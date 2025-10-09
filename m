Return-Path: <linux-kernel+bounces-846953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E2369BC9818
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62DC5353228
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 14:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5032EA753;
	Thu,  9 Oct 2025 14:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/E0ctGs"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647B2EA735
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 14:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760020165; cv=none; b=e9RdTUXdXXMsAhlyqFO0973pJ5d8fr68G3Mr3t0Cq0uv8KtAI997qr4oqR3cPs0wzuD2YhhIp/I/xJAxp922RP0lQJoo7A5x5e4OFWAPRBeuvFuRPqR4nMj0O0AR+zG0lJgB+nhCQM/AiZ3Iog0F3WOJQ7LodJNWVbmgqbcoi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760020165; c=relaxed/simple;
	bh=zeDf6KdhYAzkJxWgKM7teSxvMdUp3SBOEpzJkkS8EKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gx8A4EjQO+U8G+9gYT7kk51k2Feofh2FKxQxIxGOlFo+dbRk0rdCAFlFpzYGGBPfLYkFNCBC7gPUmVjKseDHCOSMpyq31Qz/rzGbtHJwS0uU8/+a4cxrQnGwh8VeW1SMjDjrFhDnste1+2CaYB/lkfHznh/ypoEw+H0yD2KuOrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/E0ctGs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so11636855ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760020163; x=1760624963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/74xq4XJsElEDgJYijZf54I5DhXyuQKsFilC0hgNrc=;
        b=T/E0ctGs/T6zqe3TjdC4e3qAAwAUns3t+baptOWQWEqriIfQ6rPVly8XxzS5mL5GjD
         QFJNCIIgncHHbu1BIKxDhmVOsMRpSA73YUqGCtEnWT4j1vssbzGlYETaUH/5LlIggOzS
         CIT12ozREz7YG3JeYl2jXaOitSjk13kEhtYwmT0aTcSAmz5kTCa1GvkeoyL4AsTxlnha
         va47Ja9I0DBSm2Fk7XJGK+XeRNqKGfhjqvtfzRX0Jn39dsqVU0N6RfN4PRN1KsOmnJ6c
         rnVsHO07BIhbwAjy0sHGQZsCGhM9XBDoQARiqNh6nwMFWK/USuU3qlyy8k1VwAAdkblS
         eitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760020163; x=1760624963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/74xq4XJsElEDgJYijZf54I5DhXyuQKsFilC0hgNrc=;
        b=pUfk1jzYh31mCHHE7RU3eTVuqpRIzjUrWNIB2VYiSSaaxZMva1p6sk1VocO41Ag+O6
         yNH2w/TdmfnXMunN3dlFoyIlj0N0EBXSMb9NAawr1IRE3LcLusGFwjK59GKLDYACZJmD
         74iXMUDni1qnR04Fztb/nKvaRNa7lBT9SH7BxOKFpRyZCTgI0O7Dabd8lC9UNTTC/IGq
         UuZIIhfcyEvRxY7JdXmqrKqK5Z4xjRuxevPFYtrVIsHdVSR+kfWr1nyo/ie03fDwHjwv
         NDxUomh+imKxjQCPpEGrf4zSKQTBgAjJx7iHJRdln1HCZfqcuGfg2kGOA2vD7txS7WQW
         zMtw==
X-Forwarded-Encrypted: i=1; AJvYcCVDN6wpo78E25RyZPCEzSa8FmvzGLRuRN7Fdy7EB7C1qCmGvYcsF+hlVonaAHBDrqzUrAxGHvQkeaK7MlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyOLiPhLH2XoOl8jZR1yAZrADC94nqHju1mbNcEM9teUmsPK7
	3LHSSDSHhHVMdbgIRJ7TAWU1zGAm2zK2vvtkG8seWMrwKjTsRTWYREm5j0+8rB8v
X-Gm-Gg: ASbGnctaa3p3lHhdIfreLDb50XZR3HBXfKYjtgQ7yqWw4mzX+pZDwJ6kauSPXQweAmP
	FJHJGIeA24K3PFtQM5xifXC8bdCcdUNmTfWkdFvJ8VKHlobOpXnrFsp6PkAx2HYRbNyNUCWUW7D
	gCbEZLW9uOegDd34kBTk8XKTLKxYImRECAa8tcnFPaxY92ONx+LcOHwJPJc6duuCNBw9GFelhX5
	36cP1diFHl0BpNpbkV5aNKdvd93IIZe3ALjjbBRLmXBVRxbmoiDQPX9XgidnekjUcvGuczon9qF
	iz6xGmexzwTjgL7rQDyfeDGYdbB/6J2+cCGhMgvnOKaQc3G2abfp08zb/d4jbuxP/zPMacRSIug
	gjj0m+D/AimucM5WdOu3BPfOXtLyKlSZ6VoAbUM8h8W3CByG45G5SmP8oKRQstGT6fB0pUU1J+M
	9M/qRRGjPa5hvwFAHLxJzqAIcDqBE=
X-Google-Smtp-Source: AGHT+IFB4dSwBRuZ4Sz99mGQnC+OkqQeSCmKq0qSpJyArZKnozhvJoOda9lEv+5VZ+rvS9S7fjQ3xQ==
X-Received: by 2002:a17:903:1ac8:b0:264:8a8d:92e8 with SMTP id d9443c01a7336-2902741cdfbmr105368775ad.59.1760020163233;
        Thu, 09 Oct 2025 07:29:23 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:60a2:fbdd:54e6:8eb3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f961c5sm30527265ad.129.2025.10.09.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:29:22 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+6fdd8fa3380730a4b22c@syzkaller.appspotmail.com
Subject: Re: [PATCH] ocfs2: fix stale extent map cache during COW operations
Date: Thu,  9 Oct 2025 19:59:16 +0530
Message-ID: <20251009142917.517229-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Joseph,

Thank you for the review. You are absolutely right - the cache clearing at the end of ocfs2_refcount_cow_hunk() should handle the COW path correctly.

After further investigation with the syzbot reproducer and extensive debugging, I found the real issue is in the FITRIM/move_extents code path. The bug occurs when:

1. copy_file_range() creates a reflinked extent with flags=0x2 (OCFS2_EXT_REFCOUNTED)
2. ioctl(FITRIM) is called, which triggers ocfs2_move_extents()
3. In __ocfs2_move_extents_range(), the while loop:
   - Calls ocfs2_get_clusters() which reads extent with flags=0x2 and caches it
   - Then calls ocfs2_move_extent() or ocfs2_defrag_extent()
   - Both eventually call __ocfs2_move_extent() which contains:
       replace_rec.e_flags = ext_flags & ~OCFS2_EXT_REFCOUNTED;
   - This clears the refcount flag and writes to disk with flags=0x0
4. However, the extent map cache is NOT cleared after the move operation
5. Cache still contains stale flags=0x2 while disk has flags=0x0
6. Later, when write() triggers COW, ocfs2_refcount_cal_cow_clusters() reads:
   - From cache: flags=0x2 (stale)
   - From disk extent tree: flags=0x0 (correct)
7. The mismatch triggers: BUG_ON(!(rec->e_flags & OCFS2_EXT_REFCOUNTED))

The proper fix should be in __ocfs2_move_extents_range() to clear the extent cache after each move/defrag operation completes. I will send a v2 patch with this fix.

Thanks,
Deepanshu

