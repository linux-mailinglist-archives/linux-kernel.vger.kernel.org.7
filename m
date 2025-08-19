Return-Path: <linux-kernel+bounces-775500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C30F6B2BFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBDF685EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CDF32A3E0;
	Tue, 19 Aug 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImeXTpZf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624F326D4E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601707; cv=none; b=XygflqTg6L4Ymv4n9tmdEAJfO5bXt9telo5urP6nSMQVTHNIy5mMb/UT3d+vBeu5ueAXjBzmoEBrkvvgWbqYVC3XkzmADzJm+5ydtDO5nnkcQWqLy83SRppCahB4PJKYir1ez7/ZfzsZ9lQjdMYNADZwzuX6FHgF6DeZ+tcxDAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601707; c=relaxed/simple;
	bh=5Cm91oSUyXHyy6yreXV4rGUm1byh8yAeFEZWmdl7qEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8Nko3TqUtrlHi/YRXupNADGFuw4YsB1f1cwZxJ5/XOW/nFhyTL8gUkpgCVfJFILN9Vx357QWRYsR9qcbH83/U2A23FU4IvQ3xK2zRg/Fz2nC+XqYJKx7tKuFAqVaZTaCdJ/17BWkagJFFwTmBxUPEd5BKIE5fbn2QzchMgHV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ImeXTpZf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78c66dcso725587266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 04:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755601704; x=1756206504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpDAKcv7fLih20nGtOlLdXsRYm0EQxxtEuxIHxz2kTE=;
        b=ImeXTpZfjkqV5CVBFpw92I8cX7kNOI6rR4SgQgh9FU6T6HCl0HVkG0WABHME1bIr26
         4WD7ijmXA/DQmwcHkp3I0Yea4Slfle96l6nbhhPOaGYdFGgyCdufiO+X+libA7uBBnqP
         Wxer5K0+RG0HjlNbJxV17NO/7+f+MrTLwCiIHFJtp1EgV06v/XRP9QCVDsGqKORDyWEH
         FP+2L8EFsi3+Zd8j913MDWktbR3mslk7pgmhaX/seHe1hwbEeKDXSheEKI8V4ooVar1j
         69D2DphTA5o2KKeVoLa7TtWen6FFh2VqJkQsAmonjbFBnO28V4fxIUMLq3oXE/CrbtZJ
         vENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755601704; x=1756206504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DpDAKcv7fLih20nGtOlLdXsRYm0EQxxtEuxIHxz2kTE=;
        b=juX3za35fGBh4s/T8iRmtSOi3bXx7otTL82m6937+i1qWwnp2QgcS/LZCVQuW/ajNR
         KFIo64T40lUPEunfA78fzuoZgHXQ22Mj2lsOmaf1ek+4Ieg8/4cxaLVzVDy6HEoo5qsn
         mik9A663ymNlNvmN7v3VrY7nJvrEpvcG1fJqqdkQxq9La517bNocbwjAcrQx+h45PqQl
         6aAIG/wxwz86uzgojMpgtHxNH+tvEf2lWlOH5GaVAK283AunsFCu9yVXM35TeR5Lux0V
         2Js1vxJGFKoKgLDAthhp4IByC+mYe3d7FZTY51EN1SqlenRBAsszEDaUTMRhipdLyJXH
         ZWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrFZesZ7DKiyA2jycUoTUbrPxtisgbuAERdQ2DGHlq2/raGcPQZUwLFAJFQIN+AAc+mKvt1K3ZuTCU9Xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85WT7a8SD/WaXEKjCS86QuZ+NV0MGmgDjSoF896bltJm/xcF+
	Mue3VIfKprFgL/H96tZf6eBwfx6+TTHwcD6rxvZvh/Jose7dq1naDuNPcxb3Tz/QuWE=
X-Gm-Gg: ASbGnct1LW7Qm0blA+3iMwOvMYShdlgmIhkIrwfkUl/UC1d9KMaZoRP9oanuXQzJpwj
	xrpzLuQCdw44y9P0q4T6eD8uMqZpql8NVVmhBwQHCciOZ9qprKIv942Lwxs5w6RTRCOfmBJoEcj
	OgFi0vZzIvVgPofSBG6aoj4oiWhOiVBD7iUxwaSI2LTBAlfJ7IzAckjJcqCoM8hFDfiQVyM1O/j
	u2gFiFhnXyNT53sGzRgDml9KvdPMjNsTgF9dGw0wPar0+2AsLuyvF4lX6u7A/iEjPqvvJNxcA+Z
	ZGtB+YQ5/Axu9kRLlXV2HqSL93L/oIUPSQ20WuoyY2zsy24pPYf9gz0lJ9/jWHm8nxOn2dYG81l
	egiqfJESC9LDWpxOt5P4dIkPkt0BfjTuO2BgElfP78uZIgyFM
X-Google-Smtp-Source: AGHT+IH9vzrOOzeP1dBM4pFoF33YFeXNtK3jHXKDBLebjoeZjTOHNNMM/dRMFIrqI+YVvusdLzCH2A==
X-Received: by 2002:a17:907:3da3:b0:ae9:c494:1ade with SMTP id a640c23a62f3a-afddd1c9e57mr200862566b.53.1755601703592;
        Tue, 19 Aug 2025 04:08:23 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:db5f:8096:4609:9b24])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01096csm974845466b.88.2025.08.19.04.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:08:23 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 19 Aug 2025 13:08:04 +0200
Subject: [PATCH 3/3] remoteproc: qcom_q6v5_pas: Shutdown lite ADSP DTB on
 X1E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-rproc-qcom-q6v5-fixes-v1-3-de92198f23c7@linaro.org>
References: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
In-Reply-To: <20250819-rproc-qcom-q6v5-fixes-v1-0-de92198f23c7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2

The ADSP firmware on X1E has separate firmware binaries for the main
firmware and the DTB. The same applies for the "lite" firmware loaded by
the boot firmware.

When preparing to load the new ADSP firmware we shutdown the lite_pas_id
for the main firmware, but we don't shutdown the corresponding lite pas_id
for the DTB. The fact that we're leaving it "running" forever becomes
obvious if you try to reuse (or just access) the memory region used by the
"lite" firmware: The &adsp_boot_mem is accessible, but accessing the
&adsp_boot_dtb_mem results in a crash.

We don't support reusing the memory regions currently, but nevertheless we
should not keep part of the lite firmware running. Fix this by adding the
lite_dtb_pas_id and shutting it down as well.

We don't have a way to detect if the lite firmware is actually running yet,
so ignore the return status of qcom_scm_pas_shutdown() for now. This was
already the case before, the assignment to "ret" was not used anywhere.

Fixes: 62210f7509e1 ("remoteproc: qcom_q6v5_pas: Unload lite firmware on ADSP")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 02e29171cbbee2d305827365ef7d2241b6eb786b..6faedae8d32ef6c3c2071975f2f1e37a9ffd8abe 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -42,6 +42,7 @@ struct qcom_pas_data {
 	int pas_id;
 	int dtb_pas_id;
 	int lite_pas_id;
+	int lite_dtb_pas_id;
 	unsigned int minidump_id;
 	bool auto_boot;
 	bool decrypt_shutdown;
@@ -80,6 +81,7 @@ struct qcom_pas {
 	int pas_id;
 	int dtb_pas_id;
 	int lite_pas_id;
+	int lite_dtb_pas_id;
 	unsigned int minidump_id;
 	int crash_reason_smem;
 	unsigned int smem_host_id;
@@ -225,7 +227,9 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 	pas->firmware = fw;
 
 	if (pas->lite_pas_id)
-		ret = qcom_scm_pas_shutdown(pas->lite_pas_id);
+		qcom_scm_pas_shutdown(pas->lite_pas_id);
+	if (pas->lite_dtb_pas_id)
+		qcom_scm_pas_shutdown(pas->lite_dtb_pas_id);
 
 	if (pas->dtb_pas_id) {
 		ret = request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, pas->dev);
@@ -722,6 +726,7 @@ static int qcom_pas_probe(struct platform_device *pdev)
 	pas->minidump_id = desc->minidump_id;
 	pas->pas_id = desc->pas_id;
 	pas->lite_pas_id = desc->lite_pas_id;
+	pas->lite_dtb_pas_id = desc->lite_dtb_pas_id;
 	pas->info_name = desc->sysmon_name;
 	pas->smem_host_id = desc->smem_host_id;
 	pas->decrypt_shutdown = desc->decrypt_shutdown;
@@ -1085,6 +1090,7 @@ static const struct qcom_pas_data x1e80100_adsp_resource = {
 	.pas_id = 1,
 	.dtb_pas_id = 0x24,
 	.lite_pas_id = 0x1f,
+	.lite_dtb_pas_id = 0x29,
 	.minidump_id = 5,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){

-- 
2.50.1


