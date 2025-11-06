Return-Path: <linux-kernel+bounces-889270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC1CC3D1FB
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0048C351FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F31A346768;
	Thu,  6 Nov 2025 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="g8CRyknn"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D5E2C326C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455515; cv=none; b=FERf3tgqWs9sQP8rm2fqHtkOVGDDxPfpVA7y5cpA6mStQ8ebCW6d9AiETTKW6a9gazjn2f7tCrVjOGD+7KUD92VERlFrWsDKdR1gjBKJVFcXhd6bf+OkvorH8jvKSbYPKKLGEXxw+u8/RVaajmHhO0VGPtEQ7LV12KVbAsbIr3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455515; c=relaxed/simple;
	bh=RmmyYAmWJEAFj7TB6nmTqnJ+GYGaJ0nRnlvL0FvTNJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+KVVFoNiZoNgG+OErCl1UVPBkApgxuGrr1eSXNRr1zro63tdVUrFMoV58PiiYt71IkzKc7JcvfdUDdnL2ByH1VRZTNl4NPWdgFbdvijRYhIPg8xBxMpbXdjvawVCs27Bqo+5sVhxP3oPWVGi4rlPPmBmecPnlJhSgaLWZkB5cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=g8CRyknn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-294fe7c2e69so14719685ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1762455512; x=1763060312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mOuSugR0vEDHkKd7HQ/z/MU9ajVuAQGybGkQLVZTufY=;
        b=g8CRyknn1E5/PL1VbmEJi1ApRoiJBaPBWGhv6jnlpJk8gc2oEVF6ecoqQJFPWLNKlM
         e9lf5iHY2hvnMHoYwUsfI3KqN6bxM/lyiAjL2rDoIJTtqQyq3GfeafYTGoh1RDnDAHtN
         gJQCyytLERfTfH9W3dUIWf2+6MIsmJL9A7aKnJtnEdFzPr0tIZPsvHmb7loa68n62c98
         Nps56NTBu4NzxBS9rvNKXx4GRKnB+MbXHUqIvmrDH8OOGhlDLW6pOMn4Sg0hVlXQgDYB
         qKEK/is7F7KgjiKPpngpCl7O9yuYUovYraPWYhFT8w/HB1l4fcKD/efnzmkKq6xiXlNj
         o3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455512; x=1763060312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOuSugR0vEDHkKd7HQ/z/MU9ajVuAQGybGkQLVZTufY=;
        b=q4lFQNqKA1W3W8061v4bdGL65fIc0wtyi4/HKMkpbrYPYzq/ypva1PcuDjmSjKI7DU
         YLZ00YqPecKdu8n4+otWw3v8ZgT5X3jtTb9bJt2jP3UEH6HWCJv+EZkt/lSuJLO4C9zE
         1bO1hZLMK4epQd1C//R/0WFvnJ5hO/sLhBaKhLmtuzBHdMJDX/eqFG6/XpcwtDqKr7i4
         C1Go1TU6jT9iIkIhnfDUqebxWuV4sy0bljKnfyW7+9tH32XsYF923mZfdn48Rd1oPIla
         tixMc/ja0YpsEZu/Q0mTfRZNWkqV+MfYWZWnGVId/S/MwabyfbQsNW99GIgnwQx8d5Hf
         Id2A==
X-Forwarded-Encrypted: i=1; AJvYcCVZSzSGHfvzIF8tLDEJLzYv+ewwaJXlOQ94pUHUN5NNW590yuZPYTz0ieW2tpraC60IjvnuS1E7Rcc923Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiBBJTPpIN/FPrfbNVWFify2EfNnWSMjzPGAfk3IdG21hqGRMI
	VHbd7THiqt+amu74GVE7cugwE4Q/PHFtrfJob5xZn8nMD8Bk678tlWyCqykOgqbuvOYr
X-Gm-Gg: ASbGnctZeV4vzaCg87IqnS3P6vAUsDzGxGxFNJrpTd+A+sY5iMqYf1KXMvG6HGmlZhE
	4ng4e962b+wqPgwXlsuK5ZplVaR7SaBTSs8O7hHnzTe73jEgRT1D164A5dfrCn+53rLLuemFBaZ
	G+0Xbws2HDRP/KHUHoBbmggFLuub24gnOCxou12j5fZ2J6PnvRL7cqXHJX5QsaJf2OsWdN1uR/z
	n3p5MM34Qhh4JwWIxkiCxRK0Mur7kAHC6CTturMNBdVlT4TNR5z2hu3jkW2aWkvQ/+5pAb8M8Qc
	2I+KCvcr+vT4cH9jkaB3bhWxG1AoDpkKQsJf3bjY0EG+xcyF2UNsBj+RTnWRtIe4xN0GZdtJxnI
	/5mzL8jy8x8wb3f+DiyOous/9KLR/S0YLu2w3PR5CBTcwJ2QLYt98Wy+XPYD+Z8xW+Wc89VYAtM
	FvOXM=
X-Google-Smtp-Source: AGHT+IEKN8Omxm27BVM277srluy0q0QA7FdKmsLt1KdRuR58aAFheeoJ4P4lYUWCJp0b+fyErYgSsw==
X-Received: by 2002:a17:902:e5cc:b0:295:5d0b:e119 with SMTP id d9443c01a7336-297c03cff98mr6731495ad.26.1762455511456;
        Thu, 06 Nov 2025 10:58:31 -0800 (PST)
Received: from sultan-box ([142.147.89.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096b801sm36546605ad.7.2025.11.06.10.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:58:30 -0800 (PST)
Date: Thu, 6 Nov 2025 10:58:27 -0800
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: bin.du@amd.com, pratap.nirujogi@amd.com, amd-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
	benjamin.chan@amd.com, christian.koenig@amd.com, dantony@amd.com,
	gjorgji.rosikopulos@amd.com, king.li@amd.com, phil.jawich@amd.com
Subject: Re: [PATCH] drm/amd/amdgpu: Ensure isp_kernel_buffer_alloc() creates
 a new BO
Message-ID: <aQzv00We7FyKAWk7@sultan-box>
References: <20251105232108.107765-1-sultan@kerneltoast.com>
 <a6063bc0-4ba1-4cad-9045-5fa31ea4ed7a@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a6063bc0-4ba1-4cad-9045-5fa31ea4ed7a@amd.com>

On Thu, Nov 06, 2025 at 12:46:51PM -0600, Mario Limonciello wrote:
> On 11/5/25 5:21 PM, Sultan Alsawaf wrote:
> > From: Sultan Alsawaf <sultan@kerneltoast.com>
> >=20
> > When the BO pointer provided to amdgpu_bo_create_kernel() points to
> > non-NULL, amdgpu_bo_create_kernel() takes it as a hint to pin that addr=
ess
> > rather than allocate a new BO.
> >=20
> > This functionality is never desired for allocating ISP buffers. A new BO
> > should always be created when isp_kernel_buffer_alloc() is called, per =
the
> > description for isp_kernel_buffer_alloc().
>=20
> Are you just going off descriptions, or is there a problem with reuse?

I am going based off the ISP4 driver's usage of isp_kernel_buffer_alloc().

This fixes the following crash I experienced on v5 of the ISP4 patchset:

  [  175.485627] BUG: unable to handle page fault for address: 00007f6b1092=
e888
  [  175.485799] #PF: supervisor read access in kernel mode
  [  175.485840] #PF: error_code(0x0000) - not-present page
  [  175.485869] PGD 0 P4D 0=20
  [  175.485889] Oops: Oops: 0000 [#1] SMP
  [  175.485908] CPU: 15 UID: 1000 PID: 57022 Comm: cheese Tainted: G     U=
  W           6.17.7 #1 PREEMPT=20
  [  175.485921] Tainted: [U]=3DUSER, [W]=3DWARN
  [  175.485933] Hardware name: HP HP ZBook Ultra G1a 14 inch Mobile Workst=
ation PC/8D01, BIOS X89 Ver. 01.03.00 04/25/2025
  [  175.485943] RIP: 0010:amdgpu_bo_create_reserved+0xb1/0x1c0 [amdgpu]
  [  175.485961] Code: 8b 30 44 89 64 24 20 48 89 44 24 28 c7 44 24 30 01 0=
0 00 00 c7 44 24 1c b8 02 00 00 c6 44 24 08 00 4d 85 f6 0f 84 a9 00 00 00 <=
49> 8b 86 a8 01 00 00 49 8b be 40 01 00 00 31 f6 48 89 04 24 e8 d6
  [  175.485976] RSP: 0018:ffff97b14e097ad0 EFLAGS: 00010202
  [  175.485988] RAX: 0000000000000021 RBX: ffff97b085af04d0 RCX: 000000000=
0000000
  [  175.486002] RDX: 0000000000008000 RSI: ffff97b14e097ae0 RDI: ffff97b14=
e097b20
  [  175.486012] RBP: ffff97b085af04c8 R08: ffff97b085af04d8 R09: ffff97b08=
5af04c8
  [  175.486023] R10: 0000000000ffffff R11: ffff97b085af0560 R12: 000000000=
0000002
  [  175.486031] R13: ffff97b085af04d8 R14: 00007f6b1092e6e0 R15: ffff97b0a=
0f00000
  [  175.486037] FS:  00007faf60ffe6c0(0000) GS:ffff97cfa7133000(0000) knlG=
S:0000000000000000
  [  175.486046] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  175.486058] CR2: 00007f6b1092e888 CR3: 0000000101c3f000 CR4: 000000000=
0f50ef0
  [  175.486067] PKRU: 55555554
  [  175.486072] Call Trace:
  [  175.486081]  <TASK>
  [  175.486092]  ? smu_cmn_send_smc_msg_with_param+0xc0/0x360 [amdgpu]
  [  175.486102]  amdgpu_bo_create_kernel+0x15/0x70 [amdgpu]
  [  175.486110]  isp_kernel_buffer_alloc+0x56/0xa0 [amdgpu]
  [  175.486118]  isp4if_gpu_mem_alloc.isra.0+0x45/0x70 [amd_capture]
  [  175.486126]  isp4if_start+0x3a/0x320 [amd_capture]
  [  175.486141]  isp4sd_set_power+0x96/0x1e0 [amd_capture]
  [  175.486148]  pipeline_pm_power_one+0xf2/0x110 [videodev]
  [  175.486155]  pipeline_pm_power+0x51/0x90 [videodev]
  [  175.486161]  v4l2_pipeline_pm_use+0x3b/0x60 [videodev]
  [  175.486169]  isp4vid_qops_start_streaming+0x22/0x140 [amd_capture]
  [  175.486176]  ? isp4vid_qops_buffer_queue+0xb1/0x140 [amd_capture]
  [  175.486185]  vb2_start_streaming+0x79/0x140 [videobuf2_common]
  [  175.486192]  vb2_core_qbuf+0x3b5/0x480 [videobuf2_common]
  [  175.486200]  vb2_qbuf+0x98/0x100 [videobuf2_v4l2]
  [  175.486208]  __video_do_ioctl+0x480/0x4b0 [videodev]
  [  175.486219]  video_usercopy+0x1e5/0x760 [videodev]
  [  175.486226]  ? v4l_s_output+0x50/0x50 [videodev]
  [  175.486237]  v4l2_ioctl+0x45/0x50 [videodev]
  [  175.486245]  __x64_sys_ioctl+0x77/0xc0
  [  175.486251]  do_syscall_64+0x48/0xbf0
  [  175.486260]  entry_SYSCALL_64_after_hwframe+0x50/0x58
  [  175.486268] RIP: 0033:0x7fb03371674d
  [  175.486275] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 4=
5 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <=
89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
  [  175.486282] RSP: 002b:00007faf60ffc9d0 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
  [  175.486292] RAX: ffffffffffffffda RBX: 00007fafb40050b0 RCX: 00007fb03=
371674d
  [  175.486301] RDX: 00007faf60ffca70 RSI: 00000000c058560f RDI: 000000000=
000002c
  [  175.486306] RBP: 00007faf60ffca20 R08: 13455f273d2513b9 R09: 000000000=
0000210
  [  175.486313] R10: 0000000000000215 R11: 0000000000000246 R12: 00007faf9=
801c4b0
  [  175.486318] R13: 0000000000000001 R14: 00007faf60ffcad0 R15: 000000000=
0000001
  [  175.486324]  </TASK>
  [  175.486330] Modules linked in: ccm hid_sensor_prox hid_sensor_gyro_3d =
hid_sensor_trigger industrialio_triggered_buffer kfifo_buf hid_sensor_iio_c=
ommon industrialio hid_sensor_hub rfcomm snd_seq_dummy snd_hrtimer snd_seq =
snd_seq_device amd_capture videobuf2_memops videobuf2_v4l2 videobuf2_common=
 videodev mc pinctrl_amdisp i2c_designware_amdisp uhid cmac algif_hash algi=
f_skcipher af_alg bnep uinput nls_iso8859_1 vfat fat snd_acp_legacy_mach sn=
d_acp_mach snd_soc_nau8821 snd_acp3x_rn snd_acp70 snd_acp_i2s snd_acp_pdm j=
oydev snd_soc_dmic snd_acp_pcm mousedev intel_rapl_msr snd_sof_amd_acp70 sn=
d_sof_amd_acp63 snd_hda_scodec_cs35l56_spi intel_rapl_common snd_ctl_led sn=
d_sof_amd_vangogh snd_sof_amd_rembrandt snd_hda_codec_alc269 snd_sof_amd_re=
noir snd_hda_scodec_component snd_sof_amd_acp snd_hda_codec_realtek_lib snd=
_sof_pci snd_sof_xtensa_dsp snd_hda_codec_generic snd_sof snd_sof_utils snd=
_pci_ps snd_soc_acpi_amd_match amdgpu snd_amd_sdw_acpi snd_hda_codec_atihdm=
i soundwire_amd soundwire_generic_allocation snd_hda_codec_hdmi
  [  175.486373]  soundwire_bus snd_soc_sdca snd_soc_core snd_compress snd_=
hda_intel ac97_bus snd_pcm_dmaengine mt7925e drm_panel_backlight_quirks amd=
xcp snd_hda_codec snd_rpl_pci_acp6x mt7925_common btusb drm_buddy cdc_mbim =
mt792x_lib snd_acp_pci cdc_wdm btrtl drm_exec snd_hda_core snd_amd_acpi_mac=
h mt76_connac_lib snd_hda_scodec_cs35l56_i2c btintel snd_acp_legacy_common =
drm_suballoc_helper cdc_ncm snd_intel_dspcfg mt76 snd_hda_scodec_cs35l56 sn=
d_pci_acp6x cdc_ether drm_ttm_helper btbcm snd_intel_sdw_acpi snd_hda_cirru=
s_scodec snd_hwdep usbnet ttm snd_pci_acp5x btmtk snd_soc_cs35l56_shared uc=
si_acpi kvm_amd mac80211 snd_pcm r8152 i2c_algo_bit snd_rn_pci_acp3x typec_=
ucsi snd_soc_cs_amp_lib libarc4 spd5118 bluetooth mii drm_display_helper sn=
d_timer cs_dsp kvm typec snd_acp_config hp_wmi snd cfg80211 libphy amdxdna =
roles cec snd_soc_acpi ecdh_generic sp5100_tco hid_multitouch irqbypass spa=
rse_keymap rfkill rapl mdio_bus video gpu_sched amd_pmf wmi_bmof snd_pci_ac=
p3x soundcore amdtee i2c_hid_acpi serial_multi_instantiate
  [  175.486384]  i2c_hid amd_sfh thunderbolt wireless_hotkey amd_pmc platf=
orm_profile wmi mac_hid i2c_piix4 i2c_smbus i2c_dev sg crypto_user loop nfn=
etlink ip_tables x_tables dm_crypt encrypted_keys trusted asn1_encoder tee =
dm_mod polyval_clmulni ghash_clmulni_intel aesni_intel nvme nvme_core nvme_=
keyring serio_raw ccp nvme_auth
  [  175.486394] CR2: 00007f6b1092e888
  [  175.486402] ---[ end trace 0000000000000000 ]---
  [  175.486409] RIP: 0010:amdgpu_bo_create_reserved+0xb1/0x1c0 [amdgpu]
  [  175.486416] Code: 8b 30 44 89 64 24 20 48 89 44 24 28 c7 44 24 30 01 0=
0 00 00 c7 44 24 1c b8 02 00 00 c6 44 24 08 00 4d 85 f6 0f 84 a9 00 00 00 <=
49> 8b 86 a8 01 00 00 49 8b be 40 01 00 00 31 f6 48 89 04 24 e8 d6
  [  175.486422] RSP: 0018:ffff97b14e097ad0 EFLAGS: 00010202
  [  175.486429] RAX: 0000000000000021 RBX: ffff97b085af04d0 RCX: 000000000=
0000000
  [  175.486433] RDX: 0000000000008000 RSI: ffff97b14e097ae0 RDI: ffff97b14=
e097b20
  [  175.486439] RBP: ffff97b085af04c8 R08: ffff97b085af04d8 R09: ffff97b08=
5af04c8
  [  175.486444] R10: 0000000000ffffff R11: ffff97b085af0560 R12: 000000000=
0000002
  [  175.486448] R13: ffff97b085af04d8 R14: 00007f6b1092e6e0 R15: ffff97b0a=
0f00000
  [  175.486455] FS:  00007faf60ffe6c0(0000) GS:ffff97cfa7133000(0000) knlG=
S:0000000000000000
  [  175.486460] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [  175.486464] CR2: 00007f6b1092e888 CR3: 0000000101c3f000 CR4: 000000000=
0f50ef0
  [  175.486470] PKRU: 55555554

Admittedly, it's my fault that ISP4 stopped zeroing the BO pointer argument
(&mem_info->mem_handle) passed to isp_kernel_buffer_alloc() [1]. But since =
this
issue slipped past Bin and presumably others who reviewed the code, it
highlights that isp_kernel_buffer_alloc() is not working as expected in this
respect, and the description for isp_kernel_buffer_alloc() reinforces this.

> >=20
> > Ensure this by zeroing *bo right before the amdgpu_bo_create_kernel() c=
all.
> >=20
> > Fixes: 55d42f616976 ("drm/amd/amdgpu: Add helper functions for isp buff=
ers")
> > Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_isp.c
> > index 9cddbf50442a..37270c4dab8d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
> > @@ -280,6 +280,8 @@ int isp_kernel_buffer_alloc(struct device *dev, u64=
 size,
> >   	if (ret)
> >   		return ret;
> > +	/* Ensure *bo is NULL so a new BO will be created */
> > +	*bo =3D NULL;
> >   	ret =3D amdgpu_bo_create_kernel(adev,
> >   				      size,
> >   				      ISP_MC_ADDR_ALIGN,
>=20

[1] https://lore.kernel.org/all/aNB0P18ytI1KopWI@sultan-box/

Sultan

