Return-Path: <linux-kernel+bounces-852587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB8BD966B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59E933547ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352B1314A74;
	Tue, 14 Oct 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jTtX8568"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A023148D4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445598; cv=none; b=J19QDcVCkJPb6kJOQDcjjvboycwH67bYpsMq46GZEpE4v+Gjm4lFaEjYHpr5xTWxE821jBUEzp0/MgFSTxe/H3/ne+DTLhwTJWpwVWaUwwUcLJHwDCydBjpnob/9D3bOzrDKES4dtnaGdr/5pqkY4XuefrJX6y8lrhdLp14Essw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445598; c=relaxed/simple;
	bh=m/Ryf+3/Ba7bj8cfGk0q+ZCXj08lxgpxWe3j8JBvzwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d17IMxOPzGaoDBNEcNXtzzSCxkGYMzL8q9WAf52lDbFf53l3ZY+yLo4wTmZChFKLJekb2Ke07yS5nQANh4ek1qURzG9QYZK+9Qk7xVtgbyB7DCx56y1SUJ/9xPfQHKde3uNigSv/J8KMqrMzWEUh6vbvOaGCDzQLIsD9PRAdDKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jTtX8568; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so34162115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760445595; x=1761050395; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AqsKQ8///0zondjUQyLirrRSCHthDErDWugJZ18wpKg=;
        b=jTtX8568FMMcLM+uNfA5rNmnbFr743xZ4UOPJpmHipXlreBFwrScRGZCgMvOX9a0vT
         xxn5X0124Xa+abeDVK/sIamJdFAlmpAuCWipfyborP+PjJGZMDtDfT4eASqRn/Z394sr
         G2tvVJkHGVMN/ztRlqM7E9KWiMqcKQlFhWk7MN+ehnNKnN7UkYg7pxxY74y4xhr+EGoy
         ghze/qr0vK8FHZAnZU+3KBS5ZohAo2sPPlbtX8xJRJB5wNqNQmvhsFBxmuIYNfXdQRFc
         KdhwEeaztJj+z8xlf9gjzbUEYVeWS72Aswnwwu8PA3U9uzq1peobLUSwusA71FYjE7Va
         Dl7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760445595; x=1761050395;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqsKQ8///0zondjUQyLirrRSCHthDErDWugJZ18wpKg=;
        b=Oq7TV8Cxwq5ZUxi09DqWCnBKJl5iSKRqbFM4bNQnUTAQ5XWf/Qa7qUjtMoyrVhWFvT
         MXzZTRbFtLZfvEAdyYn4SFInQ60EtZakg4q8FPjvd2vS+Cn6gr4uklERK1liuiS5MfwI
         y9KP9aWP3nlmvy3+Wirtjk3SysbtXriqoGK6EQcDnknd76uU8K06h3FyR+Dc6gDNMhRf
         MgNqs7xI8d+4KDisfBCSEOvAjrADCIh/4RN1eX5muhqLkfmttdIHhhjFNtL631D/W5eF
         FomRe5w86Cb/en6iNLqPYGtF8ixY7w3YxH7q/3W7vDsm5pjgDI4qKaVlr3KGVzyXT4oC
         c5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXYRaXaDYTriniZkWOLkxp+wj/gxme7VE2hTjM5YIEfI69hs1DedEULnN21yU0lgLL+8ORvvDotE6D4EZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYW99MyiLyNuzb86aYE/OhWz82hlw0iJXyd8qoDka80tbq+z4
	1VFDElco0i5c8yY/0/ByTgKN0eCw6jxOlABZP5Q1BR423lUd9/fVTM9ZmkB9kIRKgMA=
X-Gm-Gg: ASbGncvZsVf+oo30TkP76EktSra5M/XQeEZTBfRKPfkBW3lZx2gv+mFAeLYLc+d0Uj9
	GArKgU/QZFzhMTMwErUnZiZTB0ETNWGsN7CWuw1Mxhkrd0HeNHcu7ZkKj58GI4jwBL3irp84phs
	Q+dhPRrrNUzIZ/O42pMIKlZOaAZ4wTRC7ID++noyLbTtQfu1LoKfCRUVm+4+QhzfJFOEAmWTl8M
	TdLaE2/9DRBRswd6TLfpgowZ18Sv0F+Ddd/ipu9LYl4XOvejq64obpn64aO5yi+BkCl7Wl3BWvv
	BLaI69V+hvm4QH1s2/nMjMoaZdi5ljG5zeAl3uQOQHv1r6XjYsHWM7uscQ6cqq4m3p8VLZ/gqko
	/VFOog5qQXPwhGON0z9L655ytrMGHMAHB6WGovqZMml4=
X-Google-Smtp-Source: AGHT+IF94TkmrblUuMOmKKw3sDw0waUXWJ6Sn72cPvNn8ob8Njw4rB13rXYCle6cWXXhQ2X4WSqt1g==
X-Received: by 2002:a05:600c:1547:b0:46f:c4a1:1da4 with SMTP id 5b1f17b1804b1-46fc4a11f37mr63636725e9.8.1760445594948;
        Tue, 14 Oct 2025 05:39:54 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9easm245813815e9.1.2025.10.14.05.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 05:39:53 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 15:38:29 +0300
Subject: [PATCH v2 4/7] drm/msm/mdss: Add Glymur device configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-glymur-display-v2-4-ff935e2f88c5@linaro.org>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
In-Reply-To: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=961; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=m/Ryf+3/Ba7bj8cfGk0q+ZCXj08lxgpxWe3j8JBvzwU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7kSC91TA3eE2/FLce9JDXX+AHYC/aYLGbE6qH
 N2iL/WtXQmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO5EggAKCRAbX0TJAJUV
 ViKoD/0Sl157HvmbXuKIHDPa3XoBGzAdukbIe2ps4MXbFV6J6LNYoC90LVs6GeC+xTT6W8KVuIv
 uUJO9EJCnjsYddbeSEzuA1mREDoYnoWyXcX/bTvFKAOCtcDMEOaJ67vfF8Vu8pbCvYjcLJx/OqM
 1o20MDkMgza430gTOYMyqXa2gY5QreP1kdOwC5GM1DJdZmkopVYBYDqW9K/jbsIvpvwWVeq3hYH
 KQkWMON5+SlObVOM9AUBEl7P03csVQ7Yt79Y44WxGFyuO7ZgEw7sLfa7P5TMemoq18YGDh0TLe8
 vD5xP5vsp4mo9OiYbMHHKOHh6YsA89Py0da7gR8FinkIlVMck7F4npyorCRFcoZg6/Dr+SWWNKG
 LBUC/p+34urTE6t/bjsLZDeoj4dRXdb7tehEFrpIIY8Ve7JRvgyKOtSr3NO8VZMA7dHe3HedcgW
 LwfMMyA5Vti+iAQVPyo8cK/S9KNJkDhgthQSEqzPtFj9yMwxUg1GK4/Yq+aRjO8fXpvVQ5n0ZX/
 +ogmfphhy8Tka/TDOGfteQMc/U+GRR7PmxkW/MfKbJ9fIU5eWFrSQ9eqD6LaKnMZdLM2NTPyw03
 tzGCfR7w/wgnuufAzwJIqPydCpqdPc4BqCk1VF47snbP4jmqwMc0gvLsBBsbFOXhjDYmyHwklAF
 AN+FcDKHpISSmHQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add Mobile Display Subsystem (MDSS) support for the Glymur platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2d0e3e784c044db8ac0c478446d211a982cf0350..60bd6af83a8846f2ad751ea625a20e419c80638b 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -553,6 +553,7 @@ static const struct msm_mdss_data data_153k6 = {
 
 static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,mdss", .data = &data_153k6 },
+	{ .compatible = "qcom,glymur-mdss", .data = &data_57k },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,sa8775p-mdss", .data = &data_74k },

-- 
2.48.1


