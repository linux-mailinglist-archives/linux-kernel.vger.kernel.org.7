Return-Path: <linux-kernel+bounces-784225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9A5B3385B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A370189DF90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC79299AAC;
	Mon, 25 Aug 2025 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hewittfamily.org.uk header.i=@hewittfamily.org.uk header.b="R9yowu/4"
Received: from m204-238.eu.mailgun.net (m204-238.eu.mailgun.net [161.38.204.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D7F28A73A
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108746; cv=none; b=cvSdhEe1aOuBM5E4JAwj1qSYQZAPw6UQuEC2bqucOgzDWSgP/bF2QnVsit/DFT0c5s5epkFKhty8fAkKWQ4uSU0E2PayBGcYCdnGE/islOJFa+O3okqAflJKohtaxyeSsUDTXBd675ACmo+341OQp+hOPaOQX0M1Md6bxF2cSuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108746; c=relaxed/simple;
	bh=4XTMT6uavwuEBqViPRRFqM1dd7IHrypMtOOT4d+7JH4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=DsatkLBBwBxapa2AATIiIx7kFUiw/Qdt6zaBQ7FouEDVSVhqjSY9zEAVHJ6dM/419/MPrDJcvHjvIos61UX1q4/Pl2ICD082uOIGb/Rmbz5h5KrQNImEdMV/5M9IsPriOf65oB6JZsNizoIFjxSiFt/CsO5TV1DN2+oU178Bw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hewittfamily.org.uk; spf=pass smtp.mailfrom=hewittfamily.org.uk; dkim=pass (2048-bit key) header.d=hewittfamily.org.uk header.i=@hewittfamily.org.uk header.b=R9yowu/4; arc=none smtp.client-ip=161.38.204.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hewittfamily.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hewittfamily.org.uk
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk; q=dns/txt; s=s1; t=1756108742; x=1756115942;
 h=To: To: References: Message-Id: Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: From: Subject: Subject: Mime-Version: Content-Type: Sender: Sender;
 bh=4XTMT6uavwuEBqViPRRFqM1dd7IHrypMtOOT4d+7JH4=;
 b=R9yowu/4iSAh3rO22Y2S1x8pG/bu39UTdUZdp8L7nF8zkB+DPLrcsewAcSJsibXOY++aGpw8d7GcS/tzjLod0CwgBc0rd9BhD+PqRK3DfJhK8RVHexxFWXqbtTOW4YdzXmRu9pG+5fHmyruVcNeT2if/Mm2mb4nWtLqwlWEjDWCCsKgK5Eedy0GVZA5DhnMzFunOm5URTMPRz/P7gZ4tqBhbJbc470MJh50+ebhSAfgXyj21mb9XtejLpCMGCKfWx2QwxwrWMEp/yF2M9XBOPg7Hil/6VV/buVXW3mUyzSxbQCa+lj6bigeLYM0gdLdi5914CMhTOlFnrGoK838oJw==
X-Mailgun-Sid: WyIyNWUwNSIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCJlMzcyMCJd
Received: from mail.hewittfamily.org.uk (unknown [87.200.95.144]) by
 6daba92ea63ccfff060124925e5e264487e90b9321cf65b2c1448e79f35e349c with SMTP id
 68ac17c603c0e2ff1b03e86b (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256);
 Mon, 25 Aug 2025 07:59:02 GMT
X-Mailgun-Sending-Ip: 161.38.204.238
Sender: christian@hewittfamily.org.uk
Received: from smtpclient.apple (unknown [172.16.20.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.hewittfamily.org.uk (Postfix) with ESMTPSA id 4c9NTv3F5Mz50RyQ;
	Mon, 25 Aug 2025 11:58:59 +0400 (+04)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 01/11] arm64: dts: amlogic: Add cache information to
 the Amlogic GXBB and GXL SoC
From: Christian Hewitt <christian@hewittfamily.org.uk>
In-Reply-To: <20250825065240.22577-2-linux.amoon@gmail.com>
Date: Mon, 25 Aug 2025 11:58:48 +0400
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 "moderated list:ARM/Amlogic Meson SoC support" <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Amlogic Meson SoC support" <linux-amlogic@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <19AB5D06-DEB6-4C38-B90D-FCDD9719312C@hewittfamily.org.uk>
References: <20250825065240.22577-1-linux.amoon@gmail.com>
 <20250825065240.22577-2-linux.amoon@gmail.com>
To: Anand Moon <linux.amoon@gmail.com>
X-Synology-Spam-Status: score=-2.601, required 5, autolearn=ham, FREEMAIL_ENVRCPT 0, FROM_HAS_DN 0, FROM_EQ_ENVFROM 0, DBL_PROHIBIT 0, MIME_GOOD -0.1, MV_CASE 0.5, MID_RHS_MATCH_FROM 0, NO_RECEIVED -0.001, RCVD_COUNT_ZERO 0, TAGGED_RCPT 0, MISSING_XM_UA 0, __THREADED 0, FREEMAIL_CC 0, BAYES_HAM -3, TO_MATCH_ENVRCPT_ALL 0, TO_DN_ALL 0, __HDRS_LCASE_KNOWN 0, __BODY_URI_ONLY 0, FREEMAIL_TO 0, ARC_NA 0, MIME_TRACE 0, RCPT_COUNT_TWELVE 0, __NOT_SPOOFED 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no

> On 25 Aug 2025, at 10:51=E2=80=AFam, Anand Moon =
<linux.amoon@gmail.com> wrote:
>=20
> As per S905 and S905X datasheet add missing cache information to
> the Amlogic GXBB and GXL SoC.
>=20
> - Each Cortex-A53 core has 32KB of L1 instruction cache available and
> 32KB of L1 data cache available.
> - Along with 512KB Unified L2 cache.
>=20
> Cache memory significantly reduces the time it takes for the CPU
> to access data and instructions, leading to faster program execution
> and overall system responsiveness.

Hello Anand,

I=E2=80=99m wondering if we are =E2=80=9Cenabling caching=E2=80=9D in =
these patches (could be
a significant gain, as per text) or we are =E2=80=9Coptimising =
caching=E2=80=9D meaning
the kernel currently assumes generic/safe defaults so having accurate
descriptions in dt allows better efficiency (marginal gain)?

Stats are also subjective to the workload used, but do you have any
kind of before/after benchmarks? (for any of the SoCs in the patchset)

Christian

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 27 +++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi =
b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 7d99ca44e660..c1d8e81d95cb 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -95,6 +95,12 @@ cpu0: cpu@0 {
> compatible =3D "arm,cortex-a53";
> reg =3D <0x0 0x0>;
> enable-method =3D "psci";
> + d-cache-line-size =3D <32>;
> + d-cache-size =3D <0x8000>;
> + d-cache-sets =3D <32>;
> + i-cache-line-size =3D <32>;
> + i-cache-size =3D <0x8000>;
> + i-cache-sets =3D <32>;
> next-level-cache =3D <&l2>;
> clocks =3D <&scpi_dvfs 0>;
> #cooling-cells =3D <2>;
> @@ -105,6 +111,12 @@ cpu1: cpu@1 {
> compatible =3D "arm,cortex-a53";
> reg =3D <0x0 0x1>;
> enable-method =3D "psci";
> + d-cache-line-size =3D <32>;
> + d-cache-size =3D <0x8000>;
> + d-cache-sets =3D <32>;
> + i-cache-line-size =3D <32>;
> + i-cache-size =3D <0x8000>;
> + i-cache-sets =3D <32>;
> next-level-cache =3D <&l2>;
> clocks =3D <&scpi_dvfs 0>;
> #cooling-cells =3D <2>;
> @@ -115,6 +127,12 @@ cpu2: cpu@2 {
> compatible =3D "arm,cortex-a53";
> reg =3D <0x0 0x2>;
> enable-method =3D "psci";
> + d-cache-line-size =3D <32>;
> + d-cache-size =3D <0x8000>;
> + d-cache-sets =3D <32>;
> + i-cache-line-size =3D <32>;
> + i-cache-size =3D <0x8000>;
> + i-cache-sets =3D <32>;
> next-level-cache =3D <&l2>;
> clocks =3D <&scpi_dvfs 0>;
> #cooling-cells =3D <2>;
> @@ -125,6 +143,12 @@ cpu3: cpu@3 {
> compatible =3D "arm,cortex-a53";
> reg =3D <0x0 0x3>;
> enable-method =3D "psci";
> + d-cache-line-size =3D <32>;
> + d-cache-size =3D <0x8000>;
> + d-cache-sets =3D <32>;
> + i-cache-line-size =3D <32>;
> + i-cache-size =3D <0x8000>;
> + i-cache-sets =3D <32>;
> next-level-cache =3D <&l2>;
> clocks =3D <&scpi_dvfs 0>;
> #cooling-cells =3D <2>;
> @@ -134,6 +158,9 @@ l2: l2-cache0 {
> compatible =3D "cache";
> cache-level =3D <2>;
> cache-unified;
> + cache-size =3D <0x80000>; /* L2. 512 KB */
> + cache-line-size =3D <64>;
> + cache-sets =3D <512>;
> };
> };
>=20
> --=20
> 2.50.1
>=20
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic


