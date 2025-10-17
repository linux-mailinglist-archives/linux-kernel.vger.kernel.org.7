Return-Path: <linux-kernel+bounces-857356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CC0BE699B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DE364EBD05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E621830FF04;
	Fri, 17 Oct 2025 06:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxsUWHaQ"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1C30FC3F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681485; cv=none; b=VAS+nCtbsvrJL29nrIaKXWH+AHZYtxn7S7qgV8SIEFKhtB8RP0YbW2KTMYB3wx7KNHyfVxFP0lEq4dYA9oXHIDxCT5u3wMjIv8a1H/8Qb+i29rLgEyTOYCy95fw1kc3mGVhBM0b7rE01xAa/j96dRfT/0sjQ56L9Nv/HQOBnwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681485; c=relaxed/simple;
	bh=ulNxyjs+7P2Oi91QTv8ZCqiBF+ih61EgQsdAC1fi7Y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsRL0RZomB468PvhJQnSnlh89OhU5C2p2+Os3qtxKpczF9jrMNXEe6wl3Eu9kOU5JaU+cK2rou+tPRgHG/LvQ4Y4yw+lfTL3yBF+PG8iV8kC0Sn5Sl/LLTc5ldQrCwp7d/LmXevz/kc6DYIcwLgr+y/f8B/dnttpKEP5YZJKBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxsUWHaQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1430267f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760681481; x=1761286281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqXHg8fIVhNftDZOE9plbEgrQCbIv7x8GRINtPvlAdM=;
        b=fxsUWHaQhj7CFg7lwcIffAaSGDYWnNOGnC2Wtr3PDtaEQ9OtgWAnhCZQLOr71juH5N
         3E/e54f8YRt74Evm+pMY6HvoH1eAmF6GGjFao2uXEssAtfz413aAKV/SMCQpVD1yjpF5
         xc+Ur35Icqe6/d4U7f4prbrV3uXc52+J4ltL6zk0jWtqUqy3Wu1QIgjoRWEs94JGfPf6
         fN9loldJBtOUIUBY/zuNxxt9O41Ya+f1i0Soerajk472YDphWjYYmMdQOA3QRy7P4Tfa
         GFMJNBc840prEByFOpUiIYEcNOtpizvHVz2tfiQgiwYAyKEIgyRVv4/P/RFOb4FO9GG8
         Ps6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681481; x=1761286281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqXHg8fIVhNftDZOE9plbEgrQCbIv7x8GRINtPvlAdM=;
        b=rW2rkZY2AqlnuSA6C0/BHoLib/5NZGIWsZNEYqudQDrWQ3gpLEf8HxQ0WETc3yWNie
         jKaFBuyg6/C0OzfUa1wKI/FYet1S745a57urkAdRlktoI4lPtpz/WVDOVHPII+foPByT
         SCXNrxZa1IkjCUJ+mL4CtnCoPSfeUk6zE+3/svTLtbAX2r/OsmWGYPS+WDh8tSvPsbba
         JICmhAvQcZ1qjGl9H3wTOipF4zJTfQ6vL9VpfiwXrwat3jyhkDhY+bUNRPBFYcU5Cecu
         uxPJZNjAh04I/ui4micNcWHoMqCVDQacYwDnxnFaaS2eoFSKJVck70AtAh6w6uIof9Bs
         DPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj+t70xq28VEfCCg+90eFU8fhHPL/LbIMjjyx9hOHBwabAyLcxu7gXyxaEg4HS+/fDejdlKsRjW0z/d0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhqFUfIoVuZ7j00sXTAoXcIJEwQkLZcVUwqFQhfP6/hh6udDg
	KmAl7B2W1TOE09E3flgHcRlmhLyFHPgDijLf/bJ+46924FWiOSZ6yhNk
X-Gm-Gg: ASbGncvua51TabSsaIyqUSk+ZYwjwedkj4RAHM5nQWA0FEQGn3E7bDVL8F/6840iI0E
	Lt73idgpHFbhdI/weu+K9Fn17L1z2C8Qn41OaEW5kKxmIBoKbXmMLdg/EIoAlAA6Ix3drmuBPpV
	+vaL2k1wCglQy04Ow8Nopfzx6Azde3gxiwHzEa0bTrUXR0BKzqw1vBEwtYBqyGNZG76H0wkHY7u
	H1m0o9FRDkw1TXBlSd4U0W9lOzSjwZRRsf/7gTNZVX8d4JYoW5o+w33QWRHTgSsxckLJcTVD8Ou
	Emy1mf4ZfWMFr3gAjMLseS/JSpCTC60yOhZAYmJ/aYt/4G+OFtEGAnleox8P2tnCD1PleNW+0Pe
	o2chkKutrhvFPS1BOcnsfeTizSfSbmUo9qYKXGWBjEi5cydIB72vnhMXus5euYFH2sNW4VtcN77
	xY4CvPc6B2i08=
X-Google-Smtp-Source: AGHT+IG9nFyXU6/YzYNrNEKOmFbcI73aJtoTWz3HhvfOqLzAHFD1KIWSe0W31I+6MYQb5EK9zvZOHQ==
X-Received: by 2002:a05:6000:2507:b0:425:737a:4804 with SMTP id ffacd0b85a97d-42704d4422dmr1625416f8f.4.1760681480389;
        Thu, 16 Oct 2025 23:11:20 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ff84cbb7sm7231059f8f.23.2025.10.16.23.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 23:11:19 -0700 (PDT)
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
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Young <dyoung@redhat.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Nicolas Schichan <nschichan@freebox.fr>,
	David Disseldorp <ddiss@suse.de>,
	patches@lists.linux.dev
Subject: [PATCH v3 3/3] init: remove /proc/sys/kernel/real-root-dev
Date: Fri, 17 Oct 2025 06:09:56 +0000
Message-ID: <20251017060956.1151347-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017060956.1151347-1-safinaskar@gmail.com>
References: <20251017060956.1151347-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not used anymore.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 ------
 include/uapi/linux/sysctl.h                 |  1 -
 init/do_mounts_initrd.c                     | 20 --------------------
 3 files changed, 27 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index f3ee807b5d8b..218265babaf9 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1215,12 +1215,6 @@ that support this feature.
 ==  ===========================================================================
 
 
-real-root-dev
-=============
-
-See Documentation/admin-guide/initrd.rst.
-
-
 reboot-cmd (SPARC only)
 =======================
 
diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
index 63d1464cb71c..1c7fe0f4dca4 100644
--- a/include/uapi/linux/sysctl.h
+++ b/include/uapi/linux/sysctl.h
@@ -92,7 +92,6 @@ enum
 	KERN_DOMAINNAME=8,	/* string: domainname */
 
 	KERN_PANIC=15,		/* int: panic timeout */
-	KERN_REALROOTDEV=16,	/* real root device to mount after initrd */
 
 	KERN_SPARC_REBOOT=21,	/* reboot command on Sparc */
 	KERN_CTLALTDEL=22,	/* int: allow ctl-alt-del to reboot */
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index bf381aa0400f..82613a3be756 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -8,31 +8,11 @@
 
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
-static unsigned int real_root_dev;	/* do_proc_dointvec cannot handle kdev_t */
 static int __initdata mount_initrd = 1;
 
 phys_addr_t phys_initrd_start __initdata;
 unsigned long phys_initrd_size __initdata;
 
-#ifdef CONFIG_SYSCTL
-static const struct ctl_table kern_do_mounts_initrd_table[] = {
-	{
-		.procname       = "real-root-dev",
-		.data           = &real_root_dev,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
-	},
-};
-
-static __init int kernel_do_mounts_initrd_sysctls_init(void)
-{
-	register_sysctl_init("kernel", kern_do_mounts_initrd_table);
-	return 0;
-}
-late_initcall(kernel_do_mounts_initrd_sysctls_init);
-#endif /* CONFIG_SYSCTL */
-
 static int __init no_initrd(char *str)
 {
 	pr_warn("noinitrd option is deprecated and will be removed soon\n");
-- 
2.47.3


