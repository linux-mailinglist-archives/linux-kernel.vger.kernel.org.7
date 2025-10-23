Return-Path: <linux-kernel+bounces-866960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A5FC01328
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F8724E7091
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3440313544;
	Thu, 23 Oct 2025 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq1272be"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3D6221542
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223451; cv=none; b=mmx0RCDrRUTHH3zgThs9eIch8AbpOZJd3ueEwNPGz6YTX1HLhKi/4nPDycV69AG2wnjhQoWFvLfP/TpiSV6NgMGDpncnvkrjKVzFDuV8EHDvqe7ALqlxzO6ONNN5duk8NoNEw8EDeJ3yUgsgFI0E/OLsMikCFqldCkHDpmpQgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223451; c=relaxed/simple;
	bh=ZTf1hI7wtv3nNmFdqQT5hjAWAUfkJPl0UgmwXQ0rG4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CBUS00GPpaC9eIuA7UbBY7VtANLXBbJw9K5miCvty4Wx7mSzNtRlHjMcwA4IeAy2FQz5iMYpRdfAfoQ9gbkyibN+BC02d+0o3G6DTzi93SOb5fCzZ6/7GnA/c9hBQ/SjThmmEu9mYIzUglqUk6uYH9m8me3Ic157S3uztvMcv8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq1272be; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-471b80b994bso10770795e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761223448; x=1761828248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vtd1oYL9rm2vT83WNhqj0UFM4HsQfAMXEV4/Hh8HV+M=;
        b=nq1272beuGIJMSTldi1/nmhVnGL9jNua+e+WYrwGF8rwk0y3vDAEG8hMXDqQyh1gxK
         Yjro1yc+gYEwdySQvYMrSj7ORqKbIu58bzdtB1FquxwaTaqh0reLL9O8sz6YwrSM/NXc
         gqsoiAweg1eBUR8R8VgU089QxGlosce0terdZ7jOsPw9pPCyV1j6ApDYnjeZcC/Y1tRe
         /JV93VJbLm7U90Ai1X/B7PNClc6WU1klrAih4r8Wo0iRdKOLeD3ZUKmsA2Cxe+wD6Ocx
         WBubhLivudMvp2GzCTBQLNxSlxFNGxe6/4PsGiPFdjFWUTolAi0OW6utpLhQNR6TTuUC
         NyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761223448; x=1761828248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vtd1oYL9rm2vT83WNhqj0UFM4HsQfAMXEV4/Hh8HV+M=;
        b=n+lvEpYvtRrrdLAbBRafswssYBhcyKsN+dhr133o3spgZ0l7CjGpO4wqvbbhmZrsU6
         kqnbs1cqi8tzG0BZ8vVDmVoET4Gh/1NAOkEnqmGQEAtEDm8Vk0BmZ65kDMDfjqP5xlEF
         nAcxaygGgUbuE01xAVMSeCxZcB3J15iw4csaqA9YdL2KCKJ2Y5merq9DUHLNwS/Fe3J4
         YoZFuXfOzC6uy6maAsQSPgV3g001GrdC942r008+zcpSdxFfJjCr9EFID6U/YN+akYda
         LWyzdxzEiV/DyOSVDXoa1Ui+EjZaGWKPjZJ/duW7v4zJ4SCdumP7+3d2DlULzraiUP/g
         fcsw==
X-Gm-Message-State: AOJu0Yx519zJ3GJUQg00fJvB6pAvSjb+yft3Xh+decHyYrg4vACcJjXd
	F8fynTYCK8cmLgeKrUnN7C8gN+E4qc9WdPkprdP7VoAiAuJpFo9KN85cXC2hcQ==
X-Gm-Gg: ASbGnctoSXvcrGUfddeHeeovl4G2JiMEU0XBakdEymOEOKI16Si7Qs0VJRHpyb3Kk9A
	D7Z+slGCa6pOJJAwmiCjUroYhYwrln1GgJzTvVdHoWHhxI3h9ug70B2mXFgkt1ab85X6MyU7hXc
	sxDgW4pOhOdZifWYmU2TBb5T5Fxgl+nnbHmhjebjmAUXlfu5eT+mxMPhCXeK9YC1kyLD42Xj54p
	ERIY74SYz5nRZvvSg58EDNcjeTT5BU3Qjrj4Us7tKHBxYomaeAUfjLXR/RpaCuCdd52h78bBQEj
	ryZK0i3p+4y4rPhAcza99XNHHWtuTTWQlHI6C5Z+z3wqJWh0BhFXrp0FtyL94vmInP8A/0XG1cV
	ENZw4KdmjN0g8tDmXjlP6ru+UOJVXfPJO5OoYDD+aZ8zoiZIzft1I3nBCTbo85hcV83XoPcabaL
	W0LuXbk4e1uUy3zaXsd0xVhvp9okGwIqUyFaaN+I/SJjefMB6F3nbPmARpU/Mi
X-Google-Smtp-Source: AGHT+IFbRCVpEDCmrqa4RgpxFn6c25vddUS9helicVCJ6R5uNXspjiceVY6cxVDVuKXKFgm/PZb+QA==
X-Received: by 2002:a05:600c:444d:b0:46d:45e:3514 with SMTP id 5b1f17b1804b1-471178b13c6mr167735175e9.17.1761223447936;
        Thu, 23 Oct 2025 05:44:07 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475caf2f142sm37273295e9.15.2025.10.23.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 05:44:07 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: David Laight <david.laight.linux@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/1] uaccess: Rename masked_user_access to sanitised_user_access
Date: Thu, 23 Oct 2025 13:44:00 +0100
Message-Id: <20251023124400.3279-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

masked_user_access is a bad name and should probably be reserved for
code that is removing high address bits that the hardware ignores (LAM).

The typical implementation is uaddr = min(uaddr, guard_page) which
isn't a 'masking' operation.

Move some of the comments from arch/x86/include/asm/uaccess_64.h to
include/linux/uaccess.h

Update the few places where it is used.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---

For minimal churn this rename (or a better name that comes from
the following bikeshed discussion) probably needs applying after
the scoped_user_XXX_access() patch and before the ppc implementation.

 arch/x86/include/asm/futex.h      |  8 ++++----
 arch/x86/include/asm/uaccess_64.h | 17 +++++++++--------
 fs/select.c                       |  4 ++--
 include/linux/uaccess.h           | 22 +++++++++++++++-------
 kernel/futex/futex.h              |  8 ++++----
 lib/strncpy_from_user.c           |  4 ++--
 lib/strnlen_user.c                |  4 ++--
 net/core/scm.c                    |  4 ++--
 net/socket.c                      |  4 ++--
 9 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
index 6e2458088800..91228a39474d 100644
--- a/arch/x86/include/asm/futex.h
+++ b/arch/x86/include/asm/futex.h
@@ -48,8 +48,8 @@ do {								\
 static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *oval,
 		u32 __user *uaddr)
 {
-	if (can_do_masked_user_access())
-		uaddr = masked_user_access_begin(uaddr);
+	if (can_do_sanitised_user_access())
+		uaddr = sanitised_user_access_begin(uaddr);
 	else if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 
@@ -86,8 +86,8 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 {
 	int ret = 0;
 
-	if (can_do_masked_user_access())
-		uaddr = masked_user_access_begin(uaddr);
+	if (can_do_sanitised_user_access())
+		uaddr = sanitised_user_access_begin(uaddr);
 	else if (!user_access_begin(uaddr, sizeof(u32)))
 		return -EFAULT;
 	asm volatile("\n"
diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
index c8a5ae35c871..612a291fffa7 100644
--- a/arch/x86/include/asm/uaccess_64.h
+++ b/arch/x86/include/asm/uaccess_64.h
@@ -57,11 +57,12 @@ static inline unsigned long __untagged_addr_remote(struct mm_struct *mm,
 	likely((__force unsigned long)(x) <= runtime_const_ptr(USER_PTR_MAX))
 
 /*
- * Masking the user address is an alternative to a conditional
- * user_access_begin that can avoid the fencing. This only works
- * for dense accesses starting at the address.
+ * 'Sanitise' kernel addresses to the base of the unmapped page
+ * between user and kernel addresses using ALU instructions.
+ * This saves a conditional branch and avoids the need for a fence instruction
+ * to avoid the side effects of speculative reads from kernel memory.
  */
-static inline void __user *mask_user_address(const void __user *ptr)
+static inline void __user *sanitise_user_address(const void __user *ptr)
 {
 	void __user *ret;
 	asm("cmp %1,%0\n\t"
@@ -71,10 +72,10 @@ static inline void __user *mask_user_address(const void __user *ptr)
 		 "0" (ptr));
 	return ret;
 }
-#define masked_user_access_begin(x) ({				\
-	__auto_type __masked_ptr = (x);				\
-	__masked_ptr = mask_user_address(__masked_ptr);		\
-	__uaccess_begin(); __masked_ptr; })
+#define sanitised_user_access_begin(x) ({				\
+	__auto_type __sanitised_ptr = (x);				\
+	__sanitised_ptr = sanitise_user_address(__sanitised_ptr);	\
+	__uaccess_begin(); __sanitised_ptr; })
 
 /*
  * User pointers can have tag bits on x86-64.  This scheme tolerates
diff --git a/fs/select.c b/fs/select.c
index 082cf60c7e23..687ee8f6437d 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -776,8 +776,8 @@ static inline int get_sigset_argpack(struct sigset_argpack *to,
 {
 	// the path is hot enough for overhead of copy_from_user() to matter
 	if (from) {
-		if (can_do_masked_user_access())
-			from = masked_user_access_begin(from);
+		if (can_do_sanitised_user_access())
+			from = sanitised_user_access_begin(from);
 		else if (!user_read_access_begin(from, sizeof(*from)))
 			return -EFAULT;
 		unsafe_get_user(to->p, &from->p, Efault);
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1beb5b395d81..f49103c04046 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -33,12 +33,20 @@
 })
 #endif
 
-#ifdef masked_user_access_begin
- #define can_do_masked_user_access() 1
+/*
+ * Sanitising the user address is an alternative to a conditional
+ * user_access_begin that can avoid synchronising instructions.
+ * Kernel addresses are 'sanitised' to the base of an unmapped page
+ * between user and kernel addresses, accesses will then fault.
+ * This works provided the accesses are 'reasonably sequential'.
+ */
+
+#ifdef sanitised_user_access_begin
+ #define can_do_sanitised_user_access() 1
 #else
- #define can_do_masked_user_access() 0
- #define masked_user_access_begin(src) NULL
- #define mask_user_address(src) (src)
+ #define can_do_sanitised_user_access() 0
+ #define sanitised_user_access_begin(src) NULL
+ #define sanitise_user_address(src) (src)
 #endif
 
 /*
@@ -162,8 +170,8 @@ _inline_copy_from_user(void *to, const void __user *from, unsigned long n)
 	might_fault();
 	if (should_fail_usercopy())
 		goto fail;
-	if (can_do_masked_user_access())
-		from = mask_user_address(from);
+	if (can_do_sanitised_user_access())
+		from = sanitise_user_address(from);
 	else {
 		if (!access_ok(from, n))
 			goto fail;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 2cd57096c38e..ecd568112a19 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -302,8 +302,8 @@ static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 {
 	u32 val;
 
-	if (can_do_masked_user_access())
-		from = masked_user_access_begin(from);
+	if (can_do_sanitised_user_access())
+		from = sanitised_user_access_begin(from);
 	else if (!user_read_access_begin(from, sizeof(*from)))
 		return -EFAULT;
 	unsafe_get_user(val, from, Efault);
@@ -317,8 +317,8 @@ static __always_inline int futex_get_value(u32 *dest, u32 __user *from)
 
 static __always_inline int futex_put_value(u32 val, u32 __user *to)
 {
-	if (can_do_masked_user_access())
-		to = masked_user_access_begin(to);
+	if (can_do_sanitised_user_access())
+		to = sanitised_user_access_begin(to);
 	else if (!user_write_access_begin(to, sizeof(*to)))
 		return -EFAULT;
 	unsafe_put_user(val, to, Efault);
diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 6dc234913dd5..cc4220446647 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -123,10 +123,10 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 	kasan_check_write(dst, count);
 	check_object_size(dst, count, false);
 
-	if (can_do_masked_user_access()) {
+	if (can_do_sanitised_user_access()) {
 		long retval;
 
-		src = masked_user_access_begin(src);
+		src = sanitised_user_access_begin(src);
 		retval = do_strncpy_from_user(dst, src, count, count);
 		user_read_access_end();
 		return retval;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 6e489f9e90f1..79ad77204574 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -96,10 +96,10 @@ long strnlen_user(const char __user *str, long count)
 	if (unlikely(count <= 0))
 		return 0;
 
-	if (can_do_masked_user_access()) {
+	if (can_do_sanitised_user_access()) {
 		long retval;
 
-		str = masked_user_access_begin(str);
+		str = sanitised_user_access_begin(str);
 		retval = do_strnlen_user(str, count, count);
 		user_read_access_end();
 		return retval;
diff --git a/net/core/scm.c b/net/core/scm.c
index 66eaee783e8b..98df16c8ab13 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -273,8 +273,8 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 
 		check_object_size(data, cmlen - sizeof(*cm), true);
 
-		if (can_do_masked_user_access())
-			cm = masked_user_access_begin(cm);
+		if (can_do_sanitised_user_access())
+			cm = sanitised_user_access_begin(cm);
 		else if (!user_write_access_begin(cm, cmlen))
 			goto efault;
 
diff --git a/net/socket.c b/net/socket.c
index e8892b218708..eac71edd209e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -280,8 +280,8 @@ static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
 
 	BUG_ON(klen > sizeof(struct sockaddr_storage));
 
-	if (can_do_masked_user_access())
-		ulen = masked_user_access_begin(ulen);
+	if (can_do_sanitised_user_access())
+		ulen = sanitised_user_access_begin(ulen);
 	else if (!user_access_begin(ulen, 4))
 		return -EFAULT;
 
-- 
2.39.5


