Return-Path: <linux-kernel+bounces-757993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF3B1C974
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDFC5189D71C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55849235C01;
	Wed,  6 Aug 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="otZTRT4m"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC185293C6C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495952; cv=none; b=YeQ9O7uBpguKiz8fBQyuG8Vz6cP+u1kgBcRBpHA0v5/NjSkBL9KVPt1jUnlRc4VetMYYqkD5pClLlOOsOpcJGc5bwTddEBU0KJ3y1syfdzRhfPk7vsYk95FjJzMWw3tWWpn9B0QlZirmYqyybdnOJIFtQ1Bpnva8W8gBLeIf6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495952; c=relaxed/simple;
	bh=jzjRn/EZFD0qAQ+PJvsX6Uv6SB8tn7O65AU/5V7/ImQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RVadRHOhIkH5sV9wrgkHGq+ItGO5E5zAgqqjRZQnBAdz3MjyZApv93YJaxiZ72NEiGiSStW3FkOjGz+vd20UZlIVzFQCKshzIUjpnkMIg5yx788CbdVyD/hZhlLh7Z6CZoeHOeqsVBqU0uupxtzoN670b8xsIotQnpjQ792S+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=otZTRT4m; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2403c86ff97so80687065ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754495948; x=1755100748; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zAHdeKYizePAgk53VMIm61MpWp5aV7NGmFxaAW2qcsU=;
        b=otZTRT4mpSiUBkcg3U2OkNkL+5oTnrbWazEZ1grVG6Zx4eMBGz0x+QriBzxdeOX4sO
         lQghchVPU1rAnvrwZGgvNPxNYzKlDhG0oVKTbOXlLdxuqeGTqH80PreGd1QqmGCHjXEf
         5/uf41EYggwk7oJ4paTDsIN0MbaY2U+oWX/G0n1+bJlX5cBuD+c+l0JIf/I407kgGCfu
         MQWBMbLvarQBspoE9MJe1qWEkvWBIDXFEjdqrGwKWd/0w9DnHRA8tMJ2rawQqi8T68qg
         MJdg5TQ+hQKaAuIIqSr6cAIP5vLoNwqEP00NFCU2mJgQGUk0Jgj5kPl6VdiYjibRaFuP
         e2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754495948; x=1755100748;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zAHdeKYizePAgk53VMIm61MpWp5aV7NGmFxaAW2qcsU=;
        b=PM4kQHz9YxcG2JzlH+Q0n+77ne549F9U/6jKGVebsKFMRolKj1EyKF6Q2d0I+1/Twf
         Z/RvCzrvXxcyav4Y6jskFSeG9xJUnpaz4pIiDc+fyuBPRyHb8Fbn6deL0rKertzQQwdj
         P/Q5d2h57FsElF8MYmPeiFokOqaiGg4SvKa97zUeeISWUN5N3t0tOrX5t23wAdewoqZ9
         h11GQP2QweTcZttevaaU2FyW73d7JzIaHFgrb8DGEx8kDRZOIJ7tDWTULdVzcAsO0Dlm
         fbYhmUZ87jYEfJ0mFiXAyyzuK4jqYEL6wnyp0xvCBQeE13mNeL7gyDHTP6DYH/2yRH8e
         HT0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNyRf1bRAPZD9qDyeQLFgTHzMvysNJ6HCTffDLmu7h+iWCPBYw7DKBgapo9uzi29gcFzxDKJUUKvajaZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqUn9PwhcU5xqamt4w0RBkMdlMLOKTVM37CjS7HkGVOKYBeEGS
	SCnN2Fmz/yEarmeelg5CfqZTP5YGKqVONy45Da8lBBGn5RvxPqZfNyW8xwOSHTBuGt9aqSLH5Pe
	ZNoAcNA==
X-Google-Smtp-Source: AGHT+IEoRLZr8fswQu/g25yORXPM7roxpFOr4Rm1EYCkeCXzeC1BTvV4Tg3ArHbfD7/3gKCei8+KcI8zLGk=
X-Received: from plbkz11.prod.google.com ([2002:a17:902:f9cb:b0:240:3c17:a5de])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:350b:b0:240:5549:7094
 with SMTP id d9443c01a7336-242a0ac2da9mr39592665ad.18.1754495948156; Wed, 06
 Aug 2025 08:59:08 -0700 (PDT)
Date: Wed,  6 Aug 2025 08:59:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806155905.824388-1-surenb@google.com>
Subject: [PATCH v3 0/3] execute PROCMAP_QUERY ioctl under per-vma lock
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	vbabka@suse.cz, peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, 
	mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, 
	brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, 
	andrii@kernel.org, ryan.roberts@arm.com, christophe.leroy@csgroup.eu, 
	tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, surenb@google.com
Content-Type: text/plain; charset="UTF-8"

With /proc/pid/maps now being read under per-vma lock protection we can
reuse parts of that code to execute PROCMAP_QUERY ioctl also without
taking mmap_lock. The change is designed to reduce mmap_lock contention
and prevent PROCMAP_QUERY ioctl calls from blocking address space updates.

This patchset was split out of the original patchset [1] that introduced
per-vma lock usage for /proc/pid/maps reading. It contains PROCMAP_QUERY
tests, code refactoring patch to simplify the main change and the actual
transition to per-vma lock.

Changes since v2 [2]
- Added Reviewed-by, per Vlastimil Babka
- Fixed query_vma_find_by_addr() to handle lock_ctx->mmap_locked case,
per Vlastimil Babka

[1] https://lore.kernel.org/all/20250704060727.724817-1-surenb@google.com/
[2] https://lore.kernel.org/all/20250804231552.1217132-1-surenb@google.com/

Suren Baghdasaryan (3):
  selftests/proc: test PROCMAP_QUERY ioctl while vma is concurrently
    modified
  fs/proc/task_mmu: factor out proc_maps_private fields used by
    PROCMAP_QUERY
  fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

 fs/proc/internal.h                            |  15 +-
 fs/proc/task_mmu.c                            | 152 ++++++++++++------
 fs/proc/task_nommu.c                          |  14 +-
 tools/testing/selftests/proc/proc-maps-race.c |  65 ++++++++
 4 files changed, 184 insertions(+), 62 deletions(-)


base-commit: 8e7e0c6d09502e44aa7a8fce0821e042a6ec03d1
-- 
2.50.1.565.gc32cd1483b-goog


