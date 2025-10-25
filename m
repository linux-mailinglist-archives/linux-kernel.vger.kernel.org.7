Return-Path: <linux-kernel+bounces-869917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 126A2C08FFC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442311B26BED
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40B28727E;
	Sat, 25 Oct 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L98mhKpa"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4734438B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761393911; cv=none; b=YhZx4WQa79RkETyqSxTotjxM7X0nelu5as3ygYmqXWN01X5dgJUIsoeIrf+u7JWSeDzCR/y8dnHLXQVrliegkm3F8knx+gBu0nQPBPPcu32xImvVDw7dteZ4Rhj/LP8WfpNbpJjvoq/5UTlhToLzTAGClydXDxNnFs7H+VBgSJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761393911; c=relaxed/simple;
	bh=RqyLr/KFP6kVHxuT8uv8+KaJmrBYAr/DIIDr7cYq7eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqTeuvNwdzaEyW6WheD0YKphADr+nQl12kRWMKG2v6vk2YnamsQyUmsWC8P4JTmnDvN2n+S1iUEFBaZWq1jlEQ0aLvdPwi9zTgxbZg+rzGgL3gHliAUNyyXz8XcyoVhjBKaTFvXxhnk52KRbQN/zW+8LZsMyXRl3uHc9d8blhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L98mhKpa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29292eca5dbso40138705ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761393908; x=1761998708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPoytxf9KSpw9USlqlPwbyYT9B/FM2gOwtvnsmod8wc=;
        b=L98mhKpaxkV56QwTM46XpSk7lQIJ/pBhQfQoJ5V1s6FhOdRITNR8mcbWamOV4BQbF0
         SVn+NQhkrg/LdPTKmHeZ16L54g5x35qgPvRoTfHccJwzJx/v8kDRYp9hCTZzjNFsFkVq
         nvuwiOEVu/uT9lsArBx+eI7iJpc7TsXVG10YpGxjAbIR3B2en4AAZp70nTTOLciaXqhS
         ELPJgrDgkqgOb53XgQmrqv3APdSI0OGEebcfBqfAH+rpmGC1+P23eSqGn3d3Ih4DueS+
         FWBUnEvB7JekvuMgb7FIP96Du8Nr7YBXAbo5gdmfqyIpjnArxaCo9gia0/iWDIqU9cSa
         qNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761393908; x=1761998708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPoytxf9KSpw9USlqlPwbyYT9B/FM2gOwtvnsmod8wc=;
        b=N9v7Rugh3FnrSj9Qv9sZ6MhOD4j7fJq3uYCs1j1wQKkaHuV4+PNiVRahflEziiBsgB
         igTjvLPlAiJ7eAspEIFyFj2jM1qJuSwQesMNMPA/WGjmXoCQZPKdnzmIv0kKr141Sw0k
         u82fMwICGJD0Tc3W8ECIHYwc0943C/qDFxh/waswjGClZotq89CamHOmlqzrc9X6lKKs
         9NBlsovMKqIJEGbvzlu+WFgcbtCbw6azW57Sf8+5PlWHZ+MReZQXd5La8O+Cp5yLD80u
         hmoJemetp4ri6YR5JOViQhwfvqnLkwElSjNxgGjVS5kZ7CXxy2gH2E1oSgwZgVWwb46W
         wUCw==
X-Forwarded-Encrypted: i=1; AJvYcCWKNWcnag+z4DRMuFvwsDOVq+Ij69mDp2nmh7s1QugX7LinmVGipRE8kVxXw8omWajL4jThYbTo3NW9zew=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8WLy+VfEW4ZOXUslB9a/QrExmwgQNNh17IHw1dhIiSYieUf0
	BjHoVlgyvJlNeOM/s1kUFqmcQbKqVerx240a5CE1603oJt3HQRV7PBD5
X-Gm-Gg: ASbGnct1OifD/0JjKXf/VKdkOPxeTJQkjuZFa1GFirk6Sbl2v/aaRGvIfP3qM/WAqFi
	bd7CIFc8IUYHdZ+MGlTvcwIyxuDAhwg+KrOGNuO9FaxB2PN3pY7WMTqj+aUwy/rcxVN1T8YZUiF
	aVvwT+E5Zs9O9RhnrGwBCuP1EBz4YarGKl4wAGKYfVWI6+QM63rkSUBEAOCM2fogCOkkKyFkXCm
	U0tADxChUEdEmCh4e8R7jldgR41CzRPfgDBpW1NZLNnUBb6BVdN24NC5qy4byryy8hO0I8gXPz9
	sVP5pICpLAwRyBltPcu6psfWEmvkUelRm44/fn58yoEZBJU+I0ivnKuYWKuLdm9JSjXDrUo7s6K
	uPbgTYHHXJ09u1SrFrFgvEnh83ndLASiUtLfskz7IRCD47eG4Znaj3v0cHud5JogI+n1SHrkUvD
	Iio1rVqhr2DA==
X-Google-Smtp-Source: AGHT+IENHghZmAfoOLVQx3IvoJEGkCtm9ehcXpV3CexqECxrjj1hj7ylp/61RR7XbH9zkL6BI8FUWg==
X-Received: by 2002:a17:903:1746:b0:28e:7ea4:2023 with SMTP id d9443c01a7336-290cb07d430mr374033525ad.46.1761393908432;
        Sat, 25 Oct 2025 05:05:08 -0700 (PDT)
Received: from Shardul.. ([223.185.39.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d099b6sm21480655ad.33.2025.10.25.05.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:05:07 -0700 (PDT)
From: Shardul Bankar <shardulsb08@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	linux-kernel@vger.kernel.org,
	shardulsb08@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 fs/btrfs v2] btrfs: fix memory leak of qgroup_list in btrfs_add_qgroup_relation
Date: Sat, 25 Oct 2025 17:35:00 +0530
Message-Id: <20251025120500.3092125-1-shardulsb08@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025092951.2866847-1-shardulsb08@gmail.com>
References: <20251025092951.2866847-1-shardulsb08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrfs_add_qgroup_relation() is called with invalid qgroup levels
(src >= dst), the function returns -EINVAL directly without freeing the
preallocated qgroup_list structure passed by the caller. This causes a
memory leak because the caller unconditionally sets the pointer to NULL
after the call, preventing any cleanup.

The issue occurs because the level validation check happens before the
mutex is acquired and before any error handling path that would free
the prealloc pointer. On this early return, the cleanup code at the
'out' label (which includes kfree(prealloc)) is never reached.

In btrfs_ioctl_qgroup_assign(), the code pattern is:

    prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
    ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
    prealloc = NULL;  // Always set to NULL regardless of return value
    ...
    kfree(prealloc);  // This becomes kfree(NULL), does nothing

When the level check fails, 'prealloc' is never freed by either the
callee or the caller, resulting in a 64-byte memory leak per failed
operation. This can be triggered repeatedly by an unprivileged user
with access to a writable btrfs mount, potentially exhausting kernel
memory.

Fix this by freeing prealloc before the early return, ensuring prealloc
is always freed on all error paths.

Fixes: 8465ecec9611 ("btrfs: Check qgroup level in kernel qgroup assign.")
Cc: stable@vger.kernel.org # v4.0+
Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>
---

v2:
 - Free prealloc directly before returning -EINVAL (no mutex held),
   per review from Qu Wenruo.
 - Drop goto-based cleanup.

 fs/btrfs/qgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1175b8192cd7..31ad8580322a 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
 	ASSERT(prealloc);
 
 	/* Check the level of src and dst first */
-	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
+	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
+		kfree(prealloc);
 		return -EINVAL;
+	}
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-- 
2.34.1


