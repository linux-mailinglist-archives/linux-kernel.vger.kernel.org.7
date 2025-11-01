Return-Path: <linux-kernel+bounces-881275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB2CC27E23
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5916A4E900E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FA12F7479;
	Sat,  1 Nov 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ued7h9x5"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0518A6B0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000509; cv=none; b=YdtY092qF0NEKwXn2rFFVbxozg5r/fzz2hS6b46CySNPE0AOk+wHQSrSvHt1j3PhM4rfzE6uvHKjTiEyWUcOn5j/H4GAOyJujkArin/KF1CClC1NGTfYb8OEGF6ezHeGttrTTJVK+mR4Liq4pmXBRL/kH3uiOD/CleLVr8lUnAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000509; c=relaxed/simple;
	bh=5lljvy+eeKPbsrR97UeOzg7UMYKoHcYzDLWKuAQGdYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAsVa5dYmFJnSX54Xbf3AltZl46fKlrspkaaybu6jKUZdXJiNORV7eFBxpCm4a3W7pKKVQ7YI/mDcAkBoU0154KqUkOPziscpbPA6CkwElqtbSWDFHG66aja6fBx6Pv5z4G1ngIwBDgLO2MPjHRrWbTOOWAwZm1lwrq6KSzCf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ued7h9x5; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34053e17eb6so382979a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762000504; x=1762605304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iow4Uh3JbPUWEJRhV4H6RzrlPY1bk6TBjtSGGBlaN4=;
        b=Ued7h9x5vp0OfEsZWuXKwb9qcb5oLIHTWDDn4AxY+qZkmycD2q3m44JV4+7frRu/UA
         wYyq0oLtY1dNqRwF2SOVVvcruV0ARLln9kOuRJuxiMVSqViyXG5kt5DEDTWR9Psji40A
         g6SlYcW/pWt46sl8AHfdbG2IYlzJcuXhm/rb5mwjV/9uIajQD/xSRbanNOnQwsHc+X+q
         /d1FSnKge3SyE6LJnqbPdWY2o5vc1RAFvWex38Vy08ujVzdqtKrQo2HzrYvbmqClZlQ9
         Z21Yf/Sn+CGkHMZ2iucHUZ2VdqGQ33dZTk0/seAtBGPYHvSPaIOKvn6iI4D1+C5BLnKz
         FIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762000504; x=1762605304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iow4Uh3JbPUWEJRhV4H6RzrlPY1bk6TBjtSGGBlaN4=;
        b=QvCcwLyOXR8zIq4Y19h20xlBLiv0W/O3naNX+IGGEtg/mjtbDV8sPvsdVLvARinT5J
         JbAwGC50E8HzW7caHEL8p5+1aI+Hl6HisaXJBa0uq9oRT2cKvxNxyiqEeUyiG7Yt4vhT
         HWn1rMtNqjoXJbxFN4dXvDEHoRDJ7F2sgZeREZGucVt0cvtMhNGhaYuHNqGeLJqTb1em
         E9YQprBikeZEDC3iCOLvkCHA1okZooIHFz8vtEc7pUUWCnbs7UuHfmGXn7qCIwS0zsh+
         nzaes8sdV5QM+F+U2nOrhM61pjLp4gquxuL5JdiVXwq5sQC3sa6vcuxepLpv5pmFQ+0j
         2mJg==
X-Forwarded-Encrypted: i=1; AJvYcCVDzRWH6qED8c1q85M4r0zBgLPoBHUHvsGS3PHn3kfA4ViBTx7CO0At9fozs9xpuyIUZyfdxdC09luLpDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHbLQZ84gx4g5fDQwtkpu9I1QS2lhscAPafrz37OKbBE+KTb9k
	MqNDPZquN8VjMV2AGhnWi2Pr+Zqdj41Owv+O8j3aq+6VkcpnK9cOI3a7
X-Gm-Gg: ASbGncvLsuA7N/NFjh9HOTkChJZDX3R7qAjxgLsKoY0tW8W/AFArHRvevGB+1lBGOTX
	6dj7kY7HN8CUu0yW3lDBz0dDC6MywVNKG4jU5Ytk1s7dq6W/ONtXdgs24aANoxSjsYEuVEC1qND
	LQzOM5yDVyo3k38GxjuiQfOnpPUcAJBV2EfTdWb8qjnNb3OkmcOBKfCcojkeBUyPMt6rEVAiUUm
	0opHgJIahbiX2TRDJVF6EPEOTpgqikEZ8dsdDN79hVNS629k/JywjzpXq0COGQBh/D+7Qw5Ia4K
	GSDalQFCnVRPPqNweaAQCSDsvd/HaaC3Vktw/WSQyGwCYzkAs5Rn1wX3zuczYlrgwllIiQLe+my
	Bfy8/OROuZkQmd5V8HtJ6QChCHeuGMy3J90tr+9sEc1YWnpLsbBYm7erlLI1pdal1/iaXXds/+p
	k3wLgoOpiWxres/WtvrgCs/+crMhQ85SWIsupoi4mt
X-Google-Smtp-Source: AGHT+IGaymgUrpOcvB4JBLFSPVUyGWWS9X0AS3vOHetSYGMoN5nDwO4YcwN9LuZvJ9JYCEcykcWlKg==
X-Received: by 2002:aa7:88cd:0:b0:7a5:396d:76d3 with SMTP id d2e1a72fcca58-7a7797c005bmr3975673b3a.4.1762000503825;
        Sat, 01 Nov 2025 05:35:03 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:9fcf:a95f:918:2618:d2cf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm5214017b3a.60.2025.11.01.05.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:35:03 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sat, 01 Nov 2025 18:04:48 +0530
Subject: [PATCH v2 2/2] net: sched: act_connmark: zero initialize the
 struct to avoid KMSAN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-infoleak-v2-2-01a501d41c09@gmail.com>
References: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
In-Reply-To: <20251101-infoleak-v2-0-01a501d41c09@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762000490; l=1124;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=5lljvy+eeKPbsrR97UeOzg7UMYKoHcYzDLWKuAQGdYE=;
 b=bNfAU7fFhFu8TXmm6LrwvsK/5elG10436Ao1RifFc2YEB/o84xMwIUoUqeEcARWUBz37FRUsC
 SgI8FmaDr2wBYAcMsXO0YTdp3BUjZOLvpN3TozwQf8vw5mi/iZdNnGH
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

zero initialize the struct to avoid the infoleak to the userspace.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 net/sched/act_connmark.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 3e89927d7116..cf3cdfaaa34b 100644
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
+	opt.index   = ci->tcf_index,
+	opt.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
+
 	rcu_read_lock();
 	parms = rcu_dereference(ci->parms);
 

-- 
2.43.0


