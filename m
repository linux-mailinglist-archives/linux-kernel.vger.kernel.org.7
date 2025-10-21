Return-Path: <linux-kernel+bounces-863184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34284BF7333
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B8BC506299
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66707340A41;
	Tue, 21 Oct 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOaH5L36"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6534027B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058620; cv=none; b=qo06xIfOcoG70ozuX1g5C2azsLTnhZYgFymmKD4jQYp/Cjn4cdaVugN2feGrAVc6j836PUnR2849e6uv/XfSZWpkHX8oPh0MEIByb+YimvBuKb7JOiG0PYGpPk3N2hShp29RLPqDPnqWY7bU/N5pVcXNmTjDGwn8vJWAW8aYh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058620; c=relaxed/simple;
	bh=lB0O8j3S3miMAone/f+ICAYtXJf1J8inqWCWvoB54Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IxzLhwhgkNdIDq30pcc0pm+ulpUW2R0qI7AgOODG9YJC6BJyu7z+Sbusj3VE5Hy5ALSJ3AMkduNVNCv0oycFNKr1rN7bBn4InyIvFPh+NzkLdNWEE0EPig/+qdl12c+HXNxTCwr9PfUStjJs5JLAndSIgpXahtDUn0Q37ksgAy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOaH5L36; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2Ber0DwJnF+w6pf5w+EAkS6wDZY1zESW0Eqmz8tJxow=;
	b=aOaH5L36d22Ik5OkCJ6xlYJrN8igtZbw9XUDEXPPGKlqHYsUZEedM3IsT5hFHziWwQ41CQ
	e2emQ0Lo6p6bzcjWePNActZSDovvbCSsfHZaBISlxEraRR1hvAMN9ujd8LF9wTsmRDcLwN
	OSkbkpA4RJbjoWfP/jzryG0rZW7b7Z8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-ZW0swXBmPqaJ6CEVXpS5MQ-1; Tue, 21 Oct 2025 10:56:57 -0400
X-MC-Unique: ZW0swXBmPqaJ6CEVXpS5MQ-1
X-Mimecast-MFC-AGG-ID: ZW0swXBmPqaJ6CEVXpS5MQ_1761058616
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47108163eeaso27685785e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058615; x=1761663415;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ber0DwJnF+w6pf5w+EAkS6wDZY1zESW0Eqmz8tJxow=;
        b=T3qd8hdxBgW53phnuCrGJZrykprDAYIi4JAiiZlbU3u5qPKmEKk2idljxk9svXjKqS
         8HjD23maBJj3K4fFk4Z9zuVpbOUFnaEbPZIcgCCDJwlcKvlDqHigVOqflCQ+mFrDP3Vo
         +1GnKOHT5UNSpB+SGhr6l2XaPCxpNhAVBqRYM5fv/BhwdBWn/hatazAixxF+b68ygEt/
         +243UAC396555aUOvPQ1MCpGJhZRsNe16rKzALSwuGSyVjeGNcygkDpbBI+Rh00bAiJz
         KYh6vV4VeaHDnm/8brKLW2CYLGKWJmvayYhGRK8OzRM+l+eoMCZxRLQVmQnzvCpjV0hv
         nPTw==
X-Gm-Message-State: AOJu0Yzj6XmvixETvOjgFswE9ovqTUgkhWVflGdLkc6emneMM9KNnhqX
	QQeqUOv+rbSReE//Wq5XLuthGTy0Qctyo0eIzcqe975qS1R2Zq2FNGTYElYWWIaG08sY/igJ8uB
	jM7sndg0BH9jfhqE/64oYJ7AMPeKCp/Z2dguR2s2sQllVXk+2H/3ujrCruaCmE914Et7LnFcX61
	ni1UzKshdc2W8q77p/Xvxrs9K3I1SKDqS63rOag/LOtZ4=
X-Gm-Gg: ASbGncvg9zZMB5RH26Ey+SOhfU0Y+0aPh44puTnzEqigLPUTwdtIT3MqUpAtlAP3Gqw
	mfdktX/KwC56HAAQQvW73WYzCQBgxI2xeyEArwtRW58O4rGyxJQZFXZMAn5fj73gOxrSoDExs8E
	sCnP4bRXtdTYZUX/JO6fDCBI3PO/gTi90L54UpFk2Mio+OEE8gliF2LURHyN9v4zQQRC8gUnwaS
	YKHO4HbyJ3V+Gzwg/M1D0ZxKeh9m5zxda5SzBVMxJLl+YVqmxe3+JVRmcRkBbxAO39m1MZ9AGCG
	KdLY84B5+trCzbeQNacJUxu8QsszMwe9Do6U4jUP2dIf7ep8Gf3/r9aVMdzx9iBzVptl
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr124347155e9.5.1761058615497;
        Tue, 21 Oct 2025 07:56:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFktoT+limgbPVdpx1wPopFmtIPHLY2OPatp+bLIP4HKwWumE1HcGxwTuzl98f6QYo38c2HQ==
X-Received: by 2002:a05:600c:828a:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-4711787617amr124346865e9.5.1761058614813;
        Tue, 21 Oct 2025 07:56:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ae5510sm19394145e9.3.2025.10.21.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:56:54 -0700 (PDT)
Date: Tue, 21 Oct 2025 10:56:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: [PATCH v2 0/2] virtio: feature related cleanups
Message-ID: <cover.1761058274.git.mst@redhat.com>
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


A minor cleanup around handling of feature bits: this fixes
up terminology and adds build checks.

Lightly tested.

changes from v1:
	dropped using "word" completely


Michael S. Tsirkin (2):
  virtio: clean up features qword/dword terms
  vhost: use checked versions of VIRTIO_BIT

 drivers/vhost/net.c                    | 16 +++++------
 drivers/virtio/virtio.c                | 12 ++++-----
 drivers/virtio/virtio_debug.c          | 10 +++----
 drivers/virtio/virtio_pci_modern_dev.c |  6 ++---
 include/linux/virtio.h                 |  2 +-
 include/linux/virtio_config.h          |  2 +-
 include/linux/virtio_features.h        | 37 ++++++++++++++++----------
 include/linux/virtio_pci_modern.h      |  8 +++---
 scripts/lib/kdoc/kdoc_parser.py        |  2 +-
 9 files changed, 52 insertions(+), 43 deletions(-)

-- 
MST


