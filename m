Return-Path: <linux-kernel+bounces-824576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 006B1B8996D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F8172207
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46469226D02;
	Fri, 19 Sep 2025 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NlzSGwrP"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E821C9E4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287192; cv=none; b=Ij50ANUR08UhOmzmTnELIk6X8muhy9LNPBnqkVv2A/espJ3lI17RAm60GaoW3pfQVvBwJDskvHZWvkA7r6MGaKcs19fj+AWVE77f5YtRMAKH86LeKggIeMGTH7ZR4gYXYG2rrvT8I4LGkDpG8NCqZ7nVmD+erqh7ZGcNRfFQ+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287192; c=relaxed/simple;
	bh=r9AJTIvnzjcfdGx5s5XBeHfnb2DJucUHE/cz3DMfgHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dmhs5egkLVhz6F2j0V3nsoZGuC2Z/QM68ZiCjzjPj2kmden5A5QjbviDb8P0/YhhMsStfvWWPj7YA7mTWHlo9sIvE4Fm7UCtOL3ICcVEfTccu7mFRj8kz4QBgeEEYdmx0mgBaMWCI71IsGyemsWDGwdstAzvmHwxzWmju5bi2M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NlzSGwrP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b552590d8cdso348691a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758287189; x=1758891989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y44nOyA0y8OwFwmSdVnNikf+85sx5V+uPvR9b6gSko=;
        b=NlzSGwrPrHaZRi3wQNBC7Y8ZDF+dCbMg0EPslxHres3uzvhzagQvGApYsDHuGQGhAS
         WLn8G5I4uaYuTX5w+sYXIrWH+1o1pWLB30pgWfZm53zpwyWswlQnBI4Ph6PjNEDMiUCg
         9SkRXz7UwqkokizH55jRR0ihpiPt7z47Na1spFomeW2U33YFs9IbFh6QvJ1TV6EECb/D
         gscMONKPIhLpEBVWKs8/qesjEFOeZszNm1NFGi6Yy/IYJfDTBgsIxG7LteojGHy0xPKj
         VoEYV34YpcXtYu6mLnxyVmwSL9fxqsJDkBLO5trj57DLFXlNWKNM6UN+sLNRU8nx7+pH
         5Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287189; x=1758891989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Y44nOyA0y8OwFwmSdVnNikf+85sx5V+uPvR9b6gSko=;
        b=EMJzFNjiLjjJYNOY9J4qcT5msUd5FpdeN4UhKLYv5aeWSODDs0aYCr/GQ3FHp077rP
         BSQTEJ0IbQRpVP7NDNg49ypemzuwtIAnuux/BV4EAb1JleobFeKsYgR2X/LnVdOsvEHj
         /0JNeA80spkE1Z5TAO21MlH5eH1/FCG2wo2+4nZBNk5LF1VtOIkMqSKXkiM8zhwwIOm2
         lkvida4Nh7yw236zRzhWdk6Oq5OusNcFFw8Zn7UKCMxBhHE7etfZI6577cUG9p83noqa
         vR8aF7y3f00/7JuVypVIIFHuL40SEAs21XRvO+pBstkLF1lOgSrVFhYsSSASUVgu7f/S
         DkAw==
X-Gm-Message-State: AOJu0Ywn6ixQj3SvSbMnZCqXjP6wM4I1NedILbtjRrAyBknxLnAlExyP
	vv2xJ2mSj+0e2njpQViNH6FVdsv4ULOuN0L3hrWv2QxxewwXnruWH6zHswyJR+fSm24=
X-Gm-Gg: ASbGnct9v/x3EwLHcbiP3XNLGK3eE7tEP9dS2Xnbw8VnqwU96dzsuGs6OipHhv6umkS
	RQ0ZmS5LLORspvLS1WgvWlrx6JNipofsd1a8vC2Qcy29wdfP0N3VBeeQ2pWFUDmUcGPpUgHCWCv
	KBfPAM5OqVmiIjeM0YQ0A8SLGQF6vFPKa7WWFLe7bLSn0TkO61SP6glm+pmrj5HLXk+wJSjYSoB
	UZquPP1ATHFbdRDiLd8zn4++bjsJvkAGrl64DraO96T9B3aVzYlhzbW6fmwEo+ayF+lBzZ8uC4J
	A7f78WifZJbScKVg3w7Fjt9TFNubAx3mq+xjAD3U2jKiE3bBopAYJx3dSCXeg5KncpiNaonTTHa
	cMT0lY1jxkiWuyjOKvY4aP9YBzmVEk/d1xM9nnghWyoJYkMw=
X-Google-Smtp-Source: AGHT+IHbCYvgUOcFkkck27B0rfSlhrmfVapbla8Z6az+fBKLroeJB8snmFXCKURB5BgfWYqSEvjPWA==
X-Received: by 2002:a17:902:e946:b0:24b:4a9a:703a with SMTP id d9443c01a7336-269ba42b2a8mr46541595ad.17.1758287188922;
        Fri, 19 Sep 2025 06:06:28 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([2001:c10:ff04:0:1000::d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802e00b3sm54732065ad.90.2025.09.19.06.06.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 06:06:28 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	libo.gcs85@bytedance.com,
	Yongting Lin <linyongting@bytedance.com>
Subject: [PATCH V2 0/8] Add selftests for mshare
Date: Fri, 19 Sep 2025 21:06:13 +0800
Message-Id: <20250919130620.56518-1-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mshare is a developing feature proposed by Anthony Yznaga and Khalid Aziz
that enables sharing of PTEs across processes. The V3 patch set has been
posted for review:

https://lore.kernel.org/linux-mm/20250820010415.699353-1-anthony.yznaga@oracle.com/

This patch set adds selftests to exercise and demonstrate basic
functionality of mshare.

The initial tests use open, ioctl, and mmap syscalls to establish a shared
memory mapping between two processes and verify the expected behavior.

Additional tests are included to check interoperability with swap and
Transparent Huge Pages.

Future work will extend coverage to other use cases such as integration
with KVM and more advanced scenarios.

This series is intended to be applied on top of mshare V3, which is
based on mm-new (2025-08-15).

-----------------

V1->V2:
  - Based on mshare V3, which based on mm-new as of 2025-08-15
  - (Fix) For test cases in basic.c, Change to use a small chunk of
    memory(4k/8K for normal pages, 2M/4M for hugetlb pages), as to
    ensure these tests can run on any server or device.
  - (Fix) For test cases of hugetlb, swap and THP, add a tips to
    configure corresponding settings.
  - (Fix) Add memory to .gitignore file once it exists
  - (fix) Correct the Changelog of THP test case that mshare support
    THP only when user configure shmem_enabled as always

V1:
https://lore.kernel.org/all/20250825145719.29455-1-linyongting@bytedance.com/

Yongting Lin (8):
  mshare: Add selftests
  mshare: selftests: Adding config fragments
  mshare: selftests: Add some helper functions for mshare filesystem
  mshare: selftests: Add test case shared memory
  mshare: selftests: Add test case ioctl unmap
  mshare: selftests: Add some helper functions for configuring and
    retrieving cgroup
  mshare: selftests: Add test case to demostrate the swapping of mshare
    memory
  mshare: selftests: Add test case to demostrate that mshare partly
    supports THP

 tools/testing/selftests/mshare/.gitignore |   4 +
 tools/testing/selftests/mshare/Makefile   |   7 +
 tools/testing/selftests/mshare/basic.c    | 109 ++++++++++
 tools/testing/selftests/mshare/config     |   1 +
 tools/testing/selftests/mshare/memory.c   |  89 ++++++++
 tools/testing/selftests/mshare/util.c     | 254 ++++++++++++++++++++++
 6 files changed, 464 insertions(+)
 create mode 100644 tools/testing/selftests/mshare/.gitignore
 create mode 100644 tools/testing/selftests/mshare/Makefile
 create mode 100644 tools/testing/selftests/mshare/basic.c
 create mode 100644 tools/testing/selftests/mshare/config
 create mode 100644 tools/testing/selftests/mshare/memory.c
 create mode 100644 tools/testing/selftests/mshare/util.c

-- 
2.20.1


