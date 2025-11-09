Return-Path: <linux-kernel+bounces-891853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E01FEC43A88
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EE274E58B7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1381E2C2376;
	Sun,  9 Nov 2025 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMsarZJL"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E619F115
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762679640; cv=none; b=aKLXq5ay0Rjb5c8tQ+bgNAKojYG1ly1jtriQq00g84VDrlcccPrgcHmZafDEm+c3aX1bg8+MYSGNv0RTnk3eOmglkBzuCgJzmeV86hHZBoTJqbgpfADBxInHAtCPzPCm/5LY6sakbbpT8EqSMDYirYj93C5SQKfQbjXLYu+dhHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762679640; c=relaxed/simple;
	bh=URZZFh4LmiyKJd9P22L/fxBlRB2zK5Rd8wNGzhdrbjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGxJUY06qPgrNAF/yoqvniIVidAUqUJNFC+9zEE/SUC5m6bA6aNqqObw8DS3McCe8fDGX5mzVjWsE9rflbeMihSvubL4nh2DA+yNHP2xjnk+qniELWbs7w6hlmDMWCkH1pPJtvlwze2U6/X8gpwcohM+779jW9NDWtmAGO8lkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMsarZJL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-340c2dfc1daso290041a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762679638; x=1763284438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQtbYnMyaKjUS6x8wAYDCyIdDRCSV64H/mG803zZXM8=;
        b=gMsarZJLmlb7KkjH6mFkutdgcdUmGYcVqX9+FLShANEVhjbHhPOiO7szWA7I5VU2Oe
         1wEx3FoBkahY0D+FcGZjElTB0EVYqvU9X7PQvr1mqg/dprAGcWQ52wSxQWsa5cXwtq2K
         /l/is/bSoHO4Hm1a8L1zc9flkpX1OMdTRejFQz9FbRXQEfm6Y4FtZCpjg879boB/5czm
         aR2eakKQcSp2Kt5akeGCYEJpyEXbQcpg1ZSEEUXdc3GF18uW8Gg4ik2oWNA7DhCSYJ42
         jvlBvJ+94UIHnRS+78BjzU99Ho5roxS5PQHt3MXTHj63Hf3Suzq31/6O4L3fwNWqnTHw
         /3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762679638; x=1763284438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQtbYnMyaKjUS6x8wAYDCyIdDRCSV64H/mG803zZXM8=;
        b=QH5Jz51X+CI9t8xSBooOwxB/5tFKA9bNYa8JUaC7iN+PYICS0t6n5/6bmH7VCLNEyN
         5V5g5miTgEKn+0SDTXMoUTkrT2vua1XB4/yfK1RQ2CuEwvZc9A+8jfl7CrHzQZsO6yHN
         xw5Y3zgpGKQopCd2U8PCmi7arQu6AGiS3MD7ZOjMHFUsG6twR5x9FqCckuMB2j6iRsUy
         cY7g+D4SnSXt74OBgq+VuG5FoPHNzLzjxVyyHiantnbrCf1R6v2l2euXrdOTYIYz0W/O
         FOg0/mX8zXvOdv4fVVm6HuV3WQdSgsZUO5MF1Nl5/RkFz9dgAYDs9xKMwmRtfHRmzDEr
         IJ/w==
X-Gm-Message-State: AOJu0YxXjUL6hRizD2YVHEJkMBHPQ1IjFOT9lREZ6DRYRBJIaaAR2c97
	BIKq39EeCV9Ods3EmZOTA9louVlmr1YNMkeLpFr4bsdMrzC9it2rnRnM
X-Gm-Gg: ASbGncvL4HdK2101CZCuJgEHFCDIZUqGykRW9cnZmCYG5UabgiwKuJyJboOnbBSJxhn
	ZhqueBYLlf27W8iA8yGmPWucfDtHIDmjwJP819F/MyNo9SFVBQQ/Z2NzioyL3asNeDLtCXdrv2v
	//PGhbHF/QF/1NSTsBDeLUhHa7k3ygcXzD4zhgRscELMh8VDYk/AKdF1fAOQ/UPeI55hT2PV0cK
	lQtsfQFU4voybTWliaQzLnC6OgNpaFH+iory3sBdbS0Wib+VBv0lDeRpMejR/8oIQ+TBooEuC7A
	PZK2cKM35UMWQROK27vhC4rc1GL+lpXZPEDUZDf6OW4S5NHSyznNHbY2yiEoOTEqxzKWj/IKeGn
	5RorZbTkq1RSrIufqI/aTZ9fOi0vLsXOkaY/cnc+cACiwdCoOustopZ9bfgRnAw6TkRN/OGUHuv
	L35Iu0+/owARACi1fSRYh09kYj6nQs5tk9sHRBoOJTbw==
X-Google-Smtp-Source: AGHT+IEb42thCOUIk/cUikiK6jjogrqhy3XDOYRehOuLLYyhrRMYSxR+lfadQOwWNezm2+NhEEQdPg==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr33718225ad.7.1762679637760;
        Sun, 09 Nov 2025 01:13:57 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:bc7a:cbdc:303c:21d1:e234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm108974225ad.64.2025.11.09.01.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 01:13:57 -0800 (PST)
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
Subject: [PATCH net v4 1/2] net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
Date: Sun,  9 Nov 2025 14:43:35 +0530
Message-ID: <20251109091336.9277-2-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109091336.9277-1-vnranganath.20@gmail.com>
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tcf_connmark_dump(), the variable 'opt' was partially initialized using a
designatied initializer. While the padding bytes are reamined
uninitialized. nla_put() copies the entire structure into a
netlink message, these uninitialized bytes leaked to userspace.

Initialize the structure with memset before assigning its fields
to ensure all members and padding are cleared prior to beign copied.

Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Fixes: 22a5dc0e5e3e ("net: sched: Introduce connmark action")
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 net/sched/act_connmark.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 3e89927d7116..26ba8c2d20ab 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -195,13 +195,15 @@ static inline int tcf_connmark_dump(struct sk_buff *skb, struct tc_action *a,
 	const struct tcf_connmark_info *ci = to_connmark(a);
 	unsigned char *b = skb_tail_pointer(skb);
 	const struct tcf_connmark_parms *parms;
-	struct tc_connmark opt = {
-		.index   = ci->tcf_index,
-		.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
-	};
+	struct tc_connmark opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+
+	opt.index   = ci->tcf_index;
+	opt.refcnt  = refcount_read(&ci->tcf_refcnt) - ref;
+	opt.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind;
+
 	rcu_read_lock();
 	parms = rcu_dereference(ci->parms);
 
-- 
2.43.0


