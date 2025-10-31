Return-Path: <linux-kernel+bounces-880153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8515AC24FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F7F4351111
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A7348862;
	Fri, 31 Oct 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1asyvAI"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5EB242D8A
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913496; cv=none; b=bUZ76FBpEZsP923PcNKkbHE+kmiaIqsIV3hmrUuR+EmDjRtjZkkyEGwWKSchBV1UjAD+2uj6oxLltJnKWDlsvskACsR6FAOBVEVULn33bm7FL9p6hZeMVFpeokR2JtdAiPOhHm2cGFT6XKamQbGq1jyY3HuYveTly3KRiwnRqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913496; c=relaxed/simple;
	bh=Y66ckEvjvtnhjR24BjBtiS57XqFb+Ky669W3IQ8Uc/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oMR8N6/JWVAVSyq94AG4bkuYJ8H3P6go5gyh+49KgA9wx/qyHeFJP6PUWAxk9nxsL7N8kN5UO+c3Ftl0D+YfI0uGoL7MmwEzvVAzB5ylMm5mbMVvp32zjnj3SQ+ZxG3r2H4v0fgpKHmxXQGNIH+MT0R2c9SB1cMJJq/uJht7Z8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1asyvAI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a271fc7e6bso390574b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761913494; x=1762518294; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kA4eiGvrcUQKapvU5kcBIm2q6gz7Mks5lq1mQ3d3x5w=;
        b=M1asyvAIekgsKgNoxpzsIYk4I+4cmACA+pT/LGwZpsZZ8NBboZjPeecTe4a/hBNWE3
         rehYWP99A/GnrZ9Ck0iWT0IzcHzfYoIoTv6NlA5jA7SQx8nJKsxB59oZU6sw5w/3Pn49
         Sqz+b0MvHZcyxd2UvaJ2P7N7sFnW7U5GbRjIv6U1/OaftXDvGxi8vprR1w3X5EJmsZNe
         wgz4z+tBfg9h2NUpSNfHbnnTOtnuuU4taSgp0mlA37NyUVF6Wuw2C3VVUCUHCiBVo+KF
         GQnfULJtsSRuLnVu+s9P81UVMQfffa1pELpldAgrYkCNueVEcE7UwdpeSVSv7DPfMtBE
         2tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761913494; x=1762518294;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kA4eiGvrcUQKapvU5kcBIm2q6gz7Mks5lq1mQ3d3x5w=;
        b=dXfjfwcBT1A3nbMuETdzskFlE6VyukzWNv0df1e2dcTyhKPRyKHu4ha6X8alo0WXJW
         iF2hi4K45LpNeysR2BarRik5FNKJP6+sUhJiGpsiAzDB6F0xVr0+2JevCsa3Kp7XMUnF
         4vnMMe/9s6J8UX67x1fVyBvNdPC/N/mfUP7G0EqZo4j7LS2btIxBIVLjkxTh6zdOvAOU
         QXQ/qWoHyJPg2tx9VTIA3JHvRgM4P4rrniukPVZFuPRVMWkHAc12VJGEJXvKuqT6OIL4
         l/IFbpLTKqZycQIowrl2G99TT+eN5YpCwZTphEM4Uq2zf/e+2yv011CQzeGyuf+nxSm+
         Wj9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/0PDco+fLKsV5nDSCoODFS9oSOcOAWsANbIr4V/yq4vlYI6HC/y8k2onKSUjkwQxUXFpuRKhRitANz4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtxo0KV5K7KeloJXgjinK8LP3ou1KNtLaBvukCKirrPvO36KwX
	BfQbVT9n5nyOcSsgQoF3XKqd8NfpuUUgYMzzgBIaODHntVLpJg5wlj8P
X-Gm-Gg: ASbGncseS9rji9OpvdhSwP1TRlK2HAYScGNRJcVODQ4wKsEr43Rl9UI9Lj/fm66ggtk
	IHqGhRNw6xsNkIWBA/X3hJJEtbMpovpY2szEyaG+OsKhhTtBUHpYGeHWfpe6HAoakWPjvB92bbT
	duL5eO+l/Z+8v/IGbBij5b4JAkU9il++eJL6Z1yKns/Z8jpa6fDpAdTxU0dCd8Q5ZneyAFw6D83
	PpcnCHdhFKoLV5QGwmhEII1PZ5pollEJqhmvc+jv5MnY4TtL/VxNuFcUWKeIqwTp2kvQcSrLYWJ
	waGVIKf6FKwEL+Oc8Y/cF8ZAaXdsR2oR5ToR8SQxut7Tlu1VSCzYYSf4ncEslX1X0CwA6QUF6wx
	/CyraR/TEcTS7PX9p3SYvkDXz1cRYCZw72EaWr/bgZ/Zhq2j09yRC049G/sRM8KK8M340LuWNZu
	bjMI7OXG3y3zMr9jWIrFWyoccNGz/vlX+X/pK7GoLmBQ==
X-Google-Smtp-Source: AGHT+IF6kAFNrFllQ0zDpOrghfPSaKBaGJtRBoDThOoMjH+SuWUWv1YoOL7AYSxtynciu5SEjAdfdA==
X-Received: by 2002:a05:6a21:6d9e:b0:244:aefe:71ef with SMTP id adf61e73a8af0-348ccc044b9mr2487003637.6.1761913493991;
        Fri, 31 Oct 2025 05:24:53 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:5702:8dcc:c993:b9bb:4994])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db67cbdfsm2086639b3a.49.2025.10.31.05.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:24:53 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Fri, 31 Oct 2025 17:54:43 +0530
Subject: [PATCH] net: sched: act_ife: initialize struct tc_ife to fix KMSAN
 kernel-infoleak
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-infoleak-v1-1-9f7250ee33aa@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIqqBGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2ND3cy8tPyc1MRsXYtE85RUs8S0ZEsLcyWg8oKi1LTMCrBR0bG1tQA
 LhyiFWgAAAA==
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913489; l=2758;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=Y66ckEvjvtnhjR24BjBtiS57XqFb+Ky669W3IQ8Uc/8=;
 b=33eyT/pXFi3nNGN+9479Hggr+jQ9J6Kl06dy4BiDsIUEPo/wD3BQpTeJuZs/ZUlmJxISzNa/0
 vXwIWSu4mFSCuhs1QhN+6DvJly7CJrhvTpJbud3CZn/xFzYZkTzaiUR
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
Fix a KMSAN kernel-infoleak detected  by the syzbot .

[net?] KMSAN: kernel-infoleak in __skb_datagram_iter

In tcf_ife_dump(), the variable 'opt' was partially initialized using a
designatied initializer. While the padding bytes are reamined
uninitialized. nla_put() copies the entire structure into a
netlink message, these uninitialized bytes leaked to userspace.

Initialize the structure with memset before assigning its fields
to ensure all members and padding are cleared prior to beign copied.
---
 net/sched/act_ife.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 107c6d83dc5c..608ef6cc2224 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -644,13 +644,16 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
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
+	memset(&t, 0, sizeof(t));
+
+	opt.index = ife->tcf_index,
+	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
+
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;
 	p = rcu_dereference_protected(ife->params,

---
base-commit: d127176862a93c4b3216bda533d2bee170af5e71
change-id: 20251031-infoleak-8a7de6afc987

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


