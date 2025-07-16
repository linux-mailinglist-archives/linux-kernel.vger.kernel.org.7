Return-Path: <linux-kernel+bounces-733748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B8EB078AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D7B7B087C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D866C2F49EA;
	Wed, 16 Jul 2025 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihhWaeoV"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917C2F237B;
	Wed, 16 Jul 2025 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677314; cv=none; b=VTDtJIqneAgIhTGlXOqsCCt2KHxAhBpx8w+XwHn0a9EwUdmhMqAY0NvdmsnwcLrxqMkNJf/2W4s7gKQqcLYQ2TZBCkX978SqVoO6mOM1iX9QTuLR6n3pfQgx/Zrrl5Tge2zXGlyXYYlZkYKtsoSmZk2TLv7JYs/WvdnnNiSdUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677314; c=relaxed/simple;
	bh=BCcCRBqqAGtRsiNyKrCYuOoOMpnZPWRJIhvbklexh+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEp86IMPMC10VM4IPhZ6Kh9eePUgCKIzWmjICHBImyKRH2YwYe80vo7Z5m/+SjLkS3OYAKIzRW6+H0oLiYdyI75a68K1d96lh79I8nMdK6+DwBe1UHjZpkzCdLUtTl5TPDrutkQUJdNVcB00V/KlIgDFB3VlT8F+NNVgepkV6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihhWaeoV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e2c920058fso106281885a.0;
        Wed, 16 Jul 2025 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677311; x=1753282111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yqn7zR6ezyFbi7KLXJvKlC3aTK2K6+zAz9R7hgTDM3w=;
        b=ihhWaeoVm2vAPYvVkQcspQ6oh0bIdl6dnp/vkhfi+1jxGk6/t3KTZbRSOdna5fygO3
         Rzl6A8eYIdeI9o75j/EZomTsweQ0AG8YGcI8eDM1fN3S4qcYeqQ4qZfi56T1RLujFsEk
         EsStZVFzf6xN9o9C4gW6kVxgvWSTOviLtzzsKJtG0bIZoDs/gFzTgKFE0JK0CXhulnos
         UJ9tPz6REGrwGJhRujbbJTX7d11Yub666X1V0Iim6G0cddoYTPJG+sOjCaSkbE3NQpAB
         kJT8LI8L17dCGv+kaf/57ZI2W/usLVWuYB5fQ1zgunxsxL0SAYzetog8Mvs8qAPu9pCJ
         RU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677311; x=1753282111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqn7zR6ezyFbi7KLXJvKlC3aTK2K6+zAz9R7hgTDM3w=;
        b=VE9KBuERbdiLg3HTwlpNP8jDzkdXSebf7vna+G7mKyncx/YykumIXx5vr3zJHW3PIv
         /lx9eEMMFeMZxND41UJ+A13FQMPGkP5J9Sh47YWNmvEdBKlu2YoPMn9JGlQ04R1oFfCQ
         7e+0wojM/YsVbaSdweJcUHorJNgDl7gECJ/v1EcELu0LF9SsyLbwxZwU3ap+xRggDuip
         GWER9jMDx60Mq/PyKvaCO2oq7wxhmDOOl3d+BmFoS8FjBb8bvSP2mg/Yo70n6mJGAlGt
         gYq61ujkwRy5TLSzLLKSAKzGQ10fkiVbD9NLvnQGzrWVflnpzppVQ0Ufu93+edzEQwc2
         SGOA==
X-Forwarded-Encrypted: i=1; AJvYcCU7GMtnkNCx8p09P5l6EA3NjBZoJQA7DGRhmfN1B6kKLBIjdiQ0Wfte9OtmxfsU5s7ZUW2kQVjyOYkRtHM=@vger.kernel.org, AJvYcCVkgKrSqd3difZVv+6qe+xCp9RSlv6p8p1XZ6n7i8aFYxLo4BaKfxkSgAO08Mg3vSD4o0P9ogYZfXrVNGyEGmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxH8CN1lRN75DrAxfOevyVUBL2Jo5FXEgFr4vEXFAH8E/aE/6
	9NmE47eb6PaZORnfXx06SNklSWmI4oj/vy64Q80KJvlHHn6RGk7J3IXd
X-Gm-Gg: ASbGncvm227Q3+DpTOxHSY8AslASYkAi0cVRVj2zWL41R1gE3hDPWiCJIIBe1T3XqoW
	S7rI/KjFW/5dGoW867D0jIbD1RPkpGmpR/x7/qAWuakgLPGVaf2+GBhF81Rv6KLd4DtX9xQWwRS
	/oBku0JKNbmigu8WM+HWAdyQ0Z+NiDye9M6PN5gUsZSla+ITia1CxGGRx72GEAFDeek17CN3n1R
	pWjOIwh/lMpRq+otBIkC+wr/R4aaH+Gn4242b1GQ0h5O2bIcbUL2hFLfxwkPgpXpW5B+vYg9oqR
	eLSCbDq1nXP1UQczFy6YJA/RsI4vImfDMzNq+hcK1Gw2+4OBiERc90BIPx+Vsqlg7Pz/C4I+fZF
	15NLH+rP1yMXH4pwZ9QsWcoAMVMc+0N31DKHdrbyZAZegeqS2oH1vufZR45E3FxhghhuHRwJX5q
	6Z2BrKLze4dLZD
X-Google-Smtp-Source: AGHT+IFx68WAoZvTOVQcwBxkgEo+JP2sqdDTjNAFbzGDuX1SiMFFAwlgGdNH8yE31YtfYsqGI6zFhg==
X-Received: by 2002:a05:620a:4e9a:b0:7d3:a4fa:ee06 with SMTP id af79cd13be357-7e337b853a9mr928321785a.29.1752677311175;
        Wed, 16 Jul 2025 07:48:31 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdece0f6asm760137985a.104.2025.07.16.07.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:30 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 31812F40068;
	Wed, 16 Jul 2025 10:48:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 10:48:30 -0400
X-ME-Sender: <xms:vrt3aOsjaYj1rDf52RdTfi0_u2RuCxHplaKubPDwOIoJA43GROs0Rg>
    <xme:vrt3aB_1F5FH479ag8qdxNRF-NllZbRp0ouO1-ZfxYUGVYqZdFGPmZMZS0zITOgPi
    zi-qY4897HZTkpiUw>
X-ME-Received: <xmr:vrt3aFR3H8buybc5NWLIC9pvmHjH2vgemcCfcFVYD7N-05qif9yYtpMXsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegffejudegueejjeeivdeuteejvdduvdduvdefledugeejhfelieduhffggffg
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepud
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrg
    hnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhg
X-ME-Proxy: <xmx:vrt3aDXahlxJpZKb2cNVoYn1eW1qeEuRvdY5ZRsEVSl1ZMfg2_ql4Q>
    <xmx:vrt3aH8GM-1TyKkxFjGcQRQwOX2kzNX8qMphPKRORs1SMJy8Yi7JBg>
    <xmx:vrt3aD1vXzgRFRjJGtTI5aWJmdvrIzae78o9ZHD4Ob8XMObbdDW_Ig>
    <xmx:vrt3aMc_BLgPdu-bQgRoMtgwrFLufwezud7mUiunlF337Sj5IHuzeA>
    <xmx:vrt3aKCRVjWm0UxJY3utD_rMpHGx4lHE-Jkko_5lZXFN5buPo-sZwlMB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:28 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: "Will Deacon" <will@kernel.org>,
	"Waiman Long" <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Davis <afd@ti.com>,
	Lee Jones <lee@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 2/9] leds: lp8860: Check return value of devm_mutex_init()
Date: Wed, 16 Jul 2025 07:48:11 -0700
Message-Id: <20250716144818.47650-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716144818.47650-1-boqun.feng@gmail.com>
References: <20250716144818.47650-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will be
marked as unusable and trigger errors on usage.

Add the missed check.

Fixes: 87a59548af95 ("leds: lp8860: Use new mutex guards to cleanup function exits")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Andrew Davis <afd@ti.com>
Acked-by: Lee Jones <lee@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250617-must_check-devm_mutex_init-v7-2-d9e449f4d224@weissschuh.net
---
 drivers/leds/leds-lp8860.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-lp8860.c b/drivers/leds/leds-lp8860.c
index 52b97c9f2a03..0962c00c215a 100644
--- a/drivers/leds/leds-lp8860.c
+++ b/drivers/leds/leds-lp8860.c
@@ -307,7 +307,9 @@ static int lp8860_probe(struct i2c_client *client)
 	led->client = client;
 	led->led_dev.brightness_set_blocking = lp8860_brightness_set;
 
-	devm_mutex_init(&client->dev, &led->lock);
+	ret = devm_mutex_init(&client->dev, &led->lock);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to initialize lock\n");
 
 	led->regmap = devm_regmap_init_i2c(client, &lp8860_regmap_config);
 	if (IS_ERR(led->regmap)) {
-- 
2.39.5 (Apple Git-154)


