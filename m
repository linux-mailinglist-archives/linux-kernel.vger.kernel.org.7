Return-Path: <linux-kernel+bounces-815010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1BDB55E1D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 05:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6494BA0869B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D941DE3AC;
	Sat, 13 Sep 2025 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IunoaQ7d"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D535958
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 03:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757734649; cv=none; b=ssVjvCB257hASMXaGU/froKeu9lxu2cxLbQxC6oU7M1kASTIep+2vowNhlBDxzYBYEZYvAbSNYecD0alR7K6MSRI3OswvUe+17TF+2nQv6LE83/3RFba8/W6Hv8buCLEZQFsnKLTzOQFwJNAZlJEJ+oRxJXu3Zr2RgTQMopUx9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757734649; c=relaxed/simple;
	bh=S9RgEf0sKLoUujoXKzI5jyp7RRc7a0WMvLCahxrVDpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpyeZgPD2PxLXOV+NgDyNIil2tcrn6jv0mQ7lVUTTQs9QlKCFznthsb8dC3JtugiNGgMTW4oirndDxuQTccHUsP3JigzC7m/vKcwLNAfByHBmzekg27Gn2KY5Yqo63w97aFR6qcsJRAcaCNXP+MN+zZD1SgFgcN4jvYgUxcKscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IunoaQ7d; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32ddfe3c8ccso2506677a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 20:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757734648; x=1758339448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K4uUqLHm1wv3jT3tEGcJTrI2K+259prtijoUXxYVBhQ=;
        b=IunoaQ7dcbaWAqtC+oSt9VEMhBLJnUdDbD/bDWOD87mf0pDoH7E7DKuyr70tzldnVd
         z+aq/DloV4IXdyQXGXjJdoc5in/TVUEB0bzILsWpACyXwg1WS+fWkgvlZuSdszWxxuQb
         WKLfDxDztr3hvAOanUXMc08ySQvShxdTHRTvMOGpv9TeZTXzRh+DvYwXqnMnH4s1Vvwo
         S2q9YNRB7kLrgY2WTsk8cL2778Wc0x7zuFTC8b0CcU60F5u6+MvEowdC8n2nZK4xWmm/
         X6XOe05CbqjWPGjCyj26ZakuC3QvcTh/2HWtmreOFv9N2ZvJSz3V/0pK5Drdz1Q61w3e
         EKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757734648; x=1758339448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4uUqLHm1wv3jT3tEGcJTrI2K+259prtijoUXxYVBhQ=;
        b=rmn+Kk2pu4Lvf4ahghwYzN+d/MRRgGMonuV70Pu5KQFqPwQG2I+UBJuVHyN4dVp6Qf
         eQD6JSMLwwqaLNFTvAIZACLpd7r4hk+tTanw6MR6IDOBKTFFAIOIN8/2cml2LxrnIvFS
         gSYdAT70PRUoqrLLy9XLAZPGwNfzF+2MC/0LVdZi8A3O4LgZcI+r7DdI1sVZKbg9ebVY
         o41oMyiWYkOZ4J5p4Bhg6SRTSiPzM9fZHxH8pWhUYIAKTwAu4mEYj+WyVnZnej6d6HF9
         PDUB3N+Yi+XK47wYkqSnS5DlCIl2ebxROC64k1XyS5OPVruS7SLnMeQ0VuuHRt4dZk30
         SRJw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Lvf8pnZs64BfqFInCFQD2U8QE5rrHePFR3T3NXgFRsHTcMSpC+bABc/+EOtBEUf8p5AXK1WK+QlbSMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6LwWssGZEf/N607mejQ1wfq4ZhPeRMp9YGh99qUtE6jbsejPq
	EyWoKqwLNjs1kBWKwOu7OJbHgAheRCBJHNMtm3w4rG/FEOVAo6mEaX0a
X-Gm-Gg: ASbGncsHZ7s/KOC5vTcWYudVxp8vnKUmQlyWD0DR79TX5YCmkGATN3Mc7nPAGyIj9So
	2iu8nfUM2q7Pl41XRWOzXTfwyQPv1ubP8tMnAMMjMeS4I2wDm3VzMPcn4sYRVsW4vYJERk968S1
	0UvbdjYgoqdvZ8EADlvmPcXoobSba1ioU4l7+qWDiJN1hoev5PCb1otxNWJ7mbG+fl1g71JUevE
	esQpdIWg4Vx34ryQ4EL65pWy9ek5tawLEpt6WDatQN6MfrQY5oVCBKIj6Dn8qsGCTftEoyuGvJS
	7xlatalt6GBEXi0A9lf93xf97rxRzoJ91qW4FaVusab5N2j+VFUXFGI/xsDDvoL3Knnss3ElZcL
	2KNHPHVb9uftFAYxlSYIQ9/QxLVhSvmFlIA==
X-Google-Smtp-Source: AGHT+IHs2Rsk72hJiBcf1dG1IHcVl6K6BhYFOSeWdIg9w0otcC2YgzWP62rCvvQj7XJcIaLvM51cww==
X-Received: by 2002:a17:90b:1d0d:b0:32d:f4cb:7486 with SMTP id 98e67ed59e1d1-32df4cb757cmr3628309a91.19.1757734647593;
        Fri, 12 Sep 2025 20:37:27 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b439asm7150770a91.15.2025.09.12.20.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 20:37:27 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: hch@infradead.org,
	brauner@kernel.org
Cc: djwong@kernel.org,
	yi.zhang@huawei.com,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v4 0/4] allow partial folio write with iomap_folio_state
Date: Sat, 13 Sep 2025 11:37:14 +0800
Message-ID: <20250913033718.2800561-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Currently, if a partial write occurs in a buffer write, the entire write will
be discarded. While this is an uncommon case, it's still a bit wasteful and
we can do better.

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
bytes are 2MB-3kB.

Without this patchset, we'd need to recopy from the beginning of the
folio in the next iteration, which means 2MB-3kB of bytes is copy
duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
 |<-------- 1MB -------->|                          next time we need copy (chunk /= 2)
                         |<-------- 1MB -------->|  next next time we need copy.

 |<------ 2MB-3kB bytes duplicate copy ---->|

With this patchset, we can accept 2MB-4kB of bytes, which is block-aligned.
This means we only need to process the remaining 4kB in the next iteration,
which means there's only 1kB we need to copy duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
                                         |<-4kB->|  next time we need copy

                                         |<>|
                              only 1kB bytes duplicate copy

Although partial writes are inherently a relatively unusual situation and do
not account for a large proportion of performance testing, the optimization
here still makes sense in large-scale data centers.

This patchset has been tested by xfstests' generic and xfs group, and
there's no new failed cases compared to the lastest upstream version kernel.

Changelog:

V4: path[4]: better documentation in code, and add motivation to the cover letter

V3: https://lore.kernel.org/linux-xfs/aMPIDGq7pVuURg1t@infradead.org/
    patch[1]: use WARN_ON() instead of BUG_ON()
    patch[2]: make commit message clear
    patch[3]: -
    patch[4]: make commit message clear

V2: https://lore.kernel.org/linux-fsdevel/20250810101554.257060-1-alexjlzheng@tencent.com/ 
    use & instead of % for 64 bit variable on m68k/xtensa, try to make them happy:
       m68k-linux-ld: fs/iomap/buffered-io.o: in function `iomap_adjust_read_range':
    >> buffered-io.c:(.text+0xa8a): undefined reference to `__moddi3'
    >> m68k-linux-ld: buffered-io.c:(.text+0xaa8): undefined reference to `__moddi3'

V1: https://lore.kernel.org/linux-fsdevel/20250810044806.3433783-1-alexjlzheng@tencent.com/

Jinliang Zheng (4):
  iomap: make sure iomap_adjust_read_range() are aligned with block_size
  iomap: move iter revert case out of the unwritten branch
  iomap: make iomap_write_end() return the number of written length again
  iomap: don't abandon the whole copy when we have iomap_folio_state

 fs/iomap/buffered-io.c | 80 +++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 25 deletions(-)

-- 
2.49.0


