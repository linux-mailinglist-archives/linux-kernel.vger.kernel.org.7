Return-Path: <linux-kernel+bounces-733747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CAAB07899
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66CCD1C28031
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D112F2712;
	Wed, 16 Jul 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ7WByEr"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17E26E143;
	Wed, 16 Jul 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677311; cv=none; b=PR2EcoQQfnu2aos7k4NnpT35dirWxE4bHTBfDVUFAY8bWpNzzbFV/y5Z1DtC7FdyXYRp5M5lJWDuNVyZEM5iElaVQmdYFn2QWWimfxv/I2hLbr2PS+5zG/iltIkd4JalR5yR1oYDnFxmRQKSMurmzMEgevD+K+99Y8RW0mNGOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677311; c=relaxed/simple;
	bh=j4qjjacieeCW6I50WKuo/X4UFoA5tzd+ofZHrwlbbcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKsjiMKHwvi5B7U4e+p+vEHVUbWM8u7bbO3wkvu+VSABXGxxpX0z5QaWfjd11waadr9oUD68seS719kLECuB7/qE5MddXMELWwLrmOvGG2r7GKwcrdI/oFv72fFBNJJapMTonwszESSq17ZyABYOJiBAVxb811oDS4knSL898o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ7WByEr; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e3142e58cfso213768985a.0;
        Wed, 16 Jul 2025 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677309; x=1753282109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TBAttnVo2ur1a3bZID5ohjlkHeRyrtxoDHRT6itoh6E=;
        b=ZZ7WByErK5KvGP5CF5GObHxZNuyrQZDtjz2qDk4KUte0EFLtgUkuNV9jPS9UPRa3GN
         7drM9icVX0ztNK2p3qvHO8Wi2GXsnNTidC7Oed1cS49f0Tu8RK81ip70A7323Pu86ncD
         CcrvlFl6abGktoeGdpBFa5aYvV7Nfa0CHy+UJ4jqT+86e0zmJ7OHDMyzne6BcENnexEE
         6oWBqndbM2wTqZfQkEJ5mC9KSPyt1rV8zBEGZTVzrppbBFguv1UgzxJXLT6IrNlilyij
         e3Wbb3yV1JLvNavkAQ+DcoYxEbUtaxD26YcCMGWKXH/fY1nOCYqXHhTEB83AQ+kt14A8
         QQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677309; x=1753282109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBAttnVo2ur1a3bZID5ohjlkHeRyrtxoDHRT6itoh6E=;
        b=bn+krsckXGNk6U6mNJpnlJ+/lurElOkrwcwyRWrwBExDwKumyMvaPIdIBhTnYWNM8I
         Wrxguoknjh2BeC2fBoAGXIBsOtN36SeRNhKO1sHnL/R65uBhhNTUXWc4jAQJmtQDBbrE
         piVc9LifJHB7AcFIydDT4qEn4EZWYpkULyL33fJIQQfUpodiRi3hVgcwfVfPEkOxhClh
         yDix0Y+2/V3zCn8ReqgW2Ndz0xa6U6z1tICbMZOu+k4uA32E1Non1+A8AuK3phlXje92
         9r5sriuJ10a0iYUT2R3ssti2OMhGZU2MYmUHemKL+nwjurysWOJOaIJS2/zr7kcK6AV0
         H9QQ==
X-Forwarded-Encrypted: i=1; AJvYcCX08K4aE7CWFlh9+b9PL1CAgDXk5KlPfRyHAm5Ri3vQnVB7G3HEie1wPiLziwnsOMyBRhMvu71nqQcF86lm4uM=@vger.kernel.org, AJvYcCXbpAbOGXyss1uAQevW2SEQXsA/ve+kzZ56/cFnvcqS0fWvwJeXFre+wB+NYGFSe/jlpeipIXtaP1l2I6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw528t4ndXQrHze/OBal9sD6p33VHiYxxg0RhT3iThjF02ES7EV
	zCM8+Ulb2cvIj4LFiOHRFQmdJicM6C0Cdq7YJBxd/6QGcT2z4PIq9qyU
X-Gm-Gg: ASbGnctMHxNcAqjQjYVbRWWYc3x/40ft6m4moT5kchuLkEzoH8xG5SOH0/kcRdnnIwn
	+GlwMu4XifFskNLRdm13mqCeElGSZQI20yHQhjXeVES8BPl1F515UV1ao2UFo26Mex/G5JtYaG/
	jMNhrNej4NGmuDUyzzfz/YsCtV6GzG9LtUh6ezX4Fj/VrL1LDAgzY5o/KrQ2WSnKj5y2BdwJVKb
	Ot3bv1HLjb5zPxMZBbEz6lyPxMU/qIvBzdWkc2VDivekR9V5DzGEPUgQC2y1maPFzJw09+sw7mf
	fLj6aZDQU291VWzuJiwLxtcRENQSWzXIw3n8Fr7gApp3OfUpbA2xyZpslcS6NxpL+RwPrZdb3eh
	mzjVIMasfKB2ujZTyNxq0cF/Lh2S4eW/UfA/iVpfqjU/PLIVrbknbuvyPT53WYvys7S+LKXoO/Z
	/8GG24f8iFmU5m
X-Google-Smtp-Source: AGHT+IGJQyKLHVOSzZuFpqpbCe1JnPnRq5yPKi4SVU/U1a06lvigrCLfhNoQpjDdTGQb3FPDQlfxnw==
X-Received: by 2002:a05:620a:40d2:b0:7e1:3ef4:8f3f with SMTP id af79cd13be357-7e34356d80cmr466220485a.13.1752677308414;
        Wed, 16 Jul 2025 07:48:28 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc0f8689sm760783385a.43.2025.07.16.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:28 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id A0B04F40069;
	Wed, 16 Jul 2025 10:48:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Jul 2025 10:48:27 -0400
X-ME-Sender: <xms:u7t3aLev9KsBWrm4-kE5YWe0u7sJHKIXQWgXdq12JrCjlqn-xomcFA>
    <xme:u7t3aLRFq1SEka9CodbdHJXhcgNuy91xftNsGDVK9XTyXE7mKXBKSn7zdgxYt080P
    aE4VbDopmNTPrnYLw>
X-ME-Received: <xmr:u7t3aJexJlWtDN0QPLtiOWuBku4_d85OimcaO2E9K9kqx1wL-9x7o-MVvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeegffejudegueejjeeivdeuteejvdduvdduvdefledugeejhfelieduhffggffg
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhinhhgoheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhnghhmrg
    hnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlvghithgrohesuggvsghirghnrdhorhhg
X-ME-Proxy: <xmx:u7t3aEsqKSjVMRm3MNmtEbyVrSLNl7Fv_Jtd6NqzLS35GK2bCBst6A>
    <xmx:u7t3aFJXcLpDChorJVh1SVP_373bXJ175ufDgH-9KdgjeUPQk_HeOQ>
    <xmx:u7t3aIYnWLMNf_HCO9Kq3LewXD2DuWl_CAfc_dbcRxcgdrn8dKHCzQ>
    <xmx:u7t3aIl_E2Sve7FZ-TxtQQxGIDrvQCy4xbj9I9zYKpdvyAaHeBTxRA>
    <xmx:u7t3aGXrmKDs13wzksVZ0sW41yU2XtNML3m5ZKfwgGh0-aAV0TDrnXN4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:27 -0400 (EDT)
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
	Mark Brown <broonie@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 1/9] spi: spi-nxp-fspi: Check return value of devm_mutex_init()
Date: Wed, 16 Jul 2025 07:48:10 -0700
Message-Id: <20250716144818.47650-2-boqun.feng@gmail.com>
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

devm_mutex_init() can fail. With CONFIG_DEBUG_MUTEXES=y the mutex will
be marked as unusable and trigger errors on usage.

Add the missed check.

Fixes: 48900813abd2 ("spi: spi-nxp-fspi: remove the goto in probe")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250617-must_check-devm_mutex_init-v7-1-d9e449f4d224@weissschuh.net
---
 drivers/spi/spi-nxp-fspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e63c77e41823..f3d576505413 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1273,7 +1273,9 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to request irq\n");
 
-	devm_mutex_init(dev, &f->lock);
+	ret = devm_mutex_init(dev, &f->lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize lock\n");
 
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
-- 
2.39.5 (Apple Git-154)


