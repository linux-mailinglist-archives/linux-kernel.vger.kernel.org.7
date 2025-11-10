Return-Path: <linux-kernel+bounces-893757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56386C4844A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C183A259C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C728B7DB;
	Mon, 10 Nov 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R6pNpKWP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7C28136F;
	Mon, 10 Nov 2025 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762794887; cv=none; b=Gezxif1vcwnlbwaL69vEC/EnNAsuQvHN0C4xu/vUyp/EwIf4dM1pSXcy+Ojzg0dBSRhr4YQTNz1kpAFCHMV+MxEv7kv+3TG0xEgKUBdGvwK0kEZweoiosAryA367NTcn8++fxld6nbG/fKE/PEekByTN0C88o7L9bnv6qX0w088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762794887; c=relaxed/simple;
	bh=LsAqwy8VilxFBWtyVTGtXTxw+/2lTVweVv/9CMYeftQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A/B0Kl0UP7En2wueQIHz9F3fWbKZaRB7cTFQRH4sHo5g92b5zfmg/AUJZKfyUxv0Hq9MpGr4ZJxEZK+OydwhqtGs7X/phXfY5cKjCvv9tRRTuclTF2WiNSTQA6/e3xPieDuvyQLJ9wj+TKdN6btzFXbqyjkgNGkWIBepgF91T4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R6pNpKWP; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762794885; x=1794330885;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LsAqwy8VilxFBWtyVTGtXTxw+/2lTVweVv/9CMYeftQ=;
  b=R6pNpKWPz8e1vXq4yUk1X8h+/SsQgyqKiKT6qsScS4KSSfu8FnwXml+/
   Yo5g8t0oX1mvjyX7Uh0oZSi3K9CIXYPqTGVGUtl05Lrj0Ycw/3ccbGmEQ
   nChMJ7jt1VnbwsOZyEO4zq4xUvfd8tHSeAQ29lMzI1ZaRT72SAbTmJIZY
   SZa5eR/+HfZvFM5PDwUzXKVbiIu7iY8Qnhux7oBmDddSaOWWOjg1jlLYd
   cluJPOxIawDa17Z25MaQYEtofUDaydLdwEkFFnKV8CdAWTPmJ1S82uVBT
   Q6b78r8Ze28aX2FzbXunDUEZJk4xvKPyesMJk+zWYdCa5zTgl39QYCKk0
   A==;
X-CSE-ConnectionGUID: 8m1zS5x7TAmlvOn+voZC8Q==
X-CSE-MsgGUID: i9zqm4y/QNGZBIv1I2WgIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64550449"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="64550449"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:14:44 -0800
X-CSE-ConnectionGUID: TgHTws8aSSWa/Pay7Q/UJg==
X-CSE-MsgGUID: Rp/YvaGCR+WLWnzTQWC8fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="188032434"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.13])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 09:14:41 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 10 Nov 2025 19:14:38 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] platform/x86: msi-wmi-platform: Fix autoloading
In-Reply-To: <CAGwozwHq45Bj4FgRyrmd4dvLkR_hUGB7wVDUdtttR13sJGHHyw@mail.gmail.com>
Message-ID: <68328879-4052-2b0f-4cef-fe3fccd2c1c8@linux.intel.com>
References: <20251110111253.16204-1-W_Armin@gmx.de> <CAGwozwHq45Bj4FgRyrmd4dvLkR_hUGB7wVDUdtttR13sJGHHyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Antheas Kapenekakis wrote:
> On Mon, 10 Nov 2025 at 12:13, Armin Wolf <W_Armin@gmx.de> wrote:
> >
> > As already noted by Antheas Kapenekakis back in May, the
> > msi-wmi-platform driver fails to automatically load on MSI Claw
> > devices. Back then i suspected an issue with the device firmware,
> > however i just found out that i made a silly mistake when specifying
> > the GUID string of the driver, preventing the WMI driver core from
> > matching it to its WMI device.
> > Additionally i noticed that said GUID was copied from the Windows
> > driver samples, meaning that it might be shared across different
> > vendors. Because of this we have to prevent this driver from loading
> > on non-MSI devices.
> >
> > Compile-tested only.
> 
> Works great. Module loads normally without intervention from userspace.
> 
> I could not find an online reference for our discussion so I omit the close tag.
> 
> Replying to the cover applies to all patches if my understanding is correct.
> 
> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> Tested-by: Antheas Kapenekakis <lkml@antheas.dev>

Thanks, I've added these tags to the commits.

-- 
 i.


