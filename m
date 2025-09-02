Return-Path: <linux-kernel+bounces-795499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9CDB3F2FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8920D481162
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798512E0939;
	Tue,  2 Sep 2025 03:52:37 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2437284B4F;
	Tue,  2 Sep 2025 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785157; cv=none; b=jFE52ePXIIab2xOF9yabS312JXPyJ6hpkeFMLqj+dngczTzw2X8r0goDPszlPia8ux/BOVshp+xM+n9Md9/5yE5IL47nQC2zqDOZzQmb78SWe28SgRaqVu/5U8uoBw5CEOIzvLDrjjJ+1m4IeNAyiGVIGKu3pPDyDiQXlEfl5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785157; c=relaxed/simple;
	bh=RR6lgRRa3i2uUdHDLHNUheU3K109kH6cVsDf12acl6U=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=qiA4O4mp8PRaJgzsXCwwq36bPkLQDeVTzMZ+RpL7ovkaxmO617dx9t5Z2Ukm10I+rdS5YqVAbwGtPaUo9GqIEmMCE4yOjSTz3U3y4p7JO327XjGRc1lGTrhsEEAsBvKapkwwZTGkvw1B+iMUQP+EwatMo8kIJVUVqMx1qbOGl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4cGBdp3VwXz4xNtH;
	Tue, 02 Sep 2025 11:52:30 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 5823qMtB002677;
	Tue, 2 Sep 2025 11:52:22 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 2 Sep 2025 11:52:23 +0800 (CST)
Date: Tue, 2 Sep 2025 11:52:23 +0800 (CST)
X-Zmail-TransId: 2afb68b669f75b8-210c9
X-Mailer: Zmail v1.0
Message-ID: <20250902115223765heW78u3qH__SmNLo1RlVM@zte.com.cn>
In-Reply-To: <202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn>
References: 202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <fan.yu9@zte.com.cn>, <akpm@linux-foundation.org>
Cc: <wang.yaxin@zte.com.cn>, <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <fan.yu9@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IDAvM10gdG9vbHMvZGVsYXl0b3A6IGltcGxlbWVudCByZWFsLXRpbWUga2V5Ym9hcmQgaW50ZXJhY3Rpb24gc3VwcG9ydA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 5823qMtB002677
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: xu.xin16@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 02 Sep 2025 11:52:30 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B669FE.000/4cGBdp3VwXz4xNtH

From: Fan Yu <fan.yu9@zte.com.cn>
> Current Limitations
> ===================
> The current delaytop implementation has two main limitations:
> 1) Static sorting only by CPU delay
> Forcing users to restart with different parameters to analyze
> other resource bottlenecks.
> 2) Memory delay information is always expanded
> Causing information overload when only high-level memory pressure
> monitoring is needed.
> 
> Improvements
> ============
> 1) Implemented dynamic sorting capability
> - Interactive key 'o' triggers sort mode.
> - Supports sorting by CPU/IO/Memory/IRQ delays.
> - Memory subcategories available in verbose mode.
>  * c - CPU delay (default)
>  * i - IO delay
>  * m - Total memory delay
>  * q - IRQ delay
>  * s/r/t/p/w - Memory subcategories (in verbose mode)
> 2) Added memory display modes
> - Compact view (default): shows aggregated memory delays.
> - Verbose view ('M' key): breaks down into memory sub-delays.
>  * SWAP - swapin delays
>  * RCL - freepages reclaim delays
>  * THR - thrashing delays
>  * CMP - compaction delays
>  * WP - write-protect copy delays
>

What about updating usages into Documentation/accounting/delay-accounting.rst ?

> 
> 
> Fan Yu (3):
>   tools/delaytop: add memory verbose mode support
>   tools/delaytop: add flexible sorting by delay field
>   tools/delaytop: add interactive mode with keyboard controls
> 
>  tools/accounting/delaytop.c | 347 +++++++++++++++++++++++++++++-------
>  1 file changed, 287 insertions(+), 60 deletions(-)

Other parts are ok except [PATCH 1/3]

