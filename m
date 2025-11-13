Return-Path: <linux-kernel+bounces-899042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91287C56A7C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43763BA983
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A68B2D7D30;
	Thu, 13 Nov 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QygXnAAi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tMomvOAR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18E257859
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026477; cv=none; b=I/UMWROtygAODMAdCoy3S7NruBJ3vKq7irc8RfhljE8UHg+b4meCHnPSJdXPj4YhIW8iJs6czHLu1SZZ9UJ+AseQoatWodm2vk7W7RXfNDhI1CP5LwPnpRt+ZIit7dDafHT3mHBs5fBfkLS7iVIvVPRn0lCVPXnXKgFn1KmUlA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026477; c=relaxed/simple;
	bh=fc5r4/KfQdyp56+ox5TZmaUcK59Vz1PNuxe07AWIInY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E2+JVDer/Erh/1lvNgLmeX3qe6myzgPnle8hS1QY2Ov01S3zoeaZ1XkaplCZbYfwjbrLZVLLzDCi9qI22ErRByzqeepWnPCKuhW5CP649RarOtHyOoRd4zoHAeVEraCwQ71AkL5LoKPovhoZYKhk//E+kdUj1prcjapQCJzjCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QygXnAAi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tMomvOAR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763026475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Xs5EesSEzP5WF6QjZEDaSOvevCXi9zyOPROXmwS0Wa4=;
	b=QygXnAAiK2zZmWtag4RxfsxkI69d+QUoXw1ISQiHpamMeq3eZOPvv0LvlRlYAYfX5dLMak
	IwRRNT61upV1yYwU9UNLP1UYNyE3r8+zNDesPhgayeA2dHxpthBO/LfaNIsi58Ox72nMlB
	oJZsK0S4y/v2bWNIANxCCBQBUz33zyc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-BymEzbiROiaarQ1JFCvN2g-1; Thu, 13 Nov 2025 04:34:33 -0500
X-MC-Unique: BymEzbiROiaarQ1JFCvN2g-1
X-Mimecast-MFC-AGG-ID: BymEzbiROiaarQ1JFCvN2g_1763026473
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42b2ad29140so279337f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763026472; x=1763631272; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xs5EesSEzP5WF6QjZEDaSOvevCXi9zyOPROXmwS0Wa4=;
        b=tMomvOARlbheSk/9TCPAQNetk2gMkROXMNa+XIKRziO1h8x1dSY8qc9Ht36Aiou/Ry
         JHvasy7HPpq1WkBrpMpB2zBUha4lKtvp6EeLqBhVTW0V5YzMWqCiDgj/W9msZN3pIw5t
         3vVfcB20djGC9ZJNi/rLPJ67+v0Z5EJZPbnwJyIpswHY3wjyJ92npj5URpZDMZ/k6VJL
         ZT08q6m+8B8wjJVOjbRIRRFh0vTMLaesJrm5UDdbU4bg7BZweR1JFPPFBRXAt1q1ZWII
         +oa9KdZgIPFC1dl2a4yg63VJADANby9TR4gP85JW3JXTMgic2okCuewwNlzUmtq4NToW
         rbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026472; x=1763631272;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xs5EesSEzP5WF6QjZEDaSOvevCXi9zyOPROXmwS0Wa4=;
        b=lVSOBDslAkw7nuMHNkpW+h2+DqSNFowVhZGhOtmMUQLgJqYRCwBd+t8zORpEURsaxN
         Xa2Uc7tKcABVZqWR2NCqFwXoIou5Qpnu6YoU8pjIFBshTj2cJhfpit/MMaaklK3ISHnx
         PpHfOfM5sse454b0lCwjyKmhu3Fg6D+vxRkYPU+Fa/cquGblHO2EEjLRbQ+rjQmDtSE6
         mL1cgoQCJD6dnFUWKllRXj929HyJPO6wZ5Izn3/mBpkiqWhjw2Tdvuhfc+eoOKwJZGf0
         IXx47XzdIzq6dKo192IWfYxEmSy5JiEyKtBkcEl59tLurN3awg4y4LEEIUVTSSHDxDvk
         /jMQ==
X-Gm-Message-State: AOJu0YwvcydD8nKwAv8gKs1jfhjg7jwL/+8rGhFdmWqQRFMVTidI2i4c
	u5VQlnOHAcaoYiru4BeqId31DGeXU6kEsiKoCXcl+4QSxziE2qhZ8fnCmnQosIGh3uSiF3bKpNm
	qW1UB6qiJFsPGL3GJNOQXmHbsW405plyn5W74Z+ldbIrD6Y0b+hSn8rlGLxpoPYw5z/WE6YRVg7
	RtN6aeRua0iXUjzJZcJ64zrE4T7JXaqhASe4aIJBKcwDvung==
X-Gm-Gg: ASbGncu4VlmRJ5EmJRAe5bQW9ZJ2NdVOszL5xBDQCWn0k6lj1zJkzwxnSVauYyKqoA2
	XKVNRo3rBZqybW25hgDdn6zCM0NH4GO0C0Q2F3QH/bJuBreLk94aNmsLb5wnROoWMFQbR6ac1zX
	aMpgCbVJrshxY0g3H6dWRswDweRQwnyJGOIBOZVKKfkwDY+UdrUE7SA6Y06rE/HTl5xcCooCF0Q
	CqGYHRI9uvco95i/1vbcD4CMBNtqXom8fF5KBafyNlt1XTGIO+vvVmZ+7Mlxni81WuYA1Gxahr1
	SsdonACh7vpIrKM59Iu2H2RDZyPFNeCMwmfX0Xux1gVMzsjgZapceQ9lgcXaJrvJ+wks8kfi5YO
	rUCyeyPN53f30ob/Zt/A=
X-Received: by 2002:a05:6000:40cd:b0:42b:4803:75e8 with SMTP id ffacd0b85a97d-42b4bdb44c0mr4083202f8f.43.1763026472166;
        Thu, 13 Nov 2025 01:34:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhN76bOK/pwaEIizHOC7i8CvqfDad0ToCJ1w9vbg03jL+x170cGTp9oboc6fuT1Pnc0poPIg==
X-Received: by 2002:a05:6000:40cd:b0:42b:4803:75e8 with SMTP id ffacd0b85a97d-42b4bdb44c0mr4083165f8f.43.1763026471534;
        Thu, 13 Nov 2025 01:34:31 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f2084dsm2825614f8f.42.2025.11.13.01.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:34:30 -0800 (PST)
Date: Thu, 13 Nov 2025 04:34:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/8]  virtio htmldoc comment fixes
Message-ID: <cover.1763026134.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

This fixes warnings reported by htmldoc as well
as a couple of others I found while reading the code.

Jason, I found a bunch more issues with the map ops patches, like weird

/*
 * XXX
 *
 */

multiline comments, weirdly formatted return, inconsistent use of
"the" for some parameters but not others.

Pls take a look and address.

Michael S. Tsirkin (8):
  virtio: fix typo in virtio_device_ready() comment
  virtio: fix whitespace in virtio_config_ops
  virtio: fix grammar in virtio_queue_info docs
  virtio: fix grammar in virtio_map_ops docs
  virtio: standardize Returns documentation style
  virtio: fix virtqueue_set_affinity() docs
  virtio_ring: fix htmldoc warnings
  virtio: fix map ops comment

 drivers/virtio/virtio_ring.c  |  3 ++-
 include/linux/virtio_config.h | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

-- 
MST


