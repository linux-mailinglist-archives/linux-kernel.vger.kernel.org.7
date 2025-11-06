Return-Path: <linux-kernel+bounces-889325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D954C3D4A6
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C173A552E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E8A344051;
	Thu,  6 Nov 2025 19:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNxvtxiR"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E362DF700
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459013; cv=none; b=KEQMXdNM2Hppgq8ZOIDRXdTG2UYf/VZZO3XO5YjvAJxjGJ0/LTSuvaT+mGc2hG0qK1WaZuGcgmuoVs1DYF+NXeh8tRJKDXk6SU7bNVhr91Pxon1KgzfNf47o8DEw/cbQJkWoEs5R77IzItVNkMFAgJneMzwr8QFgbzKP4rZ+h+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459013; c=relaxed/simple;
	bh=5FI0IkQm6myrpbP8yVqdkn6nt1ygJomCbomTQtpmXjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDOj9XLN0oTqt6OIgB/yV9Te3KUYy/bfG+nbOXnAlnbiw9JqdF+KTa2+RmTkpBUuo7gmtFltSPtInrpSCyrbflisoo3ZpiR8f3NsKQGcMO7XjdUfKhpMjmsKQvwp3kUXrzOvvoz1b53wXHzZkcF7rFEEhFITljFO5Hihaj0OlVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNxvtxiR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7ab689d3fa0so879b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459012; x=1763063812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEtJRnrpSj/c11WcQopWj8JF0D9TZBxFZPrYbVMK014=;
        b=CNxvtxiRbno+D/wSpiPLdjJFMDAsWFPN3UZJ+51RlD02BB2vMO8AFz0HWFbhS6urJd
         3EM4Fqb4yCiV+CmzX3DuABgyj+gbB0NJFH5KJXJ9yF/XoamMXg3AqWGDavEWBBYgultv
         5H+GAT1SLIx2pFbAxtCQyCY/+e5GfbWMV6km9290J0kduzJb4oRr55w1w82w9lnU5AnY
         KTOGa2qWmRu6R7K/KzSoJVPBcbBPsSWXuy6X2NNtgYjf1wV26CDAmSSkPBjJ+wMz16b1
         hQDHEzBSLPSCg4668MyoMb1/FPSmrL826oRmG0GmCJ8K6uj/1rUbme2UdPzPdQYv8ZiV
         ESZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459012; x=1763063812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEtJRnrpSj/c11WcQopWj8JF0D9TZBxFZPrYbVMK014=;
        b=oQwTwwdf8bf4qxmQ+Fkajus0aiCy0ysCxLu2JolZnOfhBAXLYQZVwVhgeiZMhfbuzM
         Z+YwP+zJ7G0YuJnqTZCpxCp/SeyVvSRgcVN7ct6apO0hGtBV0G/KS6WJPsuvLD4TezV7
         xVUn+qA08PXR6AK6XB+BWf1mFzfqIpoBI+7lmPKXioIh1dgS4ttmgXFAqVs5F4bniKvl
         yZ7+OruI0AK8I+nIspzGHc/RLC4StToWozXw3uSctKfD5HQT+opJjnPHRA2/Q1spGVo6
         Z/drDulRlP8q9ptJxOxD+7LzQdF5+nKShuL4Lwk3WYQsrCrj7A8E7ySuy5da2il+5E/N
         xRBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsPtQPLTtoR2lOkH4FR62627nLycyrPOmFb0EYdkmrDJdcrV0QIT7IoTmKBLkKXVTOrQtDQBBp3yhaKJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx89XmHROOdHvBfiS4DrpLURGlgkoOAHEnpunrCJE58YP6OwUlv
	bj/3Wxy2hvE2sIF1qQXyPAmaosj7nl6nw8KsFdtlqWj9snFcgvG/4fML
X-Gm-Gg: ASbGnctcLO49PR6GAl4igB4YG/c7PmKn0bwnEm7YZhb8c1thYWClhtj0w+6bzzvAIqG
	Vm9BN3cXtMkTe6xx0tbPSBblXdHwB6QdieyhwFly3JPz4bo9SONWUJ7ngID+bH4K7hEWIWyo55+
	9OhBccf3cuBzdjy98cx+qK0qe47s8xlMQKD3nQxNT4pTl4O9AT2nxzQnOO6Qud6rSXB1tuYzBK6
	aZ0S5kxMp+EHN0GZ4sur3kZ+ZmFbprP/dcC99Q8/d0Vev9TNaogKE2AxR+a8neZ8yjdW1pJaXf8
	pMo5UjcWH2P1jit+5CKdlM6E2X3mh9UREmzz7z3ByJqojg7HgPByaQRPnQ6Yhu0+7lwaUlkphMH
	kc8Rv3Jg5QQQXxWYOXLx5UpHqXC9YuyD/O/WPA8OsDcYp3RHIdI/gz1LMMw9kdtjfskkZDRP7nJ
	NjBEvF7IuJGppJ2pVaq3NrKZTI2u10WJhbDS00PIRHsw==
X-Google-Smtp-Source: AGHT+IEqrduIZ0k9qOO/+5rFWXw8zlvFXIdWggT09NWs7Ud6rsYKIaiKc4oRhwNumh4AN+y2araGbQ==
X-Received: by 2002:a05:6a00:22d1:b0:7a2:757f:6f6b with SMTP id d2e1a72fcca58-7b0be552630mr499468b3a.7.1762459011582;
        Thu, 06 Nov 2025 11:56:51 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:e5b3:bd3b:a747:7dbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm391246b3a.3.2025.11.06.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:56:51 -0800 (PST)
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
Date: Fri,  7 Nov 2025 01:26:32 +0530
Message-ID: <20251106195635.2438-1-vnranganath.20@gmail.com>
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


