Return-Path: <linux-kernel+bounces-819043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5EBB59A88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34961188D0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBAF334386;
	Tue, 16 Sep 2025 14:38:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF05313E39
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033517; cv=none; b=YOGY+8Ju0Y/c4VsLXgaZmuuzDI7Eq7r2s41yJZpNKZdu+XKKjCA2Q7kB2YFGnZ2cUrr09gWnBP1NaqZQyKIR7OUJQLP+ZGWFN86pFlzZxOfpKY0p+LlBVXlOxf5NurhS0WFYKvVSWzPcV8YiCRN23NPm4CpJ/mPY1u9cP5Vg2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033517; c=relaxed/simple;
	bh=MMiBakgTXgsppLhre/lgCobdOkw5V7t+nmyIjY9of18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxPuNMrn3jMcZxtCWrIGKseaUOmWQIEsmsYHF1IsDA7inq4b6Gw//VG0zy3qmEccyTd8PnPqUapwwAaq6yFpFoukQSlnxhXHr030rm0X4rDDTyM/f001nVyD4QgtB4/Q49hI7x6UJREIgiVGkxfFCHMJSCFubgAZVMrVyoWju1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D046FEC;
	Tue, 16 Sep 2025 07:38:27 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22BEE3F673;
	Tue, 16 Sep 2025 07:38:33 -0700 (PDT)
Date: Tue, 16 Sep 2025 15:38:31 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	Chao Gao <chao.gao@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Salman Nabi <salman.nabi@arm.com>
Subject: Re: [RFC PATCH 0/1] Arm Live Firmware activation support
Message-ID: <20250916-energetic-debonair-mongrel-dfcafb@sudeepholla>
References: <20250625142722.1911172-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625142722.1911172-1-andre.przywara@arm.com>

On Wed, Jun 25, 2025 at 03:27:21PM +0100, Andre Przywara wrote:
> Hi,
> 
> (please feel free to add people interested on this from the x86 side
> as you see fit)
> 
> this is a proposal for a driver for the Arm Live Firmware Activation (LFA)
> specification[1]. LFA provides an interface to allow "activating" firmware
> updates without a reboot.
> In contrast to Intel's TDX [2] approach (which seems only concerned about
> some confidential computing related firmware blob), and even OCP's
> "impactless" updates[3], the Arm approach just lists a number of
> "activatable" firmware images, and does not limit their scope. In
> particular those updates can (and will) be for firmware bits used by the
> application processors (which OCP seems to rule out), including runtime
> secure firmware (TF-A/BL31), confidential compute firmware, and
> potentially even UEFI runtime firmware.
> Initially we have the whole chain demoing the Arm Confidential Computing
> firmware (RMM) update, which is conceptually the same as Intel's TDX
> proposal.
> 
> So our design approach is to create a directory under /sys/firmware, and
> just list all images there, as directories named by their GUID.
> Then the properties of each image can be queried and the activation
> triggered by the sysfs files inside each directory. For details see the
> commit message of the patch.
> This is admittedly a somewhat raw interface, though even in that form
> it's good enough for testing. Eventually I would expect some fwupd
> plugin to wrap this nicely for any admins or end users.
> 
> The purpose of this RFC is to get some feedback on the feasibility of
> this interface, and to understand how this would relate to the other two
> approaches (TDX + OCP "impactless" updates).
> 

Thanks for the details and I agree we need opinions from x86 community
if possible but definitely from cloud/hyperscale community using these
user interfaces ? While x86 and Arm may provide its own user interface,
are hyperscale community happy with that ? I briefly read the unified
(arch agnostic) requirements specification [3] but will there be a
requirement to have a unified user interface from the OS ?

We don't want to define something Arm specific to just abandon it quickly
if and when hyperscale community comes back with such a request for unified
user interface.

I am not against having Arm specific interface, just getting clarification
in terms of requirements even before diving into technical review of the
patch here.

Anyone from hyperscale community ? Please provide directions here.

-- 
Regards,
Sudeep

