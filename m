Return-Path: <linux-kernel+bounces-795438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2097B3F20D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F69204153
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 01:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE3E2DECD3;
	Tue,  2 Sep 2025 01:58:13 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BE27FD56;
	Tue,  2 Sep 2025 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756778293; cv=none; b=ZEd9SQOYEr+8HP2Kx3DUEo/rO9hkWjIpGKESQ7ciMZH267wynEPa8YQXTZ/fBgNuD4S2pP6Z0aPWNF8X2iyRr/3z3Bb+IYfYC9UzNNjCS/HPblFIwqsTWmMkiOB7qcUm9/TexuhWEsMsEccRFrYdfndKsC5BtJiDw/h2tiZ6XsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756778293; c=relaxed/simple;
	bh=N/VCLgeEzxl6yIVTPQlWV5+dpMkgTqaXpWk5kqEijTM=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=mO8E74WeHQHgi8lUNSXQxH2d/DWDiX/PzNG+hqxn7SuW8UdWxnc6P/H41xWc3MuuJEyZX7k0fGMwAqgDUWHu9/6A2FLZeJwgPgojSbqMmELb4dxsG22sYgHZ9snnkJ7ziHVF/zeMLV1wjeNgP+akhRG3v9+uhfbuMtCb6du0mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4cG85g5Bzxz8Xs7B;
	Tue, 02 Sep 2025 09:57:59 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 5821vivR041930;
	Tue, 2 Sep 2025 09:57:44 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 2 Sep 2025 09:57:45 +0800 (CST)
Date: Tue, 2 Sep 2025 09:57:45 +0800 (CST)
X-Zmail-TransId: 2afc68b64f19396-60f66
X-Mailer: Zmail v1.0
Message-ID: <202509020957458514CMgUiaqPjTURNET_d-w0@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <akpm@linux-foundation.org>, <wang.yaxin@zte.com.cn>, <corbet@lwn.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <fan.yu9@zte.com.cn>, <wang.yaxin@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMC8zXSB0b29scy9kZWxheXRvcDogaW1wbGVtZW50IHJlYWwtdGltZSBrZXlib2FyZCBpbnRlcmFjdGlvbiBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5821vivR041930
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Tue, 02 Sep 2025 09:57:59 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68B64F27.002/4cG85g5Bzxz8Xs7B

From: Fan Yu <fan.yu9@zte.com.cn>

Current Limitations
===================
The current delaytop implementation has two main limitations:
1) Static sorting only by CPU delay
Forcing users to restart with different parameters to analyze
other resource bottlenecks.
2) Memory delay information is always expanded
Causing information overload when only high-level memory pressure
monitoring is needed.

Improvements
============
1) Implemented dynamic sorting capability
- Interactive key 'o' triggers sort mode.
- Supports sorting by CPU/IO/Memory/IRQ delays.
- Memory subcategories available in verbose mode.
 * c - CPU delay (default)
 * i - IO delay
 * m - Total memory delay
 * q - IRQ delay
 * s/r/t/p/w - Memory subcategories (in verbose mode)
2) Added memory display modes
- Compact view (default): shows aggregated memory delays.
- Verbose view ('M' key): breaks down into memory sub-delays.
 * SWAP - swapin delays
 * RCL - freepages reclaim delays
 * THR - thrashing delays
 * CMP - compaction delays
 * WP - write-protect copy delays

Practical benefits
==================
1) Dynamic Sorting for Real-Time Bottleneck Detection
System administrators can now dynamically change sorting to identify
different types of resource bottlenecks without restarting.

2) Enhanced Usability with On-Screen Keybindings
More intuitive interactive usage with on-screen keybindings help.
Reduced screen clutter when only memory overview is needed.

Fan Yu (3):
  tools/delaytop: add memory verbose mode support
  tools/delaytop: add flexible sorting by delay field
  tools/delaytop: add interactive mode with keyboard controls

 tools/accounting/delaytop.c | 347 +++++++++++++++++++++++++++++-------
 1 file changed, 287 insertions(+), 60 deletions(-)

-- 
2.25.1

