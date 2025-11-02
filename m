Return-Path: <linux-kernel+bounces-881634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E583C289A4
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 05:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6C444E2DC6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 04:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392BF1C4609;
	Sun,  2 Nov 2025 04:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="e33H73g+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DCyMBLUX"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E41B1509A0
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 04:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762056373; cv=none; b=Yv9eoRPw53pbUaFAC7ArBoGRAnm6XL1cma5gIXHyILrZJhJaWl3GwI8u4tHsn/1CMHCmgTBFOKZINcqJ5/Ol2f57CjTAJ/iLPlwvrsY8bmNEcoozPsZoJoNZ6JyiFo50CU0mAXFEFJRMZOu9TGVYTZYecxy7fdjhLoYquE+yu7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762056373; c=relaxed/simple;
	bh=M9snj91RCqmt5uIf6sjigPVdXnqqM4+cma72gIIeiAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VNMX0/3zRGpwwtY4hNwQLiKb0Furucm6FeSuDnkMX1nghCCZayaogt9nKbtjhtBuBWtloGih1XPDcKRvks8gIlLZdYL0eNNr28DxEG1umsOfwGh4A2M3lp0dyhluvmvxB82pcRroqgvKukUm4DYHPkBn0vEvMADTpWnr4eFHhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=e33H73g+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DCyMBLUX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E02DAEC0047;
	Sun,  2 Nov 2025 00:03:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 02 Nov 2025 00:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1762056196; x=1762142596; bh=zz
	l9nCwgx2fuMgGeUyzjQaNy6rpK87nR2ySzUfdomWQ=; b=e33H73g+BcBAiR7YS1
	D4PXbjdQ0xL8BolC2ixY0ChGmBflBu/ZAcP6Goa1Bz2rFilv05CzGcTDr+PEBhF0
	7iHyyfsY+GaKNUsmTbre49igN+SRdcktirrhdHTPhBpeqrP/aG+GqDWO5Rx+3h70
	Hzr3XeeMCMmQC0OVz1Y7xVfwUE85POpSj6HeLehMsprQFbOIeuDjbNKhYjzfuu+f
	qNUXntZ/ujVH9AVEbcFCG9gLOO+ujwDLlDARYwiJ7RySxt1VasBfUSanyMXLAYjm
	DUpaZ79aKyziL9jdxHeU8glpEhWDOyIE9QWx9eZCg1NTWzEi/tZznTiIDdDdJAxD
	VpQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762056196; x=
	1762142596; bh=zzl9nCwgx2fuMgGeUyzjQaNy6rpK87nR2ySzUfdomWQ=; b=D
	CyMBLUXAdb7Xe11J275HnfGqLzVPrZFDKopUb8Mxadpu5/ZuXJ55PMOqlDm+i0RI
	7q63mmbJf6KVIpkp/irhUNRzTgTgAFXVMofMRyawHoqgUQ32xQ84pkcbn+P9oclo
	7n1+TzxnQEl+/wrGOMuK0wcUY+OsV0sOiKE94LhglvYLSusVzwGO5WNfHomiTBR1
	EB2SaAumBC6+74UDaDjC/LEHanzUmZPJYf2cBvOrFbhUJw4CabUOGCFJnwBFLt+h
	1wqRHMbQV3ia1Kfa5sSweEqyOT4yhyfr0KBuHuhI8115fcVPYMVoB+y4HHwTCMbE
	cAOKyGc2eHJEQCc5kkFeA==
X-ME-Sender: <xms:BNgGaZvDaiW0n1qqEfIZIokoy5qQLDX7yVdSfEGwPGMCV_v98M3azw>
    <xme:BNgGaT-1txzXVo6gSxq6k-ClPi8wqjF4KWWeZYJ8EMlujoW_jTlyrwrfKbL0WYXtW
    NSmMpjkZJSCg8Tz8h7qZOu2NYdokVY8i0STkxtvtWYdHctbuQ>
X-ME-Received: <xmr:BNgGac2CODSqEzREvwnbrKuPvv3pMejDg9gv9mn_zcO1eNH3P4HkjVETu9HdWZDkUFLVTv7QG82RVHeJGppjHK9qsMThVW0juq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeegvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkgggtugesghdtroertddtjeenucfhrhhomhepofgrrhgvkhcuofgr
    rhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvihhsih
    gslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepfedtieevteev
    geffieetveegjeefhfektdfgfeejkefhleejleffvdekheetudejnecuffhomhgrihhnpe
    hquhgsvghsqdhoshdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsih
    gslhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprghlvgigrghnuggvrhdruhhshihskhhinhesihhnth
    gvlhdrtghomhdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohep
    ghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprh
    gvghhrvghsshhiohhnsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:BNgGaQA5jGABvUodxE-F5e-jx8z7QeT0fLnRzV1GxgKK7vfkDecDVA>
    <xmx:BNgGaQeNI_nfgQ12JYW2KlhTNKmqELtGXgCQdyT20ArUmEB9hehilw>
    <xmx:BNgGaV6XvBArsnMDX57Gq0KGIKJx_QdCNeKtANu2GJHBmdMdeWjxPQ>
    <xmx:BNgGabVBtuexWK6AlgPmSuC2frPLFftA_j4ljyZcHom7jm4LxP5Zsw>
    <xmx:BNgGaaTBNBUmzn83zLHulRRzrgTgQvHOEjrDC7U6iWYXH6hBh3lEXuCE>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Nov 2025 00:03:15 -0400 (EDT)
Date: Sun, 2 Nov 2025 05:03:13 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [REGRESSION] mei_me_probe NULL ptr deref on error path - 6.18-rc3
Message-ID: <aQbYAXPADqfiXUYO@mail-itl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SstVD4tUIWzgfLQp"
Content-Disposition: inline


--SstVD4tUIWzgfLQp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 2 Nov 2025 05:03:13 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [REGRESSION] mei_me_probe NULL ptr deref on error path - 6.18-rc3

Hi,

When trying Linux 6.18-rc3, I'm hitting kernel panic in mei_me driver.
It looks like this:

[   85.878591] mei mei0: wait hw ready failed
[   85.878699] mei mei0: hw_start failed ret =3D -62 fw status =3D 80022054=
 30284100 00000020 00000000 02620000 00000000
[   85.878769] mei mei0: H_RST is set =3D 0x800E0E31
[   87.926419] mei mei0: wait hw ready failed
[   87.926515] mei mei0: hw_start failed ret =3D -62 fw status =3D 80022054=
 30284100 00000020 00000000 02620000 00000000
[   87.926581] mei mei0: reset: reached maximal consecutive resets: disabli=
ng the device
[   87.926594] mei mei0: reset failed ret =3D -19
[   87.926598] mei mei0: link layer initialization failed.
[   87.926603] mei_me 0000:00:16.0: init hw failure.
[   87.926769] ------------[ cut here ]------------
[   87.926774] WARNING: CPU: 9 PID: 518 at kernel/workqueue.c:4234 __flush_=
work+0x340/0x390
[   87.926785] Modules linked in: intel_rapl_msr intel_powerclamp i2c_i801 =
intel_rapl_common snd pcspkr spi_intel_pci rfkill e1000e spi_intel processo=
r_thermal_wt_req i2c_smbus mei_me processor_thermal_power_floor soundcore m=
ei processor_thermal_mbox idma64 intel_pmc_core int340x_thermal_zone igen6_=
edac pmt_telemetry pmt_discovery pmt_class intel_hid sparse_keymap intel_pm=
c_ssram_telemetry intel_scu_pltdrv joydev fuse loop xenfs nfnetlink vsock_l=
oopback vmw_vsock_virtio_transport_common zram vmw_vsock_vmci_transport lz4=
hc_compress vsock vmw_vmci lz4_compress dm_thin_pool dm_persistent_data dm_=
bio_prison dm_crypt xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_gpu=
vm drm_exec drm_gpusvm_helper nvme i915 nvme_core sdhci_pci sdhci_uhs2 i2c_=
algo_bit nvme_keyring drm_buddy sdhci intel_pmc_mux nvme_auth ttm cqhci typ=
ec xhci_pci hid_multitouch polyval_clmulni ghash_clmulni_intel mmc_core hkd=
f intel_vpu intel_vsec xhci_hcd drm_display_helper i2c_hid_acpi i2c_hid thu=
nderbolt video wmi pinctrl_meteorlake cec serio_raw
[   87.926848]  xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_=
gntalloc xen_gntdev xen_evtchn scsi_dh_rdac scsi_dh_emc scsi_dh_alua uinput=
 i2c_dev
[   87.926895] CPU: 9 UID: 0 PID: 518 Comm: kworker/u56:3 Tainted: G       =
 W           6.18.0-0.rc3.1.qubes.1.fc41.x86_64 #1 PREEMPT(full)=20
[   87.926903] Tainted: [W]=3DWARN
[   87.926906] Hardware name: Notebook V54x_6x_TU/V54x_6x_TU, BIOS Dasharo =
(coreboot+heads) v0.9.0 01/01/1970
[   87.926912] Workqueue: async async_run_entry_fn
[   87.926918] RIP: e030:__flush_work+0x340/0x390
[   87.926923] Code: 26 9d 05 00 65 48 8b 15 26 3c ca 02 48 85 db 48 8b 04 =
24 48 89 54 24 58 0f 85 de fe ff ff e9 f6 fd ff ff 0f 0b e9 77 ff ff ff <0f=
> 0b e9 70 ff ff ff 0f 0b e9 19 ff ff ff e8 7d 8b 0e 01 48 89 de
[   87.926931] RSP: e02b:ffffc900412ebc00 EFLAGS: 00010246
[   87.926936] RAX: 0000000000000000 RBX: ffff888103e55090 RCX: 00000000000=
00000
[   87.926941] RDX: 000fffffffe00000 RSI: 0000000000000001 RDI: ffffc900412=
ebc60
[   87.926945] RBP: ffff888103e55090 R08: ffffffffc1266ec8 R09: ffff8881109=
076e8
[   87.926949] R10: 0000000080040003 R11: 0000000000000000 R12: ffff888103e=
54000
[   87.926953] R13: ffffc900412ebc18 R14: 0000000000000001 R15: 00000000000=
00000
[   87.926962] FS:  0000000000000000(0000) GS:ffff888233238000(0000) knlGS:=
0000000000000000
[   87.926967] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.926971] CR2: 00007e7923b32708 CR3: 00000001088df000 CR4: 00000000000=
50660
[   87.926977] Call Trace:
[   87.926981]  <TASK>
[   87.926987]  ? __call_rcu_common.constprop.0+0x11e/0x310
[   87.926993]  cancel_work_sync+0x5e/0x80
[   87.926999]  mei_cancel_work+0x19/0x40 [mei]
[   87.927051]  mei_me_probe+0x273/0x2b0 [mei_me]
[   87.927060]  local_pci_probe+0x45/0x90
[   87.927066]  pci_call_probe+0x5b/0x180
[   87.927070]  pci_device_probe+0x95/0x140
[   87.927074]  ? driver_sysfs_add+0x57/0xc0
[   87.927079]  really_probe+0xde/0x340
[   87.927083]  ? pm_runtime_barrier+0x54/0x90
[   87.927087]  __driver_probe_device+0x78/0x110
[   87.927092]  driver_probe_device+0x1f/0xa0
[   87.927095]  __driver_attach_async_helper+0x5e/0xe0
[   87.927100]  async_run_entry_fn+0x34/0x130
[   87.927104]  process_one_work+0x18d/0x340
[   87.927108]  worker_thread+0x256/0x3a0
[   87.927111]  ? __pfx_worker_thread+0x10/0x10
[   87.927115]  kthread+0xfc/0x240
[   87.927120]  ? __pfx_kthread+0x10/0x10
[   87.927124]  ? __pfx_kthread+0x10/0x10
[   87.927127]  ret_from_fork+0xf5/0x110
[   87.927132]  ? __pfx_kthread+0x10/0x10
[   87.927136]  ret_from_fork_asm+0x1a/0x30
[   87.927141]  </TASK>
[   87.927143] ---[ end trace 0000000000000000 ]---
=2E..
[   87.927717] BUG: kernel NULL pointer dereference, address: 0000000000000=
060
[   87.927722] #PF: supervisor read access in kernel mode
[   87.927726] #PF: error_code(0x0000) - not-present page
[   87.927730] PGD 0 P4D 0=20
[   87.927734] Oops: Oops: 0000 [#1] SMP NOPTI
[   87.927739] CPU: 9 UID: 0 PID: 518 Comm: kworker/u56:3 Tainted: G       =
 W           6.18.0-0.rc3.1.qubes.1.fc41.x86_64 #1 PREEMPT(full)=20
[   87.927746] Tainted: [W]=3DWARN
[   87.927749] Hardware name: Notebook V54x_6x_TU/V54x_6x_TU, BIOS Dasharo =
(coreboot+heads) v0.9.0 01/01/1970
[   87.927754] Workqueue: async async_run_entry_fn
[   87.927759] RIP: e030:mei_me_probe+0x27e/0x2b0 [mei_me]
[   87.927765] Code: 11 00 00 00 74 ac 4c 89 ef e8 8e 4f f4 bf eb a2 bb ed =
ff ff ff eb 9d 4c 89 e7 e8 8d fa 02 00 49 8b 84 24 18 11 00 00 4c 89 e7 <48=
> 8b 40 60 2e 2e 2e ff d0 8b bd c4 03 00 00 4c 89 e6 e8 eb 9f 41
[   87.927774] RSP: e02b:ffffc900412ebcc8 EFLAGS: 00010296
[   87.927778] RAX: 0000000000000000 RBX: 00000000ffffffed RCX: 000fffffffe=
00000
[   87.927783] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888103e=
54000
[   87.927787] RBP: ffff888101e79000 R08: ffffffffc1266ec8 R09: ffff8881109=
076e8
[   87.927792] R10: 0000000080040003 R11: 0000000000000000 R12: ffff888103e=
54000
[   87.927796] R13: ffff888101e790c8 R14: ffff888112253d40 R15: 00000000000=
00000
[   87.927805] FS:  0000000000000000(0000) GS:ffff888233238000(0000) knlGS:=
0000000000000000
[   87.927810] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
[   87.927814] CR2: 0000000000000060 CR3: 00000001088df000 CR4: 00000000000=
50660
[   87.927820] Call Trace:
[   87.927823]  <TASK>
[   87.927826]  local_pci_probe+0x45/0x90
[   87.927831]  pci_call_probe+0x5b/0x180
[   87.927835]  pci_device_probe+0x95/0x140
[   87.927839]  ? driver_sysfs_add+0x57/0xc0
[   87.927843]  really_probe+0xde/0x340
[   87.927847]  ? pm_runtime_barrier+0x54/0x90
[   87.927852]  __driver_probe_device+0x78/0x110
[   87.927858]  driver_probe_device+0x1f/0xa0
[   87.927862]  __driver_attach_async_helper+0x5e/0xe0
[   87.927867]  async_run_entry_fn+0x34/0x130
[   87.927872]  process_one_work+0x18d/0x340
[   87.927876]  worker_thread+0x256/0x3a0
[   87.927880]  ? __pfx_worker_thread+0x10/0x10
[   87.927884]  kthread+0xfc/0x240
[   87.927889]  ? __pfx_kthread+0x10/0x10
[   87.927893]  ? __pfx_kthread+0x10/0x10
[   87.927897]  ret_from_fork+0xf5/0x110
[   87.927901]  ? __pfx_kthread+0x10/0x10
[   87.927906]  ret_from_fork_asm+0x1a/0x30
[   87.927910]  </TASK>
[   87.927913] Modules linked in: intel_rapl_msr intel_powerclamp i2c_i801 =
intel_rapl_common snd pcspkr spi_intel_pci rfkill e1000e spi_intel processo=
r_thermal_wt_req i2c_smbus mei_me processor_thermal_power_floor soundcore m=
ei processor_thermal_mbox idma64 intel_pmc_core int340x_thermal_zone igen6_=
edac pmt_telemetry pmt_discovery pmt_class intel_hid sparse_keymap intel_pm=
c_ssram_telemetry intel_scu_pltdrv joydev fuse loop xenfs nfnetlink vsock_l=
oopback vmw_vsock_virtio_transport_common zram vmw_vsock_vmci_transport lz4=
hc_compress vsock vmw_vmci lz4_compress dm_thin_pool dm_persistent_data dm_=
bio_prison dm_crypt xe drm_ttm_helper drm_suballoc_helper gpu_sched drm_gpu=
vm drm_exec drm_gpusvm_helper nvme i915 nvme_core sdhci_pci sdhci_uhs2 i2c_=
algo_bit nvme_keyring drm_buddy sdhci intel_pmc_mux nvme_auth ttm cqhci typ=
ec xhci_pci hid_multitouch polyval_clmulni ghash_clmulni_intel mmc_core hkd=
f intel_vpu intel_vsec xhci_hcd drm_display_helper i2c_hid_acpi i2c_hid thu=
nderbolt video wmi pinctrl_meteorlake cec serio_raw
[   87.927957]  xen_acpi_processor xen_privcmd xen_pciback xen_blkback xen_=
gntalloc xen_gntdev xen_evtchn scsi_dh_rdac scsi_dh_emc scsi_dh_alua uinput=
 i2c_dev
[   87.928002] CR2: 0000000000000060
[   87.928006] ---[ end trace 0000000000000000 ]---

The ME initialization failure is expected - ME is either disabled via
firmware (the case above), or not directly visible at all (a VM). But
the panic ofc is not expected.

Full console log: https://openqa.qubes-os.org/tests/158203/logfile?filename=
=3Dserial0.txt
Some more examples in this issue (but all look pretty similar):
https://github.com/QubesOS/qubes-issues/issues/10378

#regzbot introduced: v6.17.4..v6.18-rc3

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--SstVD4tUIWzgfLQp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmkG2AEACgkQ24/THMrX
1yzGigf9GIns3jw9uMIZuGTnJMFHIAQP0VZwg1MpGmGe2QC8F3h+VjsxiyxR/Fsx
1D5tjMuFRzx24XaLVlyaEpAf6fK2P4Fq2PO6DBvxrVTXkFfqa/ChNr0VwOGhdTRE
Sw5ZLTNqbBIAnwt3VFaa4HRidwzHXfJOeaY2N+VaIkjoIHCH/qNU+NXldTF4r2pA
eQzebzAeNuEdeqXut8FZvZ8cTfdURpeIkqRW3Om6gyVbCdmUxFB0IV3Q7iIZP1fo
8XZbAJ0L3Jrz70adpTLCezrSpniI79FIN/Rndiz2wBUDxFLDbaIiLjWmQhmKf7BE
bjbM7a0Lf4BzPg72qPffJOzoFFUY0Q==
=jPDf
-----END PGP SIGNATURE-----

--SstVD4tUIWzgfLQp--

