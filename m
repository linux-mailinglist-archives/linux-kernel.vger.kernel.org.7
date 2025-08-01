Return-Path: <linux-kernel+bounces-753733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B128BB18715
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E6517B7E03
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717872701C2;
	Fri,  1 Aug 2025 18:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="B6B0h/dN"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0115184524
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071280; cv=none; b=gSuqpVHVhh9zHXZCm7f08v2rmPpTMw50Dm8a99/6BWMqnnM8iExuO9Sbdgnl+jNFaNWY1o2dFQOF9wCKPbMCFKBsAxrq3Q7/HTdt992yZVjWFnhkAXjTeT8EhqGq5RRvAs2CkcCtKXTmnXd/TW2vTJnmIg46kUg1ODaNPUmJpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071280; c=relaxed/simple;
	bh=5Ww0AyzobIH6fSff5DNPb+zDOTsw5PfHFTOBcFuHm3A=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:MIME-Version:Date; b=ehn8mgy4I2Yed+YdA/ZVgWtjuC2QSAhljXqIu1FMu7lcPYgl0GAI9Xr071rDaZsNJmstgW9skyRDHQh3xS3kk5HjAPSk7aENfUTQYi5kdVmmgAuq+hiWDuzB1YuvXmLxPf6yXq+tblzr/fNFSHAERmbNmxVZbilK0W5u6SW+Ru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=B6B0h/dN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754071266; x=1754676066; i=efault@gmx.de;
	bh=8h2BaQN1GxXOMnJa55qRgY3CSQwptiDBALzWv337c6Q=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:Date:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B6B0h/dNtkiGvmqCAfGL5LcxLSrR9sK/6xeUfh67+UEYf57iw6U1x0tkD8f+odng
	 FPwMTMmq/x+4dXDbmSTqm1X8hwFttLZ4XoKRc+0kqMElrrz4FqrV87vN+NDLjga/N
	 qK5xNVs+r8DocgNq+X6mpZJg5mML9yDsOV9+rTdP8kGaKwX3oUHVJEw+85A1yNHoF
	 XtLsWLirb0dykm3/p8e1x7Hm5kjxshPGytmTRK64zXkcbNJE8l+wJp/2b9c+4wlxL
	 ffGbpOWFH2tEAi44FsHCAqjE4QfIIok9m1K6CDwc2d3bHlC9xXREhHoDm6MarQpWe
	 glz98/ERt8JdxYjzvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.25]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MsYqp-1uOb3x0Ywt-00wr6C; Fri, 01
 Aug 2025 20:01:06 +0200
Message-ID: <709adaad09aeebca8b9c152075056ec5aad69a1f.camel@gmx.de>
Subject: nouveau: fbdev: Failed to setup emulation (ret=-22) - bisected to
 41ab92d35ccd
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, nouveau
 <nouveau@lists.freedesktop.org>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	
 y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 01 Aug 2025 19:55:15 +0200
User-Agent: Evolution 3.50.3 
X-Provags-ID: V03:K1:1klbGHtdw1HnkknE9uyKOl3gSfzx2uZSnxVqui2sBalfRCiDiLh
 KLkdtIDApbCnN36Ccaao/IjjvAz6n+SWmwcLGBGGsZvVYpTQpMuFT0SW7dAUTfibtqKFBd5
 pAVGYHZdzfJOefMo7PSxHHIk41BV7kyMC1kaYhaPBTUr2tYnMJZUZTa8PbnMuDDOdwA2Klr
 YugEjLL7mgoiiwStqbndA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aULBb4k87XI=;4perM415CV9nFVTXb3j9y4vzDlR
 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

Greetings,

Reverting the fingered commit below brought my GTX980 back to life.

41ab92d35ccd2d66bfb049bd34cd95f0304b0240 is the first bad commit
commit 41ab92d35ccd2d66bfb049bd34cd95f0304b0240
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Date:   Tue Jul 1 12:07:22 2025 +0300

    drm: Make passing of format info to drm_helper_mode_fill_fb_struct() ma=
ndatory
   =20
    Now that everyone passes along the format info to
    drm_helper_mode_fill_fb_struct() we can make this behaviour
    mandatory and drop the extra lookup.
   =20
    Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
    Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.co=
m>
    Signed-off-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
    Link: https://patchwork.freedesktop.org/patch/msgid/20250701090722.1364=
5-20-ville.syrjala@linux.intel.com

 drivers/gpu/drm/drm_modeset_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

dmesg output sans revert:
[    3.220788] nouveau 0000:01:00.0: NVIDIA GM204 (124000a1)
[    3.302724] nouveau 0000:01:00.0: bios: version 84.04.1f.00.02
[    3.304609] nouveau 0000:01:00.0: pmu: firmware unavailable
[    3.308652] nouveau 0000:01:00.0: vgaarb: deactivate vga console
[    3.308905] nouveau 0000:01:00.0: fb: 4096 MiB GDDR5
[    3.308920] nouveau 0000:01:00.0: bus: MMIO write of 80000195 FAULT at 1=
0eb14 [ PRIVRING ]
[    3.375764] nouveau 0000:01:00.0: drm: VRAM: 4096 MiB
[    3.375768] nouveau 0000:01:00.0: drm: GART: 1048576 MiB
[    3.375771] nouveau 0000:01:00.0: drm: TMDS table version 2.0
[    3.376933] nouveau 0000:01:00.0: drm: MM: using COPY for buffer copies
[    3.425989] [drm] Initialized nouveau 1.4.0 for 0000:01:00.0 on minor 0
[    3.459953] Modules linked in: hid_generic(+) usbhid nouveau(+) drm_ttm_=
helper ttm drm_client_lib gpu_sched i2c_algo_bit drm_gpuvm drm_exec drm_dis=
play_helper drm_kms_helper xhci_pci drm ehci_pci xhci_hcd ehci_hcd ahci lib=
ahci libata ghash_clmulni_intel usbcore video wmi button usb_common sd_mod =
scsi_dh_emc scsi_dh_rdac scsi_dh_alua sg scsi_mod scsi_common vfat fat ext4=
 crc16 mbcache jbd2 loop msr efivarfs autofs4 aesni_intel gf128mul
[    3.460023]  nouveau_framebuffer_new+0x27f/0x470 [nouveau]
[    3.460116]  nouveau_user_framebuffer_create+0x42/0x90 [nouveau]
[    3.460289]  nouveau_drm_probe+0x128/0x1a0 [nouveau]
[    3.460402]  nouveau_drm_init+0x8b/0x1000 [nouveau]
[    3.460516] nouveau 0000:01:00.0: [drm] *ERROR* fbdev: Failed to setup e=
mulation (ret=3D-22)
[    3.494950] nouveau 0000:01:00.0: [drm] *ERROR* fbdev: Failed to setup e=
mulation (ret=3D-22)
[   19.217424] nouveau 0000:01:00.0: [drm] *ERROR* crtc 66: Can't calculate=
 constants, dotclock =3D 0!
[   19.217438] nouveau 0000:01:00.0: [drm] drm_WARN_ON_ONCE(drm_drv_uses_at=
omic_modeset(dev))
[   19.217504] Modules linked in: af_packet nft_fib_inet nft_fib_ipv4 nft_f=
ib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nf=
t_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tab=
les bridge stp llc iscsi_ibft iscsi_boot_sysfs rfkill nfnetlink binfmt_misc=
 usblp joydev nls_iso8859_1 nls_cp437 intel_rapl_msr intel_rapl_common x86_=
pkg_temp_thermal intel_powerclamp coretemp snd_hda_codec_generic snd_hda_co=
dec_hdmi kvm_intel snd_hda_intel r8169 iTCO_wdt snd_intel_dspcfg snd_hda_co=
dec uas at24 realtek intel_pmc_bxt snd_hwdep kvm usb_storage regmap_i2c snd=
_hda_core mei_hdcp iTCO_vendor_support mdio_devres snd_pcm libphy irqbypass=
 i2c_i801 snd_timer pcspkr i2c_smbus mei_me snd mdio_bus mei lpc_ich soundc=
ore mfd_core thermal fan intel_smartconnect nfsd auth_rpcgss nfs_acl lockd =
grace sch_fq_codel sunrpc fuse configfs dmi_sysfs hid_generic usbhid nouvea=
u drm_ttm_helper ttm drm_client_lib gpu_sched i2c_algo_bit drm_gpuvm drm_ex=
ec drm_display_helper drm_kms_helper xhci_pci drm ehci_pci
[   19.217694]  nv50_disp_atomic_commit_tail+0x2a1/0x740 [nouveau]
[   19.217761]  nv50_disp_atomic_commit.part.0+0x1a2/0x1d0 [nouveau]
[   19.217960]  nouveau_drm_ioctl+0x56/0xb0 [nouveau]
[   19.218082] nouveau 0000:01:00.0: [drm] *ERROR* crtc 66: Can't calculate=
 constants, dotclock =3D 0!
<repeats elided>

dmesg output with revert:
[    3.223553] nouveau 0000:01:00.0: NVIDIA GM204 (124000a1)
[    3.304520] nouveau 0000:01:00.0: bios: version 84.04.1f.00.02
[    3.306489] nouveau 0000:01:00.0: pmu: firmware unavailable
[    3.310543] nouveau 0000:01:00.0: vgaarb: deactivate vga console
[    3.310789] nouveau 0000:01:00.0: fb: 4096 MiB GDDR5
[    3.310815] nouveau 0000:01:00.0: bus: MMIO write of 800001a8 FAULT at 1=
0eb14 [ PRIVRING ]
[    3.377610] nouveau 0000:01:00.0: drm: VRAM: 4096 MiB
[    3.377614] nouveau 0000:01:00.0: drm: GART: 1048576 MiB
[    3.377616] nouveau 0000:01:00.0: drm: TMDS table version 2.0
[    3.378810] nouveau 0000:01:00.0: drm: MM: using COPY for buffer copies
[    3.419667] [drm] Initialized nouveau 1.4.0 for 0000:01:00.0 on minor 0
[    3.454261] fbcon: nouveaudrmfb (fb0) is primary device
[    3.498407] nouveau 0000:01:00.0: [drm] fb0: nouveaudrmfb frame buffer d=
evice

=20

