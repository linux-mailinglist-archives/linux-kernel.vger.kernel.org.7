Return-Path: <linux-kernel+bounces-726091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59E0B007EF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809C04E29F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A207527C14B;
	Thu, 10 Jul 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeqPI5ci"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71A27B4E0;
	Thu, 10 Jul 2025 15:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163165; cv=none; b=V0SE2UEKbhlS2MwLUMap7+EoG9h/6A5eWdaGy+52xtiyMLmXiP88RjgKYUVJsM625ioAASz+BBPBvvSlDi2MIui3iMP7BMr2/zXBlGnGKioFE4wifNoU4/N2GtDb8L8CYSqzpv2Qvwc2qN6HzqwB9KmFpa8K1VRcBx/bt32Y8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163165; c=relaxed/simple;
	bh=aMNXNTLgI8JeT7B0plMnVK9LNcSSEolGwKBFNEahtjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kljb2SXsUOI4AcmKbI08XRJy0Z/rapXOPhJwfV+8cy0dcyZvESbn/sB4wy9lAxP3LsDojcUUIIjMOC1vhENIfMFC90x5X09baiQ89eBWJKfI3gOPh0TBCOZnEsf1plPGhfXAG+gxfwGhDcCEYIESssWQzgN6CoVLjYQNUN2wRqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeqPI5ci; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a5903bceffso13968861cf.3;
        Thu, 10 Jul 2025 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752163163; x=1752767963; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kc5UYPl7f9X635NJ3Fg771yePRD2lZa815BaqxRGGKw=;
        b=SeqPI5ciCTOXnqBPTwNy9FUqBzLzgP+R8grLsrcMOQZ1v91v7sei128OTZ+oQa0A7U
         kLzRVz22EudlNEAJARMb0SveET9UQsB+diZ3c/MuklPwX0/foxY/W0gNagIGbZLxkDX/
         ivSFmNZlP7+IywQVM/KwRnlV61ysHsmzWBCf4+8QfRXzG+wXD39c35uJyzvIu2wd0z+V
         eMxGdQPQAHBD0Mk4DrfvALutkOlxxy0+sRyK443H6EEJAHZlSi42C27sucZW0BQVMB27
         8w+wZ7wahzEZEb5nxZvu84epQ4NKzEj710RsZreCEC46HsKaX/spPX+wU1WKb07GwKHQ
         dwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163163; x=1752767963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kc5UYPl7f9X635NJ3Fg771yePRD2lZa815BaqxRGGKw=;
        b=jlrZNdh65Z9sHI2SYb5vr+q/3uQoSMU+Khh+T9dER8Xm2YlHlaKpnJ57cveZp5EFRQ
         iQsb7ImBgHOndTO1MLdeIq3+4nIv6PUATQkI2T/yGR0Aodr/Q4/ec4ND1z/OQP0+01gj
         w3Pgit0xqoPJMC9tmYj/2NOnbd7IlWKgFVQtAm7Lax8dyOCia5BlS/ZxMRDUBuYLqB7o
         94ZnrJzoxGx5G/x5ruQGJRMuXSNRES/obySC+7WWcSn00Fnt5rVoAnA3dLwv/ir3xGaF
         VNOLrp9mLXfY11t4ABx56O87FwOwYuHRfSO2xU2ofpaSTMxUhHuk84hifZ0oJhfUXxqd
         brjA==
X-Forwarded-Encrypted: i=1; AJvYcCUjrLeXuTHeKLUqNHhct6ido9HMC/ybgdGb0ewHBGRMkvSur430YrNMnRbcDkN1HbGY7JRlsxJ3yBC9@vger.kernel.org, AJvYcCX/oWWxzKxf8IV8mWzo8VTd7ZigJiI2c4QQ4jbOh7Kh/4JgLtf9cpw3TROnQneT0zNNGFrEXQWO5bV/fKsW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjn2AUOl6HBFCPnVzI+xB3K1AFf7Ho+rJQKyp1sDs5D2BQxpmB
	N2mUY98y28tN11w9pfSLyBB+DWd3ezTPYDsEtaKuoD4tNDt0lI6lS7wNRG5/MZ1yPHrF09Zf0Up
	aVPIH8QZk8lKdoZdyFmhuntutG1bXnsQ=
X-Gm-Gg: ASbGncvbVs/UamN7winEAq0fXU4RHjwQ1DJng7/YTp6YW6akXlhlxIpIeVy3W4gY0EN
	XtzAM74thjFTwAwdl6dSzyuPQnKjoOCkvI92e55vj6yBJUyeV0QXBzf32o8dIMxpb/LFwE6m8Po
	eAxEQ4DPo24cTbIKp4MT8lDxseA5fL6+P92fy/z1NxSOSD
X-Google-Smtp-Source: AGHT+IEhI4AzpjBb+4MG95Co3MJ4O+5/UGoMQAVYVLzb+1MSK4cvxAy6aVFWEBdljfwhBMeShvoYgQRmoCBDnmBmDEU=
X-Received: by 2002:a05:622a:4ac6:b0:4a4:40b7:9cc with SMTP id
 d75a77b69052e-4a9dec54757mr100730111cf.12.1752163162448; Thu, 10 Jul 2025
 08:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620100010.1291658-1-amadeus@jmu.edu.cn> <20250620100010.1291658-2-amadeus@jmu.edu.cn>
 <5025631.aeNJFYEL58@phil> <b6f8f705-f661-46cf-9dda-6f18f8658622@kwiboo.se>
In-Reply-To: <b6f8f705-f661-46cf-9dda-6f18f8658622@kwiboo.se>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 10 Jul 2025 19:59:11 +0400
X-Gm-Features: Ac12FXx1qPTjJO3HuLgi2Tlv0SZqUgMUIca5qO-LsnRBbRElxcE-W9k1gvJPLZ0
Message-ID: <CABjd4YzCL3U9yf65FUBE6EMqFjZHosULU7fUcjVo9VJ_=Ov+Dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency
 scaling support
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Chukun Pan <amadeus@jmu.edu.cn>, Yao Zi <ziyao@disroot.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 7:09=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Heiko and Chukun,
>
> On 7/10/2025 1:45 PM, Heiko Stuebner wrote:
> > Am Freitag, 20. Juni 2025, 12:00:10 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Chukun Pan:
> >> By default, the CPUs on RK3528 operates at 1.5GHz. Add CPU frequency a=
nd
> >> voltage mapping to the device tree to enable dynamic scaling via cpufr=
eq.
> >>
> >> The OPP values come from downstream kernel[1]. Both 408MHz and 600MHz
> >> frequencies use the normal PLL, so use the corresponding highest volta=
ge.
> >>
> >> The voltage used for other frequencies can't be less than above (875mV=
).
> >> Therefore, 816MHz to 1200MHz also uses the corresponding highest volta=
ge.
> >
> > There has often been the argument that selecting a frequency that has t=
he
> > same voltage as a faster frequency does not save any power.
> >
> > Hence I remember that we dropped slower frequencies on other socs
> > that share the same voltage with a higher frequency.
>
> One possible difference here is that the actual CPU rate is controlled
> by a PVTPLL where TF-A will configure a osc ring-length based on the
> requested rate and Linux only configure the regulator voltage.
>
> I have no idea if the configuration made by TF-A will have any affect on
> power usage, but I suggest we keep all opp here because both TF-A and
> Linux is involved in configuring the CPU rate.

It seems that PVTPLL usage shouldn't change the equation here. As long
as the voltage stays the same, it should always be preferable to run
the core faster (i.e. at a shorter osc-ring length) so that it can go
to idle sooner, given that idle states are less power-hungry than any
of the active states.

What DOES change the equation is the different voltage that downstream
DTs define for different OTP programmed leakage values, as they make
different top frequencies correspond to a given voltage for cores with
different leakage values.

> The measured rate can typically be read from a PVTPLL status reg, it
> will be different depending on the ring-length, voltage and silicon
> quality for the rates >=3D 816 MHz.
>
> >
> >>
> >> The remaining 1416MHz to 2016MHz use a voltage close to actual frequen=
cy.
> >>
> >> [1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/ar=
m64/boot/dts/rockchip/rk3528.dtsi
> >>
> >> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3528.dtsi | 64 +++++++++++++++++++++++=
+
> >>  1 file changed, 64 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3528.dtsi b/arch/arm64/boo=
t/dts/rockchip/rk3528.dtsi
> >> index 829f980ea353..5cb7f10b79ed 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3528.dtsi
> >> @@ -53,6 +53,7 @@ cpu0: cpu@0 {
> >>                      device_type =3D "cpu";
> >>                      enable-method =3D "psci";
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPU>;
> >> +                    operating-points-v2 =3D <&cpu_opp_table>;
> >>              };
> >>
> >>              cpu1: cpu@1 {
> >> @@ -61,6 +62,7 @@ cpu1: cpu@1 {
> >>                      device_type =3D "cpu";
> >>                      enable-method =3D "psci";
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPU>;
> >> +                    operating-points-v2 =3D <&cpu_opp_table>;
> >>              };
> >>
> >>              cpu2: cpu@2 {
> >> @@ -69,6 +71,7 @@ cpu2: cpu@2 {
> >>                      device_type =3D "cpu";
> >>                      enable-method =3D "psci";
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPU>;
> >> +                    operating-points-v2 =3D <&cpu_opp_table>;
> >>              };
> >>
> >>              cpu3: cpu@3 {
> >> @@ -77,6 +80,67 @@ cpu3: cpu@3 {
> >>                      device_type =3D "cpu";
> >>                      enable-method =3D "psci";
> >>                      clocks =3D <&scmi_clk SCMI_CLK_CPU>;
> >> +                    operating-points-v2 =3D <&cpu_opp_table>;
> >> +            };
> >> +    };
> >> +
> >> +    cpu_opp_table: opp-table-cpu {
>
> This node should be placed after the firmware node for the nodes to be
> in alphabetical order.
>
> Regards,
> Jonas
>
> >> +            compatible =3D "operating-points-v2";
> >> +            opp-shared;
> >> +
> >> +            opp-408000000 {
> >> +                    opp-hz =3D /bits/ 64 <408000000>;
> >> +                    opp-microvolt =3D <875000 875000 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +                    opp-suspend;
> >> +            };
> >> +
> >> +            opp-600000000 {
> >> +                    opp-hz =3D /bits/ 64 <600000000>;
> >> +                    opp-microvolt =3D <875000 875000 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +
> >> +            opp-816000000 {
> >> +                    opp-hz =3D /bits/ 64 <816000000>;
> >> +                    opp-microvolt =3D <875000 875000 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +
> >> +            opp-1008000000 {
> >> +                    opp-hz =3D /bits/ 64 <1008000000>;
> >> +                    opp-microvolt =3D <875000 875000 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };

I.e. here the mainline kernel will always choose opp-1008000000 as
long as the regulator voltage is 875000 uV, unless explicitly
prevented from doing so by userspace. Whereas the BSP kernel [1] would
request different frequencies for different silicon, e.g.
opp-1200000000 for a silicon specimen with a leakage value of L4 and
opp-1416000000 for a silicon specimen with a leakage value of L8 - all
for the same regulator voltage of 875000 uV.

So my 2 cents would be: no added benefit in having "lower frequency,
same voltage" OPPs defined here until we implement an OPP driver
reading the NVMEM programmed leakage values and selecting different
*-L* voltages for each OPP depending on those. Once there is this
support in the drivers, those OPPs can be added together with
leakage-specific voltages (opp-microvolt-L0..11).

Right now OPP values with frequencies lower than 1008000000 won't be
selected by any of the energy-aware cpufreq governors anyway, because
their voltages are the same. Exercise for the reader: try to convince
e.g. the "schedutil" governor to select anything below 1008000000
without touching
/sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq :) This may
change if OPP tuning logic is implemented such as in [2]: that will
try and find the _voltage_ resulting in PVTPLL providing a frequency
closest to what cpufreq requested, and use that for the in-memory OPP
table instead of what was provided by the DTS.

[1] https://github.com/rockchip-linux/kernel/blob/develop-5.10/arch/arm64/b=
oot/dts/rockchip/rk3528.dtsi
[2] https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/soc/r=
ockchip/rockchip_opp_select.c#L842-L994

Best regards,
Alexey

> >> +            opp-1200000000 {
> >> +                    opp-hz =3D /bits/ 64 <1200000000>;
> >> +                    opp-microvolt =3D <900000 900000 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +
> >> +            opp-1416000000 {
> >> +                    opp-hz =3D /bits/ 64 <1416000000>;
> >> +                    opp-microvolt =3D <925000 925000 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +
> >> +            opp-1608000000 {
> >> +                    opp-hz =3D /bits/ 64 <1608000000>;
> >> +                    opp-microvolt =3D <975000 975000 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +
> >> +            opp-1800000000 {
> >> +                    opp-hz =3D /bits/ 64 <1800000000>;
> >> +                    opp-microvolt =3D <1037500 1037500 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >> +            };
> >> +
> >> +            opp-2016000000 {
> >> +                    opp-hz =3D /bits/ 64 <2016000000>;
> >> +                    opp-microvolt =3D <1100000 1100000 1100000>;
> >> +                    clock-latency-ns =3D <40000>;
> >>              };
> >>      };
> >>
> >>
> >
> >
> >
> >
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

