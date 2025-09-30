Return-Path: <linux-kernel+bounces-837792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4F2BAD31A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4930A19407C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29698303A0C;
	Tue, 30 Sep 2025 14:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="URL3vnWq"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ECF304BB4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242761; cv=none; b=A+vwyC1hK5/FAMYE3EZSXwgpIJdQJo0Ix0K2oZXcPDRijUqPnsu0QCtq0u3DoRA6FltbiotJO7sVZADLYL0GQ2s1wzgoZafYp/mgVH2Bog/yCTE9Yyv3ctr/SPxZaK2GcmC/jF61FHds79Qgs8ZVSxQJgC8gmjF/LlTZLtWnsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242761; c=relaxed/simple;
	bh=1Qrepa0d79KDRfqWjvfyl5ebsRzMz7XsX/QwuRAgnRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQIEFqeuCmivatuvIfgzdfh9p7iueeb1hWBxWqC/JPJ23uXXRHqtz8fQnpkVzbvUYP0/aeXd765mQonIVUQOVmN5Hs9ZUSTI4gh5yzRgwsetW1eHTBu/qBt5vi6GF6pkQv2C8wf5qYl5xDGUSF/6OWEmbPBB1+MMe9Tb0LqRQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=URL3vnWq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63667e8069aso1521360a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759242757; x=1759847557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nc2qQ87H/zk/puiJyILxc2v8deO0t3zigh08i1yQUkI=;
        b=URL3vnWqSJa11KrtLNIsZ4tUD2DC9q+urIQFwwIVj6MZpFCh8rYo3BOIPszjJzvFAP
         PXuUp1M+z3rhYa4vhSuGF9JGbkDuLtYhsFjmtmDHC6ihnxZ/s9SqZvuhEP7yS/hZVZkr
         IMXW9le3GMbKgspekrAB0BASiwLrqFsWmfkEFzirHHvif7S4rVObzVTmlld14vZFITv3
         AcjAniCcjljFr0x34JwJQMvUN3u4Ba5JbWzVXLYZanaZIyDAJudUx4YsyVJrSPbsAarF
         pTpSAJrnRLmhtiYsvDbTBVYgRFhgoI2FSBNGcn26awSSEKzXi+J2Ln+3SA8boulinESK
         ufoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242757; x=1759847557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc2qQ87H/zk/puiJyILxc2v8deO0t3zigh08i1yQUkI=;
        b=SzTX/2n1buTAMCgI5vkgRrnq94hg8RifSKk9XA6Cg56znJX19eu/1SK2z7dP5J4yM8
         rrSexm2kBmtoztwp9nwpPAvapnCYQdY3eAB5AnrTXPBJ96Vc9aGwwDolspHneMmC3BZY
         6VHTBubdUI5syqNRTYEKCRviHCflemuE6crSRcyse/KDK+9pq0RP9RpXUItPwMI7tEyS
         +bSPQiFMO7ey3G7jwYAxJisFCRBOQcZwFPD8By/ktWVcBoFqU1Qp/lfCGbTvQKc46bOh
         cZTwDZQnPH8KFxbWI7IGKylEuSZzDUOCZrA63XHzhiDvkVBtutwQHOyCzn7ylNS8EoAa
         236w==
X-Forwarded-Encrypted: i=1; AJvYcCULE9AqyfLOAlBrB4X2QZA8ZMmc2EPrToQxVw/ovgLyRuAEkGZmPaHWr8Lw397QuqBkb03qe9lMllwbhD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97iNURHhs8w7FZxcetqfI3Gz4KKIWiqZmPBTkyJtRLkRGKNlp
	ca8dtwKgOlmKlhTU7tCffY48AKqgNm61Y71Yzm2NsOqQM+lFaLwEDuyPaqSFOkDE5TTuX0JO3yR
	N9CrGfSM=
X-Gm-Gg: ASbGncsakYMp9ATWr++sjKCmOKIWhCEk0VvDPr/mPnOWMKgAArjhHVkSAvDPsg4tDeA
	pjUVj7LptTpPtwsyO90n7xJ2UYdMd7xbrCpzbNHrKVQQQsqkP8hs/u/rehCDYdZEQ284iYLEHPj
	hOFm2kTqnwShE5B4JALKxzitF+o+7P4FpVHWA6xGqo8esASlBjp20AdxMiQoSDRNNsvWO5pUfXI
	T5Qv1rdqC+xA85lLXCyf5cbhVoHk4FxnJFKB/5tssNzAe35TZmFRflV+aoAFFtXXFy8Tl1wC7FK
	4N73S0bLAzphdcVwQEEleLPqYrzUw6lxmSmEVQ9OCTQ52EcsaZzLhNQyy1tojh0ZqyozJpV576+
	d3xwQZI61eGJ/1sfT0V16oombWjIw9XFyqhd7VNb5p5tanPL/mDUpCEiFrrei6177uRmmPM1wFd
	TSgDq7RUd3JJV5a1E8ug==
X-Google-Smtp-Source: AGHT+IET9ttI4eeiZng5G1T3bEUZDSD1oiLBh/Po11ld0hjBgN7AzeZt12fBgv2zC3YDhmr21o8uSA==
X-Received: by 2002:a17:906:2987:b0:b3f:3efc:35d5 with SMTP id a640c23a62f3a-b3f3efc3dd4mr601458466b.15.1759242757421;
        Tue, 30 Sep 2025 07:32:37 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3dc2cf61dbsm499858466b.29.2025.09.30.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:32:36 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 30 Sep 2025 16:32:22 +0200
Subject: [PATCH 4/6] arm64: dts: qcom: qcm6490-shift-otter: Enable flash
 LED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-otter-further-bringup-v1-4-7fe66f653900@fairphone.com>
References: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
In-Reply-To: <20250930-otter-further-bringup-v1-0-7fe66f653900@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759242752; l=1003;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=RjIAYSDJ30bwj+KTioQR2VwyMimm7reXWwcHGX1gmD8=;
 b=GpnS8IMJcURHkOIJRLK8EmV/KIk7v8nq402RU4bIIbHmyoe5zj7rVpUSCGp4sh0MMyPGPXoUr
 Ee55HLqiVajAlW4j2Iu+pzNkj3Q9dgNuE9iXm35GVrxhwZjFSOp8/tS
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Casey Connolly <casey.connolly@linaro.org>

Describe the flash LED on this phone.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index ce794ca724db6deb39f7fae47912c3fefe974573..36cc67469615974c193ea3a9db1b2362869d56bb 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -619,6 +619,19 @@ volume_down_default: volume-down-default-state {
 	};
 };
 
+&pm8350c_flash {
+	status = "okay";
+
+	led-0 {
+		function = LED_FUNCTION_FLASH;
+		color = <LED_COLOR_ID_WHITE>;
+		led-sources = <1>, <2>;
+		led-max-microamp = <500000>;
+		flash-max-microamp = <1500000>;
+		flash-max-timeout-us = <1280000>;
+	};
+};
+
 &pmk8350_adc_tm {
 	status = "okay";
 

-- 
2.51.0


