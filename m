Return-Path: <linux-kernel+bounces-762324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E8AB204EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7588918A0173
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711AD225A59;
	Mon, 11 Aug 2025 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4fqz4aK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F62222258E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754907004; cv=none; b=qxzi5qSO4UYwdJRjXbSxOQ3RUgaZC4xbjxJI7NH5hyj4Lr/72x08DfdvVW8u9OiIma1RAU4AE7CNvN/zi+HWnf2sef5DsAGDQ6ajv23w2pBsBPG9MpxPJjVmGcAu5HAxhg0s4rg6QGQaQsiQd3iWhz1dCTE66qQf/CX9yABAWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754907004; c=relaxed/simple;
	bh=ArzdlRRjJmGeM53R6VRcLqZjX7N9evotnkSHizSx02w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPRRNCrUrhn8NVQQPGl5xaBzWi69TQpE12+Pp03rmVaOVDzF1RhQMVSWeDlb5gz6ofjnduyBWzqRMYsNvHBtivwZCHVvxJgrIXbtlA9u4YsEJm2MTKO2DKowKw3DV+cKZiB/rOerPsRhdLeBzF0mmpviB7iJDQiJQnSqJ5wTNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z4fqz4aK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754907002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rBrzknqAgzd7JukeAoXkv0pdIP1fZcHbaMe4XwjCqzM=;
	b=Z4fqz4aKrcBRdkiv0zVnocJTCR1NP68G51a5egOOp5WFYRxGc98h07KvtE60xtjfqUPOz1
	URBOIgzmEKY6htLqa/dEwKXDGTF/pYFqyfGx29Zu+/YE6SkqoWbwgBLUavpA6IfbZmRQ12
	lhHoLyNLmehPKarwHFWzZXysqGrwT7w=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-I5vJCQFJM0qqHV6E7RgC4g-1; Mon, 11 Aug 2025 06:10:00 -0400
X-MC-Unique: I5vJCQFJM0qqHV6E7RgC4g-1
X-Mimecast-MFC-AGG-ID: I5vJCQFJM0qqHV6E7RgC4g_1754907000
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-61599108233so5228459eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754907000; x=1755511800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBrzknqAgzd7JukeAoXkv0pdIP1fZcHbaMe4XwjCqzM=;
        b=G0IHAFl6n7Ilf6mxeLkl2dBp/ZqJYhDns6jJPzja0YaiAHu9moBA9ZBZlN+yU1Atpo
         LoOoV25maD2VcGfI954S2VGTBxsqXrwxrqmDdPH3O83Qd43d8kZnpLGqzkAeY5dQqYLQ
         qmCkDIcdrEpdirPvZCENXuaA8uaTAq0G5qsm/ciKMjdZcIZFVDHkSc1OOQcvcMIVjh+/
         mqG56yZt160DG1TStbHZpC+sVKIlsqvI/TgMPiGjeTSV7gggUX+6M+Ffeaa944UcbtU/
         CDqAD0QVBvnYpcB8ntkQsJPGcBAr7b4EpQ9JAiKN48PYDwuvvyIgrIyyyXlReWdgz2B2
         qGPw==
X-Gm-Message-State: AOJu0YyQFjUEnosJITh6xCaJfAXkGxem5U133BiU7dq0vfB6d0s5qKhM
	XkvLVsQZeVyh5FgcwkqM9/m4Qjspa14h/Afmj1SbA3B1t8p9M/lwchxNTOSrwqUawZ91CyBTJcr
	ie/A/lD1CgnDDeVzOwm+SN3vCKDMPn0JLsoAFw55rX0nP3EhNS/3JHuc85kpZXzrJbA==
X-Gm-Gg: ASbGncuT0QAn4kQiutkqBwwHhGJQp6rKpOCj3IzfP1vOSu3/51MqHv/2UqW2RZ24JS0
	aM1h8N/UYm2XJJo+3TqvrZPICKyjQ92D2muyFkXzBXiICQeo2qMCAqZNGt8A+rqBNp1IqSXYGd0
	09E8M5gEQ4iCV0xPAMFWmmB/cGct+1jymAcOpoApydNiqHdCO5UrAx82oNdxWAHy2KdvjupN7U8
	HIDc3d1i/+aRAF53RxBnO3mtaK9o0UT/YcKyJ2zrqQXvzJ0jHzcW9Pvr7mw5uu7NfySuE9W+yGJ
	JxgUnSUlNOvtn4KSPhp/K8cj4XuH6ySJHYvpG4ckzQwUoHaVA73ygdj0gOEA9LBOJRtFtqclJg=
	=
X-Received: by 2002:a05:6820:4808:b0:615:85cc:339 with SMTP id 006d021491bc7-61b6ed3c184mr5812273eaf.2.1754907000158;
        Mon, 11 Aug 2025 03:10:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq2QQ7oXiIdgHaW5DRAGfOw5NbYt0mkKjXsuUywxvqtTNhy/9JeYZPPIHYotzuYg4v2A5y8w==
X-Received: by 2002:a05:6820:4808:b0:615:85cc:339 with SMTP id 006d021491bc7-61b6ed3c184mr5812260eaf.2.1754906999859;
        Mon, 11 Aug 2025 03:09:59 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61b84cb7630sm849522eaf.19.2025.08.11.03.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:09:59 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	idryomov@gmail.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 0/2] ceph: fix client race conditions with stale r_parent
Date: Mon, 11 Aug 2025 10:09:51 +0000
Message-Id: <20250811100953.3103970-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses client-side race conditions in the Ceph filesystem
where the cached parent directory inode (r_parent) can become stale during
concurrent operations like rename, leading to incorrect state application.

The first patch adds validation during reply processing to ensure the cached
parent directory inode matches the directory info in MDS replies. It refactors
the path building API to use a structured approach and prevents applying state
changes to incorrect directory inodes.

The second patch addresses cases where r_parent becomes stale between request
creation and message sending when the parent directory's i_rwsem is not locked.
It validates that r_parent matches the encoded parent inode and updates to the
correct inode if a mismatch is detected, with appropriate warnings for this
rare but problematic condition.

Alex Markuze (2):
  ceph: fix client race condition validating r_parent before applying
    state
  ceph: fix client race condition where r_parent becomes stale before
    sending message

 fs/ceph/debugfs.c    |  14 ++--
 fs/ceph/dir.c        |  17 ++---
 fs/ceph/file.c       |  24 +++----
 fs/ceph/inode.c      |  59 +++++++++++++++--
 fs/ceph/mds_client.c | 148 +++++++++++++++++++++++++++----------------
 fs/ceph/mds_client.h |  12 +++-
 6 files changed, 182 insertions(+), 92 deletions(-)

-- 
2.34.1


