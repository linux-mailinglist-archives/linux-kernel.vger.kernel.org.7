Return-Path: <linux-kernel+bounces-757896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E631B1C80C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CC954E2B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B02C28EA70;
	Wed,  6 Aug 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRM37AFo"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852328DF0C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492408; cv=none; b=k1FNffvi6Dn8h7qnW0Q/OJnrIYSup6ux3/ogGhwBTFdZKWjtrOaRw2Qiu1fMjLjzRocpvhlPgksLPFeoODOhSoC4oLQgz0wixMbuALzzqdF5zYFJSLbYPAxyArUx/jDEoYoaQjhDM8eDomf8Fo2URqfnzsg+jiD2DeTcXb+GJk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492408; c=relaxed/simple;
	bh=nhPiWTy9zCiNXlpI6QepO88Wb4tuQktJ28yjP/P9DEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SzQH8Nj4JgeZh3qrG8QTWoTlYyNh2dXbIgbyXaRKyCJPR3gdTz1iBRzj00Jv+mF/Z82zGt2UB0i/FcQGLJ5m84OpPfwZY05m/ORPPqw5s94rVVLsVMN3KdtpzoeFrvlE5Gt/GpKdTAJi0RpU6KbY/D+tJRa+yh4jUXRdNK/dpWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRM37AFo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76aea119891so1104009b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 08:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754492406; x=1755097206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZB7P+LR6z9Zxc9rEDL62l6M20YPI12NkjExjZ6NWpno=;
        b=JRM37AFok+/2nuEWwpZJ22rXKRTuSc7e8lIb9t/+mLthaJbkw0GnwxcmjKqy0AMrbe
         JUurVY2mheBhqqN4vnDXY+fluwM4R15is+/Nvx/FYvS/yRDU1qouc4osI9Vbk05yM6QF
         X31pfMp4tlHTzjD7rcNthqPK+8Hwoek85acO9MhBg0UligHZKEOMNF2YdurEEngGNWtE
         WxORJACmaWlzk/ZRTODvK2C9028aBxIGr4LCSV7ywarC6VrKISF/dK2KF2dc5xlGYrLh
         PsZ0KErIbCPgeB8BLWu+vIl7VjCqvBJIfM4hzdA7rGx4CijCq9bnvVQ8ZeeUv3BMlDOg
         hnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754492406; x=1755097206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZB7P+LR6z9Zxc9rEDL62l6M20YPI12NkjExjZ6NWpno=;
        b=LCRPBEOY/mDqCF+iieGS8hkzyttpr3G9BRLwhqYkkRELzZ8wwqmobmTviXLn2CMha8
         qKT/G6IoBNeZj1DIwM6jO3ujyqeMzJ/8oYt8HSj6QpivTmqbr9mXJxd9IioxprOftnfB
         uKFw6UgRmGqTw2zr6PUabjm9rParaBI5Kqn0SEkAT7m0RTf2a4mSXoergjV5iuDSewdv
         9kt+G5LBMEViTVBYMZzeZVPHOdxne2Cy8L/1DMazLu9GloZ2s5j+qOFAnGWdn5ms3pF2
         pB5AhlABSADWAf1wOe2b4H8qVOUnc/d7OnIj6JgIF1ZgYI17tRIc+xBuzG+vZ64aPcaC
         CZ3A==
X-Forwarded-Encrypted: i=1; AJvYcCW7gcvcnmiQiNulyZ8TKONBEluPDEstyfSMO+EUVvnnMZyZr0jtC2gnwczJpmFF9iPqxi5Pt/NyrPxsAaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZaIkxIQTbSQ6dXbB47aF65+SdU8woK8RSEQz6geWoyqnia8B
	0ptA3Six83gh1qfdhTTf+VdVza0UOnojvouisvtqH4N/U1y+2J/qxO0L
X-Gm-Gg: ASbGncvKjzhRh/2aRzqBeNsRJWOhXRS871B0veWH7Av0cEkJKshTqx07k/d41pr04Pv
	U5invN3i6xMPqu7Sa9HWKVJ3TZ//fSml+cdzpoMj1XY0JvV7G/EJ9zPvPida4V1uE5d6zf49DUI
	E3irjrJqoPhBoVauf++4PQEj8Ymmfcfd+72H9zyPwT4x/ffTtbqHjPMEGd1H1oy2v4QBHFMCklo
	JuGKuCKGXvaFiPuieDCUpKnvd3UxDyrvBPaDkT1qNjMGuQGDRnLQ0qNeDeMUINrYQsWE3tJBXb9
	aHcTjc96ViU3tFNdewtxWDxz0YIVwozUSNeot9rTdJFN/PU7WCR2A+7tdbPP6y207eAqcRPfP6N
	VeHDWOuABIwSGochnKzUjV3vAszjtDStVRg04ZWAsoWDrEmrL0+btO3ceF6a10CtdDgeLnZUE/a
	ICX1w8t3BlJ/nf333E4mxzDwZFlGNay8WmfHFB
X-Google-Smtp-Source: AGHT+IF/zb4p8uMDpctBooDw3w4OO1dxizR+VfBzQU5WXXX3PuwBSvSo4mc81Nt/Sb/Ar2TwYOPqMQ==
X-Received: by 2002:a17:903:1b30:b0:23f:b00a:d4c with SMTP id d9443c01a7336-2429f8af5d2mr38722975ad.2.1754492406205;
        Wed, 06 Aug 2025 08:00:06 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (220-143-195-113.dynamic-ip.hinet.net. [220.143.195.113])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2429b7dfc23sm29204985ad.105.2025.08.06.08.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 08:00:05 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Liam.Howlett@oracle.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Feng Tang <feng.79.tang@gmail.com>,
	ahuang12@lenovo.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Adrian Huang <adrianhuang0701@gmail.com>
Subject: [PATCH v2 1/1] mm: Correct misleading comment on mmap_lock field in mm_struct
Date: Wed,  6 Aug 2025 22:59:06 +0800
Message-Id: <20250806145906.24647-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment previously described the offset of mmap_lock as 0x120 (hex),
which is misleading. The correct offset is 56 bytes (decimal) from the
last cache line boundary. Using '0x120' could confuse readers trying to
understand why the count and owner fields reside in separate cachelines.

This change also removes an unnecessary space for improved formatting.

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
Changes in v2: Per Lorenzo's suggestion, use "56 bytes" instead of 120.

 include/linux/mm_types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1ec273b06691..c9c3d0307f8c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1026,10 +1026,10 @@ struct mm_struct {
 					     * counters
 					     */
 		/*
-		 * With some kernel config, the current mmap_lock's offset
-		 * inside 'mm_struct' is at 0x120, which is very optimal, as
+		 * Typically the current mmap_lock's offset is 56 bytes from
+		 * the last cacheline boundary, which is very optimal, as
 		 * its two hot fields 'count' and 'owner' sit in 2 different
-		 * cachelines,  and when mmap_lock is highly contended, both
+		 * cachelines, and when mmap_lock is highly contended, both
 		 * of the 2 fields will be accessed frequently, current layout
 		 * will help to reduce cache bouncing.
 		 *
-- 
2.34.1


