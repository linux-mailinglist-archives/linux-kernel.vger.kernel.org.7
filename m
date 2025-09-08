Return-Path: <linux-kernel+bounces-804922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7EB481F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CBF189BFAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E781D618C;
	Mon,  8 Sep 2025 01:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ID95PfqI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WYbXacV9"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EFC15E97
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 01:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294479; cv=none; b=lTVT/04snMtz/gAiD4Jg6WLJXsY5B60RaYwbiTIi/wlb0ygj83MIl/0nfRUasH9kuvIKH9TcVlZYjsAOfhbnzYOomDdTviR2XR+fGzPtTn0XXnM3uqH+eo3grvVDewfLdEPobmEY/BFCBdTttesDTD+kcfhqTS710KA8QNMeqzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294479; c=relaxed/simple;
	bh=BwIw5chTj+JYj7x6Gcc0ICDdS/qolqQ0C2AKuuTEPAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YF3bnj9Ee438A48aqknDHktx+ApTDENH5oRk1QanQiMA8Qs3zzjvzOKUBPU9mhMogN6vQ/pYz9B3pzFkHuYMy3vw/RWLiKhJkflR4BajV/HTWGddJpkSpaclz8joPCBznfwUNd7sa3h6yLeEDoCSVn14InqhVonRFGNjHu53g0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ID95PfqI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WYbXacV9; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32A3C140002E;
	Sun,  7 Sep 2025 21:21:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 07 Sep 2025 21:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1757294475; x=
	1757380875; bh=IU8eRzIzzoCn+klvIX+UYvGJSjMoL3fwFs3HuV6Tx0Y=; b=I
	D95PfqI9f2K5md/n+nf0Mak+y3mA5wjL2mTxlRKuE1Jzgqj9KvdaY0lA5VM6Btg7
	nq0fWJFI+gHm0OZEKO9cstNkPa2k0STVRnaxKCVifdNVboGZpeJlnr5oyW6FUIvA
	b+fuQFSRIUJSzNahIBREogdAMGaQ22YbtqqstwPT66ce3RKDKCoueKKkgiqquLGA
	Rt5iFrSuZGZwoOhpj7LmaoThzmmF8FNc8zsVKN2H2WQ36bStaCxr7P+XXVOGDn8G
	9jVgQMUBcT6Xje10t87jG08AJZfxHzZ2bXiNbXL5f2c9sfvcLO+kyx1kmsmhznuR
	xwfk6RFqBveVZK5Vgg5mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757294475; x=1757380875; bh=I
	U8eRzIzzoCn+klvIX+UYvGJSjMoL3fwFs3HuV6Tx0Y=; b=WYbXacV9FMlwlTKdy
	DXue8RWTHoZJgFPnr8/Pe65z2OvtYNMNd1RbsPGatA1KxJsEvV32ElYfMIt8166U
	jmmf22d4jMlEa836CJfjomrSun24lbQT//iF2uYqZSMDP3EQUaFRyBuOEl5R+W40
	22wszK+ZuEJPlkk8lGFUf0hQnThgJVoh9IwC02UCqJQmk6yKdBvSoccI4qWnhVep
	Np4XbZU3t0EFtx4wdPqmPDnrDHWgkrM9RBMF7DlisVm5OfsfHYEZ+xrVokQ7W1ia
	sjuAQwttaYrqUNEzXD19OQIBft18otPntG2SgXnR84rG1Lqfg+MnsYfi8ozMeoHk
	HlGgA==
X-ME-Sender: <xms:iy--aH3t7aQd6i7WQU4OLJLU3p_eSeGFZTj5x2gM4KYHwAHb98H1YA>
    <xme:iy--aPDprjvPv2R2Hiy-Y2YeyjqnbSjpILggTu5cbKbG6iEFs1v-QNA10P1aldecI
    uBf8pAA5A5k9uug024>
X-ME-Received: <xmr:iy--aJ0mf_btZ1bCAIMVZxls2UnIXb3NY6sXwQ3VHdCMUsmt6kjM7CWzUyCA4yvp13OrZ3FnfFlw891Tnd8FesHquc7_K6lSW4yYUYJWKFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepvdejgfejuedvgf
    duudekleevtefgtdevhfdtffefiefgveeuteffiedvffekvddtnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkh
    grmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlheslhhishhtshdrshhouhhrtg
    gvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:iy--aJsxJcuxiYVDMM8D_SCAXiKwTu0IMCEikY7cKolR8ZZ2QA7SqA>
    <xmx:iy--aJ5YHcBkRw64jjJB_jWBiKQqJzhXp83FlXYxIFhmTTFgOFvlUA>
    <xmx:iy--aKK3QhRwt3wx5NX2U2qhyxrO7Qelui2Y3_FkiAJnzJUDIFMtGg>
    <xmx:iy--aJ4_hj9CeIfBeRqcB6QIFOexU74eLvQGChg9oEzLeCC_CsK2cA>
    <xmx:iy--aFaUXpKaUe4C1bgp3ITcrv_YaZHL22h6ZN1clLpO9w5JnUJbSkxJ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Sep 2025 21:21:14 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] firewire: ohci: use kcalloc() variant for array allocation
Date: Mon,  8 Sep 2025 10:20:58 +0900
Message-ID: <20250908012108.514698-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
References: <20250908012108.514698-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When allocating the list of isochronous context structure, a kzalloc()
variant of managed device API is used. In this case, a kcalloc() variant
is available.

This commit replaces these lines with devm_kcalloc().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 40851b120615..030aed5453a1 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3482,7 +3482,6 @@ static int pci_probe(struct pci_dev *dev,
 	u32 bus_options, max_receive, link_speed, version;
 	u64 guid;
 	int i, flags, irq, err;
-	size_t size;
 
 	if (dev->vendor == PCI_VENDOR_ID_PINNACLE_SYSTEMS) {
 		dev_err(&dev->dev, "Pinnacle MovieBoard is not yet supported\n");
@@ -3576,8 +3575,7 @@ static int pci_probe(struct pci_dev *dev,
 	reg_write(ohci, OHCI1394_IsoRecvIntMaskClear, ~0);
 	ohci->ir_context_mask = ohci->ir_context_support;
 	ohci->n_ir = hweight32(ohci->ir_context_mask);
-	size = sizeof(struct iso_context) * ohci->n_ir;
-	ohci->ir_context_list = devm_kzalloc(&dev->dev, size, GFP_KERNEL);
+	ohci->ir_context_list = devm_kcalloc(&dev->dev, ohci->n_ir, sizeof(struct iso_context), GFP_KERNEL);
 	if (!ohci->ir_context_list)
 		return -ENOMEM;
 
@@ -3591,8 +3589,7 @@ static int pci_probe(struct pci_dev *dev,
 	reg_write(ohci, OHCI1394_IsoXmitIntMaskClear, ~0);
 	ohci->it_context_mask = ohci->it_context_support;
 	ohci->n_it = hweight32(ohci->it_context_mask);
-	size = sizeof(struct iso_context) * ohci->n_it;
-	ohci->it_context_list = devm_kzalloc(&dev->dev, size, GFP_KERNEL);
+	ohci->it_context_list = devm_kcalloc(&dev->dev, ohci->n_it, sizeof(struct iso_context), GFP_KERNEL);
 	if (!ohci->it_context_list)
 		return -ENOMEM;
 
-- 
2.48.1


