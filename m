Return-Path: <linux-kernel+bounces-823014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F88B854D2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5207B5F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B317530C100;
	Thu, 18 Sep 2025 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I92hhvne"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7EE1FC0ED
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206514; cv=none; b=D4l9apXe6WY0+RsoOFN+6bOB0dYCYNGnIArFkOKqB9pHTJnDxJQJILfWEA3OCi01ZNKtE8h6EdTRNy1U0x+s312fYQaVR9odliGehBfKYCfH1auExuyHMyuX5wzElwxHMwuD7uO2T53tQJxcNDvf2QWMsAHXiyycFykG91GKp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206514; c=relaxed/simple;
	bh=52mzwF50ZysPik2mfGb84bky8NEzJW1dDbmZc78Gl3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g+bSN8zSA4xIZvveP/RuwrCRS6vSiKOZ7W7WXug0hc2qVa4lz/DXP7CLwmiVLE3R9YdfPGZdt4sjmaykB9dY2uUgHEPOHvj3waP8dH3k1WbjF9DZJOwnCSOJCmwXXXUeu+J0auxChcTIkz5v+2KazdgYalf1xPABGBmVRlgqsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I92hhvne; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758206509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XGS8iYxGjjgCtPNfLtzzgPnXWY2Ig3ulBcoQ+vUpdX4=;
	b=I92hhvnejmVFbYB1S4O6uxwKDCpPHQ9DOb2YpM26hWG4p4nbx8ei6HCKEK8VNBvAK3S9H4
	NpY8HJqsuRAtYlVJf36K/NA+GW8z6wbWEoCzcUwnpnRMCCKEXDvXwq9WJVinbN4g3rnxvF
	DuGWUMobI4l3nH1P8swRrFc76XznV98=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-XOv_TjRAPHGVUtFYxfHK6g-1; Thu, 18 Sep 2025 10:41:48 -0400
X-MC-Unique: XOv_TjRAPHGVUtFYxfHK6g-1
X-Mimecast-MFC-AGG-ID: XOv_TjRAPHGVUtFYxfHK6g_1758206507
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45f2b0eba08so6321285e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206507; x=1758811307;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGS8iYxGjjgCtPNfLtzzgPnXWY2Ig3ulBcoQ+vUpdX4=;
        b=L9sy7QBBlMjKbtGLrq47fCsfaJHDwBfjg7lyEY4QNn0NVep3V5KCEWEbXd64HAzJF6
         aCaK+pMbzDAyiNgwUmbrqYDGgesbzM/XUOoDNV9M1bSHRCjvuFXh4SoArn+pPiR2ycsa
         /7wIMLRMoAptu0s5BivbqZI9Gu7Ch9Exd/sAzqQTDpeCUCKDUTHmKUCo6wt3rPE1NGqL
         /CXNkLZOxiqB7be1esTrgTrCiRvPHLKYy1/VkIt9NnGw/TspDBReF+QL/f5tv0N8DqFj
         CZvt6jHGDuF/PPVexRfQCZL1q7w0CBkzK605Sfa4rNHyrUCCJ6DS97e0oSwZq3KO8qKx
         /0ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXXsp15LfSTULBy2ezSJoMkf0eXUm93Y2YAf+19/CxMPPf8NKkPn1y3e3NK0aGhzBrlIR97YNXs5k5yDQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGiXrjYTPU9oHqN0/0m2PFzWrS2qeWebUUx7gIxuklrTdyNDST
	OHDfMoypbwHc7qaPD65X2pzv29giiH4VvnyJGg1zbiwwlGuJm9NEkVrml7LUE50VnCMmJrHPkq4
	UdDRCdLKk8z2ritQPRx6qPcf+PMSPh4f717duxThRXFdLCJggQuan2G43GR9hgay4YQ==
X-Gm-Gg: ASbGncsb6vAKwI/UZyl1v9SsQQ2yCCRGj7IskCfwPGhjS5AP1AL45cCN6N2//+zO+zy
	/enkSogp65GdSG9TJ43Lmywd2wvWWmXnvjTCAPqSEsvFvmJ1CadeNnDyjf9HI7hKQ89sxmREL1y
	RUPUYYgFmmG3anWVSs2w/6zpXloi/j7HqUb4fKzkp8StEQLtB7BLGBv/S576B1h7+ltvNu+xTc7
	wEnmiJMw3W0+o/npdv/VwKtMZlRqLbdnBXVie8BGHFg95vOGkQj4yQpn1rysebVYLCd3/16nvCF
	cesCfxm6LJh7cnCeZEBTD7EJkQlM7o0AplE=
X-Received: by 2002:a05:600c:3b05:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-46201f8aa61mr51947555e9.7.1758206507297;
        Thu, 18 Sep 2025 07:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6KtyNG51lUBBb+796Ksha+xJ3k91Ah4nN79uv8tPH32cwmgf4CIFGIqg2jBve/wowaCq5Rg==
X-Received: by 2002:a05:600c:3b05:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-46201f8aa61mr51947335e9.7.1758206506772;
        Thu, 18 Sep 2025 07:41:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm42562565e9.1.2025.09.18.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:41:46 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:41:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com,
	mst@redhat.com, seanjc@google.com, stable@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:

  virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this reverts a virtio console
change since we made it without considering compatibility
sufficiently.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Michael S. Tsirkin (1):
      Revert "virtio_console: fix order of fields cols and rows"

Sean Christopherson (3):
      vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed
      vhost_task: Allow caller to omit handle_sigkill() callback
      KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks

zhang jiao (1):
      vhost: vringh: Modify the return value check

 arch/x86/kvm/mmu/mmu.c           |  7 +-----
 drivers/char/virtio_console.c    |  2 +-
 drivers/vhost/scsi.c             |  2 +-
 drivers/vhost/vhost.c            |  2 +-
 drivers/vhost/vringh.c           |  7 +++---
 include/linux/sched/vhost_task.h |  1 +
 include/linux/virtio_config.h    | 11 ++++----
 include/uapi/linux/vduse.h       |  2 +-
 kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
 9 files changed, 65 insertions(+), 23 deletions(-)


