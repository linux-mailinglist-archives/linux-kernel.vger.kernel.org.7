Return-Path: <linux-kernel+bounces-864097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BB5BF9E59
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E6AD19C5261
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38562D8383;
	Wed, 22 Oct 2025 03:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDFEm7H5"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D16E2D7398
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761105539; cv=none; b=ryjCaD5UUEu/08y3ion1GElonAJVO1dmfhv03mNZB9SmPqOeFUNSxo1dkCNbusIS/QvdbFyTM6n9HB0j5M/EIiJCwsLXCTqKTqSFioxFYUutM+qUST+EVNhQhl5GXs6Q2A2s8grQZSuEh5Dji7ds0WEB4CQJ0pPqSNgNiMOUwy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761105539; c=relaxed/simple;
	bh=kvAMP3ctlHC+NcMNgJAgs9mnDMpwSkggmTJd2ypqC5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYI3cdoCQ7HIVqJhgL+JAbY3slHcisfLFjj8SPzjr9SO3sn3kiQ1PgdC8g/tzDCOaR5FZ/t6FdEni3WwDKbr6BXwfW5LnM/oqr+iKCr+YHtVo9ZGE+UxgbmMnehyJ4TjaYqpXwzOpNy0o2A2Sf0XdTKLr91zonsEZ511s1ltyyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDFEm7H5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4710683a644so4389415e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761105535; x=1761710335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sI4ASgSpPGAj/Dv/E2slB3WMFvZC6o4/Alrjjt2Ie8Y=;
        b=nDFEm7H5XueUDJznN5/7tYnwz3iK0QwrYwOyCuukBji2e7h+pwISx7EVtRQcGRzGpK
         qGr+1VZT5+JVjDICQ86Jp5VGoIa4m1v2y0MqHwxkRcggJs1WXe3YudCe6FCpNKOHMs+l
         pNIKXGr+HpZN8wu9voztnMoQbQ9T8jyDVyjBjbncnvXaVXEJDve6EEstKFp2R8OAH8ap
         OGs1usArY3zL+KquiDXPt2zs1csl+Gipbsygn0cR12SCzc9LuwmkJUPXs0gq5jWKVGQ/
         cabAR+CEG7G8vvPjsLbhM94j2acsrfODW9Bn7NErPK54pfxxDGLnyEvohnUxJRDtFYce
         l+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761105535; x=1761710335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sI4ASgSpPGAj/Dv/E2slB3WMFvZC6o4/Alrjjt2Ie8Y=;
        b=NlItisvsb/zI+/WW5gIiWqX2Oxw4phSUxOQJmqHiG+CM43v4Wk6meVyJiP8f3YzVvF
         j4Pg4vuFJUtgc1r9kK11tBOyuyUI+sVFa2PtmV0QzW7YZ8k/3OhTW7+SSDbXHtyNZY2X
         MUmCq38WxFfsWtlbtKKkrvo81xqqBsMrzv99Sa+0IH0cp61VOqnt4TLIGohpToMqtXts
         KJvCtpnJMAieOMss0hTUw5Pry8PGJb/m73zRVRzVCe46kyh52cB/wRs+4nAqP4mTz4G4
         jkkgr2RPWfVjcaAZmDjurgYokwxVCL6VYERdlFiCD5Cu2ei/vvPwTf5tEwW3YpsFN9S8
         nadA==
X-Forwarded-Encrypted: i=1; AJvYcCXT9/uUVCh9hlbj9Asobvd0pxklWImVaWycH2td0aG1/qSLnifs4ipz/kJRFIZk43eymyecpg0Z6Eb37uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIgn6JYYNQgSWQq85M4wZc0KcppD0vcy8p40Kmre8/yHny2RsS
	WlJ+3RMAMLzw4BdXx9mo3bRxnSQ3R4BVYnGrYZF3d12wua0R4AE/AcCn2Vw6s1YRmWA=
X-Gm-Gg: ASbGncvZ4f9QUXIQtAxHo1NOQ+ZM0hW8VAckabDWk39NKUcQ9FYBAzlN2Ep0o0PnPVl
	uUyrd5xm4IYHifScMKCdxkjUFGrKQyScx9F09CQ4FxP4+4QMjLrkt3XUdWVHh8GoY/r6HO5Mj2V
	JwVSaIINt0UWmxJfdcc/mC4tRc551ySptsnmDb97qvc9hDTnctXf8U9aQ5rp3r/G9dnCO7aW+ld
	Z86g5xH01UTSZb+oUEAPCbpuBAAtNGczeYt+UCxZWUDqcEzQrDIisTY7D62G36gylwQ2xEszW4q
	aSiis3jp9i7jIl6bY3HX/nqQV7lDlBSe/vs7tDaDHBZq91WYqLEpi18KGNxsOk8gCeI7PlBOaq5
	u+bTo/EKbIPiSA+uSIMphY+XmmhEArNVEphuTJNMfWDoJdIG8U75x3xs0iuKi0CTWrqr3uuKDs1
	PpRc465YVG62WRtaKD
X-Google-Smtp-Source: AGHT+IHeEb3tGuV2cdLUPqnynhdT9+HgBOgYCBUb5B0FsyuU5f/KzVMWWrEQeBupy2nAXL/DwGwzPg==
X-Received: by 2002:a05:600c:3505:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-475c3fcb2fbmr12453345e9.11.1761105535320;
        Tue, 21 Oct 2025 20:58:55 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:11f4:2b3f:7c5a:5c10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a6c5sm23637639f8f.28.2025.10.21.20.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 20:58:54 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 22 Oct 2025 04:58:50 +0100
Subject: [PATCH v2 2/2] ASoC: qcom: sm8250: add qrb2210-sndcard compatible
 string
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-qrb2210-qcm2290-sndcard-v2-2-32e9e269a825@linaro.org>
References: <20251022-qrb2210-qcm2290-sndcard-v2-0-32e9e269a825@linaro.org>
In-Reply-To: <20251022-qrb2210-qcm2290-sndcard-v2-0-32e9e269a825@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: b4 0.14.2

Add "qcom,qrb2210-sndcard" to the list of recognizable devices.
Use "qcm2290" as name to let UCM to use it later. QRB2210 RB1
and other QCM2290-based boards can use this sndcard compatible.

Cc: Srinivas Kandagatla <srini@kernel.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index f5b75a06e5bd20e00874f4cd29d1b947ee89d79f..bf71d9e4128873fd956750e71311a357d60099a8 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -210,6 +210,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 static const struct of_device_id snd_sm8250_dt_match[] = {
 	{ .compatible = "fairphone,fp4-sndcard", .data = "sm7225" },
 	{ .compatible = "fairphone,fp5-sndcard", .data = "qcm6490" },
+	{ .compatible = "qcom,qrb2210-sndcard", .data = "qcm2290" },
 	{ .compatible = "qcom,qrb4210-rb2-sndcard", .data = "sm4250" },
 	{ .compatible = "qcom,qrb5165-rb5-sndcard", .data = "sm8250" },
 	{ .compatible = "qcom,sm8250-sndcard", .data = "sm8250" },

-- 
2.47.3


