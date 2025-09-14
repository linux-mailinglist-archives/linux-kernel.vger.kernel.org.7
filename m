Return-Path: <linux-kernel+bounces-815459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA232B565D3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 05:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 937214E1143
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2CA26FA57;
	Sun, 14 Sep 2025 03:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrO6Dva4"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFFE26E6F3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822377; cv=none; b=kd9ahHKJi8DSeJadjqoSvKwUsfgU1Hqr05KItRezk1d3JcUG4xnbZyZ/iHDXopbbrTJrIV3YqsHppiBoTJBVu821wsAlMsonNkC86fOMJtJmgHn+Z4aHTk+VZbboMAiZvVEmkmBrnjOkHq9X4Eu4sR3HtvR1anrg5fMoG8OtyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822377; c=relaxed/simple;
	bh=dWOevKs33KVPp7BfwW01lTdoAaIwqA9A0zVQ5+zAb7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZlsKzOMZ78Jzvj/PmR01Oo3P5hAqqNjpdarOInRsdozRSBdqHo65/Vbkie1JxrGlbTPkkGOE1Fbc7xw3xUREqjJiYkfhtWwXD2iiW6Azr2//RItbshOoOtRAqNSYFIEbJiIqbs5D54NUAgTfkJ6RXlkSj9uAdxDKKGcY8EOzDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrO6Dva4; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b04ba3de760so404206366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822371; x=1758427171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=;
        b=NrO6Dva4wPAGaeFNN7il7aL1kcNhTD/kXZSqeaO7MpBzFdgEGF7io2Id4R2p/xcAtB
         IhFiGiDJ5jpuYu9D3dzCpYk7QZCGg/f7IReCoaftYHsNb+xLwcyDciuRMZKBlFq9gtLU
         Uh4l+/GodSClEZ7UfI4Q4dmPgEm5hnugLd4JjffCREANrbViB53jCYu+mbWqXoHbhvTK
         TYS01n1cq9o68pWzYNIxqzhpSPYtBxIsQauT9jrI78nQaxJ32SV7thUSVU8hNI4Uwm1R
         KkXFrDzmxAspa+v0SnGnftYv9jfyub2c4ZF2TimEB5B4nEIEHn0lZfRxMJXO21de1ZxC
         CBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822371; x=1758427171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O9abWz0+AALTE1DyE86pUo1tihrL6Hn8wt7mMTmG960=;
        b=XdevSOmalyT9tCjH7xdNfyZnW8r17Nfn3iZf2pNdsrAa/b2XsDJv9tkjzBAhVG8aOG
         fgeqRcUJCRZT6FNW8N/UgFvsYZV0OxYzm4UCMhPQJ0mC4S3kSeKDEefWnd4Y/inHKX2A
         +osPnNnDVDM+lCkDGSh0xLcpBYdH6WIL7G3/NmNC6R69eZ8PszGOtor457B1iM4QwmsL
         5ZXRr4Dorvl6TDOAzEgz3NBtXo2/oh6W1DXj0XZcst+7PJAu/XcroftpPofR5p85vkG2
         M1AT6rzCtWSM5RMofOiGi30R8huSC4ucDo7JbcWXiyijBQTRmx7bzH8ZjqWUwQhuTECS
         mxHw==
X-Forwarded-Encrypted: i=1; AJvYcCXmOl9kW3ufutcFDK7xGI217uqnB1lUKCIr5hCxs5QgUwotDIDC1jrfTbFWKLBgJQURyJ2Q6EZC+cvJzeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0iEPAaJYALqPFsvnFlU1slv0SCL82H0MRE20swlJ5J3+EcQbP
	va0NXT0Rpy1ttmGxZX42byEftMPN0SWdMt9DlbGLb8J7MvFK4dqVjPrN
X-Gm-Gg: ASbGncvnZEJfzQguxOtBJMUZ84ganiiklB4hNHhThIthDBHjMjegy6LHKQNs0UOWzgF
	bPF5PsYQuDhnJiDvhd/PMr46snEaAFz3Jf8VY1MTW4h0uOF5HkZOOWg0hnXADH4qhiab+pLHJmU
	M4dGmIxs3/PqT67qU/wVJfcvqNWo/2y78QE14uKRbmanYgkbOyP0Sru41wrcI5ng6761606nV7U
	OlaW5yCipSJpILhwNC9jZD7CazKyS7V5KZvj3oQgqbjgNmo6W7hfeKGWQhvE+OmpfaXAtXL+ZDt
	ink3MZNlP/6kQrz5x2CGhY6LbYpco8dIo/6q0gTfUMl7kxQwm1yqtqmUp1E+8g/cGdOYIltVm/w
	BKSRkz4aXXZ54c85ytyA=
X-Google-Smtp-Source: AGHT+IHIaNmlQUOqaI2XvHaD2x2sJJCA+iwXMxeIqgPaozK4MzRrxS2gXxwIxVkINaRf0GrOSh3U1Q==
X-Received: by 2002:a17:907:3ea6:b0:b09:48c6:b7ad with SMTP id a640c23a62f3a-b0948c6c6a4mr387666066b.57.1757822371514;
        Sat, 13 Sep 2025 20:59:31 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07de03d93csm287001766b.12.2025.09.13.20.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:59:31 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 53/62] init: rename kexec_free_initrd to kexec_free_initramfs
Date: Sun, 14 Sep 2025 06:59:26 +0300
Message-ID: <20250914035926.3770703-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/initramfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 40c8e4b05886..d52314b17c25 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -690,7 +690,7 @@ void __weak __init free_initramfs_mem(unsigned long start, unsigned long end)
 }
 
 #ifdef CONFIG_CRASH_RESERVE
-static bool __init kexec_free_initrd(void)
+static bool __init kexec_free_initramfs(void)
 {
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
@@ -713,7 +713,7 @@ static bool __init kexec_free_initrd(void)
 	return true;
 }
 #else
-static inline bool kexec_free_initrd(void)
+static inline bool kexec_free_initramfs(void)
 {
 	return false;
 }
@@ -743,7 +743,7 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initrd()) {
+	if (!retain_initramfs && virt_external_initramfs_start && !kexec_free_initramfs()) {
 		free_initramfs_mem(virt_external_initramfs_start, virt_external_initramfs_end);
 	} else if (retain_initramfs && virt_external_initramfs_start) {
 		bin_attr_initrd.size = virt_external_initramfs_end - virt_external_initramfs_start;
-- 
2.47.2


