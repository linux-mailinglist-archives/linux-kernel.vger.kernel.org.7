Return-Path: <linux-kernel+bounces-870051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 858CEC09CDD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5214F0D88
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AA530C60F;
	Sat, 25 Oct 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVN14onw"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6ED30BF6A
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410446; cv=none; b=ibR0fIUPSUq/joXoSMkJ9mG1xvM4OWsRfil0qV/R2BI6luK479/NfhFszH/WKRhlNgi1TM7eWhstjJMEzjBeXubtzuz6MWr7vo3ciDNhpWTroI3ttkUwF9lid5aq+pR9BML2tKbxcoTc3Y2Q60nIuPPQoy40W2pUZCi5L8qNJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410446; c=relaxed/simple;
	bh=HkqvAUV2gBzhJnul/mGo7LdzjzJg+2pG+539ApHOXFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL6rI5BMUNHyYyS1RzMoAYSc/w+LSS5zqVV1U16fvCnvYXCTuP5gnrfU2GfBUaQWwrpVQyRs8G/+elb7QScyE0nKdcEg96IxNrhthPflMxaykESTsvzMteH1OIgInjzgkEFKhFNx0hGdvVL5SNDf7yYwWKe6HyLh+TCy29vmy7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVN14onw; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-795be3a3644so17802966d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410442; x=1762015242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXemVp+XP5C7K8PhG6mE03zKRPQX07LLYcr9/0qBaeY=;
        b=YVN14onwG2Ww1dUHuVA8kXevdVznYfaJfJPACF32GtrqG4BQ40tDrTfXnDzCmbSTG1
         oPf++8Win6glHMH6XlcUqJkXFW94QcsEhu0dqExF9w/R1Gs9EnFsQCJdaNyp/XC6/JiK
         wZYtPge/GIkO4RtdFV7w4wA8yVr1FLy0BtMhPugI+he4S0dC+LxRXU8u/ZnqopQ/gf9+
         6gUCycJyDpxqzLpR7rQbrbzJf6wpHZ3qW8q3s1L/P9XgfGoTE4jpJOSg9juuyjlH3aFJ
         h2ommn6oVF8oQAp9rJkdqjTLN+fc44+fAbwabz2Z/TUEOIYvRn29+/7y5chUX17qn5/Z
         x+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410442; x=1762015242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXemVp+XP5C7K8PhG6mE03zKRPQX07LLYcr9/0qBaeY=;
        b=oDHcdXyICpR0hu4jFMP3/5GJJmeusDJ+r/bVd1eCz7Pw8f83mnWLrJ6pghYhCdVpam
         LSfYDTHdunsFFdlN6qY4D4cT3+r9yGU8Re3o+HfH85JkwhJYUy8JP2iBbCeWgs5vG8Vq
         7Qz53W/sPMOl7QPTZW4lTC7vAnZBeo04i1urteEsm94jQo/5PJ4iZY48NBIt2so4Qh7n
         esTkJPM9fE68UmA1tV4AQSQInjNEaiulzWgFSX1lkGnc2SL+7G38TtMirHNZbdqniBrM
         e4ReG48ix/MjrL9QT09KiM+eQlupMgPxf5329LIMpt8X60G1yKxECl95uVU0TprEGGgU
         SaCw==
X-Forwarded-Encrypted: i=1; AJvYcCVIy5vq3WU1fiTjK1HwB38Nn1eTlLcbZADOS0TQb4avHbx3MLwrMwTO/jEwF1qNGD4b3foWYa6PhpDJpZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiL0TAakop9boRK3yemDi9NHuHsGd5cm5WGlP5PjrWkVinOTG
	GMApgBInXPB27lVwfDegkRH/oITWJyTBVUmJa+qC0nsv9UOZCRq4fQCU
X-Gm-Gg: ASbGncsaMCOlotithfw4tVKtKu50nAj22aH37xTieiafl55TbBBpKiSULRJKsqkEFKO
	xp9e4+piQdaHWSBWKDZ8sT9Bmo+pjbwa/FaYAD3IBVAzYCu6aHeFkPvVlhxBTi8xQmoOUmvDIjV
	BxucrnXjrNdtH7APvx4PZJrHKY2Yup/fsB6oxG2DpYgeOpgylnxViZa8k1TQ0Xs6KS7t5HJhucb
	Jn5kf2JHfchBMOk+AHexkRZXt/g5sJybA5Hc8Pk5Fn/DCw625QV6OfFt+tOEqp9JKvV6grpsMaV
	JM7mhdIIAAoVy/so7+Ex3336QJDAwis4PJ74z1hKOpFqb4RmJ/gRHMb5mC62ppGUpB9nnTf8YIP
	gTlITlVoB2eHl04HgKEFnIlOJF5Ssi/aGNy0D+axw7QD5NNPLGsrQsYilGpOZHwm6dG/Z5PYgnO
	jMSe6IzuQ=
X-Google-Smtp-Source: AGHT+IFkeV9A6Ptus3JmqPV8qa6Aad4UN1X85QS76U9hx0IlT5Ln2gOuZnWRlM9bH9mA3BFWyYon/A==
X-Received: by 2002:ac8:7e84:0:b0:4e8:b793:1c3b with SMTP id d75a77b69052e-4e8b79325e2mr295994671cf.61.1761410442323;
        Sat, 25 Oct 2025 09:40:42 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37db728sm15162421cf.12.2025.10.25.09.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:40:41 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 06/21] mfd: prepare to generalize BITS() macro
Date: Sat, 25 Oct 2025 12:40:05 -0400
Message-ID: <20251025164023.308884-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding generic BITS() macro, add an #undef directive
for the existing BITS(). The following patches will drop it entirely.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/mfd/db8500-prcmu-regs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/db8500-prcmu-regs.h b/drivers/mfd/db8500-prcmu-regs.h
index 75fd1069372c..25d2d5966211 100644
--- a/drivers/mfd/db8500-prcmu-regs.h
+++ b/drivers/mfd/db8500-prcmu-regs.h
@@ -12,6 +12,7 @@
 #ifndef __DB8500_PRCMU_REGS_H
 #define __DB8500_PRCMU_REGS_H
 
+#undef BITS
 #define BITS(_start, _end) ((BIT(_end) - BIT(_start)) + BIT(_end))
 
 #define PRCM_ACLK_MGT		(0x004)
-- 
2.43.0


