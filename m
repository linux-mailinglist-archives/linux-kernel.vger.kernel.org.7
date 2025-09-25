Return-Path: <linux-kernel+bounces-832482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F6B9F6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721283868D3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED2121A421;
	Thu, 25 Sep 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DECKPo1S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7342101AE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805822; cv=none; b=kMOQR/dxN9GtluLTCQRbw0nsV876sjN8T0ZE3EO5UNKXx8gRHeQtzJDnhkF4o5TkmYebYBruNna3z8RydYHYWzfBKnN7jkEbe38noNSSGmJOXR/IvS3nN1yjaS+irhxDQRUWcvZc85skypcYWq2+ObnB+fbi0/+7y7A3Of5Bs60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805822; c=relaxed/simple;
	bh=0B43x3hO60s/q7zuJq3RHOjXfJvIsP5KZNO4MN7Tppc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qJp1NkghCkqDVk8CP5CNDdnFqDtHM9vxJovRI/iDiUprfWeG1d1A0r0HqncODIc4Za3X35nj4KFyUIy9VXJcAyfY44DiYoKW5gMNkZ05jtKLvjwUDquFWfGjJh+O9igBR8fVBhOvxCe64TKwZetLyDEGUNvEPrDzFd/qdd4eXnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DECKPo1S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758805819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KW0ZC7vXwF1U7peaSsttqsWo+PHv2YRJfJzgYOs3pfE=;
	b=DECKPo1SUylXy39P44wVpzMhUT+EypRxLpfO4IcaL/fBeyI+Wu13YdAbJ98dYjb/+o31O6
	/0ZNnafaqFkkWgqVn51c5pBwphpaEDiRvAeY5ZedEHxY3FXWxJ5p53xWiP/6rWYuqBRSxS
	oTiaJa7kcFOxICzJvnV7OjhxoNzjBCs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Cu1lolAHPZKhnN6WBnnOdA-1; Thu, 25 Sep 2025 09:10:17 -0400
X-MC-Unique: Cu1lolAHPZKhnN6WBnnOdA-1
X-Mimecast-MFC-AGG-ID: Cu1lolAHPZKhnN6WBnnOdA_1758805817
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so632745f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805816; x=1759410616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW0ZC7vXwF1U7peaSsttqsWo+PHv2YRJfJzgYOs3pfE=;
        b=wGITgKXWScQiSLVIvTP6sR+v3idBv30ZnPsSimTmq9B8crf9JS45ph+WrZ+EdXqre2
         cQq8ebIsZpaHbS0uI0q1dRCSW1H4bhPAgwGt2XoEj8CsHbKULvP09d+boNJKsLK/JPIa
         rWfDDoITXZ8wVkBnvvxTzu0z3YEgIP3ClRHyfQgyMJnE/d/X0tN8HlpQdYrivhr2WdMm
         VXZxClN2jVEv1IltsHOv/ODGBTgOh07X0iBAW1O1IDk6MZN9vFs4TJQpF1yMsY5RfQIR
         vvs/R/TaoUBNbPvekbD5GaFky3TWmiGZexa4/p3Q9IDCBlFnxUWQAwjOZGO3owI+WrKO
         kP9g==
X-Forwarded-Encrypted: i=1; AJvYcCU91XAwmz9EHM34+6/4/n+C73pQTYzg6AFQ9EoRqpZWRP26qtKmljC2DJr4wZGVtiep1H4NHXDouion9Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYmwKRlweR9eGcCsoU3pR2GWyUcuhuNtFLlU/68p0UXlM0+Zos
	LxDv3M0b55MirF2s7e6aCGMp+HRu1GPn7gshr93Uw9ruWy8CjVEjeJPknB2EVI91Q7AfQ39nX0s
	iwXSErbFMq4EqcUApirKMf5xcx27Y221wcIPrsuEdsVcxwMrC2HAnHjjtb3ugHQqzRw==
X-Gm-Gg: ASbGncsjqxaY8NzC6Is5b52C5CRVIuSQzABTgzlG3r39Jb5lTrq72akETeAcCzbB19r
	3/ZuhpIOMAY6aVvxgWxCRfibXDpCMF1xKYeoow95lr8mT0V3HOeZuh2ejTqJ/hs9Ph+NdoC2PY7
	wzoIvhECtW5imaGsotO5KnMfNomZE/iX9XbhwlC5EdbqepMXxCXa7drOkijqyzCDFulqPP2QWF1
	zbvHirBnjb81K2PyksLFJDvVvxg0RNaRqaDwny9RvInWzlsEVkGJpybWzOI1yYl+9kTw5RGTXrX
	W7ljLesvxITwLW12wKM9+iFuhiZW8aBVwA==
X-Received: by 2002:a5d:588c:0:b0:3fb:37fd:c983 with SMTP id ffacd0b85a97d-40e48a57465mr3216280f8f.49.1758805816378;
        Thu, 25 Sep 2025 06:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzU/fT07/taXxNhpSlgViOVy92VqAS1NyA0bx0hGfqPg/L3VBSKrQfSmeVvB7FScm07URuig==
X-Received: by 2002:a5d:588c:0:b0:3fb:37fd:c983 with SMTP id ffacd0b85a97d-40e48a57465mr3216242f8f.49.1758805815830;
        Thu, 25 Sep 2025 06:10:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72facf9sm3112468f8f.13.2025.09.25.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:10:15 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:10:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, bigeasy@linutronix.de,
	hi@alyssa.is, jasowang@redhat.com, jon@nutanix.com, mst@redhat.com,
	peter.hilber@oss.qualcomm.com, seanjc@google.com,
	stable@vger.kernel.org
Subject: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250925091012-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

I have a couple more fixes I'm testing but the issues have
been with us for a long time, and they come from
code review not from the field IIUC so no rush I think.

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cde7e7c3f8745a61458cea61aa28f37c3f5ae2b4:

  MAINTAINERS, mailmap: Update address for Peter Hilber (2025-09-21 17:44:20 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this fixes crashes and hangs in
vhost-net.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Jason Wang (2):
      vhost-net: unbreak busy polling
      vhost-net: flush batched before enabling notifications

Michael S. Tsirkin (1):
      Revert "vhost/net: Defer TX queue re-enable until after sendmsg"

Peter Hilber (1):
      MAINTAINERS, mailmap: Update address for Peter Hilber

Sebastian Andrzej Siewior (1):
      vhost: Take a reference on the task in struct vhost_task.

 .mailmap                      |  1 +
 MAINTAINERS                   |  2 +-
 drivers/vhost/net.c           | 40 +++++++++++++++++-----------------------
 drivers/vhost/scsi.c          |  2 +-
 include/linux/virtio_config.h | 11 ++++++-----
 include/uapi/linux/vduse.h    |  2 +-
 kernel/vhost_task.c           |  3 ++-
 7 files changed, 29 insertions(+), 32 deletions(-)


