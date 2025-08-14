Return-Path: <linux-kernel+bounces-768000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 754F6B25BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65C67AF5DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEABC2417E6;
	Thu, 14 Aug 2025 06:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSALF2kF"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D8B23B611;
	Thu, 14 Aug 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152380; cv=none; b=TrDVa822UJH/tONBJ4bkZhYHsTxQNIh1avvR9lvfvHzDuuVEUafw/tpSoYA5kgGc21mqPNP94XYFHWZ9Mb8WGlV2FJn1/mfYJUjz2lX6JG/UVmHwX9FrMwRc2qv4AhxiVzJEbwV96u+R2fQyqPnx5V711LaFYLwbZrsOg9xZyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152380; c=relaxed/simple;
	bh=HcspPniQ+/a9UgjFb44d/Qy83pFsOwoD+mG4yuju6Fo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0dJ+mJbTTMh25DqaTdpAoF/nUmW/bAC0/BLX/c9vY4hS0WarDmDIoCzrQRIdkFEREwBZRo9D4PjYtHZCR3fwJAGceYU/X5cDm7C6NQ9yTG4kng2Qf6kPpJ35KumP93wnJ+SkwKwO6tScvGe4AZbEoCUy9IJe4WFK5gPWIsGBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSALF2kF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea887f6so495158b3a.2;
        Wed, 13 Aug 2025 23:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755152377; x=1755757177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+vKmcBx4tFOUtnevR3o1xCot+6PtJYfeGLB/iWk5Rc=;
        b=XSALF2kFRUKvPdj9DrtHxxFYS4a1HVNReH5UDjrGVUl/83YjR730w8ct37sPQy+WMr
         C9whrHXm36EmrX7vtP6k5wRtpTE19uulKjswDm59lJKM4Tl7h71ZwewHzQraj+m4gd7R
         KX35wIYZfqlakac4QPT3otD21Uaqtwga9FmLQjcuk2Fh6Z797rqDEiW29owHclr2AmgZ
         WshdCCJWAVs5FKXRDNsLzyA8J1hxNjZzBtUhdiuJo8nwwmSGti/ML/3mfBOmEoYcqWFZ
         MTbRYKqbRUNEedvG1xuMf0/RyEgPZRXmU/Fevgglg54Z53ogTW9Rybqf/UXwjyiHdGMg
         h5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755152377; x=1755757177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+vKmcBx4tFOUtnevR3o1xCot+6PtJYfeGLB/iWk5Rc=;
        b=fLKD9VVOquI0UWmUFVsfCN5K8dMpBzL+2DYCRUsptD51SEikNWHzvURkSj8PW24Iz4
         +1SlV2xbJsvgjDPhO7qJwCGBqA6Q9cqn6GwBIBQLNWVd1dJJbD2jvkS2gFGNwpaaG8aR
         6setauNy2MsEz5o6yJid55ziH4Vye/aM10mBJARMGWqOUGGRz2I4bHPlk9phHdA+nGtF
         7FCeoS59c4cn6JwVs6Udj8H7y8hFyLLwC8ydUOmYC5GqdehlCNuEujI+8GmoK7zxPbnT
         1QoPpgITbFbKOjsKO3fO1Y1LYAizJqHQybjlKyJb52KHUWa5oRlC/BAwNc/YmegcjVDB
         RtCA==
X-Forwarded-Encrypted: i=1; AJvYcCUffoH6EJjjqJTD3S5eXqqBY8vtfItBAO9CPHaIh8u8tQjDPD/R9WwKtvzrdBfXGP/7QuCBDeH+jqwjMmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLR5E8BoS8bMar+vEZ0iWT3s3kLJj8mGlW62Hzs4Y3pwcggQ7u
	Q8JXdYFaQQAled07qQjkBh4qyWqnRFvuOYt2p6VZZfCeARDIZbofs4VT7dQj3Q==
X-Gm-Gg: ASbGncsiKTuBnoIOoWdQDnBwL7p0O2zUQmWQ1B1nYi5WylPJ6spk4YPa/raaKZ1/cm4
	AQ5g59bKjS1QAvdjsZer9jXKJJXdlrUbZzSH8swhzCoNehv2NTTkZryqAIw6jEo/Kpl/3vJYnGE
	pnIEq6buqq8OUNi2wmljvSFeby8dRl/fJnts9dCHaU2o7DP8w5BWYkSjWSiyoamPBBKeWzJXgpp
	xDkr+/eHoAluyOYWzhfrwxoNMm0c8yt0akFPbKaGrKVNPBBZFBUq/QvqTsET6yToeDjTlDqZkd2
	eblJwG9IKlc1+/F+KeTY2rjIjuDkVC3K7pYi2JuUEfVt55hEEBY2me4wzI3pCKZ0Q7YvkjFDzVw
	4PcgBbFkZ60mSkGD8+FkQ7iKqkSmj7ltwyt8RfGNhbDBgJUAj27GFl5Uf/89Kfg==
X-Google-Smtp-Source: AGHT+IENr9Qn+GUepbngqAMVYzfwmsgTlwwhKf6Z5G5NtxRUHPwwPyMROo1T3CRHR+hZnOQveZ2vQQ==
X-Received: by 2002:a17:903:191:b0:226:38ff:1d6a with SMTP id d9443c01a7336-244584c2650mr30919735ad.7.1755152377190;
        Wed, 13 Aug 2025 23:19:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:3e4:5d66:b054:56a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899a909sm339674185ad.123.2025.08.13.23.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:19:36 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org
Cc: Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH v3] kernel-parameters: fix kernel-doc warning
Date: Wed, 13 Aug 2025 23:19:25 -0700
Message-Id: <20250814061925.4281-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <B15E4343-E543-4C59-85E4-CF06FE78A627@infradead.org>
References: <B15E4343-E543-4C59-85E4-CF06FE78A627@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

Fix kernel-doc warning in kernel-parameters.txt

WARNING: Possible repeated word: 'is'

```
[command]
./scripts/checkpatch.pl --strict -f Documentation/admin-guide/kernel-parameters.txt

[output]
WARNING: Possible repeated word: 'is'
+            The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."

total: 0 errors, 1 warnings, 0 checks, 8339 lines checked
```

Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf..302145870 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7506,7 +7506,7 @@
 			Set a trigger on top of a specific event, with an optional
 			filter.
 
-			The format is is "trace_trigger=<event>.<trigger>[ if <filter>],..."
+			The format is "trace_trigger=<event>.<trigger>[ if <filter>],..."
 			Where more than one trigger may be specified that are comma deliminated.
 
 			For example:
-- 
2.25.1


