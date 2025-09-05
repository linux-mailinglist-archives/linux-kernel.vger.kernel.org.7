Return-Path: <linux-kernel+bounces-802535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1B1B4537A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D6582A47
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304EE284B42;
	Fri,  5 Sep 2025 09:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="inXntreZ"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB62571CD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065039; cv=none; b=Xz2DgRr/awhMOzNkXPeReLLackoKVJyiy+ITHpvsbSidJ+R/aPruo6f6wvO9l6cgCeCSEwSyIkg53QFgXgUsZQZd9NUjaju7XpWJNR9GgPkaqTMau6L8zlNZPPkhTMIPPoNs2SUZjZzUW/Rp+bUEGIy8oeM5fE8kaAFhVeeXUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065039; c=relaxed/simple;
	bh=w6GDFIJ+X63yvl142zHgW4KfFmPUnPR8J/fwB+G5Rgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MJd/pMvY28oAUHH5QAhtmo9OzmniZgkD+jwRLtl/fGb4RNg/pXtjooJePYX0s02Cjt+Eso+E4E/Cg/qcAXqdQoq2fbGT76MkNuZ4pT3uD7jj2nuG9MfeVzUs7FMGEkT+V6d5EUYUMn7z68aLxUmQYgYbrAppAkoqgQiYHdYRS2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=inXntreZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b0415e03e25so280839566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1757065034; x=1757669834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI/TqVlWRD+p2wdRTf7lXSCZ6jSplSGXljjBzdG21/U=;
        b=inXntreZnoSm7MxD/KOtYT/M1mQBi0KWWpSAdg97YufFoYgr2k5/YlTh9ZfCiXwEZQ
         JAXT8b0YMJtG4e4zPn8im6YNN7/pUsWqejmK5EUN9jyFJpTjqbLErUB7aBq6CW0E0qnu
         qzuW5Cl34k3XMIfnMfQ3ey+L69fzzUm/MhZx5dgMjm5Rxmi7ziRHtzlTTbTeapveyCqv
         Cf8KKXxkwTkOlng52zAZL7mHkrpiEG2CEVu/HRKmkMK4yja8Woawh44+R1IfB93DpKLl
         BLJlGVZk0RtbU6WNGt/vcEjZRhFAZie4lynHGjSyBVcqI760xalwFYNvqKjXUR04H3vI
         aGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065034; x=1757669834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI/TqVlWRD+p2wdRTf7lXSCZ6jSplSGXljjBzdG21/U=;
        b=rxhLVK/4seJ9OnNc0LAA9RfmBNzJwbPf000vAviV3U0xSrKUW9XH9DPdEsK88iRGqU
         rrXTkJFuZlc3tb6KeNo82JBe0FMmT5U/YhPFRPkqGxSsHhncEx/lm/yo/PeUV32YLqSV
         vGcJ69qqN/czKslaYu3OV3E1+jhFho2awkAe9yBu1qGVmL8VT8glgMcrFVch5ytAfum9
         jPhiwo39FHjIssHjFrEpHlDnoK+ghSDKBWJwWUaOSBMcy2DP/ohaMcNGxDnG/D2VLcaC
         ELIQcJVm2mmys8j5AVY0fmvBS5AN63KrnH7JKcE9cmDO0vw78thcl2aPjNqG0dMfvY3v
         MAUw==
X-Forwarded-Encrypted: i=1; AJvYcCXaBCBRGOHGBnQVzEFPVQsT4VaHJiwZLpyyaU0BzTMXprm0tTUUhZ4k1nQPzpQmxxmkzFqFpZw9ZbxSvcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJk7A8zG0Q7Mu6dpZS7TES4LvmgOv0U+brT6LGJLY39z1hApna
	IrXZb7RnVvFolO/coOoBYxo2VkeWFALumXQoieWWlRgNhLBQoFrzGuFga0QW8epuM7w=
X-Gm-Gg: ASbGncutcxxbJZG5/VyBFxSTKn4Moh1C5uIbhSb8V8b1DF4CmKupzFsqqIExahYK7X0
	hELa6UfuMyC8wfjZAgeB651Ijb7hB10lwnL6/2wldWw/eWTcZOiap9mHTylIOcrYiGEpSMRIFcO
	Af0kOWU+2JmZY7a9vOM3nsrzEyED1dDsq/9wSgnNLoYQJQTRgfQ9a94vjiiHnECY9Coz1oflGKA
	Lqy3OAPWeYNkzD46iyhNWWwqmH1F/09WkLZi/KoKdMn4rPkggV+jLGn4gzWkb3NQXOJXnI5zwq4
	e6Yye2LeZqB5jd4K0GOEGBFqZEKza0j/3wwD3r4m8P1qQGh4wFC5kUoZjX2TOVYaVwGsOuoEkfp
	ZIJ4QyFAj54cqpEiCoqAX5ZhnrHX+h5zPfboZv8MniLPvy7UqDausbLjj8cksBfgLTUXwdjZrT7
	aCeRCvInMVQx1SEnaMhPQ+xZGqdfzG4w==
X-Google-Smtp-Source: AGHT+IGWzvz7Jd4OjcFPWdH5oL6V/J6WBtEASHEF1I5b9fS5dO04CE1hh46ZiWnFvbAOp5lSYlOmsA==
X-Received: by 2002:a17:907:1c0f:b0:afe:9880:8a9b with SMTP id a640c23a62f3a-b01d8a30e2bmr2250841966b.2.1757065032263;
        Fri, 05 Sep 2025 02:37:12 -0700 (PDT)
Received: from [172.18.170.139] (ip-185-104-138-158.ptr.icomera.net. [185.104.138.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0416842ffasm1361597866b.38.2025.09.05.02.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:37:12 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 05 Sep 2025 11:37:05 +0200
Subject: [PATCH v4 2/2] remoteproc: qcom: pas: Add Milos remoteproc support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-sm7635-remoteprocs-v4-2-9e24febcb246@fairphone.com>
References: <20250905-sm7635-remoteprocs-v4-0-9e24febcb246@fairphone.com>
In-Reply-To: <20250905-sm7635-remoteprocs-v4-0-9e24febcb246@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757065028; l=1934;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=w6GDFIJ+X63yvl142zHgW4KfFmPUnPR8J/fwB+G5Rgc=;
 b=0B8vnxm1AvzPVVeUgAQf02vyF1lJ/7BCN8e1OLXPuvneDRXLt2hKLZh0rYQLIiQjv9b4ySsH1
 mG3q+u1RqC7D8G0AoKe+f0cx1Tj6jej7gUFhxAQnBsqKO3/8nnFmvzi
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
index 55a7da801183d54569452dbb48041fdc52bf9234..be4edd0c3eeefb80d3b25a48f6dfe0b7590bc624 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1255,6 +1255,26 @@ static const struct qcom_pas_data sdx55_mpss_resource = {
 	.ssctl_id = 0x22,
 };
 
+static const struct qcom_pas_data milos_cdsp_resource = {
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
 static const struct qcom_pas_data sm8450_mpss_resource = {
 	.crash_reason_smem = 421,
 	.firmware_name = "modem.mdt",
@@ -1429,6 +1449,10 @@ static const struct qcom_pas_data sm8750_mpss_resource = {
 };
 
 static const struct of_device_id qcom_pas_of_match[] = {
+	{ .compatible = "qcom,milos-adsp-pas", .data = &sm8550_adsp_resource},
+	{ .compatible = "qcom,milos-cdsp-pas", .data = &milos_cdsp_resource},
+	{ .compatible = "qcom,milos-mpss-pas", .data = &sm8450_mpss_resource},
+	{ .compatible = "qcom,milos-wpss-pas", .data = &sc7280_wpss_resource},
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},

-- 
2.51.0


