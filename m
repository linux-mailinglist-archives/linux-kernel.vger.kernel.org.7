Return-Path: <linux-kernel+bounces-790369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B9AB3A619
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257E97B70F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90645322759;
	Thu, 28 Aug 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gSRaYvJ1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9132254D;
	Thu, 28 Aug 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398088; cv=none; b=K4grfYvUxqdJEX4szf5/HmRuLRN4wI/3KmPzeR+1alCYrt7Z5/QEZHdFVCUnGrxEdBlgFxM1qCIrpNWu8DDLXvfjapwjGiFXyOlThr54J2h2fEgIIzY8BkxdeJvmaBScOjtutk04Oo2jOEGfGURODxN7J5CQ3apbl++PDiCsGoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398088; c=relaxed/simple;
	bh=ishMDqViDkzusKDi0w+PPkmIF5OaPRUPWiAMoKXHJjQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W/7s2pBOIfYamMsi1TLqgZWJAgTMICCNWbWS1WbFp2znC7aBwOm1wEoC3PMpfcnq3ymfXpqkoE272jwYVASBdrX4xOTotGg0+E6BZlOcET8Pv3jqSN4FOr364R5x/+aMebiujAwa73ic+AXCgrzjz1Rs+nC0CbwQ80HnOlYfm1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gSRaYvJ1; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756398086; x=1787934086;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=ishMDqViDkzusKDi0w+PPkmIF5OaPRUPWiAMoKXHJjQ=;
  b=gSRaYvJ1eq1cBemGxiNtG68TohDeo0Y0zMjji1NzerOC6BxLPhmd0VBV
   iDN57gBHhqxuaPU5n1GINYQ+gF20MG1SydiMMxpxIWekfRj0NcTQhvpE3
   93nrE6Cip3F5/kJUAjqUuzsWRJZT+e4gs3n+w8Y20iwWVwzTJrny9/HBe
   hj+jtdFffcS/t7jl3udty93tjevNgiq4tgjspkIsgYPR05lAyZLNpi8pO
   Klwi1Vwu6dMtcHkicjavSNbbREPfiQAo3kW50NQzvsvyRJA4iXrySfsrY
   svRlogVzQFfKAuMkWsDS9H3joOSjmaMY1EFvRPxz3K951b68/pKZBhuSl
   g==;
X-CSE-ConnectionGUID: tM2WWWtYRZ+OCxfhL5OwnA==
X-CSE-MsgGUID: pZdZvnfoTRCeebvA+epFkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70114278"
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="70114278"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:21:26 -0700
X-CSE-ConnectionGUID: 2S7918mLRBqNEZgCSaqOgA==
X-CSE-MsgGUID: gRUV7T4wTM2gigEnnclDkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="170066186"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 09:21:22 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: jlee@suse.com, Armin Wolf <W_Armin@gmx.de>
Cc: hansg@kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lynne@bune.city
In-Reply-To: <20250826204007.5088-1-W_Armin@gmx.de>
References: <20250826204007.5088-1-W_Armin@gmx.de>
Subject: Re: [PATCH] platform/x86: acer-wmi: Stop using ACPI bitmap for
 platform profile choices
Message-Id: <175639807798.20700.11953577105955162977.b4-ty@linux.intel.com>
Date: Thu, 28 Aug 2025 19:21:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 26 Aug 2025 22:40:07 +0200, Armin Wolf wrote:

> It turns out that the platform firmware on some models does not return
> valid data when reading the bitmap of supported platform profiles.
> This prevents the driver from loading on said models, even when the
> platform profile interface itself works.
> 
> Fix this by stop using said bitmap until we have figured out how
> the OEM software itself detects available platform profiles.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: acer-wmi: Stop using ACPI bitmap for platform profile choices
      commit: b0908e03fdd488a5ffd5b80d86dcfc77207464e7

--
 i.


