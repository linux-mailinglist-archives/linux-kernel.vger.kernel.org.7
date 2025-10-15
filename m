Return-Path: <linux-kernel+bounces-854386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A674BDE3DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783D519C39BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836031D362;
	Wed, 15 Oct 2025 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZuhVO1z"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38FA31A576
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760527137; cv=none; b=mNNVITlhjTz4wx4LKE6/b3sCDi8lRgwLsC2mH8eW24ibkgFG5Joi1FxQMV1mIVmjLDqJJX9RhaEy2io6MX/Kp5930MUr3aH8E6GRg96eeidid2kTTG3397L78nXhk3AfwtzjAR1cOb7a712odFf4ZUXJ7J8D+d0ivPu2HURkERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760527137; c=relaxed/simple;
	bh=SzFxEbyxEcDRigJfL5eL/SkazLCkh76xI9qUKlEw35o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m323aPYS3TlUwAFtZIYrI1aKmHeG1VM56QoelxzfNsoggReplEKVT7LWtFION0eAsmvs8k99U1a6yPm2qJQ8ENX2nYV/C7LJv9xv8BdOdky3Lw15NP4FkEYTT8Blm6L/nToFi82QOtw/P6ceDttF7ug+1Vftb4irJ5Ylzx7vt8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZuhVO1z; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7841da939deso5791525b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760527135; x=1761131935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2vnTLcw57Y069vTGfiFWbSfImvEmfVAFfbmVAA9rgo=;
        b=GZuhVO1zEbxLej09hLywXoc8EVElbDJAAOBM+9psIdWfa/TQs5bw1TMcd0nMU7lHxf
         B4ETqI9UCjtcWL1OVzRdRb0wqXNr0J/tO8/cyd3sgm6LrTvS1+g7V9TQ1VPOcbduMKLs
         P/ofb6F0+CF+aDjBN69V5iu8Mb+tLZ2KPJ7XU+8jJ477IwLi74yawbHotYSEDXDHzQ2K
         M1iY5XtvSx+fZ7PSUmBcithJwBEh1JigaAjlbYk4oLhy3VDZ28AFcSClAz8KD2o8AMkm
         Jxc1Ip8MHOeA/jkPpEm/Ujb1lUujfnXGnV+5KAcXtkCEbPH+ew7BYi4MiSt05waWSLGb
         Fpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760527135; x=1761131935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2vnTLcw57Y069vTGfiFWbSfImvEmfVAFfbmVAA9rgo=;
        b=lVFX4qaWwL6SiQMUWFJok3rs32rjc6FQm/i3zPxlDOHJOW9jJbSdiZJoSOJ1547c+D
         pRoVy0K3SlFFhPvbpEyaSeEYoRCH9Bx6X/FPrwfJPjqzMYePqsYbV93/UZuva75Gjx2t
         Ep36V/FCvF4WGhbW2aFj/Nb4Pjs3meoy+G+53IpU5Cqr6tXvljhgjdD0G9xm5bTj942S
         IIw+QRvU3OQpERnDrBseOkKGoqD+I1oZl/h/uTsQ0lUbKMIElT6NvAZ2UO358khxio89
         YbpeUzseeRdUwPavFliPujsT/jHnnGNRNxm3rJzIIFGu74UYKTXF1Nzv3QxCy/mz1yPc
         EPqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwsdBONiwZcEeadlUtBwSM/i6lxc8rtgjWmNQsSDSK6yCWLBZqt++oSPgpSqtKki9aHG98xFtDKRHj5A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSNlraYdCcWxUTB6fTB0VyfQwL7sICvp+N/IcelBnkCJvzTAXm
	m0pC4EYE65MAsw5QhFVVHGWKc9pO8ANasJ2Gw1eRY+Rp/M1KmafYWcpq
X-Gm-Gg: ASbGnctaAKJyXhZ1DPEvtenIz16eTCMqVmXHaUg8bLJaIN0O0pfnPX43H42ABRjeatJ
	JtcMknKF7dhuhEc2c9jA5RPMTH16FXcXsGeIRy1bCxEWrdfT7pMH0NRn7RHbbfogqpXxSTs71OG
	YuHjgZtofsqOvenn9FvmMVWfppvrrllPwxmA+zMNGBoUJYastgNrBDAYYQ99E9g9kR23Jcg5Rkp
	ir4wuQeMtf8C6aALDuQhvOAuHrN3MrUUzZk6ApknNUhxQmZdpCrSMO8cUGh0E6BELMSjMquc1lc
	jAUSMghgTX1/5jnHMquPi/DoJ4A+MhJjgy3Jm9Md9gZhwPQ4tLxTc6e4gLYR7siZtDqTcv44MTC
	919sNVAIA3lWnvbuGEZpEdQ0Qq6bZOQIX3s5ADlVyjS0/WUe2hj3gYLwdIw==
X-Google-Smtp-Source: AGHT+IFxanje2UwITyO7JhKP4HwVngGwSfVPKTDvSZY8WDRIMIBK8NNPGmeF09cgQwzpalXD/vgd7A==
X-Received: by 2002:a05:6a00:4b01:b0:77f:1550:f3c9 with SMTP id d2e1a72fcca58-793859f34b3mr35946413b3a.12.1760527134951;
        Wed, 15 Oct 2025 04:18:54 -0700 (PDT)
Received: from tixy.nay.do ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09aa20sm18322631b3a.39.2025.10.15.04.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 04:18:54 -0700 (PDT)
From: Ankan Biswas <spyjetfayed@gmail.com>
To: bbrezillon@kernel.org,
	himal.prasad.ghimiray@intel.com,
	dakr@kernel.org,
	matt.coster@imgtec.com,
	robin.clark@oss.qualcomm.com,
	matthew.brost@intel.com,
	aliceryhl@google.com,
	thomas.hellstrom@linux.intel.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Ankan Biswas <spyjetfayed@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/gpuvm: Fix kernel-doc warning for drm_gpuvm_map_req.map
Date: Wed, 15 Oct 2025 16:47:08 +0530
Message-ID: <20251015111828.18944-1-spyjetfayed@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel-doc for struct drm_gpuvm_map_req.map was added as 'map_ops'
instead of 'map', leading to this warning during htmldocs build:

WARNING: include/drm/drm_gpuvm.h:1083 struct member 'map' not described in 'drm_gpuvm_map_req'

Fixes: 000a45dce7ad ("drm/gpuvm: Pass map arguments through a struct")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
---
 include/drm/drm_gpuvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 8890ded1d907..476990e761f8 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -1078,7 +1078,7 @@ struct drm_gpuva_ops {
  */
 struct drm_gpuvm_map_req {
 	/**
-	 * @op_map: struct drm_gpuva_op_map
+	 * @map: struct drm_gpuva_op_map
 	 */
 	struct drm_gpuva_op_map map;
 };
-- 
2.51.0


