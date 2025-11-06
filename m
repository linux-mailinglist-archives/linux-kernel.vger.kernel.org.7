Return-Path: <linux-kernel+bounces-889311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECD0C3D3F5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D735B3BBBA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D69354ACA;
	Thu,  6 Nov 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcSuY0Kv"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DB230E0F1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457319; cv=none; b=NtC9v/5qnb+kSrsjOnGwD0ANiqy77Hh6mk+DMDGQ7OO5ftVy9MBkTNIP9DwkP/xzWZGCB8s/dqWf13dDidwNJHmXGVr0QxahrR5QUbU8Prk95yzv+hBIly+/PKnMVN7B8NYCstH7DqCY7zD2cEe8wsnQrvLKVpNHOfspItuyaCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457319; c=relaxed/simple;
	bh=5FI0IkQm6myrpbP8yVqdkn6nt1ygJomCbomTQtpmXjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9e3p/4kxWt2ejTBUotsyaREvxAeEa06c41dY/uWMveghjokAfKLrkuvSHQ28ZDh5HiagetzyQRoevwRgRAyPes2MYusRRwg9f3jqDamPR2HxCYx0CRA/zfXcGm2QnBWVDcfLFxRAtSi4zfsdFegfXf5KqbciKKMsMLXwVt4Pnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcSuY0Kv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2952d120da1so746235ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457318; x=1763062118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEtJRnrpSj/c11WcQopWj8JF0D9TZBxFZPrYbVMK014=;
        b=bcSuY0KvGVN2+arn4a3CjE+tbYNNFG1sD7tQwv8+hYKAr14cZF16RZ+8biloVmz2fw
         fiMhuxK9uvT+CLOpRl8iw62j5cgRRLtbrq8h1izxju4UtIUqLkGrKZitqdxiN8RP/l5g
         xJAeetaVAOom4jXJ8IP09Vwb8HNeexWRV67GVeg5+3k9dEWtFqABC6HFpmU+pjQjLult
         92pcuje88Z3QF1W7yWxEAUTgMD1wPiJOH2uvipqSrNAYk6fWeIDvKfVrk4btV/PsV/fP
         KynUBwgVdc2Mvt78AZXoz/RALPZGwGPmIUGbZ1bigQiA2fa7tStQUrznvywmeJPedz0H
         BgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457318; x=1763062118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEtJRnrpSj/c11WcQopWj8JF0D9TZBxFZPrYbVMK014=;
        b=c5tYmcVmLB/Dfo2iY/e12MIyT4NwzfCbUdy60J8fVVNWzINtYE+tL1rNmMgjMMT9oa
         DEqdfDT8lBgTmv7ilUrCXDmYg6siGKUBXGYqNzx7TvR+h63kptLiGFw+H5+tNHEwPbjG
         ZHJ+MBAtp3oqQyuR2P29EijzyR1VyuAziBiYhpjMnjitSj79DJ0tS5C+Esw0sgxxYLP+
         lc4NJ53EhQ7+VerAz/mHdGd6wNEMqpkivVwTsPdPqWDU0LpS+ZEywJXCrExYhmu8bAgC
         /uzlmPMt6jiI8+z2uBZntw5RPlhsiyUb0aIGXxPmn9xnqBvpdltyZCdyeImfhQj+I63W
         B7Lw==
X-Forwarded-Encrypted: i=1; AJvYcCX5q63XYm/zITuwJ0Q4mXG3LwuRKxmiuuUc+i384EbK/yhFXfuZohdcG7ZOde3M9+M8J3kFEwqM2IOudyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMHW9FVXASmzeoStFoXzKIIBMlsUIBE5wSsb507Kpqrl68FmO
	8tzxfGTwvCWuVhMOiFQxfCVQ3HcMUUT/AF2jTYki8H8Gu6Rn1Ec7bUI9rWWaCg5M
X-Gm-Gg: ASbGncs6bNvUfDQDxRq3KuaHNB7VvCHNHYjUmJm41B42pYuM/yLoAUaqdA+DdO5ZeKz
	vVz8+NBIjjKr1WvjXwblrytS2mKwh0uozXDIe5dk1UBuYcnNh5X9X8yyZpm91AuVHRQqivSz/BK
	TJP0bxPFCz8EcIa4MWfHo/MSO21jjofRmgQfsozKkuVs3J5ib3l3TBLvngErd7CAmnKMhcM9TXe
	t2+u4OnAN3j8acu18otQErBvt/os0qrwvGIXzFTBgtrpG8uDhoknnjkBKET59Vc+/DSShuv9j9R
	+7SPpl6W8bwLn3TBfueAbYE71NQdjm9IISLWPXfynxmmrtMN2vr2ZejedT/ENlkZC4fxt/lqv/h
	b+R5JuoTRoCaxykTjuwEqQKojmiXtW5eFzY48R0krk09deE9pfGANu1n8ujjXTDb2VVkLmzfV2N
	tvjpEcjY4kCvfJrcESb1k8YgAB/Lhe/Fy5pANar/X3RQ==
X-Google-Smtp-Source: AGHT+IGvyt/J+mRIlP7wDwLyYUFozm585qUU/+U8wKdGfZXJuM/V4hzwm0ca6tnKePGfbJK0qRSMLQ==
X-Received: by 2002:a17:903:11cd:b0:27a:186f:53ec with SMTP id d9443c01a7336-297c0481612mr3853765ad.9.1762457317780;
        Thu, 06 Nov 2025 11:28:37 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:fe91:a1ef:9f13:366a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5d66dsm36286685ad.37.2025.11.06.11.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:28:37 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com
Cc: vnranganath.20@gmail.com,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: [PATCH v3 0/2] net: sched: initialize struct tc_ife to fix kernel-infoleak
Date: Fri,  7 Nov 2025 00:58:19 +0530
Message-ID: <20251106192822.12117-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series addresses the uninitialization of the struct which has 
2 btes of padding. And copying this uninitialized data to userspace
can leak info from kernel memory.

This sereies ensure all members and padding are cleared prior to 
begin copied.

This change silences the KMSAN report and prevents potential information
leaks from the kernel memory.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Changes in v3:
- updated the commit messages and subject.
- corrected the code misisng ";" in v2
- Link to v2: https://lore.kernel.org/r/20251101-infoleak-v2-0-01a501d41c09@gmail.com 

Changes in v2:
- removed memset(&t, 0, sizeof(t)) from previous patch.
- added the new patch series to address the issue.
- Link to v1: https://lore.kernel.org/r/20251031-infoleak-v1-1-9f7250ee33aa@gmail.com

Ranganath V N (2):
  net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
  net: sched: act_ife: initialize struct tc_ife to fix KMSAN
    kernel-infoleak

 net/sched/act_connmark.c | 12 +++++++-----
 net/sched/act_ife.c      | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

-- 
2.43.0


