Return-Path: <linux-kernel+bounces-881274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBFAC27E20
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BC014EA0BA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CDB2E2DDA;
	Sat,  1 Nov 2025 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI8oYo/Q"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82018A6B0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000502; cv=none; b=EDWbvgbz7CG6Sb+5ZHH8Kh0gYRdaP2cXQ44Ex0NTYKt9FeWHtv+jN8/OcDTihbdDh26qwCElzO8pC9lTvXvoFa6ky17mOxh9mK0tAUxs0nwm55WUojMQyB5vSuE6aazBNfOe2D3DlU4C0x0SG8SC08aA4/uW8XFZtafUS2mO9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000502; c=relaxed/simple;
	bh=chT7ZuJdmZz2+odZdjWBl1QPwpZX5AyyiSBmBy+TRRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgXcrozz/sCU7vxOlgwQrrGAdUKxaE3rKs65EO5ruyRrKhV5SPYAyt+lGZg47Z1uTG7AZVB10shKNHTyqOfn34WrmFgS41FWTAf3LkBss24t8xtpedvH3R2N+GtBbPH74RcFcH+1Chwy5LIR/fGCPvu4wPHfIC1PDRM9uWjqs3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI8oYo/Q; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340299fd35aso545851a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762000500; x=1762605300; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDRT+NEI4paVe6C3WZWM0dixLtLFOOKY3SXggLATTdE=;
        b=KI8oYo/QLWsn+hDSKqleoz+sPr2vstS6qoomYQ+B1wEKKSJdPW1/wDogvSchBMoC13
         r0RFnrEPBHln01PTB2S1KJasxAQgJqmpEB56be1AoQDIwGxyk7jUGA7eHd6Wn3a0N4Eq
         evh/k7Wz6wPyYWTZhdfFZ59PT1DtKRdcdJ+1JYuLsRZWdf2lnRXw6PxTSXqlf2Qda5EZ
         OC2OsLkjslWHtS0ruJOitXNNKwcGSiUK507MSomOu5ytfK43J2oh7eba+wAdVGwP8ADB
         LjXPzv1RmpiWuK7fvmbbt/TRXIzbSv5qZ7Jwh32+kDpOjbcNS3rV4AeUQFkfGgGsXP8+
         trAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762000500; x=1762605300;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDRT+NEI4paVe6C3WZWM0dixLtLFOOKY3SXggLATTdE=;
        b=DJYsttGO1QGr/ljPQFPMtvfUTdRkpskTKjjTUyXrpzBf+XHz3DEIUA9kMrbByFqkLq
         yuyIk+IDxnwZJzUlHpNH4ToSwLMtRyfEXJh//gAiZpx87sCYSi9P4oH7vUEn1ZfwDTqX
         o66RmjD7Ybkj/Ybtx1X3y7vd3VsFiiSG7E01CYYtFIfU/9Epm0r0DBFv8Mse4ASU5oWZ
         xnWDsn3rHlYt5Ql6sr5cVlHV8JBkxRQrB4VwBz8H2pmYrmER6f6XoQXSNHmULK4sNKd/
         inj2OzHXed9eoRwjc01C8TtBzqPSXInc6WhAdrlXVnWtZqWLZr1o3Xy5+37Ave+jNSj/
         LKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaGffuCloEAlZ4XIcJLVyxJdf5N/NR22AxVfmzh0TtQ5IDcR7cQE5+//OzAZb64fjJHd1ArbT+k6WmbEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQLN6fcC9KXaVpqRTlC9Fol8DgJYLL0F9ue6xHqnh34ZYEV29U
	ieRFEGuWjI6nnbGgpvWOziecPusV9wMDdTCtAk9oG2ySVAlwA1DH6vHV
X-Gm-Gg: ASbGncsGcz6xdKFaPNzf6N2RGYXsoPjMd7LDnCGDhacLZQqNnhk4jFIKvcPqx0+IbN8
	4FbxIzuRaWHuCcAucRjnQmZ+5sIMzxG3XPsLbSwhQdrRyaZlZ9zLFXDEZkhFKMIIR20EXjbQ5w0
	iQsvtPfOf6lH4q5e92ph2DUfhSna/DceJTxpFPeKfy+SLwtOMVjpcI2JUYrglfdqeAl69+yalJF
	BZB3O26wC9OAxUYHd9Lb3zN8WHO9xrb+TCxE163T5maYXWda09gGEM5ohKwgPtPsOpqnPYRE666
	/a0xEsBvwuJkuU2sCaHq7FDamPWo68urh11aBuUd9vwblBxGfLRDO0dFyDuPhn3pKSOIVVPzK4g
	yk4Rcim9m1FNv4Lv8TbPMjk0tPJSA3FwyCo8kSwIlAqb+WrtlHwDMhGti6dHjO19JOxYQkh0kOV
	WlZ6cMA1E6gecFEy3OyU6jiVyO7d6fgV6GTrq/nOLC
X-Google-Smtp-Source: AGHT+IEIpXxPwq5sEDlkOcaHuDBQuKRHH2343dqIJklYh5KJcqhNIUb8e5LlvsFd0ntOyTjMFiZdcQ==
X-Received: by 2002:a17:90b:180e:b0:332:3ffe:4be5 with SMTP id 98e67ed59e1d1-340830b422fmr4786530a91.7.1762000499628;
        Sat, 01 Nov 2025 05:34:59 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:9fcf:a95f:918:2618:d2cf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm5214017b3a.60.2025.11.01.05.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:34:59 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sat, 01 Nov 2025 18:04:47 +0530
Subject: [PATCH v2 1/2] net: sched: act_ife: initialize struct tc_ife to
 fix KMSAN kernel-infoleak
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-infoleak-v2-1-01a501d41c09@gmail.com>
References: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
In-Reply-To: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 Ranganath V N <vnranganath.20@gmail.com>, 
 syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762000490; l=2056;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=chT7ZuJdmZz2+odZdjWBl1QPwpZX5AyyiSBmBy+TRRQ=;
 b=QhYz129puv3oVszl5c9tMRyDFQV70rx+6GTRyuQ2lTGOmSohCfnYhkr7dhtyfXGznRR41o9n/
 ydrxrEdNIyCBMzus9PmjGIv2Da7KLzDO3m1QO4QL6o08Ea53pyn97Pe
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix a KMSAN kernel-infoleak detected  by the syzbot .

[net?] KMSAN: kernel-infoleak in __skb_datagram_iter

In tcf_ife_dump(), the variable 'opt' was partially initialized using a
designatied initializer. While the padding bytes are reamined
uninitialized. nla_put() copies the entire structure into a
netlink message, these uninitialized bytes leaked to userspace.

Initialize the structure with memset before assigning its fields
to ensure all members and padding are cleared prior to beign copied.

This change silences the KMSAN report and prevents potential information
leaks from the kernel memory.

This fix has been tested and validated by syzbot. This patch closes the
bug reported at the following syzkaller link and ensures no infoleak.

Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Fixes: ef6980b6becb ("introduce IFE action")
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 net/sched/act_ife.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 107c6d83dc5c..7c6975632fc2 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tcf_ife_info *ife = to_ife(a);
 	struct tcf_ife_params *p;
-	struct tc_ife opt = {
-		.index = ife->tcf_index,
-		.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
-	};
+	struct tc_ife opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+
+	opt.index = ife->tcf_index,
+	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
+
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;
 	p = rcu_dereference_protected(ife->params,

-- 
2.43.0


