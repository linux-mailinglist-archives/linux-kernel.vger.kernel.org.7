Return-Path: <linux-kernel+bounces-815441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1955B56499
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 05:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2342C189EF4A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 03:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37452459F3;
	Sun, 14 Sep 2025 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Meuoho8s"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2E2E413
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821427; cv=none; b=QDjuWiVVM3V+9jasyxX9r4Ns5FIfWuUDJGv4LRDNDWUaOybwEi9hGTFZeTDFTiwzXn2aR4YdKraew88+ngSILow/msa33ymv3vq1SwdYqKQfrMwksXbO4p49o7QKP1V4+9dYmKUd3iWQZO/5fRboIlyBHU0E4RGW9XKxLBb6Pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821427; c=relaxed/simple;
	bh=Rey/ebl7WFu2BHJpZO0tlGb9Yvux/yHNtNSpgXJUf3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC6JZeQBDKQW75LKnp82kGV52M+PmZw0iiVQy+JC9W/PnJwn+6VqDv1/PL+9E6aartdu5gTG45+7ZvoyrrWNM4PCFtvi3v95pVp7hcrBkg7aMMYuVY7a/2StmEUKqf6izkxWiJrbxWvzxq58txd3Aj0SAFzUTiuMdjE3h8EzrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Meuoho8s; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-62f1987d49fso1099417a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821422; x=1758426222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edp+OfqM1e00xcpSWGvAGWC/LGQGu+BMiq7TC0KqX/w=;
        b=Meuoho8stdCgQ03Hoq6UgAr03TaN96IypV+PgLqP/nGA44yo2zt6U929mjRx+HCq13
         FPWIoc3jiMY7qBRlszyNQbvaQVxYynf3mcVS4ZUqM9DXZXSglG7vOuDf+9BPpKpwhOE5
         esyrIr1LmwK1sh8FW8bsMCVhqfrrjJWn3/4I8UakoSU28KzFPHuQL9W0/2J7g0A8nZ1O
         T5RsV+SSGzPKnwo1gUBPlfDSkMXh66xIdqSXJL7EHd2oWfyzikGuiq7xGrG+i6kSggsO
         7dLhiHDpmeMEhTiC4sxGkbT4o1wUK7rDi6kWKBKQROziCBkBfVzJywQs93poRxb5DR22
         ZxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821422; x=1758426222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edp+OfqM1e00xcpSWGvAGWC/LGQGu+BMiq7TC0KqX/w=;
        b=afo5F0w6YkWoEjmBgR0KN0yZ7gT/sPBNSJHTeYEd6tvf7MLfB3s3yZ1MLGDK4VxRcU
         8SxbomUcNYCgiWHISvhFtqF7Y3bTIMElnbPjQNRF6TFQhFDU8TJKavQyiDvcvM8oD++U
         OHMe/qmAJZ1WizhwuHi+5h4wm+rbIP/M3lh4n54Gz7Jq1dNWQlLjXTODAjj3CYxFnjjF
         ROFLwdnHP79uv+0g9TczW5rDwtR9bNFhCWsS52XhwuhtfEmaA4Z/HOgYbDDOIjT91rqe
         BU4UcFrIfXjfNdlfaZlmSXKa+YVryLb6W3qrOE3JnaWOyWZmvAQ22oorrrLLCeSd4SNU
         iZaw==
X-Forwarded-Encrypted: i=1; AJvYcCUJw5NT98NSsT54x7UUL8xq3FEP3gxy2mrLQR5Cu8+Vv58YG+enrV++1hJLpSL2OCW6HsXK0z8D5G+I4vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YweHLyvXhU3B4Sz1fSgKcr1HsaHL7jG+ngIIVYi8CFK4X2ai5kw
	ARd5J8z71X0v1Jg5eE9Du0pE0+8lvcVeBXi+SXVRhrj76LRIr7S0utiK
X-Gm-Gg: ASbGncs2PIreMQQ4n3UoyZqaIvFRgrS/SCxDqWRyp/GRxA+JSOssNjOW17robZ6PFWe
	8wSMQdTNCDMT9CfFfOr/U2IOsr70LLqgpfixrx/vc9Nd11YVRBgD0wP8QVUz4XdXwBpl8yE88/y
	WpY+ofx8wjOZBoEAIGRrOu85rt+rR3h32TN+3oxGS0t2pAoXlKKyzqA6FInwDWhD0dI+5CUD1WE
	lq4rfEqP4+1+KhjeMKBTYAd3lPBCzkuzPG5PWoVTssXmYGBL+b3RGSalwfCFYLz1HfUmB2xOy4o
	EHWUC1CpIjx0KH9zhLlo6vn1zpi26Vu+rDuhw4VxskCmSP0saso3SHW92iIG8kqGzCpgW9ZSkqB
	Hec0KDCdlla4wyokzXR8=
X-Google-Smtp-Source: AGHT+IET6lw3qY9XyvNvb3pybcnRN4nnQ2bci5TeiF0EBvfDGIL/USbY9x3ZkIUotRlW6z+hFZZ7Dw==
X-Received: by 2002:a17:907:72c9:b0:af9:6bfb:58b7 with SMTP id a640c23a62f3a-b07c354e9b4mr721980466b.5.1757821422077;
        Sat, 13 Sep 2025 20:43:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07d2870da1sm345137366b.13.2025.09.13.20.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:43:40 -0700 (PDT)
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
Subject: [PATCH RESEND 37/62] init: remove root_mountflags from init/do_mounts.h
Date: Sun, 14 Sep 2025 06:43:35 +0300
Message-ID: <20250914034335.3506706-1-safinaskar@gmail.com>
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

It is already declared in include/linux/kernel.h

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index 90422fb07c02..e225d594dd06 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,8 +12,6 @@
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-extern int root_mountflags;
-
 /* Ensure that async file closing finished to prevent spurious errors. */
 static inline void init_flush_fput(void)
 {
-- 
2.47.2


