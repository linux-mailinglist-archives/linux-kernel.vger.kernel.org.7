Return-Path: <linux-kernel+bounces-722681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B4FAFDDAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014914E2D00
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AEB1DE8BE;
	Wed,  9 Jul 2025 02:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lufHw3QE"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E61DED53;
	Wed,  9 Jul 2025 02:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029275; cv=none; b=X5JwmCbeexNfG6QozdI5uQSKAgEXqR80OrwKJZ82/UOWTa5pwWkPgwnYgLBz+bYRAINEjfccDlvE08rGpxHvTAI1AgTrloh6/txJv/r82LeWYMr7dz64bAqjIa/EvKgPx2fwiTCJPOtrIP0AN3OKZkb9qaGl/rF7w46Ps+0aZ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029275; c=relaxed/simple;
	bh=k6Ek1V0zFww6cTykRAAu80fQP06Gke8Nizb83BaqAJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJ9mTeWu1IibSL5x1ULAapaqSOmGFkDM5wjnXiH3F0kYTMRUlwdoJ/1drxbiL0GuAtzYdOK/kaDgHPC0++wegorLidAxaI+qY/jHVzR5CecorQClI16UCVKM18L9VkWsZv0e5ULzUE1M/gCWUAAOGDx+tvdaV4jn0DXUj7M1Oc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lufHw3QE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso5952570a12.0;
        Tue, 08 Jul 2025 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029272; x=1752634072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp8YHaUYlt3FEpZipGcvq1XyhTc8r4Get1J5KKVgG6U=;
        b=lufHw3QEAiiQjSqnKtfqj8V4XrZkxcqRRVZ7M6fxI5ZqW7h/TNJnBdpp6pxY3nQhCq
         BLc8d8b87hDG+uSQ+HrIHzbMIB5iis/OauWhKiOdnvnuhiGTE9Be4XBiQrF5wG7Uq4xg
         T3c7RMEjl7Q16uEP94sq1q4Bjzgay2pxFHRxFHGiFyfWG9pYz35BGfPV3jRv01Pqbfn/
         CG1SCQPoMdQy7jOhefhlltEs8aMfxYB0X0y9XyAdY2O7JJe77KsGkpaxsg+LMxcE2DKl
         uJuXKOa9Rt5gd67c/FuothA2+GUt29OHrBba6FWvK31Nnzjqxt1RNZ0ihM2N4a/WfbOa
         N0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029272; x=1752634072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp8YHaUYlt3FEpZipGcvq1XyhTc8r4Get1J5KKVgG6U=;
        b=eB5lOgrdUAKDjU5QpPJYjU9wiOI64z0AwqBwktLEv2gTdZJUbTeyUSgbTKyd97Ibvt
         XDshWTfqklyIWZmMfO6w5wFbaAH3M/DFxb0s+VuuFJZlj5ZjggqGpqPH4jfTQofBJLM+
         SB57oy7sPmtl3/1IQ8D5bnCX+gsyhKKr6DOQYar9/+kCKkBjhTLxU/8vbEhUR46MK4Ex
         BPcgNckXrP79gbNyyxk1dhTQRQjB2t3SZraJs/qLFIxW787LJCxIKoLjF6AG3DQTopAh
         JiNsM7j8wXzpQ10UgjjLUKUNZUroLLhgAdFf7qopbsktIOuaTYXnpZ7XcpYzFAM1Nok3
         ORZw==
X-Forwarded-Encrypted: i=1; AJvYcCU5UAIjLbt3/fkdJUaN/qnH0RbyIUokQ+f81B1il6M7Ew9WmsGc9i9xovaHJCAuimBMeub5yUTZ+GJ1@vger.kernel.org, AJvYcCVBu4oJIJUhS0sVst03MYC37HIGQySfFNrMB1bSoD+ADYEjzy2X7MKTj2ziSUmcy7DYicpDcZ3YHEYgaZg5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2+hMFxsPJqW4gTGFf4XP0EAazOXdGUX47KsV1QUuYuhczSVP
	hdHI81taPD+d05ztHO/c8qrbKZ5PWUCKWGptDCLmWwLkyXP4wj7MxauzflvpvA==
X-Gm-Gg: ASbGncvi8UHoCIVAAypXzFC8qfiZlB3zp6X8vEjdyoBlEPqXZbpKs5ZdhT7Qo0jKFvf
	NR8CvYLrhbVi2nI0OTRJ5jFM+qrc1RCFD1oe0IID3WnOgaji5rpMaT95iOWfmQ7Dh3oVurodvFG
	d0AQdtlc+YNPQZGu3RPtkVrlvL8TDluBQ8i+b10sqtgUOVMs54NZrFEBd3coeOaOk2x5VWXX/Pu
	FEijEuVr2BO/FlxC8Hyf074gCbmLStlI5qQsKIZ46kE/7/XkzdnDL8yH3oGRjIRzBsRocvcwzcE
	gBuff+boXyV6aeQXHbVuPJA1zmFDVb99FXwM7FspWtki1STfZLOLZvTl7Kw+qM23dojHgs3e7Ld
	R9uJWi+YAQmpTudE=
X-Google-Smtp-Source: AGHT+IEHwqi/EQgAniA8J4hpSTtY+L6ofBdKe59xqRYM9KizU8VJSPRmkYbhBk57sY6zOAYxvP/tpA==
X-Received: by 2002:a17:90b:4c8c:b0:313:1e60:584d with SMTP id 98e67ed59e1d1-31c2fcff2fbmr1562544a91.11.1752029272425;
        Tue, 08 Jul 2025 19:47:52 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300b50e8sm535082a91.31.2025.07.08.19.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:47:52 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] reset: bcm6345: add support for bcm63xx ephy control register
Date: Tue,  8 Jul 2025 19:47:25 -0700
Message-ID: <20250709024740.194520-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709024740.194520-1-kylehendrydev@gmail.com>
References: <20250709024740.194520-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ephy control register on bcm63xx SoCs contain bits for
resetting individual internal phys. Use the existing bcm6345-reset
driver to set bits.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/reset/reset-bcm6345.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-bcm6345.c b/drivers/reset/reset-bcm6345.c
index aa9353439e70..56518f7bfbb3 100644
--- a/drivers/reset/reset-bcm6345.c
+++ b/drivers/reset/reset-bcm6345.c
@@ -119,6 +119,7 @@ static int bcm6345_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id bcm6345_reset_of_match[] = {
 	{ .compatible = "brcm,bcm6345-reset" },
+	{ .compatible = "brcm,bcm63xx-ephy-ctrl" },
 	{ /* sentinel */ },
 };
 
-- 
2.43.0


