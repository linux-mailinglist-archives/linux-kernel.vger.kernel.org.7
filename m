Return-Path: <linux-kernel+bounces-794087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5988BB3DCAF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 941173B3FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A262FC016;
	Mon,  1 Sep 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUox1ZQe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591962FC004
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715890; cv=none; b=HPWGaoeJiUusnEzyV3P/8VPg2d7Esgnq9AQ42TcI7F2pf2b4Ln7UeV3uI8dljg/KhmaiIm03sPX28iJGXwYCvwIGvD3iO8gFTmeU9f7wFzDf8xVQ0g8rZRSGMbsp+EuVwShh6hQd2sVzGt9eMr5mMu6XUkAwqJXEordpO6EFMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715890; c=relaxed/simple;
	bh=FFDoK6eZw/raOR+8vpbrZnJPVub4O/sPTswfcIGLU3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X+1Dc5Rz6lLVb082IDzOfPUiJHTg4nz6HWrzaT1CoQToTwbO20skyGynzh6oVv4B/ZzCbrSQ2fvPqxhVVF+YfVDwOiNuPM9L5W8OwezJkZALs4vy0ZPUIlC+Z5s5MR0HNoV6gAr5ZPxcpyNfnilOzXDnmTEFKEg3POP5rdOsoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUox1ZQe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756715888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=P+EUDX1W/ihdzaBuV48woqw6avcEjywzB+FadyRSMcI=;
	b=WUox1ZQeAhGaEMn/ZeXG1Gn2WZKQHuxLlvGyGapJ52GWR5lXI3eVT7iN7f5/ppgjag/EnR
	ed7FdDIZNc2tAe83ElCb6LzYVTP0z3dc/3CrQWpT1VekchEDXn0/RYb8TDbxYiJKg5d3vz
	ieJpYwa25RveRYW8MRUiAl9FZClZ2No=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-e3mhX2AcN1q0z1dRxznVTw-1; Mon, 01 Sep 2025 04:38:06 -0400
X-MC-Unique: e3mhX2AcN1q0z1dRxznVTw-1
X-Mimecast-MFC-AGG-ID: e3mhX2AcN1q0z1dRxznVTw_1756715886
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-772642f9fa3so248414b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715885; x=1757320685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+EUDX1W/ihdzaBuV48woqw6avcEjywzB+FadyRSMcI=;
        b=mSN5F4Nu8mE+fYsNPSmlm0vrm8XI1KSIh4HFD4H2W8igW0atpkamYrPRDfUKIpRdHY
         Qsc1U83qOh84e3lU3CQPFWxVUjmmGNiyUFOFslt7Wl87Zj+fZGT2wmAhjDPa7dDnnLm3
         U8/UUF/qM4OALRmBDbyYiAIFEiLb2gtRG7h4qiv+ADiFcl3ghd8YYfPlCGDEwNoYtCxO
         QO2bi5Rg1ooZzjERmcimOMb2rob4eqbeDuZ2mmInuSZPXn2xff+1uAoXlJAtSwIScG2N
         REaNphcCe3QR9Zgic6FZh1VcmgjIkq2nGid+QexFZ3D8gTw9DpWyWS1BpmLk3jp78pUO
         XqFA==
X-Forwarded-Encrypted: i=1; AJvYcCUXYT+XTHdvgGF2l3oj1Z2qY7op2L93CyF0xoB0eohl5ltFQkzXqlIbAWudct9MMl9aXD8GXO8nPlvD6Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyf6be0mmpwQPdFru0AZxB0t04ZyO5LDgsOyO0rzSJ+MVLcMV
	zR+lXtpdW49D0ulWej0/FBaAxY6G8GHq+B96cSavTuNGwslOaNc3GuP43CB6/QDvXBhgWhlodhZ
	TNNoaiQf10272yPCd5RJ+7TuV9xW9A5mH1j2gNFNTIoKyXwrb5JMkvXSLkNhHhCQSdw==
X-Gm-Gg: ASbGnctofaVMb/0o9TyyV4fn8V8M/Ug3GqNkpAjL1vp1IUHEP2L5tCH8kTe2nXa3UyB
	uKXtzhMcdeFd9qCHXQgG3mGbjKLIbAZM3q0ysM6fPtYwBe8hyz49FJNbDZOfTInWNu+y2AnjHjM
	QR7NULVhK5dIWO0I6SBsb0Gnudo3puCSuFwQap0fyOOv57K8ZR3/I63S6Mq8M2zlAdRrm9Qd76K
	K0QdT8Ea1g3ffKSEoJRe2zH3oyjocYo3tXzUZBh5MZLww58iSTS4Nc2ljd1vopVDGapN3Uf7kHr
	qq+r3Uxl/r36pMosgVmPsRAfJxABXDeFhtI=
X-Received: by 2002:a05:6a20:12ce:b0:243:9587:a774 with SMTP id adf61e73a8af0-243d6f7ef50mr9510681637.28.1756715885658;
        Mon, 01 Sep 2025 01:38:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHICmbVBLeWJ6x4FNJkNFYJdgYcXmjleynjZn+8qv0o+FPmxhi1TGcD3dIfwmIF/wHRSCKB3A==
X-Received: by 2002:a05:6a20:12ce:b0:243:9587:a774 with SMTP id adf61e73a8af0-243d6f7ef50mr9510665637.28.1756715885279;
        Mon, 01 Sep 2025 01:38:05 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26ae02sm9815337b3a.21.2025.09.01.01.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 01:38:04 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-misc-next 0/1] add drm_panic_support for stdu
Date: Mon,  1 Sep 2025 17:36:54 +0900
Message-ID: <20250901083701.32365-1-ryasuoka@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add drm_panic support for stdu in vmwgfx. This patch was tested in 
a VM with VMSVGA on Virtual Box.

Ryosuke Yasuoka (1):
  drm/vmwgfx: add drm_panic support for stdu

 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c   |  43 ++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c |  11 ++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h    |   4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c    |  48 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h    |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c   | 139 +++++++++++++++++++++++++
 6 files changed, 246 insertions(+)


base-commit: 73cfd166e045769a1b42d36897accaa6e06b8102
-- 
2.51.0


