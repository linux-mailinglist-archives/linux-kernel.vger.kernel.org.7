Return-Path: <linux-kernel+bounces-810102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9928FB515DE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 596AB481A91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974432848BD;
	Wed, 10 Sep 2025 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApXjy1T5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3227FD76;
	Wed, 10 Sep 2025 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757504176; cv=none; b=uxCcoypO3VHG1HifVrt2CUXW2hPPbhl/OOdXyG5Vb+3d39MiR9fRiTl/N8rt31W9Xb93Pk8BbRuG1HZKtV6unvCBVUPJ3K2QcmFuUVcgfqiwBlUV1GaZ4hmP/doDrnqgI4ovvUldyd9+bLQ+TENTR3RmorHvftgWG+DhMvwoJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757504176; c=relaxed/simple;
	bh=6l01S/6rt47Erai4jgs1/fHMs7MWuVscpV4xRqhC7Bw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ejSYno2yyIn+8zp8CAgE0cFW3d4G7MhnvD9qXUtNKtqTPRcpAWZ3e2tvul2JOBRZsbG/NCHcyEXcTXVEOC/R1Uy+oW8I6w0aLVu+0vAJF/VgFjUwAc2/4GQUOLRWCZIt0OIFH1KJFX6uhvr9mGJu9gW4rRtIjll+hzvdOk2fKkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApXjy1T5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757504175; x=1789040175;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=6l01S/6rt47Erai4jgs1/fHMs7MWuVscpV4xRqhC7Bw=;
  b=ApXjy1T5NFgybDDKODC3wp8loy9mjbo5uBjeCi2+XV9iKiCZfdHa32Dx
   KRj4AfYP8R9DXwL1CdBQs9FtEkav4CaZlV5xQlYrse9wLTcSJffFDUeNu
   /w6vu/87JR60RaDBc/x1B72y8dsYvLhg/jdllmcQiowCQyN/K0yOEnHIL
   NajDWKcVRUX5HJbp64vOk6WttIvPUALfm+Ohcbj8Zok1wptam/p5+wCnm
   Kl8sLT24aMMqbQJOiemYKGKbyFtCV7kyNYQl6/QekiT3VdJGOhwjZIVm+
   3rGO9LKZZKxwj4PrBrqxAWrXEvRrax6j0Kh65fGBbSoOCSRbIoQj1vKb0
   A==;
X-CSE-ConnectionGUID: UEudGTgATv2TXbkZ8eAbjQ==
X-CSE-MsgGUID: Dn/ZlPX0S3it0xMtwKfwOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="85254248"
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="85254248"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 04:36:14 -0700
X-CSE-ConnectionGUID: GgsNQTLSRAChkvxJTM6ILw==
X-CSE-MsgGUID: iK3CtWNvQyacEx2hxp+Fxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,254,1751266800"; 
   d="scan'208";a="172535363"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 04:36:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: platform-driver-x86@vger.kernel.org, 
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: linux-kernel@vger.kernel.org, 
 Derek John Clark <derekjohn.clark@gmail.com>, 
 =?utf-8?q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>, 
 Eileen <eileen@one-netbook.com>, Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250904132252.3041613-1-lkml@antheas.dev>
References: <20250904132252.3041613-1-lkml@antheas.dev>
Subject: Re: [PATCH v1 1/2] platform/x86: oxpec: Add support for OneXPlayer
 X1Pro EVA-02
Message-Id: <175750416456.15501.9029760807017226588.b4-ty@linux.intel.com>
Date: Wed, 10 Sep 2025 14:36:04 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 04 Sep 2025 15:22:51 +0200, Antheas Kapenekakis wrote:

> It is a special edition of X1Pro with Intel and a different color.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/2] platform/x86: oxpec: Add support for OneXPlayer X1Pro EVA-02
      commit: fba9d5448bd45b0ff7199c47023e9308ea4f1730
[2/2] platform/x86: oxpec: Add support for AOKZOE A1X
      commit: d857d09fb653f081f5730e5549fce397513b0ef9

--
 i.


