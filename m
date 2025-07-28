Return-Path: <linux-kernel+bounces-748356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 187F1B14014
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0750917DE43
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EE22750F1;
	Mon, 28 Jul 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLZhJaus"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2427511E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753719529; cv=none; b=uQZ/aIZ8KHluldQKLJAoDhSZMghfB2F9U4QZddtfK4eQV0a3LSiV5d804Ea4EesHkAg2Z5+avzp5/6eq7WS3BXUJvDtzPzOW9kpBnfI4EAHZ6gEEmsgw15llcZBrgZePg2BpV2n2dKD1h3rIlL1AuM74pjR23bNaM9/yiy132b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753719529; c=relaxed/simple;
	bh=ephH6JRKJ/LV4k0LL+jduB0UWZSYH4UCk06AZ7FQyvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRZYRKa71sYP3BAlRCCCZR6jPEgTHoDOvU+oE6UPTD1/Af1oLNlOwmphKN8XSk6KEKp/208+PPjTLnrNyTFjaGD3hUaAncLKaHvCptYN1D2+pQYGZ6zePAtJgn6QAoYXO7P0pOBtvcrS5Xj6Nutc+TkTgrZ1fP9ydfLlOJxQfcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLZhJaus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8337C4CEF7;
	Mon, 28 Jul 2025 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753719529;
	bh=ephH6JRKJ/LV4k0LL+jduB0UWZSYH4UCk06AZ7FQyvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LLZhJausciaJODqlG9Jj2dfzm0Ys1dn2lItiA+JG7j6wveBw64AmoG0Vc2QZfCUEL
	 REOabckQxFdR/NgZDhxl5W19gfyU6GG6krhmfJve3i6Lk02tgT+ILJ8LzTOT0Yl/uB
	 ryxl1qvVyIteB2Q7WG06nsbJuiBkQzLaI9cfq4J2emaX5MdFjEzLRGEwv/JD9WZ1My
	 9HnRG7AgUYX4crBfbp2bcesGC4BJhVesyiG9KGg6q0KLzl8r0HgJS4CnyOaW9+Zedw
	 HVMbY9eltY0L20vzXZimA89q4NvGS8ahLCqahOSAwMMvjifwylO5BWiNeRJgkIfjlj
	 DhJ6EESmxns5A==
Date: Mon, 28 Jul 2025 17:18:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] coresight: Appropriately disable programming
 clocks
Message-ID: <49438224-fed7-4009-9865-c91b38d4214a@sirena.org.uk>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7e/I2qI4FRkfCUIf"
Content-Disposition: inline
In-Reply-To: <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
X-Cookie: Do not exceed recommended dosage.


--7e/I2qI4FRkfCUIf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 04:22:34PM +0100, Leo Yan wrote:
> Some CoreSight components have programming clocks (pclk) and are enabled
> using clk_get() and clk_prepare_enable().  However, in many cases, these
> clocks are not disabled when modules exit and only released by clk_put().

This patch, which is in -next as ce15ee28bdddc49d18c4e296859456b819cf0690,
appears to cause the funnel device to stop probing on the i.MX8MP based
Verdin module, I also have the i.MX8MP-EVK but that has potentially
separate boot issues.  The device fails to probe with:

[   15.080552] coresight-funnel funnel: probe with driver coresight-funnel =
failed with error -2

and a bisect identifies this commit as the cuplprit.  Full log at:

   https://lava.sirena.org.uk/scheduler/job/1612972#L1661

bisect log:

# bad: [0b90c3b6d76ea512dc3dac8fb30215e175b0019a] Add linux-next specific f=
iles for 20250728
# good: [60a48532c31d9d652a1e3a92ff7d620ff4545e8c] Merge branch 'tip/urgent=
' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
# good: [2d442a0c781403702de27ccfbc4bb233721585f5] spi: SPISG: Fix less tha=
n zero comparison on a u32 variable
# good: [e95122a32e777309412e30dc638dbc88b9036811] ASoC: codecs: Add acpi_m=
atch_table for aw88399 driver
# good: [87aa3c8d8c4aa2e2567fe04126d14eb9fde815e5] spi: intel: Allow writea=
ble MTD partition with module param
# good: [ffc72771ff6ec9f5b431a86c4b00d8ef0fea958b] regmap: Annotate that MM=
IO implies fast IO
# good: [0bd042ae771d61ef7ccd5882f7aeca59a25f71d9] regulator: mt6370: Fix s=
pelling mistake in mt6370_regualtor_register
# good: [50a479527ef01f9b36dde1803a7e81741a222509] ASoC: SDCA: Add support =
for -cn- value properties
# good: [f6b159431697c903da1418e70c825faa0cddbdae] spi: spi-sg2044-nor: Add=
 SPI-NOR controller for SG2042
# good: [da98e8b97058c73b5c58e9976af2e7286f1c799b] ASoC: dt-bindings: atmel=
,at91-ssc: add microchip,sam9x7-ssc
# good: [6776ecc9dd587c08a6bb334542f9f8821a091013] ASoC: fsl_xcvr: get chan=
nel status data with firmware exists
# good: [71d141edbfa3e0a213c537e979790835550270d6] regulator: Kconfig: Fix =
spelling mistake "regualtor" -> "regulator"
# good: [8b61c8919dff080d83415523cd68f2fef03ccfc7] spi: Add driver for the =
RZ/V2H(P) RSPI IP
# good: [0ef2a9779e9decee52a85bc393309b3e068a74a6] MAINTAINERS: Add an entr=
y for Amlogic spi driver
# good: [c58c35ef6ae62e36927f506a5afc66610b7261d9] ASoC: qcom: sm8250: Add =
Fairphone 4 soundcard compatible
# good: [1f590fa4b93dd7c7daaa4e09d8381ac2aab3853c] spi: spi-qpic-snand: sim=
plify bad block marker duplication
# good: [246570cd351299959822ac21e75e2975f80ce4b7] ASoC: SDCA: Fix implicit=
 cast from le16
# good: [59c5dbd585a0bee70e51fcdf36185f7602b9c285] ASoC: SDCA: Shrink detec=
ted_mode_handler() stack frame
# good: [17882721dcb49323eaa9728d7eaa2ae826c876f7] ASoC: SDCA: add route by=
 the number of input pins in MU entity
# good: [d60f7cab7c04944a79af16caa43c141e780a59c6] spi: spidev: Add an entr=
y for the ABB spi sensors
# good: [d511206dc7443120637efd9cfa3ab06a26da33dd] regulator: core: repeat =
voltage setting request for stepped regulators
# good: [951a6d8d41289b86a564ee5563ededa702b62b1b] spi: stm32-ospi: Fix NUL=
L vs IS_ERR() bug in stm32_ospi_get_resources()
# good: [03aa2ed9e187e42f25b3871b691d535fc19156c4] ASoC: Intel: sof_rt5682:=
 Add HDMI-In capture with rt5682 support for PTL.
# good: [63be976da994260ea116c431a2e61485dbede1b0] regulator: rt6160: Add r=
t6166 vout min_uV setting for compatible
# good: [8778837f0a5b7c1bc5dbf0cccd7619fec6981588] ASoC: codec: tlv320aic32=
x4: Fix reset GPIO check
# good: [d929cc75e9791def049a90998aaab8934196131c] spi: gpio: Use explicit =
'unsigned int' for parameter types
# good: [d5255ae7ec48ac1f702e95b472801dbb7bf1e97f] spi: dt-bindings: spi-mu=
x: Drop "spi-max-frequency" as required
# good: [4ed357f72a0e0a691304e5f14a3323811c8ce862] ASoC: SDCA: Add hw_param=
s() helper function
# good: [d9f334fca5448907cc47ba8553926f9ba148512f] MAINTAINERS: add regulat=
or.rs to the regulator API entry
# good: [d5f317fd5cd9dfdf5bbe11384001817760c12b75] ASoC: stm: stm32_sai_sub=
: convert from round_rate() to determine_rate()
# good: [15247b5a63f506125360fa45d7aa1fbe8b903b95] ASoC: SDCA: Update memor=
y allocations to zero initialise
# good: [6f8584a4826f01a55d3d0c4bbad5961f1de52fc9] spi: st: Switch from CON=
FIG_PM_SLEEP guards to pm_sleep_ptr()
# good: [43728a6434f9eca0385fd180d8452a5071678a5b] regulator: tps6286x-regu=
lator: Fix a copy & paste error
# good: [790d5f8ee6f2a27686d042abbce16b4e03ac1608] ASoC: codec: tlv320aic32=
x4: Convert to GPIO descriptors
# good: [af241e3fa4d823f8af899c92fd50d020816a1860] ASoC: fsl-asoc-card: add=
 sysclk_ratio for calculate sysclk frequency
# good: [3aa47d2ec83316c24e1ed15a492b331802dc6a69] regulator: qcom-rpmh: ad=
d support for pm7550 regulators
# good: [5030abcb0aa3304bf91497844ffa9607a2d4ad5d] ASoC: SDCA: Pull HID and=
 IRQ into the primary SDCA module
# good: [f00e06296ba3f0d8440030afe8cc2258758b7af7] ASoC: samsung: littlemil=
l: don't set dapm->bias_level directly
# good: [b30d390812c8559c5835f8ae5f490b38488fafc8] regulator: tps6594-regul=
ator: Add TI TPS652G1 PMIC regulators
# good: [7d61715c58a39edc5f74fc7366487726fc223530] spi: rspi: Convert to DE=
FINE_SIMPLE_DEV_PM_OPS()
# good: [ad4655653a6c463026ed3c300e5fb34f39abff48] ASoC: SDCA: fix HID depe=
ndency
# good: [c61da55412a08268ea0cdef99dea11f7ade934ee] ASoC: sdw_utils: Add mis=
sed component_name strings for speaker amps
# good: [68e4dadacb7faa393b532b41bbf99a2dbfec3b1b] ASoC: img: Imagination T=
echnologies sound should depend on MIPS
# good: [defe01abfb7f5c5bd53c723b8577d4fcd64faa5a] spi: stm32-ospi: Use of_=
reserved_mem_region_to_resource() for "memory-region"
# good: [86ccd4d3e8bc9eeb5dde4080fcc67e0505d1d2c6] ASoC: Intel: soc-acpi-in=
tel-lnl-match: add rt1320_l12_rt714_l0 support
# good: [67bdd67aedcec8c63e3158c3c82991fbde0c4d22] ASoC: rt715: don't set d=
apm->bias_level
# good: [5054740e0092aac528c0589251f612b3b41c9e7b] regulator: sy8827n: make=
 enable gpio NONEXCLUSIVE
# good: [08dc0f5cc26a203e8008c38d9b436c079e7dbb45] ASoC: soc-dapm: add pref=
ix on soc_dapm_dev_attrs
# good: [2fca750160f29015ab1109bb478537a4e415f7cd] spi: Remove redundant pm=
_runtime_mark_last_busy() calls
# good: [571defe0dff3f1e4180bd0db79283d3d5bf74a71] ASoC: codec: rockchip_sa=
i: Remove including of_gpio.h
# good: [2bd9648d5a8d329ca734ca2c273a80934867471e] ASoC: SOF: Remove redund=
ant pm_runtime_mark_last_busy() calls
# good: [c61e94e5e4e6bc50064119e6a779564d1d2ac0e7] regulator: stm32-vrefbuf=
: Remove redundant pm_runtime_mark_last_busy() calls
# good: [9f711c9321cffe3e03709176873c277fa911c366] regmap: get rid of redun=
dant debugfs_file_{get,put}()
# good: [bc163baef57002c08b3afe64cdd2f55f55a765eb] ASoC: Use of_reserved_me=
m_region_to_resource() for "memory-region"
# good: [baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd] ASoC: fsl_mqs: rename sy=
stem manager indices for i.MX95
# good: [7105fdd54a14bee49371b39374a61b3c967d74cb] spi: dt-bindings: Conver=
t marvell,orion-spi to DT schema
# good: [913bf8d50cbd144c87e9660b591781179182ff59] spi: spi-qpic-snand: add=
 support for 8 bits ECC strength
# good: [0c0ef1d90967717b91cded41b00dbae05d8e521c] ASoC: amd: acp: Enable a=
cp7.2 platform based DMIC support in machine driver
# good: [34d340d48e595f8dfd4e72fe4100d2579dbe4a1a] ASoC: qcom: sc8280xp: Ad=
d support for QCS8275
# good: [3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff] spi: offload trigger: ad=
d ADI Util Sigma-Delta SPI driver
# good: [244bc18e5f1875401a4af87d2eae3f9376d9d720] spi: stm32: delete stray=
 tabs in stm32h7_spi_data_idleness()
# good: [fc0d2840a00d75931777e6dba55fcce40f34a24a] arm64: dts: imx93-11x11-=
evk: remove the duplicated pinctrl_lpi2c3 node
# good: [b6fb05efd90e0f0bfc3e3d2557b6aa1c65fcbfa6] arm64: dts: imx93-11x11-=
evk: reduce the driving strength of net RXC/TXC
# good: [b63ae4182b6afa89ad0f7cff9c932328d887b936] ARM: dts: imx28: add pwm=
7 muxing options
# good: [b9ab3b61824190b1c6b2c59e7ba4de591f24eb92] ASoC: SDCA: Add some ini=
tial IRQ handlers
# good: [c4f2c05ab02952c9a56067aeb700ded95b183570] spi: stm32: fix pointer-=
to-pointer variables usage
# good: [7e1c28fbf235791cb5046fafdac5bc16fe8e788d] spi: spi-pci1xxxx: enabl=
e concurrent DMA read/write across SPI transfers
# good: [427ceac823e58813b510e585011488f603f0d891] regulator: tps6286x-regu=
lator: Enable REGCACHE_MAPLE
# good: [29ddce17e909779633f856ad1c2f111fbf71c0df] ASoC: codecs: Add calibr=
ation function to aw88399 chip
# good: [ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea] spi: dt-bindings: add nx=
p,lpc3220-spi.yaml
# good: [2555691165a0285a4617230fed859f20dcc51608] spi: atmel-quadspi: Use =
`devm_dma_request_chan()`
# good: [ce57bc9771411d6d27f2ca7b40396cbd7d684ba9] regulator: core: Don't u=
se "proxy" headers
# good: [08bf1663c21a3e815eda28fa242d84c945ca3b94] dmaengine: Add devm_dma_=
request_chan()
# good: [0f60ecffbfe35e12eb56c99640ba2360244b5bb3] ASoC: sdw_utils: generat=
e combined spk components string
# good: [9a944494c299fabf3cc781798eb7c02a0bece364] spi: dt-bindings: stm32:=
 deprecate `st,spi-midi-ns` property
# good: [3e36c822506d924894ff7de549b9377d3114c2d7] spi: spi-pci1xxxx: Add s=
upport for per-instance DMA interrupt vectors
# good: [68fbc70ece40139380380dce74059afa592846b3] ASoC: hisilicon: Standar=
dize ASoC menu
# good: [8f9cf02c8852837923f1cdacfcc92e138513325c] spi: microchip-core-qspi=
: Add regular transfers
# good: [17cc308b183308bf5ada36e164284fff7eb064ba] ASoC: wm8524: enable con=
straints when sysclk is configured.
# good: [59566923d955b69bfb1e1163f07dff437dde8c9c] ASoC: SOF: amd: add alte=
rnate machines for ACP7.0 and ACP7.1 platforms
# good: [024f39fff6d222cedde361f7fe34d9ba4e6afb92] regulator: mtk-dvfsrc: A=
dd support for MediaTek MT8196 DVFSRC
# good: [19cbc930c209d59a2c9828de4c7b767e9f14667e] regulator: pca9450: Supp=
ort PWM mode also for pca9451a
# good: [c4ca928a6db1593802cd945f075a7e21dd0430c1] ASoC: hdac_hdmi: Rate li=
mit logging on connection and disconnection
# good: [a48352921f0b15b1f7eff83f5b5613d6ae2350d3] ASoC: codecs: wcd939x: A=
dd defines for major/minor version decoding
# good: [3421d46440ebe0865bec71dbd2330b4e17a425ab] HID: core: Add bus defin=
e for SoundWire bus
# good: [a1d203d390e04798ccc1c3c06019cd4411885d6d] ASoC: SOF: ipc4-pcm: Ena=
ble delay reporting for ChainDMA streams
# good: [2756b7f08ff6ca7c68c8c7dd61c8dc6895c9de34] ASoC: SOF: ipc4-pcm: Har=
monize sof_ipc4_set_pipeline_state() dbg print
# good: [ace9b3daf2b4778358573d3698e34cb1c0fa7e14] ASoC: SOF: ipc4/Intel: A=
dd support for library restore firmware functionality
# good: [bb48117b79ebc39485f7306d09dc602981fe540f] ASoC: Intel: sof_sdw: Im=
plement add_dai_link to filter HDMI PCMs
# good: [cd4da713f99651e99fbce8ed6b6ec8f686c029a8] Documentation: PM: *_aut=
osuspend() functions update last busy time
# good: [5fc2c383125c2b4b6037e02ad8796b776b25e6d0] spi: falcon: mark falcon=
_sflash_xfer() as static
# good: [7f8924e8785b68c998bc1906e049bf5595865e60] ASoC: dt-bindings: cirru=
s,cs42xx8: add 'port' property
# good: [3e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115] regulator: rpi-panel-v2:=
 Add shutdown hook
# good: [d9f38d9824bfb1b046d2e720349d2f45959ab184] ASoC: tegra: AHUB: Remov=
e unneeded semicolon
# good: [d03b53c9139352b744ed007bf562bd35517bacff] dt-bindings: gpio: gpio-=
xilinx: Mark clocks as required property
# good: [dce4bc30f42d313b4dc5832316196411b7f07ad0] spi: spi-fsl-dspi: Rever=
t unintended dependency change in config SPI_FSL_DSPI
# good: [47972c1c3315672352f25c68f91dd88543541947] ASoC: Intel: Replace dep=
recated strcpy() with strscpy()
# good: [367864935785382bab95f5e5a691535d28f5a21b] gpio: raspberrypi-exp: u=
se new GPIO line value setter callbacks
# good: [7b2c2f1eb3914f5214a5b2ae966d7d7bb0057582] gpio: Use dev_fwnode() w=
here applicable across drivers
# good: [5eb8a0d7733d4cd32a776acf1d1aa1c7c01c8a14] ASoC: hdmi-codec: use SN=
D_JACK_AVOUT as jack status
# good: [bb8d8ba4715cb8f997d63d90ba935f6073595df5] ASoC: mediatek: mt8183-a=
fe-pcm: use local `dev` pointer in driver callbacks
# good: [8a5a5cecb79058b608e5562d8998123a3adb313c] ASoC: tas2781: Move the =
"include linux/debugfs.h" into tas2781.h
# good: [a4eb71ff98c4792f441f108910bd829da7a04092] regulator: rpi-panel-v2:=
 Fix missing OF dependency
# good: [6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3] spi: spi-mt65xx: Add sup=
port for MT6991 Dimensity 9400 SPI IPM
# good: [7e10d7242ea8a5947878880b912ffa5806520705] ASoC: ops: dynamically a=
llocate struct snd_ctl_elem_value
# good: [d6fa0ca959db8efd4462d7beef4bdc5568640fd0] regulator: rpi-panel-v2:=
 Add missing GPIOLIB dependency
# good: [d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4] regulator: rpi-panel-v2:=
 Add regulator for 7" Raspberry Pi 720x1280
# good: [1f5cdb6ab45e1c06ae0953609acbb52f8946b3e8] ASoC: codecs: Add suppor=
t for Richtek RTQ9124
# good: [6ba68e5aa9d5d15c8877a655db279fcfc0b38b04] ASoC: renesas: msiof: Co=
nvert to <linux/spi/sh_msiof.h>
# good: [548d770c330cd1027549947a6ea899c56b5bc4e4] regulator: pca9450: Add =
support for mode operations
# good: [c459262159f39e6e6336797feb975799344b749b] spi: spi-pci1xxxx: Add s=
upport for 25MHz Clock frequency in C0
# good: [267be32b0a7b70cc777f8a46f0904c92c0521d89] ASoC: remove component->=
id
# good: [03b778d1994827ea5cc971dbdfbb457bbb7bfa5d] ASOC: rockchip: Use help=
er function devm_clk_get_enabled()
# good: [111a2c8ab462d77d1519b71b46f13ae1b46920b4] ASoC: imx-card: Use help=
er function for_each_child_of_node_scoped()
# good: [f6f914893d478b7ba08e5c375de1ced16deb5e92] ASoC: dt-bindings: tas57=
xx: add tas5753 compatibility
# good: [c95e925daa434ee1a40a86aec6476ce588e4bd77] ASoC: Intel: avs: Add rt=
5640 machine board
# good: [9a30e332c36c52e92e5316b4a012d45284dedeb5] spi: spi-fsl-dspi: Enabl=
e support for S32G platforms
# good: [c8c4694ede7ed42d8d4db0e8927dea9839a3e248] regmap: kunit: Constify =
regmap_range_cfg array
# good: [ac209bde018fd320b79976657a44c23113181af6] ASoC: tas2781: Drop the =
unnecessary symbol imply
# good: [b9ecde0bcf6a99a3ff08496d4ba90a385ebbfd68] ASoC: codecs: wcd939x: A=
dd VDD_PX supply
# good: [ece5d881004f041c2e1493436409dbcbea3ad5f8] ASoC: codecs: wcd939x: D=
rop unused 'struct wcd939x_priv' fields
# good: [e6e8897995a9e6028563ce36c27877e5478c8571] ASoC: qcom: sm8250: Add =
Fairphone 5 soundcard compatible
# good: [7e17e80c3a7eb2734795f66ba946f933412d597f] Merge branch 'for-6.14/s=
tack-order' into for-next
git bisect start '0b90c3b6d76ea512dc3dac8fb30215e175b0019a' '60a48532c31d9d=
652a1e3a92ff7d620ff4545e8c' '2d442a0c781403702de27ccfbc4bb233721585f5' 'e95=
122a32e777309412e30dc638dbc88b9036811' '87aa3c8d8c4aa2e2567fe04126d14eb9fde=
815e5' 'ffc72771ff6ec9f5b431a86c4b00d8ef0fea958b' '0bd042ae771d61ef7ccd5882=
f7aeca59a25f71d9' '50a479527ef01f9b36dde1803a7e81741a222509' 'f6b159431697c=
903da1418e70c825faa0cddbdae' 'da98e8b97058c73b5c58e9976af2e7286f1c799b' '67=
76ecc9dd587c08a6bb334542f9f8821a091013' '71d141edbfa3e0a213c537e97979083555=
0270d6' '8b61c8919dff080d83415523cd68f2fef03ccfc7' '0ef2a9779e9decee52a85bc=
393309b3e068a74a6' 'c58c35ef6ae62e36927f506a5afc66610b7261d9' '1f590fa4b93d=
d7c7daaa4e09d8381ac2aab3853c' '246570cd351299959822ac21e75e2975f80ce4b7' '5=
9c5dbd585a0bee70e51fcdf36185f7602b9c285' '17882721dcb49323eaa9728d7eaa2ae82=
6c876f7' 'd60f7cab7c04944a79af16caa43c141e780a59c6' 'd511206dc7443120637efd=
9cfa3ab06a26da33dd' '951a6d8d41289b86a564ee5563ededa702b62b1b' '03aa2ed9e18=
7e42f25b3871b691d535fc19156c4' '63be976da994260ea116c431a2e61485dbede1b0' '=
8778837f0a5b7c1bc5dbf0cccd7619fec6981588' 'd929cc75e9791def049a90998aaab893=
4196131c' 'd5255ae7ec48ac1f702e95b472801dbb7bf1e97f' '4ed357f72a0e0a691304e=
5f14a3323811c8ce862' 'd9f334fca5448907cc47ba8553926f9ba148512f' 'd5f317fd5c=
d9dfdf5bbe11384001817760c12b75' '15247b5a63f506125360fa45d7aa1fbe8b903b95' =
'6f8584a4826f01a55d3d0c4bbad5961f1de52fc9' '43728a6434f9eca0385fd180d8452a5=
071678a5b' '790d5f8ee6f2a27686d042abbce16b4e03ac1608' 'af241e3fa4d823f8af89=
9c92fd50d020816a1860' '3aa47d2ec83316c24e1ed15a492b331802dc6a69' '5030abcb0=
aa3304bf91497844ffa9607a2d4ad5d' 'f00e06296ba3f0d8440030afe8cc2258758b7af7'=
 'b30d390812c8559c5835f8ae5f490b38488fafc8' '7d61715c58a39edc5f74fc73664877=
26fc223530' 'ad4655653a6c463026ed3c300e5fb34f39abff48' 'c61da55412a08268ea0=
cdef99dea11f7ade934ee' '68e4dadacb7faa393b532b41bbf99a2dbfec3b1b' 'defe01ab=
fb7f5c5bd53c723b8577d4fcd64faa5a' '86ccd4d3e8bc9eeb5dde4080fcc67e0505d1d2c6=
' '67bdd67aedcec8c63e3158c3c82991fbde0c4d22' '5054740e0092aac528c0589251f61=
2b3b41c9e7b' '08dc0f5cc26a203e8008c38d9b436c079e7dbb45' '2fca750160f29015ab=
1109bb478537a4e415f7cd' '571defe0dff3f1e4180bd0db79283d3d5bf74a71' '2bd9648=
d5a8d329ca734ca2c273a80934867471e' 'c61e94e5e4e6bc50064119e6a779564d1d2ac0e=
7' '9f711c9321cffe3e03709176873c277fa911c366' 'bc163baef57002c08b3afe64cdd2=
f55f55a765eb' 'baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd' '7105fdd54a14bee49=
371b39374a61b3c967d74cb' '913bf8d50cbd144c87e9660b591781179182ff59' '0c0ef1=
d90967717b91cded41b00dbae05d8e521c' '34d340d48e595f8dfd4e72fe4100d2579dbe4a=
1a' '3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff' '244bc18e5f1875401a4af87d2ea=
e3f9376d9d720' 'fc0d2840a00d75931777e6dba55fcce40f34a24a' 'b6fb05efd90e0f0b=
fc3e3d2557b6aa1c65fcbfa6' 'b63ae4182b6afa89ad0f7cff9c932328d887b936' 'b9ab3=
b61824190b1c6b2c59e7ba4de591f24eb92' 'c4f2c05ab02952c9a56067aeb700ded95b183=
570' '7e1c28fbf235791cb5046fafdac5bc16fe8e788d' '427ceac823e58813b510e58501=
1488f603f0d891' '29ddce17e909779633f856ad1c2f111fbf71c0df' 'ac4c064f67d3cdf=
9118b9b09c1e3b28b6c10a7ea' '2555691165a0285a4617230fed859f20dcc51608' 'ce57=
bc9771411d6d27f2ca7b40396cbd7d684ba9' '08bf1663c21a3e815eda28fa242d84c945ca=
3b94' '0f60ecffbfe35e12eb56c99640ba2360244b5bb3' '9a944494c299fabf3cc781798=
eb7c02a0bece364' '3e36c822506d924894ff7de549b9377d3114c2d7' '68fbc70ece4013=
9380380dce74059afa592846b3' '8f9cf02c8852837923f1cdacfcc92e138513325c' '17c=
c308b183308bf5ada36e164284fff7eb064ba' '59566923d955b69bfb1e1163f07dff437dd=
e8c9c' '024f39fff6d222cedde361f7fe34d9ba4e6afb92' '19cbc930c209d59a2c9828de=
4c7b767e9f14667e' 'c4ca928a6db1593802cd945f075a7e21dd0430c1' 'a48352921f0b1=
5b1f7eff83f5b5613d6ae2350d3' '3421d46440ebe0865bec71dbd2330b4e17a425ab' 'a1=
d203d390e04798ccc1c3c06019cd4411885d6d' '2756b7f08ff6ca7c68c8c7dd61c8dc6895=
c9de34' 'ace9b3daf2b4778358573d3698e34cb1c0fa7e14' 'bb48117b79ebc39485f7306=
d09dc602981fe540f' 'cd4da713f99651e99fbce8ed6b6ec8f686c029a8' '5fc2c383125c=
2b4b6037e02ad8796b776b25e6d0' '7f8924e8785b68c998bc1906e049bf5595865e60' '3=
e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115' 'd9f38d9824bfb1b046d2e720349d2f459=
59ab184' 'd03b53c9139352b744ed007bf562bd35517bacff' 'dce4bc30f42d313b4dc583=
2316196411b7f07ad0' '47972c1c3315672352f25c68f91dd88543541947' '36786493578=
5382bab95f5e5a691535d28f5a21b' '7b2c2f1eb3914f5214a5b2ae966d7d7bb0057582' '=
5eb8a0d7733d4cd32a776acf1d1aa1c7c01c8a14' 'bb8d8ba4715cb8f997d63d90ba935f60=
73595df5' '8a5a5cecb79058b608e5562d8998123a3adb313c' 'a4eb71ff98c4792f441f1=
08910bd829da7a04092' '6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3' '7e10d7242e=
a8a5947878880b912ffa5806520705' 'd6fa0ca959db8efd4462d7beef4bdc5568640fd0' =
'd49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4' '1f5cdb6ab45e1c06ae0953609acbb52=
f8946b3e8' '6ba68e5aa9d5d15c8877a655db279fcfc0b38b04' '548d770c330cd1027549=
947a6ea899c56b5bc4e4' 'c459262159f39e6e6336797feb975799344b749b' '267be32b0=
a7b70cc777f8a46f0904c92c0521d89' '03b778d1994827ea5cc971dbdfbb457bbb7bfa5d'=
 '111a2c8ab462d77d1519b71b46f13ae1b46920b4' 'f6f914893d478b7ba08e5c375de1ce=
d16deb5e92' 'c95e925daa434ee1a40a86aec6476ce588e4bd77' '9a30e332c36c52e92e5=
316b4a012d45284dedeb5' 'c8c4694ede7ed42d8d4db0e8927dea9839a3e248' 'ac209bde=
018fd320b79976657a44c23113181af6' 'b9ecde0bcf6a99a3ff08496d4ba90a385ebbfd68=
' 'ece5d881004f041c2e1493436409dbcbea3ad5f8' 'e6e8897995a9e6028563ce36c2787=
7e5478c8571' '7e17e80c3a7eb2734795f66ba946f933412d597f'
# test job: [2d442a0c781403702de27ccfbc4bb233721585f5] https://lava.sirena.=
org.uk/scheduler/job/1608649
# test job: [e95122a32e777309412e30dc638dbc88b9036811] https://lava.sirena.=
org.uk/scheduler/job/1607724
# test job: [87aa3c8d8c4aa2e2567fe04126d14eb9fde815e5] https://lava.sirena.=
org.uk/scheduler/job/1607785
# test job: [ffc72771ff6ec9f5b431a86c4b00d8ef0fea958b] https://lava.sirena.=
org.uk/scheduler/job/1607863
# test job: [0bd042ae771d61ef7ccd5882f7aeca59a25f71d9] https://lava.sirena.=
org.uk/scheduler/job/1605091
# test job: [50a479527ef01f9b36dde1803a7e81741a222509] https://lava.sirena.=
org.uk/scheduler/job/1604262
# test job: [f6b159431697c903da1418e70c825faa0cddbdae] https://lava.sirena.=
org.uk/scheduler/job/1604203
# test job: [da98e8b97058c73b5c58e9976af2e7286f1c799b] https://lava.sirena.=
org.uk/scheduler/job/1604511
# test job: [6776ecc9dd587c08a6bb334542f9f8821a091013] https://lava.sirena.=
org.uk/scheduler/job/1604444
# test job: [71d141edbfa3e0a213c537e979790835550270d6] https://lava.sirena.=
org.uk/scheduler/job/1603792
# test job: [8b61c8919dff080d83415523cd68f2fef03ccfc7] https://lava.sirena.=
org.uk/scheduler/job/1604568
# test job: [0ef2a9779e9decee52a85bc393309b3e068a74a6] https://lava.sirena.=
org.uk/scheduler/job/1603982
# test job: [c58c35ef6ae62e36927f506a5afc66610b7261d9] https://lava.sirena.=
org.uk/scheduler/job/1600231
# test job: [1f590fa4b93dd7c7daaa4e09d8381ac2aab3853c] https://lava.sirena.=
org.uk/scheduler/job/1599937
# test job: [246570cd351299959822ac21e75e2975f80ce4b7] https://lava.sirena.=
org.uk/scheduler/job/1595440
# test job: [59c5dbd585a0bee70e51fcdf36185f7602b9c285] https://lava.sirena.=
org.uk/scheduler/job/1594678
# test job: [17882721dcb49323eaa9728d7eaa2ae826c876f7] https://lava.sirena.=
org.uk/scheduler/job/1592665
# test job: [d60f7cab7c04944a79af16caa43c141e780a59c6] https://lava.sirena.=
org.uk/scheduler/job/1592406
# test job: [d511206dc7443120637efd9cfa3ab06a26da33dd] https://lava.sirena.=
org.uk/scheduler/job/1585934
# test job: [951a6d8d41289b86a564ee5563ededa702b62b1b] https://lava.sirena.=
org.uk/scheduler/job/1579912
# test job: [03aa2ed9e187e42f25b3871b691d535fc19156c4] https://lava.sirena.=
org.uk/scheduler/job/1580023
# test job: [63be976da994260ea116c431a2e61485dbede1b0] https://lava.sirena.=
org.uk/scheduler/job/1578734
# test job: [8778837f0a5b7c1bc5dbf0cccd7619fec6981588] https://lava.sirena.=
org.uk/scheduler/job/1578568
# test job: [d929cc75e9791def049a90998aaab8934196131c] https://lava.sirena.=
org.uk/scheduler/job/1578406
# test job: [d5255ae7ec48ac1f702e95b472801dbb7bf1e97f] https://lava.sirena.=
org.uk/scheduler/job/1575898
# test job: [4ed357f72a0e0a691304e5f14a3323811c8ce862] https://lava.sirena.=
org.uk/scheduler/job/1575105
# test job: [d9f334fca5448907cc47ba8553926f9ba148512f] https://lava.sirena.=
org.uk/scheduler/job/1573838
# test job: [d5f317fd5cd9dfdf5bbe11384001817760c12b75] https://lava.sirena.=
org.uk/scheduler/job/1574065
# test job: [15247b5a63f506125360fa45d7aa1fbe8b903b95] https://lava.sirena.=
org.uk/scheduler/job/1574632
# test job: [6f8584a4826f01a55d3d0c4bbad5961f1de52fc9] https://lava.sirena.=
org.uk/scheduler/job/1573953
# test job: [43728a6434f9eca0385fd180d8452a5071678a5b] https://lava.sirena.=
org.uk/scheduler/job/1565302
# test job: [790d5f8ee6f2a27686d042abbce16b4e03ac1608] https://lava.sirena.=
org.uk/scheduler/job/1563425
# test job: [af241e3fa4d823f8af899c92fd50d020816a1860] https://lava.sirena.=
org.uk/scheduler/job/1563277
# test job: [3aa47d2ec83316c24e1ed15a492b331802dc6a69] https://lava.sirena.=
org.uk/scheduler/job/1563161
# test job: [5030abcb0aa3304bf91497844ffa9607a2d4ad5d] https://lava.sirena.=
org.uk/scheduler/job/1563376
# test job: [f00e06296ba3f0d8440030afe8cc2258758b7af7] https://lava.sirena.=
org.uk/scheduler/job/1562391
# test job: [b30d390812c8559c5835f8ae5f490b38488fafc8] https://lava.sirena.=
org.uk/scheduler/job/1557141
# test job: [7d61715c58a39edc5f74fc7366487726fc223530] https://lava.sirena.=
org.uk/scheduler/job/1556515
# test job: [ad4655653a6c463026ed3c300e5fb34f39abff48] https://lava.sirena.=
org.uk/scheduler/job/1554886
# test job: [c61da55412a08268ea0cdef99dea11f7ade934ee] https://lava.sirena.=
org.uk/scheduler/job/1554475
# test job: [68e4dadacb7faa393b532b41bbf99a2dbfec3b1b] https://lava.sirena.=
org.uk/scheduler/job/1553556
# test job: [defe01abfb7f5c5bd53c723b8577d4fcd64faa5a] https://lava.sirena.=
org.uk/scheduler/job/1553627
# test job: [86ccd4d3e8bc9eeb5dde4080fcc67e0505d1d2c6] https://lava.sirena.=
org.uk/scheduler/job/1547948
# test job: [67bdd67aedcec8c63e3158c3c82991fbde0c4d22] https://lava.sirena.=
org.uk/scheduler/job/1548029
# test job: [5054740e0092aac528c0589251f612b3b41c9e7b] https://lava.sirena.=
org.uk/scheduler/job/1546903
# test job: [08dc0f5cc26a203e8008c38d9b436c079e7dbb45] https://lava.sirena.=
org.uk/scheduler/job/1546255
# test job: [2fca750160f29015ab1109bb478537a4e415f7cd] https://lava.sirena.=
org.uk/scheduler/job/1540301
# test job: [571defe0dff3f1e4180bd0db79283d3d5bf74a71] https://lava.sirena.=
org.uk/scheduler/job/1539760
# test job: [2bd9648d5a8d329ca734ca2c273a80934867471e] https://lava.sirena.=
org.uk/scheduler/job/1539583
# test job: [c61e94e5e4e6bc50064119e6a779564d1d2ac0e7] https://lava.sirena.=
org.uk/scheduler/job/1538601
# test job: [9f711c9321cffe3e03709176873c277fa911c366] https://lava.sirena.=
org.uk/scheduler/job/1538696
# test job: [bc163baef57002c08b3afe64cdd2f55f55a765eb] https://lava.sirena.=
org.uk/scheduler/job/1538737
# test job: [baee26a9d6cd3d3c6c3c03c56270aa647a67e4bd] https://lava.sirena.=
org.uk/scheduler/job/1533847
# test job: [7105fdd54a14bee49371b39374a61b3c967d74cb] https://lava.sirena.=
org.uk/scheduler/job/1533532
# test job: [913bf8d50cbd144c87e9660b591781179182ff59] https://lava.sirena.=
org.uk/scheduler/job/1531295
# test job: [0c0ef1d90967717b91cded41b00dbae05d8e521c] https://lava.sirena.=
org.uk/scheduler/job/1530379
# test job: [34d340d48e595f8dfd4e72fe4100d2579dbe4a1a] https://lava.sirena.=
org.uk/scheduler/job/1530296
# test job: [3fcd3d2fe44dc9dfca20b6aed117f314a50ba0ff] https://lava.sirena.=
org.uk/scheduler/job/1528998
# test job: [244bc18e5f1875401a4af87d2eae3f9376d9d720] https://lava.sirena.=
org.uk/scheduler/job/1528326
# test job: [fc0d2840a00d75931777e6dba55fcce40f34a24a] https://lava.sirena.=
org.uk/scheduler/job/1531509
# test job: [b6fb05efd90e0f0bfc3e3d2557b6aa1c65fcbfa6] https://lava.sirena.=
org.uk/scheduler/job/1531006
# test job: [b63ae4182b6afa89ad0f7cff9c932328d887b936] https://lava.sirena.=
org.uk/scheduler/job/1531089
# test job: [b9ab3b61824190b1c6b2c59e7ba4de591f24eb92] https://lava.sirena.=
org.uk/scheduler/job/1526374
# test job: [c4f2c05ab02952c9a56067aeb700ded95b183570] https://lava.sirena.=
org.uk/scheduler/job/1526246
# test job: [7e1c28fbf235791cb5046fafdac5bc16fe8e788d] https://lava.sirena.=
org.uk/scheduler/job/1525641
# test job: [427ceac823e58813b510e585011488f603f0d891] https://lava.sirena.=
org.uk/scheduler/job/1525664
# test job: [29ddce17e909779633f856ad1c2f111fbf71c0df] https://lava.sirena.=
org.uk/scheduler/job/1523970
# test job: [ac4c064f67d3cdf9118b9b09c1e3b28b6c10a7ea] https://lava.sirena.=
org.uk/scheduler/job/1515921
# test job: [2555691165a0285a4617230fed859f20dcc51608] https://lava.sirena.=
org.uk/scheduler/job/1515764
# test job: [ce57bc9771411d6d27f2ca7b40396cbd7d684ba9] https://lava.sirena.=
org.uk/scheduler/job/1515820
# test job: [08bf1663c21a3e815eda28fa242d84c945ca3b94] https://lava.sirena.=
org.uk/scheduler/job/1517644
# test job: [0f60ecffbfe35e12eb56c99640ba2360244b5bb3] https://lava.sirena.=
org.uk/scheduler/job/1511602
# test job: [9a944494c299fabf3cc781798eb7c02a0bece364] https://lava.sirena.=
org.uk/scheduler/job/1507932
# test job: [3e36c822506d924894ff7de549b9377d3114c2d7] https://lava.sirena.=
org.uk/scheduler/job/1506359
# test job: [68fbc70ece40139380380dce74059afa592846b3] https://lava.sirena.=
org.uk/scheduler/job/1504183
# test job: [8f9cf02c8852837923f1cdacfcc92e138513325c] https://lava.sirena.=
org.uk/scheduler/job/1502895
# test job: [17cc308b183308bf5ada36e164284fff7eb064ba] https://lava.sirena.=
org.uk/scheduler/job/1501541
# test job: [59566923d955b69bfb1e1163f07dff437dde8c9c] https://lava.sirena.=
org.uk/scheduler/job/1499643
# test job: [024f39fff6d222cedde361f7fe34d9ba4e6afb92] https://lava.sirena.=
org.uk/scheduler/job/1499718
# test job: [19cbc930c209d59a2c9828de4c7b767e9f14667e] https://lava.sirena.=
org.uk/scheduler/job/1499004
# test job: [c4ca928a6db1593802cd945f075a7e21dd0430c1] https://lava.sirena.=
org.uk/scheduler/job/1499010
# test job: [a48352921f0b15b1f7eff83f5b5613d6ae2350d3] https://lava.sirena.=
org.uk/scheduler/job/1499007
# test job: [3421d46440ebe0865bec71dbd2330b4e17a425ab] https://lava.sirena.=
org.uk/scheduler/job/1493072
# test job: [a1d203d390e04798ccc1c3c06019cd4411885d6d] https://lava.sirena.=
org.uk/scheduler/job/1491497
# test job: [2756b7f08ff6ca7c68c8c7dd61c8dc6895c9de34] https://lava.sirena.=
org.uk/scheduler/job/1489214
# test job: [ace9b3daf2b4778358573d3698e34cb1c0fa7e14] https://lava.sirena.=
org.uk/scheduler/job/1489281
# test job: [bb48117b79ebc39485f7306d09dc602981fe540f] https://lava.sirena.=
org.uk/scheduler/job/1489352
# test job: [cd4da713f99651e99fbce8ed6b6ec8f686c029a8] https://lava.sirena.=
org.uk/scheduler/job/1538865
# test job: [5fc2c383125c2b4b6037e02ad8796b776b25e6d0] https://lava.sirena.=
org.uk/scheduler/job/1486917
# test job: [7f8924e8785b68c998bc1906e049bf5595865e60] https://lava.sirena.=
org.uk/scheduler/job/1486907
# test job: [3e1c01d06e1f52f78fe00ef26a9cf80dbb0a3115] https://lava.sirena.=
org.uk/scheduler/job/1481712
# test job: [d9f38d9824bfb1b046d2e720349d2f45959ab184] https://lava.sirena.=
org.uk/scheduler/job/1481616
# test job: [d03b53c9139352b744ed007bf562bd35517bacff] https://lava.sirena.=
org.uk/scheduler/job/1488745
# test job: [dce4bc30f42d313b4dc5832316196411b7f07ad0] https://lava.sirena.=
org.uk/scheduler/job/1479475
# test job: [47972c1c3315672352f25c68f91dd88543541947] https://lava.sirena.=
org.uk/scheduler/job/1479561
# test job: [367864935785382bab95f5e5a691535d28f5a21b] https://lava.sirena.=
org.uk/scheduler/job/1488643
# test job: [7b2c2f1eb3914f5214a5b2ae966d7d7bb0057582] https://lava.sirena.=
org.uk/scheduler/job/1488133
# test job: [5eb8a0d7733d4cd32a776acf1d1aa1c7c01c8a14] https://lava.sirena.=
org.uk/scheduler/job/1474493
# test job: [bb8d8ba4715cb8f997d63d90ba935f6073595df5] https://lava.sirena.=
org.uk/scheduler/job/1472038
# test job: [8a5a5cecb79058b608e5562d8998123a3adb313c] https://lava.sirena.=
org.uk/scheduler/job/1471855
# test job: [a4eb71ff98c4792f441f108910bd829da7a04092] https://lava.sirena.=
org.uk/scheduler/job/1469012
# test job: [6cafcc53eb5fffd9b9bdfde700bb9bad21e98ed3] https://lava.sirena.=
org.uk/scheduler/job/1468918
# test job: [7e10d7242ea8a5947878880b912ffa5806520705] https://lava.sirena.=
org.uk/scheduler/job/1466023
# test job: [d6fa0ca959db8efd4462d7beef4bdc5568640fd0] https://lava.sirena.=
org.uk/scheduler/job/1464675
# test job: [d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4] https://lava.sirena.=
org.uk/scheduler/job/1463032
# test job: [1f5cdb6ab45e1c06ae0953609acbb52f8946b3e8] https://lava.sirena.=
org.uk/scheduler/job/1462978
# test job: [6ba68e5aa9d5d15c8877a655db279fcfc0b38b04] https://lava.sirena.=
org.uk/scheduler/job/1463334
# test job: [548d770c330cd1027549947a6ea899c56b5bc4e4] https://lava.sirena.=
org.uk/scheduler/job/1460070
# test job: [c459262159f39e6e6336797feb975799344b749b] https://lava.sirena.=
org.uk/scheduler/job/1461008
# test job: [267be32b0a7b70cc777f8a46f0904c92c0521d89] https://lava.sirena.=
org.uk/scheduler/job/1460425
# test job: [03b778d1994827ea5cc971dbdfbb457bbb7bfa5d] https://lava.sirena.=
org.uk/scheduler/job/1461891
# test job: [111a2c8ab462d77d1519b71b46f13ae1b46920b4] https://lava.sirena.=
org.uk/scheduler/job/1460867
# test job: [f6f914893d478b7ba08e5c375de1ced16deb5e92] https://lava.sirena.=
org.uk/scheduler/job/1461469
# test job: [c95e925daa434ee1a40a86aec6476ce588e4bd77] https://lava.sirena.=
org.uk/scheduler/job/1460121
# test job: [9a30e332c36c52e92e5316b4a012d45284dedeb5] https://lava.sirena.=
org.uk/scheduler/job/1460546
# test job: [c8c4694ede7ed42d8d4db0e8927dea9839a3e248] https://lava.sirena.=
org.uk/scheduler/job/1461313
# test job: [ac209bde018fd320b79976657a44c23113181af6] https://lava.sirena.=
org.uk/scheduler/job/1461924
# test job: [b9ecde0bcf6a99a3ff08496d4ba90a385ebbfd68] https://lava.sirena.=
org.uk/scheduler/job/1461083
# test job: [ece5d881004f041c2e1493436409dbcbea3ad5f8] https://lava.sirena.=
org.uk/scheduler/job/1461674
# test job: [e6e8897995a9e6028563ce36c27877e5478c8571] https://lava.sirena.=
org.uk/scheduler/job/1461769
# test job: [7e17e80c3a7eb2734795f66ba946f933412d597f] https://lava.sirena.=
org.uk/scheduler/job/1130953
# test job: [0b90c3b6d76ea512dc3dac8fb30215e175b0019a] https://lava.sirena.=
org.uk/scheduler/job/1612972
# bad: [0b90c3b6d76ea512dc3dac8fb30215e175b0019a] Add linux-next specific f=
iles for 20250728
git bisect bad 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
# test job: [8f39ed5e760dad5ca25eb6a49264cd22ec971c63] https://lava.sirena.=
org.uk/scheduler/job/1613241
# good: [8f39ed5e760dad5ca25eb6a49264cd22ec971c63] Merge branch 'main' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good 8f39ed5e760dad5ca25eb6a49264cd22ec971c63
# test job: [3935bbac1876808a0199d8b3724f1e9a225cc6a9] https://lava.sirena.=
org.uk/scheduler/job/1613371
# good: [3935bbac1876808a0199d8b3724f1e9a225cc6a9] Merge branch 'next' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
git bisect good 3935bbac1876808a0199d8b3724f1e9a225cc6a9
# test job: [c87c8601aa83e2d78894181ac9eff9ec26cc10a7] https://lava.sirena.=
org.uk/scheduler/job/1613389
# good: [c87c8601aa83e2d78894181ac9eff9ec26cc10a7] Merge branch 'tty-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
git bisect good c87c8601aa83e2d78894181ac9eff9ec26cc10a7
# test job: [fcf2858f22433b60a33f86ca56bed8657b263539] https://lava.sirena.=
org.uk/scheduler/job/1613493
# bad: [fcf2858f22433b60a33f86ca56bed8657b263539] Merge branch 'for-next' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git
git bisect bad fcf2858f22433b60a33f86ca56bed8657b263539
# test job: [05ef423f543d8f5f41f0bc66510562906120b8a4] https://lava.sirena.=
org.uk/scheduler/job/1613626
# bad: [05ef423f543d8f5f41f0bc66510562906120b8a4] Merge branch 'next' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git
git bisect bad 05ef423f543d8f5f41f0bc66510562906120b8a4
# test job: [0eb8d7b25397330beab8ee62c681975b79f37223] https://lava.sirena.=
org.uk/scheduler/job/1613798
# good: [0eb8d7b25397330beab8ee62c681975b79f37223] iio: adc: ad7173: fix ch=
annels index for syscalib_mode
git bisect good 0eb8d7b25397330beab8ee62c681975b79f37223
# test job: [b13b41cc3dc1811189b9cbeb04d11d8bef474679] https://lava.sirena.=
org.uk/scheduler/job/1613833
# good: [b13b41cc3dc1811189b9cbeb04d11d8bef474679] misc: ti_fpc202: Switch =
to of_fwnode_handle()
git bisect good b13b41cc3dc1811189b9cbeb04d11d8bef474679
# test job: [351e07e6b2ecc16ef8669713b14b6f67518c945d] https://lava.sirena.=
org.uk/scheduler/job/1613891
# good: [351e07e6b2ecc16ef8669713b14b6f67518c945d] phy: cadence-torrent: Ad=
d PCIe multilink + USB with same SSC register config for 100 MHz refclk
git bisect good 351e07e6b2ecc16ef8669713b14b6f67518c945d
# test job: [4a3556b81b99f0c8c0358f7cc6801a62b4538fe2] https://lava.sirena.=
org.uk/scheduler/job/1613931
# good: [4a3556b81b99f0c8c0358f7cc6801a62b4538fe2] phy: qcom: phy-qcom-m31:=
 Update IPQ5332 M31 USB phy initialization sequence
git bisect good 4a3556b81b99f0c8c0358f7cc6801a62b4538fe2
# test job: [7eca4399060def1a65098564ad84e327d8388d4c] https://lava.sirena.=
org.uk/scheduler/job/1614008
# good: [7eca4399060def1a65098564ad84e327d8388d4c] coresight: catu: Support=
 atclk
git bisect good 7eca4399060def1a65098564ad84e327d8388d4c
# test job: [7471c81e60b9f0945d33577efe467c9eef2476e5] https://lava.sirena.=
org.uk/scheduler/job/1614054
# bad: [7471c81e60b9f0945d33577efe467c9eef2476e5] coresight: Refactor drive=
r data allocation
git bisect bad 7471c81e60b9f0945d33577efe467c9eef2476e5
# test job: [90b0000bd5016bcfeccfe4c7d5276637aa380e76] https://lava.sirena.=
org.uk/scheduler/job/1614124
# bad: [90b0000bd5016bcfeccfe4c7d5276637aa380e76] coresight: Appropriately =
disable trace bus clocks
git bisect bad 90b0000bd5016bcfeccfe4c7d5276637aa380e76
# test job: [ce15ee28bdddc49d18c4e296859456b819cf0690] https://lava.sirena.=
org.uk/scheduler/job/1614174
# bad: [ce15ee28bdddc49d18c4e296859456b819cf0690] coresight: Appropriately =
disable programming clocks
git bisect bad ce15ee28bdddc49d18c4e296859456b819cf0690
# test job: [14fb833b820422bc1cdb18d2e1a35eccbf9789de] https://lava.sirena.=
org.uk/scheduler/job/1614220
# good: [14fb833b820422bc1cdb18d2e1a35eccbf9789de] coresight: etm4x: Suppor=
t atclk
git bisect good 14fb833b820422bc1cdb18d2e1a35eccbf9789de
# first bad commit: [ce15ee28bdddc49d18c4e296859456b819cf0690] coresight: A=
ppropriately disable programming clocks

--7e/I2qI4FRkfCUIf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmiHouMACgkQJNaLcl1U
h9BjnAf+NWD2fdm1d4ZG0pBVXyQW71E7g9rLQ23wPpTzBKRw60ABTRn42dddbY85
9M8XOxV5+TvYRtynm/45ZQ/k9Pku6Nt3SaEO1pl/1meCpnwaOS2biuJdXOvmX3jZ
jGaAUSZWq8rU06RWWnK/bDfpNKxyIT8PNIKLrKV7qn1ZjLWom1fwY6dIdG9NarhG
I4CHzJaZ6lzXO3Jb6gukHHuvDh+amUUWN1YWltFEtSN1DgBwhyJnVhmHFPBPAEoW
/ltTUW5weawtuOWB4WY41Ic+DGyHaGmAG7ug53RNcEEImkFGMzikQmbgYxfL4yil
rf+rTcC+DFAieIcsiXoeoWa7zLngGA==
=EYl5
-----END PGP SIGNATURE-----

--7e/I2qI4FRkfCUIf--

