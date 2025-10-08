Return-Path: <linux-kernel+bounces-845034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA8ABC354A
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C2A3C6E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814492BEC2B;
	Wed,  8 Oct 2025 04:40:02 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5099A7081E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759898402; cv=none; b=t68LCUWMTKaqCdUtl1jZfYexzdYEi850XFxvw/upNjN1uySv9A1+T9SXB0cKLkbzkS0rAjgttk1LHwOLraJYUlN990IY6g9J+q9AZ/+w+USifLATxxAAVRAxiTO+EZNoCiUx+hKjAmEf7jpHGDEVcnKrkM0dZNHVeZIwwxR6KkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759898402; c=relaxed/simple;
	bh=qmHzY+IdKAe8tNe65KIgIaVUdPSdPE91QqWMQyT3RmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqq/Jh5086R1Mp/QHtVn727jaEFa36WGw2E90Oo4nowt6nr0GEJdIn1nqaVWuAVxYX4FMJM5+Q62B+0BB16t/Qbbs++WT5bmQOQcpVxbGY3KykYNKOIGyCyz/l0r488jfiUCNwuy7ILRkjXD04kkJTuog777fjQLqAcxnfGWpb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso45931875e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759898399; x=1760503199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mvv7sSqOor4odYLPDAZ6ntZ/NXZIV6IKoEJT47Ds+1s=;
        b=BigFicsZACSXkEhNc4vIAm+z9Z5aVweydf3bz0tVQh0gWQw8/G+yLoAivub3lBn+YS
         wJVNf3+bVXliTtabhqoMkNZA8DTDqYBFnaCit7pA3V4y9ZM9OrRKtaWH3Q6MdmYrcwyC
         xPy172D1sHYW6b2O0NLQqExFQZe1oYh398bLUCI+Asf8CMmVL5UWni8TuvBU1oVXQ06L
         45IvpkzbAyiUTiTAyhPaw0JIkzcKL+yCMFU9VA9jBGJZEKA+XS+Q8sDIOyCo/avPfq4T
         zVvI+iDbovQHtCQMurVpDeAcLckivjPObOWOaAyAEQ4VFLoYKhzXeuHK3usvR8PdyL9Y
         qzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF0s0cH9WlE8nWBHrS8XCtc/w9JyGnS+dwQZrTiXWLgCXcL7BqotTb+zSItEMX0GcRhS5iWepTq9r+jio=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUQRKp0SqkLZcCyptQlJfgnar2IQhRx0z+x/Fxs3sbIuoFDhPm
	0TrGFzDfWUaPKXcU0bKtREbYGp/0lQqERVg0g53WvV5VqCI6t10XMrp/
X-Gm-Gg: ASbGncsql+5JKKg7MRn134c82y1zFvzhXwD+M4KSMdR2oPW49bDyrG47cTs4glsQxPL
	FCo8Jm6Sn2GX0Q+AgretwkPY7cKhGp4lNR1JOaKjMblgLgLTYw678YuyJbSXg6n8XOzkorGMmRy
	BiHDLzFZR5R2V0+JjROMN9W5+qLVTyM4q2NkFgPYjdMKfIdPxmJe/2U9n5u+6g5RjLKGan/CA8d
	CI9T/RHk07JDpeYEOwIGvZ2wOJRoh25DWkQ33iatkFCsoxBruwJ2qm8UhhGgteYrl4UZosiOEdS
	cQU8DTNy3votYePRa4R4XY1h25kYGKzEUHcK7r4Y9XtP+r+Tv+854FlSmWTdJ08Aro0KloBEb9W
	hGxyU0wDjsgylYixbqBLepRAUCNs5k/5jy+5pJt0=
X-Google-Smtp-Source: AGHT+IHsgqJLs4+bfAfvT/DMNOM9+GORw/CjObpAPKIew63euSQ+3GLqLlo1CMK/HKXVHgHZZ72ECQ==
X-Received: by 2002:a05:6000:4202:b0:425:72b3:7368 with SMTP id ffacd0b85a97d-4266e8e6d2emr879161f8f.56.1759898398560;
        Tue, 07 Oct 2025 21:39:58 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6c49sm28159164f8f.3.2025.10.07.21.39.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Oct 2025 21:39:58 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	richard.weiyang@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new v3 0/3] refactor and merge PTE scanning logic
Date: Wed,  8 Oct 2025 12:37:45 +0800
Message-ID: <20251008043748.45554-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series cleans up the almost-duplicated PTE scanning logic in the
collapse path.

The first one is a preparatory step that refactors both loops to use
a single if-else-if-else-if chain for checking disjoint PTEs.

The second one replaces VM_BUG_ON_FOLIO() with a more graceful
VM_WARN_ON_FOLIO() for handling non-anonymous folios.

The last one then extracts the common logic into a shared helper.

Thanks,
Lance

---
This series applies on top of patch[1], which is based on mm-new.
[1] https://lore.kernel.org/linux-mm/20251008032657.72406-1-lance.yang@linux.dev

v2 -> v3:
- #02 Collect Reviewed-by from Wei and Dev - thanks!
- #03 Use vm_normal_folio() and drop struct page altogether (per Dev)
- #03 Move the cc parameter to the end (per Dev)
- https://lore.kernel.org/linux-mm/20251006144338.96519-1-lance.yang@linux.dev

v1 -> v2:
- #01 Update the changelog (per Dev)
- #01 Collect Reviewed-by from Wei, Dev and Zi - thanks!
- #03 Make more of the scanning logic common between scan_pmd() and
      _isolate() (per Dev)
- https://lore.kernel.org/linux-mm/20251002073255.14867-1-lance.yang@linux.dev

Lance Yang (3):
  mm/khugepaged: optimize PTE scanning with if-else-if-else-if chain
  mm/khugepaged: use VM_WARN_ON_FOLIO instead of VM_BUG_ON_FOLIO for
    non-anon folios
  mm/khugepaged: merge PTE scanning logic into a new helper

 mm/khugepaged.c | 242 ++++++++++++++++++++++++++----------------------
 1 file changed, 130 insertions(+), 112 deletions(-)

-- 
2.49.0


