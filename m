Return-Path: <linux-kernel+bounces-858684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8BABEB6B4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C2019C7C60
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 20:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04B72FB970;
	Fri, 17 Oct 2025 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWk658bC"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538532566D9
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731213; cv=none; b=LRuKhwx76x70dSK20/Yx76PWmI57EVcleEBrLrmyHrcJxgiVTEfAVeylmICaa7PmvwduZZTv9Yi2wXawxZ4uuTnXVyxNG5uoIVUniOMkuIp3GsRBaOTk4e/Bmhh/2LLz47ZrPdgf9awvZaR1+S+Mrrp78y4hb9O5MsqmDRwrWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731213; c=relaxed/simple;
	bh=j4CxU22f5f5xHLw6uVxf327bBBJgMniZTot+Nm5mz0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGbEcfRXYL7rKMwhUPma0JLJBx1K7cSZc8zTXhUxjKj9j6eg8awTZ4/p2U2AmRKU60V2UjtGGSnARsfe9ehkrCPPhiHHrRpXOiXTeH8ba37AkWwHGf5aT80mIDpKiD6i5b0FwrAh3CYM6O627TRLnyw+iwuNMpFCHHrrUEiPZDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWk658bC; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-371e4858f74so27128661fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731209; x=1761336009; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FW9/6WAzhrFRAj+VvpEcKL8n1ZBRl0dJtQSc+UHoxRY=;
        b=PWk658bCJ41xt/bpQYGYJxP14/C3q3IWlI2Aghk9fk4E0rV6LdSq258qeIDE+ZIPqR
         dDmweSikgJVmqJ8TlGqDoHWyo8E95BXJ+jmMTSUN8viPWuKo2wxjXrq7KGb3660QiSDv
         A07jIoA3fzlm5RYhozjHnQLtdHYccu8Q8qWtW34V+SxsR+H9wwZluyWH60aH4Lo7UPc0
         ccw9njuy1r0rvsgMSg2SkNmjLjDzdcXJ5XnpBg2KlsvSzQnXGUbONJIQ1aeqlmgefMlo
         9hag2hwQeZYgpJZdiPS869x58sB25Wm4XAQroIxj2c+PF+s8VtSnP5d4lAG0uaIj5T9W
         +eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731209; x=1761336009;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FW9/6WAzhrFRAj+VvpEcKL8n1ZBRl0dJtQSc+UHoxRY=;
        b=Wv1zfPg8YtUmPHj7aQ5QOyXQjod3SStUGE4owTZ5/i54k7i/D/quwBL9IYpg4Pt6nO
         CusQ0Wy7ZA00cSRyBV19MuQ0amM4RCw4ILlLA6PKbn7Ll4e2POpbzWiOAsQ2n3A9jehF
         pqv7FpDOhMfmsTbiY7tB8mUN3Jajk+rE+TvmyQefiAjK5Bw7HTHqzs2bPLO3vOkhGvrM
         bc4arVpvru8wsGZcBUST8m/JlEtGk9wgCSYCuKI3tqCfFw99V9fL29otw31/cB7lQTTB
         5zXrh0tVpS3AZQtuR5sf5qVi2lHT2CFTRd9CY0qtvPOZ04QOkSJBb8U2pYJ9InvGUBkl
         u9+A==
X-Forwarded-Encrypted: i=1; AJvYcCXBSyr3G1mbnCJ+wST0uh52hHpJBnafTVSguQfkV0ZqbrKwSeHqb1DjQGbCenpnH3AArOX/3h5l/az1pD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Y9M1ogqYQY4DjNs7+0bUF5XMdXSH0IWXOX1SeVj8BUPHvP1E
	yLkqmeH5u55r3QVLep1QWMMo5f5HaDVJsmnchUwT6RGhycKre7U32xNc
X-Gm-Gg: ASbGncsC8vjcmUhTYZ1jFwZVU+I+a9Le0q7B04djgBYtExg8OKcywpsXmOQanWc+u7u
	uC/IfAGejlQwgtp8xAeXYP1WiWjrSP2koOizqv6Q8j3cQ0oJigK0djRqbv0UXP28FW82Um3k30b
	/1ursavW7B5/kapMn9UPBMLOBFZ7P4sXqda+f3vxT5Av18xkb4QYygJTwwKDN7mKvTLeG4beJeV
	LKVSxKx48tOypwCaxnSe8l5e/ZKAoS7vlz5jX2h9c86I2P+MQycml05Az2GWi+S9IMtib6KqiKZ
	lOA825EbJcfO7tjLEUPVFnT9Cw0jd8yTg8ejIvkU5k75ZPmuzURYcNhY36pzejg1/iOZcag/9Zc
	JGKj29XT0HGNaze+zOe//XyBMb+d3aQIidqbtTxyDyAq81EM/uusrCRplRYGVUSWIm8QvPxS4c1
	z/s9ekvJoq5blBEu4Ax6N80CzKtd5iwEpkm/DRSoNSabT2amd776+p/6TkQfIMBA==
X-Google-Smtp-Source: AGHT+IEQgaJHNjNCzev2AElmYZvm0Ji4cjMgDetLxA+1NUJ+RNTYtKrBYXG44qqxgaS1GwNzvFxAkw==
X-Received: by 2002:a05:651c:4353:20b0:377:991f:c1bc with SMTP id 38308e7fff4ca-377991fc573mr13307731fa.5.1760731209147;
        Fri, 17 Oct 2025 13:00:09 -0700 (PDT)
Received: from [192.168.1.244] (public-nat-13.vpngate.v4.open.ad.jp. [219.100.37.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921d99bsm1580861fa.22.2025.10.17.12.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:00:08 -0700 (PDT)
From: Vladimir Lypak <vladimir.lypak@gmail.com>
Date: Fri, 17 Oct 2025 19:58:35 +0000
Subject: [PATCH 1/6] drm/msm/dpu: Fix allocation of RGB SSPPs without
 scaling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-b4-dpu-fixes-v1-1-40ce5993eeb6@gmail.com>
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

Due to condition in dpu_rm_reserve_sspp, RGB SSPPs are only tried when
scaling is requested, which prevents those SSPPs from being reserved if
we don't need scaling at all. Instead we should check if YUV support is
requested, since scaling on RGB SSPPs is optional and is not implemented
in driver yet.

Fixes: 774bcfb73176 ("drm/msm/dpu: add support for virtual planes")
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 2c77c74fac0fda649da8ce19b7b3c6cb32b9535c..d9c3b0a1d0914a47f86ac9a854fbcede021e73cb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -842,7 +842,7 @@ struct dpu_hw_sspp *dpu_rm_reserve_sspp(struct dpu_rm *rm,
 
 	if (!reqs->scale && !reqs->yuv)
 		hw_sspp = dpu_rm_try_sspp(rm, global_state, crtc, reqs, SSPP_TYPE_DMA);
-	if (!hw_sspp && reqs->scale)
+	if (!hw_sspp && !reqs->yuv)
 		hw_sspp = dpu_rm_try_sspp(rm, global_state, crtc, reqs, SSPP_TYPE_RGB);
 	if (!hw_sspp)
 		hw_sspp = dpu_rm_try_sspp(rm, global_state, crtc, reqs, SSPP_TYPE_VIG);

-- 
2.51.0


