Return-Path: <linux-kernel+bounces-788452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC58B384CF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358051BA60BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1735A290;
	Wed, 27 Aug 2025 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="byRv1DeI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05C3469E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304419; cv=none; b=poT9zvGmcwlXljTXVaEas8LNV7dyLb46FTltZcAWsuXVoS9wD0C/XKjRBXav/BUnGy70vEUEX7TtX2GiYXdpY1LnGres1I0NeYsXnxJJJZTrAvu9DFLZWLeMvRuXDkGYFTJ7l9wYaIEtyIB3FB5PPYbJXBcs7BJ3idyHuwI3UtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304419; c=relaxed/simple;
	bh=HHk2BSgl9+A5isTV0Es7jKwwEf6+byROFUjgpG/p04U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RYstW7FDa1zLhK/hHPbrGSlDaYge1eBn00GcOzl9wgIY1tiR44e9M4B78+TxC8S7FbBIZItau/HQnEYO+dkumC8Ya2vVuJNje0twOoYP3oRHoCTt+2XxKkKQewLVMLvXIEMt2jP/BSXk+S0mc8TwsIK3gnQEs6Kz/YqYRzM3+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=byRv1DeI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756304416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=opDJ3bmxpJeKk5jilIGi+lkf0qL9GQCfD0EA1RSLjbc=;
	b=byRv1DeIXj9HMcHdEcqVyM0fTmWxPjeMmYZSHX/PTCyGX5yh2FDT+Bf/Z6dge7FyY4Xqao
	KQgrCjPDHa8jB/XmLSqowYjdd3NjqI/w0Tbp89HbC/9T6NOq9gGLGU+tdAU+zfILKEep9n
	H6ykvAC2IWuT8DnG1nmV/qjgpQb7AVE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-df5j9kduND-VO2KeETf0ug-1; Wed, 27 Aug 2025 10:20:12 -0400
X-MC-Unique: df5j9kduND-VO2KeETf0ug-1
X-Mimecast-MFC-AGG-ID: df5j9kduND-VO2KeETf0ug_1756304410
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45a1b0bd6a9so38283495e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304410; x=1756909210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opDJ3bmxpJeKk5jilIGi+lkf0qL9GQCfD0EA1RSLjbc=;
        b=MP0g25aNXX4MnT3auxAexr1fNLw3AOu5dW0FBh+Nk/U3IOLuSs9VIFYArIJlk7N3s8
         i9GeUVf1Qq5byLLQ17L6cW4LBr3NuXEuoqk9D5szVUyLkdnzkKTvaSrVXzy3V7lZ2A7s
         M4wLLGNTL+g48JBWT1DGldJh6RTE1vhkQadK9B2VVF8lJnP4mGUbBtycvWSWMhRC7rbm
         OZeXhMb0UA6veVFyxYLrpuMQTpr6PYc5lwo3EPKzDpRHzgCtOfrAuxz5R4BXvmDoBJq8
         k3q1KDUi7wrXbrdAb1hooHmhuLtIRsejwo0No6oh/wg2umrRtPyya9aZsKYnn3elNzZm
         wpJA==
X-Forwarded-Encrypted: i=1; AJvYcCWn03TUHuxsiHGXkc9f/r1cWhxb2y1MO4jd8qBT6zXZvgSkRujrSUyO4DP4mzphwqK1otnz3kc71plxGq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/EitDTiqJy9TgC0ttij3oX9iofq1lbi1qLa0i/b793nTYfkl6
	8V3TXgMrHGWqU/oWRSxUtMflSpZHHR2aRd5FR5V9R8dBLelqf0syoFqiq1ZgcDl0WrlAM4O2mCX
	vXdj9JNQsthiwz/gO8VygtRSqC++CrsbKMoIMzy4CGtkMKibnRsLccf4jVhJ8gTb+A3IIoEk6AQ
	==
X-Gm-Gg: ASbGncujEwmIFRUmrXoHMkVIQAlPPRBROlCmF45aa9hAHW7paDrHJJXQncxS7Ql7ufo
	EZqBj3LToGkD4f2JFtPT1h6vw5QwlQoo2JqunYEU9Fmtq6kvt1o2o2jV7GV0OzTEUKOOcKs3qbQ
	hj5QpeNy6I0LDPN9kzkyPVwfgH/uzSO42toRyyowrvliFndyyOhEWT9yyW2A8zs8VZRjZM7o4TX
	XVdqa3Z6uxhr3foyEsm/eNhRxSn8zy4X9HOOzryilz/4WHZQE5kcYh/MD6hWxLW+iDWNwt+3YmR
	/XTQ8oSUKEvjj7uPmCUTjVgu/M4EwQ8=
X-Received: by 2002:a05:600c:4746:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45b517a0bacmr187068585e9.10.1756304409954;
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFKNOtqoYfcFfl5BN6DYFKW7ddCHHcODDT/GXLs1RNGvAT7ubO6RW2Y1yIY5L1Dbp0HoJT5Q==
X-Received: by 2002:a05:600c:4746:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45b517a0bacmr187068355e9.10.1756304409549;
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f3125ccsm32582585e9.19.2025.08.27.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:20:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	arbn@yandex-team.com, igor.torrente@collabora.com,
	junnan01.wu@samsung.com, kniv@yandex-team.ru, leiyang@redhat.com,
	liming.wu@jaguarmicro.com, mst@redhat.com, namhyung@kernel.org,
	stable@vger.kernel.org, ying01.gao@samsung.com,
	ying123.xu@samsung.com
Subject: [GIT PULL] virtio,vhost: fixes
Message-ID: <20250827102004-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 45d8ef6322b8a828d3b1e2cfb8893e2ff882cb23:

  virtio_net: adjust the execution order of function `virtnet_close` during freeze (2025-08-26 03:38:20 -0400)

----------------------------------------------------------------
virtio,vhost: fixes

More small fixes. Most notably this fixes a messed up ioctl #,
and a regression in shmem affecting drm users.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Torrente (1):
      Revert "virtio: reject shm region if length is zero"

Junnan Wu (1):
      virtio_net: adjust the execution order of function `virtnet_close` during freeze

Liming Wu (1):
      virtio_pci: Fix misleading comment for queue vector

Namhyung Kim (1):
      vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Ying Gao (1):
      virtio_input: Improve freeze handling

 drivers/net/virtio_net.c               | 7 ++++---
 drivers/vhost/net.c                    | 9 +++++++--
 drivers/virtio/virtio_input.c          | 4 ++++
 drivers/virtio/virtio_pci_legacy_dev.c | 4 ++--
 drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
 include/linux/virtio_config.h          | 2 --
 include/uapi/linux/vhost.h             | 4 ++--
 7 files changed, 21 insertions(+), 13 deletions(-)


