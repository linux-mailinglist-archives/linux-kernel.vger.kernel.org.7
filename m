Return-Path: <linux-kernel+bounces-833180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFE8BA15D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628B6383E26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929231D721;
	Thu, 25 Sep 2025 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="pJf8uTAx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lw2ETftN"
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49C2750F3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758832419; cv=none; b=Ge9F2UlxiPa4zzJCyntRH9ZaDXooaHnr2mcartcPNnapduXgkihKI5xgcF2FDjxbY3nu8sQAmovHp+Qf/tUU+0ubLFswxt1iLlsCdSvxCfImkRe900R6M6KXFrKuixGUGD0HnjFCwrLGRSYacuEFReKZThBGBK/6HjKw6fBswXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758832419; c=relaxed/simple;
	bh=+Jor10eg5LvHZCSW9hUAM8+MJz6BmLXiQAQ9uw52A+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CL01vKaNTJiroQqrtt8YP58Rqya/KKoKJBNXixCahNX7UCULFIIOysJqmXySETx6KqAWW4w7fozKFKH2+g9oHFnvDsJB7ZlJFpQ2TbqRscu1fryHIiRilA6U8kgq5VAOutPzURkaUldovKhRe2YPtUjbjKIwfFwfwjNpNxB4ESg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=pJf8uTAx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lw2ETftN; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB4A37A006F;
	Thu, 25 Sep 2025 16:33:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 25 Sep 2025 16:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1758832416; x=1758918816; bh=4M
	sAfN8ggET6LQP8EBxlOi/6T17883/ulcELGobe1ps=; b=pJf8uTAxclEov111Gn
	xQ33IEzEHo7vZmyugvLylE5X3t7pkcrOh7/XCidyZiYzR0a4NyS6HyGjCY2RivHL
	kzjCsBYKPn9K1MMqnWmtZ+EUfptvUGwTXB3/GZ8RoGAFD14VLatTcN0i7x5VdcxL
	VzKzL3SI9txI5qCLxEx4yXyHlncYrz9iuU7+9OZYhj/NBtQ8b0V3YQT953Sy4yZo
	Poqajq2bZA6wWZeIzp3ZkJcmlT9Jk2ZhyUUk7CV3YRcYDk0nTHNtiocJBthAeOKb
	mdf+WJOcxLqpClG3rFnpPh/b85F1wePpSMC9tA3ZEygExgKKTzXzHmGqjOhNBwNS
	IGpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1758832416; x=1758918816; bh=4MsAfN8ggET6LQP8EBxlOi/6T178
	83/ulcELGobe1ps=; b=lw2ETftN5AzzStse6OyaSkJZuueuyPUur6H1J8UGRtAL
	tAAxWijSEKFt0+5vbGbdh3XAnZ0qgCAOIiIrfGGq/UXiozMzSnH1YKDdLcp9/6BN
	KhM3y0FEGYd2J7ZXf5fTGCZdsy68aVqpYXJHAF25iIz8+Do2qQt+Zpi19xJNXYpI
	Mh4WgO2/X6IQvjxGw6fQgxjDjmvjifcF4MeHYx9kv+zv+8/UeqFmKIOzks5BE+LL
	UE7ge7OkFFfvJm567uE/u+dwu9/8SwWCtMq+8Fol1c3T23qehOYs3iW2+4RsZsHL
	V6Zrlv+zstB5oR5MuvqEMKEV3a1pZWJpe/v1oxRW/w==
X-ME-Sender: <xms:IKfVaDcyJhuTh0EKMcbT7vfbUje0hkz8Pbd-IaixgespATpn-tBd7Q>
    <xme:IKfVaDQrYi9YSJzbAyMUw9HGudsbSIg0PzuO7Dc1C7BlHXtf450WNSz-mWmtG7Ul9
    gtJfkffpo43jiU3YeEvA-b0v6hzAcVH5dQoFvUpAgjFSqnwnPJhZA>
X-ME-Received: <xmr:IKfVaMZ4Z7_YvfZp_Dav0LunN2VmZjwuKOp6WaDEsuZj9X8eArDK1OprQmGG3gTJW533JK5Z17qaxoYL770K6oOFF-9bzRlim92Rfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijeeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheplfgrnhhnvgcuifhr
    uhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgffeiff
    etueffteeugfeghffghedthfekgfdtjeeuuedvveekteevvedvffekheenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnh
    gvthdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvg
    hrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlvggv
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuh
    igrdguvghvpdhrtghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvrghlsehgohhmphgrrdguvghv
X-ME-Proxy: <xmx:IKfVaGdLgQ47fw3_12hvrZhafUyESr_kIuiiZmel5oIMUKdEh5wa8A>
    <xmx:IKfVaNJiTL8cjvTSDT__UcSJ8An68vNHUfVm4Igj0aPVuEA7GARr-g>
    <xmx:IKfVaDLdz77NmFoKrf-EvnPHSUTNZT49cU58Nm4x5bJ6E_AfDQQmSg>
    <xmx:IKfVaMWokm2V5rgT18v8iSgKqEmkosr2nwMaMhFre0Ew3s07gidJUQ>
    <xmx:IKfVaL5wYVvDXcvtiryhIXB5g6spwD_SM6WbfZgl96NQUaRfSyCNdz9w>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 16:33:35 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Thu, 25 Sep 2025 22:33:18 +0200
Subject: [PATCH] mfd: macsmc: Initialize mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
X-B4-Tracking: v=1; b=H4sIAA6n1WgC/x3MTQqAIBBA4avErBNMiH6uEhHTONYstNCKILp70
 vJbvPdA4iicoC8eiHxJki1kVGUBtGJYWInNBqNNrTtTK4+UPCl/HnxPEuRQrbYNzQaRHELu9sh
 O7v85jO/7ASqO8vhjAAAA
X-Change-ID: 20250925-macsmc-mutex_init-80d7cb2aacfa
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Lee Jones <lee@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=+Jor10eg5LvHZCSW9hUAM8+MJz6BmLXiQAQ9uw52A+I=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhoyry+UO9Srerd2t5J3CXPixIzP8kk3K0o78Hg8pJqstE
 61cZ6zsKGVhEONikBVTZEnSftnBsLpGMab2QRjMHFYmkCEMXJwCMJG9Cxj+u/Dy+rsvSXuXqf/+
 NJPM2Vvxa/88vl4V/Sj85vrdP/fqPWD4n5c9X/nTyo3iOrwT1Xo0xQxLWI2EVVz8QmOninz3X3G
 PBQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Struct apple_smc's mutex was not initialized before use. Surprisingly
this only resulted in occasional NULL pointer dereferences in
apple_smc_read() calls from the probe() functions of sub devices.

Fixes: e038d985c9823 ("mfd: Add Apple Silicon System Management Controller")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index 870c8b2028a8fc0e905c8934c2636824cbe5d527..3a117cf19145e86b642f40dc165b542b8df69070 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -413,6 +413,7 @@ static int apple_smc_probe(struct platform_device *pdev)
 	if (!smc)
 		return -ENOMEM;
 
+	mutex_init(&smc->mutex);
 	smc->dev = &pdev->dev;
 	smc->sram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &smc->sram);
 	if (IS_ERR(smc->sram_base))

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250925-macsmc-mutex_init-80d7cb2aacfa

Best regards,
-- 
Janne Grunau <j@jannau.net>


