Return-Path: <linux-kernel+bounces-764499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89428B223D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA2917DE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103792EA739;
	Tue, 12 Aug 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsSqbJEV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4839C2EA178
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992668; cv=none; b=IHDDWjuZODhspkJOTby+m1xdN9L0Cn70tTy54RhfOAoR6qRa+sVaiEcmxo4/32YeOiU0hV+b5NrigWwScjN5KczXp1tRVaNxQlWIe1Kg92nnO5cbBTKqm3OrNpBvtK4Ka1GeVZbfCLX+x8zcqbclOQUSbiwibkNyusT9yZNoP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992668; c=relaxed/simple;
	bh=nVn0POSwkcWMaC1jbZnEy37aapLqX1FOpohl7cvgnzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FVN8xhBwRJp5ALBOmHqRqEqrsn1RTs8Uo9/8nL4z+ETTWa8OLSKot+2YHuR2Jf6RuCMvNrLUkWzs0oFt8bz2RHBk690T372R5oeVC2abMM7+46Lea1uL5PlWTAEASrJphfutq+D+NeoBy/OsKkyBbcZgaaZgRYe4aaeN53Ccsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsSqbJEV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754992666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C1x/OfrbyvlivDoeYkRGWs+/omb3R/XBJnFzS6asuSk=;
	b=dsSqbJEVYrUQC5xn9fXqvKIpQEvbHIdQBCSDBeYvq3vBYTWDfOuR5hPZnZwVk9PeZflLj4
	le2Le965LB4IRkoyhTubCK8ZFFqWTne/+L7xkUasNAuqOYXg/W4VRC0By5QaWVWTIszr2+
	/f311n7M2iMjDIzzuwkBsTSAQDQVZnU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ERUlLW4FNr6ipO7dmV0HEg-1; Tue, 12 Aug 2025 05:57:44 -0400
X-MC-Unique: ERUlLW4FNr6ipO7dmV0HEg-1
X-Mimecast-MFC-AGG-ID: ERUlLW4FNr6ipO7dmV0HEg_1754992663
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-af97757b46eso556717066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992663; x=1755597463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1x/OfrbyvlivDoeYkRGWs+/omb3R/XBJnFzS6asuSk=;
        b=vXNSqWfvOk0Wa0ix/4RNjJVeyJB5gBNan1uK3ddnUb6ES03oBexGcDAz0qlzVd9OZz
         R+TJrqGU/an77PtTuna3/8vMlKtCvvjhTQ6GJcHqcTAaI71KfWjvjHfXv7xfY1qdYUvg
         cZyfJEtNmCJQV1BzuLtcZbopCLRCq7qdVc1QzA4V3bw9tIOYZZ47XoD4rTuadLnFw6vN
         IbLCoXQ2r5vy93E7XpLsCqe7WYs4to4PbMCQuEJZSvLkRJG8NeZG2v6/1PRi52Fs4AX5
         JXidZHPu7LE0V0828rPIyJm/Fr6J+DCvZNKMbrFvFUBxzs27B+vgMQ3tOuxlvM+c/3oY
         hUMg==
X-Gm-Message-State: AOJu0YxXYxg7t93toLBlg/QHHcevPzvcmmm6wqXIxP6GRTNu+rnlmXLY
	MiMthdU/nQAgzuHEL0nDwfa2D/h8ZODWVxd0VwcYfeQQ7stYVAeiXntyE+m43Y2G4c9cRyaeV1Y
	1j1djKm/xuZi5rDku7G+qnNVdHHwqkwaNcfmKJ9y1M8w53TZ2s1zU8mvvo2lwG7vUUQ==
X-Gm-Gg: ASbGncurerllS8argYv2Pbux8vUR8eye5VnU5aYHvMmc3OVD4Ah8MwsDKnKVJdPgpau
	RmrQbxfO38/5YMSWeMEV/3ibPxt0skWlJ6hXUrYYA4/PPDHeO1lhPG9F7vDBHk6vm3QueZz/Ba6
	nyBy6aA0gRMaXZEa2MC0yHEUX1XJ2WEcMcUsu4HC9mM87S96emC4ehi5EfOQsaZjFdgNmg9K+IJ
	guHzStqjhZWJHlvLipBcdu+HFsSNhAAs+PswwqHGZvQ3Kt7BwTfl0cviPjnLYA3YRb/W6aKGCMr
	ZJ4RIeSfRz99CyEkDqSGXX4JwK94kN5SXzDkL+mhaYNkXTqNu5snmA7oScl+rg606CMx6W6cFQ=
	=
X-Received: by 2002:a17:907:1c0f:b0:ade:9b6d:779f with SMTP id a640c23a62f3a-afa1e12ec39mr234739266b.32.1754992663202;
        Tue, 12 Aug 2025 02:57:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4H6r1rDXLB4/W9J+K5dQYmeE2JLHMHIw2xHSDqxHJoSowoENjgFZeVCZOYOrhQKyjZFVIQQ==
X-Received: by 2002:a17:907:1c0f:b0:ade:9b6d:779f with SMTP id a640c23a62f3a-afa1e12ec39mr234736466b.32.1754992662712;
        Tue, 12 Aug 2025 02:57:42 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c0a4sm2180821466b.109.2025.08.12.02.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:57:42 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Slava.Dubeyko@ibm.com,
	idryomov@gmail.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v4 0/2] ceph: fix client race conditions with stale r_parent
Date: Tue, 12 Aug 2025 09:57:37 +0000
Message-Id: <20250812095739.3194337-1-amarkuze@redhat.com>
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

Alex Markuze (2):
  ceph: fix client race condition validating r_parent before applying
    state
  ceph: fix client race condition where r_parent becomes stale before
    sending message

 fs/ceph/debugfs.c    |  14 ++--
 fs/ceph/dir.c        |  17 ++---
 fs/ceph/file.c       |  24 +++----
 fs/ceph/inode.c      |  59 ++++++++++++++--
 fs/ceph/mds_client.c | 165 ++++++++++++++++++++++++++-----------------
 fs/ceph/mds_client.h |  18 +++--
 6 files changed, 189 insertions(+), 108 deletions(-)

-- 
2.34.1


