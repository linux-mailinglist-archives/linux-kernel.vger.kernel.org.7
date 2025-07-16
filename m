Return-Path: <linux-kernel+bounces-734321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03F1B07FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00841177E50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083C22EE275;
	Wed, 16 Jul 2025 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="AACRkPJF"
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2732ED87F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752702533; cv=pass; b=u87joqSvodUT8/oXcqtAqZERPQZwimJkqnOLBbKaKDJbpBT3Fdg5bYrCMntu5FtHwL6TvbyUgHGYsi7QvpRnwjuTh/AH1ZbX/zTWc82qSpFiuArQv3t3yYcfkZu+/IulP//sEUsq58pJozJdth0B62bTuwevwljPQTNGxgo3FqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752702533; c=relaxed/simple;
	bh=u6BdzZJhx24mYYqYOAREec47UXOE7JPyiDqGUzGpSYI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sZ9nkiN5Zxx5CNBKtdi3754YKhgdGRdIfoqsLW0gudHZ1ZbYCSS/VO1L48dNMdfYEE+/V76GQcmT80JFqwTgw+VP6KlQffv3nugZzJSfQP/7q1OalmE1Ka2P9MRzqT0Zxh9bNm0gypINnvBptJCg6lC1t95kYKuOOewBxy6HGko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=AACRkPJF; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1752702517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JCgbVQKeF8fPuBzymCpZ6ocDt/uZa4MaRcWzaPxap4+fqhJ//Yn5jxFwCa1aag4/UxhdfF9KrZTAhE4gHRUY26bA85Ujkon1a0STuaW3ACNjM5xijp2UbYvF7Ko5nBugM4BmAdayuXL2U6E3d0HcdSkswioWAJyFcaZGo6cjwMI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752702517; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jykymLpcIuD1F/ilyuxCAh0D/DhSx5X6vDiB9nbBDi8=; 
	b=ButG1eaqH+j60qJkVSoXIcjoc5i6ITbNl5SylW2URa4C71UcRL57jA6Tu1cXT5W8SMs/70mbuQ22ZMr+mUUJCttZWaBGlv4/WsaF7/e9L/YvdPc2Dz7Md+eTLKXdJt1WFCwCAN7MRP5raSG3SeEM0rqAWoiD6SbhD3Tsmpowbyk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752702517;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=jykymLpcIuD1F/ilyuxCAh0D/DhSx5X6vDiB9nbBDi8=;
	b=AACRkPJF1sTJJnG4JmepNkWcwoHEUoNZ6piD+VdqiwTXoQgtrnzgjTSnWSA+Q3aM
	SZmDOIuTx8+ySKjUD0lVl0gqkL7UCAeQOyFMiwro2v6Yn23g2/qHh8CI3p3nlRJx7WC
	9z/QlLkKbe/IPHdTdv4z0VgZQc7kO69yj0sb7VjM=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 17527025142865.420431262086026; Wed, 16 Jul 2025 14:48:34 -0700 (PDT)
Received: from  [212.73.77.104] by mail.zoho.com
	with HTTP;Wed, 16 Jul 2025 14:48:34 -0700 (PDT)
Date: Thu, 17 Jul 2025 01:48:34 +0400
From: Askar Safin <safinaskar@zohomail.com>
To: "Jocelyn Falempe" <jfalempe@redhat.com>
Cc: "ryasuoka" <ryasuoka@redhat.com>, "airlied" <airlied@gmail.com>,
	"dri-devel" <dri-devel@lists.freedesktop.org>,
	"kraxel" <kraxel@redhat.com>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"maarten.lankhorst" <maarten.lankhorst@linux.intel.com>,
	"mripard" <mripard@kernel.org>, "simona" <simona@ffwll.ch>,
	"tzimmermann" <tzimmermann@suse.de>,
	"virtualization" <virtualization@lists.linux.dev>
Message-ID: <1981535f461.11e01ca3b21091.7915707831085255756@zohomail.com>
In-Reply-To: <05c40a0a-d2b0-4f55-981f-6da3765eebb2@redhat.com>
References: <20250613132023.106946-1-ryasuoka@redhat.com>
 <20250714000456.14-1-safinaskar@zohomail.com>
 <1961897d-cf42-4495-aec7-f4c20dfe7566@redhat.com>
 <1980fcccefe.10a7c92b36705.2744765212931179004@zohomail.com> <05c40a0a-d2b0-4f55-981f-6da3765eebb2@redhat.com>
Subject: Re: [PATCH drm-next] drm/bochs: Add support for drm_panic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011227c5463886fdf22997189eff70000061a5f1d7e53860d826172f6061090962bf5ae90f91ad8289de:zu080112276f196aec0a095a0a879bbc740000301014a8f874aef8db273d280520c189b8235d3de26de00cbf:rf0801122b6eb97275627a4a89c5a2933c000051fc395a76030f971dc85125368a1f3ccbb2b641e979217cbffce946b8:ZohoMail

 ---- On Wed, 16 Jul 2025 02:00:56 +0400  Jocelyn Falempe <jfalempe@redhat.com> wrote --- 
 > Yes, that's the default if you use a drm driver like bochs with fbdev 

Thank you for answer! I just tried kernel from drm-tip with this config with drm_panic in qemu. And panic works.
But I don't like result.
When drm panic happens, messages printed to /dev/console disappear. Only kernel messages remain.

Here are steps to reproduce. And then I will describe how this breaks my workflow.

Compile kernel from drm-tip ( https://gitlab.freedesktop.org/drm/tip ). I used commit b012f04b5be909a307ff629b297387e0ed55195a .
It seems to include this bochs patch (i. e. "drm/bochs: Add support for drm_panic").
Use this miniconfig:

$ cat mini
CONFIG_64BIT=y

CONFIG_EXPERT=y

CONFIG_PRINTK=y
CONFIG_PRINTK_TIME=y

CONFIG_PCI=y

CONFIG_TTY=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_DRM=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_BOCHS=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PROC_FS=y

CONFIG_DRM_PANIC=y
CONFIG_DRM_PANIC_SCREEN="kmsg"

CONFIG_BLK_DEV_INITRD=y
CONFIG_RD_GZIP=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=y
$ make KCONFIG_ALLCONFIG=mini allnoconfig

Create initramfs, which contains exactly these files:
$ find /tmp/i -ls
     2861      0 drwxrwxr-x   3 user     user           80 Jul 16 23:56 /tmp/i
     2891      0 drwxrwxr-x   2 user     user           80 Jul 16 23:56 /tmp/i/bin
     2893      0 lrwxrwxrwx   1 user     user            7 Jul 16 23:56 /tmp/i/bin/sh -> busybox
     2892   1980 -rwxr-xr-x   1 user     user      2024544 Jul 16 23:56 /tmp/i/bin/busybox
     2864      4 -rwxrwxr-x   1 user     user           43 Jul 16 23:18 /tmp/i/init

This is "init":
===
#!/bin/sh

set -e

echo hello
sleep 3
exit 0
===

Now boot this in Qemu. I used this command:
$ qemu-system-x86_64 -enable-kvm -m 1024  -kernel arch/x86/boot/bzImage -initrd /tmp/ini.cpio.gz

You will see word "hello", then after 3 seconds the system will fail into drm panic.

What I saw: word "hello" disappeared, when the system falled into panic
What I expected to see: word "hello" should remain.

Now let me describe how this breaks my workflow.

I often use hand-crafted shell scripts as PID 1. Both in Qemu and on real hardware.
I use them to reproduce and bisect various kernel bugs.
I always put "set -e" in the beginning of shell script. This means that script fails after first error.
And thus system fails into kernel panic.
I also sometimes put "set -x" to debug these scripts.
Thus, when script fails and panic happens, then faulty shell command will be last thing printed on screen before panic stacktrace.
But with drm_panic everything printed to /dev/console disappears.
This breaks my workflow.

In Qemu I can easily workaround this by using serial console.

But I cannot do this on real hardware.

And yes, I experience fbcon panic problems on real hardware, too, this is why I'm interested in drm panic: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14658

(I have not yet tested whether drm_panic fixes that fbcon i915 panic problem, but I assume it does.)

I can workaround this by using efi fb with fb panic as opposed to i915. But this will not work if I attempting to catch bug in i915 itself.
(And yes, I recently found another i915-related bug, and I'm trying to debug it using shell scripts running as PID 1.
Here it is: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/14598 .)

I can workaround this by logging everything to disk.
But this will not work when everything is mounted read-only.
And this is exactly what happens, when I try to catch that kexec-related bug:
immediately before issuing "kexec -e" command I mount everything read-only.

The only remaining workaround is to redirect everything to /dev/kmsg.
I. e. put "exec > /dev/kmsg 2>&1" to the script.
This will work.
But I still don't like this.

--
Askar Safin
https://types.pl/@safinaskar


