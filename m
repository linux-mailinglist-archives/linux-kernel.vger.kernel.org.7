Return-Path: <linux-kernel+bounces-783344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B3EB32BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 22:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A3954E1063
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 20:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2688D22D7B6;
	Sat, 23 Aug 2025 20:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwVcxrqi"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E84212548
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755980701; cv=none; b=eS82mlPmQlKHYWA0SHUdKVL2P5OaBfpRGmUarF1J17soreUyjIegJj5tNird/cwciafVn66byOORbrmJWFoXyR1C3CxfT1hDIWkaVrw9F3wr1/pfGp0s1eVF/KPTIGM2xx+RIhiT6pQO9sCHfH2OJn793wpXMb3yMeR83K3ZNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755980701; c=relaxed/simple;
	bh=UQYowNRuo1xp4aEMuamPeEoTbh5naa2NIxNUUSwpebE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtfT5FLLFhWmxKzi424g95HywyEbxkmtacz6shGfkzZsOzJv+UGC2IElgS0izqoBpBaLSUP5GWJ6csWfSS1fIgtnY0JhrAKZXs1z0Tz/ukjsxpKJ5HrDzijVb45Aw6/x26bHfcKjP/QE22ikKqZgEo+Xq6U/oR0jg+yHwYyREm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwVcxrqi; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-246648f833aso6851315ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 13:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755980699; x=1756585499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jluHiqgaZQZWMzm5WgOiIg71d7mItf5bX9RJ5F/RYN0=;
        b=NwVcxrqiVvjTkNL4IU263eCKrNFPv+FgteVhmXFcoDB+KHZgDIPF5yupRZ7Qj9tFIJ
         50w0rAZnEIQoqwYXnlHhatNzR7QUY+JLEKmn/73ojZQP+DqJMUmIEbq7AAj4Z+vxMotv
         43+DHiR73Dm2fa1qEbUZY3lxCLdZNgsLb+t4op88ZPadkIttBeDbbYi4yHzEq5/gcLu7
         RhTW90pIhlY+hcKIY83KFc230uWtYVpYUIkdnLFgkSoR9ypNHcS8hL0fuf6yj2UlUwag
         15zGmvoxvAwGqo/0S4hUUKQiScdng7n3pafTHpmqKqjy1FMrz3F5OLnzpXEyABP4T2Uz
         Aupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755980699; x=1756585499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jluHiqgaZQZWMzm5WgOiIg71d7mItf5bX9RJ5F/RYN0=;
        b=BcimC3+pRrGBphudIse0djA0nYw6YuLOxUoODazA2mBNNhSmRm16A2lmTEQArch08t
         Msn/dAOJ/TWX+3f/KWoF5U8jPQcBvOKbtG+bkAXkqkPxj6I+Q8xWzKZM0oOhfDPodbzh
         OBAhnrRzMsk9YZTQYv0J3mgxKTrNrMzC6N49+zQOz7IFLxzS1F9Il5eC6fBKYCiqk/Bh
         Eq7qiI177j2lLcztYeCbfmTE1RFTfZd9/I1maDW8Suk3sBiV2XRIGHRgpxpB+hz1WPPn
         Mj3cWUp+Wd47ubWhU1oPsQEiwSsC0hHAAfMVQVkPcqSBAWqu8/bwo4VEYx5a92vF33D4
         HX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/Oiw5H4lTmgId6o4IXtQIfLDTeBmo1KnBealCLOqafXo7FsdDeSumoN8DLf/slCm5UK1GBNTXm2G+gjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjHaslkqutABrTGKUlwvSWJyUnm7SYq3xmkYxU7Pl43034runi
	H+Lshu3Y7XxqonUwA78W2w8Y5kkOsImVFnuG5juv2owAO9LasVQ03/Am
X-Gm-Gg: ASbGncu74LdEXnWYgpAzSL/8AZ91VKOBFSPBsYpra2kvGa6EoE8yAdx9qVcFoo5o0cS
	qm2NLfJj46cON115vaF90HlCnGCIiawnfQVMO50gRkPFkdoFeBUFBWCWnvcPk61gE63VqeKSF6Y
	7N0i8NHso8sFyEOHVmFSfRLoHyuAP5kdDGrwoOdQjeSmUJorMfDqXPMyX/cMoNeKHSUeaRSmKD2
	T0W4wvBdo2WF2wM/uAJrKtnlnGoP8wTSGUi26N7nXq/tx9CPXnAdOpA9jjPaDdQhaUVvY7sIK5l
	VBn2h+1lFwDSvxnah2foHEH4Ue0BZLMzfheMSIITXBUdGHRy1GHQK0PQDfIcrdFu1JsjsEfbj7R
	S3Mkub6PIBQ==
X-Google-Smtp-Source: AGHT+IGdNe2acobe7hoYy/3SG0sU0woB1Ddr0YVeZCAUQFiiD1P+atEHJGDMr/DnmavEr02jQpM7Fw==
X-Received: by 2002:a17:902:cec2:b0:240:9f9:46a0 with SMTP id d9443c01a7336-2462ef05828mr94011855ad.38.1755980699439;
        Sat, 23 Aug 2025 13:24:59 -0700 (PDT)
Received: from localhost ([2a09:bac1:3680:98::10c:23])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-24668889dbbsm28386195ad.132.2025.08.23.13.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 13:24:58 -0700 (PDT)
From: "Kavithesh A.S" <kavitheshnitt@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	"Kavithesh A.S" <kavitheshnitt@gmail.com>
Subject: [PATCH] drm/amd/display: Document num_rmcm_3dluts in mpc_color_caps
Date: Sun, 24 Aug 2025 01:55:40 +0530
Message-ID: <20250823202540.487616-1-kavitheshnitt@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a kernel-doc warning by documenting the num_rmcm_3dluts member of struct mpc_color_caps.

This is my first patch submission to the kernel, feedback is welcome

Signed-off-by: Kavithesh A.S <kavitheshnitt@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 59c077561..06f05979b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -234,6 +234,7 @@ struct lut3d_caps {
  * @ogam_ram: programmable out gamma LUT
  * @ocsc: output color space conversion matrix
  * @num_3dluts: MPC 3D LUT; always assumes a preceding shaper LUT
+ * @num_rmcm_3dluts: number of RMCM 3D LUTS supported
  * @shared_3d_lut: shared 3D LUT flag. Can be either DPP or MPC, but single
  * instance
  * @ogam_rom_caps: pre-definied curve caps for regamma 1D LUT
-- 
2.43.0

