Return-Path: <linux-kernel+bounces-806730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607E6B49B0F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C853ACADC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E282DAFBB;
	Mon,  8 Sep 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Qk+qHOz0"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0926CE07
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363232; cv=none; b=QjO7JwlXwF8yRRbmdbxPoEcas0zuiVEnFd9z0KtkvvenH1O/78uOaCvVEjPKIXODjVPp/AYZIInA+v5GCVps79/g7/qeJnmYuhHVrHDwo/0VTO3bGMsChSxtD/gDkVnShN6n7cjjF7TFxxS+E8R168IKloARFfWJXScssY+FkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363232; c=relaxed/simple;
	bh=R+RPFUaQ4mejsHing0JSmdO1/cH8Syy4hOFC8sFGHH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CM8fzxV8cRJK/++ZyLv+NHGiooOjKr50kKEhqBPmwLs9cQFLzKvSL3q3mp5YFHonOSHkGzKkHmPh5TT5BI37ArmCUJHbD73obmCwwk4Rvedlczt/2TyPZ1zbCtkTt6PBqtuFA8x/DZK1e2fGXNCtyJegPRtIY4xAeQtK9Lo2jZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Qk+qHOz0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77460a64848so394806b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1757363228; x=1757968028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hV02bLAKFBFkOOZ9eD4/UG2hKvc6GSc1iWXYygfABnA=;
        b=Qk+qHOz0HDaMigHC8Jp5tqbGnErL6Rp2+D/l+0azUach3+eOlRnzM2/icS8AVO88kr
         6gEPVji4qZOdPYrZdhE1+/eoXuWwFokfFOhqqLQGphGcidtZGkKep8QFEmggN8shzpW2
         GouUBrKDNZUAUDkpCKDHuiJPEZS4IaK62xEAcLjShJb+iVh8U6iDaXyoi62p9trb28+B
         1gR7spCbUhNJ22g+5jRT7T1102XR6rN4nnVZo6H44G/OPr/B0ixbesSuE4GnqUIdSFsH
         588hzHgZ2YyUNlg1XVgqJwdvq8gGv6KtWW/9lYF6e/v5tId2KmNWuuSbiX4ANxzoM2MD
         b/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757363228; x=1757968028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hV02bLAKFBFkOOZ9eD4/UG2hKvc6GSc1iWXYygfABnA=;
        b=mikh+00QICBCplatmB+Y4VYe2JJINJf15cVCx7lvAafWVp563PVE7S+/YO7JFe0+4V
         osSMZ4gtXZq/uVUz47N1pLGwsPvcHv5r4EuKxiWvG2M7uUT9jRyZSTX2oWXFBDIj9SBE
         AJQdtp03R93+jl7zqELuJ90SSkHgIT0+ff2a+PQCngy+UHUpnvHnfzgKRigoJeot4imU
         2zlG4Zm045kF4LElUgnNjuFEaWhhp+vGW76oXa6Hf2LN/z9XBIexsNn/98F10lRH5PQV
         Aho17zpNncHkgVo7vETh7FCCMBAddUr0DgLfEtYz3mVKIny3IGqvTGMy9orV+UvJczhL
         hrXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU00222qlhZX8l84bMxxUSuO6IkpguHfO6xKfu8AeNh0lHOR5cOTwQWMu4b7dzUxdLqG9c4ya2PCV39YgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKGsVQlfXehbO34Zuz62bR0n6mQRPgbiPfQbiaP5R6IiLB0HG
	GjbLX+syOl7y2083LpGufVSKk98m7uhpE1zj0g+PP5/I67lmLoiEeJ8P+y+wnL13FX0=
X-Gm-Gg: ASbGncs4WbbPEfFzraLlC1QNUlpbQ/willUtQxcdTj8BDzWRL+Teds1D+SJAoXEK9yF
	7vb3DgPLHYyEplEvGilG7S4W/ZxlDzBxCupyY5tubMQHbNXjZdj972mn42Lq7nuKBOiOrNQ6s+z
	cHDWy7QeN4ERf8DwpGVuu8GM2mh+SIc9wG0+mGG84nyXZEr7ChEqhu0xuDiHA7EZkZrewhhUN86
	OKHLGr1etHIHatRirhgZtwZUUpMxCCFsnRFwcWsOT4cpIujuCbeSZHY6Wa79pAbpTIF+nghS8Ub
	lA8jygi3U8twPu1JqK6YvjuwepGMfkNfpgbYRn0jOsB2H+lR7qI8+Vy2aTPwELmh4W4lFqK+z4K
	XWZx47CnrChhsDMYbtOvCNpvtyKti1hlIu/s=
X-Google-Smtp-Source: AGHT+IFplMZW/dMedCK7FU7LCKvxFX/4CXky7giYFTQYl0fKfaDs9ntsMf8Dnd2XJ7Px+krXV3eJPg==
X-Received: by 2002:a05:6a00:188b:b0:774:20f9:63cd with SMTP id d2e1a72fcca58-7742dd1174fmr11757332b3a.1.1757363228239;
        Mon, 08 Sep 2025 13:27:08 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7726c1ed65bsm20050671b3a.45.2025.09.08.13.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 13:27:07 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:27:05 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: John Ogness <john.ogness@linutronix.de>,
	Breno Leitao <leitao@debian.org>
Cc: Mike Galbraith <efault@gmx.de>, Simon Horman <horms@kernel.org>,
	kuba@kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>, paulmck@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <aL88Gb6R5M3zhMTb@mozart.vkv.me>
References: <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
 <84a539f4kf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84a539f4kf.fsf@jogness.linutronix.de>

On Friday 09/05 at 14:54 +0206, John Ogness wrote:
> <snip>
>
> NBCON is meant to deprecate @oops_in_progress. However, it is true that
> consoles not implementing ->write_atomic() will never print panic
> output.

Below is a silly little testcase that makes it more convenient to test
if crashes are getting out in a few canned cases, in case anyone else
finds it useful.

Testing this on 6.17-rc5 on a Pi 4b, I don't get any netconsole output
at all for any crash case over wifi, so that already doesn't work. All
the cases currently work over ethernet.

----8<----
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH] Quick and dirty testcase for netconsole (and other consoles)

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/tty/Kconfig     |   9 ++
 drivers/tty/Makefile    |   1 +
 drivers/tty/crashtest.c | 178 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 drivers/tty/crashtest.c

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 149f3d53b760..c0f58943202c 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -424,6 +424,15 @@ config RPMSG_TTY
 	  To compile this driver as a module, choose M here: the module will be
 	  called rpmsg_tty.
 
+config CRASHTEST
+	tristate "Empirical testcase for console crash output"
+	help
+	  Say Y to expose a file at /sys/kernel/debug/crashtest which allows
+	  the kernel to be deliberately crashed in various execution contexts to
+	  prove crash traces can be successfully emitted on the console.
+
+	  To compile this driver as a module, choose M here. If unsure, say N.
+
 endif # TTY
 
 source "drivers/tty/serdev/Kconfig"
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index 07aca5184a55..0448b8285079 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -27,5 +27,6 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
+obj-$(CONFIG_CRASHTEST)		+= crashtest.o
 
 obj-y += ipwireless/
diff --git a/drivers/tty/crashtest.c b/drivers/tty/crashtest.c
new file mode 100644
index 000000000000..a7b90300d906
--- /dev/null
+++ b/drivers/tty/crashtest.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * # cat /sys/kernel/debug/crashtest
+ * crash_user
+ * crash_user_nobh
+ * crash_user_noirq
+ * crash_user_conlock
+ * crash_user_rtnllock
+ * crash_bh
+ * crash_irq
+ * # echo "crash_user" > /sys/kernel/debug/crashtest
+ */
+
+#include <linux/console.h>
+#include <linux/debugfs.h>
+#include <linux/irq_work.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rtnetlink.h>
+#include <linux/string.h>
+
+static ssize_t __crash(void)
+{
+	pr_emerg("BANG!\n");
+	*(volatile unsigned char *)NULL = '!';
+	return -ENOSYS;
+}
+
+static void __crash_irq_work(struct irq_work *work)
+{
+	__crash();
+}
+
+static struct irq_work irq_crash_work;
+
+static ssize_t crash_irq(void)
+{
+	if (!irq_work_queue(&irq_crash_work))
+		return -EBUSY;
+
+	irq_work_sync(&irq_crash_work);
+	return -ENOSYS;
+}
+
+static void __crash_bh_work(struct work_struct *work)
+{
+	__crash();
+}
+
+static struct work_struct bh_crash_work;
+
+static ssize_t crash_bh(void)
+{
+	if (!queue_work(system_bh_wq, &bh_crash_work))
+		return -EBUSY;
+
+	flush_work(&bh_crash_work);
+	return -ENOSYS;
+}
+
+static ssize_t crash_user(void)
+{
+	return __crash();
+}
+
+static ssize_t crash_user_nobh(void)
+{
+	local_bh_disable();
+	return crash_user();
+}
+
+static ssize_t crash_user_noirq(void)
+{
+	local_irq_disable();
+	return crash_user();
+}
+
+static ssize_t crash_user_conlock(void)
+{
+	console_lock();
+	return crash_user();
+}
+
+static ssize_t crash_user_rtnllock(void)
+{
+	rtnl_lock();
+	return crash_user();
+}
+
+struct crashtest_case {
+	ssize_t (*fn)(void);
+	const char *str;
+};
+
+#define CRASHTEST_CASE(fn_) \
+	(struct crashtest_case){.fn = fn_, .str = #fn_ "\n"}
+
+static const struct crashtest_case tests[] = {
+	CRASHTEST_CASE(crash_user),
+	CRASHTEST_CASE(crash_user_nobh),
+	CRASHTEST_CASE(crash_user_noirq),
+	CRASHTEST_CASE(crash_user_conlock),
+	CRASHTEST_CASE(crash_user_rtnllock),
+	CRASHTEST_CASE(crash_bh),
+	CRASHTEST_CASE(crash_irq),
+};
+
+static ssize_t crashtest_write(struct file *file, const char __user *u_buf,
+			       size_t u_len, loff_t *u_off)
+{
+	char buf[32] = {0};
+	unsigned i;
+
+	if (copy_from_user(buf, u_buf, min(u_len, sizeof(buf) - 1)) != 0)
+		return -EFAULT;
+
+	for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++)
+		if (!strcmp(tests[i].str, buf))
+			return tests[i].fn();
+
+	return -EEXIST;
+}
+
+static ssize_t crashtest_read(struct file *file, char __user *u_buf,
+			      size_t u_len, loff_t *u_off)
+{
+	ssize_t ret = 0;
+	unsigned i;
+
+	if (*u_off > 0)
+		return 0;
+
+	for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+		unsigned long len, done;
+
+		len = strlen(tests[i].str);
+		done = len - copy_to_user(u_buf, tests[i].str, min(u_len, len));
+		u_len -= done;
+		u_buf += done;
+		ret += done;
+		if (done != len)
+			break;
+	}
+
+	*u_off += ret;
+	return ret;
+}
+
+static const struct file_operations crashtest_fops = {
+	.write = crashtest_write,
+	.read = crashtest_read,
+};
+
+static struct dentry *crashtest_dentry;
+
+static int __init setup_crashtest(void)
+{
+	INIT_WORK(&bh_crash_work, __crash_bh_work);
+	init_irq_work(&irq_crash_work, __crash_irq_work);
+	crashtest_dentry = debugfs_create_file("crashtest", 0600, NULL, NULL,
+					       &crashtest_fops);
+	if (IS_ERR(crashtest_dentry))
+		return PTR_ERR(crashtest_dentry);
+
+	return 0;
+}
+
+static void __exit cleanup_crashtest(void)
+{
+	debugfs_remove(crashtest_dentry);
+}
+
+late_initcall(setup_crashtest);
+module_exit(cleanup_crashtest);
+
+MODULE_AUTHOR("Calvin Owens <calvin@wbinvd.org>");
+MODULE_DESCRIPTION("Empirical testcase for console crash output");
+MODULE_LICENSE("GPL");
-- 
2.47.2


