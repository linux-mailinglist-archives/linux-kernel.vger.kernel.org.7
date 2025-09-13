Return-Path: <linux-kernel+bounces-814984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E49B55D20
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7685C53CD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E282745C;
	Sat, 13 Sep 2025 01:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm9piSCy"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48119AD5C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725976; cv=none; b=ARIaK5RUljwoCHs1PlCvTtEaJanAxQXaiaz6N7XYly5EYCW8Esb6LqSRj8ombcJHBPksGxJnW6wSLhZvEn+fb9zq3iguMSddhhnIIBXwTo8xpS4g/o5KMKRfQprmRvA3JodxO4t4J1ytYEd1MQVmrKSuxBlo3eykJnYKnq1gMMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725976; c=relaxed/simple;
	bh=5w1rh0L6NznGkqOB1ptiKwAFOGZfY5CoA2D4m8g2/Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua55qeCwc8oSB8BUSzDO7g3o5cDHCyBdj2xyvRrxrXREIYYSPAnGCieIiNSeUtHJyfUDvFtinhLRkvZiiEPowVOiMgpTh1F/fQcqSQyzlUQyq2jDlAz97Rob+GhYiMS0pELRVGhiKgi/UlBzBZG909H0UtG9chciB8m12+6HvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm9piSCy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7a16441so374602266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725970; x=1758330770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=;
        b=jm9piSCyAtXZ4sW7o/h3SGpliQHevBkrhxl1tQii9mgHqdG87o74LcSjtY0avpY0iX
         RdeiQDrUqQ5C5qyGy2HNHbhjeW1tyThLcjGIFDuhifBp9ZAahZRe/JcjT78TZLjYxr6O
         clz08Pl2eYNgCRP3z65VvP8bCDfsGkCIvdvYFwno6M8/UvygM+KRsZjpRUrxOekYWGnI
         j0/O25Qolp3eD7BmcFGNh8/jP3xJV+WM11QZFpJ3kUVpHKMxijbTHMgjsau/ncgLiR1/
         GlkR/1ri7/XijIi7U6mEk94bP2JEKshCIzyPHHSsIIuiNpAyZbMwdpQELhiCIBLbGIjK
         LxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725970; x=1758330770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPS175BLdkdbkMvPyh09bMwfY79gXnuJYPms+9/x8xc=;
        b=e7z+R/G831yZMyncVMcKq7+a9xn67A2+2HTJzIBekrBUp0zLuBmYIVv1ucN+vpj1yI
         oOACzvjAYUzz4Xk/Hsbqbh2aoqckvdDpDs4bHNmkU20dRJpRUYdqBKSJ0Z3ETN4TsP5C
         9X0olIUFmY9PLpDMiS7EojVdW6M1dI5tCMmg8pzLMdKRK6ETUNJyAbY05CJoRQgVS/DO
         qF0l7mMqokOX3CJj3jnJNLxrtk/MVYFDliraP7NlcJGfym3L3a0bkjxWHuiiyYIglW0I
         Y4R7B5cZxat2urx3V9IRbWk1YY73RCZBLOcv6r5x9NIva5kNsThec73h+wdkLvtRKij7
         LgrA==
X-Forwarded-Encrypted: i=1; AJvYcCW9JgsgD/VZbCcItuVM+/6bxMqWHuv0LjVn9jfVQ/IyFYoK2v67bCBTSYn/9SD7zIAmJxLlSg7bir6Y0IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrYpm8pDBhVLyZBz3zIomafsEokgPD3/bQkhI7ubf1tALaj7Qa
	j5P0070UONYkr8d589lalOBDGN1l1isKL6DrRFdFVMLKPFbgTigPcMPP
X-Gm-Gg: ASbGncvfjeViSbaVlpOHqu7aI1++p0hJySY5rDy5TYqlt8YkYKafTc36/yrjFWiX5ww
	oVqNx8ZCprJvzi/BVxt6UG1rE/m+E+Ngq5awNCSwyaTg+xPBO52ktNADoXaObQWvAVcXMP+sz2y
	GGuFpAg4x913uvfX+NCCvTgYYUhy0gNEIf3aBqHzeu1Ml3ctuccj+Nnis1OBVF+ll20MMeM18hd
	91wYexAAIsG8AckH9+Q+uaCVTPMGV1aWxX4OJVTuuymVU5zR9++nQvLyXaog69xq72ogQhkN24f
	o2Pq+jGZu85tqV5Sn8H94CcGybc9LmTwg0oWfP+geGIwD6Aey6eaxwIu5tJhaJ6/OcODJQFjNZr
	CAfxtyIrJpfusP3xAb3QqvI0ZCFqfO7L8H31Z6tfm
X-Google-Smtp-Source: AGHT+IExCbHobezsJZBylPatDCb3rXiTmvHjuHynF55nxxCc14bpP2oPLB71sx+Li40Hkl4GjqRelQ==
X-Received: by 2002:a17:907:97d2:b0:b04:31c6:a434 with SMTP id a640c23a62f3a-b07c324cf12mr467235966b.0.1757725969783;
        Fri, 12 Sep 2025 18:12:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b30da327sm479612566b.11.2025.09.12.18.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:12:49 -0700 (PDT)
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
Subject: [PATCH RESEND 30/62] doc: remove documentation for block device 4 0
Date: Sat, 13 Sep 2025 00:38:09 +0000
Message-ID: <20250913003842.41944-31-safinaskar@gmail.com>
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

It doesn't work. I tested this both in system booted
using initramfs and in system booted from real root
device directly

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/devices.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
index 27835389ca49..6ce0940233a8 100644
--- a/Documentation/admin-guide/devices.txt
+++ b/Documentation/admin-guide/devices.txt
@@ -138,12 +138,6 @@
 		number for BSD PTY devices.  As of Linux 2.1.115, this
 		is no longer supported.	 Use major numbers 2 and 3.
 
-   4 block	Aliases for dynamically allocated major devices to be used
-		when its not possible to create the real device nodes
-		because the root filesystem is mounted read-only.
-
-		   0 = /dev/root
-
    5 char	Alternate TTY devices
 		  0 = /dev/tty		Current TTY device
 		  1 = /dev/console	System console
-- 
2.47.2


