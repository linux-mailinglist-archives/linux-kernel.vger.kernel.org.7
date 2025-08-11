Return-Path: <linux-kernel+bounces-763307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C00E3B21308
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7B0622D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FD92C21E7;
	Mon, 11 Aug 2025 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IihjBcWJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915C9296BA4
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932888; cv=none; b=VKpCtiz2n2cusBYzWoZ6nYt90BFjoEeX/kcokGfMAhb5cMKoXkmcUasVr8SXqdGzZ1P6ErbwZ3IRkcKFJ6XqlPtPkNL3Zub97TtgSyTj2RK1pEX4bH7ixoBBjkX6erAAbJPnDFBOhFocJl9QpUrEKf9e7Iv4VFB/nZS8lSuBDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932888; c=relaxed/simple;
	bh=cZOVR6qO4to7nnf5ztJhIkMyYUl3OOAjFBiA/KbnxXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsYNlBJLULxBveJucHuKvoPsG1ikUuB9SGFzBDjgU9beYGLzlpuCrGjXtFhIP2bs8nHxJQgeHPUSY6L3Hd+jhD47TUC9d/k1NA7dzKbtVNV02P03yD0wWADY3cmBNLHjsb6dgcKlzLxmU1XWLIHeUO7JB1v1ie0/oGnVbhlDTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IihjBcWJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so31292745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754932886; x=1755537686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Gl0kNWJ25/yIfPBpPHLOS57WlvYG3gVMGvmLd/BW+k=;
        b=IihjBcWJvUp0bzs7apfxNauDvy2uNvvRJxpVCYfMX7wkJIrUMO/92ZnF56sD5pgtiP
         jmT9WDnqfxnG0PV/X1HJR0ivud/dlyvQ7GWR6pU0DsE5wHQ6EgzBK6K7SVpSYx2OE9ZX
         Wqn7G2mFaWhoutvKA7rWjQZwr6U9qqNgO0zN5QMJmupyVAeBHmRm7kRKVqvLLwBeVAyo
         gKs0cCieWJcq+5gtDRYw7oJu2eXsBL0a7d6tlJ8xWsqsWskZYq1Zj+5zlI4Te/Wr6UOn
         CoRRDyxHfykSb3InLzc5IDcWuM65h+HIVNBww2ER7vhzcw0s9AehWiHOp6cyXZhc0Dx8
         cDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754932886; x=1755537686;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Gl0kNWJ25/yIfPBpPHLOS57WlvYG3gVMGvmLd/BW+k=;
        b=u5dbi3eUekKqUUJC8rf+FiznmMW2rBWHKADztNFXnUNE9w48REVxkOV5XAoa2VtyrL
         SUIW84G7PD/bKK/TREPTfYesdslNo0A74sqcY5muO9/tAiYkHWJwCXu2Yc5jKe21Jrpd
         jae/iTCdhWlbnSLdpmaPZtPPSGn56e8H0KwFRn15f/ckIx1kSNkc6HxM9Mj7qLQL4fMr
         FZdU5GocQ+ewE3lg4iKbOq0TdsTrjEEX47mdaWhISCuUCTV492v3RDbw7TvyXjWRwhM7
         3AHbJsU7ahYt8DaKL/HU/CXEnf1IpzkCgpr8TCo+1725LooMHJqwx7XxmlN7+Q48ebr+
         nHBA==
X-Forwarded-Encrypted: i=1; AJvYcCUjCA1WQ4N2yy0P2GlgBOoqnAhnk6fyPMorZugMe9Psn7TCYMlxmWfvB8+T189DTd8MNNVTTWgX/hwRJ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSoC3Z/Dw7CZz/N6nKMgphHpRb7BzS0LVSuB9prBJwTISzQ4DI
	XMRQSaWq5EhXOzxu7pHkC/URmoHVrPs88M8qHZYI8Dc5NAOmCUZR+IG1
X-Gm-Gg: ASbGncuzYro6vfIh1zIK7mfWLnNW/ifWF+LkTc04iLnnSmZ8vCGOO6lZIzzMyQDYS2M
	V1B8IhONFdd1iWNvKwue/VutrNv1ptANyapymrlNUM5X94kapVY7cZEDz5m/tv76p63c7Vd4Tr7
	vfuDYSnWru8bg+q1yM7QvC41EWH89a4ZZUS1LmvZy5ijKDjJAHwCxaaQcIyKZ+xeL4wPEWrE8Hl
	Hhwr5EDKeBr5+4WkKX3wMM87dszbZuLIfYdgbq5N/jF/o0ZzyI9pJKXy0h7p52/leVJm+kFrAwJ
	ksgcelA6qAFXTDNvhfpLiyhWHfjwg3etSaeDwji8tSIt1AcbW/AkwEyFSJtcT2tZLKEfPYzviXI
	5++QqyGFfPXHmx0M+sXnwNZ9l4nM=
X-Google-Smtp-Source: AGHT+IGwu3PkfB4V1Yv2mCO1LLyrkpXffWwmWfFaL+F4PID4txEpeJBXA0pgs8s/xYC7ZB4Ql852qQ==
X-Received: by 2002:a17:903:b88:b0:235:5d1:e366 with SMTP id d9443c01a7336-242c1ffce6cmr161954275ad.10.1754932885688;
        Mon, 11 Aug 2025 10:21:25 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769fasm276685055ad.107.2025.08.11.10.21.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Aug 2025 10:21:25 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/2] mm/mincore: minor clean up for swap cache checking
Date: Tue, 12 Aug 2025 01:20:16 +0800
Message-ID: <20250811172018.48901-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series cleans up a swap cache helper only used by mincore, move it
back into mincore code. Also separate the swap cache related logics out
of shmem / page cache logics in mincore.

With this series we have less lines of code and better performance.

Before this series:
mincore on a swaped out 16G anon mmap range:
Took 488220 us
mincore on 16G shmem mmap range:
Took 530272 us.

After this series:
mincore on a swaped out 16G anon mmap range:
Took 446763 us
mincore on 16G shmem mmap range:
Took 460496 us.

About ~10% faster.

Kairui Song (2):
  mm/mincore, swap: consolidate swap cache checking for mincore
  mm/mincore: use a helper for checking the swap cache

 mm/mincore.c    | 70 +++++++++++++++++++++++++++++++++++--------------
 mm/swap.h       | 10 -------
 mm/swap_state.c | 38 ---------------------------
 3 files changed, 51 insertions(+), 67 deletions(-)

---

Changelog:
- Remove RFC prefix.
- Don't touch the PTL for now [ Jann Horn, David Hildenbrand ]
- Fix error check for filemap_get_folio [ Nhat Pham ]

RFC: https://lore.kernel.org/linux-mm/20250807152720.62032-1-ryncsn@gmail.com/

-- 
2.50.1


