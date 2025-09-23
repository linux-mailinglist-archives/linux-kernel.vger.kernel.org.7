Return-Path: <linux-kernel+bounces-828233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EE9B94386
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 06:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73A12E2613
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 04:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFB52765D1;
	Tue, 23 Sep 2025 04:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRyJteT+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF08275108
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601324; cv=none; b=T0ywdt+xd+RKuNVVCPSZwNbJrpVqzKglkZj5DC5XdlKRxanEgLaLUS1UuAR6vMR7CK/SMUeShmR/mCrxelrW48eGEeL9eHHGxk60+4xsBwSkW2/nXhiOr7EUcSDj7hPgXEnXOJAKpax9TOPk6Q8/pqrQT0W1iX2kMcsvHB/FAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601324; c=relaxed/simple;
	bh=+QlMXBX3fIO2WsSlIyfqccXfJ3O6cuDiaAdLlHzXzPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qz23dlBbKzLLu9uY4wZ0zTS8lXcLEtub7OSDOo0Hic/4MTTnRSReme+6HtbYPspHNuyCy90DLosvEqj652ekdfTsqQOi8QIvoKoH6gH+cMpK5Z51N+E9AVZk4irGM1e3NuVYq2wUdO+S490O8l0SSEX3xhJSKR4VpSNYsYWZA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRyJteT+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so4643411b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758601322; x=1759206122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgtSPBN4qoSsBifl7HF2PLKbfZ3YMsx958plJG8wRIM=;
        b=dRyJteT+f6HjQ/KobfU6hmjRCXKruCQn405O+rf3M5sDOGWM+q2Pudeg/yzeTvWArw
         SMS/4n7T+vXppHi+3dwMhjQUxCpDjcgygRjQU8FbcPAaWc/SKCiSUCMleRvvSy6fc/Zy
         uYSF2RNOU0dVVT65eeuCa0Uo4CAQfyVHW49ktgZgnGfLr6uCU2B5CP2o4ahlhkE9bkDp
         RLxf37sonEHc1jx02vpgxmgbVPkSy9v+eWr4U3xZDDj2sgoR1TtqxjFISaCcAaid1vwy
         xdr/7SsYkMn9BL2UT4KDXXYLMv8Zb98uBJMtHNNHscd6EMhPJ5akfndDNKEeMFnCdOcG
         ISuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601322; x=1759206122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgtSPBN4qoSsBifl7HF2PLKbfZ3YMsx958plJG8wRIM=;
        b=oGPOvQNfPQjJR4Zi+rIbKUg6eGLWwIUCyqibE9c/83vhw7ueQtFnODmrYklNjkQVqi
         7e7nUEpV6IKqOFakqjCjE3P8IKIUz94/ae247227I+CxCijh9l4QNspf2mHl+z1T0Nko
         /ZfLVYrk8IiuTGju4M9eD5Uq0dqZQre40nU3SOsoj932tGssoN9HTj0rTDWYo7oEHq1D
         Ff3BvbAutsqQSRrw+rM1QfCdryhZbH1W2O3skkalJp8emHlD1CIYiFP7hY0xeNB9U8g6
         l6DzYpwGDdXjgxAREepHolPoHGxBfSjmBKyNszMhD3K2Y+CDIZY7iB1DIBOJ3riOyptG
         9aVA==
X-Forwarded-Encrypted: i=1; AJvYcCXGFFicGlzQgmf2GP89OyBPet8S9j+2Xvr31iqVMFL8QWfrEOV4YFlVK6WLWfGBq/fGy3u4hNGv5/pgNF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsyL6Lc3orsasbKyWQLfEhH0GpriqPbvDwXXCp5LhVRhvWlGJ
	y+oNyfuIyM/lIVrIMgBQMTWq5k+elXfrp3t6mQlj958vqa8at+24mPbE
X-Gm-Gg: ASbGncuv9d+Qo8FErafztIt6J6D5T2E1b1WXAc5m4bThswnM3BiNJZlBOpZCbVFv2oT
	hvFrMuRDwBB3Qux4GVduVt+cN93G22UuhSln7cDEjffaSu/eRu8Hj54teeN0LknsP101a04if8j
	cC20r/qsDZX2FEjtw0gT4SnuCAZHSNOC8zOqhkCwHhvsgQaog434IyQBO2ikegyhaqOeSNJEDir
	LrWe/iMnNNF0SQ1U8JQxGhPXu5HQH0SmMmjho3fQ7ltukem4sy40/lbtnxOaYgZYsWA1WI3ZDto
	lrIINSm/k8WTPf3HRqECha/p3IMC+AGjWN47LPeUNAfZxkXWwGYGiQyS+HiBvaxoP7p/0Q2hpaQ
	wRca4cylB7rn/H6RkFQXSf1ZJ/SDLT0uglA==
X-Google-Smtp-Source: AGHT+IEI6I2Ch27KIHx7rue7mtAXNkIvBUrcrNNPpGcyDYBvbhGNyE2n2O4SQBbgRfem9JRoLD9FtA==
X-Received: by 2002:a05:6a00:1706:b0:77e:76df:2705 with SMTP id d2e1a72fcca58-77f54866800mr1124514b3a.7.1758601322099;
        Mon, 22 Sep 2025 21:22:02 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77d8c3adfd4sm13316513b3a.82.2025.09.22.21.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 21:22:01 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	kernel@pankajraghav.com
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v5 0/4] allow partial folio write with iomap_folio_state
Date: Tue, 23 Sep 2025 12:21:54 +0800
Message-ID: <20250923042158.1196568-1-alexjlzheng@tencent.com>
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

V5: patch[1]: use WARN_ON_ONCE() instead of WARN_ON(), suggested by Pankaj Raghav (Samsung)

V4: https://lore.kernel.org/linux-fsdevel/eyyshgzsxupyen6ms3izkh45ydh3ekxycpk5p4dbets6mpyhch@q4db2ayr4g3r/
    patch[4]: better documentation in code, and add motivation to the cover letter

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


