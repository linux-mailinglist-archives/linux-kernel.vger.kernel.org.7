Return-Path: <linux-kernel+bounces-798465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF365B41E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3CB07BA300
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878AD2FD1D5;
	Wed,  3 Sep 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blog7Bdd"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908722FCBE5;
	Wed,  3 Sep 2025 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901169; cv=none; b=QgNRBbJEoGLRBJucJNJwgQ1IhVc5Cf+V/o1ZvxtW6QHjdeYhkdo807wJr02vfo8JeyT8thuZpXjuPiPuKCvIrMcjFh4pdQLd529vzEPagka11yv82vFke6+NT9KVEhhHWtEFiB6L2wt0u0qcOhcfA3zoPcMtcIZTSuTHHb+C1Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901169; c=relaxed/simple;
	bh=zD/knpXZK+xRvRIxsZ4WBGoq4pr0hrqyFvZ0HqBI9OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv/zZRqnSkA/FX9McrujWitbgB0goefNU3Q+hmhv9syGAN6ERsAMuqG1ERVd/+KkEWNu3DbmzHErHihgu7oouV0/Nt9BipDRNSRVeGhJMnTTEpaszK2vsq5IUkMDGHoOkWjnGseeWdkajPFJvhskdB3163Fmpu/phRRLc9IAd2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blog7Bdd; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24879ed7c17so49003585ad.1;
        Wed, 03 Sep 2025 05:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901168; x=1757505968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqGQhSrmR9KNt2mlgrpLBIlQIaWDRnvltPL/Gn6wm7Q=;
        b=blog7BddpW7t0FgI9DtXyVqOjHc2FnagjAOL6OtQSmNE9NfOKnQPUszd7JljdYgSa+
         zO6wwrwYwzReitlIq6dpwQEgdLei0UKB1NmiSfeMPMnD+6yUsRMimvP+a8lZppyVqJxI
         WiKH6L/U21TPjrstalzrILpGjFv7rVmO++yMWZHDp1X39h80SxtFGiGjRvnXQIucj9KF
         dV/7ivIZfwvpmTrtb0N4u0jRUsGOTPpE5AciYPfEgEtaVgJQhfczjy+OOj3bHaU4OQIU
         Mu5iRLQftjR27/fWjjUcSJsKt2JNHf0EH5obLxTJBKXOnCwN7ZPv5zCj2IP2VjTHbA8t
         aODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901168; x=1757505968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqGQhSrmR9KNt2mlgrpLBIlQIaWDRnvltPL/Gn6wm7Q=;
        b=PFIzuxwEKCc4ipeCGRWDZO4WGQM3niwlVp3nAsmqkEcgTlbGlzK8DwgeZA9EuMMBZp
         oYSXQJXLTAmzcXUMvS+IFF/lvCvW2qcF3uO9hOqwntaBmU/6inTO2DiRN9V87phmlDwx
         oABRAnnyupp2yC8yBdP4XoEXFX2uh5fM0EdAkNRxUfuhqIDa+3h0BBhkCcqf3Ud+yf+o
         9wOE0GrNNkTDCa/fL+0U9OOpGf5kwVluUTIUHd9Q0/H7Vpst6HDwRfwKej22gUTnJCz4
         ckWII5JcgLQHmTO94YgggQEE764HOjHmM1E0WDu/j5QAG5Q7dnu3kt41CiFMZvJpr4w2
         a3UA==
X-Forwarded-Encrypted: i=1; AJvYcCVi2pCeFcpb/IiwaNS1QxosXAbexTPE/1Q8sWldol/bqmcwq9tNPrOJ4R1qRVpAmp73FFonpUoJHCLc@vger.kernel.org, AJvYcCVmK0N7Gne6nB+U+VCy6l9CFi0niiDNwzLURupE+zehaXFarOQ2hFWABOs8bBUoeeKJCBu3VPVZG1Hn3kJr@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ3MXGPwQrP7SjjxAFaHGcV+DQ0zFtUj+oW8jT6ssXHA23skfO
	YgcW+7ks97fyp8heWz7Pic/ZAYGuUVmkHDQEziLEnNRY6u9G85MO6YNO
X-Gm-Gg: ASbGncvCR6sfN9PVy2+lt200W32bIOE86nTACrwhEOsMXfOGae3djC99xiyYbggP/VF
	+de8JtoCv9weKiysN/VVRKWyvxh1pTXG3BBFVNEa+ydkGiYez7TPvpZMQwlt8KtzCw8L68EOqiz
	2VoIOBHxp63kQRl5n4fxRiY8sQFnE7N35vSkXL0KIzmrN4zqW7F9lyI7HQ3i1pCQQqDI6qcdUb6
	Umi24X/TikypuqPSqtmih3J4jvHOYmmDH6BlQzM830WkhKoyRNQrW3kumqDkSILFUnR6Vl3RJAS
	nQz5g4+7zcAqmsqZMNlLzXy6qhyFn95mrK8q67iXJnkm24X2Cxy57RCMYDykRTU6rpPyLsmZZGZ
	zyezxGrlqQvsBH3v5+O20JL+ASp1XRxFPRV9LDbZFIE4URBXwdN95WnCwuj80lICUNh1htU6Wfy
	u7CZTk8megKiNeAUDPr6I=
X-Google-Smtp-Source: AGHT+IGRwP+2jhI7HlYV8PivgRIYsoYupEDByvIyv5rCdBLRIMTGG2RxKeItgA988VxEJG/hq8+L9g==
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id d9443c01a7336-24944870a4emr227499035ad.3.1756901167713;
        Wed, 03 Sep 2025 05:06:07 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm160905185ad.109.2025.09.03.05.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:07 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v11 1/2] dt-bindings: arm:aspeed add Meta Ventura board
Date: Wed,  3 Sep 2025 20:05:59 +0800
Message-ID: <20250903120600.632041-2-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903120600.632041-1-pkleequanta@gmail.com>
References: <20250903120600.632041-1-pkleequanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new compatibles used on Meta Ventura.

Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..1eecb4b69fe6 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -91,6 +91,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
-- 
2.43.0


