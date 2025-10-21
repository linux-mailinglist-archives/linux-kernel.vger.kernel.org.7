Return-Path: <linux-kernel+bounces-863150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25432BF7222
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDFB540E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75BE33B946;
	Tue, 21 Oct 2025 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b="mr4zgvvp"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AD1F237A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057604; cv=none; b=jInLZ8tc8Zd3ipcfgun8n33syMTH/VmBVbclp7MmNWlKWIvdnArbVh5JQ0L5XBzM/PT29knlQA1YxftMqmL7LvF7SbatshC5Q2hlLwYa/8jBeiEJo252SNMWmbS6GRJ6yB23VmxnxJzWLZ2bV5Vv1R2JTjZeTFGquvAT5TVFEmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057604; c=relaxed/simple;
	bh=vTmwzj7jCVGxM0hspAF/xKQ5dD8scHgK7MFySuizQi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZv7B1+mVVQJpb/wypgyMiZtXlnnGDbXPYMgrHtS+ZB5+gAAkvJuWwRnGCC1d/6ozPLURmHOuYR8eZ2/fjJwdo8G/gX95TwFMnASVYYc2GpsmJ+SDm3jmktcG7uRg2xH7offzdLIpLRR4qw4tiQYWOJYz8osd2rNJafRoeNa99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in; spf=pass smtp.mailfrom=ssn.edu.in; dkim=pass (1024-bit key) header.d=ssn.edu.in header.i=@ssn.edu.in header.b=mr4zgvvp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ssn.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssn.edu.in
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b632a6b9effso3760774a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ssn.edu.in; s=ssn; t=1761057599; x=1761662399; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2uh0DCayAA4Oho0rHf47AemBHPEtNN9rGbNknJrZ68=;
        b=mr4zgvvpfK2sRpHlRaaSZIPE7rpxeCjKHodoQkpTMyVjBSbvLSH0f7XvZYA+/Ba/XN
         T9J4KKWWEY8esF+yTjXW8efA0adtn/bNf0FcV8mqGv2XYdaJobE9/u+7FmgCmxUbh2mK
         mLF38J3+dTBL7GsHR7f6TCeNRQuiuRW2uIuKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761057599; x=1761662399;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2uh0DCayAA4Oho0rHf47AemBHPEtNN9rGbNknJrZ68=;
        b=pztdK3JWxuGk0quO7AJ6/jR4n7JobiX5+VYGFOscKYtm/L6tuWFC6ZBku65EPIOwtL
         n2ib5KDKd2T11ZCYskFETUOChapVymrdLjc/hJqxVq2uUguysz0DnNOaYDTnfLfOU5bO
         UctVL+0D1mdn0CAfRZ4XeeLPA1bfXIsUnN6IL/Q+7BSF5urz7DQIjhlzxHegrgCd93H5
         3Lg7dMqpXnSSuoSha2h5uKYYNKtqTygF23YRRkCRTEFU2trr3IMtr+uMzJQi3HrbGPhO
         bzC1RtnYP9rQaLpl7ekzO4Z8i8Gv5Da5Al697DBpBrmt+okC1iSTcJfzj7Ag3U4vkbFZ
         lO3A==
X-Gm-Message-State: AOJu0Yyeip/pf5er+kkCHTV5r+vsQfse+xBMPstVokHlhw9bRcrIyxnb
	cq+MiNY1bD6g+VAxZV1FGIMD7se2P2PsGagNT/TS8KQZyMoIULSt9/vmyLuCd6NLQPcV4J1Kvke
	z9XBpaYp+RQg8f/UXYmuy7NldiICjckuvgvBRUF6zSQjyYlvGbmCmZ3IeDjyAIR4nTRJ72NI+Q3
	E=
X-Gm-Gg: ASbGncvOIItugQTl51NCeu448P3FZNaULcYNQYShJRjJgLB8h/JJzX7yjrZWw+sgcVG
	uyqmgJNxy5K/kQ+JB1zGKiUny4XVoNULxCU/52FHhASQ0sOzuDDnEjKwiuY5VEbqHlBQiBt7b+7
	EnxyXGez9KwNFUvN87vXpJIM8Ql18jpW1q1/1M9EF5gciSkf6Chc2C2Ohp4W5gD+P2WGK8AYssB
	xEJkVh+GhBcnOBlCAOyXKBjdqoKooTzql3CUavSy7lN7Ue5gohA4SMa5WQ2JGydjlgZ5vWy2A8D
	6gKa7UUlwzLQm3HkVG7o5CnQ1Ywyjo4aELRi0y8q+enGpzNy7V8LL+ZtnxBjRz4vLtsUcarNWtj
	ga61WR6sycQqfo1/+lRjoABgJZGY5pW5lqB8D9NfkbQIGbmCK2paGqhmj5WYbGJN+lx4I5TAfWF
	ph/Z0oiahrpZ9Pen677xpZL4GyhOzapDxecO0E88jS2vwOvKZPnfivwv/pNEadVSjILKDtNG8Ft
	F4qyiIfw63zzg2Vv8A9zY6GNA==
X-Google-Smtp-Source: AGHT+IFjv4JXaOF/iC0stpVkmCP2QD+0EFGAF94HVriZpIhIfJrpDK1+j5TziU5b2ai58ueVKJNnOg==
X-Received: by 2002:a17:902:c951:b0:25c:b1d6:c41a with SMTP id d9443c01a7336-290c9cf3517mr226672875ad.11.1761057598831;
        Tue, 21 Oct 2025 07:39:58 -0700 (PDT)
Received: from biancaa-HP-Pavilion-Laptop-15-eg2xxx.. ([2406:7400:1c3:33f3:d5f3:33d1:a1e0:46bc])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247223a3csm111127385ad.112.2025.10.21.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 07:39:58 -0700 (PDT)
From: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
To: linux-kernel@vger.kernel.org
Cc: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
Subject: [PATCH] replace strcpy with strscpy for safe copy
Date: Tue, 21 Oct 2025 20:09:52 +0530
Message-ID: <20251021143952.37036-1-biancaa2210329@ssn.edu.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"

Signed-off-by: Biancaa Ramesh <biancaa2210329@ssn.edu.in>
---
 fs/ufs/dir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index 0388a1bae326..cffb7863adc5 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -557,14 +557,14 @@ int ufs_make_empty(struct inode * inode, struct inode *dir)
 	ufs_set_de_type(sb, de, inode->i_mode);
 	ufs_set_de_namlen(sb, de, 1);
 	de->d_reclen = cpu_to_fs16(sb, UFS_DIR_REC_LEN(1));
-	strcpy (de->d_name, ".");
+	strscpy(de->d_name, ".", sizeof(de->d_name));
 	de = (struct ufs_dir_entry *)
 		((char *)de + fs16_to_cpu(sb, de->d_reclen));
 	de->d_ino = cpu_to_fs32(sb, dir->i_ino);
 	ufs_set_de_type(sb, de, dir->i_mode);
 	de->d_reclen = cpu_to_fs16(sb, chunk_size - UFS_DIR_REC_LEN(1));
 	ufs_set_de_namlen(sb, de, 2);
-	strcpy (de->d_name, "..");
+	strscpy(de->d_name, "..", sizeof(de->d_name));
 	kunmap_local(kaddr);
 
 	ufs_commit_chunk(folio, 0, chunk_size);
-- 
2.43.0


-- 
::DISCLAIMER::

---------------------------------------------------------------------
The 
contents of this e-mail and any attachment(s) are confidential and
intended 
for the named recipient(s) only. Views or opinions, if any,
presented in 
this email are solely those of the author and may not
necessarily reflect 
the views or opinions of SSN Institutions (SSN) or its
affiliates. Any form 
of reproduction, dissemination, copying, disclosure,
modification, 
distribution and / or publication of this message without the
prior written 
consent of authorized representative of SSN is strictly
prohibited. If you 
have received this email in error please delete it and
notify the sender 
immediately.
---------------------------------------------------------------------
Header of this mail should have a valid DKIM signature for the domain 
ssn.edu.in <http://www.ssn.edu.in/>

