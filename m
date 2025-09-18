Return-Path: <linux-kernel+bounces-822347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E086B83983
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608EF1C03B80
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDF2FE598;
	Thu, 18 Sep 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vGBuD8Fl"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85892F9DAF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185490; cv=none; b=CTDmrIUcM3xbhvKi9EBVFt/oLKWdJjxLsPJ609esjMRV095G7Xwviowofp8M2b5AMUd0FH2tJYd5Hsu2FbwK+eZTSwygQHhp0lfYDG96IUj/BpEP6Hb11RfmlLmShsRzqtPRoW9RxQ3VXJyvlmgTdO2SyMuRt74V6hxMZhmfu/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185490; c=relaxed/simple;
	bh=HkqrJdNGa2duMrYZbpbFvG8nRI6z4Ws788qlrVk+/To=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=FQJkWTCohORETUdopxW6s6LK9zq773fD3j0ZlaObEUprvvMosWvBatRwMlUWSvDKioxRbk3MwIjhDr/4LYcwCZJasO0odaPBR8g+2VX4InBcpsOyand1F9wNT2QCr86i0fx/mU+9rm47LRxA3yhGe1MkvROUwvdLN68KujItAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vGBuD8Fl; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250918085119epoutp01422c8d3c1fe95a54440e99a08fb4770f~mVGDdZXQQ2801528015epoutp01k
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:51:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250918085119epoutp01422c8d3c1fe95a54440e99a08fb4770f~mVGDdZXQQ2801528015epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758185479;
	bh=/n8aZaGi5wsZR3M7fxB/xKjxSKJA7+RjEz4hMqj7gvI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=vGBuD8FlsHxFXCb9z9eD9mefUm8gQo7rGZoTtcwWnHvgsabfziku8iXwfYIBvjchm
	 udzMo7gt//eam8GnJ0Lbbd8BEwWhVWpGgF9Oz0s8gf6/8W2sa4FvOGggk6Y/dycuol
	 WbUuK+h6sZGuR0qJtw1wsFxaTbPP99YS0vK/IyTY=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250918085118epcas5p49ea042cd797817fabbe3e9cd04938c10~mVGC7mMTj0181101811epcas5p4a;
	Thu, 18 Sep 2025 08:51:18 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.95]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cS8W96djpz2SSKY; Thu, 18 Sep
	2025 08:51:17 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250918085116epcas5p1b8d60fcb677cbed348996b4c11761d92~mVGAOVtcj1744917449epcas5p1S;
	Thu, 18 Sep 2025 08:51:16 +0000 (GMT)
Received: from INBRO002756 (unknown [107.122.3.168]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250918085112epsmtip2c228739b2db7b0773d4c34c7df918b7f~mVF9VBzE82068720687epsmtip2X;
	Thu, 18 Sep 2025 08:51:12 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Raghav Sharma'" <raghav.s@samsung.com>, <krzk@kernel.org>,
	<s.nawrocki@samsung.com>, <cw00.choi@samsung.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <sunyeal.hong@samsung.com>, <shin.son@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <chandan.vn@samsung.com>,
	<dev.tailor@samsung.com>, <karthik.sun@samsung.com>
In-Reply-To: <20250915095401.3699849-2-raghav.s@samsung.com>
Subject: RE: [PATCH v2 1/3] dt-bindings: clock: exynosautov920: add m2m
 clock definitions
Date: Thu, 18 Sep 2025 14:21:11 +0530
Message-ID: <087a01dc2879$64a6f750$2df4e5f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIDMWX7dzjI2+lsAsCe3lTeFtXiqgHaCRjjAd0WrFy0LNbBwA==
Content-Language: en-us
X-CMS-MailID: 20250918085116epcas5p1b8d60fcb677cbed348996b4c11761d92
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250915094512epcas5p223e2eb264967508527f478eb2200be83
References: <20250915095401.3699849-1-raghav.s@samsung.com>
	<CGME20250915094512epcas5p223e2eb264967508527f478eb2200be83@epcas5p2.samsung.com>
	<20250915095401.3699849-2-raghav.s@samsung.com>

Hi Raghav,

> -----Original Message-----
> From: Raghav Sharma <raghav.s@samsung.com>
> Sent: Monday, September 15, 2025 3:24 PM
> To: krzk@kernel.org; s.nawrocki@samsung.com; cw00.choi@samsung.com;
> alim.akhtar@samsung.com; mturquette@baylibre.com; sboyd@kernel.org;
> robh@kernel.org; conor+dt@kernel.org; sunyeal.hong@samsung.com;
> shin.son@samsung.com
> Cc: linux-samsung-soc@vger.kernel.org; linux-clk@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; chandan.vn@samsung.com; dev.tailor@samsung.com;
> karthik.sun@samsung.com; Raghav Sharma <raghav.s@samsung.com>
> Subject: [PATCH v2 1/3] dt-bindings: clock: exynosautov920: add m2m clock
> definitions
> 
> Add device tree clock binding definitions for CMU_M2M
> 
> Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>


