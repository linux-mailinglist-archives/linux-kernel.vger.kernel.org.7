Return-Path: <linux-kernel+bounces-859595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7612BEE0C2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEAB189B5EC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209E29DB64;
	Sun, 19 Oct 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HaLYBw7c"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346401E832A
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863147; cv=none; b=BBjkX8Ejh06aw9KiG56/1unPYXSvSA7Vzj997enldhmOYImKmeUGY25uOC5XzpE6gjgVQ+oN0Fh0wYnCxBBg4O9FoMGylxJ1lVgv0VgBsIH/GCuC5f+hV6HvrixD28+zJrNszma62fOpLf5JqEshfKjgaOVJT1i81eM3eQ93EEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863147; c=relaxed/simple;
	bh=mEnjwgJfQJ0O71tpE2SqslOlsardtAe/nQ4bMnmTnKg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j+7ijyQrpCADNDdKImfqjP3erhGPyZiHCAYfv23T/Fw2ScD7W53wytXpf5iemKmt90pzRDHWRoJreDt5En+LtAcXd6qjUppQJPkcz35HLIW+VfecKv22RIKFeGzCAmn2eCasQOHhZzBKtEfZ4LLdD0qW1aOeKLUQ/i+o59fMqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaLYBw7c; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-782e93932ffso2916526b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760863145; x=1761467945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1O1qFjTaYa3YKr1wUK2qwfX5whhrXvdDystRg7bIkb8=;
        b=HaLYBw7cU+RhWFf5SNkDBftCG9/fuvcdi14+vf7N1LUrVwhlqar8jpS2e8a94p/8AE
         UP2uy4OYnm3wWYtaVTbV0Q/nMxMXEQsljLxZ94Osl5fqkoUSu9CiEnlDUToTb7xUSVEl
         NYhiAtwV56ExkcInE4b88KmzkG/+GjW9ZjWMZ95WucAlFKmKsp+xZJCNf8SthMrYj+b/
         uAe9c5iCQWNqKqc7uetsu0skll3nfbvfCnipNH0K297ESd5a78tn7rHbsI9U1JeCgpNk
         xL1kMcoPoestGvHMGK5WQnleRcelfzArCeXNg1unLctdkbu4ZvlrdjKsjXIQQgEzxK6U
         I4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760863145; x=1761467945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1O1qFjTaYa3YKr1wUK2qwfX5whhrXvdDystRg7bIkb8=;
        b=XU4DptVzZeo/87tJbCz7YKf2I/aIKYRmIUt48bZQupKIqrjMiuc+QU4hL4FK3HSMt1
         NNDxAqqjwVSdbbpP/BzYhLF5tlbDWyPBSSxgINaqlhpS7C/ot1NSDrPo9IHR1b0Tc1fR
         VYGT+9d+Ni0SbWzu255l3ZcPj0YVPcekeLCJ0kGri7j9vumnvUuDdeyg8G6Si/9p7zpM
         bBNen5ZGv5nAonRznLkwq5Eu7LK0KgTKrvaKhAK9uA6WP+YMKTIbsrsbdxkYeWQwGqFN
         4nIRHjN5RtUcziJEZ+JALjKqsnkAIw0W+AZdGfLJcwXtsF2cuOaMI1Qn/DHd7tBBwMnh
         YIcA==
X-Forwarded-Encrypted: i=1; AJvYcCWgEPGVO9zykDsvL7Joo1HDt7PH+zSrKfWawphe/B6CHURrkN4xDM4JOLNQHLqVQKKRAKgIar0042iy/xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0vCjgKwycapvWqXWLsRmDMIGyqN9m0brStyg6+EAuqrXvU322
	24/9W8OIaRnAWpUMUDmZucDyr82KdTpZ8UuMjN02X/o/66nvngIvRJCU
X-Gm-Gg: ASbGncv/at0XhNwKUMZvvNf8YPUTctkUpYYS0st+TXu4twFGip1XSQwhh7oHD+2Nb40
	NrVJQK0M+IQ8Bh7UZLLvbaeL6NknVVaKDVOq1Zmd8IWCubRJcwKlJRdpR02y+LyOZpsAmuBIOty
	4tj5geq+RkYwdUxP1M2WTR20Ph/8FljfVzt+70ygLu/Sqc2yRQp1LjDyivb7EtxuWxN6jsSXb6r
	xNHn16bzAYS6b0VtNnN7YPkdpzeykKFt9EQREXajNhrn4XedBkJe6+aoo537QDtBT0G+hg5cop1
	k87QnaqU21+J5dcYipBRPyNQgopoLvYd3js2Au4l9P7Ko/wCKfKxAlTUPR+rfxxPUMclZmUD92c
	WQQB00NhBr8/y5rONFLcMhRIMiXD6crDExgLq47/ISVywKCTlx3QSxUu/UtO0gr7Fyk+3lRemZH
	L8JdrLlLjMXD4ynZOtKw==
X-Google-Smtp-Source: AGHT+IG0nj3JfGbvrdQsQygdR1y3JLnopGBbMcwuKfE0iF7oNqWVFfy3kIP6nViup8Myx5gaNy6aHg==
X-Received: by 2002:aa7:8096:0:b0:7a2:218c:962d with SMTP id d2e1a72fcca58-7a2218c974fmr7021815b3a.3.1760863145378;
        Sun, 19 Oct 2025 01:39:05 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230122380sm4864516b3a.77.2025.10.19.01.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 01:39:04 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: clm@fb.com,
	dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] btrfs: initialize folios to NULL in compress_file_range()
Date: Sun, 19 Oct 2025 08:36:47 +0000
Message-Id: <20251019083647.2096733-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'folios' may be used uninitialized when jumping to cleanup
labels, triggering the following clang warning:

  fs/btrfs/inode.c:874:6: warning: variable 'folios' is used uninitialized
  whenever 'if' condition is true

Initialize 'folios' to NULL to ensure the cleanup path is safe and to
silence the compiler warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510171743.VQ6yA0Uu-lkp@intel.com/
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d726bcdacf6b..54903e17338f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -862,7 +862,7 @@ static void compress_file_range(struct btrfs_work *work)
 	u64 actual_end;
 	u64 i_size;
 	int ret = 0;
-	struct folio **folios;
+	struct folio **folios = NULL;
 	unsigned long nr_folios;
 	unsigned long total_compressed = 0;
 	unsigned long total_in = 0;
-- 
2.34.1


