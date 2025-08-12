Return-Path: <linux-kernel+bounces-764865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F38B22819
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9117E1BC4549
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEA8275B07;
	Tue, 12 Aug 2025 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FI4H7F/C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88C270EBF
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004198; cv=none; b=c0hoaXln+pLRK+XovKe+xKXbQ2S3kXorYBbSkdm4Lrdb0hnzeLHrPMZSUv/cQHyIGQ2btdyasW+E3ukdG+0Fewewds6xy8s3iTEvMx9Hdh0WzaqccXiIE4Q+jeP4yRTG7KvD4f9/5tVX1SSg+JraMO3Q69K0dsnTy9dGXnLTqeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004198; c=relaxed/simple;
	bh=OhSFzyX49hT+emcatqYo/zwzamB0yKt6RKZcAg89LO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=VL8hDwMA8fLhIzPRNxwt+ZTXiizIaHxnZNZJ0mVQEg8zVxeTFSVUKNgtWJmqEpGLLVUhVINA73B5d4IP9fb0kWFmJ4bZcT+Q3llw1kdrBL3xKO9VgflE+LuP36wFF9Yw0J1az+vk8PHsTcMSQa9WOyif+PAAUcQt2oQianVoVec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FI4H7F/C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755004195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/cuxRnTF/+sbokXrks651YRr5s4tLHJAN7bhV7Yv7fM=;
	b=FI4H7F/CAR29cyBJxMXRA3e9PZKQhk8cnaAppHl3K3h4SBk/XcveNqZEDyiquxjamRYhfj
	KjRh6ORF2idEVKd1clvTRchVg0p38lUyMAEsO4Fo70sZ56y5zIhy+jKGgP2aftQNLY5yKU
	rqMAtttX0q4YNbyzuQJ+edFAXOnJKhw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-SArAZdPZOtigwjx2dT9jhA-1; Tue,
 12 Aug 2025 09:09:49 -0400
X-MC-Unique: SArAZdPZOtigwjx2dT9jhA-1
X-Mimecast-MFC-AGG-ID: SArAZdPZOtigwjx2dT9jhA_1755004186
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87D20180036F;
	Tue, 12 Aug 2025 13:09:45 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BEA8195608F;
	Tue, 12 Aug 2025 13:09:36 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: snovitoll@gmail.com,
	ryabinin.a.a@gmail.com,
	christophe.leroy@csgroup.eu,
	hca@linux.ibm.com,
	andreyknvl@gmail.com,
	akpm@linux-foundation.org,
	chenhuacai@loongson.cn,
	davidgow@google.com,
	glider@google.com,
	dvyukov@google.com,
	alexghiti@rivosinc.com,
	kasan-dev@googlegroups.com,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	agordeev@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 0/4] mm/kasan: remove kasan_arch_is_ready()
Date: Tue, 12 Aug 2025 21:09:29 +0800
Message-ID: <20250812130933.71593-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

These are made on top of below patchset in which all functional functions
will be skipped if kasan is disabled by checking kasan_enabled(). With
the changes, kasan_arch_is_ready() can be easily cleaned up to simplify
code.

[PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three modes
https://lore.kernel.org/all/20250812124941.69508-1-bhe@redhat.com/T/#u

The 1st three patches are from Sabyrzhan Tasbolatov's patchset. After
clean up the kasan_arch_is_ready() definition in loongarch, power and UM, 
we can simply remove kasan_arch_is_ready() checking in mm/kasan since
all the checking has been covered by kasan_enabled().

[PATCH v6 0/2] kasan: unify kasan_enabled() and remove arch-specific implementations
https://lore.kernel.org/all/20250810125746.1105476-1-snovitoll@gmail.com/T/#u

Test:
======
I have tested the effect of this patchset on loongarch, power and UM.
Will try to find machine to do testing.

Baoquan He (1):
  mm/kasan: remove kasan_arch_is_ready()

Sabyrzhan Tasbolatov (3):
  arch/loongarch: remove kasan_arch_is_ready()
  arch/powerpc: remove kasan_arch_is_ready()
  arch/um: remove kasan_arch_is_ready()

 arch/loongarch/include/asm/kasan.h     |  7 -------
 arch/loongarch/mm/kasan_init.c         | 10 +++-------
 arch/powerpc/include/asm/kasan.h       | 13 -------------
 arch/powerpc/mm/kasan/init_book3s_64.c |  4 ----
 arch/um/include/asm/kasan.h            |  5 ++---
 arch/um/kernel/mem.c                   |  6 +++++-
 mm/kasan/common.c                      |  9 +++------
 mm/kasan/generic.c                     |  9 ---------
 mm/kasan/kasan.h                       |  6 ------
 mm/kasan/shadow.c                      | 18 ------------------
 10 files changed, 13 insertions(+), 74 deletions(-)

-- 
2.41.0


