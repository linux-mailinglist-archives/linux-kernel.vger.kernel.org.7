Return-Path: <linux-kernel+bounces-755570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E7EB1A896
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB17F7A2313
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3EC28B514;
	Mon,  4 Aug 2025 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlD56zNd"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9028B4F0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328290; cv=none; b=CGHM703W75m4DXHfPLsmtHPoXM3Vxcx/1BPFu5Hv5/zmkZGOio9h+xVIS/mtfAFlbqTL+3NchBL2aaNCiMbl8dX9ccozLGgeMbL3uxOcX/Q1fkGHNL2YdLlJk7xchwSzPLlS50enPXZxA1VPPmPuHuxY6eiErAMbF0H/ovsqHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328290; c=relaxed/simple;
	bh=KFo/GmS3vcCmlUIVE5RuEXl9t5xeH9nCBJxDQKd4grE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NWdZHisWM81kpmDSRIjOCAbVdtOjL9LCfksU0XyAgcNWVvmQYnatGumnTXHCS2YDlpDZ8hC1sX0cth7TF8SWtvZpTVQFhPxXPeQGKJs/vJV8r2f1Go/jCzRfIzCD9erBIw6KxY6wU8BeHZGBX3eJwOnzIILuH1KNQZawNnuGVlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlD56zNd; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76bdea88e12so2769035b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754328288; x=1754933088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHVh+bW0oX3+8yP14fW/aJudQEbUBGW3A6TL5UtPTPQ=;
        b=mlD56zNdfgXN8El8zqYR5RjD6mifIf/2XDMnedRy7L8+xMSTSkFyM7yoNXPR4LLDmp
         OoNgNQ6pFlNB2/0eqD+BCXMK0PK4ayjqS4G7/DYOvIRr8TPKNuJrb4QVK+PMmwPb88sw
         6W4hpUMdkK60VhafqcFkqlgzLU2W/cCL9SyKmYE3xES+Y4dhaLeyhDmHmVUQwKrCldYo
         By0x8XfKUsNmdNwfJvSaNQhwJW2ODsaqOWzdE42lXBjUtbGdiAaNNmfM9Eg6J9FVFS8k
         KEGJ4iZbBy8rPuvBwhoywxgjauxBRwm4WJC1Ghr9LP1SaBCNR+ckn08sZ3CdrJ+ndC06
         +zMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328288; x=1754933088;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHVh+bW0oX3+8yP14fW/aJudQEbUBGW3A6TL5UtPTPQ=;
        b=QE9shoWU5pnbwA+A02x7sPQlJ0jBFobeRs4PjRuF5yi0kZuagbhZATQ6gfiFOXtuls
         PWiuqWNXHveozNOytkM1FAq0Fiu6NjYNR1gXbDoyzTSNuv5r6JvgCxz3u/++/65uDdmi
         DARIKLesxq02Wnkj7pPrZT1Ae6/Uc6WLAWhEOCJF4WSG4342OgKMYWf4SoRB/YLP+P0e
         MVDMCHUDSut6/tjVqpSegScetvL3SW+aes5LUC5AL1xOeZh3e1+w/6lNibjKRbRrLMTW
         +4czuO8NKVDrO7OImHBLa62hkCemMZOSsO3fHwV4mDyAdZEm0CZRWjSalbgKcuBBVHxk
         llWA==
X-Forwarded-Encrypted: i=1; AJvYcCUXgPL/CSIzShIcilpvGbkYaIkyDGl+N7cp+moP4y7kMvL3pGuB7RBBwS3MXYBNkc+8o+di6AQynXWrpAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEVHgemYzrzzE/EHzcHhP2oVhNL+wH72/AAX8TNNi1sudGbRoB
	JS5ce6Y06RhTwyowAIlmpE8VITp+pbHVpUacFTDQ7xXRNJDf8cKU667C
X-Gm-Gg: ASbGnctcS9kEombCDDqF59xlX/+rXxwfynsJjf95IWZsIIoXU1NRJjmchx0nMEcT/ew
	B7qRZLBmLOJnPiO+Z4RaEO3XeeBjZq5UZbDg6ozs48zifvcx+BSI3d/Vt8EqdFctG3r1xzbS86A
	BuAEaHImTmEIM5/9Ke7PhxvchJMPEWH0e7C8LPC+eGhVGd2nwmpSOs/TLXB/jBNb1qoJYcOWksE
	R19rhhZ14ViPDlI5ALpVhdgxT7Dj6hBUloO35tfu63kCLPjrmC/GFhCo3ANITF4sHvgXwtVkPp6
	Uwm68dHtISokrwHypsEc04heNQp3Jg6IugNR72fDMSoTR0LpuWmaQrtZJY9c0aQjy6zYPKVK1ZK
	fuV+pvNevdfkTvqVITz+oo50NvCRbVGaj7nwRPw==
X-Google-Smtp-Source: AGHT+IHSC7TNTjwpqx44F8YGDvODHfInTOBsE13N4kab2tXYxlMKJ6P5FKRoHxc8idI1nYgb7Ht+Sg==
X-Received: by 2002:a05:6300:218a:b0:233:b51a:8597 with SMTP id adf61e73a8af0-23df9127c29mr17231404637.35.1754328287752;
        Mon, 04 Aug 2025 10:24:47 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfcb26905sm4194530b3a.123.2025.08.04.10.24.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Aug 2025 10:24:46 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/2] mm, swap: improve cluster scan strategy
Date: Tue,  5 Aug 2025 01:24:37 +0800
Message-ID: <20250804172439.2331-1-ryncsn@gmail.com>
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

This series improves the large allocation performance and reduces
the failure rate. Some design of the cluster alloactor was later
found to be improvable after thorough testing.

For example, build kernel test with make -j96 and 10G ZRAM with 64kB
mTHP enabled shows better performance and a lower failure rate:

Before: sys time: 10230.22s  64kB/swpout: 1793044  64kB/swpout_fallback: 17653
After:  sys time: 5538.3s    64kB/swpout: 1813133  64kB/swpout_fallback: 0

System time is cut in half, and the failure rate drops to zero. Larger
allocations in a hybrid workload also showed a major improvement:

512kB swap failure rate:
Before: swpout:11971  swpout_fallback:2218
After:  swpout:14606  swpout_fallback:4

2M swap failure rate:
Before: swpout:12     swpout_fallback:1578
After:  swpout:1253   swpout_fallback:15

Kairui Song (2):
  mm, swap: don't scan every fragment cluster
  mm, swap: prefer nonfull over free clusters

 include/linux/swap.h |  1 -
 mm/swapfile.c        | 68 +++++++++++++++++++++++---------------------
 2 files changed, 36 insertions(+), 33 deletions(-)

-- 
2.50.1


