Return-Path: <linux-kernel+bounces-825929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EBB8D245
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7BAE168187
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 23:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB44285419;
	Sat, 20 Sep 2025 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pqoANKw6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83622261388
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 23:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758410489; cv=none; b=CT5gpYNBLG756u0tKeh42BwSzr8sQ/Ab87kXx+5cbYDh9gTL0IcbzXAIZJ1yn3m4sVK+wIjrmS1srQmz0MyONmVEJx9+jiLXi+lqEmydn4D7xQmNp1oiA5Qk3M465Xoc45mUeKM58fxtuJnabizNWaCq04/REG5C8j8Q9jx5MBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758410489; c=relaxed/simple;
	bh=RUL1Zs2ER3rymeciz/eOY8tNxSFCvRDGsNi6QpI68eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+HngVp4JYz/Q1irtF7Jeqpi3TAH5d2zsvSII2HoqCTQAoXkJUibQ5XQ/GTn2ImQkroomR+uNPnsvCyv+EubAiTeKU55tRd17b3ol6yZUVSpD4y7MTrMoYwrfTPM5+AGpwnKkJ6T++3fjURFx6syu35iOhaziwEU1q4sBSVeU7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pqoANKw6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58KMHJxM011113
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 23:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QJ08kPi4J0e6QPjOfD6/wld0PtOfnxlKb2Gc/b7w35U=; b=pqoANKw6CwhCz9j1
	JD7U/Mv4jQ5cCH+952wBFWXKgoWPPlqzDBlBYQu3xziRVSkLFlP2sm4VxW3UWLKy
	qibAH/jOKD2fvndcAaHs9GErZZdc1GV9zVSrvJV/H7fJzNuQq8Sf4NOEZaEPXAas
	j6oz1j6NTC1tWPfmoBfqTtGKPsSI6CoQqng0d3g5rh0ezbvoIBKpg8xjBwE4+vhQ
	ezkJIOttUd4YH1KGh5RT8ar2Rb1sgtySaqz/pWWNE4CC51JmV7Puj1hp+UJQHYKl
	9m2p+DfmUBRDTpEXIhc09OXsnYkkN/Gad9NSVibZISwC2kCk8r1iFCfeVIsySOff
	4e8+RQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg31ct1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 23:21:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5ecf597acso79023351cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 16:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758410484; x=1759015284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJ08kPi4J0e6QPjOfD6/wld0PtOfnxlKb2Gc/b7w35U=;
        b=PQ9Zh4EGpmxvV4AoYfijPnuOnx5b85fP/875kL9u+PEjgmy9w5z7PTRIu9M6WFSLsF
         PLonJg/sRhc1dNJzBDfZ65mMf/Rm7P6obV5EBNlFYiMPGPsoE/mhuA//NxAvKiukDCk9
         zUcJNsV67m75Pw5eLxYABOwCKI4silvPMWfAxTmHXUmT3VdblQCVRVjy2wZ+f9orr1qw
         a/S/5ck0FpnLE9gy35sK1tfauSmzS/1lag6ERStKV+UZfZGCy5swcZJBMCDVzQAKReXh
         iBEkbeK7WcDAKHKJrLOskvkwSxXW8xyrraN06DFR4XCZXn6xZIa0v5aMyrlkvZP0H0ja
         ihug==
X-Forwarded-Encrypted: i=1; AJvYcCVx2pKOCFOi0FmqdSENs9tpiPz8FYL3ALZ2atNu/ArW2HYc+BXWZWQuF9S6XTx1wW3eEAv1Jw46TZ1SHg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWjUIv+orPEsCZME21vMLzQnFicdtRmCBTWJDwSRt72wwZ2+F
	Y+tubhbtfw8jb/simgfAq/0+nTmzuS8EcOLkf/k971cjaCdQBoT6LGUoBsoHNktrSgps7ITQwCc
	QyXUk+EtU474UDMfh+XzVNVKroOekLp1UCaHz45t8ee44e7hSNcgeWvwUCil+3+f9kmdFMXSB65
	8=
X-Gm-Gg: ASbGnctDnGu98jXOxH4KimWQx4YWxnPef+S35dQf3nbryvN1ZZ1H2H2mi9sqHZX8puO
	Y9N25TqRyoUUxceHQEW5D15Eq8yMdduDCI++SdIMuBmxs4BNdVNSwEln996V2Qa3ES2GbE8LbVm
	xrD8gAOQQXM/WI8zfxn+/daM3jUpfxba2twIy14pp9nVU2J8a7jVt61I+DzTlDvFmvrpZmWTCQ8
	xQ9j2OtjHS0gWB7dpM/F8GtSRx6D2Ah6zjzMT4Dqse7yYspM60iLvFRmQcZlBHSGr7saYUWkVOV
	cwOC3zrb79gzXkFMhFPQejqB5doHRzGYPuVfWj2/H7R79++pbQg4Av7HVZGUBHdIgL2Jk5hGybZ
	v7SK9+7LTSuEYo56HhIvWmn/Il13zUp3148uL3G98TGMlCIWHJltF
X-Received: by 2002:a05:622a:1389:b0:4b9:6bbf:7073 with SMTP id d75a77b69052e-4c0720ac134mr82344351cf.53.1758410484391;
        Sat, 20 Sep 2025 16:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYGaTWFE/W0JZvdbyAwuAt0nxQOFKarDbY+G/GCtpOyicyxYjNEFi6dQXVLSt7TGc08dWv0Q==
X-Received: by 2002:a05:622a:1389:b0:4b9:6bbf:7073 with SMTP id d75a77b69052e-4c0720ac134mr82344251cf.53.1758410483922;
        Sat, 20 Sep 2025 16:21:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a68e8814sm2191909e87.62.2025.09.20.16.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 16:21:23 -0700 (PDT)
Date: Sun, 21 Sep 2025 02:21:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric =?utf-8?Q?Gon=C3=A7alves?= <ghatto404@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] arm64: dts: qcom: r0q: add gpio keys
Message-ID: <3sox7jdjpahljevgyctg7zbvoua364hyajbap3ulsykloxqzna@dl2lfxdppdba>
References: <20250920014637.38175-1-ghatto404@gmail.com>
 <20250920014637.38175-2-ghatto404@gmail.com>
 <qiiuezocvxvj5bhrr77v6o2amaaaepdx54pqoewvhtnxce5ccz@g7bhkrb6a4pd>
 <5436E420-E459-4E47-9752-EF80F550FA6F@gmail.com>
 <r6e23h4nkddktkle5rohdiiqkw667rq26j7u2yodao6p3scixp@y3roqbly4oje>
 <B58EE981-3702-4FA3-B150-A3C862643870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B58EE981-3702-4FA3-B150-A3C862643870@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfX1FQ2LHmUfy0x
 /Ve0PnZx7BDqWMtsYaknWXox0t8lpG7BfEhUnD6y7AzGgNCFTtglih7yCFbD454inxdT4InMe5c
 z/RhpIvxwjYRjoF/yTwV5r2dA9kyCwij4hmXGH7h4b67ga5HU0TMIM4Ty8IYLqWq4PPaB7fhRmY
 viFLDNBFRR5Lmw5ej5LYV/4XXypxBu6esVQ3eC6X50gy+bKJWhs/n//P/kb+w00o0ODBT5bV0CU
 +l5sg/UyWe5PVfQ7PInKGwJ4qtPrZC3uegTgk6Zs1GyJNZDKtM1alvLVMJHr+uKXEvsIj1OkAw0
 EfPYlZ4+Bh7VUam7bbxAAKSOAM2YeYdSTR11wEDjzStAqihceaOeDIvM+GBy3YiSD6cbTiLQZs6
 dlWjlBch
X-Proofpoint-GUID: 6Ua0cfGz8kvk---JrrXDtkSr8w4Dylg5
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68cf36f6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tsbVFwL6q7DH9GSC2JYA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6Ua0cfGz8kvk---JrrXDtkSr8w4Dylg5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_08,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032

On Sat, Sep 20, 2025 at 05:22:28PM -0300, Eric Gonçalves wrote:
> 
> 
> On September 20, 2025 5:15:41 PM GMT-03:00, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >On Sat, Sep 20, 2025 at 03:02:42PM -0300, Eric Gonçalves wrote:
> >> 
> >> 
> >> On September 20, 2025 12:45:27 PM GMT-03:00, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com> wrote:
> >> >On Sat, Sep 20, 2025 at 01:46:33AM +0000, Eric Gonçalves wrote:
> >> >> Add GPIO keys support to Samsung Galaxy S22 (r0q).
> >> >> 
> >> >> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> >> >> ---
> >> >>  .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 53 +++++++++++++++----
> >> >>  1 file changed, 44 insertions(+), 9 deletions(-)
> >> >> 
> >> >> diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> >> >> index 880d74ae6032..70e953824996 100644
> >> >> --- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> >> >> +++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
> >> >> @@ -2,11 +2,12 @@
> >> >>  
> >> >>  /dts-v1/;
> >> >>  
> >> >> +#include <dt-bindings/input/linux-event-codes.h>
> >> >>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >> >> -
> >> >>  #include "sm8450.dtsi"
> >> >>  #include "pm8350.dtsi"
> >> >>  #include "pm8350c.dtsi"
> >> >> +#include "pmk8350.dtsi"
> >> >>  
> >> >>  / {
> >> >>  	model = "Samsung Galaxy S22 5G";
> >> >> @@ -28,13 +29,19 @@ framebuffer: framebuffer@b8000000 {
> >> >>  		};
> >> >>  	};
> >> >>  
> >> >> -	vph_pwr: regulator-vph-pwr {
> >> >> -		compatible = "regulator-fixed";
> >> >> -		regulator-name = "vph_pwr";
> >> >> -		regulator-min-microvolt = <3700000>;
> >> >> -		regulator-max-microvolt = <3700000>;
> >> >> -		regulator-always-on;
> >> >> -		regulator-boot-on;
> >> >
> >> >Please don't mix up refactorings and new features. Split this patch into
> >> >several.
> >> The patch only added gpio-keys node and pon_resin,
> >> pon_pwrkey. Do you mean I have to split each button
> >> into separate patches?
> >
> >No. The patch also moves regulator-vph-pwr and changes the comment in
> >the TLMM node.
> >
> I thought they would be too small to be
> patches on their own. Is it okay if I split
> them into 2: arm64: dts: qcom: r0q: small refactor
> and arm64: dts: qcom: r0q: add gpio keys?

SGTM.

> >> >
> >> >> +	gpio-keys {
> >> >> +		compatible = "gpio-keys";
> >> >> +		autorepeat;
> >> >> +
> >> >> +		pinctrl-0 = <&vol_up_n>;
> >> >> +		pinctrl-names = "default";
> >> >> +
> >> >> +		key-vol-up {
> >> >> +			label = "Volume Up";
> >> >> +			linux,code = <KEY_VOLUMEUP>;
> >> >> +			gpios = <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
> >> >> +			debounce-interval = <15>;
> >> >> +		};
> >> >>  	};
> >> >>  
> >> >>  	reserved-memory {
> >> >> @@ -47,6 +54,15 @@ splash-region@b8000000 {
> >> >>  			no-map;
> >> >>  		};
> >> >>  	};
> >> >> +
> >> >> +	vph_pwr: regulator-vph-pwr {
> >> >> +		compatible = "regulator-fixed";
> >> >> +		regulator-name = "vph_pwr";
> >> >> +		regulator-min-microvolt = <3700000>;
> >> >> +		regulator-max-microvolt = <3700000>;
> >> >> +		regulator-always-on;
> >> >> +		regulator-boot-on;
> >> >> +	};
> >> >>  };
> >> >>  
> >> >>  &apps_rsc {
> >> >> @@ -119,8 +135,27 @@ vreg_l1c_1p8: ldo1 {
> >> >>  	};
> >> >>  };
> >> >>  
> >> >> +&pm8350_gpios {
> >> >> +	vol_up_n: vol-up-n-state {
> >> >> +		pins = "gpio6";
> >> >> +		function = "normal";
> >> >> +		power-source = <1>;
> >> >> +		input-enable;
> >> >> +	};
> >> >> +};
> >> >> +
> >> >> +&pon_pwrkey {
> >> >> +	status = "okay";
> >> >> +};
> >> >> +
> >> >> +&pon_resin {
> >> >> +	linux,code = <KEY_VOLUMEDOWN>;
> >> >> +
> >> >> +	status = "okay";
> >> >> +};
> >> >> +
> >> >>  &tlmm {
> >> >> -	gpio-reserved-ranges = <36 4>; /* SPI (not linked to anything) */
> >> >> +	gpio-reserved-ranges = <36 4>; /* SPI (Unused) */
> >> >>  };
> >> >>  
> >> >>  &usb_1 {
> >> >> -- 
> >> >> 2.51.0
> >> >> 
> >> >
> >> Resend because I forgot to CC the mailing lists
> >

-- 
With best wishes
Dmitry

