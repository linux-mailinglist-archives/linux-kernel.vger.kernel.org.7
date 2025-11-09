Return-Path: <linux-kernel+bounces-891852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8AC43A7F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1548E4E55C6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551442C326B;
	Sun,  9 Nov 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neoiCzsx"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3CEB67A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762679630; cv=none; b=IfnsOu17M9VU4OsDPzSf0GoEuIWSFEAyfZl3lC6gPUyWKPf9Dy52EOT6icSagUIElTao6veqkOC2dhTLJXB22/T9PIumNwxEU8H4AqZX/FTAJMwpANb8jdTqLRpZLrltrh/e31CCC+6XWx4RyqnJyTZCrK9rsKhPZCulqeq5SrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762679630; c=relaxed/simple;
	bh=wiudvA7pEvupsgjtg50l57If4OL8tnDZaUwr1RVfrJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5yDwCJ1Y7RJCI/t7p6V/E+e2gUs6VhSSWFpNt2bJihpQjMxJTAySRx/MCkj+fp8ut4zS3WW1TN9QdnfruAtg2jKG4zVfWkhXS3gzQDMQPam7Dd18y5Hz5+h4xzLaZ0gKg4f+0K1dtCYMan2jFUbBKrc4f6rmRTCzXRCa1HrV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neoiCzsx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343610f3990so330190a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762679628; x=1763284428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nfv02LK+Y+jS1NwaBEcJvt0Ah+/vQd/alXWF2KE36LM=;
        b=neoiCzsxJnSO/cbKr+Epjmj5XB0Om/sF7q7fWC4we/d3kdylSJmCMyYZfwoGVIAsrJ
         TVY7lz3RBiYIQ+9WywYY6ZVlfu1eq1He5zA99sQOcS3DzxhiQdjtbuUadybjG0fwXyaI
         xjVIKGnrtkOKV12Me1Bz0fiYEF0K9h6Z4lBoTRkQSoMJm1nWpjZESnGTqHSrn5wQXiVZ
         TBbJwt1GwnNFXnan/80IcQfJtWar3zyUo37lKP0wOajsTPErnriufwXNHCytbGw959vL
         GJAeZALYtgEeT4thxpiXFamFDRnN0D+OHfosQB57HYoKuv/qLLhD8JVwBH1QL2zLjzBG
         rwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762679628; x=1763284428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfv02LK+Y+jS1NwaBEcJvt0Ah+/vQd/alXWF2KE36LM=;
        b=Ak68QswWZaBuVyP/EPERuMd4XA374wq0QezI/Af658w4qdN5pnpRUYlBCMIgL9rLzR
         NYu6WlU3Bk/LPPSMq2BiTaRmNF3t2xMJK7aNYy0SQw5N3Z/WYHmaGZlQ3P0qPftdcI5c
         Vv6kLql13VIRBeMdZatDdFePmA9LxJsrvi8BjApptaTj90+BCch7d2TjxCSX0xTafvD4
         MS4F80vZWr1/0g8IrrFhKGr5uOGe+mIHGXrkYdxSf4dfgXBWXCHT87q8HeJVy392TbRA
         AFG0mL2XNxM4T6vYlNubJ3P3Wwmw4piEcKPfp4C1k1d80rae8QPyeGOaIsP3EExXUAHH
         tJ5g==
X-Gm-Message-State: AOJu0YxWzKt+vi4n1iR7BMqpv0p+MUsFlButrsqQBGDjSkUod1+Dajn8
	rkvoJsihr3JV1a3+ISBqDnEu4c8PYoI1L4Mj4xRkHHXjAB3AqhE7GRMe
X-Gm-Gg: ASbGncs9NeYmiNu5Mcnv68Kv9VVkLqGZbe1J/n08De0r10NfvBDvh6/9Yg/D9Ix6Gfe
	gVZR2bpkvWWRQ+nJQXWsgs1cSnk/FV9dxKValjR82MHn1qggHxvK2dF04B0Sz0tiUcsnwQ+4SJH
	IjG1PRsharqIzglvqz4GoSOF77LtEvIF8XuTSimL5+Qhjc3vEkl27G5AYFBZAt7vKp5yRDB7Q4B
	GEBN6s5Jpa598zwTrQQ6uMXjL+t6/gINMXExR1mhSSn8oZdM1OPhrOpYDUTIjmLqF8439P67k8s
	dW5iE81XYhRQ3W1imtYOFy0gZFkpU+Z2gUhxCSaAmSH1ekqr47Xn1mcqr1FYsaZdTVOt/6apmqK
	iV1lSIwShcWUt+F8A0foZWM5FolEW6hRdgnmKxeKZpGw09gYqXrsgwFDM4grLLKfd+xVb0cULga
	Dd7P9ZzD7JCuJwsG1H2WUa7yk1RwUTRpT4lWlqWlznlv3g4aqcuaKNOApGlHAEUkc=
X-Google-Smtp-Source: AGHT+IGtQ5khg9zdirBZQdIqj8QNg8agF4U9wpNQYbN3h699jYCrALiCVhoVI+BJEY9hUf8pP7qRlw==
X-Received: by 2002:a17:902:c408:b0:295:586a:764f with SMTP id d9443c01a7336-297e5743fd5mr33079525ad.11.1762679627635;
        Sun, 09 Nov 2025 01:13:47 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:bc7a:cbdc:303c:21d1:e234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm108974225ad.64.2025.11.09.01.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 01:13:47 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	david.hunter.linux@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: [PATCH v4 net 0/2] net: sched: initialize struct tc_ife to fix kernel-infoleak
Date: Sun,  9 Nov 2025 14:43:34 +0530
Message-ID: <20251109091336.9277-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses the uninitialization of the struct which has
2 bytes of padding. And copying this uninitialized data to userspace
can leak info from kernel memory.

This series ensures all members and padding are cleared prior to
begin copied.

This change silences the KMSAN report and prevents potential information
leaks from the kernel memory.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
Changes in v4:
- including net in the subject.
- added the Fixes,closes,tested-by and Reported-by tags for patch(1/2)
- Link to v3: https://lore.kernel.org/lkml/20251106195635.2438-1-vnranganath.20@gmail.com/#t

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


