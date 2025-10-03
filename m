Return-Path: <linux-kernel+bounces-841428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA45BB749D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 17:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338DD1B20982
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288BE23B618;
	Fri,  3 Oct 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw3JOwTr"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3299042A80
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504205; cv=none; b=V0fec9tJUHQJXYJiYNe1cz9IRYcumqtRCzRnD20VIMvFMvQg3U+sjwPxm4SwIJVk6sCcLdnLRSFK7nhfYVfii5Oep13ZeKqa4UIA+Mw6LwI2MYaxeTrnglqu53MTw3huhgzA6mevc/ia2M4DYw8qeN1IyWZLhZ2w9n114LHzjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504205; c=relaxed/simple;
	bh=F6atCfT03eBwwCNCSd6Eg9lNzmWSKcg1y/TrXIwWovk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSt2Yy82cvD4MDz07+zMYuYe5NJUQfGxlBxRqeC0Us4IMd6JAl+q4PElRnHoA3YAAvduyPcdca6qhOmJrFD4QGDDhrSySENZifyf9lV+YzkqwOxmXPC0opkCMSfSNaFaJwI5vlv0J4UR4zfZh4GdTLGmRR9+pwovS9Y4EbETy5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw3JOwTr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782023ca359so2385818b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759504203; x=1760109003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaSUB1+BagfG1uIIKH1kjK0S2ChhrhqFels8CRGn4NE=;
        b=Cw3JOwTr3BxBdop9Ul/URELqsKE9ssYsgrxr2umbDZFyq7eB2d2++vtdSxVXmur0jR
         nebFYjgA326DsjfUW/Gd8ZfFFbBcjGvNv0BgAluYD2KnZhP58AX/BNZuRomiB9zV2c+E
         1G0A7JKV7WbAOHjoPWbzodnNOveXAS9IlnEnx9t6tdZS57HXFtGAyT+fcx4Ig1JTVnop
         7L2VJlKXfo8UWxb1DmwsEvXoWR5x1FGI/Q3P8ShWvDaseUW96eJBOUomQelrFyK3hMqT
         p+cISXfZABhQyi+oCx+aBXQPPSOS24aIN5eTGtj2Dc7Ku7+NXwejZImYzGCPLiUa3kaT
         sDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759504203; x=1760109003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaSUB1+BagfG1uIIKH1kjK0S2ChhrhqFels8CRGn4NE=;
        b=nujt5EwWPsX0LD38QFdThzy04Bvl5E+brNSmJn5pqYreh4AWnFeoSSnreMtmDUf814
         G2tB4FUl4b0UADXe8XdwQ9m/j25gWxPif2LdnCMFVzCRjKLgfSCZy1TEv0p1CaJN8JgX
         R2uD9Osm3kWKR6dvpKuv273fG1msKywf7PsJGp+TllBAyYJP468J3J4sdT7HVmKTOhoj
         tb+15YeeLu7k4Y2RQi/TAg9i+LTDfuhgLABylKrwGy8aFuSn9NeUn5G/wnL4VtYzZiTa
         CAPk1ikDBy9JjImHb35AkQIprs0AJK1Qea3ISBHLv9cl1+4h3JJf0rBIT6MouXI9xZoK
         XYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuwwdZcv/uw5JKxNbaXBpuiPYWoQTdiOAiY4Wxogk65Y3YCXfy+3OTr9mr0zGZzkHR5q+PcRX+wLPNwqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy97NwqzG6+cO5jRpdubLA9k6MbTEzL2QLTtVCK83t1kv1A5EoB
	c+0LrRRbO9SjGWvmw1kSt6NEwfr5fLv7J0ON/Hh3uhRt2NvyLYDbUjHK
X-Gm-Gg: ASbGncsUitTlqsALzXn/OQfucQC4vssvx5sff/yNjwilZsTI3kFu28QtnqQWYM58Zgg
	C4oJDHvTUteoP7izzBRMZYyq15p7+9BP05PBXmOvbx5qcxSC3vz+7HJyRssi2Xll0rK66/BsycT
	5e8xI1WCmu+C4si+BtzleYKeNBghNrLoJ7tDrb1qi/Lx4bKPRcgVi2UKPpY/vT72tXg0I3MdoiB
	bwjcMZRZ6ysW5tMC7R8hLOPmqNl/q0kM8/DCBZcVkxkZ85x/UxbiaRD5dlK37C73EwkgywVyYKM
	GbyYq1gKQkcDdtdHFD1NmjjnbBaG3zEhGApzfwHIrVIln32tN/RqHYHSVN2NXqhbyajkBpcZnlV
	erpuow1OpfMAkJeVvggLt0fA4f7hQkF9beNHZfm25+omky5r8FOC6Th1/Q6G1duoFIyxLW92NzN
	1qfdJgEovshGTMgW6vLBB7jWPNKFV8hwIJ3zfPttBQZDFC/k4=
X-Google-Smtp-Source: AGHT+IGv+cplVeHusb5afcK4OnFwSnTpvX7kooNClTNAm9OZjgX2hRlebJcAFwQUa4C5tMeybPYp/A==
X-Received: by 2002:a17:902:f792:b0:28d:1939:f9c8 with SMTP id d9443c01a7336-28e9a5bf4c4mr47109095ad.26.1759504203274;
        Fri, 03 Oct 2025 08:10:03 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:38c3:a5e9:d69a:7a4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b8444sm53363805ad.86.2025.10.03.08.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 08:10:02 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: akpm@linux-foundation.org,
	broonie@kernel.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com,
	Aishwarya.TCV@arm.com
Subject: Re: [PATCH v2] hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list
Date: Fri,  3 Oct 2025 20:39:56 +0530
Message-ID: <20251003150956.2870745-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

My previous patch dd83609b8898 ("hugetlbfs: skip VMAs without shareable 
locks in hugetlb_vmdelete_list") fixed a WARNING but introduced a 
regression where pages aren't freed during punch hole operations, as 
reported by Mark Brown.

The issue is that skipping the entire VMA means pages don't get unmapped, 
so they can't be freed.

I'm considering the following fix approach:

1. Add a new ZAP_FLAG_NO_UNSHARE flag
2. In hugetlb_vmdelete_list(), try to get the shareable lock
3. If we can't get it, set ZAP_FLAG_NO_UNSHARE and proceed anyway
4. In __unmap_hugepage_range(), skip huge_pmd_unshare() if flag is set
5. But still clear page table entries so pages get freed

This way:
- For truncate: same behavior as before (might skip unsharing)
- For punch hole: pages get freed immediately (fixes regression)
- No WARNING (we don't call huge_pmd_unshare without lock)

The trade-off is that PMD metadata may not be cleaned up immediately 
when we can't get the shareable lock, but it will be freed when the 
VMA is destroyed.

Does this approach seem reasonable? Or is there a better way to handle 
this?

Thanks,
Deepanshu

