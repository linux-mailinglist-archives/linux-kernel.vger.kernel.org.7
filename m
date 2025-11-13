Return-Path: <linux-kernel+bounces-899184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DB511C5705D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 53A3D34437F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75F332EDE;
	Thu, 13 Nov 2025 10:51:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A25D3321D0;
	Thu, 13 Nov 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031119; cv=none; b=fG/vLeA9+9URf6pECHj6gOmyacbm+ylz/rwotiyIRG621CTJ0rg0MqS4YZpL3jI6P3nO8Y+UXBMT+s5UWtx6sxzYdKD9wQGS0tjkvFUl70RqafrFsRSR9GFDHpwN47qjOF8yhDfbEnWXlMNU1xOBHnhtgBQptLFeI55gz+rIt6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031119; c=relaxed/simple;
	bh=TMalLOBJ2Ps+T1mVeULqAsJxSVmOVKoC84RboHyKnMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwWqAIzstP2gHfMNeQqT7rKmriXohezOKbBqlluQ1EqmyrvtTGyNnsbNyHtenLmf3TXAZsMRYcS1bPUs2w96SN8Y/e9lIF6jwcNqZmEUIiv1ofYsf7leRmAEDRIxLe43mjHyxwuy9Ppk6WD5shr7x7BGt0y9DIz1qbgNal0YlS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4F7412FC;
	Thu, 13 Nov 2025 02:51:48 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49EE73F66E;
	Thu, 13 Nov 2025 02:51:55 -0800 (PST)
Date: Thu, 13 Nov 2025 10:51:42 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Artem Shimko <a.shimko.dev@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scmi: reset: validate number of reset domains
Message-ID: <aRW4PpPjVw1-melm@pluto>
References: <20251103161044.2269377-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103161044.2269377-1-a.shimko.dev@gmail.com>

On Mon, Nov 03, 2025 at 07:10:43PM +0300, Artem Shimko wrote:
> Add validation to reject zero reset domains during protocol initialization.
> 

Hi Artem,

> The fix adds an explicit check for zero domains in
> scmi_reset_protocol_init(), returning -EINVAL early during protocol
> initialization. This prevents the driver from proceeding with a
> non-functional state and avoids potential kernel panics in functions
> like scmi_reset_domain_reset() and scmi_reset_notify_supported() that
> assume dom_info is always valid.

Indeed, this was alreay spotted/reported/fixed in other protocols, but
the preferred solution is NOT to bail-out when there are ZERO domains,
but to carry-on WITHOUT crashing of course: the reason for this is
testing scenarios in which you can have a platform/FW reply with ZERO
domains.

> 
> The change is minimal and safe, affecting only the error case while
> preserving all existing functionality for valid configurations.
> The existing -ENOMEM handling for memory allocation remains unchanged
> and sufficient.
>

In fact if you look at the code there are already a lot of places in
reset.c where the code path is anyway guarded by num_domains so it is
NOT problematic.

There are, though, other places where the dom-> dereference is NOT
protected and those could be probelematic.

Have you seen any crash related to this for real when zero num_domains
are reported ?

Anyway, it would be good to harden the protocol code as already done
a bit in other protocols in the past, but I advise you to lookup in
perf.c the scmi_perf_domain_lookup() helper as an example and see
how it used across perf to address a similar scenario and adopt the
same solution for reset in order to harden the code while preserving
the possibility to initialize the protocol even with ZERO domains for
testing purposes.

Thanks,
Cristian

