Return-Path: <linux-kernel+bounces-839908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4FCBB2B38
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 09:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0410188BDFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 07:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891DB2C1788;
	Thu,  2 Oct 2025 07:35:11 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E939FD9
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390511; cv=none; b=SaQLhgpUFSuyEwD4/n9Y5oopoXTaP1iE1GBi/MviyR8zaskM24pacERlzX4O267z5lRZVgTc/iys2Lmqeir6319Vi/Q7/cvuPk91kCWcfACFnPj8yxnE4/p7/J0I/otHtlx8cckw+t/iZ94QrQWt6oMhXqjb3m8lwsv75kVA/GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390511; c=relaxed/simple;
	bh=Lvem05vgsC6rqvRaieoAhCU37f116E21leOhamD1D9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sVtKtKQwSFcjh4Qkup8XBAAkYTv7LoZTmCKYJc2wRAktrSGiiW/TYjbWlDIecZMFl+1YYtmt/TSjv4oSGysf6PvtuiD7HBgHAeDfCtvaEqshsl3rJVbS5HU2lxkRIX774U8unERnfG6MBLtBODitOEKWjnkQuyWPnwxe2HF6RIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so5796475e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 00:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759390508; x=1759995308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zy0m6lGq7yazke2nafMsvPVV6PQXFaV2+DO3R5bhnME=;
        b=OgPbsAcdArk7WxK12AEx0a+BQUzLDjW3fSXm0TLDUMwnNNnUrFp4I4DG9TO07xErB1
         l2UCfH7GAtfl0g3Zlkq2iYILeM8viTr3NGNQ4qaVprQqsdVmyvr2a9biq77jUBMtoc5R
         v6drIJKXjIjihuaJnCS8OZSap79PWuUBk2i97tJp8tM7HgqfMDJ7oi9khAF4SrnSphiw
         XH9GMNtQtxEDUAulyc5sIhZb12v9lVorfZ2k2338GKr+/trdjHRPqRkErsL8IYjz7dyu
         c0Rz4pINLWDmwFF17VA8GzyRMh+kp9ZKD792AFGFE/z/VufXe8DhQkF/oTZ+MHUZrP5j
         cXfA==
X-Forwarded-Encrypted: i=1; AJvYcCXyw/jG9OJOeaGRJrYv6Zo3UZG5HKNTwIHt9NXuRz55HRJ1nEjxiccbxmoNh8DlRfC3s1D4K1grgj+LDKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsa/EBTyvUbbbUJtVezuMAaW73ddEdgLzi77RMyMNps89dQx3o
	NdQLKcNgWITiDi7HbLaMK4uev7yK3EZkOHP1+dRGthKHoLcowqMs+iqQ
X-Gm-Gg: ASbGncvxasYw22pGK681bL3vK5cI5jy7+pNYicGr1v1FbHxIVVXBOkGyE+3+0wb5TJa
	CqcpalXHUsQGpM137g0+bD0AznVNd0QWDXwcHtp+DRMvmF/FZWDCPJ4SdLfY1IATm6m3W9qBmuu
	MrZEK22bV3965ESzTSQS1zZ37w+ki78H4LJLVDDROdPnj85iYT1NZct9wSvWt98MlqXgJObh3mL
	UCJOh6b18YXRiVnWm3Ndr1Tn5BQmXPKHCWtSgbpwrwVMB1L2xhSb+LtCJekYZzA74A/D1wCmhOb
	q8pIhe+0xbhVk4YoLnexmejK/Gq8cjELAaU7kE0M9ifOLgKeim70LTME5u8mI+ZrUimGLurhbul
	evvzqphU4MsExKtiT7txaduW/YS8gQSNUf1voAoo=
X-Google-Smtp-Source: AGHT+IFdXedeq8zfqN8YTO4c4rG0+WopGT+gds1vJKougcSHuF83RceLKvrR4pss1nVq5M3RimSQvA==
X-Received: by 2002:a05:600c:3544:b0:46e:5aac:54f9 with SMTP id 5b1f17b1804b1-46e61293e93mr47824755e9.37.1759390507589;
        Thu, 02 Oct 2025 00:35:07 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::301b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6a692af6sm17856135e9.21.2025.10.02.00.35.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Oct 2025 00:35:07 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	richard.weiyang@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH mm-new 0/2] mm/khugepaged: refactor and merge PTE scanning logic
Date: Thu,  2 Oct 2025 15:32:53 +0800
Message-ID: <20251002073255.14867-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series cleans up the almost-duplicated PTE scanning logic in the
collapse path.

The first one is a preparatory step that refactors both loops to use
a single if-else-if-else-if chain for checking disjoint PTEs.

The second one then extracts the common logic into a shared helper.

Thanks,
Lance

Lance Yang (2):
  mm/khugepaged: optimize PTE scanning with if-else-if-else-if chain
  mm/khugepaged: merge PTE scanning logic into a new helper

 mm/khugepaged.c | 171 +++++++++++++++++++++++++++++-------------------
 1 file changed, 104 insertions(+), 67 deletions(-)

-- 
2.49.0


