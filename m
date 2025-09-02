Return-Path: <linux-kernel+bounces-796785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89368B40714
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E8BC4E176C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06DA31DD9A;
	Tue,  2 Sep 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="pXeUr5xJ"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA483126C8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823800; cv=none; b=LlgBJhFvJnXdz03HVBTs2qRWtBcheRv6v9HeDkREETHLLPlBROsdsV7tRnNDVT/87WOJnYkXMDPGb8lw7sQ7cWUH8Lx1vMetyQicbnT/YJxq7z8uIVr1ThcZsPROPKrpCHYvzX72c81EcBRgc5mmglIuCDlkbM7efQgd/qoH7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823800; c=relaxed/simple;
	bh=A+LsaK/8DhB/sQF9unOwV9CCW5H3/KtzVBQyYx2LaUI=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=qYnbV3wF2eu4EN+zp/V8x65OIDRCODwlJbD0DGpdM6WMU4QlzfyFUM12oPmUWpiryHTYDXBRyFM9svAjxJk1AGZLsdDUCv8+4mQ+5M6XSXMtsx3sGSdU9ou6kN04rvUr2fjvDaqm7F7Y5xvAMXoP+QtHthCGON8odGvs9VH2HmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=pXeUr5xJ; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Date:Cc:To:From:Subject:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zRxrYvACY0BtKprr4DU8AfTF+qXgwquqVx2ViwvSgsA=; b=pXeUr5xJO5BtyFYyH49zLb7ZWH
	hG0iLLsHuZ9/VTNU2VPoT6dxNw4eCSbNJ464oMUQQoJUgIsjqSMy1awKeZWC7SXbIe4uVAg1tUEw5
	2zuKORgbkOfF4UpLBmX8hBccvslqHQL6iDeFCV76/2ra2VFZZ+PkhrTjRhkteAbDbEjwHk7XnOB9S
	L3qgD4uH+3CmEwRp7RTk5kgTftNeKV3cgSpiCF+2hvHrrsy6bdZlGNwVO8NwO+ufNMWJ3ZQhGKorx
	jq1HwLVRz8FrCJYOIcS/gBAG5IRwFP4g2tOGaCKK+zUkmQosoucaYDWh1ZAo613SOGwPPQTSHjG+f
	IMBQ4Ceg==;
Received: from [213.55.222.174] (helo=[10.155.49.253])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1utRev-007C5B-MG; Tue, 02 Sep 2025 15:06:54 +0100
Message-ID: <a90ee087c4dc21bbd548c933256d6b4a877a9fd9.camel@codethink.co.uk>
Subject: SCHED_DEADLINE tasks causing WARNING at kernel/sched/sched.h message
From: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, Vineeth Pillai
 <vineeth@bitbyteword.org>, Daniel Bristot de Oliveira <bristot@kernel.org>,
 Luca Abeni <luca.abeni@santannapisa.it>
Date: Tue, 02 Sep 2025 16:06:52 +0200
Organization: Codethink
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: marcel.ziswiler@codethink.co.uk

Hi

As part of our trustable work [1], we also run a lot of real time scheduler=
 (SCHED_DEADLINE) tests on the
mainline Linux kernel (v6.16.2 in below reported case). Apart from some reg=
ression identified which recently
got fixed [2], the Linux scheduler proves quite capable of scheduling deadl=
ine tasks down to a granularity of
5ms on both of our test systems (amd64-based Intel NUCs and aarch64-based R=
ADXA ROCK5Bs).

However, very rarely (e.g. only once over the course of the 2.4 billion tes=
ts we ran last week on ROCK5B), we
do get the following message in the logs.

Aug 23 18:09:37 localhost kernel: ------------[ cut here ]------------
Aug 23 18:09:37 localhost kernel: WARNING: CPU: 7 PID: 259143 at kernel/sch=
ed/sched.h:1787
__task_rq_lock+0xac/0xfc
Aug 23 18:09:37 localhost kernel: Modules linked in: ghash_generic overlay =
snd_soc_hdmi_codec panthor
rockchipdrm pwm_fan rfkill_gpio phy_rockchip_usbdp cdc_ether typec synopsys=
_hdmirx display_connector
snd_soc_simple_card hantro_vpu usbnet phy_rockchip_naneng_combphy phy_rockc=
hip_samsung_hdptx rockchip_thermal
snd_soc_es8316 drm_gpuvm rtc_hym8563 rk805_pwrkey rockchip_saradc drm_exec =
industrialio_triggered_buffer
drm_shmem_helper kfifo_buf dw_hdmi_qp spi_rockchip_sfc analogix_dp gpu_sche=
d dw_mipi_dsi drm_dp_aux_bus dw_hdmi
cec drm_display_helper snd_soc_rockchip_i2s_tdm cfg80211 drm_client_lib r81=
52 drm_dma_helper drm_kms_helper
v4l2_vp9 mii v4l2_h264 v4l2_jpeg v4l2_mem2mem snd_soc_audio_graph_card snd_=
soc_simple_card_utils rfkill
pci_endpoint_test drm dm_mod snd_aloop backlight dax
Aug 23 18:09:37 localhost kernel: CPU: 7 UID: 0 PID: 259143 Comm: stress-ng=
-cpu-s Not tainted 6.16.2-dirty #1
PREEMPT_RT=20
Aug 23 18:09:37 localhost kernel: Hardware name: radxa Radxa ROCK 5 Model B=
/Radxa ROCK 5 Model B, BIOS 2024.07-
00925-g459560000736 07/01/2024
Aug 23 18:09:37 localhost kernel: pstate: 804000c9 (Nzcv daIF +PAN -UAO -TC=
O -DIT -SSBS BTYPE=3D--)
Aug 23 18:09:37 localhost kernel: pc : __task_rq_lock+0xac/0xfc
Aug 23 18:09:37 localhost kernel: lr : __task_rq_lock+0x54/0xfc
Aug 23 18:09:37 localhost kernel: sp : ffff80009dd83b80
Aug 23 18:09:37 localhost kernel: x29: ffff80009dd83b80 x28: ffff0001e48557=
80 x27: 0000000000000000
Aug 23 18:09:37 localhost kernel: x26: 0000000000000000 x25: 00000000000000=
00 x24: ffffb2e0b0d37c60
Aug 23 18:09:37 localhost kernel: x23: ffff80009dd83bc8 x22: ffff0001e48557=
80 x21: ffff0001e4855780
Aug 23 18:09:37 localhost kernel: x20: ffffb2e0b0c2fe40 x19: ffff0002fef2ae=
40 x18: 0000000000000000
Aug 23 18:09:37 localhost kernel: x17: 0000000000000000 x16: 00000000000000=
00 x15: 0000ffffd2453db8
Aug 23 18:09:37 localhost kernel: x14: ffff0001e4855800 x13: 00000000000000=
00 x12: 0000000000000000
Aug 23 18:09:37 localhost kernel: x11: 0000000000000165 x10: ffff000100a5fc=
e8 x9 : 0000000000000000
Aug 23 18:09:37 localhost kernel: x8 : 0000000000000000 x7 : ffff0001e48558=
00 x6 : 000000000000008f
Aug 23 18:09:37 localhost kernel: x5 : 0000000000000000 x4 : 00000000000000=
00 x3 : 0000000000000000
Aug 23 18:09:37 localhost kernel: x2 : 0000000000000001 x1 : ffff0002fef172=
58 x0 : ffffb2e0b0d5bfb0
Aug 23 18:09:37 localhost kernel: Call trace:
Aug 23 18:09:37 localhost kernel:  __task_rq_lock+0xac/0xfc (P)
Aug 23 18:09:37 localhost kernel:  rt_mutex_setprio+0x6c/0x498
Aug 23 18:09:37 localhost kernel:  rt_mutex_slowunlock+0x17c/0x310
Aug 23 18:09:37 localhost kernel:  rt_spin_unlock+0x7c/0x90
Aug 23 18:09:37 localhost kernel:  cpuset_cpus_allowed+0xd8/0x10c
Aug 23 18:09:37 localhost kernel:  __sched_setaffinity+0xb0/0x194
Aug 23 18:09:37 localhost kernel:  sched_setaffinity+0x140/0x27c
Aug 23 18:09:37 localhost kernel:  __arm64_sys_sched_setaffinity+0xb8/0x180
Aug 23 18:09:37 localhost kernel:  invoke_syscall+0x48/0x104
Aug 23 18:09:37 localhost kernel:  el0_svc_common.constprop.0+0xc0/0xe0
Aug 23 18:09:37 localhost kernel:  do_el0_svc+0x1c/0x28
Aug 23 18:09:37 localhost kernel:  el0_svc+0x34/0x104
Aug 23 18:09:37 localhost kernel:  el0t_64_sync_handler+0x10c/0x138
Aug 23 18:09:37 localhost kernel:  el0t_64_sync+0x198/0x19c
Aug 23 18:09:37 localhost kernel: ---[ end trace 0000000000000000 ]---

Usually, this is accompanied by our test workload process also getting the =
SIGXCPU signal, despite it not
overrunning its allocated runtime, at least not on purpose.

We are wondering what exactly could cause this or what exactly could be the=
 issue.

We are happy to provide more detailed debugging information (however, full =
journal logs are usually a couple
hundred MB in size), but are looking for suggestions on how/what exactly to=
 look at.

Any help is much appreciated. Thanks!

Cheers

Marcel

[1] https://projects.eclipse.org/projects/technology.tsf
[2] https://lore.kernel.org/all/ce8469c4fb2f3e2ada74add22cce4bfe61fd5bab.ca=
mel@codethink.co.uk
[3] https://lore.kernel.org/all/20250715071658.267-1-ziqianlu@bytedance.com
[4] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/k=
ernel/sched/sched.h?h=3Dv6.16.2#n1785

BTW: due to us having applied this patch set on top of v6.16.2 [3] the line=
 number moved by 2 lines so the
WARN_ON line in questions is actually the following [4].

