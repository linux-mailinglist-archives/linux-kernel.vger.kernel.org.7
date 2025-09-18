Return-Path: <linux-kernel+bounces-823567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D5B86DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB05D1CC44A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D660031CA64;
	Thu, 18 Sep 2025 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GabhOFbQ"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B85331CA62
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226320; cv=none; b=WgawllbDKuHNsa9Jzkw+GjCfGSIC90T4gqUukX5ShWwWJFmFJ9MLVmp3l5PjRicrkwzhEF68rTMQe86fmAeK1eP3vGvBQLQ5xqZ2Ey/7Cd+pvZ7msNA2qcjcqyCrPMFj/rwyf/EIlunkZKXxxoLuHxQOCNeIX/5ZuVY50Nn2b3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226320; c=relaxed/simple;
	bh=AFi5DdFh+/5V7snMBQ64aoxQDVUz9zY0bbZXem3ZDAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgJpn5J7sJXVM9lGaeemozBsGhs/jH334jL5p+zhGfy9JL53BJ6D4f06fJV6H/AUcl/KjfaTm2aObcHwsK64wNZFdT4MB2b8yCWeYpYPEolnNvNdz42ANUak/ba8EwHW6ZKrHd0OWD1FapD5TiUr0g3bD5l6gJy5tZ2OtLBilug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GabhOFbQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b7a8ceace8so15850441cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758226317; x=1758831117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fB4PMKHGHfIKWZXnYg77rpKZoRif5ebNQQe0AWVulAI=;
        b=GabhOFbQf05nWi8MUpex3yUBwd3ocOMgamaZE18yDOsFm0O7E4pXc1WFhkS8niuHNR
         qElAX1WYGam39Ccz2KOjp8QVPxJlXQkl8R+iXAdBs2ytya8L8kBuEvZ/VZyofPTisQvV
         PCnojukgIHy8XlBsqM8OPigVlGCthiOUIbLVdJrbK23esbshjO5g5QoFJfloHST2cQKd
         lN94LT3FaoOUxqZDYjry4R17fR3wCR7J/diy29DF6IbKLmS/j9LfZpKbSxJyTjWMPI1G
         w0rSf+BUXfbS4cmwP5KQdge0CVXvi7lx4IVKnQNeLWnUVFvL+Exh4487WNket0ArOfpM
         Ql+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758226317; x=1758831117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fB4PMKHGHfIKWZXnYg77rpKZoRif5ebNQQe0AWVulAI=;
        b=OJuvJdgeynZa2bE74JzXW0oaLxM+ggBHxlgUSK4LlmQV8AY5M9EUa/gK7Fr2FYB56x
         Yk9xZMdNIX8dJUKU32R9HRqZ4nIqE2HjdwGGBYIAETCsk89mzdOIcesYylWc4PCKOrCz
         9ASELxSO0lwDqwzi8/Un8YKTOPzBsRYDW+HNCflf4GkWcZNSkWnLxAtftqRIUJrmFMVm
         w7ujo9mBDAO2WvJV5OgSiAPyV3BVH62TBBQJci8tSO5E6fZR58cBK94xVIVlL/64eLkE
         tPyyd+KRA9XGvJ/6JZotAVCVQdlepymkFRfc5ZXxPgVhTvOvS5YMPg51GSJ3jc+O5dSR
         80cg==
X-Forwarded-Encrypted: i=1; AJvYcCVTq5L5L+FN2u2YDtg0Dn9Q0irl9NMVyMEDdTxKfq6LCBItMhkuKbS4HWbWwG+iiNA0o8bVmOTnQ5QRiBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9PhmtF6nh/devGH2mLNojXPMOpWLRMwfVa039eFbizvokFNF4
	GWKtud4IUCbAkvdlSRUIU2KnqLihkemE0HgTMYeIaGbXppZXIsHuCqyc
X-Gm-Gg: ASbGnct1Kawkry86vv9iE+ZzRxOnP79F8aJ6sFcSPFsyG7AFmsgHJSP1ppYyy4PFOMb
	nZE6iFDtHkTAObMmKEekhuGesdHxG2pajX9sV51Kw7jKUQ3HXajEZlY4fX3tQZNLuuwdNz87qIx
	EZa2L1D/AZA7IN6BTZpMEUkA2kc0/zYv/frWjZjpjHhd9ammCWCvKdBsB29/YnJV0bUXs7/HbIv
	PAcq12dZAbUrN7a94auaHiapwRqpB8//e0lxyv92A42B/PQd6QGR6xyEp3j3GufRzwV0DQlZEf1
	DgYadLSUEo83I/pFGx0fewUxPzUGcVN3X1FAHDN3nVgvHNnIGWsABRVlNYcATMOtFDHTwlOnn5c
	zyOjBJy243MX6VvN4kd8gsnFNY6Liqm5sKUDHcCe9UdJt
X-Google-Smtp-Source: AGHT+IH6ghb5zeNlCjOlURltdRO0PpOlpaN5aQ8ddhGkViobigXgjnQAIiFPcPqWg/SNpo204yM6Yw==
X-Received: by 2002:ac8:5dd1:0:b0:4b3:4457:feca with SMTP id d75a77b69052e-4c06fc18407mr7944931cf.6.1758226317292;
        Thu, 18 Sep 2025 13:11:57 -0700 (PDT)
Received: from jl.umd.edu ([129.2.89.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-83630299579sm222392985a.41.2025.09.18.13.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:11:56 -0700 (PDT)
From: julian-lagattuta <julian.lagattuta@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julian-lagattuta <julian.lagattuta@gmail.com>
Subject: [PATCH 4/6] module: move idempotent allocation to heap
Date: Thu, 18 Sep 2025 16:11:12 -0400
Message-ID: <20250918201109.24620-10-julian.lagattuta@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918201109.24620-2-julian.lagattuta@gmail.com>
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct idempotent is normally allocated on the stack.
If init crashes during a finit_module syscall and then the module is unloaded,
reloading the module causes issues. This is because the struct idempotent stored
in the list becomes stale after the crash.

Therefore idempotent is stored on the heap and placed inside the struct module 
to be completed by delete_module.

I am open to the idea of only storing it in the heap when 
CONFIG_MODULE_FORCE_UNLOAD is enabled; however, simple seemed better.

Signed-off-by: julian-lagattuta <julian.lagattuta@gmail.com>
---
 kernel/module/main.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2825ac177c62..217185dbc3c1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3650,6 +3650,8 @@ static int idempotent_complete(struct idempotent *u, int ret)
 		complete(&pos->complete);
 	}
 	spin_unlock(&idem_lock);
+
+	kfree(u);
 	return ret;
 }
 
@@ -3666,13 +3668,19 @@ static int idempotent_complete(struct idempotent *u, int ret)
  */
 static int idempotent_wait_for_completion(struct idempotent *u)
 {
+	int ret;
+
 	if (wait_for_completion_interruptible(&u->complete)) {
 		spin_lock(&idem_lock);
 		if (!hlist_unhashed(&u->entry))
 			hlist_del(&u->entry);
 		spin_unlock(&idem_lock);
 	}
-	return u->ret;
+	ret = u->ret;
+
+	kfree(u);
+
+	return ret;
 }
 
 static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
@@ -3705,21 +3713,26 @@ static int init_module_from_file(struct file *f, const char __user * uargs, int
 
 static int idempotent_init_module(struct file *f, const char __user * uargs, int flags)
 {
-	struct idempotent idem;
+	struct idempotent *idem;
+
+	idem = kmalloc(sizeof(*idem), GFP_KERNEL);
+	if (!idem)
+		return -ENOMEM;
+
 
 	if (!(f->f_mode & FMODE_READ))
 		return -EBADF;
 
 	/* Are we the winners of the race and get to do this? */
-	if (!idempotent(&idem, file_inode(f))) {
-		int ret = init_module_from_file(f, uargs, flags);
-		return idempotent_complete(&idem, ret);
+	if (!idempotent(idem, file_inode(f))) {
+		int ret = init_module_from_file(f, uargs, flags, idem);
+		return idempotent_complete(idem, ret);
 	}
 
 	/*
 	 * Somebody else won the race and is loading the module.
 	 */
-	return idempotent_wait_for_completion(&idem);
+	return idempotent_wait_for_completion(idem);
 }
 
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
-- 
2.45.2


