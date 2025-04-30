Return-Path: <linux-kernel+bounces-627170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4C6AA4CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 15:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203791C06E90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4567026159D;
	Wed, 30 Apr 2025 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuIOd1bv"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6E52641EE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746018088; cv=none; b=ggptMHocW27eXf6GL9tcpF4EBHpWs72oTElAQQJbng5YJ1gCICmwogHqVmEGxuskJQ1TWJXA3a7tuBu7JfD6pQc5mtVCKtjt65FnMEZbshNh7sicUSETbYp0j1wXeC8h8mlOg0B6Wthh92fkWRCHkSTPpDpj+m4oa0ydnQNZ4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746018088; c=relaxed/simple;
	bh=YdAJ+TcRpnByJCx5xiQcsqNp2ElrCHTYvszAfZ5/598=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=klT50+Vspu+Q7e8r3zcC06ZY52gYzeHZV6KVlqV9Uxikve7mKEO/byidI/It26wzf9pq4RDZiQ1T3OCrI6xtcPL8f/PsMU89C1NHGPFSDkWyWH1s4sFwUcvATKVYmGU4aq2N2sE6ye6vIlEzxXCdLSM8q5S24pfLqs9HGPz6wQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EuIOd1bv; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912a28e629so248871f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746018085; x=1746622885; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G56fwlkHV3KB/OxnW7J+564mnIXMTid8vWYCOTPTaNw=;
        b=EuIOd1bvjNs5hVfoTgEBVrVKtU5NqWJMptpU2Dq282/3S9c3ytk3jwPLEEI5ThoIjq
         FE3HKgWtOY5ms8foNFSRU5ylxEx/tlJG8IgGf6/oRmQ8C9K5UDzO8lyrQdBjo507Wrh6
         0LZ5MraqnaZPKSdcSCbyhRT/T7earm55eMn20GXzuKUNxIOM18ZOqnoiQkIVaIe8llz+
         McvM5ZUvMd4D+u6SZMhIwmEdAAt8Me/8emdmfDyszWKP2ozOMmh9GC8kwhDFmYBCZfsI
         q278Ib+nN7c4hS4QCPTGfO5KPGWL+aeiLtF+YjTmKkXkkQlQWMlxPYCrwOAt9JBjDvGt
         7ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746018085; x=1746622885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G56fwlkHV3KB/OxnW7J+564mnIXMTid8vWYCOTPTaNw=;
        b=k2TE2GF1WvytF1wiR7uPxWYNe5g9soLSYYKIHsaKnefKLSesUeNkT2RmvwFvgJAuno
         EHw4a40TEz/6e/bVHK45msGklM/8rqFIMACdFpclEExWcnO+sVNwJaGYkjHFdf3Tztaq
         Bymg2B6eyyZxxE+g0OUGhKPzsX0sJ5nmjTAXoapOxHY2yoHnsrKYSZHCd/D9+et6aTf1
         iE+Ukgd4XEmoCA2WyxxUkXofgW8sDG4BLoBUc7gw17upILvsqD7ERIhb/Fsm9vrEfFNm
         N/nT/7CiSTLgw938+hHFxcCH8Iclw4WDf4AkI+Fr9/gHIx4WkUAgRBwTMDF1rE6F8jit
         rmLg==
X-Forwarded-Encrypted: i=1; AJvYcCUMkRSJabdOVLdU1mWRHNsRm1O2L+oyz2BHsE5E+/Z0asZlCXrYTNKjvv3NNdH1T+NJvJ94QICjXtuxqgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/Ste0E57BsB5yl7yu1g9nBUIjocV9UZB2A3Ic0YUYCE3OMSM
	toHs1Ub/2ETG+0YTpDNILr7+6OiqebE/zz9E2f/asqAxngld5Rm0LSIYg8k66No=
X-Gm-Gg: ASbGncvXY8igGdJUptTZFFUzHeMfEHQaC+9yvYwWaaae8+JLTPdg1l2cJWjKiWlCFGC
	cY2LlEz3peLWAPYrv70XuDwlkeHj03R4b3mbn6t2IdiUSFlF1VB2VDP9WmCZr4m7WRUGUxaA3ex
	DnWztq9TaE5FTfgP2FmSBM0WZ8hjX7nGUHeb0a4aMikyxjeY1jHtkNqdnL4OwZESCouBLa59DA5
	ToqPzGWzzjzo/DKR/T9SZHitMLpDTyLWpsPcLGExVdy1NuggAMvo6Btl8C2XVIKUTIkucwqkuW9
	ufcohrz8BdV431iatonVzrCeUu/yoV1E+bPR6iP6H5fSFyCZTo+DWnUg2Bc=
X-Google-Smtp-Source: AGHT+IEoUWvGWdL9QLslZg4nZPiix459pQUseyRqOjqhSJlygn4i1XIERDQ0eUIfPQB7sDh5Lq2NvA==
X-Received: by 2002:a5d:64ee:0:b0:39f:6ca:9250 with SMTP id ffacd0b85a97d-3a09007e507mr674654f8f.12.1746018084811;
        Wed, 30 Apr 2025 06:01:24 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e46c23sm16884043f8f.75.2025.04.30.06.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 06:01:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 30 Apr 2025 15:00:38 +0200
Subject: [PATCH v5 08/24] drm/msm/dpu: Clear CTL_FETCH_PIPE_ACTIVE on mixer
 reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-b4-sm8750-display-v5-8-8cab30c3e4df@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YdAJ+TcRpnByJCx5xiQcsqNp2ElrCHTYvszAfZ5/598=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoEh77fqKbDLgkpf1pdvLC6OrR5UmskUxgpr1w6
 ExjZa7J1ZyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaBIe+wAKCRDBN2bmhouD
 11bZEACazt698BtzY7JCNzUsIlW64/Sx7aQfTkM3ztdREfsCw4cVo24ndllWjXlrx1Ih5q22LI2
 470OmDJTJxPIClvhUKyi6s8NaN+8m07nbsw2DydjvyhT7NFVPacTANyn26TFJhIjyesjGmBzPk7
 hgDeLKcN+y3V/6girVQptB3xkDjhtHnIHvpyjsOk4EHMgHzp/pGrll+5Pwqk7geXlhCm+NFI76+
 KmEhoQxgfu1sO8WWnQ4RidUAMiuLQmDohPCJ2G6qmFLKS0UXld3RNaJ+ScawoUrrabOslBklLHL
 U+TXi0SqB3LE0sWFcmVyYZkNE0GP1x7SvXV7eFUyoNsX05equ3bbOYaQTT/DSZon5JnNbeT+qjW
 TPwf9AJDZUwzL38DZpmV4GZS0mwVz0nalTFxZ1c/bY+LlNvUFTa5esST25GBMVLE1KjTH/uxvjc
 zD8N3ZwtimgoC+zKIamSZzvzQ3d15FT77R7+wjIFAUAh4ZpYShJdmiPq1/gfTKZtd9qvqmnQ/F7
 CuJeAn0OorANzAeCgxFgoyDO9oGMD2vLcXAtaQqHMn3gYAkqfz0nyNrHrbaha9Bninc2LAT8TAR
 FAoVfDiOscP6sAAGYWEH1Qbz0gykWGGZpN1KQIJVjBh33kq0wa2KQKm3tv4hFBwQzhUi+vLaf8H
 pRjnfn5TctiTeiw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Resetting mixers should also include resetting active fetch pipes.

Fixes: ae4d721ce100 ("drm/msm/dpu: add an API to reset the encoder related hw blocks")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v3:
1. New patch, split from previous big DPU v12.0.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 862e9e6bf0a5522d3877cbb4b9dfa385d6ab64e5..3d4000611656f2d3173aac27891a51402f68ddf3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2190,6 +2190,9 @@ static void dpu_encoder_helper_reset_mixers(struct dpu_encoder_phys *phys_enc)
 		/* clear all blendstages */
 		if (ctl->ops.setup_blendstage)
 			ctl->ops.setup_blendstage(ctl, hw_mixer[i]->idx, NULL);
+
+		if (ctl->ops.set_active_fetch_pipes)
+			ctl->ops.set_active_fetch_pipes(ctl, NULL);
 	}
 }
 

-- 
2.45.2


