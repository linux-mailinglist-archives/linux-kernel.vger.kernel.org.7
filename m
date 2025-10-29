Return-Path: <linux-kernel+bounces-875420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50875C18E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0705354F11
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6EC3176E8;
	Wed, 29 Oct 2025 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b="MX1GDYUj"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258DF27F00A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725465; cv=none; b=d/wVRj9/gPBAAm37KtdI38yOTUqnmg5vzFun20tr0zDOppn6JzOMt5/8A5fU6EAeXfqGr3Rrf+iNV9Y8pLNBROMiwbg0xhI3Uv3Teimhx9ZYxzAsVRWPykeDyBDirdwD+A18aUWRjD9RmNH9SMcDUxN6ejJ9FAMisikM+/NrMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725465; c=relaxed/simple;
	bh=kHatVRxxPPICyZtcpOwFhGHqwfnRHosqeh1btz/QO64=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cqTu2zLuqO68AMxhZ4JidkrF/6omCqsbDGJB7nfeQvpupzpgDCFjBQ+7oefK85T3KLVqcvK/yE4K4rPy5vRbvualR6QeBJPQXKLgO3+WKKc4WO2kzSwUUKeNQWuh54++rUJklta9khwvh2P9NSnGLaH6iaOTSmMcdCPiiuirT30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=compal-corp-partner-google-com.20230601.gappssmtp.com header.i=@compal-corp-partner-google-com.20230601.gappssmtp.com header.b=MX1GDYUj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781997d195aso4981101b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=compal-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1761725461; x=1762330261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W4TBb1NGZPBKZvsq9zfR8xwiZbK0RiAI4Eb+zjEMiJg=;
        b=MX1GDYUjR3NDHYCT5x53mmU39eMI8KeOmEBntilyPbAstahvwKD8ixFlgtsXNqhZnd
         VLHjEH6sl5NaAqULwsKgkzCsm9ZEaVX89I5rAiMixEbuI/64d5ecPZSfWVBbMagh0hwJ
         L6/NIicf/Yf+5UYZ9PGsKTDMbFTKjjZlLrrE0AdDGz3MnmRA0ZlUGaYmmF/cOpw9rjMM
         q6Pw3PBanpKLyRYOPivAidRE5TJclb8zLoVk1l8i5MsiuCuVJsVETBxGSJiHgsATszBa
         qP1lAVmKT7Cp5fxeyDq5Q1q6U78cpKs/hF0NYaQ3d1+UHa9OWFkjX5qaCG+3xSWXyRBa
         Y05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761725461; x=1762330261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W4TBb1NGZPBKZvsq9zfR8xwiZbK0RiAI4Eb+zjEMiJg=;
        b=iAWLNxe1RkxOHvuweBxKPtavGUGoxXYPksJYWmZD5XFJ77DLtoRZAPPVokJDWAoFuO
         PItjqkGKyc5rx8g+PMqAg5V4cztcFB+ca22fGM6PQ2rypsvFs+tHNr+nrSqVnIypXhmq
         IoZZ9e5rsM2HieRMaKHoqfNGM5nTo8SrFeT3cV//0UhnyyIBUzkhvbagZEcDbG66UsFD
         TQAdl64iTGuGBAhvZSUUHuDqcaodcYJIBOgOWILn388q/hCLHf2RCd/+VLHHaH3/qogQ
         gGJtqIfe02XQMoaO8BXvd5qsJqXlIWKfh2/k5mUpgNO5u+zjaIiPWGh+oyz8Zi6o+cV0
         YKeA==
X-Gm-Message-State: AOJu0YwLnnA0rtvekeGfLAiv4rC4QSp9oZO0219ykUX3a3edm1z5F7kA
	LjT5LbBDUzk7ErehIJQbv2czmjPNCfqTCOB+oEJ+yPTRqfvG4YrJveQ5BSyF2vkZV97p9WATXwV
	HuZkez7pO6A==
X-Gm-Gg: ASbGncu07nHyaezEr7NjIWW6iegwurwjvGKtl51FdK8sr07D47kJoY6BJMK5KO5cork
	g5N+s03f+xYDCnkllW2PaNxa918/4kf04gW05eoLBdq8TIhd9/UArEraq7fpea/MU7B+PPsyzJA
	ELYcAywopZ9RMlkLI2gCEuHR+wJQUyk+dWqSV+UpZ/95bSDRmUlhWjBPO+wktTCe34iOVFkYj77
	KDdPNOD/MPHBVI+qUn117//Q+WWX6vmZ2zd4T6alPCff7po585OxgoLM/y/tCoBRx0M+4UsYawG
	AKm7sGuRrv4+vsI466/K30HqryknvlUW07dcL7gjCE7rGNQATfylcCdRb94rbhYftw2/rLmN8FI
	q9mfGcp0WT6XkDnWTVxApCaax/sc5Caye3MR4Fxn/Q6jrBzk3jYlGfy2UwNv/ILSb6v2418/4iI
	HjkGOpprDGRUTMFsJFAHoeiip/qSmb6zhVLOWjPumdo9tdciCWl1AD/cXSqx1pyL8zVHuUMhCni
	umcF7H8Kg1wQujNtmUJ/UCB
X-Google-Smtp-Source: AGHT+IEcVGsW+DQZ98CiBxU6KG24EXGungrAvTUljhmtkrrdGkEJqJ2HiPOwNRPACMFE5LCNKepWsg==
X-Received: by 2002:a17:902:ea08:b0:250:643e:c947 with SMTP id d9443c01a7336-294deec67femr26359755ad.28.1761725461243;
        Wed, 29 Oct 2025 01:11:01 -0700 (PDT)
Received: from ajye-OMEN-by-HP-Laptop-S.compal.com (61-219-175-100.hinet-ip.hinet.net. [61.219.175.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d23226sm143988155ad.49.2025.10.29.01.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:11:00 -0700 (PDT)
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
	jazhan@google.com
Subject: [PATCH v1 0/2] Add EDP_PANEL_ENTRY3 to override bpc
Date: Wed, 29 Oct 2025 16:10:46 +0800
Message-Id: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1:
- EDP_PANEL_ENTRY3: 
  - "override_bpc" is used for override the value of panel's bpc.

Thanks for the review!

Ajye Huang (2):
  drm/panel-edp: Add override bpc quirk for generic edp
  drm/panel-edp: Modify LQ116M1JW10 panel's bpc to 6

 drivers/gpu/drm/panel/panel-edp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

-- 
2.25.1


