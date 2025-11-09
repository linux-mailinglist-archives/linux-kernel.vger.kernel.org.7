Return-Path: <linux-kernel+bounces-891854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86AC43A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A260D4E59DF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151C2D0C9D;
	Sun,  9 Nov 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL04uAuz"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC82C158F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762679647; cv=none; b=fKtL1g3KzQxeBMEn/lTKGJT4vEjhKOa5eijNhhqXZ/p/L1QxmKF0jSmRCSx13inyVEeT5DLj8twv4AHadJYIMsHlCW+5VwESnqBBlvcl1YzC+WLDZbCfy0CXxvMfIfUbxbuNk6BP1kJNpVAlfcUPheQQrtQxAm5j0miRjOfEH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762679647; c=relaxed/simple;
	bh=HnQiRwzviFZfkE6loxr/BOANkRT7iJY6innAQLrusbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDenBs7/NBC5gBS3XuDTuLHKAx5UNggWNXR+mL3UVStatqckP7ONhoZdYNR+YEt5Q1QeJz+zWx02PY5YuxZAFVQSNpqnAaJGDMIm/dUnZ1VwvPE6mXR4/L3maqJ7dWv+oC6mEx1mN1vo+ya/ciFPdItvda/6wbgUqGNnjdv0nig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL04uAuz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34368216f06so215380a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762679645; x=1763284445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PMsTc2iEamsoaNNgA4bvlleTLsvEej8IKKb+6/VtSo=;
        b=LL04uAuzG1+SIqqnm04+LCVDI8h2vl+FSxIHjHND88ZIXrn8ZRHm2YRP3xvDl8OD7T
         6QKZlK2Rf8HO2zNzeKIHv9nQV7mO5yVpMAE57mOV4hFDQozRe6q8hRv2ak5A4yQUEcKq
         7fDduXL9Q1ROM+gHbt8GuJ/CJa9eEPi+chw7YIpHCNuEK/PeJv26mfU8pkmUcDiQGPij
         YHtoPIh52FOhsc2qc+TjRbUwY6PT4Av9CczTWYKlj4USIgHEvkG9IfSY+2jAj0Mo+nln
         Nf+wdhdMwnVOQQEMoaSWr/exHwL+rJuJJ3XHDUMcCsHtm1x3lQnNP2hJ3j+66BlibkK0
         xRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762679645; x=1763284445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PMsTc2iEamsoaNNgA4bvlleTLsvEej8IKKb+6/VtSo=;
        b=g+hBr+qiA0bv+kkEqOx2nIaSbqiHDv1BWSolNMwaK+hYihnFomrxSIr3gJmLBaOoHM
         T8yJHHL5gh0V518Vg1FwVi2FGjlxPkDhqbfGQcP4PgK+gNdDzUHmrLoNOpXsmbPUbSmC
         WATBh8w4Wo+eHD+lYfpUZ1dbAG9msjpLerypXmqyZw7Qq6+bcQFRjavz+3nXM9UUaXBl
         2qMbKD9sisFdsMXr1DaTvT5mAU6QJjn0LPfYoZeqkVVVnmY4Lj/FWxIsRfSkpu5XfZ3a
         VN8Qi6YNYitFPTGNSxdJ6LdYHJtzTQOe5TTTkzlAVeGlEMvY+LP39w4U+vMUG4//mE2h
         KuYw==
X-Gm-Message-State: AOJu0YwPHlV4X1RfLSuskTxlH1M5LTUXvW+3Mc9Rj6XZ6HmnPb/D7nju
	2EOuIs5L/xQ33dlYEdEtajlqLL0k2NocV/JF5XtE842kVaD7RkBHbDVV
X-Gm-Gg: ASbGnctMIg4TFSIURC/EnLqnlYiMqLX/wAxIL0cSVvMau5T0hTXx9bTWPZO9GaItO98
	qWBkg9e4UnIN5bx/iHnY5UPcCt8/7TL6YBJtSZrV8cfTwj+erWh1NvM6h4WZEF3rPmDf9Y7aCS6
	1yY1Ye3ZHZ9SeRL258HJU8/qm26rxd/Q7F8rYpO6ETq6tGAbTDZAjhgRf907+UaBbaqfojqrlB8
	xjP74sQdIrzQQew/pq3KZfmbZ/6+oYy3V8KRYJzsptk2XM2YDo+RpoO8/FzZBhRCL9ijfTx520d
	lwxMKd35jjPHtgm5hF4hhO1H5qmUHqN+PrmMFp7iL2e1UX8q1j2FEeBFrmkvxW4cqcqY0+bDoCg
	eesq12PfYIqiUAVWym4IoUw9jpC42HWYG0ofMayc5FJokpkr2ap84HMKh9jJMb8Bnbetz1S97mR
	2c2mCKUNxo/KIhxLyzHLtNSL0AgMn3vk08UCEIh/GlwQ==
X-Google-Smtp-Source: AGHT+IHjXNmhuS8efz6vClWXbs3pBS9HpVo6djl/mfWt5tPuH+GEG2YZZK7drOxtvdXymvEDjvlxIg==
X-Received: by 2002:a17:903:2343:b0:277:c230:bfca with SMTP id d9443c01a7336-297e565283dmr32156275ad.4.1762679645191;
        Sun, 09 Nov 2025 01:14:05 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:bc7a:cbdc:303c:21d1:e234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm108974225ad.64.2025.11.09.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 01:14:04 -0800 (PST)
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
Subject: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
Date: Sun,  9 Nov 2025 14:43:36 +0530
Message-ID: <20251109091336.9277-3-vnranganath.20@gmail.com>
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


