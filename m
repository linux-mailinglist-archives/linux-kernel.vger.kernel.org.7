Return-Path: <linux-kernel+bounces-895349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D384C4D913
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B3D3AA846
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75749357A54;
	Tue, 11 Nov 2025 11:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPC0Dqnz"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672483557E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862372; cv=none; b=WG0Nm7eW2/HFTvWgpDTzuvZFgo4X/Lfk1rvf7y6X1Fvct91UW97kqS517vN5QVw2RWS7hp+x2SQ9N7NWfAmoZPURDztTjgOqpSihfS+I6IEyUN/vv+cT2QEZYhjAtP9sHo293jOUYNDCrdaWoQppzw/M2n5T5e+FXAOJE7VVAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862372; c=relaxed/simple;
	bh=FdTXxCQ7Q6AxN4RORySKndm6mVXLyDWwpJ+4AHMhLY8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rxTbGBN1tQBW58KfCXf+IoKZDnY28badu5hKtseLjUhX2tT0APBsPgjp17ScRxe2MgeGf5sQvfpVrIEpKoYSLIPlDgfKHkCCPXewIsNmO3d54mwpPM5W7hx5wLO+Byx99Wslf2Wbgv5gCURwD5gptNfongS2U4SsWdV0+PMR+f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPC0Dqnz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29844c68068so3563205ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862371; x=1763467171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tTXQT8S4mtxd9pnn7XmlBWIFpySMyf1Ua7+YxQyn080=;
        b=FPC0Dqnzj4HlGNWiv8Jxly3ohEIHV4Xy58EnOhTIFZpk9RbinMSwmHX0/yQM5sg/H2
         grHYlQUG071UWUHA1eSBywKvueilgH1gGzm5MRscMRgVnkPIJC3o8SFWIBqF4SAHj6Uv
         GWK3TJGq2SvEUX6Jq4obhibOPZ/fc4vf/sIYZh4wZLtAZzppFPrMxhWl2N11CcmSZkQd
         TO7aGCLjHP8vLsOMgv2QSEB6gAdXu/QOyfnysNf6Jzaypk0MOKQfsa7pTuTLsXNHdWQV
         Ru2v56w/b8O/l+BThKG1H96yIbWZCs8F0YGk34S05BFWb8315Z5IimgDzJbfg7tHV84m
         HHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862371; x=1763467171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTXQT8S4mtxd9pnn7XmlBWIFpySMyf1Ua7+YxQyn080=;
        b=abMxV1tOUyC2v6ALRxRps19C0dWLkLU882ZT60N7tqA0VjyH1q+loNCHlurg/8tFuq
         vLTM5o4I7g1//crk/+Z5j5qnNUrjT0J0S7Fii0hbOu0X5xwxR3FgQbaDPPcEIFFwztTw
         jtvWZetic5bg7F1R7f2JwqVq/hO6MK6zKZQB6kKGWxgZocIVZCAbe9KImM0/9LSNp3eg
         6fRWmz01MzqUW5PMk0+AtaBY6NzVNGH1j/X5oBizTg8jOKS1PMN0NcwfrW5y8/emuf0I
         6o3wJEd2iNZddb9RlCGABZmN7F81xTDd76hqGwCEYfk5cEVUnamVD0jHnaM502/rCbK6
         yXfw==
X-Forwarded-Encrypted: i=1; AJvYcCXIKB9Df9oHbS3sioVMmWX23bBCCgYc8jYZmtLuJEU5tQGsdXyFfjReQDFBlnXHPrj2METgLdPKqkDD5WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzKtQN77vaoI9VDBGMfJSneQqGNtXVJb51DF2GwnDpI4T1PJk
	2T7PbG/QciFbUisMTCh4dl9qqzjiFvawG8kInOJuQH5aQaXOS9I29e4u
X-Gm-Gg: ASbGnctJNMhzuvkvhWFiIg+dQZki5RmviIouhw0uA9Q4rpkZp2B2HvM+bvQk92NBfMb
	v6DSZM1dEliYa0SV+O/rl6FpdwVZeeffDArevuwk2FQ3c/jTbyI6DkXcQFYvNmbcvGll/Pn+Bsd
	TXOM+MqEYaHaUTheVVktnRYSlEaKoz403UpoLJCugTIxCbMLz66X1i9nlWd7S1dn4td99m2OeqL
	Mag/AeDh3xuylNyMEyHuByISsqMdP8X+wZFB3EUJZgbBll4YiF7YetuUVkzu2Yk99FGrRU2K+zj
	X7eZlOwDeEUGYIW1eEr0Q0mtnXx9JIRO/mSDjtB5AjKnehrI0hvJoJwNV4W67LnrFYR7cQ5dcq2
	WowuJrjouVGapjWTqAxmx6d2msvucyZqOMfb16Hhpn+EAW9xVpdStIaTOgxZA4D4H2U0gnTN0f3
	pHpmhH+niB4I98aHhQxrarWiUzyhE=
X-Google-Smtp-Source: AGHT+IHEnPWDBHcMURIQBALd4LkxZ9HPi+VzFRx2yEKPAWBgCNMBIOVhcPerQghaB4Tqgzhe3hSDow==
X-Received: by 2002:a17:902:da84:b0:295:73f:90d0 with SMTP id d9443c01a7336-297e56e1cb2mr158685185ad.50.1762862370657;
        Tue, 11 Nov 2025 03:59:30 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343bfef789esm1349609a91.1.2025.11.11.03.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:59:30 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] blk-mq-dma: fix kernel-doc function name for integrity DMA  iterator
Date: Tue, 11 Nov 2025 11:58:10 +0000
Message-Id: <20251111115810.2320857-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation build reported:

  Warning: block/blk-mq-dma.c:373 expecting prototype for blk_rq_integrity_dma_map_iter_start(). Prototype was for blk_rq_integrity_dma_map_iter_next() instead

The kernel-doc comment above `blk_rq_integrity_dma_map_iter_next()` used
the wrong function name (`blk_rq_integrity_dma_map_iter_start`) in its
header. This patch corrects the function name in the kernel-doc block to
match the actual implementation, ensuring clean documentation builds.

Fixes: fec9b16dc555 ("blk-mq-dma: add scatter-less integrity data DMA mapping")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 block/blk-mq-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index a7ef25843280..b4f456472961 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -351,7 +351,7 @@ bool blk_rq_integrity_dma_map_iter_start(struct request *req,
 EXPORT_SYMBOL_GPL(blk_rq_integrity_dma_map_iter_start);
 
 /**
- * blk_rq_integrity_dma_map_iter_start - map the next integrity DMA segment for
+ * blk_rq_integrity_dma_map_iter_next - map the next integrity DMA segment for
  * 					 a request
  * @req:	request to map
  * @dma_dev:	device to map to
-- 
2.34.1


