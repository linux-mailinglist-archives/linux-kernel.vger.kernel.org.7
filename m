Return-Path: <linux-kernel+bounces-722677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C08AFDDA3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CED64E6EE1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66ED1DF970;
	Wed,  9 Jul 2025 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pr1o1zah"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCCD1DE2B4;
	Wed,  9 Jul 2025 02:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752029111; cv=none; b=Odp+3mEB9HgHot8Y2XGQd3ypMw1yz2Xo7uzU/2OVnHiFvlw60x74CqkGsDaNsVsDfVdHIH07yMhCG0W3sqIOuBA/+MQV8owQV3/ijploBq1BHs26sx+2yxWqfzj0Y+peDTAoYAaST5EixEF8zwGqX/scs16cOd0S8YWe3jYZAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752029111; c=relaxed/simple;
	bh=v5gWJHZSziQ9AK4ivNXRbjP5Rm/JcvFHiODpyoVd+Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sg9KrW8On7wqdSfjOvRKd8nFb3nePxAbiZN2oP3DlznzW0qluHLJyDm9VogXoeHjw5ge9O49KO3GIYIuw8Lj6IGuJ1zCZGgJH7R5t4D8i4P0xHeeGI/Zw0RTjwfNOae1cfh9dKXAGGiA4reLfRQlBpxKwBmgrkYJBLEf3ivUHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pr1o1zah; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748f5a4a423so2958664b3a.1;
        Tue, 08 Jul 2025 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752029109; x=1752633909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPq+2uwW5apwANEY0SAy/z4/pBz0JuDXsQOXkU84O0M=;
        b=Pr1o1zahIdyV5+mK3M/fsUOuIeOAC5iAXc7GP8EMkkeVBtqD/vfTcoYH3pgqfMM8T7
         qFfA2Dvo+GgSBReR8RPlDvtHTeQMVXyUKFw47K/NSi/jDeIXA3Pzwj/4pjqOxNFe1XrB
         mHsBjWxxncxWNSl7WDiHzoBYOsPIFyN4CaNpnw7uqYlbLtcxd9zA9wVGlKD5wdZqhUXA
         HMNItcMREXfKCC+pNXV5r7vVOPVRPxYTGJw2mXZj9DlQ+a8zbKM7s5U8PdcptqTQFUmu
         Q2rLGEUMHHmDJkUpPyjaEtJjTlbAAyFQK8rGyfQq4fzXVWhLC934x22mu3SruvXeiLNw
         0GAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752029109; x=1752633909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPq+2uwW5apwANEY0SAy/z4/pBz0JuDXsQOXkU84O0M=;
        b=lriFJ67SMU/n1EJVEyXKhqGrp5dhssUqy0W8tfq63Qg/h6NMgG3YF09KOjpRatq6B0
         0t8jAEYGvOLqUittnkFTEmKaJxYkPWjQQU3ZFGtk1JDc72E1sqMNVrWUF1fj/JO9EWUo
         hR6eOFESvY+l9SRGYp5tNqfBDTnWEimqTWuBa8f4gNXuOalLUPgu2P6pM1ZZ3InS6QsY
         atSLyQ42N9K9bLSjR0ptNyWKvavBChGnE35K/054Wddu3GW9/usskHyK2RpjzsaH/VFU
         wVNVlF2b0KX92A13X6juVrsqk9FQ7fsxKSt/tcb/peZr/e3VDqcqQZbPMw5JhL3/uU6z
         euYA==
X-Forwarded-Encrypted: i=1; AJvYcCXbzje4tl+ZwKtqGUumokfZQyIVt1J+NtjePThWE9VYVvXgA+GhX2jlYdrg+YZfPI9TpEaUiQlAo8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRy2K3TToM8xKBsz+Z1Dsb7mqYGboBZS/tS+QWL+I4WmWx0bBG
	j2/BjUY5mLqp+UQV5lLhu9wgrc+x527GE4A+0aj0xxWlav/HBTfakq53
X-Gm-Gg: ASbGncuFlkgrsAR/3tq1sQe/QO1Dl+1Eu26V1DiUxBvB8rbz3rpUPsVSsIPZ8z//JjJ
	OdIKqcpp+8VoD5PqWNZfsdb1bsZKIO+8Xm7PU+2eoh3oe6leByc3GMf4r8VnPEt+1jOXCjRhv/n
	4LPep1JEaIOKQ/SP3IUhp3APjoZXeGmgcWDbqAczxz31rUp5zSczbzcCHTIN86Lbr6uGnptwfIP
	hntb1xP9KjYlKFDZAKPB5Pi80vfjNcFmDQRe9T4blkk+sawbMNeH7zMgPpt81pPEQSItvLfI7Q/
	zlEuHraRb4vR/4mCjRogSjfZupL08AzkPGVWB851RdzvuLQEVN6ksJ4YrhBavQ==
X-Google-Smtp-Source: AGHT+IH+kdEVZvs9IAFbHwWw/WF5McIPt9LcfUjjAjzh/4FnuSalS1e/sXDSWzZtol1ZOl8HqeNVpA==
X-Received: by 2002:a05:6a00:ac8:b0:748:ffaf:9b53 with SMTP id d2e1a72fcca58-74ea666190fmr1263828b3a.16.1752029108518;
        Tue, 08 Jul 2025 19:45:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm12092598b3a.76.2025.07.08.19.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 19:45:07 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8EB9E410194B; Wed, 09 Jul 2025 09:45:03 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Antonino Maniscalco <antomani103@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected usage in literal code block
Date: Wed,  9 Jul 2025 09:45:01 +0700
Message-ID: <20250709024501.9105-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2245; i=bagasdotme@gmail.com; h=from:subject; bh=v5gWJHZSziQ9AK4ivNXRbjP5Rm/JcvFHiODpyoVd+Gk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBm51/Z53YsLvGWmMfnpq8p+i6L/rxLu7T034YfIl8zXD T/rwnoOdZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiE8IZ/vv97ebV6XSa7Ob+ teACe8RxsyrBF3beIv7TDe/P/iDzKomRYcsD5ZjsB2xqks158UX/dz4+dv6xy4m7yw7e4/YtcVi bzAUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Stephen Rothwell reports multiple indentation warnings when merging
drm-msm tree:

Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2445: ERROR: Unexpected indentation. [docutils]
Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2447: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2451: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2452: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2456: ERROR: Unexpected indentation. [docutils]
Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2457: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2458: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2459: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]

Fix these by wrapping drm_gpuvm_sm_map_exec_lock() expected usage
example in literal code block.

Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250708192038.6b0fd31d@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index bbc7fecb6f4ab4..f62005ff9b2eef 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -2430,7 +2430,7 @@ static const struct drm_gpuvm_ops lock_ops = {
  * remapped, and locks+prepares (drm_exec_prepare_object()) objects that
  * will be newly mapped.
  *
- * The expected usage is:
+ * The expected usage is::
  *
  *    vm_bind {
  *        struct drm_exec exec;

base-commit: 8290d37ad2b087bbcfe65fa5bcaf260e184b250a
-- 
An old man doll... just what I always wanted! - Clara


