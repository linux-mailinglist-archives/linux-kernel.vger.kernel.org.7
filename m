Return-Path: <linux-kernel+bounces-870268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE7FC0A53F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 10:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014FC4E58BF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD5288C96;
	Sun, 26 Oct 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN2KKfDs"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD2238178
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470001; cv=none; b=k3ZiM+JvNxiRQKejpDviPIAOMp6lmdTO3hV0AYgjdmjS1a34u0Gdo+d6IDFqmBZzKZo4fwIp3jLaVaUYH1t0pBvCS6zL+f2l7Z+AqSGjhT8YdGKWGLbzG+LJoV4neYYL+05dVopxGP4ec1B08OqLsVwSQiTqt/kAT655HbUNd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470001; c=relaxed/simple;
	bh=5b5PYMxopEb8YY4FdGelcJUO0Yvn+/7BT0Giy57xNWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejKllYx4QMQz2FCGHuPB495+0XiU2YutWAYsSEK0TvM21jyGoocaPNTY+f0i3wv6Bn3y9LFQ0Gyd5+EJWKV71j5qFV3EKAiZQ71My12AQ7O41fwWE1YyZwl0qISfaEgkcQyo2qhY9kD1TCfAnJYWNJsMkIJgfdv1IskQ+b7DOPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN2KKfDs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so3403170a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761469999; x=1762074799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMX23+YLvbC4KKYE3owkIF/POC5qa9l7q+YDn+rGhBs=;
        b=SN2KKfDsQkeTqdseEQyG/hCI7cTwgkEZdcfVDhayZ7m0K26eYWv62CVqOEhqj8S6GH
         y3symXdmxE0YzyqQW1Ti1PAHRB+GHkK0kZa3HbLi3CVtHlPkMHfPg6Kqz43mvLXaIzHF
         MMkTRx2ehLRvXhuO4Tc784kYtE1pX/xhrGrWmoMEXTeDEX7Rledc/GbVFqAqOjoo4aui
         bqdcjmMetRx+BbiPX+gAd2dsd4/EVNlV/YsAf4OvdBXKEmL7zugyp6Q75Q/QVU12cqfJ
         gEAta1gPws2MZSIEgn4E9Kr3r0GrpQdk5sDzDxZiHaxSMli9pVeUlzAnpqDV+K/nV47D
         eo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761469999; x=1762074799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMX23+YLvbC4KKYE3owkIF/POC5qa9l7q+YDn+rGhBs=;
        b=Geb/fRlx70WPGiFGZRBF0pTfVIglb0C42WQ0e+7X4KG8qxhDRXOFzdr8an9Xes2dkn
         iuZOe87nJHbplf8IVEvTPZt4yl2RT/+p6ZlD5a55Ia51VOE96HA5KzaZqydIE3BUUu6W
         W+y0hRFnp/iLKLxLo+qT7xh+oZbZ67t7SlndQvJktT3NNH4O2zKkMqpUZulVVMTUb7pH
         yA0DV9j/kdEMzgz6uQJ5pp49ACpeNXnjZ+iYbBrcYw4dCk2QUlwbpg+UdVLhnRfMsuKC
         PA8Zd5P5lrWvLAjqjO8MntZxIlv9wHEjxR6bwrLZV3b5Yca3strnYmJnpVL3CI4zI3mU
         McIw==
X-Forwarded-Encrypted: i=1; AJvYcCWOCAUUp40MCDxkQnDUPykabhWjBNYTQex4jCxEFcKW7PcqH/ed5OXrJvBXAESfxN3FYLsJfU0O+GSqz9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWOrNa8gEMq1oNKQOZ3/NBaIuP71kOTi9/itor8HvTDdKdeoKv
	a78/5u1+pqd/zjEItjeWrYVeX1lWcgWnJ2QZg1BfQ85TXA5B1MBpKxsV
X-Gm-Gg: ASbGnct6Wk6SdPFPokAAycZsgE4th/v3mkVAv6lBa1bCVLByI5bEbk3oLxqvHLVjbLN
	4OwsLEWNEIUmOey5yAuc/5cRGt2zHXbhibtyU1ckxS0tgGkwAwDKT31y1fckcoIxvHspHtPQA4x
	iG436taXQ5+C1AQq94Vef6g0Ytj4Srwa1TJC/wT9z7P92WPQnRF8xsnJzej4IIE/2zhC7RnbgOx
	OmApMdjwA3eQm3iTMQlc0fqyTCSVAm7uSaAwx0VLdo9PBFlOF9tMwrUwlTvKLhDYZpsL8UtRxtT
	AD9i3So2/zTfum2x3PbzcmKJvY8XwSyJhnX6GnxHPGyQZ8+zhB2VvACUiqWaTDXC1Pf3ev+PLq/
	8od5mRsIPOP85L84lfZ+yYOL521smi0X1oa1zrNHoLGxvFsjTF2d2kP5emNEhzAA17uLVSfbu/e
	UfKVrzNLAXf7nnxoX8mQb1Qi+Qzr9E90KeahH/mwnP0+VBWBLWM7BVpaw=
X-Google-Smtp-Source: AGHT+IFQFXNUYIY4vSpSr/xv31CBewG848HOy0cOfx8lxhYhMoQ5KdF68P3/KWEwPTs9NKzCL3WWXg==
X-Received: by 2002:a17:90b:5386:b0:33b:b308:7655 with SMTP id 98e67ed59e1d1-33bcf861fc3mr44925100a91.8.1761469999250;
        Sun, 26 Oct 2025 02:13:19 -0700 (PDT)
Received: from prakrititz-UB.. ([2a09:bac1:36e0:1c0::10c:2f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a42aa5d9a6sm789558b3a.62.2025.10.26.02.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 02:13:18 -0700 (PDT)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Jiri Olsa <olsajiri@gmail.com>,
	sam@gentoo.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH v2] selftests/seccomp: fix pointer type mismatch in UPROBE test
Date: Sun, 26 Oct 2025 14:42:33 +0530
Message-ID: <20251026091232.166638-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <aP0-k3vlEEWNUtF8@krava>
References: <aP0-k3vlEEWNUtF8@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation error in UPROBE_setup caused by pointer type mismatch
in the ternary expression when compiled with -fcf-protection. The
probed_uprobe function pointer has the __attribute__((nocf_check))
attribute, which causes the conditional operator to fail when combined
with the regular probed_uretprobe function pointer:

  seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
  expression [-Wincompatible-pointer-types]

Cast both function pointers to 'const void *' to match the expected
parameter type of get_uprobe_offset(), resolving the type mismatch
while preserving the function selection logic.

This error appears with compilers that enable Control Flow Integrity
(CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
on Fedora).

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..e13ffe18ef95 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
 		ASSERT_GE(bit, 0);
 	}
 
-	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
+	offset = get_uprobe_offset(variant->uretprobe ?
+		(const void *)probed_uretprobe : (const void *)probed_uprobe);
 	ASSERT_GE(offset, 0);
 
 	if (variant->uretprobe)
-- 
2.48.1


