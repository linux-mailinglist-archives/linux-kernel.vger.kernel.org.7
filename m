Return-Path: <linux-kernel+bounces-822936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D0B851AF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127C9547FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0287730CB30;
	Thu, 18 Sep 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c5dG77vF"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DD315769
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204387; cv=none; b=rbcg+0fOD1wSbVUdDCR82xvJKjiW9pbEvuqdfUwQH6DgkEMpg8otcF0hZQLwUq9b73keCodk9wvg0BYGjNMDwGXnK4M2KxEmFT+qudVJPwCQTsPdz/0i8OtWxt7gXQbfUVKzJyFaymdzMonjv2ecVkyQjzE/G6oTER6hWeEZDMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204387; c=relaxed/simple;
	bh=DOVYYkUooifd4WMC9FlK4YiWuUY4p8vtxZ7kRIKV6k8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BUgCtADXSK5bBwFB0fsYsr9EQo965w+RSeIpMyxDCfDh9oZYCVY2HWhc9CIEZN7NMseKkEBSzRMeoqljB4If+K2cDJF9Vv2+CfAY0X/JLoIIkff+lh9YrNw/9VrjOldOZ/KvS6xcpegKcRxKn4EQAK05e2YK7iiiatxRut8Hw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c5dG77vF; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3ea2082db1cso229680f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758204384; x=1758809184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oanwb4AvefPzztLhk08gBpEPn5bxbhzZnwvICntunHw=;
        b=c5dG77vFNyxfvKw3cM6bjsTs6GWnqksB7+kwITSQeVcH0dat7rSp1xTDrWvvwdP76B
         FWjr1gxEyZDzXgBUx/SJB77WQ3ZRcPj3jOlsXDMMfTuQFIrMr86BQOrP4PPSxc1VZiqK
         3zkZjjZszHaIZf3bxF8+/Kz/Fynu92Ko38uWIWuNMFS5J3og2Yb2rt1OYhmlP1N1RbnA
         XI7xhhPQfZSXPTFg/e3jXdzWXGj0nzfJBpir9TMcxl2hMD71dzszVVQSUUYk6vJ6Qetp
         /A87ltwEISO1INQYwMv9FM9ZsCLd2WOCb+1QeNov9soOS9H9tY51w/dFsx2rsK4OGudy
         yWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204384; x=1758809184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oanwb4AvefPzztLhk08gBpEPn5bxbhzZnwvICntunHw=;
        b=DW9+Xh96SZFqWZkhomkDU4J3xtyqaG6tRuOufdFf/00+gYLDKeUJ4geeUOq2D42ueD
         RA9I/9Hok/VYf260rAjnWUP3ckkBIWJ3WzfNdyYNIzcaLYU8o2/vvkoPM6fw9w7qZo6/
         BII5cVyeJ2dG0XZoLmFRnYiAFOOL4BAQ5yANHOEvd8zaoMywjjEc28oyxGgUBVIZew2+
         sZvflSxGIxPWSCYqPhIXhktHJrE6O8TMVPsTLVItQpaswVfAbay8kYSpedU2S2dM1Wd6
         wEEWDiMpCLeaorCBdL8bUJPmbzV7Q08apL9gl3+zwbm7eWmKmK+iyBJS6oYlwF4sRHdg
         EHqw==
X-Forwarded-Encrypted: i=1; AJvYcCVuzxXrv69CpF4xLvszimp1ZIkiU43KBLVg2FLKYpQYxDZcyqGOG9NdiIGJ24bw2FCIPcyjjSw6MXfjt3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcL2WUjSsdsVVZ3FdmlYJHBCl0oYJ9grk1H3tl9se0jEctdZzX
	3a848XF1w9phEwvv+JejyOa96IQy5OtOJ5soozAQfIYWiKLC7yjFq1LALXOiJQ5YlXQCY5uV9I+
	OWw==
X-Google-Smtp-Source: AGHT+IFkViOrkTd7Qf740HpWB1Y+zHZAT/ov2XdutlPI/XGCPUkCb5+91SEAW6LMPzEdlyQcI8JNeQaNOQ==
X-Received: from wrbcc13.prod.google.com ([2002:a5d:5c0d:0:b0:3ec:df7a:666])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:438a:b0:3ec:db18:aa37
 with SMTP id ffacd0b85a97d-3ecdfa4b7camr5826204f8f.60.1758204383884; Thu, 18
 Sep 2025 07:06:23 -0700 (PDT)
Date: Thu, 18 Sep 2025 15:59:32 +0200
In-Reply-To: <20250918140451.1289454-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250918140451.1289454-1-elver@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918140451.1289454-22-elver@google.com>
Subject: [PATCH v3 21/35] debugfs: Make debugfs_cancellation a capability struct
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When compiling include/linux/debugfs.h with CAPABILITY_ANALYSIS enabled,
we can see this error:

./include/linux/debugfs.h:239:17: error: use of undeclared identifier 'cancellation'
  239 | void __acquires(cancellation)

Move the __acquires(..) attribute after the declaration, so that the
compiler can see the cancellation function argument, as well as making
struct debugfs_cancellation a real capability to benefit from Clang's
capability analysis.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/debugfs.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 7cecda29447e..4ee838cf4678 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -239,18 +239,16 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
  * @cancel: callback to call
  * @cancel_data: extra data for the callback to call
  */
-struct debugfs_cancellation {
+struct_with_capability(debugfs_cancellation) {
 	struct list_head list;
 	void (*cancel)(struct dentry *, void *);
 	void *cancel_data;
 };
 
-void __acquires(cancellation)
-debugfs_enter_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
-void __releases(cancellation)
-debugfs_leave_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
+void debugfs_enter_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __acquires(cancellation);
+void debugfs_leave_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __releases(cancellation);
 
 #else
 
-- 
2.51.0.384.g4c02a37b29-goog


