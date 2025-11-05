Return-Path: <linux-kernel+bounces-886440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD3BC359F5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8BD1B34D793
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB6314A74;
	Wed,  5 Nov 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdOdN2N7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20536298CC7;
	Wed,  5 Nov 2025 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762345430; cv=none; b=kMtzFuiNduP7cwklnfLRWzkGOpBepA2tdcdnWki39s6ssmfisgbWnL8sciWFof/7xVxJGgFPkj150BbziDfq7s6jRR4gjbw+lKWexhJktfXi/Bev3qmlaamqkKWRL8i9o5coManret6LYBeIdrXVGXy1t4w98WNWK2ge16OdcXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762345430; c=relaxed/simple;
	bh=5yetftzuDJzcSZ8yMglkCk474RStpiW7y+BOBVaYRpg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PWxFbWP2h8i+8KgEQiWx0WSkEi2+hxGT6kx+/BVISIIsUyoMDEWxKWo5v13lxUQVtNi/7T7oEp/wsmNjxiQfu/Eeb+DSPqc78oQeX0Eim5Kjm9Ef/wNwyoq1gioaOkdsUOQ4EotNLrmtN/P8h6bMSGKP+kG29R7kiK5kl4xIMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdOdN2N7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762345429; x=1793881429;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=5yetftzuDJzcSZ8yMglkCk474RStpiW7y+BOBVaYRpg=;
  b=bdOdN2N7Q/NPP/noBWwBBSixrW9FXkxH6hdsCtnfzcx0EHIIZYaf+lBE
   MmHtZr+ylJcOdnxbaZEj2FikBk73naoBM/tHyzZ6kPENuTG0lGh3ZzWxE
   B9wlwx1TEFP9SBzxY6Kj11i5AaQ2VicT7JBTfHMJA1vqZIgaTChGboBaZ
   mjPltpgGeFVq+mLATDQ0r/9/u4HIWly3/bvhPXVUdiScTLU7RWZE9abgs
   8EcfRYsDJLuMoziZ5tT2rJh31dnAlb5Fc8f3rGgjwowJYi93JI0B9MNv0
   LiqGomSSIj0fJFE6p2Dowz+XTgfGtSxSIcqlR4pS/C9hkFdr10XAVaFrh
   A==;
X-CSE-ConnectionGUID: YxcuLJLvSX+NvZx59S7G+g==
X-CSE-MsgGUID: nYTokxZiTs6BQAqd5gtpsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75808530"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="75808530"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:23:48 -0800
X-CSE-ConnectionGUID: 8Qb3nSgJQkCsc4qIjZkb0w==
X-CSE-MsgGUID: Mkr3LIuGRr2NeviblboXRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="210924155"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 04:23:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hansg@kernel.org, kuba@kernel.org, edip@medip.dev
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251015181042.23961-3-edip@medip.dev>
References: <20251015181042.23961-3-edip@medip.dev>
Subject: Re: [PATCH] platform/x86: hp-wmi: mark Victus 16-r0 and 16-s0 for
 victus_s fan and thermal profile support
Message-Id: <176234542081.15175.5226902403695078034.b4-ty@linux.intel.com>
Date: Wed, 05 Nov 2025 14:23:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Wed, 15 Oct 2025 21:10:44 +0300, edip@medip.dev wrote:

> This patch adds Victus 16-r0 (8bbe) and Victus 16-s0(8bd4, 8bd5) laptop
> DMI board name into existing list
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: hp-wmi: mark Victus 16-r0 and 16-s0 for victus_s fan and thermal profile support
      commit: 55b6ece2213f60fcd822904162fa58c36b8307e0

--
 i.


