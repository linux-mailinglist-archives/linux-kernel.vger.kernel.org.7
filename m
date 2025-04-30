Return-Path: <linux-kernel+bounces-627171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F369AA4CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 15:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD75B1C208FC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7562226658E;
	Wed, 30 Apr 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zCMNAmkZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC32264FA4
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018090; cv=none; b=PcWg2pAL/IQZTnngoxdqo97MCg6F8NMepizDp1uA6qFP9TZB4tXEzpfVLeSZSAMTjyhPLQ7L9U/s7s4+bB6lFqSel7z/a3vAsjLEShaFdsafCND6CfX249yxPbZoA7KP3GJd0uScaRKPFbwy0pysqfqk2eKFYXpvdkZlyrcYYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018090; c=relaxed/simple;
	bh=G8kmX8Y5U2x/n9a8DLdAhPn2jAzN7EAn1Qe34LI7dH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WCIMfcSzSB86i5Wj5c7W/4RBVDdM8RuUZip4WEOMCwHqBX/8dyH3XwsbE9Rlmj62W0AcNk+OZZCjWpb5QZs6r7Ljd9zQ+bVy98pazNDkQBy5szJEZz1HIW/+qj/gfy9LW+S8b1EVzyiS1qimwivLQpM95W/xhaQv/uRtFXtgPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zCMNAmkZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf825f46bso5321275e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 06:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746018087; x=1746622887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QuPmvY4YtpBzr55GIjE7Ii7onSO28ODq28OEYBnNado=;
        b=zCMNAmkZNgrSGgD24SOFGoq8HicBwh6dNleHRBEZ2eJ27oh7rSyBTqoeeZp9ICybn/
         jpAPsr6VFFBUbrarfZ3411E5eh2AvcDmGyk2wBtDtAbYq4fmZOu0+J46GSdLs3AUs/mC
         ZSHwni5vBi0jMMcKf5x+x/ZBSBTw9xqYSnWT2ojbRKwFWH6arSpx9wr+mnhH0AW6/Bax
         62VWB/O6lEkPbucBbajPoJgPaeLJdv2kcljmwSfvZMvbd0f4w6e0s2ZhSgaHDwpgP5up
         TySn1jkkAvkY1I1PirnISXr7tzX8FVc3CL62Ka2AOF6auZ7/qnJg8TGR4jJaZnzbHkBf
         5lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746018087; x=1746622887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuPmvY4YtpBzr55GIjE7Ii7onSO28ODq28OEYBnNado=;
        b=P0T2zNm2hcbtHQ13cTnVX1mwe8CQaUyGroX73AZtHZ9fidBGZCRWZyc2goNNu9xwdH
         Vm9+OiqnkUv7Saa9ZroBS+vm+VuCaMiv9DNkqUuGj7vo5vqfWzaMCfPF1XrApkJWLmxt
         scbCpN/dbey5rUZz25BmKxiH1elFJzTsUl5FDjDYp1V/VeSst7BXRRBQjfK7HKCw4KRv
         7F0hgxDreUBNg+mrIrw8/ETIYrpZazeDFmkDVGhRsA5OR6VGb7s7LcHHBok4pc83FRIy
         Yppa0YuePPZqos94yWPbfCWC5k7LIpP8E+Y5pAM9fOjDlpEgW8SdGIVRSwPlif90+poI
         EkdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXDFeLK3agoTMMtWXgIfsZzegXvbOaLRN5MwMTxsneIsR9zftmxMimAEeqmabKteP149Dy78MVusJr6iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqJwRSPeMonyhCP6LoAwBO+4OAr7A0hs3x9naq8ZQLzfxaPBx
	wMtS6iWCrjNFrXwb5Rm3r/ktEzkb7/nq1lV1sugSuy1Ytd6frj+Dv3FoEYwsMYU=
X-Gm-Gg: ASbGncvaptWvbr9/tq4XKNDJKmOwWw1InKKoFuhKsqgJjgwO2F0UOkY2CuutjkpRS/2
	bNjetQD6DmuoRQPtVjKOHVsd/iVs3JtxmNFVNfLhGkaQ6BIGImQbQpNZY/yp+3SArggUgDRPPAp
	sfD/CyyLsqQKDnZRRRoRgi2b8E81YyBboyCQXJMau80pPw+YQe0Z++oZz1eh9wxjyZ60GnQbu0E
	TRvHTBe0ydSXkYBBpo9x4v6K/ArpiCHgPBjep6vqsV/EZHEXdUnSadf2uBsIC/sGCyAAn2Imc/W
	94hEofKtRo/S5+fGcGDUMdIbluGAVIbCVDIs7r6/+S6FxULNTDoDjvfj2oc=
X-Google-Smtp-Source: AGHT+IFPVxwiNivZ++TjpjGT/qAxP8FXep/7/i0J8h9qywNJGxNKdY1zAQHo3HdDyksPAyOWHH3yvA==
X-Received: by 2002:a05:600c:c13:b0:439:930a:58a6 with SMTP id 5b1f17b1804b1-441b2dfb921mr8737165e9.8.1746018086893;
        Wed, 30 Apr 2025 06:01:26 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46c23sm16884043f8f.75.2025.04.30.06.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 06:01:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 30 Apr 2025 15:00:39 +0200
Subject: [PATCH v5 09/24] drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE on
 ctl_path reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-b4-sm8750-display-v5-9-8cab30c3e4df@linaro.org>
References: <20250430-b4-sm8750-display-v5-0-8cab30c3e4df@linaro.org>
In-Reply-To: <20250430-b4-sm8750-display-v5-0-8cab30c3e4df@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rob Clark <robdclark@chromium.org>, linux-clk@vger.kernel.org, 
 Srinivas Kandagatla <srini@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=G8kmX8Y5U2x/n9a8DLdAhPn2jAzN7EAn1Qe34LI7dH4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoEh792Pz0KYs8YKt7eNeX9TYrgL/EYhGrTrub+
 fTICCKbYKSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBIe/QAKCRDBN2bmhouD
 15LbD/9Y8AOMIcZjZBqfuPxEhFacejPrHDDKuGuPISxVw+vzdzTLLAsrUqWP8kK55wYBJSssS7D
 4nM+atPnpj1bfCPwkQUfWH8U+Ymng8bArXT6NYxHHbiW3h7aOX8FB9BvOnzUloULBfvVHgMqxr8
 V23OHZE/6cmctYtCaASrioHqKAg6Gf/4QxTsWJ2JQx9HWIVJp99FeUdUpv8hvD2+YXCGGceFALI
 ABGlmc0CbViyM+Ce/d5qUkEcyOcnT+UD1QWRCOvlXPsa+XNNxfSsI8/z/+uJM9RE5k0wjGLfm7y
 /JYuIiiSf0N9lw+p/Yf36psCUEcG0dzM/tXvELj85XmxUJv2Dx3DA4hqRf2lcN+hTmag6wfsqVh
 E4pR90DsRfPzVfmkIyDWQiKGkkFcyIFkOlwMRrNn+qpOh44eT3TIvucC7HMtzGaQoY7A6Ok7gaZ
 0hRiQRCtKoQnT2P0vddJ9dIvPoyZhQUNr1qfTrCdEz9IDo1Jub3PWXvGMmq9mxpc7D76JJb+VKC
 Y9OOKxiAaMqppw4qaFl92Qn7TicvFA4RJws2csx0KbEFWdkGIn5jK8ECY/6Rkd0l3ciWTu7zYt8
 HpUolzVlchWGRLQT3v7e+8uFviK/0phNgQeA4R/bYuNEygiBs/oXCuHJO8isv6o2rouptS0tOHW
 cLMU7b5tUW64IBg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Resetting entire CTL path should also include resetting active fetch
pipes.

Fixes: e1a950eec256 ("drm/msm/dpu: add reset_intf_cfg operation for dpu_hw_ctl")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
1. New patch, split from previous big DPU v12.0.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index 951d5dccab6faf34a519d06683514aea1ee6ef60..2ce59ba50ffa0d14eaa07e993fadf0f218390ef1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -667,6 +667,9 @@ static void dpu_hw_ctl_reset_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 
 	dpu_hw_ctl_clear_all_blendstages(ctx);
 
+	if (ctx->ops.set_active_fetch_pipes)
+		ctx->ops.set_active_fetch_pipes(ctx, NULL);
+
 	if (cfg->intf) {
 		intf_active = DPU_REG_READ(c, CTL_INTF_ACTIVE);
 		intf_active &= ~BIT(cfg->intf - INTF_0);

-- 
2.45.2


