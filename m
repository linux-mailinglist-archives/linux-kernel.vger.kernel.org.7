Return-Path: <linux-kernel+bounces-723481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50D6AFE75D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250C77AF55B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA229346B;
	Wed,  9 Jul 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="btCO22CM"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02927291C2E
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059605; cv=none; b=NUcAvNljuJW/mEV00NBEs2wqVlcqnUjQmRt6M0UTeajAChOVYftlSl2t1SE6MitnOpjxiJ3dpyUkXjWUeZO/WZOxv8wqTM5LuOmCqw7FBfQRUtYTmQIshZVKmQTR5tx41OD9PDirQ2X267UGTn6CyQqzcrUuNkNas2MTTj0dY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059605; c=relaxed/simple;
	bh=OJvIgyuj5zHbAHydPvWzJJbjCtffTewHwXPSgao+2c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jfpNj6M7+ZUhukPPmXqz7ejPGNzIUlKXtxXHgZOpM3b6AzUfMqlE0hIGOT4WUO0shaqA/Vq4oULNYgwmqfzxRn3zsUg7FwcjFBj+CCEkJ87cQ0G/Y/LrLjb0WilFlfd2Auo/xlQyWRcPhFkXBjM0sMOiAtkmpiXSBa8B8nSm5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=btCO22CM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so1875038a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752059601; x=1752664401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ybiFFUL1Z57/CU2gYjZ2nwMXvOylKu9ZrRdZ3JW//c=;
        b=btCO22CMagTtmaMG9WuvFmAw6yCITeeBGvy+hAwNjZk7oyerHtFDQlDRPn3OYOhl67
         4gSDsgA8A6XROVFfeErtXiDiW0MoBfaQl0ycMx6SIDk5B7fSfIlgXDOzl4J+8irQlMGc
         MJvvJ0jqhXNou1b1aRhg/pn9hh/8iBXfxhEUxgCtmZsLIrAlJfCIuLewXYw0UyD+RRGs
         1xNqMThcnQ1SZPazZzsh+5B353cw1RYoYRsCinR6BCoIpg5wQm7THOeetD7NBjog2+eQ
         rDDF78vh8gx89plcv1JBQJlkNqsgeUrkaSdr9dqzAEYn5E+em6A5IU+Ib+lPeulI3V/X
         pTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752059601; x=1752664401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ybiFFUL1Z57/CU2gYjZ2nwMXvOylKu9ZrRdZ3JW//c=;
        b=n7nKq5ncE76baFP2pDdXQRCPTshMD+O2y/84PDA6Ulbsl0QqFKm8Pv96Qyps+UH/SP
         f2uWTk8rjMQc8uE13OgCiv+7OlajqoASXEBld6ENdVkjSW2ZASJ8mOUaESROqvIuCuOU
         qFJoTsybxIg/0htaGjkt5LqkLvFFLOrQ4/LrIJ2QKpL/NnTH9+f3+ubKjjmVCyWoda/O
         xp/ohpjyWYLoQUu23rmxmm4zDY/lDsi/n3tev/JmYpJdJiR8j3KstPB31N7Js2Z8OCzm
         V4iJJwXESmlEsS7nb9ZrGY7HL88nGP68L9nLxz1JEdvyORR0igo2f0mbHIH1A1NNLRLp
         Vulw==
X-Forwarded-Encrypted: i=1; AJvYcCV0HEFgUhJ0AzddGidzfdZBQg6mOGq0p92LOj6rDX6sOFGqBDYz03z0VBGZV+A83HMaR3GmnZgjyDbkSCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbT37BCnvbD6FEzqTaG63uuPw2wM9AgpDj1USP70riK07e08Gc
	ZfRLkCfnPkCabpX63smalvu4pPDIwOeNqujcm23upZhobONldeNIYzW5vA7EFo9lVEg=
X-Gm-Gg: ASbGncuoZlZjL6YPPGDLEbVozHOU+/UX8nWdaqyU3RK8YZ1RDBaLqCnHsBIloCzbU/W
	wPL66ocRUnhJAMWmf765rZE42qlRml5AyioijJOmS/XcyrEJG5rxAnmfZZSGG+E+UslBrEYdNtn
	CdxYwNat4z/xZ4BTK2VUE3hamnQSMVw50OLqMrL/7vR170zOOpbAY8CvMUG4yzjs6iWyJIKR3am
	+IgtotfG2oWvxnxWqTxpkO1LKirOzU8qWdSeCnJRP5A8VNzuRnZw7jnaKNfYvHrJoc/pQoHzmGz
	WNCrc5DREhpsvfcYyoTNF72vi2H6d7h10jOJpR7SS2PqAFMrJuC1gThFYV3kjcIIucGZ3fNKE2k
	Q9CnwQNHkTK1PfiuBW3UjMFLqPYXs51ky
X-Google-Smtp-Source: AGHT+IHXBll9+vo07ZfbksnE8wLMF4LIAQ2GbDeL2E6iTV/VmTgWRYgEkhIVvpcQIDycxaI0d4YQZw==
X-Received: by 2002:a17:907:3f1f:b0:ae4:123a:7fe3 with SMTP id a640c23a62f3a-ae6d142d7ddmr206899766b.20.1752059600885;
        Wed, 09 Jul 2025 04:13:20 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6daed7d49sm27191566b.114.2025.07.09.04.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 04:13:20 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 09 Jul 2025 13:13:08 +0200
Subject: [PATCH v3 2/2] remoteproc: qcom: pas: Add Milos remoteproc support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-sm7635-remoteprocs-v3-2-c943be976180@fairphone.com>
References: <20250709-sm7635-remoteprocs-v3-0-c943be976180@fairphone.com>
In-Reply-To: <20250709-sm7635-remoteprocs-v3-0-c943be976180@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752059598; l=1914;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=OJvIgyuj5zHbAHydPvWzJJbjCtffTewHwXPSgao+2c8=;
 b=lHLNcjCgk/GHlzx8rQbUPfkZQox5Dk1Ek78pJsnh1xN61wmSbZQ27bMq+NZUW2SjHZuhrBEeA
 Y5xdyzw4YQSDQO/3aywFk7RFzDsgE2OuticVijqzXi7+hBnOYC8aZvW
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the different remoteprocs found on the Milos SoC: ADSP, CDSP, MPSS
and WPSS.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b306f223127c452f8f2d85aa0fc98db2d684feae..7cc67ee62a341d56c92bbf2e4222837c0e34cb20 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1261,6 +1261,26 @@ static const struct adsp_data sdx55_mpss_resource = {
 	.ssctl_id = 0x22,
 };
 
+static const struct adsp_data milos_cdsp_resource = {
+	.crash_reason_smem = 601,
+	.firmware_name = "cdsp.mbn",
+	.dtb_firmware_name = "cdsp_dtb.mbn",
+	.pas_id = 18,
+	.dtb_pas_id = 0x25,
+	.minidump_id = 7,
+	.auto_boot = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mx",
+		NULL
+	},
+	.load_state = "cdsp",
+	.ssr_name = "cdsp",
+	.sysmon_name = "cdsp",
+	.ssctl_id = 0x17,
+	.smem_host_id = 5,
+};
+
 static const struct adsp_data sm8450_mpss_resource = {
 	.crash_reason_smem = 421,
 	.firmware_name = "modem.mdt",
@@ -1435,6 +1455,10 @@ static const struct adsp_data sm8750_mpss_resource = {
 };
 
 static const struct of_device_id adsp_of_match[] = {
+	{ .compatible = "qcom,milos-adsp-pas", .data = &sm8550_adsp_resource},
+	{ .compatible = "qcom,milos-cdsp-pas", .data = &milos_cdsp_resource},
+	{ .compatible = "qcom,milos-mpss-pas", .data = &sm8450_mpss_resource},
+	{ .compatible = "qcom,milos-wpss-pas", .data = &sc7280_wpss_resource},
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},

-- 
2.50.0


