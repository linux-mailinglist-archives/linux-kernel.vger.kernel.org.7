Return-Path: <linux-kernel+bounces-806022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864CB490E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36BFB1629AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0311530BBA4;
	Mon,  8 Sep 2025 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jKfh3VR1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88522FDC53
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340752; cv=none; b=IZNbbC9LiftZL4SPNrFp6owzCpa5C3QSI+ctXlP5cqUpelEuVeO9vp3hay+2gqcZIkXfYxv6ZcJ1slvRmi08uR66MKyPA/v9yOIIv1Xbxa7a3AcW1O4EJHU/DC4yTLRGcn7w0c5cFoOV6OVeRsabN9yz5qdZI8SA1/N6x7CAoDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340752; c=relaxed/simple;
	bh=d3wwtvL2jKZ7swv6msDLDhoAxoc8bk/zyp6nXyNsjWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AVczOo3DeKHxDoxZTfN6RpPUxXj5c7Z6EQatLdl2odJ+MCQ0YbUSdDRu8tTSQbuNpDnxkbbKf8Cx8exWImvYlWskbeluFIEK4ajdhDP/hM9p7FdAqjACG8r9J5cH7QuPf75NtolD1QzB8KcYyDQQ/ikmxGArrjrN8GZlwmFyofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKfh3VR1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757340749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fPEM/6vsiAl702X9lBvcgrhIXEUzSqlwkstVlu6sD9Y=;
	b=jKfh3VR1bjdQKhuS+p7F5GSiZk/RJC38GvCQ5Mxb+irYw7ZXQs4kSM5esI7cplGhSbiBYQ
	eZYhBZYd/th0+LDa6JBNTlt7w5XzdTVtImVjgs6sGzUdz/ARR/JMPHKn5c54Kq4TINvqgF
	FAi9DmkFLzX0694Ma6UqyJnIK9iXNsU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-eCgLRvZeOyGqxalLbUXz4w-1; Mon, 08 Sep 2025 10:12:27 -0400
X-MC-Unique: eCgLRvZeOyGqxalLbUXz4w-1
X-Mimecast-MFC-AGG-ID: eCgLRvZeOyGqxalLbUXz4w_1757340746
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329cb4c3f78so4580941a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757340746; x=1757945546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fPEM/6vsiAl702X9lBvcgrhIXEUzSqlwkstVlu6sD9Y=;
        b=P3jjdSsMix/P0oB0oXHFwrei1+WgKF7ABOkH/Q5C/FzHGucw4OnK/xliyDcqTne6FM
         rPE9xUfZzcwkxcA1wpT/NCLkDCaw7dsGBYV+VswJ1C2VO5Yi4ksvxfQWxXfIo7d1v0Dw
         gNh/6xnx6SUKvq1JxFlCKQueeU755l8w2Mzmtdb8BlgmT6plzbJrmKQupWk36bQiZAow
         dXtcGPGApitX8hIJq95IJ6ECuS9CXzkksZs/bsB+gael8XUeqVAN5yr7U56fIDTohown
         +2m7CPb2GKKcFcQjdYw7Ok+9WaVRh4E0oFXZ8NR2gV/MqaGmMIyemWRzKVtWvvOD+ptC
         ZeiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3mfkOHs+72DE9/03nKVy8p+plDVv+spnWYZbUMvegCDXiFTL9Se+rTO6piRsVQte+66iTS7+ZCLQys2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb8HOKXDZ/aYzgqKTieLfSBtsn97HDV3/GIMwX3IcWh2CDxvAT
	4baK3eyfb1veQbHUwpnh1gTc4iC6iaIzB0a+fIBpGP3blBRCSQx6542Xxms1jamg7yUr+BYz1mP
	Ald3ZPDbcCgqrRQWByS49BOkcL8GOAd3Y2mF2OPsAnh617x2srnLQrWmcK3tubDYcvw==
X-Gm-Gg: ASbGnctdM4ifoehmC9+0Z04/0k7q+nSeddfl0e//Rp+sMQG0S0VZplOa6JnneO+VLLc
	lN94YsddNgXBLtXPHyIgJvQPJMUBfqIr/8oo0tJHfFsr3/k12C3T7zkC8ZWkiWqoeC/BcQyWzii
	4jNen5sZgLHFzNsyGLQGSfQiYYhDmVBZARePuMnVFV0nkUE6zZlkicdxZTudGzLayYVAC0edyyt
	ciLbH11pnT6HG8lbhPt+8gLwmpeK+z4LNT6gURqW1kxSBPmJ6P5xQz7wLA/HJYtMDIAynWy46wi
	VEiMg1q/rNi+OTeYT7B9wJtHCWHpY6FTaKc=
X-Received: by 2002:a17:90b:4c12:b0:329:f110:fe9e with SMTP id 98e67ed59e1d1-32d43f5bc76mr11240816a91.17.1757340746443;
        Mon, 08 Sep 2025 07:12:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpoq0ydxeRV3bqT1pPZ0asQ1BYD8GDn9+GYnc0QJIZ3/e+Jo6uQtsHmaaVuWuQ1Ptp5qrMOA==
X-Received: by 2002:a17:90b:4c12:b0:329:f110:fe9e with SMTP id 98e67ed59e1d1-32d43f5bc76mr11240780a91.17.1757340746005;
        Mon, 08 Sep 2025 07:12:26 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d89f32ebfsm2937596a91.0.2025.09.08.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:12:25 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: zack.rusin@broadcom.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	ian.forbes@broadcom.com,
	jfalempe@redhat.com
Cc: Ryosuke Yasuoka <ryasuoka@redhat.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH drm-misc-next v2 0/1] add drm_panic_support for vmwgfx-stdu
Date: Mon,  8 Sep 2025 23:11:33 +0900
Message-ID: <20250908141152.221291-1-ryasuoka@redhat.com>
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

I got 2 type of suggestions from reviewers:
1. Write the panic screen to guest_memory_bo and send dirty/flush
command
2. Write it to VRAM directly and then switch back to legacy mode

Since option 2 is simpler than another one and ldu might be able
to re-use some codes if ldu supports drm_panic, I re-write this
v2 patch with option 2.

Ryosuke Yasuoka (1):
  drm/vmwgfx: add drm_panic support for stdu

 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c  | 73 ++++++++++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h  | 18 +++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  |  9 ++++
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  | 43 ++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 34 +++++++++++++
 6 files changed, 178 insertions(+)


base-commit: 306c8959b5fdfdc3900aebe4e56257a349f5765f
-- 
2.51.0


