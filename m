Return-Path: <linux-kernel+bounces-722686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E14A2AFDDB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1AB45421D6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4820B80E;
	Wed,  9 Jul 2025 02:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+zhWov6"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A421DED49;
	Wed,  9 Jul 2025 02:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029286; cv=none; b=cKunf4NzjhKRBcivEICtIf5yT2GXJrYHIdtn7fzWpFGkaQIzYK3jPhD4FBIHVrP6gBlbFHXoIv8tO7U8fVhSY6QHK/cQul/vKY/3tGyD2wKAo0opHxQV33f5yOhMI2dfh0p0LZah5x5X/UhZrEgbEPlFoC2mTgSIBYIA1+z+uQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029286; c=relaxed/simple;
	bh=fry00SPGVpuxdDFCi4Ompf03J0WRVATIzGUJ3376lLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rng+/Qdy0+xCpPrTjMuHp4Jl/I9TGfuDOSpv5NDvlUY3SNPXIhCDTWRLQ+QMf8pVs7gR3oL26lfe1OXq/ckP1vGhcFO/OWm2u3fZpwSIO/XJ0VltQWxrBxndQ295j4aGtpuOFcXI2IQfAdV+sdnI6+AGSE7N7PkTV1CvgAEc9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+zhWov6; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso4122465a91.3;
        Tue, 08 Jul 2025 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029284; x=1752634084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpHAYh9iKWqP/zPhU3wx+tlN/kVS3P+zxDIM81VYEsk=;
        b=i+zhWov6AD53AhrKCL72uiucK6kOCcN6zKaBW3MOPGOO8k3Nk7RLhb2ZC/nNfKd9Pl
         jo/W2NuMGYJOs0KkIlcqjmgVBBqpLRCBznhcoGdwueiThVmAlsQ+Ubx/jgn9YoJeigtd
         gsp/ZkhGmeYPhjPMeeVOx9AuvZmZgclrJUCZC5MEC2ScxvE7pa7/pc6Iy/zclzjBaqp3
         ZyI0TC0ncJmqd5wUTkswe6/7OOCzNE8k/fPvQopTDRkkcPp2SEMVVoulqdYbVhg8x5yg
         gtz7r7KHjnxZuHrnC/YxN70yd3Wn3Gq0VBOIR3svXfHKnB6q+voHicHrdUBWoToHMhA8
         Vd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029284; x=1752634084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpHAYh9iKWqP/zPhU3wx+tlN/kVS3P+zxDIM81VYEsk=;
        b=oxQF2KgJrvwoKduFfVQ0UgdgA5NL23Iv0X5m72COO640vOsXCGIqX5MH6X5q784CjL
         XEESaAd8Y0GV/zR7hAcIBeGF3er3eVRmU32pEmWSyLzvSb87ait3u8RAoVqyeNI/tQjr
         jcfBH/G4udEGfu8ksdf2dxmwXn8DyDhKpo6hSFIudx6/mvKntxMF2Rtv9aMOrRIjCuyw
         xZ/IEWKqDITyLzgJwgY3IPb8Lj3K9buTMIzPKCcxXjMhs7WHoL6xCBn+JtTJmu4PccUL
         REbFrLmWafd8h3KAACKERnFheWHEvVFcjMYFNHZ/Nh5wsoG507fWzcdkpbhchkAGFIho
         ROfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH9kROR93B73674zj5HiEzVx7XBtrbHsdBKJWRGQE0tXyP/7hI1BZqcM7KyFlVzLVd8UT0jglijYo41cwh@vger.kernel.org, AJvYcCXOJMCBUN/KDzHdaelt5c8NAnXxIK5XpZvCYC8OAqRYHlx8pZZBWhdtIVm3/NuikNR/kqnkTRBLpkie@vger.kernel.org
X-Gm-Message-State: AOJu0YwkJ8s/yX9Yy2HSJNNTz9odk+7dphOHrYe48zqTGFZY8AjAsr8u
	QCOasw1tJGBZQ8KTAbxXWp69+grYDKYGS0+HcsxJuJzH2gw7MKUSfAXd
X-Gm-Gg: ASbGncvSORVhtzEE9suIP7IkSSzZ0yWcG5p09eCxlnuEf3z5PRu52i95uh08LiL0YZw
	ltnwtD2VEdUv7SIkXokhNgxIXC5eGlUNWKVKOYtxD/itXSjLtnFC+tjfalj5SNY5vPYgBprSbmk
	Uqc4xsL4Bhg+toJYC+MycPI3aqbI0kcVEcaXFr5zTvq6r+g3qV6rI1g6xF2q8PWh96QcDjhr3h0
	wKvQx/1lFFd67PH+5EVrhBIf5IOx71IEsySFLVLLdwG3jnvfPRR9QGxUtJHIkHiQjDcAew3RrdF
	AUTkD7RueJugNh8QqW6c+zMkkwDxHNuapfU0Oib0AfDWo+vn9pQ73OsjMFAd4qxIWCZgzrLzCgs
	GtFGw
X-Google-Smtp-Source: AGHT+IFIBs3wSVNkPLG3SDgTiNiHQPD9fa2jIm3DYXSUMgX+vkGBZUrSRwhjrROeBXtB7zRA2/DnMg==
X-Received: by 2002:a17:90b:578f:b0:311:9c9a:58c5 with SMTP id 98e67ed59e1d1-31c2fce6cfcmr1475974a91.12.1752029284286;
        Tue, 08 Jul 2025 19:48:04 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c300b50e8sm535082a91.31.2025.07.08.19.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:48:04 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] dt-bindings: reset: add BCM6328 ephy reset definitions
Date: Tue,  8 Jul 2025 19:47:30 -0700
Message-ID: <20250709024740.194520-7-kylehendrydev@gmail.com>
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

Add definitions for resets in the ephy control register.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 include/dt-bindings/reset/bcm6328-reset.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/reset/bcm6328-reset.h b/include/dt-bindings/reset/bcm6328-reset.h
index 0f3df87d47af..f0a164af4105 100644
--- a/include/dt-bindings/reset/bcm6328-reset.h
+++ b/include/dt-bindings/reset/bcm6328-reset.h
@@ -15,4 +15,9 @@
 #define BCM6328_RST_PCIE_EXT	9
 #define BCM6328_RST_PCIE_HARD	10
 
+#define BCM6328_RST_EPHY1 0
+#define BCM6328_RST_EPHY2 1
+#define BCM6328_RST_EPHY3 2
+#define BCM6328_RST_EPHY4 3
+
 #endif /* __DT_BINDINGS_RESET_BCM6328_H */
-- 
2.43.0


