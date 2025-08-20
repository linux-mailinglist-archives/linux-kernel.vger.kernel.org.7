Return-Path: <linux-kernel+bounces-778151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182C4B2E1F1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 18:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25DDA24643
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B7E32A3E8;
	Wed, 20 Aug 2025 16:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EytWJOU+"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DD2E4259
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755705767; cv=none; b=PdunrX0zmOqLnVCGIW0KYKskngQOnZRD+LnW3KuHaZOubGx9+3M3sc1/yVEk6BlIYcfsQueW+Dnf7tBStMnQDICCt0uIb5EIoyGT5Gs8Ae8HgAuu7Bm2et/VBw9vr3BdNrMLszbKKQKKtifCzWZ2Q+ORz/06H5/9oTd7db4FXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755705767; c=relaxed/simple;
	bh=+mkqb2Ue7u1YvGacNORI9vgglAhAHZA5EgMtWKI45No=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5pqqv02LZnDNDMaqMtpKCVCiFG9tw3Tc5HKC+nPX/0z34uz5wMom9Rw0/EKY8NCQoVGbxuSzCa1S+Jftwer9X6j8cDE8GhkhcuU1o0Y5AIQU5Lsq5sJtwiUBtR+VKutI6Zo2hZ9CqYz+J5GgRX/p0Hvv7bw3BRx10g+oUwfFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EytWJOU+; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b0990b2so58495e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755705763; x=1756310563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qhuxsj5hUNsmEcvC7TbsLqtTmOhmGuaHA8uQAx721Xg=;
        b=EytWJOU+bQQ8j4GVe5d/aJNc8AMOtNfbvTaFJ61RKvxm1k9M9C58jRDKZAY6zuDsUR
         mzs2ENEd7z0orwjGIj53UV7VkzP5qTcwuWqCkfkdchmJ6pnEzdBoFydwhb47eJHvhO+u
         xNACs0BOC4xpoee6mw7nA9ebO5/8ej6eKw4qi1LuYVfat1zG1k0s5Ls41eNSEN+bGUMp
         jDFlStS9OPQ2CGkDaLlDD59Akt+cXXEiIMMV8wzSkD/7wWQhbYpj1mX5zFEjJOJIeFN5
         kUiFcDNrkcuGixdjBGspNWUf6ojfqOW/Wpa9jMJ6d20cnUyuDaoYb8N91iouzkb6d1X/
         P99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755705763; x=1756310563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qhuxsj5hUNsmEcvC7TbsLqtTmOhmGuaHA8uQAx721Xg=;
        b=SyxY0eGcA/+CUY/nu9FBFsrfgyx8C+EUNVuU9dyPf98O5qyeRXQwg8mpK1PPJtyTt0
         my6a4oNS1wtR7PplDPLr3hwibUcSfaYH2XAuzUPCTEtVyY3IDy8KUZabV8xNKoV++DC3
         rEA8bfOrtc1WwHyUvmdVlUKi3ZErP+0q8Bm45Vn4pZ1s+D1RgvYYysHAkn3btZy0Ghzk
         Te3xOl7za8sUjWHP3FLm0cOdgE26sfR4nV1wJ4CQfvypWfznvjTU2U3tyvXfDv4GEamB
         u90l/lLoUg1pmyaK2ntDKUK8TEHcjUYPrgl+/oM97IojeTxCcRjdS4y6a/Q0PPGXfbld
         n2lg==
X-Forwarded-Encrypted: i=1; AJvYcCVRormG5db9H+mq6PBgqhqJPqAkat3Q1U+zR27mWMoFOrJYQkF3L2HtRYljvW5prWgpfAsEpF0hr9QYeps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuvsh2cAU22IzkC2i2UxfdUXO17YSezWO822LhzGWrtKVuStRd
	V0+gfI7kLBfRI518V/2pUuKgB03O6fWF1y1k/MEDpTOp5a9rEjEnJqYW1+894PuXQ9g=
X-Gm-Gg: ASbGnctpRsluLQ3S0d7hw3dn99mkZwd7GBA1ptsqWTD3UQzIr1gbpvgZMKcHpDnCoaU
	DKIvSNM4LEO9xbEVkPG0k4YAt8TZOeo+LKxuk7PStQqe7zvQDT+7IUJHEokqONUrB2wdKdMrntQ
	YC9I4BgWzrj7qM8sArTWYmoKTIImc/HK+/31zBv7epBZe+qktzJAyiclUvPmfkSNgw8a6mLAOz3
	o2oCAYziq2Fau6fZNJUOFFdPdILd/jjkYaIQDO+GP/r7hYivaRmR7jq2QA/ACbQUGJNkohXMKY6
	3YhPJigRPTyLSzmJwZMIjOrLjN1S/qOHBgoBzWFwTjFZmR4wXPesin6+q4PcDjhHCsNInWCr0Z+
	z7s78IHxkVS8gMuhNAOmndK8Tp2cfZpdUoCebcmmphctM6J4=
X-Google-Smtp-Source: AGHT+IGvG4k/agQ1VYv0xl78frC3MBSWK35BnNz8JnK0jUOga4Or/7FWKiGhMWhFKLnbdgZxkb+pAA==
X-Received: by 2002:a05:600c:8b17:b0:459:ddad:a3bd with SMTP id 5b1f17b1804b1-45b479b331cmr32104145e9.15.1755705762491;
        Wed, 20 Aug 2025 09:02:42 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:f5f2:96b:fcb7:af4b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43956sm8364628f8f.19.2025.08.20.09.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 09:02:42 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 20 Aug 2025 18:02:35 +0200
Subject: [PATCH v2 3/4] remoteproc: qcom_q6v5_pas: Shutdown lite ADSP DTB
 on X1E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-rproc-qcom-q6v5-fixes-v2-3-910b1a3aff71@linaro.org>
References: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
In-Reply-To: <20250820-rproc-qcom-q6v5-fixes-v2-0-910b1a3aff71@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
already the case before, the assignment to "ret" is not used anywhere.

Fixes: 62210f7509e1 ("remoteproc: qcom_q6v5_pas: Unload lite firmware on ADSP")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 02e29171cbbee2d305827365ef7d2241b6eb786b..f3ec5b06261e8bafe8a8d2378b60285d0855674a 100644
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
@@ -226,6 +228,8 @@ static int qcom_pas_load(struct rproc *rproc, const struct firmware *fw)
 
 	if (pas->lite_pas_id)
 		ret = qcom_scm_pas_shutdown(pas->lite_pas_id);
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


