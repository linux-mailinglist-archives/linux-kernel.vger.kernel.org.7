Return-Path: <linux-kernel+bounces-843415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA321BBF239
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FAA33BF9E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEB9257853;
	Mon,  6 Oct 2025 20:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hL0TPxzO"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3281DF261
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759780986; cv=none; b=us1aE5b9P+BbsqaNrxNFPk0pf4NSPW5jz3NK8tH7wWWkkOdo7gZzvZR3bdsn3hMQaUFIRG1tIuWhoVpmJKUMwApW9mxRreVx0xPmHnRM4bABmy+h2NV8ijfLcSfXk6SkbfKen7MbMsWLokVDM6S1VeWYlggjiSVZi6MsvYS5ddg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759780986; c=relaxed/simple;
	bh=nI6vO0DSE4JriYdKFQbJUB/kx2IDdQbl/nFX4zRNYUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JY2nytFJyBF1ULJTBV91xx1COvD8iUawYNVaimSSTizeKmQiCa3y2aCsBiFL/hmqNgXjz8guB+tXWPWyA3FCCk3USlIL1SYj+ejiawGGOfL3qyJorSR2cebHjhwNxvWgbe7Uy0sMTe45OkM/jNmcLRwIoQpp5xyFnDzOanYMWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hL0TPxzO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4155230a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759780984; x=1760385784; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPonIAH1BxQsQtr1Fp2wusarT5XUOhEuCk2sJi7fQwA=;
        b=hL0TPxzOFeg+sDH36XARp6qGg6ZuSlgud8B9Asrk61xONGbWa2xUoRwFRj6iwxzaV7
         H70aVrhjrNgM3YyHdqthCjmyBX4Bz+MoBf1uzy8PxAqX0+JOHsHY5+DNp+4m6YWbHUjL
         1msDlnENz24lh0HjO/4xOQ35zOq6VLTNFEEhIM6N5lgconKY9dFY/VFzgANwL1TXKuoo
         pBJVPfdPpjkLxoW4vfPQq6NIST/OCyU3Zp2GrtZFNzRx+/C5shXlBtcApJnL5gfrxikm
         zuLc1nSFm6/3QwVeLU7GIIzgfl843pl7KGHQT+GTkFICHT0nH+uc6cONyydPHt+RNx3c
         JbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759780984; x=1760385784;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPonIAH1BxQsQtr1Fp2wusarT5XUOhEuCk2sJi7fQwA=;
        b=kBDfWfiPCOxHHFUF4UUz654XG3As3lq82C/SsrWr6BLD3YGWKQUzpGE5P2/V57nwub
         SZBYudhChENeAketO+C2xr3pYAnkPb7OyncqH423iFoApLmgYagwQ0glzS4HTTAedGlJ
         RCZsUyxLrcBEAQBgYKwUetTIrneEBCuMyPgR40U1eMqDKIOyuViWmlWgNJgB3elXwl4Q
         V+CJC6gtnQTC4b6TWGCnSJMsD4q1Vxam5vhFQCHaWiNNKeMh7sANIpGPLifDNsez0Snq
         TVP+ZhOcT3vLW1dDFmS90dep91OJTsxmmHCqIw6Xkdm10JW4hN0cGg2R7yYSgFdYa+iV
         wE5g==
X-Forwarded-Encrypted: i=1; AJvYcCUuVxCijkKI7+5uIpX3/IqPzsGEk+Y6S4mQXWBLW4iWa9J7nvihBZ+VYWKph9pLM71n49f/WFs5WYVkvPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYRdyPiKyXDzjZxbXNjdtR/omWtd+kRdRAdZQpQTseM96fu7JM
	XfZE3ltuB5QQa8RR4nck+1bpXy3WUbo82ylcvshGrBvVQRnMsmuu6T6u
X-Gm-Gg: ASbGncuhUF5MpDB12QTuu+/DiikBN28HkBJ8EQPr44NdKjcwvg76WrjN49c9/Z/0+Cb
	9v/4EVlu3Qt+JqXWY8f0zdVNfrUCTt9nXwoI4+JjykYiSry+9sbtXsKa8GmyeMMz1zdX1fM9c3T
	XVjGeyS1lajUw/wLMlvRAnGdS4G2zvKFkwqC3oaqKla7HW75ErQxsgvYHP3pSidaI52SxvSIgF/
	bqHkmf03BUMDsNGgnp68YeLIpJrymv5hMx1B1qvwRgyr29+HhR0w9sv9TEaFC3V23qEz735HA5j
	nSRaStfQen6ffzrAZFFX1KipIZc5fNiyn5B/B8MJju+a7d8z11mwCj9Tg0JCHvqEF6HJvXEFHFq
	Cbz50rWRLvs19+3QmICvjuKhyChaAA5lVcqrccuDWxaAYneHz2wRWeCThjBzeiO8=
X-Google-Smtp-Source: AGHT+IG+0oUQlrSsGCn6Vgw1ZjZpeukVO6DKfpXCGE9O6Ywd1toItQoNbpHsbdY1nkL3pyjQL+eGNw==
X-Received: by 2002:a17:902:f691:b0:27e:f018:d2f9 with SMTP id d9443c01a7336-28e9a61a6d6mr182472965ad.34.1759780984255;
        Mon, 06 Oct 2025 13:03:04 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339ee0ba20asm163148a91.4.2025.10.06.13.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 13:03:03 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Subject: [PATCH 0/4] mm, swap: misc cleanup and bugfix
Date: Tue, 07 Oct 2025 04:02:32 +0800
Message-Id: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFgg5GgC/yWNwQqDMBAFf0X27EKiWGl/pXhY9aVdkDQkokLw3
 w32OHOYyZQQFYleVaaITZP+fAFbVzR9xX/AOhemxjSdNabntEvgaYF4Frci/sUq4wIOlsen9I+
 2A1onVCIhwulxD97DeV7BTplFcAAAAA==
X-Change-ID: 20251007-swap-clean-after-swap-table-p1-b9a7635ee3fa
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Kairui Song <ryncsn@gmail.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.14.3

A few cleanups and a bugfix that are either suitable after the swap
table phase I or found during code review.

Patch 1 is a bugfix and needs to be included in the stable branch,
the rest have no behavior change.

---
Kairui Song (4):
      mm, swap: do not perform synchronous discard during allocation
      mm, swap: rename helper for setup bad slots
      mm, swap: cleanup swap entry allocation parameter
      mm/migrate, swap: drop usage of folio_index

 include/linux/swap.h |  4 ++--
 mm/migrate.c         |  4 ++--
 mm/shmem.c           |  2 +-
 mm/swap.h            | 21 -----------------
 mm/swapfile.c        | 64 ++++++++++++++++++++++++++++++++++++----------------
 mm/vmscan.c          |  4 ++--
 6 files changed, 52 insertions(+), 47 deletions(-)
---
base-commit: 53e573001f2b5168f9b65d2b79e9563a3b479c17
change-id: 20251007-swap-clean-after-swap-table-p1-b9a7635ee3fa

Best regards,
-- 
Kairui Song <kasong@tencent.com>


