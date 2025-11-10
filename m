Return-Path: <linux-kernel+bounces-893789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C7C485E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB61C3B23AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6A2641FC;
	Mon, 10 Nov 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsMUlAY/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6522DAFBE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796027; cv=none; b=fBrBLKIQQqRPJWPRPNjK73arqfgUAKFS6GTnL5+hMTUrQZAwmqUA4XasT3tTtCXVa5u6P+YoHzAyjaRJeAOOOJdVDuI6eGNeUWdskTrOVFqPRoZ2LYtuCeKSdQFyHMK7pgu0/69hO8jq2AFejpQlNroshVpFaMD9ngiqz0LMI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796027; c=relaxed/simple;
	bh=DtKMJowc8zPPK7iC/rmKldEQoigsxp57cIpDSZGk6rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKnttpF/mJ7Y7cuM5NX36VJd47tQA3MSNpvpp5Y/T3olqn6YUgVc0WZ+AIL2oj/qrKHrAdPIYNvlIXNUrUEgbgkcl411pTLbkoeQE+I7tTk+g0mHyE13EKpMnCliy6ikyM8qov8j384q7G1fDuNj8csI7sxHvJEymdo8z5OWcNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsMUlAY/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4777a9aeedaso14121765e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762796022; x=1763400822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWzPWemnSbElAjabzmde4Itt9ehqptnppmUVmOqIRpI=;
        b=AsMUlAY/hzDdJcNbRA+g8fhdi9DayB4GJGOQfRbw6vcCCPW5JShGEQoDEMsIKRaeaf
         g5CkVgPhf3c1RzAPReaKMXQhpnEoty3QFg5nahPOa6rtOPmIFWMeIJ0zJc4NovYb+rZd
         RiJxSrZZclsU5+aRFE364NuciRvCVwmMBNTw6EERA0RKJZUgxQ5Egd9klVTxgX8rZEq7
         2ANxxAYN/2SmEeID2VmiJUiFNtgEnRzygyOK+bc+Q7FBPqk8OHEjyjltk3cJIoP1Gwmp
         Fun62+q64TzzSZk1F8TuuietOOPlfUh8DMGBZlZXymr+qqKEo+myFrfwCRtR6pWtGY9L
         svSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796022; x=1763400822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWzPWemnSbElAjabzmde4Itt9ehqptnppmUVmOqIRpI=;
        b=f0gLHo8Z9atyXl4lhDEYUYLTbHHm0SbU+4RBk7xxlvw0123fH9SFxAyOwCoFnTshQq
         pyQFC7QnA37UIseq8sjpL/DqGlQwxXXT7sJ5AywbavJN/HHL+Y/BzYPu4nUgYLkDuBbn
         RZ3Jg564U8MeXKQaZgb4dfnxPUgsDqkP/4fm1ve5yJgaAvqwm5xdUdKXSOAS8mUtya14
         ZnxsZbV3kWUbI1yqqkSsbHhlApPG6JvD8kdsNVBbfg35GMN0kGfmOGznofIwxi3FarUr
         nDU1hvQvW/mbL/C2ao/+PPRqK1qeDFYGInIfDK6ZY009c3JPxbntwhoETnNqQKXa872W
         tq0Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9O9sc7OUOzXDPy5AiUStGsHgESIlOq8mbqKzuH0EP/kvDISiqYLB0YZXHURUeMETAAQyDMr2rsO+1gCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+MukzgX7vcITgQBWq7UdKub3IVM4Ps0jDcpx4XPdp4z3wqBG0
	ZPUxD8GNu22o7SdhUJEul7MRvx3FzrbKKmS3HHzSwQDOK9hNZZTHb/sIejAX9H4svFE=
X-Gm-Gg: ASbGncv4MS+ISiwGSNdkSicY9YX81n7pTLfkRSF8pAoT+DRIRhp00LVuDF0a6ucgyti
	jBL3wx6h8z02u16UyFZLCMhZuLea2n88GKp9ttGuN/JAL99/h/sEUdLyR3coBZXTpj8U6lLDX3j
	f88yuU41MMfYD0FJhJ5xYWHXJqstpz+5brUnexVp1PeNOkhHJBGmY8p4WyHTbwT9YSMTUGge/WY
	APUz/cKg5TX6G5I1cLmDY81ercZTIgHME7EDaQcBeQKg2PDEvXNqqckAoVorCae7Q4Vr9Hp/zwp
	frfajnpRaz1ufOOlnysZF6isM58Cu9bjYSOzWAiX9tl5IJXZYZA0Hy21WCHkph+PTjuUff/MpTs
	yB8cLLFmTkMIUytAClIfIUUaiE+suTF0nBPNCEESyZJ/Z5ueQ+DDqx5MwsMp8RaMScDjqlHNTK7
	TpigpFymZK6oO2yO/1IUw=
X-Google-Smtp-Source: AGHT+IFG+zeZs8i0HcOK4EFCqMFXkt25jlhJO9xhRAVgjZV+KV4HEsFl6cEM5lLjaVjHEaqSmZ4BKg==
X-Received: by 2002:a05:600c:530f:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-47773465f2amr89513515e9.7.1762796022324;
        Mon, 10 Nov 2025 09:33:42 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d5ec:666a:8d59:87fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774df2d80sm140111375e9.14.2025.11.10.09.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:33:40 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 4/4 v4] MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver
Date: Mon, 10 Nov 2025 18:33:34 +0100
Message-ID: <20251110173334.234303-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110173334.234303-1-vincent.guittot@linaro.org>
References: <20251110173334.234303-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new entry for S32G PCIe driver.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ddecf1ef3bed..922ebd4787fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3136,6 +3136,15 @@ F:	arch/arm64/boot/dts/freescale/s32g*.dts*
 F:	drivers/pinctrl/nxp/
 F:	drivers/rtc/rtc-s32g.c
 
+ARM/NXP S32G PCIE CONTROLLER DRIVER
+M:	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
+R:	NXP S32 Linux Team <s32@nxp.com>
+L:	imx@lists.linux.dev
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
+F:	drivers/pci/controller/dwc/pcie-nxp-s32g*
+
 ARM/NXP S32G/S32R DWMAC ETHERNET DRIVER
 M:	Jan Petrous <jan.petrous@oss.nxp.com>
 R:	s32@nxp.com
-- 
2.43.0


