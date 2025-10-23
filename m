Return-Path: <linux-kernel+bounces-867525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 995BFC02D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BA4D4FE6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57F334B435;
	Thu, 23 Oct 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lykHND2z"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AF2D9EEC
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242502; cv=none; b=psuY34PGGD+W1s5bC6rdo0TZRJLA+cI8wHZtJGJsNModMCQDkYWUcpjn+IfgUYbTqkUD/Rqf+u9RLpy0rBRf0kN7Qg24sf/w2f1kDxvL8Bj9OtATWtoht2q/uiU7FcKvnBikvz6thG5pXXEEgiwDPjuGN++hdPBR01mEYZxnX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242502; c=relaxed/simple;
	bh=a4YFELyl3UTNxlSSCOM9DTPR9OQOU/m3i/VmvCHO7Qg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oIVqXQzEsJy9CP+FNKdA3Z8H2Gz9V+cFfdEZDFTMkqBTHG/833ZJVKxdO96BRS3HgQrTStZu3QkwA8DSWujjSBbzQ23TwkEYqVmNleJRXQnPNefrPHo4Uenr16r2Lb/HL/hZnH9yqgxWEptFuCx7K5hZweS77MaDCpIJa8AHgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lykHND2z; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7930132f59aso1442323b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761242500; x=1761847300; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hOfpW2F0dLhMpb8zi4+tT7+zxDG4noiF/FBCYOCAu60=;
        b=lykHND2zY85yAxtfme94LboWPkNetwVUKyXaNeI8oODVqW79V9bTkH50KLLjHIIPDW
         wlpwC7TZrbvJvVBmCwnfHRsCyQyZNyhSV5wilh8cLE9Prr5yK7uOH4k1IOdhA9auW1qj
         5a3RR+kMdfG0Q/NX/AMsP8VhFJ7TtDQxrOZI5xb8w35bi3DbngQJKlx1Ob5Z15rPyNr5
         uIWyKJK+ACeHe2HWlCQXDSU/LjCJeHbUdHJk6RqtkfoBAokb2qsC6fh7ULSsBCFaO/JE
         QhAceGtqy0crDcTHpNT1Xfxbo5JChm3UFtkIzElSjxLSSU0jmDD17sqjfWL6DMIUly27
         IdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242500; x=1761847300;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hOfpW2F0dLhMpb8zi4+tT7+zxDG4noiF/FBCYOCAu60=;
        b=TvIceq3ha3OEUFGpKCC2Bn5q8I2NoHCA7I+ouS360FOTiBaXYiN5QYIR3RgeA6mP4K
         TcXHtDo97QpfA0+EAbcq06v/rWHbyEjJ6RSJocwIsqYwfMJS/s9anU3VrvjRUnM04nO8
         pDGX5nAHHLzzMR8FTPArmU6Fj6c2MTENKc/TzvGxr3+a7pEr16h141N1XrANR4RbYltt
         p8S+caxXvXA7sqzdojoqFSBjK4+/efW8W2Z7CSO1wyBepoJNkLny0OfY4g5jxRoMyr6H
         rHrmsXReNvMogf1rDqVPT7Mgd90m5Wi8CgL8EAclmkdzWd2iWpOtGJyYX12ZBWJNdnjz
         BHzA==
X-Forwarded-Encrypted: i=1; AJvYcCXydM6bQJCSEXa6CVoCySt1VhMl4hvc21otZF0h/QFOASGK2pKptvZfuItSjGp4UiHa5Sa7YtcRG1PpCFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDnJeoMaF4mrNhBRQQC3zl+9bwC81ziDWmmNlbJ3Ux0IE442wW
	dZ1d/K5C71MHO8ZWcF4/u3/padiTMJzuZg0oHwPzXMnG1p2/WXJTC7zV
X-Gm-Gg: ASbGncsQziRnbRyduVk++wJ/U9jUdj4qSdHDEdUYwCbPp83QYxHWZCgZLwKX4k83Ox2
	Y94wBgm3hd4J2w5nMnyCx3NulHrzDo5/fs6n3sW2ByBn5teop23Y5aR5QIVfaKuKaNQa6+r7oya
	4hhSofDiI9ysYmQ9vNq1fbFoZlGoiK3UbsUfV1iyYIPX24i/CRcxsUqx0RqYiPrSl272EzBw2MR
	jpP5DZ6M/naglByiaMbB6UgX+T5scvboXMRcxVTAuI3zmUmTk9xJhC2wtujfs2zVRnIoSoPRwJa
	yexhQNHR7gqDEmhlRYwEIeCmVlr/Q6mxBcPPP5O+AIGbuPUn/5RfE19YwYMK/TK95eRP+76h77P
	kh3C1dQh9G3qpgRc7iRjyqfkXnI7XTHbrXICwcPqEqEGzCstSTJSg0wscFiRZCpwCdv8v8dz4JE
	fEXf4N15VbephCn7PA
X-Google-Smtp-Source: AGHT+IHIZOFsj/SegFVrNbdOjeH3WRgln2EKfh0ASZUCKq0ad8fJDrSau2Rt6XTQaNzq2A7iutDbkA==
X-Received: by 2002:a05:6a20:1611:b0:334:7e45:e69b with SMTP id adf61e73a8af0-334a85a552bmr30672459637.29.1761242499397;
        Thu, 23 Oct 2025 11:01:39 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c4d83dsm2734532a12.18.2025.10.23.11.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:01:38 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH v2 0/5] mm, swap: misc cleanup and bugfix
Date: Fri, 24 Oct 2025 02:00:38 +0800
Message-Id: <20251024-swap-clean-after-swap-table-p1-v2-0-a709469052e7@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZt+mgC/42NSw7CIBQAr9K8tc9Af1RX3sN08YoPS1JpA6RqG
 u4u1gu4nFnMbBDYWw5wLjbwvNpgZ5ehPBSgR3J3RnvLDKUoGymEwvCkBfXE5JBMZP8TkYaJcZE
 4nEi1VcNcGYIcWTwb+9oH1z7zaEOc/Xv/rfJr/06vEgWqumsFm24gVV8iO80uHvX8gD6l9AGaQ
 0SPzgAAAA==
X-Change-ID: 20251007-swap-clean-after-swap-table-p1-b9a7635ee3fa
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 YoungJun Park <youngjun.park@lge.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.3

A few cleanups and a bugfix that are either suitable after the swap
table phase I or found during code review.

Patch 1 is a bugfix and needs to be included in the stable branch,
the rest have no behavior change.

---
Changes in v2:
- Update commit message for patch 1, it's a sub-optimal fix and a better
  fix can be done later. [ Chris Li ]
- Fix a lock balance issue in patch 1. [ YoungJun Park ]
- Add a trivial cleanup patch to remove an unused argument,
  no behavior change.
- Update kernel doc.
- Fix minor issue with commit message [ Nhat Pham ]
- Link to v1: https://lore.kernel.org/r/20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com

---
Kairui Song (5):
      mm, swap: do not perform synchronous discard during allocation
      mm, swap: rename helper for setup bad slots
      mm, swap: cleanup swap entry allocation parameter
      mm/migrate, swap: drop usage of folio_index
      mm, swap: remove redundant argument for isolating a cluster

 include/linux/swap.h |  4 +--
 mm/migrate.c         |  4 +--
 mm/shmem.c           |  2 +-
 mm/swap.h            | 21 ----------------
 mm/swapfile.c        | 71 +++++++++++++++++++++++++++++++++++-----------------
 mm/vmscan.c          |  4 +--
 6 files changed, 55 insertions(+), 51 deletions(-)
---
base-commit: 5b5c3e53c939318f6a0698c895c7ec40758bff6a
change-id: 20251007-swap-clean-after-swap-table-p1-b9a7635ee3fa

Best regards,
-- 
Kairui Song <kasong@tencent.com>


