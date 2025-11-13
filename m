Return-Path: <linux-kernel+bounces-899197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38220C57112
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 12:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ACF54E50D7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5A233557C;
	Thu, 13 Nov 2025 10:56:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A65F2D0607;
	Thu, 13 Nov 2025 10:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031419; cv=none; b=pYzPnnR8OZus4TKciKSB8V6jufY88LvxrVczcg6qclLr5k79q59wcMWG6VGS17Gm3EUSO6C/UEiIINkFua3yE1uVKRpiEds9z29hZ1BCeYmZRpy4rACxq3F8X8BGa7kRRwI/DUnD7VuY3r/Q1TlNJ5vALRI99GF0hl2N4R3ajAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031419; c=relaxed/simple;
	bh=TN+Yss/PGQXw+pmsl/tUfZ9rVvg5CW2bGw7CVE/qd0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwOZTDerT2X2sms6gUcRw7XHxcIJ/V7oGQVONAViVcMxZQVQXYAIXp8yuwnp85geNiO2hI/eMHdhsgbODtcNuJrSAcCZT/StIEext65fgcX8GrLFccNIdGyE0m1TORKibkTi7+K/ErQV4a3wcGSujGXoJJ4FTSbJGsD49oIyS3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 259DB1477;
	Thu, 13 Nov 2025 02:56:49 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24CB3F792;
	Thu, 13 Nov 2025 02:56:55 -0800 (PST)
Date: Thu, 13 Nov 2025 10:56:53 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Ally Heev <allyheev@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] arm: fix uninitialized pointers with free attr
Message-ID: <aRW5dWxhosQzqiCF@pluto>
References: <20251105-aheev-uninitialized-free-attr-arm-v1-1-f7b6cb5d3361@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-aheev-uninitialized-free-attr-arm-v1-1-f7b6cb5d3361@gmail.com>

On Wed, Nov 05, 2025 at 07:37:52PM +0530, Ally Heev wrote:
> Uninitialized pointers with `__free` attribute can cause undefined
> behaviour as the memory assigned(randomly) to the pointer is freed
> automatically when the pointer goes out of scope

Hi,

> 
> arm doesn't have any bugs related to this as of now, but
> it is better to initialize and assign pointers with `__free` attr
> in one statement to ensure proper scope-based cleanup
>

Thanks for this, I agree that it is better to stick to the intended
usage-pattern in order to avoid future issues when the nearby code
changes; for this reason I would also NOT add a Fix tag (...like you
effectively did NOT...just to clarify why :P)

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

