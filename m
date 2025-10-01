Return-Path: <linux-kernel+bounces-839605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A1ABB1FE1
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685681922573
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9880228C849;
	Wed,  1 Oct 2025 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="C0Njy6y7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rL3OqkXt"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4F26CE0A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357699; cv=none; b=KVcn32zZcKo5AzcE+Zgr0egHZBo9bkc9nW40BSn+DUPk2GHMFeiK0WsqvNPmcp2n8t7TWqEjF8hLht0hoyUqS8v02kfQwbrTjfipscN75VzqYLsl98K6eA+4yw6ys348wa64xLabRQpgUzcHxDbQ+AT27GWkZCGO4Rz+Rn1nOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357699; c=relaxed/simple;
	bh=xzbU5u6r422cb6a6RH4zZYc2W0r6coUA0uWmw0K2Fa0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uQOy2EXPp23zJvrsnI41oRQvjkwCdSKIDcNdCS7bfA23nqiRRv2pb55GbJ442pEIozSrygnlmGJdvnyXbnyK66LkRwyj9FFsHVup6QLMtQUu989kl/dbNTXBbcyY7NOTbRH1SvLAVhjvvoXU6AMUd/CTWfpgCaOhrfQVPnvjpBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=C0Njy6y7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rL3OqkXt; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA4B21400227;
	Wed,  1 Oct 2025 18:28:16 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 01 Oct 2025 18:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759357696;
	 x=1759444096; bh=Ra8D/sOtgvsEKGJ/X+JGe1F+fv2gRA9NpTbnIDU2wcU=; b=
	C0Njy6y7MT6juFEltikVEpv6UjK80/Td/l8BR0Yhe7yZlPyB3//0pqPGfuE4fhS7
	FyEopkeAtL8M/xHc3zdqMu7EL4AiY5SoPdh4Lx9U077GcufBN0RLoV5V7kZFBWQv
	Yxl8m6ig6wCEg5iQoZqNHOb6XUh2hEot+Z62GXz61+cL+Z5xKptNeN3x6J0vPSng
	SliFpguziUcssFucPkLkgYmN8Du7qzJUc4KHRQ//AfkjlLYrddTuMshSvVLDutPC
	PmT51lNBD6BAX76hm+cyNgFM6xSMVu5Yf40RknKfi0we36Tpvx6trBoj3D3gwEkv
	AMO+9s4kHixEkTqyPplorA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759357696; x=
	1759444096; bh=Ra8D/sOtgvsEKGJ/X+JGe1F+fv2gRA9NpTbnIDU2wcU=; b=r
	L3OqkXtSwGLOxIGNbF1+SKN7TI4xy3pJZW1Iw9NF/QOwR49QEj6X1c9+E4rIuOdd
	3vCTxIWykZ6qGCegQL2AAvlPRATf0268rYRgBX22ezZRx86JlnilR3xWbNKq89lP
	HcqQTBd5yuX+s2uyPCyZxFthKVBAYmxJLfC7YxI6i5rz6c052ytJylEH5Dyalyf+
	o/MuNGlIkbB8sAQl06I3EMXM2mm0cN0f3FxV1sH2O+dalaksIp69i6rm83kvvNtq
	w2sovFrEcl+i2K+x7c9m33CqK+y7VYuUeeV7SMfjrC2WTDNz+a96pp2nSbt2eFGK
	gfkNhN+uxPD7MCWRPZQYw==
X-ME-Sender: <xms:AKvdaHZmv7eEoVmJb41IvhwRB13BJlqgKS87gyR8tC082lHEAWyD5g>
    <xme:AKvdaBN449a3jjeLOFnlaW0qU9a36ZZGYMw3cf9SYv76Z5uwkiktQDkdVyplEcn2H
    PlhLK_woRL0CoxT0IH2mEKhc7RW7SY7cl-7ZS0LjrCWIxFcgEwIaIbh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekgeefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeeivddvkefftdegjedtgffftddtheevjeelueekhefflefhgfetgeeiledtffetheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhpvghnghhuthhrohhnihigrdguvgdpgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlh
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhr
    ihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshhotg
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AKvdaPH2JjdWDG6rjxrGn7w7s1zxI9j-wvbPCQeyX1FNzEwjvQjyog>
    <xmx:AKvdaFoajQWY2nfvRpTQOrT4ai8777r7RByxWc0lSclTf0K20IyZ-g>
    <xmx:AKvdaIbjLuDEFDk6qv8Qn3raoYKn8bIL2icQDkdBh6mO3Ku9oj3o6g>
    <xmx:AKvdaOViGRdRDaUadezYac1uxyvfFlcgamkyTq7Gv3KzRIXxfsj0gQ>
    <xmx:AKvdaOzrL0nH9muRsGr91MsxTOhCBoXWkLIkZxwbdxzqUll7hWsgXOfs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7793E700069; Wed,  1 Oct 2025 18:28:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AjqV-Bcf-9VR
Date: Thu, 02 Oct 2025 00:27:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, soc@lists.linux.dev
Message-Id: <b94bf376-2653-4726-bc51-9c608f55fff4@app.fastmail.com>
In-Reply-To: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
References: <54b49f7b-9232-44d7-9ae3-ecc1826f17d7@app.fastmail.com>
Subject: [GIT PULL 4/5] soc: driver updates for 6.18
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following changes since commit b320789d6883cc00ac78ce83bccbfe7ed58af=
cf0:

  Linux 6.17-rc4 (2025-08-31 15:33:07 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-d=
rivers-6.18

for you to fetch changes up to c4ebd661282df563a0c83acacbc35cfd4d8da541:

  Merge tag 'riscv-cache-for-v6.18' of https://git.kernel.org/pub/scm/li=
nux/kernel/git/conor/linux into soc/drivers (2025-09-24 23:17:23 +0200)

----------------------------------------------------------------
soc: driver updates for 6.18

Lots of platform specific updates for Qualcomm SoCs, including a
new TEE subsystem driver for the Qualcomm QTEE firmware interface.

Added support for the Apple A11 SoC in drivers that are shared with the
M1/M2 series, among more updates for those.

Smaller platform specific driver updates for Renesas, ASpeed, Broadcom,
Nvidia, Mediatek, Amlogic, TI, Allwinner, and Freescale SoCs.

Driver updates in the cache controller, memory controller and reset
controller subsystems.

SCMI firmware updates to add more features and improve robustness.
This includes support for having multiple SCMI providers in a single
system.

TEE subsystem support for protected DMA-bufs, allowing hardware to
access memory areas that managed by the kernel but remain inaccessible
from the CPU in EL1/EL0.

----------------------------------------------------------------
Aaron Kling (3):
      dt-bindings: memory: tegra210: emc: Document OPP table and interco=
nnect
      dt-bindings: memory: tegra210: Add memory client IDs
      memory: tegra210: Use bindings for client ids

Akhilesh Patil (2):
      drivers: tee: improve sysfs interface by using sysfs_emit()
      drivers: firmware: bcm47xx_sprom: fix spelling

Amirreza Zarrabi (11):
      firmware: qcom: tzmem: export shm_bridge create/delete
      firmware: qcom: scm: add support for object invocation
      tee: allow a driver to allocate a tee_device without a pool
      tee: add close_context to TEE driver operation
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      tee: increase TEE_MAX_ARG_SIZE to 4096
      tee: add Qualcomm TEE driver
      tee: qcom: add primordial object
      tee: qcom: enable TEE_IOC_SHM_ALLOC ioctl
      Documentation: tee: Add Qualcomm TEE driver

Andrea della Porta (2):
      dt-bindings: clock: rp1: Add missing MIPI DSI defines
      clk: rp1: Implement remaining clock tree

Arnd Bergmann (25):
      Merge tag 'aspeed-6.18-drivers-0' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/bmc/linux into soc/drivers
      Merge tag 'renesas-drivers-for-v6.18-tag1' of https://git.kernel.o=
rg/pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'reset-for-v6.18' of https://git.pengutronix.de/git/pza/=
linux into soc/drivers
      Merge tag 'arm-soc/for-6.18/drivers' of https://github.com/Broadco=
m/stblinux into soc/drivers
      Merge tag 'qcom-drivers-for-6.18' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'hisi-drivers-for-6.18' of https://github.com/hisilicon/=
linux-hisi into soc/drivers
      Merge tag 'tee-improve-sysfs-for-v6.18' of git://git.kernel.org/pu=
b/scm/linux/kernel/git/jenswi/linux-tee into soc/drivers
      Merge tag 'tee-sha1-lib-for-v6.18' of git://git.kernel.org/pub/scm=
/linux/kernel/git/jenswi/linux-tee into soc/drivers
      Merge tag 'tee-prot-dma-buf-for-v6.18' of git://git.kernel.org/pub=
/scm/linux/kernel/git/jenswi/linux-tee into soc/drivers
      Merge tag 'renesas-drivers-for-v6.18-tag2' of git://git.kernel.org=
/pub/scm/linux/kernel/git/geert/renesas-devel into soc/drivers
      Merge tag 'samsung-drivers-6.18' of https://git.kernel.org/pub/scm=
/linux/kernel/git/krzk/linux into soc/drivers
      Merge tag 'tegra-for-6.18-soc' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/tegra/linux into soc/drivers
      Merge tag 'scmi-updates-6.18' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/sudeep.holla/linux into soc/drivers
      Merge tag 'microchip-soc-6.18' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/at91/linux into soc/drivers
      Merge tag 'v6.17-next-soc' of https://git.kernel.org/pub/scm/linux=
/kernel/git/mediatek/linux into soc/drivers
      Merge tag 'qcom-drivers-for-6.18-2' of https://git.kernel.org/pub/=
scm/linux/kernel/git/qcom/linux into soc/drivers
      Merge tag 'apple-soc-drivers-6.18' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/sven/linux into soc/drivers
      Merge tag 'amlogic-drivers-for-v6.18' of https://git.kernel.org/pu=
b/scm/linux/kernel/git/amlogic/linux into soc/drivers
      Merge tag 'ti-driver-soc-for-v6.18' of https://git.kernel.org/pub/=
scm/linux/kernel/git/ti/linux into soc/drivers
      Merge tag 'sunxi-drivers-for-6.18' of https://git.kernel.org/pub/s=
cm/linux/kernel/git/sunxi/linux into soc/drivers
      Merge tag 'memory-controller-drv-6.18' of https://git.kernel.org/p=
ub/scm/linux/kernel/git/krzk/linux-mem-ctrl into soc/drivers
      Merge tag 'tee-qcomtee-for-v6.18' of git://git.kernel.org/pub/scm/=
linux/kernel/git/jenswi/linux-tee into soc/drivers
      Merge tag 'tee-shm-register-fix-for-v6.17' of git://git.kernel.org=
/pub/scm/linux/kernel/git/jenswi/linux-tee into soc/drivers
      Merge tag 'soc_fsl-6.18-1' of https://github.com/chleroy/linux int=
o soc/drivers
      Merge tag 'riscv-cache-for-v6.18' of https://git.kernel.org/pub/sc=
m/linux/kernel/git/conor/linux into soc/drivers

Barnab=C3=A1s Cz=C3=A9m=C3=A1n (1):
      dt-bindings: firmware: qcom,scm: Add MSM8937

Bjorn Andersson (1):
      Merge branch '20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-2=
-17f07a942b8d@oss.qualcomm.com' into drivers-for-6.18

Brian Masney (1):
      clk: rp1: convert from round_rate() to determine_rate()

Bryan Brattlof (1):
      soc: ti: k3-socinfo: Add information for AM62L SR1.1

Chelsy Ratnawat (1):
      bus: fsl-mc: Replace snprintf and sprintf with sysfs_emit in sysfs=
 show functions

Chen-Yu Tsai (2):
      soc: sunxi: sram: add entry for a523
      soc: sunxi: sram: register regmap as syscon

Christophe JAILLET (2):
      firmware: arm_scmi: Constify struct scmi_voltage_proto_ops
      firmware: arm_scmi: Constify struct scmi_transport_ops

Christophe Leroy (2):
      soc: fsl: qe: Change GPIO driver to a proper platform driver
      soc: fsl: qe: Drop legacy-of-mm-gpiochip.h header from GPIO driver

Colin Ian King (1):
      soc: hisilicon: kunpeng_hccs: Fix spelling mistake "decrese" -> "d=
ecrease"

Conor Dooley (1):
      dt-bindings: cache: ax45mp: add 2048 as a supported cache-sets val=
ue

Duy Nguyen (1):
      soc: renesas: Identify R-Car X5H

Eric Biggers (1):
      tee: Use SHA-1 library instead of crypto_shash

Etienne Carriere (1):
      tee: new ioctl to a register tee_shm from a dmabuf file descriptor

Florian Fainelli (1):
      dt-bindings: memory: Update brcmstb-memc-ddr binding with older ch=
ips

Fushuai Wang (1):
      soc/fsl/qbman: Use for_each_online_cpu() instead of for_each_cpu()

Icenowy Zheng (2):
      dt-bindings: reset: thead,th1520-reset: add more VOSYS resets
      reset: th1520: add resets for display pipeline

Ivaylo Ivanov (1):
      dt-bindings: soc: samsung: usi: add samsung,exynos2200-usi compati=
ble

Janne Grunau (23):
      dt-bindings: arm: apple: apple,pmgr: Add t6020-pmgr compatible
      dt-bindings: power: apple,pmgr-pwrstate: Add t6020 compatible
      dt-bindings: cpufreq: apple,cluster-cpufreq: Add t6020 compatible
      dt-bindings: interrupt-controller: apple,aic2: Add apple,t6020-aic=
 compatible
      dt-bindings: iommu: dart: Add apple,t6020-dart compatible
      dt-bindings: pinctrl: apple,pinctrl: Add apple,t6020-pinctrl compa=
tible
      dt-bindings: mailbox: apple,mailbox: Add t6020 compatible
      dt-bindings: gpu: apple,agx: Add agx-{g14s,g14c,g14d} compatibles
      dt-bindings: iommu: apple,sart: Add apple,t6020-sart compatible
      dt-bindings: nvme: apple: Add apple,t6020-nvme-ans2 compatible
      dt-bindings: net: bcm4377-bluetooth: Add BCM4388 compatible
      dt-bindings: net: bcm4329-fmac: Add BCM4388 PCI compatible
      dt-bindings: mfd: apple,smc: Add t6020-smc compatible
      dt-bindings: spmi: apple,spmi: Add t6020-spmi compatible
      dt-bindings: watchdog: apple,wdt: Add t6020-wdt compatible
      dt-bindings: clock: apple,nco: Add t6020-nco compatible
      dt-bindings: dma: apple,admac: Add t6020-admac compatible
      ASoC: dt-bindings: apple,mca: Add t6020-mca compatible
      spi: dt-bindings: apple,spi: Add t6020-spi compatible
      pinctrl: apple: Add "apple,t8103-pinctrl" as compatible
      ASoC: apple: mca: Add "apple,t8103-mca" compatible
      spi: apple: Add "apple,t8103-spi" compatible
      pmdomain: apple: Add "apple,t8103-pmgr-pwrstate"

Jens Glathe (1):
      firmware: qcom: scm: Allow QSEECOM on Lenovo Thinkbook 16

Jens Reidel (1):
      soc: qcom: smem: Fix endian-unaware access of num_entries

Jens Wiklander (10):
      optee: sync secure world ABI headers
      dma-buf: dma-heap: export declared functions
      tee: implement protected DMA-heap
      tee: refactor params_from_user()
      tee: add tee_shm_alloc_dma_mem()
      optee: support protected memory allocation
      optee: FF-A: dynamic protected memory allocation
      optee: smc abi: dynamic protected memory allocation
      Merge branch '20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-2=
-17f07a942b8d@oss.qualcomm.com' of https://git.kernel.org/pub/scm/linux/=
kernel/git/qcom/linux
      tee: fix register_shm_helper()

Johan Hovold (5):
      firmware: arm_scmi: quirk: Prevent writes to string constants
      firmware: meson_sm: fix device leak at probe
      firmware: firmware: meson-sm: fix compile-test default
      soc: mediatek: mtk-svs: fix device leaks on mt8183 probe failure
      soc: mediatek: mtk-svs: fix device leaks on mt8192 probe failure

John Madieu (1):
      soc: renesas: rz-sysc: Add syscon/regmap support

Junnan Wu (1):
      firmware: arm_scmi: Mark VirtIO ready before registering scmi_virt=
io_driver

Kathiravan Thirumoorthy (1):
      dt-bindings: sram: qcom,imem: Document IPQ5424 compatible

Kendall Willis (1):
      firmware: ti_sci: Enable abort handling of entry to LPM

Krzysztof Kozlowski (2):
      soc: qcom: icc-bwmon: Fix handling dev_pm_opp_find_bw_*() errors
      firmware: arm_scmi: Simplify printks with pOF format

Kyle Hendry (2):
      dt-bindings: reset: add compatible for bcm63xx ephy control
      reset: bcm6345: add support for bcm63xx ephy control register

Luca Weiss (1):
      dt-bindings: soc: qcom,rpmh-rsc: Remove double colon from descript=
ion

Mukesh Ojha (4):
      firmware: qcom: scm: preserve assign_mem() error return value
      soc: qcom: mdt_loader: Remove unused parameter
      soc: qcom: mdt_loader: Remove pas id parameter
      soc: qcom: mdt_loader: Remove unused parameter

Nick Chan (8):
      dt-bindings: mailbox: apple,mailbox: Add ASC mailboxes on Apple A1=
1 and T2
      soc: apple: mailbox: Add Apple A11 and T2 mailbox support
      dt-bindings: iommu: apple,sart: Add Apple A11
      soc: apple: sart: Make allow flags SART version dependent
      soc: apple: sart: Add SARTv0 support
      dt-bindings: nvme: apple,nvme-ans: Add Apple A11
      nvme: apple: Add Apple A11 support
      dt-bindings: spmi: Add Apple A11 and T2 compatible

Nikita Travkin (1):
      firmware: qcom: tzmem: disable sc7180 platform

Nikunj Kela (1):
      dt-bindings: firmware: arm,scmi: Allow multiple instances

Patrice Chotard (1):
      memory: stm32_omm: Fix req2ack update test

Peng Fan (5):
      firmware: arm_scmi: Fix function name typo in scmi_perf_proto_ops =
struct
      firmware: arm_scmi: imx: Add documentation for MISC_BOARD_INFO
      firmware: arm_scmi: imx: Discover MISC build info from the system =
manager
      firmware: arm_scmi: imx: Support retrieving MISC protocol configur=
ation info
      firmware: arm_scmi: imx: Discover MISC board info from the system =
manager

Peter Griffin (1):
      soc: samsung: exynos-pmu: Enable CPU Idle for gs101

Philipp Zabel (1):
      MAINTAINERS: Use https:// protocol for Reset Controller Framework =
tree

Prasad Kumpatla (1):
      soc: qcom: pd-mapper: Add SM8750 compatible

Qianfeng Rong (1):
      soc: qcom: use devm_kcalloc() for array space allocation

Rob Herring (Arm) (1):
      soc: aspeed: Use of_reserved_mem_region_to_resource() for "memory-=
region"

Robert Marko (8):
      arm64: Add config for Microchip SoC platforms
      arm64: lan969x: Add support for Microchip LAN969x SoC
      mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
      tty: serial: atmel: make it selectable for ARCH_MICROCHIP
      spi: atmel: make it selectable for ARCH_MICROCHIP
      i2c: at91: make it selectable for ARCH_MICROCHIP
      char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
      crypto: atmel-aes: make it selectable for ARCH_MICROCHIP

Ryan Chen (2):
      soc: aspeed: socinfo: Add AST27xx silicon IDs
      reset: aspeed: register AST2700 reset auxiliary bus device

Salah Triki (1):
      bus: fsl-mc: Check return value of platform_get_resource()

Samuel Holland (1):
      cache: sifive_ccache: Optimize cache flushes

Sneh Mankad (1):
      soc: qcom: rpmh-rsc: Unconditionally clear _TRIGGER bit for TCS

Sven Peter (1):
      soc: apple: Drop default ARCH_APPLE in Kconfig

Svyatoslav Ryhel (1):
      soc/tegra: fuse: Add Tegra114 nvmem cells and fuse lookups

Thomas Wei=C3=9Fschuh (1):
      soc: ti: pruss: don't use %pK through printk

Tudor Ambarus (1):
      firmware: exynos-acpm: fix PMIC returned errno

Val Packett (1):
      firmware: qcom: scm: Allow QSEECOM on Dell Inspiron 7441 / Latitud=
e 7455

Viken Dadhaniya (6):
      dt-bindings: qcom: se-common: Add QUP Peripheral-specific properti=
es for I2C, SPI, and SERIAL bus
      soc: qcom: geni-se: Cleanup register defines and update copyright
      soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux =
subsystem
      i2c: qcom-geni: Load i2c qup Firmware from linux side
      spi: geni-qcom: Load spi qup Firmware from linux side
      serial: qcom-geni: Load UART qup Firmware from linux side

Wolfram Sang (2):
      soc: remove unneeded 'fast_io' parameter in regmap_config
      reset: remove unneeded 'fast_io' parameter in regmap_config

Yijie Yang (1):
      firmware: qcom: scm: Allow QSEECOM on HAMOA-IOT-EVK

Zhen Ni (1):
      memory: samsung: exynos-srom: Fix of_iomap leak in exynos_srom_pro=
be

 .../devicetree/bindings/arm/apple/apple,pmgr.yaml  |   33 +-
 .../bindings/cache/andestech,ax45mp-cache.yaml     |    6 +-
 .../devicetree/bindings/clock/apple,nco.yaml       |   17 +-
 .../bindings/cpufreq/apple,cluster-cpufreq.yaml    |    3 +
 .../devicetree/bindings/dma/apple,admac.yaml       |   17 +-
 .../devicetree/bindings/firmware/arm,scmi.yaml     |    2 +-
 .../devicetree/bindings/firmware/qcom,scm.yaml     |    3 +
 .../devicetree/bindings/gpu/apple,agx.yaml         |    6 +
 .../bindings/i2c/qcom,i2c-geni-qcom.yaml           |    1 +
 .../bindings/interrupt-controller/apple,aic2.yaml  |    1 +
 .../devicetree/bindings/iommu/apple,dart.yaml      |   14 +-
 .../devicetree/bindings/iommu/apple,sart.yaml      |    5 +-
 .../devicetree/bindings/mailbox/apple,mailbox.yaml |    8 +
 .../memory-controllers/brcm,brcmstb-memc-ddr.yaml  |    4 +
 .../memory-controllers/nvidia,tegra210-emc.yaml    |   11 +
 .../devicetree/bindings/mfd/apple,smc.yaml         |   17 +-
 .../net/bluetooth/brcm,bcm4377-bluetooth.yaml      |    1 +
 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    1 +
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |   30 +-
 .../devicetree/bindings/pinctrl/apple,pinctrl.yaml |   27 +-
 .../bindings/power/apple,pmgr-pwrstate.yaml        |   27 +-
 .../bindings/reset/brcm,bcm6345-reset.yaml         |    4 +-
 .../bindings/serial/qcom,serial-geni-qcom.yaml     |    1 +
 .../bindings/soc/qcom/qcom,rpmh-rsc.yaml           |    2 +-
 .../bindings/soc/qcom/qcom,se-common-props.yaml    |   26 +
 .../bindings/soc/samsung/exynos-usi.yaml           |    1 +
 .../devicetree/bindings/sound/apple,mca.yaml       |   17 +-
 .../devicetree/bindings/spi/apple,spi.yaml         |   16 +-
 .../bindings/spi/qcom,spi-geni-qcom.yaml           |    1 +
 .../devicetree/bindings/spmi/apple,spmi.yaml       |   20 +-
 .../devicetree/bindings/sram/qcom,imem.yaml        |    1 +
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |   27 +-
 Documentation/tee/index.rst                        |    1 +
 Documentation/tee/qtee.rst                         |   96 ++
 MAINTAINERS                                        |    9 +-
 arch/arm64/Kconfig.platforms                       |   51 +-
 arch/powerpc/platforms/Kconfig                     |    1 -
 drivers/bus/fsl-mc/fsl-mc-bus.c                    |    9 +-
 drivers/cache/sifive_ccache.c                      |    8 +-
 drivers/char/hw_random/Kconfig                     |    2 +-
 drivers/clk/clk-rp1.c                              | 1222 +++++++++++++=
+++++--
 drivers/crypto/Kconfig                             |    2 +-
 drivers/dma-buf/dma-heap.c                         |    4 +
 drivers/firmware/arm_scmi/bus.c                    |   13 +-
 drivers/firmware/arm_scmi/quirks.c                 |   15 +-
 drivers/firmware/arm_scmi/transports/mailbox.c     |    7 +-
 drivers/firmware/arm_scmi/transports/optee.c       |    2 +-
 drivers/firmware/arm_scmi/transports/virtio.c      |    3 +
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    |  111 ++
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst    |   25 +
 drivers/firmware/arm_scmi/voltage.c                |    2 +-
 drivers/firmware/broadcom/bcm47xx_sprom.c          |    2 +-
 drivers/firmware/meson/Kconfig                     |    2 +-
 drivers/firmware/meson/meson_sm.c                  |    7 +-
 drivers/firmware/qcom/qcom_scm.c                   |  125 +-
 drivers/firmware/qcom/qcom_scm.h                   |    7 +
 drivers/firmware/qcom/qcom_tzmem.c                 |   64 +-
 drivers/firmware/samsung/exynos-acpm-pmic.c        |   25 +-
 drivers/firmware/ti_sci.c                          |   57 +-
 drivers/firmware/ti_sci.h                          |    3 +
 drivers/i2c/busses/Kconfig                         |    2 +-
 drivers/i2c/busses/i2c-qcom-geni.c                 |    8 +-
 drivers/media/platform/qcom/venus/firmware.c       |    4 +-
 drivers/memory/samsung/exynos-srom.c               |   10 +-
 drivers/memory/stm32_omm.c                         |    2 +-
 drivers/memory/tegra/tegra210.c                    |  146 +--
 drivers/mfd/Kconfig                                |    2 +-
 drivers/net/wireless/ath/ath12k/ahb.c              |    2 +-
 drivers/nvme/host/apple.c                          |  197 +++-
 drivers/pinctrl/pinctrl-apple-gpio.c               |    1 +
 drivers/pmdomain/apple/pmgr-pwrstate.c             |    1 +
 drivers/remoteproc/qcom_q6v5_adsp.c                |    2 +-
 drivers/remoteproc/qcom_q6v5_pas.c                 |    7 +-
 drivers/remoteproc/qcom_q6v5_wcss.c                |    2 +-
 drivers/reset/Kconfig                              |    7 +
 drivers/reset/Makefile                             |    1 +
 drivers/reset/reset-aspeed.c                       |  253 ++++
 drivers/reset/reset-bcm6345.c                      |    1 +
 drivers/reset/reset-intel-gw.c                     |    1 -
 drivers/reset/reset-qcom-pdc.c                     |    1 -
 drivers/reset/reset-th1520.c                       |   41 +-
 drivers/soc/apple/Kconfig                          |    3 -
 drivers/soc/apple/mailbox.c                        |   19 +
 drivers/soc/apple/sart.c                           |   60 +-
 drivers/soc/aspeed/aspeed-lpc-ctrl.c               |   14 +-
 drivers/soc/aspeed/aspeed-p2a-ctrl.c               |   14 +-
 drivers/soc/aspeed/aspeed-socinfo.c                |    4 +
 drivers/soc/fsl/qbman/qman_test_stash.c            |    2 +-
 drivers/soc/fsl/qe/gpio.c                          |  139 ++-
 drivers/soc/hisilicon/kunpeng_hccs.c               |    2 +-
 drivers/soc/mediatek/mtk-svs.c                     |   23 +
 drivers/soc/qcom/icc-bwmon.c                       |    3 +
 drivers/soc/qcom/llcc-qcom.c                       |    1 -
 drivers/soc/qcom/mdt_loader.c                      |   20 +-
 drivers/soc/qcom/qcom-geni-se.c                    |  506 +++++++-
 drivers/soc/qcom/qcom_pd_mapper.c                  |    1 +
 drivers/soc/qcom/ramp_controller.c                 |    1 -
 drivers/soc/qcom/rpm_master_stats.c                |    2 +-
 drivers/soc/qcom/rpmh-rsc.c                        |    7 +-
 drivers/soc/qcom/smem.c                            |    2 +-
 drivers/soc/renesas/Kconfig                        |   13 +
 drivers/soc/renesas/r9a08g045-sysc.c               |    1 +
 drivers/soc/renesas/r9a09g047-sys.c                |    1 +
 drivers/soc/renesas/r9a09g057-sys.c                |    1 +
 drivers/soc/renesas/renesas-soc.c                  |   12 +
 drivers/soc/renesas/rz-sysc.c                      |   30 +-
 drivers/soc/renesas/rz-sysc.h                      |    2 +
 drivers/soc/samsung/exynos-pmu.c                   |  276 ++++-
 drivers/soc/sunxi/sunxi_sram.c                     |   14 +
 drivers/soc/tegra/fuse/fuse-tegra30.c              |  122 ++
 drivers/soc/ti/k3-socinfo.c                        |   10 +
 drivers/soc/ti/pruss.c                             |    2 +-
 drivers/spi/Kconfig                                |    2 +-
 drivers/spi/spi-apple.c                            |    1 +
 drivers/spi/spi-geni-qcom.c                        |    6 +
 drivers/tee/Kconfig                                |    9 +-
 drivers/tee/Makefile                               |    2 +
 drivers/tee/optee/Kconfig                          |    5 +
 drivers/tee/optee/Makefile                         |    1 +
 drivers/tee/optee/core.c                           |    9 +-
 drivers/tee/optee/ffa_abi.c                        |  146 ++-
 drivers/tee/optee/optee_ffa.h                      |   27 +-
 drivers/tee/optee/optee_msg.h                      |   84 +-
 drivers/tee/optee/optee_private.h                  |   15 +-
 drivers/tee/optee/optee_smc.h                      |   37 +-
 drivers/tee/optee/protmem.c                        |  335 ++++++
 drivers/tee/optee/smc_abi.c                        |  141 ++-
 drivers/tee/qcomtee/Kconfig                        |   12 +
 drivers/tee/qcomtee/Makefile                       |    9 +
 drivers/tee/qcomtee/async.c                        |  182 +++
 drivers/tee/qcomtee/call.c                         |  820 +++++++++++++
 drivers/tee/qcomtee/core.c                         |  915 +++++++++++++=
++
 drivers/tee/qcomtee/mem_obj.c                      |  169 +++
 drivers/tee/qcomtee/primordial_obj.c               |  113 ++
 drivers/tee/qcomtee/qcomtee.h                      |  185 +++
 drivers/tee/qcomtee/qcomtee_msg.h                  |  304 +++++
 drivers/tee/qcomtee/qcomtee_object.h               |  316 +++++
 drivers/tee/qcomtee/shm.c                          |  150 +++
 drivers/tee/qcomtee/user_obj.c                     |  692 +++++++++++
 drivers/tee/tee_core.c                             |  342 ++++--
 drivers/tee/tee_heap.c                             |  500 ++++++++
 drivers/tee/tee_private.h                          |   20 +-
 drivers/tee/tee_shm.c                              |  165 ++-
 drivers/tty/serial/Kconfig                         |    2 +-
 drivers/tty/serial/qcom_geni_serial.c              |    8 +-
 include/dt-bindings/clock/raspberrypi,rp1-clocks.h |    4 +
 include/dt-bindings/memory/tegra210-mc.h           |   74 ++
 include/dt-bindings/reset/thead,th1520-reset.h     |    7 +
 include/linux/firmware/qcom/qcom_scm.h             |    6 +
 include/linux/firmware/qcom/qcom_tzmem.h           |   15 +
 include/linux/scmi_protocol.h                      |    2 +-
 include/linux/soc/qcom/geni-se.h                   |    4 +
 include/linux/soc/qcom/mdt_loader.h                |    7 +-
 include/linux/tee_core.h                           |  113 +-
 include/linux/tee_drv.h                            |   22 +
 include/uapi/linux/tee.h                           |   87 +-
 sound/soc/apple/mca.c                              |    1 +
 157 files changed, 9538 insertions(+), 751 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,se-c=
ommon-props.yaml
 create mode 100644 Documentation/tee/qtee.rst
 create mode 100644 drivers/reset/reset-aspeed.c
 create mode 100644 drivers/tee/optee/protmem.c
 create mode 100644 drivers/tee/qcomtee/Kconfig
 create mode 100644 drivers/tee/qcomtee/Makefile
 create mode 100644 drivers/tee/qcomtee/async.c
 create mode 100644 drivers/tee/qcomtee/call.c
 create mode 100644 drivers/tee/qcomtee/core.c
 create mode 100644 drivers/tee/qcomtee/mem_obj.c
 create mode 100644 drivers/tee/qcomtee/primordial_obj.c
 create mode 100644 drivers/tee/qcomtee/qcomtee.h
 create mode 100644 drivers/tee/qcomtee/qcomtee_msg.h
 create mode 100644 drivers/tee/qcomtee/qcomtee_object.h
 create mode 100644 drivers/tee/qcomtee/shm.c
 create mode 100644 drivers/tee/qcomtee/user_obj.c
 create mode 100644 drivers/tee/tee_heap.c

