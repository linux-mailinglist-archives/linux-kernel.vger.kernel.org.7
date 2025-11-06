Return-Path: <linux-kernel+bounces-889326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B80EFC3D4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 20:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E17DC4E616A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA26350A28;
	Thu,  6 Nov 2025 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvCMQq9P"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53A2DF700
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459024; cv=none; b=Ph+T+4idHXUhNSrKd8PgoJwpHgZHgwfwJgFfcKtQCBdXxyX1+5yo/eGXSFpeei00etVjh0HvQzv0LMIDmONm4tPeHyjxvEBaYFYbbui2zZIycs9BVZlSl7eOROcgYZ8gPCXl2T91MU6z/IPZCf3kMm9H/u0nXgBiNgeNYoO8Ta4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459024; c=relaxed/simple;
	bh=hsCI2B35eg3VdUKU7IHlxYdYmWmKF/gxitpVILRLqSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tujFy/pIG5XY1M7w3dxg1/eK80XZTypPzH7B6IsfFGV/TPrMnSRbNytfKlmDWl/mBkilk60Ygg+4Zs1H3ZKQ9eWljmv5Y8I5gT3pgNvNk7Jts8EKLO0U6lyqmw6e2IjIaSvuOBTBrywD40hkdEYTxcvZcw3lPOeeW+ypEliv+Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvCMQq9P; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b8f70154354so506a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459023; x=1763063823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKQZJes3dV7Wm13cikS86S+AarGtDoSVY0Ws8VEcad4=;
        b=MvCMQq9P+fdaBItBLpttqAkkMAGUxHZyWjehNhvKdS7QhLmlzt2IwJThfABM7PHhps
         DQu4OVTTN1V558Dkb5A1AQwM/ZcPWauatHr3A92cP83VQHrCjyp0K5GDFmUbWRp2nXMb
         GptZCT5NM5CI+ow8yIffV3WxStdl3CvL+8+e2gGUmUMlzhJb60zOy6W/r8yyM8E2aMb7
         GHJi1FipqNfIWg02mNP2s7v6BIWj95YSoKtodt8DHXH8TLcnsSUDyAgJRLPqDDYcKc9e
         vf6S5bzLrSmTQJgm2qhoKlqunDRO7wo3NBCAfClPhbxbWhq8gnBg+UuHsyZ7v2F4Toho
         exBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459023; x=1763063823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKQZJes3dV7Wm13cikS86S+AarGtDoSVY0Ws8VEcad4=;
        b=CWHDzghwujNSzeri7v29U3qeWOor/UEh4wCLE44mXvH4jJewiIHpiV/UWfnJAIq+yG
         /2mV22p7E2WiB1bHxhsWvXUpOpKVOQ3E8JBMXmGCxYiX5iHoKEiVD0mCRkb4PB7x39zq
         LdJaQ+MTG0WAmUUx7yRd76CQxwIUKyc3+t1exsQQeDYKYZHEUsBMlCWj1/HoZYNPhVCb
         RTz9QPainjBsTALn1MaSZb6nWGqOQnN7S7+QVOeluZpQn9RV9ohXf+RAVg5BZ5zsxqvq
         gSySY1JehlV9FN+Q9K81MPlNo04pAPaCo/XYkM8BRAB5A0wh2B3CWTxh0Emm0SnJJz4q
         2a3A==
X-Forwarded-Encrypted: i=1; AJvYcCVP+2cy2KIVO2HC1sH6zx4D+6FzXTtIYVPV5VXnH0ZUklCdB4kqUg2v28DJdqIhHoV0YsZIX0HpBckY//M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4qnKWN1OspawT0NNOulUefM8UDM7azWrymfjwWI/rfY7E7E4I
	WYwQ4b/6ssh0p9IGkdTzwb2g7H72/rW1X/Zv+7uq/TiPq2oJ7WbjztGO
X-Gm-Gg: ASbGnctRj86gk3K2aWcsKasi3jNqBvj6BB+MqtyTl6mx7H64RGgPPGkiRknRxDB/UVX
	dfDqxo7ozO4yl31/nxoq0KW/qSxNTrqyZO0a/ElMK20icDrUPoWdG/Nn5cvbkhirBXf2T8s1jl4
	fvNXwDaWXbC2492U0xwAfYNBIfl1JDrJFJpEb3G/G/83ZSMkoGR+Rs1ddU6IOETZTAcRqdVaiXL
	1zzmDO+41EhuNvTjKjr11ZggDnJpj2EzQW0Uxj1OqyUISSt/C2QC3nwAxoWDG9R3+X3hgVitLWU
	JCWm77Gr+LQnelTu42X8shvAW3qg0kEUVAzXUBBfaef+2bgCWaFUGfNnsrH+Ueu6e9QE1yhrSab
	VsBxufsYDBvEgr7V/QbBcP9/rG1HkvrEV/zWZqDh9hU5InvUjZnQK56wiIX8vpEUNgBAoH8eM/8
	Ee/HI8xXM2iSSaj8zfJc5KH7QjIQq+a3MjcZXje/Mj/w==
X-Google-Smtp-Source: AGHT+IH6zEmUN6vmiW4J1BiS6HaiwG/z1An2ceST2X7NQPzM5nnSYeV6WQ7jOJGjNnz59T3lA3K0MQ==
X-Received: by 2002:aa7:88c2:0:b0:77f:1a6a:e72b with SMTP id d2e1a72fcca58-7b0bdb86450mr470949b3a.5.1762459022802;
        Thu, 06 Nov 2025 11:57:02 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:e5b3:bd3b:a747:7dbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm391246b3a.3.2025.11.06.11.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:57:02 -0800 (PST)
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
Subject: [PATCH v3 1/2] net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
Date: Fri,  7 Nov 2025 01:26:33 +0530
Message-ID: <20251106195635.2438-2-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106195635.2438-1-vnranganath.20@gmail.com>
References: <20251106195635.2438-1-vnranganath.20@gmail.com>
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

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 net/sched/act_connmark.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 3e89927d7116..2aaaaee9b6bb 100644
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
+	index   = ci->tcf_index;
+	refcnt  = refcount_read(&ci->tcf_refcnt) - ref;
+	bindcnt = atomic_read(&ci->tcf_bindcnt) - bind;
+
 	rcu_read_lock();
 	parms = rcu_dereference(ci->parms);
 
-- 
2.43.0


