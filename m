Return-Path: <linux-kernel+bounces-735341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ECDB08DFD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70A316CFF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE812E49A6;
	Thu, 17 Jul 2025 13:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JstZrVIe"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABF029E11A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758382; cv=none; b=hddvG3wGUrhdQKAAeYzXBK0pMMseM3ziuhDObgG3DlG2zYKn4O3p/mGwQ6Pbcui12Z2wp8bvaueQFQI3Evh4NVBbuMuBHAZ2c2TLnP2lWg+qTiu9KxhoFKcvdoTvGubH0nsJAlEvNi2YGVEYar67vZmB6fMf39jyF8intoamdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758382; c=relaxed/simple;
	bh=g0qlHCtcwrLrtJsqdofcFY/H8w0ylA7uoGP9lYh34h0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fb+mKURLJ4coftAEInk0iGqae8qEUxGY9IAOYVs8pwdxpPixbNAjPOsMjVmVR2lnLjuCWl8MdDo9/plLOvOhnoHGmPV1rDYwdqHTXx5wg0i1ARdQx7drMXXnOSRprQNL7xzQyDHB9B1T6wKVx+0rYzPHjxOZVwK7jIXRNGYFATM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JstZrVIe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-237e6963f63so5311065ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752758379; x=1753363179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIfVYIOgK/QSplOCMwjyGw4nxlfPzb7fG/AtkpDzYcs=;
        b=JstZrVIeSq4Pw8Qm5kqbeeub6hziQNPRhNisCWhNIDK7SXAhvluJ9wE0cHhsSeN2Nv
         4pzaiV6FIMA9zHWdmEPs+5PNQErYcOXHs8MRNU1l5O/JzJ7JzAIIKTiADF6MvCvRowFl
         K1AaRVbKW7yhYHFQJdiffWOp4yGIdmY3VRhDRXB3voFNiF3C/gxCN6pJ6D6vlu5Mj8OQ
         Ne2PmxoG3qJUqG/8SUWMn9uhyRGQUA+NhCu1HuREuMLoI0ZCtCWPRvAzunR/P6AqfRej
         6c/20/PqzJQ/iBGJwdPBP5XDHkUDH/2QckT0pYGPYrk4ss/J8UhFIidFH6/RkWnrY06j
         7dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758379; x=1753363179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIfVYIOgK/QSplOCMwjyGw4nxlfPzb7fG/AtkpDzYcs=;
        b=XwCYUg37gcCM/BaDfAEF5zJ52cPqv4EXELfteQq7BiJyC3FE7ml1sMmDvNnkJ1G+z6
         fg+tCyD6nylQBbUP5JJt5icJgXx6O9IOrrdezyBajCJNnDqEU6F6YQuSEvGtgrpWpJpJ
         uI5/k06yZB/Rmw3Rm3nCtH6G+oNKSd7YSHyEmww+eKr3QqMPRrezC3VNbN4z60qUBwkY
         GIaCUH+Bh6Xnpfsp8uMTvTYYfByGsKJhjTbIjZw86X+d0XJQULvIzo8olaXnIClVlMhb
         QG7/jMKJgwvAjIPAg5VZ96XpNlA7Rj7n+KZPm/6OgE5tWt7apor1dTgW20q/FSDxl+Jp
         fAuA==
X-Forwarded-Encrypted: i=1; AJvYcCUBouP+3opWyKX/81iY8xu4Slpyd0EbL7JZYoT8z4YSjuCzs5cVaVe2Jo547vg3fDJlpcAMu5O1DFXi7cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThd2AgmFJHj2InBMS/LYvv7Zlxnrr3I//jUijGLeSFP1gWa/c
	IM9OqwdtbT/Zi4lfhpJ1ZogZ77TD9PgwCcP5eZxGRKalgDY77adDGR3K
X-Gm-Gg: ASbGncu1SAcRVz9aGvBzieMh+jg4/deviYVqeRXcFjjFFPd+uDwisga8l+zeRsk41Tt
	Dx3PdoHujvUEV9HzROLX4liRg6lQx9lvzzh+l2hplAWLfKm6WFQwL9Lcf86Ya5Fzw44+nW3kjie
	Xj8ZTUbjrb7pV5ml/bC2GzVQp5wxs+2gIIh4NiCDMaVnj+iYFT2GZ2e8bBTi0XZFNGG/HjrUW8H
	QdwmNrLHw9vZPRNZsqc7iJosgMtpybAL+p0E6RjBDUMFF7gahlTlcVW4G0e+G0NXin+IwB2Pxqp
	J+thA6gntQ52xZiZhFhtA//0T1ytzheVOGVI9FQH5f6j3Si7hhZGxrXFCLaxepphfFJwyW6w7NE
	Wv0eMbO8RtSO6tkPfPG0a0INpZ5jrzGdi1rRq2U3Lywc7XImF
X-Google-Smtp-Source: AGHT+IH/M1xyr9NkvWP5fNEyy5OCbS/XnJRQQMQoUCIx9xmo+tQ67SiYR2sumVW0GJb/vUk2nRmIvw==
X-Received: by 2002:a17:902:f601:b0:234:cb4a:bc1b with SMTP id d9443c01a7336-23e2577851fmr103453805ad.49.1752758379105;
        Thu, 17 Jul 2025 06:19:39 -0700 (PDT)
Received: from DESKTOP-GIED850.localdomain ([114.247.113.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4322e7fsm148053315ad.93.2025.07.17.06.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 06:19:38 -0700 (PDT)
From: wang lian <lianux.mm@gmail.com>
To: akpm@linux-foundation.org,
	broonie@kernel.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	sj@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: brauner@kernel.org,
	gkwang@linx-info.com,
	jannh@google.com,
	Liam.Howlett@oracle.com,
	lianux.mm@gmail.com,
	ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com,
	richard.weiyang@gmail.com,
	ryncsn@gmail.com,
	shuah@kernel.org,
	vbabka@suse.cz,
	zijing.zhang@proton.me
Subject: [PATCH v2 RESEND 0/2] selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));" and some cleanup
Date: Thu, 17 Jul 2025 21:18:55 +0800
Message-ID: <20250717131857.59909-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a common FORCE_READ() macro to replace 
the cryptic asm volatile("" : "+r" (variable)); 
construct used in several mm selftests. This improves code readability and 
maintainability by removing duplicated, hard-to-understand code.

I previously sent the refactoring patch [1] as a standalone change, following a suggestion from David. 
As Andrew Morton and Wei Yang correctly pointed out, 
that patch was incomplete as it was missing the macro definition itself, 
causing build warnings. My apologies for the noise.

[1] https://lore.kernel.org/lkml/20250716123126.3851-1-lianux.mm@gmail.com/

This v2 series corrects that mistake by properly structuring the changes:
- The first patch introduces the FORCE_READ() macro into the shared vm_util.h header 
  and reuse this new macro to refactor the selftests.
- The second patch guard-regions: Use SKIP() instead of ksft_exit_skip().

changes to v2:
- collected Acked-by and Reviewed-by from  David and Lorenzo Stoakes.


wang lian (2):
  selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r"
    (XXX));"
  selftests/mm: guard-regions: Use SKIP() instead of ksft_exit_skip()

 tools/testing/selftests/mm/cow.c              | 30 +++++++++----------
 tools/testing/selftests/mm/guard-regions.c    |  9 +-----
 tools/testing/selftests/mm/hugetlb-madvise.c  |  5 +---
 tools/testing/selftests/mm/migration.c        | 13 ++++----
 tools/testing/selftests/mm/pagemap_ioctl.c    |  4 +--
 .../selftests/mm/split_huge_page_test.c       |  4 +--
 tools/testing/selftests/mm/vm_util.h          |  7 +++++
 7 files changed, 32 insertions(+), 40 deletions(-)
-- 
2.43.0


