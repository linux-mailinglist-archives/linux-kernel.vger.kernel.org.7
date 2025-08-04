Return-Path: <linux-kernel+bounces-754955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354FB19F24
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC19164E21
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38742246BD8;
	Mon,  4 Aug 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN17U9RB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E132246798
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754301597; cv=none; b=S5NKQmd0GLoEJdWrMo6CzkXoD2pLs2l8QEgOy9kx99Okeph7MjKz55pp9P67zYxwn5gg9InKfiFKsF2xVzb/SwJ/ubO3pauHKUvlQtgk5r760h6Ptcn9xd+ca253H14m8RAEo0I9NrO24u4eaMUQLRBT+Jr6gloB5Ra9nBr958k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754301597; c=relaxed/simple;
	bh=86xZu00+UDnBPH6MuEJGYfj4bcSnDnN94cUc+QXGuL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ha+br5c9IYpdxctjOqY/wH5MNJ4P9mnXPKvd9Jn8sVCjFHzTdV8qzywRFuXIk47aZdfGyn2XircHE18kLcFhCC7arSPhJv/VCN2Hpj4J7xjMv/fwbqkyf1hvGK/fJqeaZozJ4EdL87YVBWMmAD7lhw1Y3jPqYYJwPhBprlcDyGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RN17U9RB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754301595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hNbEQ0dntB4TZw05j2S92XHQV8iXE8KzN/fVBin+25o=;
	b=RN17U9RBkmtAz+AMQvH+bDT34oGY/W2zzYuKjcEKHaOX1ROEsNKq9KddprCeNgf9VzJpXY
	uTPUfBglFuR00RvPcjFuMPA7EOQ7htG2AXbhctVrjXZraZ0KzuH6t30W6TZvEp0K9ohRdc
	X2pCzz/4qMgqM23c08uYTLD5lYm06iQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-mrirQ3iMMmWMqZqQzc30Zw-1; Mon, 04 Aug 2025 05:59:50 -0400
X-MC-Unique: mrirQ3iMMmWMqZqQzc30Zw-1
X-Mimecast-MFC-AGG-ID: mrirQ3iMMmWMqZqQzc30Zw_1754301589
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-af94c842282so171519066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754301589; x=1754906389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNbEQ0dntB4TZw05j2S92XHQV8iXE8KzN/fVBin+25o=;
        b=aJZoZMLMg9Ow8BbKV6SyGV9hvZ++RAQMqh06IJBJpTalo3BBYWkMR//RYLusll9kOS
         K3lJfeWStrv4gJ1GoLDMntCkkPNHbRWFdF+hvLAddeTtUi/AnIwqBWLdNfxOw+Hjn9SU
         UbiPu5i4+ougTX9xyyAFj7sXblPBbR+Zf2nHFhVptv+7/1VM7OLYgOvidbS2MyJQd56T
         62blERYYBLrJOWxmYGtjzd3+rNGopKTM2LudqavwK+iw33mHYXjuYNsvM8C1+ytQ4FQK
         iwFuIt22XQ/X9bTvYFHiu+o6WIAMLM7jONqBYhjKt+LG7KYywQ4QWs+UBYPkhevvYi5B
         d8nA==
X-Gm-Message-State: AOJu0Yx2WMYpZ03m6cqAI0CLpDm5gd9sE7GO6u/MBSz9N7bBovUjU11/
	d0Fl0/UPpF4p2vxf+Z5Kf7sVmXm8IaGQgLqEvPkbSiqnuuh8vs7uoiLYzxg8hvZloDksMMYRjJa
	jel6QF5LEO66BA5sMqqoMGSexOeDHYgXAg2r9K9t07Z7nX+hJpZz1Tyjne8CZR8uDzQ==
X-Gm-Gg: ASbGncuGobKzupJFRdHnCaywqCnCyKXvx9EZORqgPl0aMWLB2nIAoD25RI/9NWTC9ut
	FqwFiC7BBuOGh3G/tjDBeRrR/LvNhErqzd9FxgaTBF8H7tT4PxoQAtlkczGYcrYjFUQJi1Hi34c
	vTww08xuzOz5auiyV5WPS8Ihv1sObUK/YxE43WEJ8Xkez2pUxNT7hVRwoj7flcjiXHa1oVxJNGV
	EQ/eamYyJywsKWVXpZBXMV/pWmBYYKlKl+O9CD56FnQcBnkdb/fcZPj86fnWN8KrRgkQOlVZ8AQ
	3NjBRSfOb2/IvQnZQ32cwCBGvZSfd0l5csxyBD1NQyWgE2w9M+ppoH3ViHnLSWcQyPgKHQMowQ=
	=
X-Received: by 2002:a17:907:7fa8:b0:ae9:a1f1:2b7d with SMTP id a640c23a62f3a-af94000b3f2mr831447466b.17.1754301589102;
        Mon, 04 Aug 2025 02:59:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb2HHPuXvQ2LMWAETW8wVTYltytg19lKiAeoJsOqTr346zSwvOEP8YFFHQOXGIR1fQ3Fgsnw==
X-Received: by 2002:a17:907:7fa8:b0:ae9:a1f1:2b7d with SMTP id a640c23a62f3a-af94000b3f2mr831445566b.17.1754301588728;
        Mon, 04 Aug 2025 02:59:48 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078bcbsm715458766b.13.2025.08.04.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:59:48 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	idryomov@gmail.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 0/2] ceph: Fix r_parent staleness race and related deadlock
Date: Mon,  4 Aug 2025 09:59:40 +0000
Message-Id: <20250804095942.2167541-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset addresses two related issues in CephFS client request handling.

**Patch 1/2 ("ceph: fix client race condition where r_parent becomes stale before sending message")**

This patch fixes a race condition where the `req->r_parent` inode reference can become stale. Under specific conditions (e.g., expired dentry leases), the client can perform lockless lookups, creating a window where a concurrent `rename` operation can invalidate `req->r_parent` between initial VFS lookup and MDS request message creation. The MDS reply handler (`create_request_message`) previously trusted the cached `r_parent` without verification. This patch enhances path-building functions to track the full `ceph_vino` and adds a validation step in `create_request_message` to compare and correct `req->r_parent` if a mismatch is detected (when the parent wasn't locked).

**Patch 2/2 ("ceph: fix deadlock in ceph_readdir_prepopulate due to snap_rwsem")**

This patch fixes a deadlock in `ceph_readdir_prepopulate`. The function holds `mdsc->snap_rwsem` (read lock) while calling `ceph_get_inode`, which can potentially block on inode operations that might require the `snap_rwsem` write lock, leading to a classic reader/writer deadlock. This patch releases `mdsc->snap_rwsem` before calling `ceph_get_inode` and re-acquires it afterwards, breaking the deadlock cycle.

Together, these patches improve the robustness and stability of CephFS client request handling by fixing a correctness race and a critical deadlock.


Alex Markuze (2):
  ceph: fix client race condition validating r_parent before applying
    state
  ceph: fix client race condition where r_parent becomes stale before
    sending message

 fs/ceph/inode.c      | 44 +++++++++++++++++++++++++++--
 fs/ceph/mds_client.c | 67 +++++++++++++++++++++++++++++++-------------
 2 files changed, 89 insertions(+), 22 deletions(-)

-- 
2.34.1


