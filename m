Return-Path: <linux-kernel+bounces-663282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81624AC463A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFD73B0563
	for <lists+linux-kernel@lfdr.de>; Tue, 27 May 2025 02:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698B31917F4;
	Tue, 27 May 2025 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PyxEbGlB"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476688615A
	for <linux-kernel@vger.kernel.org>; Tue, 27 May 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748313419; cv=none; b=H4vmDSqRMsUsXS53xn3igetln7iGp+F2jBm/PvSsx637mc+QO9poAXSB06GhuNAYIZb4GX7o5nbOGUt97oHxGzsuD96Xjnn/V878LcBOCCzKw/WA4nG6MyZZR5o4ZABgUkbAEXN+ccvfEzWV76gNl3Z129N1F5v1zwSNtP2OCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748313419; c=relaxed/simple;
	bh=IxFhFOfVR/d97FymSJiv4isF5ZND2eN40VFm3L41/jA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jbv6CqIV6R6x0NQogJyB/72IKljUmBrz5HSdiaIH98UqeR/j+GURBEaNXWYzpn9wIU+mLYOExf9WE4XXeXxUJn/TDhKat732CKSmFPDzZUO/j9AMKV+yOZdNqR8vlhzeq9rk8NwvWLsjN/u5LPi96uG32tN+q8MlJZCpL+P7MAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PyxEbGlB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748313415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxLDvATeq4EvUrtiMA5gJipkjRHQ2+Vkf/2GOjiK+w8=;
	b=PyxEbGlB3kc7OZx07zTZFO4EvhcxU42FDlMkAkZXfcQ5Ko0h7H2UA/S+LOq6hzckIUOVxM
	b6RIalTujB/mydflLtqs4VYcEVkxdPKmCxKZmYCWcRucN/uu2c6yyI7bTLxY41zc2TkXsZ
	QPEcaVjIM+BOiN76jVyvh2yNqczcJKE=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] mm, list_lru: refactor the locking code
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20250526180638.14609-1-ryncsn@gmail.com>
Date: Tue, 27 May 2025 10:36:02 +0800
Cc: linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 Julia Lawall <julia.lawall@inria.fr>
Content-Transfer-Encoding: 7bit
Message-Id: <13AF220A-3792-491A-B5C2-36044C450402@linux.dev>
References: <20250526180638.14609-1-ryncsn@gmail.com>
To: Kairui Song <kasong@tencent.com>
X-Migadu-Flow: FLOW_OUT



> On May 27, 2025, at 02:06, Kairui Song <ryncsn@gmail.com> wrote:
> 
> From: Kairui Song <kasong@tencent.com>
> 
> Cocci is confused by the try lock then release RCU and return logic
> here. So separate the try lock part out into a standalone helper. The
> code is easier to follow too.
> 
> No feature change, fixes:
> 
> cocci warnings: (new ones prefixed by >>)
>>> mm/list_lru.c:82:3-9: preceding lock on line 77
>>> mm/list_lru.c:82:3-9: preceding lock on line 77
>   mm/list_lru.c:82:3-9: preceding lock on line 75
>   mm/list_lru.c:82:3-9: preceding lock on line 75
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202505252043.pbT1tBHJ-lkp@intel.com/
> Signed-off-by: Kairui Song <kasong@tencent.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


