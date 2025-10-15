Return-Path: <linux-kernel+bounces-854692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF90BDF206
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD5A18851BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD872D73B0;
	Wed, 15 Oct 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJTMLG3Y"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E642D739D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539187; cv=none; b=FPF8T5JD85sky/mEsUMVMz2if4azHZYFlGBXNuv7dgfPj+Cejc+ww3aeS21kuFiFh6KO54UsnALnKIRcOONa3DM9ysU3ECIgjB6CIBsape5vsMNSUDVv9W6zbu+8Lw1mAgqNfoFGg+ErCxlMEbPf0NWOEdpiSZOhTESNPXGAvDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539187; c=relaxed/simple;
	bh=lYf/qe80oLGAnbA7MhV4NFVx5ShYiQse0PXVM1jfQ10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HyT0dsL3ZrA+AOWgiVWTyVkP+TU5B7rJflYuoiaGGvfMEC9K0z5QxEqtE7+BegP3bwq8M0ufxHjG6NcwNoOy30BbN8woPiSO83PMlC1gw7VkwdUJxN6JvRFiZWNWo0Rfg3OvE5l+x5E4jEVlCF6F9D/jupWjOqJ9ZKXt4vlQTCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJTMLG3Y; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-279e2554b6fso50024095ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539185; x=1761143985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/LQNtZoS7OfijYrFt3rjrDuiajb22vvwUPhElheOqs=;
        b=eJTMLG3YVH8WC6q/6qdtQD0sYY23AFn61FQaDZFIIe3O0hQKLTifeLDS2Kn5qwovFm
         6kcPhrJ0YHyxBbaMbgaECNEQW5M30VCry2w2u7rl/KpSY+V15K2OBWwPRF7oefySKFVf
         xkFs0/kFNaVuVa11Huf1vF8XjBogj31DU9MHnM/bCqXmLuO8kQC1yl747mSlpaIcYfee
         W+rVizuNLS3YCAcyz2eVcdCCIumrlLMlvA8nMu5bysjrUsYxbzqGeN6noV4jNNYeuyVm
         Qmsae+oyvtgk3Qr3TyhQu/FNGe4JgY+dYc/xUi6AqUOB3XYHzJhQ3MFuP1BrOSQ/APMk
         +s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539185; x=1761143985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/LQNtZoS7OfijYrFt3rjrDuiajb22vvwUPhElheOqs=;
        b=NMkQbX4j1IxUHqs6rQxiNhD+Ll1DTEIzqDJO3afJhW0v2Q6Y6pU0a0Oy4NdVbGO9aA
         wnn0mlf9S57/dmZ+d4JaDEjy0Gp0sdS9lkbXu5M4kts0voj8CLYRaIfqCgJHBnSZxWtV
         Ob/2ew7DqcEy0FKXAb0czgUfm1QxS2BTl83UgXNVSAvLO4CvKzkSuZKMnE+XRQeXkkSZ
         OefcoDfbkV0/8zQ8EdVfWXtyp7tYsvsM3W/+g8n3kT50nG2Q+14vftoBjiaL3YlKSIp3
         L9l4wBDJa9qKpzBM3stZ4jNZnYI+WYEVUbuQU/xsSETiKEe40PQHQ3l4GpNIqtdbYBTA
         Ki2g==
X-Forwarded-Encrypted: i=1; AJvYcCWYe6DkWTgGNWOracGkvVzX2oSrIkPqFvvE6vt7wcNnppuzi3PqifIjwH2/t11qYj/wvhmGls7BOhwiC/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkjrcNeYHvP0aslfLBRajz81cMY0tgTRQf34kvTSDHkn0EGayf
	O6JaTRYZB8Di+xQ9Z03wX9hzdKxj3k6jHvGdnRYmk2/BfkQltIscbOZfm8iVzuQR
X-Gm-Gg: ASbGnctHMeTVAJkv02fuh5++zfJRsp7Tu185530DsXY85aPdfBAQz0v4c0qw9QKIcr+
	hIyZ8mrw1lomWfr5/FzsR/wbF0JNX2s9dbRu7iQvEoZnw0Fj9k5FJuNbLlvl+pyWRYHuzrCjFLl
	itGKz1hXI2w++RIiVZgFNJx2Hksf+a2cGF6nVS3KfwWereZftBNy0pGwsCudsAR8bLanX4yeCIz
	SbiX67BGlFjl5LYb4kkBlH1mgndvgsmgJz0feqtZHG9TWmHfa9zVXwLQEM3pFYxyKOqHAc8t/L8
	SOoLkgftPQN7pRViz84EhCCKHPuDdUdh3n1WITFNgHKnLV2VFz1xcyY5w4wy7moB1+NxDT3/wBo
	/LhXXSxOSv3t+METw4Xs38VXlSN2eaNHFLtpq6YWBd6TAz+11gp10eNKdn5RSVxiu2s9TtptUPO
	HckGPDYDE6Rm/pVp+lbpD+78Fo+ghQSg==
X-Google-Smtp-Source: AGHT+IF2UAqKBEIsjWDU03fhnfdk79hzfXklRzmYJu0XI5WZNyJUsJl9A1TbaofF+An7RpHOubeYSA==
X-Received: by 2002:a17:903:2c10:b0:27e:e96a:4c3 with SMTP id d9443c01a7336-29027374b5amr331259715ad.14.1760539184757;
        Wed, 15 Oct 2025 07:39:44 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:44 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] ARM: dts: aspeed: santabarbara: Add eeprom device node for PRoT module
Date: Wed, 15 Oct 2025 22:39:03 +0800
Message-ID: <20251015143916.1850450-8-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add eeprom device node for PRot module FRU.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 3ca5109af19b..f74f463cc878 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1076,6 +1076,11 @@ eeprom@50 {
 		reg = <0x50>;
 	};
 
+	eeprom@51 {
+		compatible = "atmel,24c128";
+		reg = <0x51>;
+	};
+
 	// BSM FRU
 	eeprom@56 {
 		compatible = "atmel,24c64";
-- 
2.49.0


