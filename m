Return-Path: <linux-kernel+bounces-858688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE0CBEB6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 843DA4E8608
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCA92566D9;
	Fri, 17 Oct 2025 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXC6HAQl"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45614F125
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731273; cv=none; b=uXqc71pQlAfIVwaXvhV3xNr/XiJbHG7h1LXtwOEOPQlsIyL/xYNDS2j3aklR/rhFq2x0kC9I+3Ni6jxl1WZU2Kyz173HoH2cXl4BEdeomOZPIZHz8CcQpUVtpM+WqAEbqIbo+VgPmshDmmxaDNYxNnf4ZNVkTDtF0tXHpyfOymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731273; c=relaxed/simple;
	bh=K2ZJWWVPxcS3Zb+xMa4QB2/1GTr41KU5/gINSseGrdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJ11ReBgQqpR1W0lMoJqmnEkwDMkS2/Ww7cXBqzNYOeROvzZJr0gz2a8OHW1ORfbn0DEQDWeMTzdVqSD0E3e7HeOZ2LdnpyxTUFqjXLwOD9MQLB+pBiPTPGs/ELwmG0cGmB19aKd35r/UVndRag8Dc1rtaXbZqhmOaWsDauDC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bXC6HAQl; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-375ff2b3ba4so24313261fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731270; x=1761336070; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZvamalkucLTXF0UtA58TBlyJrhax3HxRIT0v5R1YbAI=;
        b=bXC6HAQlCEI2dbevg0C4d1K4kgdW6/cSzS0y3dR1/ieHdkFq5QtxOAAEOpqvO4UtcJ
         U12jQRuyu8/p4RvrQxJCk85Ze3b/hPPyExOMTNjhk5Rl7KPZ0SULlHz2ivd8rz2m9IVl
         opyN28g53EtRTqjbpL6+/OsyWkChNkn50I3zDMbNtevJLvra7iSEJ/xmerUoURrSsBBp
         htO7X0w6LhRRoi26YUVv21ydFJvS1eFWoZBNpHrNIJyVO9umC+++Hg1oqaomQhI5vC5j
         EZtY58NdHAGydXX8O0YqXMBahVuyhe8UBEk/bTv8XdFEZJ5UniU3R0HKdCOHlkZFiuPP
         jlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731270; x=1761336070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvamalkucLTXF0UtA58TBlyJrhax3HxRIT0v5R1YbAI=;
        b=Ho5OsFUfWJ4BxSqHgPM05jaSqS4+QWBxYBj03OuXXetQe7fEl2XS1m0OiODF/SvEm2
         ilyyz3pZZma651ULGVp3ajqywMeNqPey+XkYbRbGk1tHqFw5P18y/tiCU93l2j78n5Ov
         gWwxq366IOxXZA4PFPk8FwhP595CO6eq2iO5sdCXDRGx3RgoEVr1qp56OtCTvTCcmEra
         +BhfqSXzo/TGRrQJ4hd/sBWW6rEdQhkFSZzgZ4i0dHuG0dGOn78TU/PE/Ci/0Foh27zX
         OTGsrH2tGEzJpRrh3pekwh86F8Gj7wFtCM0dGUt0ragj83gLf4z1RRPtVkqLLUtj8ma/
         dXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoka6oabb+OHJ+sp9OLP3OhInv8dXeOYBxACH3PNjGWngF9li61UGLTs+XQT+9R39hLqt4K4v7F0xz7Cc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym/8P4CqaQSI8FvQvG8CuYByOjVzvav3KZ+/L865O+tgqDI5Hg
	mgrEjUD6gKRlh/9J1Y4aZIowqqrcNbJfibsiuk2EyRu44gFDlxoj4N+x
X-Gm-Gg: ASbGncvr5u4McxQOieSMRwdC6rIO7OiHThlH0gZD4ZlG8gIJ55YmYx0HWBtZbJJhQJH
	qlZaTEniAH+b972O6SxRYxIjGCyZsLkRY0a5qe6WtWSv8dFeMWhvCBEq0dvyvunJEiTMl7an0oV
	zIavRiJuu8OPsqir8aRVLnCGW6604Si+SF/9Fmu/d9JxBMEYnWip1/6mXH121mSlickEeHnMzdv
	CVExoZvL+O64wJCzJhMcNjJGk4XxJ4KCFzQY7FzUULk28G+wU7PWW4ihvT9up/jp4Mh16KPFAfR
	Rdf2zqeML2kt8jKX3yLHC/2M5mdwcT1fiWpvPB4AtWnoVbo6W/VcpOcNEuzwiMn2sde/toQtJwe
	s3YriucZWfskyb+xURVpLmNl9hkwxe82YFesDj3lo/sKzRUBV9uXfPJFlOHGc/PCOd7jSXpjSTm
	L9jPVFW26NLgrLdmGpMnJ0km/3ZtiGNwwrWnvVsOyl7rZBWosquxOJUDphpiQyxA==
X-Google-Smtp-Source: AGHT+IGGkPzUg9+WLDnfzSVIMAOLQOKXgwa2ttL1tbW7RtbDwguoGHJ6HNdyipMTINLcvQ/30wWafQ==
X-Received: by 2002:a2e:a583:0:b0:35f:246:a751 with SMTP id 38308e7fff4ca-3779781d39emr17282741fa.5.1760731270001;
        Fri, 17 Oct 2025 13:01:10 -0700 (PDT)
Received: from [192.168.1.244] (public-nat-13.vpngate.v4.open.ad.jp. [219.100.37.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921d99bsm1580861fa.22.2025.10.17.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:01:09 -0700 (PDT)
From: Vladimir Lypak <vladimir.lypak@gmail.com>
Date: Fri, 17 Oct 2025 19:58:39 +0000
Subject: [PATCH 5/6] drm/msm/dpu: Require linear modifier for writeback
 framebuffers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-b4-dpu-fixes-v1-5-40ce5993eeb6@gmail.com>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
In-Reply-To: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Kalyan Thota <quic_kalyant@quicinc.com>, 
 Vinod Polimera <quic_vpolimer@quicinc.com>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Vladimir Lypak <vladimir.lypak@gmail.com>
X-Mailer: b4 0.14.2

UBWC-related register configuration for writeback is not implemented in
the driver yet but there aren't any checks for non-linear modifiers in
atomic_check. Thus when compressed framebuffer is attached to writeback
connector it will be filled with linear image data. This patch forbids
non-linear modifiers for writeback framebuffers until UBWC support for
writeback is properly implemented.

Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu_writeback.c")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index cd73468e369a93c50303db2a7d4499bcb17be5d1..7545c0293efbd8f7eb34a4ac56f616b7cadae1c0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -72,6 +72,9 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 		DPU_ERROR("invalid fb w=%d, maxlinewidth=%u\n",
 			  fb->width, dpu_wb_conn->maxlinewidth);
 		return -EINVAL;
+	} else if (fb->modifier != DRM_FORMAT_MOD_LINEAR) {
+		DPU_ERROR("unsupported fb modifier:%#llx\n", fb->modifier);
+		return -EINVAL;
 	}
 
 	return drm_atomic_helper_check_wb_connector_state(conn_state->connector, conn_state->state);

-- 
2.51.0


