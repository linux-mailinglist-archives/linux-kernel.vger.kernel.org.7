Return-Path: <linux-kernel+bounces-815448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC2B56507
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 05:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36021A20D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3186326E717;
	Sun, 14 Sep 2025 03:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnfVFf76"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5668C1D7E5B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822016; cv=none; b=UbN71hN3aMc/VuUzzIPIQw2DS3Nr62FyQCyDa3OV5lPt1l9WQIOxpfCZcFWto99siuZGI4GfI72tBIkan2O03v5wI66n9h0Fd9y2MkrxUZZR04VO4gMGSIkEafmhqdWYwDNJB1unne27nUFpxO6wTIZzgO26RX3KdsSN4TAIWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822016; c=relaxed/simple;
	bh=FZoweijhihxtu6HrPrxAC18gjv4DF8N0f7D122SferU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Thnbn/GuYzIgRWCtH/Sh2HD9UJqUfiL7pqsp5X+RbES14YYtuV3uljSu318rTAS5JzFZLd2OHQh6v1WAmF18PM9ZRqYeqmIvvNlNMGCLEmfbo9GPAUj8pL8itb+QAkhq57SPfhsaYPDUW088+e6e7fB2YTewZ7TneLg4hPnkAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnfVFf76; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso2847379a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822013; x=1758426813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=lnfVFf762khiYz0FDgghMlXPGvOITxGCtk+wu9qrbN5hxLRAJ1gs2+ppk7BKe0HXlG
         G5OREfPjiRmY8EwPfB8G4xt1X/oakdJZUIVKAQidEaQcGSNKY/+M0I9BNsBTVp63txq9
         mWNSh2WPW1lcIW6EbcZonrtOLr+rPOcWu02CjDYUuTOSmFZo9hjdGaUQTIax5JlCS+NZ
         TNYxrphaJHRheaHZZPcAmZYwIMBqEB73xXkFvBqUDa4R/U5otIgxVvxeHp4zNeeaJNCP
         7lKrRo7Ge+7IBKugxANcXh/v7/I3r3NwkZPsvZtjWj9jftx6y6vKzysCIfWd+kJWivtX
         fbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822013; x=1758426813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=j7W7AIcIA+7E9e7lUXdrTOwjIOe/eZAaxbFWFaAJgMRf00J4Ipt0wYsdZeNTOJGw11
         0Ys2kdj7HL/yi4ozQq6HFr3zvDogaS+YGYN02HE4j1CmunVv+F6W/u5+oBTjMEh5aBco
         KI76R2V68Eok/H7GpDkBmbKGT0XhNUol0u7Enscui8L614RhJ8epw5bcqnXI65Ie4DAt
         6LxNC2hKoU9WThH8TLIyyVRYlD4c23HmN8XOlZDhBwlXMhWju7vS9wafXj4jwXfORBwo
         6jAMb8Mbvyy6m20CildNcPdHdg8nmRmJeacCnoeG7AbW2At+E0vZciKpQKUVeUv93Tax
         zWEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq2a4VpVniDjwQfQihEY6hFcVUrpFKJbsoaMrLs90El2yf6fgBuEOuVee4ywZtGNusMRxPZfLMZSxJrjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQgAXaYCr/qCCz2udz+NjeJpye66b988m/+dgulkg/azbmQSiw
	BBA4Pb6imzkX3a/SjQ+a1ZYYCJn5zVPDTDZFqmxAtgdEOl3bGcqxnbYp
X-Gm-Gg: ASbGnctwY76K/z3+MkXsDUODnBYAz+L5FK/XFxUR3eF74GZRo760GpD8wWWHZYJ60MJ
	EDVNWQuF5JQLc8lXzX37+2AS8k5Nenu198eTytMlF5AqpGaOTSgD2lYY3MDmuhWZIaNjRPt6CF8
	zZxzb/1LRROt3i9zVp1zHl6dOHhcr+kpDr/TtjDSfE+1HKo9SScxO5jxnAy+hbkyrL0ageI0A9v
	Hk1xf8v4b+lLVtaKsOIVDWfHZTpnyJLPnpdOaViIxtlI11hcTzsXy0aIqAI1FtNioXTRN7PCXvj
	h6pjVw5OujduAnCm5tyTEB3Gj8GSvJopDZmtTG3lsBryRqmnwFCzjKGDLwchaKVOLQTabo+lERY
	jI1l34mLL13JoNDCX/5ifWYGW5g2E8A==
X-Google-Smtp-Source: AGHT+IGUQXhZVcMzH5x4qrxgNQpCZ4sYyZ3ugDsvfNumu2I8pECs9df4oC+H+CMnm997jPnr5crTug==
X-Received: by 2002:a05:6402:2111:b0:61d:2096:1e92 with SMTP id 4fb4d7f45d1cf-62ed82614c4mr7020136a12.15.1757822012514;
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3a5esm6570485a12.30.2025.09.13.20.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
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
Subject: [PATCH RESEND 43/62] setsid: inline ksys_setsid into the only caller
Date: Sun, 14 Sep 2025 06:53:26 +0300
Message-ID: <20250914035326.3661003-1-safinaskar@gmail.com>
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
 include/linux/syscalls.h | 1 -
 kernel/sys.c             | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77f45e5d4413..75e9ee03d19b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1231,7 +1231,6 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
-int ksys_setsid(void);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
 ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..66e1e2dfd585 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1265,7 +1265,7 @@ static void set_special_pids(struct pid **pids, struct pid *pid)
 		change_pid(pids, curr, PIDTYPE_PGID, pid);
 }
 
-int ksys_setsid(void)
+SYSCALL_DEFINE0(setsid)
 {
 	struct task_struct *group_leader = current->group_leader;
 	struct pid *sid = task_pid(group_leader);
@@ -1300,11 +1300,6 @@ int ksys_setsid(void)
 	return err;
 }
 
-SYSCALL_DEFINE0(setsid)
-{
-	return ksys_setsid();
-}
-
 DECLARE_RWSEM(uts_sem);
 
 #ifdef COMPAT_UTS_MACHINE
-- 
2.47.2


