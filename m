Return-Path: <linux-kernel+bounces-826138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 101BDB8DA05
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACBEE7A9C9B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF925B1FC;
	Sun, 21 Sep 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H59w8IDw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0034BA36;
	Sun, 21 Sep 2025 11:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758453954; cv=none; b=fushzvRgd7maHGfS7gUamu06I9m2hfX1FXkI3AJus4uCuNHTyffrHZUujoMnDkpChsaIEbGNEI9nZP0mnws/VHFlWu1nBO5d9EpQ2cr64ZAwbIrrYtFhDp28vgErR1fYLUVjl7svzoKPT/+onl7zbKaGxXHm/sQSZFGOyfZw9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758453954; c=relaxed/simple;
	bh=s9p7AnSm2SVyC7g7GOXgkO/x4Z9HefOiYXNgEGYVaBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbbmqJYYKZMdWfVJ8azku9/gOGR/t+Z1ewuboG5ylovw09LA/jxMB0wY9CksL60oGwWjYgNNl40AdE7TlfHWvGdaDkJKLE7SINSihb0VDCZAl61xTwkRD6dTOZT93r1stJdfYR2m9ux9H33RsEc40u06+14Fs06hVgvIMesHMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H59w8IDw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF94C4CEE7;
	Sun, 21 Sep 2025 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758453954;
	bh=s9p7AnSm2SVyC7g7GOXgkO/x4Z9HefOiYXNgEGYVaBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H59w8IDwMD1XkO/r82c6X9Zw+D5f9nlE+G3noh9CprII45onOUpGPCSMmnj5i1cjU
	 ookjkE1HX/OHYGgG/DH8j3G3QFYMmEt1o0F9of1MfWfVtdrZ3XP+UMD0kpQQNGpLdn
	 Dc3EXP1Tryze505P3IksEc21mRaxrFODqZyaWDtrgMlItcERvgiWpoCjEDWy0rDubl
	 /BC4tP44BzZ1hkdDKhr8jvSgMm8WjpQkn65MvwAaLQhrl3Ec7TmwBav9A/no0I79Hf
	 4kXc3yd2IiRw/V7LEQr/VyXgCrMFfHFT4Kf/38fZhzues3k5KasyI7RDP8tFeum5eZ
	 U/qrxetMWwSkQ==
Date: Sun, 21 Sep 2025 12:25:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/26] clk: amlogic: clock controllers clean-up and
 factorisation
Message-ID: <b88a947c-7074-4fed-8283-c278b573a7ca@sirena.org.uk>
References: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E60cnk4Xf02DS9Qr"
Content-Disposition: inline
In-Reply-To: <20250702-meson-clk-cleanup-24-v1-0-e163c9a1fc21@baylibre.com>
X-Cookie: Even a hawk is an eagle among crows.


--E60cnk4Xf02DS9Qr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 02, 2025 at 05:25:58PM +0200, Jerome Brunet wrote:
> The work on this patchset started with the submission of the Amlogic t7
> peripheral clock controller [1]. This controller is fairly similar to
> existing controllers. Once again, it redefines the peripheral clock macro,
> the probe function and composite clock helpers, even if it is almost the
> same as in other controllers. This code duplication trend has been going =
on
> for too long and now is the time to properly address the problem.

Friday's -next breaks the boot for me on the Libretch Alta.  The system
doesn't show any output on the console unfortunately:

   https://lava.sirena.org.uk/scheduler/job/1853204#L1606

Unfortunately earlycon isn't turned on, I'll try to do so at tomorrow or
Tuesday.

A bisect points to the patch 4c4e17f27013 ("clk: amlogic: naming
consistency alignment") which looks like it's a squash of several of the
patches here.  Due to issues with the bootloader it could potentially be
an adjacent commit but this looks suspiciously relevant.  Bisect log, my
infrastructure does retry the boot a lot on these boards so even if the
final error is a bootloader issue there will likely have been boots that
start the kernel:

# bad: [846bd2225ec3cfa8be046655e02b9457ed41973e] Add linux-next specific f=
iles for 20250919
# good: [474052984673a850ad15d74f479f445cdeb5ce24] Merge branch 'for-linux-=
next-fixes' of https://gitlab.freedesktop.org/drm/misc/kernel.git
# good: [abe962346ef420998d47ba1c2fe591582f69e92e] regulator: Fix MAX77838 =
selection
# good: [ab63e9910d2d3ea4b8e6c08812258a676defcb9c] spi: mt65xx: add dual an=
d quad mode for standard spi device
# good: [8b84d712ad849172f6bbcad57534b284d942b0b5] regulator: spacemit: sup=
port SpacemiT P1 regulators
# good: [88d0d17192c5a850dc07bb38035b69c4cefde270] ASoC: dt-bindings: add b=
indings for pm4125 audio codec
# good: [8d7de4a014f589c1776959f7fdadbf7b12045aac] ASoC: dt-bindings: asahi=
-kasei,ak4458: Reference common DAI properties
# good: [7eaf684bc48923b5584fc119e8c477be2cdb3eb2] xfs: remove the xfs_exte=
nt32_t typedef
# good: [6a1f303cba45fa3b612d5a2898b1b1b045eb74e3] regulator: max77838: add=
 max77838 regulator driver
# good: [ecdca1af962b366d27067cd61da2f37baf418d20] Merge tag 'qcom-drivers-=
for-6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux int=
o soc/drivers
# good: [9c616f970dfe4a2f3702fc64b5939cf0b5ee5075] Merge branch 'vfs-6.18.a=
fs' into vfs.all
# good: [8b184c34806e5da4d4847fabd3faeff38b47e70a] ASoC: Intel: hda-sdw-bpt=
: set persistent_buffer false
# good: [18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4] spi: amlogic: Fix error =
checking on regmap_write call
# good: [d4a36db5639db032a434aef968f9188a600139ec] panic/printk: replace ot=
her_cpu_in_panic() with panic_on_other_cpu()
# good: [2b7220a18ef5660749b46e385f4fe918b806e7ed] Merge branch 'clk-thead'=
 into clk-next
# good: [1d6161617c10435e970d3bb3ef5de124b94fe719] arm64: dts: ti: k3-am62-=
ti-ipc-firmware: Refactor IPC cfg into new dtsi
# good: [30db1b21fa37a2f37c7f4d71864405a05e889833] spi: axi-spi-engine: use=
 adi_axi_pcore_ver_gteq()
# good: [1217b573978482ae7d21dc5c0bf5aa5007b24f90] ASoC: codecs: pcm1754: a=
dd pcm1754 dac driver
# good: [59ba108806516adeaed51a536d55d4f5e9645881] ASoC: dt-bindings: linux=
,spdif: Add "port" node
# good: [2e0fd4583d0efcdc260e61a22666c8368f505353] rust: regulator: add dev=
m_enable and devm_enable_optional
# good: [6a129b2ca5c533aec89fbeb58470811cc4102642] MAINTAINERS: Add an entr=
y for Amlogic spifc driver
# good: [473a19211c4dc762e6ecab9c3e6583afd3200817] arm64: dts: qcom: lemans=
-evk: Add sound card
# good: [e696e7aa439f1134ca5f91d6c86b332b72e57d9c] arm64: dts: qcom: x1e781=
00-t14s-oled: Add eDP panel
# good: [d9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595] spi: cadence-quadspi: Us=
e BIT() macros where possible
# good: [e5b4ad2183f7ab18aaf7c73a120d17241ee58e97] ASoC: cs-amp-lib-test: A=
dd test for getting cal data from HP EFI
# good: [452ed5c724038c269518f9df20599ed5134f36d0] mfd: at91-usart: Make it=
 selectable for ARCH_MICROCHIP
# good: [1cf87861a2e02432fb68f8bcc8f20a8e42acde59] ASoC: codecs: tlv320dac3=
3: Convert to use gpiod api
# good: [5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5] regulator: dt-bindings: =
rpi-panel: Split 7" Raspberry Pi 720x1280 v2 binding
# good: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b] ASoC: Intel: bytcr_rt565=
1: Fix invalid quirk input mapping
# good: [2c625f0fe2db4e6a58877ce2318df3aa312eb791] spi: dt-bindings: samsun=
g: Drop S3C2443
# good: [b6f90511c165a2c546650f26d810280237440cb1] clk: qcom: regmap-divide=
r: convert from round_rate() to determine_rate()
# good: [7d083666123a425ba9f81dff1a52955b1f226540] ASoC: renesas: rz-ssi: U=
se guard() for spin locks
# good: [b497e1a1a2b10c4ddb28064fba229365ae03311a] regulator: pf530x: Add a=
 driver for the NXP PF5300 Regulator
# good: [9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634] ASoC: replace use of sys=
tem_unbound_wq with system_dfl_wq
# good: [0ccc1eeda155c947d88ef053e0b54e434e218ee2] ASoC: dt-bindings: wlf,w=
m8960: Document routing strings (pin names)
# good: [7748328c2fd82efed24257b2bfd796eb1fa1d09b] ASoC: dt-bindings: qcom,=
lpass-va-macro: Update bindings for clocks to support ADSP
# good: [dd7ae5b8b3c291c0206f127a564ae1e316705ca0] ASoC: cs42l43: Shutdown =
jack detection on suspend
# good: [5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd] spi: spi-fsl-dspi: Repor=
t FIFO overflows as errors
# good: [94b39cb3ad6db935b585988b36378884199cd5fc] spi: mxs: fix "transfere=
d"->"transferred"
# good: [ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c] ASoC: codecs: lpass-wsa-=
macro: add Codev version 2.9
# good: [ce57b718006a069226b5e5d3afe7969acd59154e] ASoC: Intel: avs: ssm456=
7: Adjust platform name
# good: [3279052eab235bfb7130b1fabc74029c2260ed8d] ASoC: SOF: ipc4-topology=
: Fix a less than zero check on a u32
# good: [9d35d068fb138160709e04e3ee97fe29a6f8615b] regulator: scmi: Use int=
 type to store negative error codes
# good: [8f57dcf39fd0864f5f3e6701fe885e55f45d0d3a] ASoC: qcom: audioreach: =
convert to cpu endainess type before accessing
# good: [8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb] ASoC: soc-dapm: rename s=
nd_soc_kcontrol_component() to snd_soc_kcontrol_to_component()
# good: [3d439e1ec3368fae17db379354bd7a9e568ca0ab] ASoC: sof: ipc4-topology=
: Add support to sched_domain attribute
# good: [5c39bc498f5ff7ef016abf3f16698f3e8db79677] ASoC: SOF: Intel: only d=
etect codecs when HDA DSP probe
# good: [07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9] ASoC: SOF: sof-client: I=
ntroduce sof_client_dev_entry structure
# good: [f522da9ab56c96db8703b2ea0f09be7cdc3bffeb] ASoC: doc: Internally li=
nk to Writing an ALSA Driver docs
# good: [d57d27171c92e9049d5301785fb38de127b28fbf] ASoC: SOF: sof-client-pr=
obes: Add available points_info(), IPC4 only
# good: [f7c41911ad744177d8289820f01009dc93d8f91c] ASoC: SOF: ipc4-topology=
: Add support for float sample type
# good: [400915493f53b10085648b387cdbb4da5612ebfc] dt-bindings: Add Actiont=
ec vendor prefix
# good: [a37280daa4d583c7212681c49b285de9464a5200] ASoC: Intel: avs: Allow =
i2s test and non-test boards to coexist
# good: [b088b6189a4066b97cef459afd312fd168a76dea] ASoC: mediatek: common: =
Switch to for_each_available_child_of_node_scoped()
# good: [c42e36a488c7e01f833fc9f4814f735b66b2d494] spi: Drop dev_pm_domain_=
detach() call
# good: [f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c] regmap: use int type to =
store negative error codes
# good: [ff9a7857b7848227788f113d6dc6a72e989084e0] spi: rb4xx: use devm for=
 clk_prepare_enable
# good: [edb5c1f885207d1d74e8a1528e6937e02829ee6e] ASoC: renesas: msiof: st=
art DMAC first
# good: [5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4] ASoC: amd: acp: Remove (=
explicitly) unused header
# good: [899fb38dd76dd3ede425bbaf8a96d390180a5d1c] regulator: core: Remove =
redundant ternary operators
# good: [11f5c5f9e43e9020bae452232983fe98e7abfce0] ASoC: qcom: use int type=
 to store negative error codes
# good: [e2ab5f600bb01d3625d667d97b3eb7538e388336] rust: regulator: use `to=
_result` for error handling
# good: [a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c] ASoC: tlv320aic32x4: use=
 dev_err_probe() for regulators
# good: [7d11b8c260ea68ce8f420ad467b04b21ea34b011] dt-bindings: vendor-pref=
ixes: Add HINLINK
# good: [f840737d1746398c2993be34bfdc80bdc19ecae2] ASoC: SOF: imx: Remove t=
he use of dev_err_probe()
# good: [71b12166a2be511482226b21105f1952cd8b7fa5] arm64: dts: qcom: sc8280=
xp: Describe GPI DMA controller nodes
# good: [9b541c18a8cfbf9f01d3dc5e794104cda1708329] arm64: dts: imx95: Add m=
ore V2X MUs
# good: [d78e48ebe04e9566f8ecbf51471e80da3adbceeb] ASoC: dt-bindings: Minor=
 whitespace cleanup in example
# good: [96bcb34df55f7fee99795127c796315950c94fed] ASoC: test-component: Us=
e kcalloc() instead of kzalloc()
# good: [c232495d28ca092d0c39b10e35d3d613bd2414ab] ASoC: dt-bindings: omap-=
twl4030: convert to DT schema
# good: [f9de6cdf4cf8c932ee94f6e25cd7434a97c78bf3] s390/sclp: Move memory h=
otplug code for better modularity
# good: [ec0be3cdf40b5302248f3fb27a911cc630e8b855] regulator: consumer.rst:=
 document bulk operations
# good: [27848c082ba0b22850fd9fb7b185c015423dcdc7] spi: s3c64xx: Remove the=
 use of dev_err_probe()
# good: [c1dd310f1d76b4b13f1854618087af2513140897] spi: SPISG: Use devm_kca=
lloc() in aml_spisg_clk_init()
# good: [da9881d00153cc6d3917f6b74144b1d41b58338c] ASoC: qcom: audioreach: =
add support for SMECNS module
# good: [be5d60d94b982d46a734750d93624bd85a1c7089] arm64: dts: renesas: r9a=
09g077: Add DT nodes for SCI channels 1-5
# good: [cf65182247761f7993737b710afe8c781699356b] ASoC: codecs: wsa883x: H=
andle shared reset GPIO for WSA883x speakers
# good: [2a55135201d5e24b80b7624880ff42eafd8e320c] ASoC: Intel: avs: Stream=
line register-component function names
# good: [550bc517e59347b3b1af7d290eac4fb1411a3d4e] regulator: bd718x7: Use =
kcalloc() instead of kzalloc()
# good: [daf855f76a1210ceed9541f71ac5dd9be02018a6] ASoC: es8323: enable DAP=
M power widgets for playback DAC
# good: [0056b410355713556d8a10306f82e55b28d33ba8] spi: offload trigger: ad=
i-util-sigma-delta: clean up imports
# good: [90179609efa421b1ccc7d8eafbc078bafb25777c] spi: spl022: use min_t()=
 to improve code
# good: [a46e95c81e3a28926ab1904d9f754fef8318074d] ASoC: wl1273: Remove
# good: [48124569bbc6bfda1df3e9ee17b19d559f4b1aa3] spi: remove unneeded 'fa=
st_io' parameter in regmap_config
# good: [258384d8ce365dddd6c5c15204de8ccd53a7ab0a] ASoC: es8323: enable DAP=
M power widgets for playback DAC and output
# good: [6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d] regulator: rt5133: Fix s=
pelling mistake "regualtor" -> "regulator"
# good: [0e62438e476494a1891a8822b9785bc6e73e9c3f] ASoC: Intel: sst: Remove=
 redundant semicolons
# good: [37533933bfe92cd5a99ef4743f31dac62ccc8de0] regulator: remove unneed=
ed 'fast_io' parameter in regmap_config
# good: [5c36b86d2bf68fbcad16169983ef7ee8c537db59] regmap: Remove superfluo=
us check for !config in __regmap_init()
# good: [714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb] regulator: rt5133: Add R=
T5133 PMIC regulator Support
# good: [9c45f95222beecd6a284fd1284d54dd7a772cf59] spi: spi-qpic-snand: han=
dle 'use_ecc' parameter of qcom_spi_config_cw_read()
# good: [bab4ab484a6ca170847da9bffe86f1fa90df4bbe] ASoC: dt-bindings: Conve=
rt brcm,bcm2835-i2s to DT schema
# good: [b832b19318534bb4f1673b24d78037fee339c679] spi: loopback-test: Don'=
t use %pK through printk
# good: [8c02c8353460f8630313aef6810f34e134a3c1ee] ASoC: dt-bindings: realt=
ek,alc5623: convert to DT schema
# good: [6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1] spi: spi-qpic-snand: rem=
ove 'clr*status' members of struct 'qpic_ecc'
# good: [a54ef14188519a0994d0264f701f5771815fa11e] regulator: dt-bindings: =
Clean-up active-semi,act8945a duplication
# good: [c494de2e00fb06d5b62708a91d7dda701abc52f4] arm64: dts: renesas: r9a=
09g057: Add RSPI nodes
# good: [2291a2186305faaf8525d57849d8ba12ad63f5e7] MAINTAINERS: Add entry f=
or FourSemi audio amplifiers
# good: [595b7f155b926460a00776cc581e4dcd01220006] ASoC: Intel: avs: Condit=
ional-path support
# good: [cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34] ASoC: soc-component: unp=
ack snd_soc_component_init_bias_level()
# good: [a1d0b0ae65ae3f32597edfbb547f16c75601cd87] spi: spi-qpic-snand: avo=
id double assignment in qcom_spi_probe()
# good: [3059067fd3378a5454e7928c08d20bf3ef186760] ASoC: cs48l32: Use PTR_E=
RR_OR_ZERO() to simplify code
# good: [2d86d2585ab929a143d1e6f8963da1499e33bf13] ASoC: pxa: add GPIOLIB_L=
EGACY dependency
# good: [9a200cbdb54349909a42b45379e792e4b39dd223] rust: regulator: impleme=
nt Send and Sync for Regulator<T>
# good: [886f42ce96e7ce80545704e7168a9c6b60cd6c03] regmap: mmio: Add missin=
g MODULE_DESCRIPTION()
# good: [162e23657e5379f07c6404dbfbf4367cb438ea7d] regulator: pf0900: Add P=
MIC PF0900 support
git bisect start '846bd2225ec3cfa8be046655e02b9457ed41973e' '474052984673a8=
50ad15d74f479f445cdeb5ce24' 'abe962346ef420998d47ba1c2fe591582f69e92e' 'ab6=
3e9910d2d3ea4b8e6c08812258a676defcb9c' '8b84d712ad849172f6bbcad57534b284d94=
2b0b5' '88d0d17192c5a850dc07bb38035b69c4cefde270' '8d7de4a014f589c1776959f7=
fdadbf7b12045aac' '7eaf684bc48923b5584fc119e8c477be2cdb3eb2' '6a1f303cba45f=
a3b612d5a2898b1b1b045eb74e3' 'ecdca1af962b366d27067cd61da2f37baf418d20' '9c=
616f970dfe4a2f3702fc64b5939cf0b5ee5075' '8b184c34806e5da4d4847fabd3faeff38b=
47e70a' '18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4' 'd4a36db5639db032a434aef=
968f9188a600139ec' '2b7220a18ef5660749b46e385f4fe918b806e7ed' '1d6161617c10=
435e970d3bb3ef5de124b94fe719' '30db1b21fa37a2f37c7f4d71864405a05e889833' '1=
217b573978482ae7d21dc5c0bf5aa5007b24f90' '59ba108806516adeaed51a536d55d4f5e=
9645881' '2e0fd4583d0efcdc260e61a22666c8368f505353' '6a129b2ca5c533aec89fbe=
b58470811cc4102642' '473a19211c4dc762e6ecab9c3e6583afd3200817' 'e696e7aa439=
f1134ca5f91d6c86b332b72e57d9c' 'd9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595' '=
e5b4ad2183f7ab18aaf7c73a120d17241ee58e97' '452ed5c724038c269518f9df20599ed5=
134f36d0' '1cf87861a2e02432fb68f8bcc8f20a8e42acde59' '5bad16482c2a7e788c042=
d98f3e97d3b2bbc8cc5' '4336efb59ef364e691ef829a73d9dbd4d5ed7c7b' '2c625f0fe2=
db4e6a58877ce2318df3aa312eb791' 'b6f90511c165a2c546650f26d810280237440cb1' =
'7d083666123a425ba9f81dff1a52955b1f226540' 'b497e1a1a2b10c4ddb28064fba22936=
5ae03311a' '9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634' '0ccc1eeda155c947d88e=
f053e0b54e434e218ee2' '7748328c2fd82efed24257b2bfd796eb1fa1d09b' 'dd7ae5b8b=
3c291c0206f127a564ae1e316705ca0' '5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd'=
 '94b39cb3ad6db935b585988b36378884199cd5fc' 'ce1a46b2d6a8465a86f7a6f71beb4c=
6de83bce5c' 'ce57b718006a069226b5e5d3afe7969acd59154e' '3279052eab235bfb713=
0b1fabc74029c2260ed8d' '9d35d068fb138160709e04e3ee97fe29a6f8615b' '8f57dcf3=
9fd0864f5f3e6701fe885e55f45d0d3a' '8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb=
' '3d439e1ec3368fae17db379354bd7a9e568ca0ab' '5c39bc498f5ff7ef016abf3f16698=
f3e8db79677' '07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9' 'f522da9ab56c96db87=
03b2ea0f09be7cdc3bffeb' 'd57d27171c92e9049d5301785fb38de127b28fbf' 'f7c4191=
1ad744177d8289820f01009dc93d8f91c' '400915493f53b10085648b387cdbb4da5612ebf=
c' 'a37280daa4d583c7212681c49b285de9464a5200' 'b088b6189a4066b97cef459afd31=
2fd168a76dea' 'c42e36a488c7e01f833fc9f4814f735b66b2d494' 'f4672dc6e9c07643c=
8c755856ba8e9eb9ca95d0c' 'ff9a7857b7848227788f113d6dc6a72e989084e0' 'edb5c1=
f885207d1d74e8a1528e6937e02829ee6e' '5b4dcaf851df8c414bfc2ac3bf9c65fc942f3b=
e4' '899fb38dd76dd3ede425bbaf8a96d390180a5d1c' '11f5c5f9e43e9020bae45223298=
3fe98e7abfce0' 'e2ab5f600bb01d3625d667d97b3eb7538e388336' 'a12b74d2bd4724ee=
1883bc97ec93eac8fafc8d3c' '7d11b8c260ea68ce8f420ad467b04b21ea34b011' 'f8407=
37d1746398c2993be34bfdc80bdc19ecae2' '71b12166a2be511482226b21105f1952cd8b7=
fa5' '9b541c18a8cfbf9f01d3dc5e794104cda1708329' 'd78e48ebe04e9566f8ecbf5147=
1e80da3adbceeb' '96bcb34df55f7fee99795127c796315950c94fed' 'c232495d28ca092=
d0c39b10e35d3d613bd2414ab' 'f9de6cdf4cf8c932ee94f6e25cd7434a97c78bf3' 'ec0b=
e3cdf40b5302248f3fb27a911cc630e8b855' '27848c082ba0b22850fd9fb7b185c015423d=
cdc7' 'c1dd310f1d76b4b13f1854618087af2513140897' 'da9881d00153cc6d3917f6b74=
144b1d41b58338c' 'be5d60d94b982d46a734750d93624bd85a1c7089' 'cf65182247761f=
7993737b710afe8c781699356b' '2a55135201d5e24b80b7624880ff42eafd8e320c' '550=
bc517e59347b3b1af7d290eac4fb1411a3d4e' 'daf855f76a1210ceed9541f71ac5dd9be02=
018a6' '0056b410355713556d8a10306f82e55b28d33ba8' '90179609efa421b1ccc7d8ea=
fbc078bafb25777c' 'a46e95c81e3a28926ab1904d9f754fef8318074d' '48124569bbc6b=
fda1df3e9ee17b19d559f4b1aa3' '258384d8ce365dddd6c5c15204de8ccd53a7ab0a' '6d=
068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d' '0e62438e476494a1891a8822b9785bc6e7=
3e9c3f' '37533933bfe92cd5a99ef4743f31dac62ccc8de0' '5c36b86d2bf68fbcad16169=
983ef7ee8c537db59' '714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb' '9c45f95222be=
ecd6a284fd1284d54dd7a772cf59' 'bab4ab484a6ca170847da9bffe86f1fa90df4bbe' 'b=
832b19318534bb4f1673b24d78037fee339c679' '8c02c8353460f8630313aef6810f34e13=
4a3c1ee' '6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1' 'a54ef14188519a0994d026=
4f701f5771815fa11e' 'c494de2e00fb06d5b62708a91d7dda701abc52f4' '2291a218630=
5faaf8525d57849d8ba12ad63f5e7' '595b7f155b926460a00776cc581e4dcd01220006' '=
cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34' 'a1d0b0ae65ae3f32597edfbb547f16c7=
5601cd87' '3059067fd3378a5454e7928c08d20bf3ef186760' '2d86d2585ab929a143d1e=
6f8963da1499e33bf13' '9a200cbdb54349909a42b45379e792e4b39dd223' '886f42ce96=
e7ce80545704e7168a9c6b60cd6c03' '162e23657e5379f07c6404dbfbf4367cb438ea7d'
# test job: [abe962346ef420998d47ba1c2fe591582f69e92e] https://lava.sirena.=
org.uk/scheduler/job/1840606
# test job: [ab63e9910d2d3ea4b8e6c08812258a676defcb9c] https://lava.sirena.=
org.uk/scheduler/job/1838173
# test job: [8b84d712ad849172f6bbcad57534b284d942b0b5] https://lava.sirena.=
org.uk/scheduler/job/1834295
# test job: [88d0d17192c5a850dc07bb38035b69c4cefde270] https://lava.sirena.=
org.uk/scheduler/job/1833971
# test job: [8d7de4a014f589c1776959f7fdadbf7b12045aac] https://lava.sirena.=
org.uk/scheduler/job/1833174
# test job: [7eaf684bc48923b5584fc119e8c477be2cdb3eb2] https://lava.sirena.=
org.uk/scheduler/job/1850040
# test job: [6a1f303cba45fa3b612d5a2898b1b1b045eb74e3] https://lava.sirena.=
org.uk/scheduler/job/1830634
# test job: [ecdca1af962b366d27067cd61da2f37baf418d20] https://lava.sirena.=
org.uk/scheduler/job/1844747
# test job: [9c616f970dfe4a2f3702fc64b5939cf0b5ee5075] https://lava.sirena.=
org.uk/scheduler/job/1850448
# test job: [8b184c34806e5da4d4847fabd3faeff38b47e70a] https://lava.sirena.=
org.uk/scheduler/job/1829416
# test job: [18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4] https://lava.sirena.=
org.uk/scheduler/job/1829113
# test job: [d4a36db5639db032a434aef968f9188a600139ec] https://lava.sirena.=
org.uk/scheduler/job/1845138
# test job: [2b7220a18ef5660749b46e385f4fe918b806e7ed] https://lava.sirena.=
org.uk/scheduler/job/1850731
# test job: [1d6161617c10435e970d3bb3ef5de124b94fe719] https://lava.sirena.=
org.uk/scheduler/job/1845014
# test job: [30db1b21fa37a2f37c7f4d71864405a05e889833] https://lava.sirena.=
org.uk/scheduler/job/1811017
# test job: [1217b573978482ae7d21dc5c0bf5aa5007b24f90] https://lava.sirena.=
org.uk/scheduler/job/1810173
# test job: [59ba108806516adeaed51a536d55d4f5e9645881] https://lava.sirena.=
org.uk/scheduler/job/1809981
# test job: [2e0fd4583d0efcdc260e61a22666c8368f505353] https://lava.sirena.=
org.uk/scheduler/job/1806800
# test job: [6a129b2ca5c533aec89fbeb58470811cc4102642] https://lava.sirena.=
org.uk/scheduler/job/1805768
# test job: [473a19211c4dc762e6ecab9c3e6583afd3200817] https://lava.sirena.=
org.uk/scheduler/job/1844860
# test job: [e696e7aa439f1134ca5f91d6c86b332b72e57d9c] https://lava.sirena.=
org.uk/scheduler/job/1844148
# test job: [d9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595] https://lava.sirena.=
org.uk/scheduler/job/1800082
# test job: [e5b4ad2183f7ab18aaf7c73a120d17241ee58e97] https://lava.sirena.=
org.uk/scheduler/job/1800033
# test job: [452ed5c724038c269518f9df20599ed5134f36d0] https://lava.sirena.=
org.uk/scheduler/job/1844963
# test job: [1cf87861a2e02432fb68f8bcc8f20a8e42acde59] https://lava.sirena.=
org.uk/scheduler/job/1795720
# test job: [5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5] https://lava.sirena.=
org.uk/scheduler/job/1796218
# test job: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b] https://lava.sirena.=
org.uk/scheduler/job/1795886
# test job: [2c625f0fe2db4e6a58877ce2318df3aa312eb791] https://lava.sirena.=
org.uk/scheduler/job/1794528
# test job: [b6f90511c165a2c546650f26d810280237440cb1] https://lava.sirena.=
org.uk/scheduler/job/1846076
# test job: [7d083666123a425ba9f81dff1a52955b1f226540] https://lava.sirena.=
org.uk/scheduler/job/1794833
# test job: [b497e1a1a2b10c4ddb28064fba229365ae03311a] https://lava.sirena.=
org.uk/scheduler/job/1780280
# test job: [9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634] https://lava.sirena.=
org.uk/scheduler/job/1779412
# test job: [0ccc1eeda155c947d88ef053e0b54e434e218ee2] https://lava.sirena.=
org.uk/scheduler/job/1773850
# test job: [7748328c2fd82efed24257b2bfd796eb1fa1d09b] https://lava.sirena.=
org.uk/scheduler/job/1773401
# test job: [dd7ae5b8b3c291c0206f127a564ae1e316705ca0] https://lava.sirena.=
org.uk/scheduler/job/1773884
# test job: [5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd] https://lava.sirena.=
org.uk/scheduler/job/1769270
# test job: [94b39cb3ad6db935b585988b36378884199cd5fc] https://lava.sirena.=
org.uk/scheduler/job/1769571
# test job: [ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c] https://lava.sirena.=
org.uk/scheduler/job/1769702
# test job: [ce57b718006a069226b5e5d3afe7969acd59154e] https://lava.sirena.=
org.uk/scheduler/job/1769630
# test job: [3279052eab235bfb7130b1fabc74029c2260ed8d] https://lava.sirena.=
org.uk/scheduler/job/1762396
# test job: [9d35d068fb138160709e04e3ee97fe29a6f8615b] https://lava.sirena.=
org.uk/scheduler/job/1759988
# test job: [8f57dcf39fd0864f5f3e6701fe885e55f45d0d3a] https://lava.sirena.=
org.uk/scheduler/job/1760154
# test job: [8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb] https://lava.sirena.=
org.uk/scheduler/job/1759919
# test job: [3d439e1ec3368fae17db379354bd7a9e568ca0ab] https://lava.sirena.=
org.uk/scheduler/job/1753468
# test job: [5c39bc498f5ff7ef016abf3f16698f3e8db79677] https://lava.sirena.=
org.uk/scheduler/job/1751960
# test job: [07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9] https://lava.sirena.=
org.uk/scheduler/job/1752548
# test job: [f522da9ab56c96db8703b2ea0f09be7cdc3bffeb] https://lava.sirena.=
org.uk/scheduler/job/1752037
# test job: [d57d27171c92e9049d5301785fb38de127b28fbf] https://lava.sirena.=
org.uk/scheduler/job/1752865
# test job: [f7c41911ad744177d8289820f01009dc93d8f91c] https://lava.sirena.=
org.uk/scheduler/job/1752878
# test job: [400915493f53b10085648b387cdbb4da5612ebfc] https://lava.sirena.=
org.uk/scheduler/job/1844661
# test job: [a37280daa4d583c7212681c49b285de9464a5200] https://lava.sirena.=
org.uk/scheduler/job/1746902
# test job: [b088b6189a4066b97cef459afd312fd168a76dea] https://lava.sirena.=
org.uk/scheduler/job/1747024
# test job: [c42e36a488c7e01f833fc9f4814f735b66b2d494] https://lava.sirena.=
org.uk/scheduler/job/1746769
# test job: [f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c] https://lava.sirena.=
org.uk/scheduler/job/1747903
# test job: [ff9a7857b7848227788f113d6dc6a72e989084e0] https://lava.sirena.=
org.uk/scheduler/job/1747043
# test job: [edb5c1f885207d1d74e8a1528e6937e02829ee6e] https://lava.sirena.=
org.uk/scheduler/job/1747281
# test job: [5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4] https://lava.sirena.=
org.uk/scheduler/job/1747762
# test job: [899fb38dd76dd3ede425bbaf8a96d390180a5d1c] https://lava.sirena.=
org.uk/scheduler/job/1747389
# test job: [11f5c5f9e43e9020bae452232983fe98e7abfce0] https://lava.sirena.=
org.uk/scheduler/job/1747482
# test job: [e2ab5f600bb01d3625d667d97b3eb7538e388336] https://lava.sirena.=
org.uk/scheduler/job/1747056
# test job: [a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c] https://lava.sirena.=
org.uk/scheduler/job/1734065
# test job: [7d11b8c260ea68ce8f420ad467b04b21ea34b011] https://lava.sirena.=
org.uk/scheduler/job/1846249
# test job: [f840737d1746398c2993be34bfdc80bdc19ecae2] https://lava.sirena.=
org.uk/scheduler/job/1727317
# test job: [71b12166a2be511482226b21105f1952cd8b7fa5] https://lava.sirena.=
org.uk/scheduler/job/1843829
# test job: [9b541c18a8cfbf9f01d3dc5e794104cda1708329] https://lava.sirena.=
org.uk/scheduler/job/1844380
# test job: [d78e48ebe04e9566f8ecbf51471e80da3adbceeb] https://lava.sirena.=
org.uk/scheduler/job/1706186
# test job: [96bcb34df55f7fee99795127c796315950c94fed] https://lava.sirena.=
org.uk/scheduler/job/1700387
# test job: [c232495d28ca092d0c39b10e35d3d613bd2414ab] https://lava.sirena.=
org.uk/scheduler/job/1699509
# test job: [f9de6cdf4cf8c932ee94f6e25cd7434a97c78bf3] https://lava.sirena.=
org.uk/scheduler/job/1844774
# test job: [ec0be3cdf40b5302248f3fb27a911cc630e8b855] https://lava.sirena.=
org.uk/scheduler/job/1694293
# test job: [27848c082ba0b22850fd9fb7b185c015423dcdc7] https://lava.sirena.=
org.uk/scheduler/job/1693120
# test job: [c1dd310f1d76b4b13f1854618087af2513140897] https://lava.sirena.=
org.uk/scheduler/job/1693448
# test job: [da9881d00153cc6d3917f6b74144b1d41b58338c] https://lava.sirena.=
org.uk/scheduler/job/1693616
# test job: [be5d60d94b982d46a734750d93624bd85a1c7089] https://lava.sirena.=
org.uk/scheduler/job/1845071
# test job: [cf65182247761f7993737b710afe8c781699356b] https://lava.sirena.=
org.uk/scheduler/job/1687518
# test job: [2a55135201d5e24b80b7624880ff42eafd8e320c] https://lava.sirena.=
org.uk/scheduler/job/1685778
# test job: [550bc517e59347b3b1af7d290eac4fb1411a3d4e] https://lava.sirena.=
org.uk/scheduler/job/1685903
# test job: [daf855f76a1210ceed9541f71ac5dd9be02018a6] https://lava.sirena.=
org.uk/scheduler/job/1686264
# test job: [0056b410355713556d8a10306f82e55b28d33ba8] https://lava.sirena.=
org.uk/scheduler/job/1686471
# test job: [90179609efa421b1ccc7d8eafbc078bafb25777c] https://lava.sirena.=
org.uk/scheduler/job/1687008
# test job: [a46e95c81e3a28926ab1904d9f754fef8318074d] https://lava.sirena.=
org.uk/scheduler/job/1673873
# test job: [48124569bbc6bfda1df3e9ee17b19d559f4b1aa3] https://lava.sirena.=
org.uk/scheduler/job/1670408
# test job: [258384d8ce365dddd6c5c15204de8ccd53a7ab0a] https://lava.sirena.=
org.uk/scheduler/job/1673491
# test job: [6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d] https://lava.sirena.=
org.uk/scheduler/job/1673168
# test job: [0e62438e476494a1891a8822b9785bc6e73e9c3f] https://lava.sirena.=
org.uk/scheduler/job/1669836
# test job: [37533933bfe92cd5a99ef4743f31dac62ccc8de0] https://lava.sirena.=
org.uk/scheduler/job/1668959
# test job: [5c36b86d2bf68fbcad16169983ef7ee8c537db59] https://lava.sirena.=
org.uk/scheduler/job/1667990
# test job: [714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb] https://lava.sirena.=
org.uk/scheduler/job/1667794
# test job: [9c45f95222beecd6a284fd1284d54dd7a772cf59] https://lava.sirena.=
org.uk/scheduler/job/1667620
# test job: [bab4ab484a6ca170847da9bffe86f1fa90df4bbe] https://lava.sirena.=
org.uk/scheduler/job/1664662
# test job: [b832b19318534bb4f1673b24d78037fee339c679] https://lava.sirena.=
org.uk/scheduler/job/1659194
# test job: [8c02c8353460f8630313aef6810f34e134a3c1ee] https://lava.sirena.=
org.uk/scheduler/job/1659263
# test job: [6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1] https://lava.sirena.=
org.uk/scheduler/job/1656644
# test job: [a54ef14188519a0994d0264f701f5771815fa11e] https://lava.sirena.=
org.uk/scheduler/job/1655988
# test job: [c494de2e00fb06d5b62708a91d7dda701abc52f4] https://lava.sirena.=
org.uk/scheduler/job/1843899
# test job: [2291a2186305faaf8525d57849d8ba12ad63f5e7] https://lava.sirena.=
org.uk/scheduler/job/1655730
# test job: [595b7f155b926460a00776cc581e4dcd01220006] https://lava.sirena.=
org.uk/scheduler/job/1657175
# test job: [cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34] https://lava.sirena.=
org.uk/scheduler/job/1657053
# test job: [a1d0b0ae65ae3f32597edfbb547f16c75601cd87] https://lava.sirena.=
org.uk/scheduler/job/1656117
# test job: [3059067fd3378a5454e7928c08d20bf3ef186760] https://lava.sirena.=
org.uk/scheduler/job/1653997
# test job: [2d86d2585ab929a143d1e6f8963da1499e33bf13] https://lava.sirena.=
org.uk/scheduler/job/1656944
# test job: [9a200cbdb54349909a42b45379e792e4b39dd223] https://lava.sirena.=
org.uk/scheduler/job/1657048
# test job: [886f42ce96e7ce80545704e7168a9c6b60cd6c03] https://lava.sirena.=
org.uk/scheduler/job/1657127
# test job: [162e23657e5379f07c6404dbfbf4367cb438ea7d] https://lava.sirena.=
org.uk/scheduler/job/1652976
# test job: [846bd2225ec3cfa8be046655e02b9457ed41973e] https://lava.sirena.=
org.uk/scheduler/job/1853618
# bad: [846bd2225ec3cfa8be046655e02b9457ed41973e] Add linux-next specific f=
iles for 20250919
git bisect bad 846bd2225ec3cfa8be046655e02b9457ed41973e
# test job: [89cda16c3f68b43f16237152c3cbfdb10097f3da] https://lava.sirena.=
org.uk/scheduler/job/1854673
# bad: [89cda16c3f68b43f16237152c3cbfdb10097f3da] Merge branch 'master' of =
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
git bisect bad 89cda16c3f68b43f16237152c3cbfdb10097f3da
# test job: [cddf2ce47b552f5f8aafd8027baa76b7a9a2ff4c] https://lava.sirena.=
org.uk/scheduler/job/1855126
# bad: [cddf2ce47b552f5f8aafd8027baa76b7a9a2ff4c] Merge branch 'for-next/ps=
tore' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect bad cddf2ce47b552f5f8aafd8027baa76b7a9a2ff4c
# skip: [8f8f91acbfb162f1245ddfffad4e7215ac3a440a] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
git bisect skip 8f8f91acbfb162f1245ddfffad4e7215ac3a440a
# test job: [103e90626d3a4032d22e8b09ff14600e71cda59c] https://lava.sirena.=
org.uk/scheduler/job/1855233
# good: [103e90626d3a4032d22e8b09ff14600e71cda59c] maple_tree: testing fix =
for spanning store on 32b
git bisect good 103e90626d3a4032d22e8b09ff14600e71cda59c
# skip: [e94125046bd821858edc1311b008523edd34e628] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git
git bisect skip e94125046bd821858edc1311b008523edd34e628
# test job: [df9a4d79f1decb1b85efa58a66bcf122d6b6c624] https://lava.sirena.=
org.uk/scheduler/job/1855374
# good: [df9a4d79f1decb1b85efa58a66bcf122d6b6c624] nfs: constify path argum=
ent of __vfs_getattr()
git bisect good df9a4d79f1decb1b85efa58a66bcf122d6b6c624
# test job: [77aae5255c6d2ef4981f7fcedf35333466abcb06] https://lava.sirena.=
org.uk/scheduler/job/1855429
# good: [77aae5255c6d2ef4981f7fcedf35333466abcb06] arm64: dts: renesas: r9a=
09g077m44-rzt2h-evk: Add user LEDs
git bisect good 77aae5255c6d2ef4981f7fcedf35333466abcb06
# test job: [431ab7953c234cef6c9074761cd0e6482a26a761] https://lava.sirena.=
org.uk/scheduler/job/1855510
# good: [431ab7953c234cef6c9074761cd0e6482a26a761] Merge tag 'tegra-for-6.1=
8-dt-bindings' of git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux=
 into soc/dt
git bisect good 431ab7953c234cef6c9074761cd0e6482a26a761
# test job: [9db88bc46a491a234eade710370b71ccfe636d98] https://lava.sirena.=
org.uk/scheduler/job/1855661
# good: [9db88bc46a491a234eade710370b71ccfe636d98] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
git bisect good 9db88bc46a491a234eade710370b71ccfe636d98
# test job: [8be4d2d8f242889dbe49f19475164f1ad1adc24e] https://lava.sirena.=
org.uk/scheduler/job/1855685
# good: [8be4d2d8f242889dbe49f19475164f1ad1adc24e] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
git bisect good 8be4d2d8f242889dbe49f19475164f1ad1adc24e
# test job: [4e935fa4af4e3fbe6ae41873207ae7fa667bc26a] https://lava.sirena.=
org.uk/scheduler/job/1855809
# bad: [4e935fa4af4e3fbe6ae41873207ae7fa667bc26a] Merge branch 'next' of gi=
t://git.monstr.eu/linux-2.6-microblaze.git
git bisect bad 4e935fa4af4e3fbe6ae41873207ae7fa667bc26a
# test job: [ff3fecf14556fe603815881bc4b0d20248f7e45e] https://lava.sirena.=
org.uk/scheduler/job/1855834
# good: [ff3fecf14556fe603815881bc4b0d20248f7e45e] Merge branch 'for-next' =
of https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git
git bisect good ff3fecf14556fe603815881bc4b0d20248f7e45e
# test job: [ea3b3975fe44fa531bd5fecb6370bed50b1e3022] https://lava.sirena.=
org.uk/scheduler/job/1856327
# bad: [ea3b3975fe44fa531bd5fecb6370bed50b1e3022] Merge branch 'clk-imx' in=
to clk-next
git bisect bad ea3b3975fe44fa531bd5fecb6370bed50b1e3022
# test job: [91ec7ad756f103d3a45baac651ea55e4b8c479ca] https://lava.sirena.=
org.uk/scheduler/job/1856440
# good: [91ec7ad756f103d3a45baac651ea55e4b8c479ca] Merge tag 'clk-round-rat=
e-6.18' of https://github.com/masneyb/linux into clk-determine-rate
git bisect good 91ec7ad756f103d3a45baac651ea55e4b8c479ca
# test job: [a75ca9ae47f90c619c88d359c7ae8af96bb350c5] https://lava.sirena.=
org.uk/scheduler/job/1856759
# bad: [a75ca9ae47f90c619c88d359c7ae8af96bb350c5] Merge tag 'clk-meson-v6.1=
8-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
git bisect bad a75ca9ae47f90c619c88d359c7ae8af96bb350c5
# test job: [cf03071b7c3f1537dba21a64bcd1559b5201a156] https://lava.sirena.=
org.uk/scheduler/job/1857196
# bad: [cf03071b7c3f1537dba21a64bcd1559b5201a156] clk: amlogic: drop CLK_SE=
T_RATE_PARENT from peripheral clocks
git bisect bad cf03071b7c3f1537dba21a64bcd1559b5201a156
# test job: [480197ceece792b887a6f3361080a030eb8e4846] https://lava.sirena.=
org.uk/scheduler/job/1857697
# bad: [480197ceece792b887a6f3361080a030eb8e4846] clk: amlogic: add probe h=
elper for mmio based controllers
git bisect bad 480197ceece792b887a6f3361080a030eb8e4846
# test job: [4c4e17f2701316e0cac16e19366056f464feded5] https://lava.sirena.=
org.uk/scheduler/job/1858222
# bad: [4c4e17f2701316e0cac16e19366056f464feded5] clk: amlogic: naming cons=
istency alignment
git bisect bad 4c4e17f2701316e0cac16e19366056f464feded5
# first bad commit: [4c4e17f2701316e0cac16e19366056f464feded5] clk: amlogic=
: naming consistency alignment

--E60cnk4Xf02DS9Qr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjP4L0ACgkQJNaLcl1U
h9CqfQf/Q2V9qlXDGIfm9OTpFRb+XRr5i+cbMtfLDuDav6UdoEZGK0pAEMNVSodu
GkfFMPAQiV0T+Vc11anFxedoTZ5KwY6vTdKy39rQYYhNRbsSm1DhzyiRq5Svei7N
TsKpQ1P0Hu8vQ7gddwz1/k3bbM2OBeYYXBKvk1p1CBNG2hvsoUUWphEHo30VTv+J
4gVjYhfa/CCUrANFD9C5/tOCZC7+FSvI+UmYVoVk5To2BX1SockIoyFbBUH4PL1Y
zBL57JzSyBqTITJ/2I7iwdB8qHbxMABjZX7M3Hn8JhGUjKFBCevkkbH/3eGz3v3V
Hu0nZhWG0OKIucZ9aRcvfXeuoj1K3Q==
=rKge
-----END PGP SIGNATURE-----

--E60cnk4Xf02DS9Qr--

