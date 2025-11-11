Return-Path: <linux-kernel+bounces-895445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08759C4DC26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27753A73D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC543AA188;
	Tue, 11 Nov 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DgQibGED";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jkxAG2uW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DF3AA182
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864539; cv=none; b=Nb3OhMzJILXCQvE0dX9dPnmHzDNW+YCTZNcJBEn1sFblo6GAQ2/quZEK9mpGUPzTKS0Msl4FfSKBdlWHZRkPDQMNmt5WluKLewq0s31a6visf06jnXVlaxX0HMFslMDtdXVmSSZf/F4dsyB+v/GWPStfWpxBmkIHMc6B/wKZn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864539; c=relaxed/simple;
	bh=qWO+LslAAiZd3CNygxHIYmwELeyYi6yEhKewOMVfbd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyj8RplAVjFwsTAkbz5JAYy9F2bz23YNgPTGZ2tv2DueL2U7nqCLyx3jW2UZREC7yqD9tFJVwBoQ677s881VrBPEkK14XHPcctMRktNAqq0+GpzA66qP+za42IuFtt9UB7BWHaUCS3ndeEuQJpVxxbVj8byZ0Wm/KGrPhHOKRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DgQibGED; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jkxAG2uW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGrZA2130489
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:35:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QFlA+rmHCQw2mTHSNf1gtuKKDHdDMWf6upuETlt4zpk=; b=DgQibGEDdAnr38dn
	hlp1J2DOyIw9PACjKvJ3bhLr3qfAgXZRYpfrU1ys943h1nRU56sXJQcfYrCUSorJ
	TmUzfPoaRTlmu0DMQ+3IzfInrM1BhCC9WYiN0vg2VSbDWMc1GSl+LdruscQCWsB3
	FDioslIJPFV7YD17BPji4yM4QlPerQOLH4ugfoNzGPl8ev+vGCFHgYOIAV53nS8C
	YqVGcT7EnVTUhKBa/QdAI3GPKdIsXkf3t2M3adMkvfCXntz5nMxSvFJNfdUvQR/K
	K2spX6loxiPsFV4SMxcX0fPa8MlMgsJdxkOSqLtdIPX8sy+NoYkIXSFStvdkPsse
	sVlORw==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abvhthm18-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:35:37 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-3e82b0276d4so135447fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864536; x=1763469336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QFlA+rmHCQw2mTHSNf1gtuKKDHdDMWf6upuETlt4zpk=;
        b=jkxAG2uW8coNmH3tgJNldIyXA+S9Vq9ShwM4TtkCHIlLOx8nIl0xvw/ee6MRxMxVs1
         k2JI1SwNKBxziOETATKdUCXPpx7lUBIZKPyjGfEwDGBjw/K1JlIprg7I7ovfiwm3VC27
         dmHdunTJXd5l4BofgqSzsS4XMqwYot6F9w1mBnFw+nZp2ftxFu0vYLuScjeJmSn1s+OT
         cIA2/dhWsWJga6kFEtXJNiIVvNjm7PIevc2lIHJjvAuFGWyTBp2g3C6gTiyRv7JnCjkZ
         xset35HvEtAryZh1YKqY2K4VkvpSv+sopIELQpKOtYOVyp4uAp+3QVKZcB87PbLIB4rf
         v5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864536; x=1763469336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFlA+rmHCQw2mTHSNf1gtuKKDHdDMWf6upuETlt4zpk=;
        b=vdMDGqXu5RabXCtkAgyPjqxb+HeGkp2j2OfdrJ/BikwCs1Ae3Q/7c/FXRuMQkP5cHF
         7uk4lsEaVuEKP7SmYnhx5xnpO/VCNdKYdqXN32rHVmGaWwjXJYEAiZoeEUrD9iEWo6S1
         2dDK6O1djjsdMcDVdePZj1RMH6eS38M7pGFno6Q2zovfTe7OAdLDmQx2pF0GxFgUSqnQ
         h100pFMfXH+hZbIqAkTl9YYT7dQWW1lHcj9MaKSiV3wYJb7UoMNQuRvzYwUMiPrbCAG2
         7KfbMYUQrA7oAPbCZ8kUb2eH1b4xL07jL3Ca3X4tKmIvn9mHEqVtwJTmj8c4Q+R9bdHm
         5Mxw==
X-Forwarded-Encrypted: i=1; AJvYcCVz0kXpG2FF5OI0YKPib7z6JbEqItGuW9wfjIY9dvnRxFsCT/H73l8uyQwEI29WaIlrtdp092WDY46bAE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwElZNxTlQhLBLcNFl662zDhayh2PMmxW2+s9nyrWlDE7tSv9Cs
	4DR13oJTObqaBRZdBNrt/tmcfwtsHvcQy8i+ziUnskKVE1ek5PcjtfBO2ZdNIfRN5mlUJzDU8/K
	56ELo6qQ+Lye+WwCGguMD58KGtJbOTf7aOfSyJWFP2pdCC4i+GZm+pIjMDSD60Odz11eknBRTmy
	4=
X-Gm-Gg: ASbGncux1cZaCdtpbulo6Z7lhK/YyR1oRnUaN3yXrPqduArN0XID9ohz75pFGQ5B4Ek
	3pgB89nzS34fNZ9L8hnaAmtZcf86K62vmSPIV1uNdVWin5a8fP62Ywdc+DiwE93FtI5cdXWUMf6
	nev7zFg69qm3wiJBUlVjwFk5clK2Nlg9hT7gOx1nXxaoJG7+wIKUN76ZCqDHnpv8RIYPGx2NKyX
	h5Z8leuqHFRgFUYpcVVTG/WSXQ1uHAA3V4zmaVY2o/C8d9/1ve4+D+yDZi7UHUJZJU3+fX9KxFI
	6rDOdzWe47FoVHCPUKuyrwo+j1B9dP+09mXxXkqQ+2YcSCPN4k/pQShE+1+q2QrgYgaorKyPuvD
	84loybKq+JmloVhyIL4OIuef4rvt2/t0M2F0UP9Ak9LgOIj7ApjekDqTXYFIHnQ4iQayKgIA/+P
	vMB27Bs89guh0y
X-Received: by 2002:a05:6870:468b:b0:3d9:158e:d943 with SMTP id 586e51a60fabf-3e7c24cb4e6mr6044434fac.9.1762864535731;
        Tue, 11 Nov 2025 04:35:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFB0QADbO+w8dIjN2emZaXFkoCmnPbMKIptoyc4K6i/3GMqeYEKpmtn9C+u+nB5MxEt9+6ieg==
X-Received: by 2002:a05:622a:d0:b0:4d8:1f72:ba60 with SMTP id d75a77b69052e-4eda4e7a7a7mr134961411cf.14.1762864129941;
        Tue, 11 Nov 2025 04:28:49 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f0dd359sm41987281fa.32.2025.11.11.04.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:28:49 -0800 (PST)
Date: Tue, 11 Nov 2025 14:28:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Riccardo Mereu <r.mereu.kernel@arduino.cc>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, broonie@kernel.org, linux@roeck-us.net,
        Jonathan.Cameron@huawei.com, wenswang@yeah.net,
        naresh.solanki@9elements.com, michal.simek@amd.com, nuno.sa@analog.com,
        chou.cosmo@gmail.com, grantpeltier93@gmail.com, eajames@linux.ibm.com,
        farouk.bouabid@cherry.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, mm.facchin@arduino.cc,
        Riccardo Mereu <r.mereu@arduino.cc>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: unoq: add dts for arduino unoq
Message-ID: <vzpbuf3hrmt7axry63tgelbkj54kqby6pjnb3cynew6k476uye@6qonkynked2g>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
 <20251106153119.266840-6-r.mereu@arduino.cc>
 <f20fd593-0173-424d-9951-e0f2ad33b4cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f20fd593-0173-424d-9951-e0f2ad33b4cd@oss.qualcomm.com>
X-Proofpoint-GUID: NGXpa2emOmRMep0SC823X78qfPlAXkP1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwMCBTYWx0ZWRfX6fUTgUWVuLR/
 T8j6kUiX/jpv9uP3Sl9QaumG2c5q+UagwEULQhTumCjPkF1+vg423VXwv+sPgyP6hnbHi5vuyG7
 GYk0JrNNmx0muo/ab49X5cnW5cnKgysQjab5oZzuNKWB3tauQQ/Mx/Yt+wU5r14bF3khF+RFLb0
 OS2Bb7OZDn+hzIR8gSkr2EeMeUauW5wjgW8yh5nmMa3CtOnifzQkm9STwqtsbsFFU5SWEklcY5X
 o3/VQoqWhoOaXP2HkMeR3Sbf6HHTcvGGCcmjsrSexxnKDrWNfM4QhzjvK9Guo+Jw1O0vJd1hS6T
 3uz6hfn+uM2q7n1jJQz+L7Gc0L2Z7Ng0KXZMXtfH+TbIWYfvIcbV24Xs/7szSj5IpPUKllRCVhE
 FUnZCnnWNtDfhA0xewXAJ57lgSSCxA==
X-Proofpoint-ORIG-GUID: NGXpa2emOmRMep0SC823X78qfPlAXkP1
X-Authority-Analysis: v=2.4 cv=d4b4CBjE c=1 sm=1 tr=0 ts=69132d99 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=7D5TFTMLEG-0mYwEVy4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110100

On Thu, Nov 06, 2025 at 05:29:47PM +0100, Konrad Dybcio wrote:
> On 11/6/25 4:31 PM, Riccardo Mereu wrote:
> > From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
> > 
> > Arduino UnoQ is a single-board computer combining Qualcomm
> > Dragonwing™ QRB2210 microprocessor with STMicroelectronics STM32U585
> > microcontroller.
> > Support to a simply boot to shell environment includes:
> > - UART, I2C, SPI
> > - onboard LEDS
> > - eMMC
> > - WLAN and BT
> > 
> > Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
> > ---
> 
> [...]
> 
> > +        leds: leds {
> > +                compatible = "gpio-leds";
> > +
> > +                ledpanic: led-panic {
> > +                        label = "red:panic";
> > +                        function = LED_FUNCTION_INDICATOR;
> > +                        color = <LED_COLOR_ID_RED>;
> > +                        gpios = <&tlmm 39 GPIO_ACTIVE_HIGH>;
> > +                        linux,default-trigger = "none";
> > +                        default-state = "off";
> > +                        panic-indicator;
> > +                };
> > +
> > +                ledwlan: led-wlan {
> > +                        label = "green:wlan";
> > +                        function = LED_FUNCTION_WLAN;
> > +                        color = <LED_COLOR_ID_GREEN>;
> > +                        gpios = <&tlmm 40 GPIO_ACTIVE_HIGH>;
> > +                        linux,default-trigger = "phy0tx";
> > +                        default-state = "off";
> > +                };
> > +
> > +                ledbt: led-bt {
> 
> The labels (label: node-name@unit-addr {}) for the above 3 LEDs and
> the group are not used, please drop them

Also, I think the nodes here should be sorted alphanumerically.
Otherwise LGTM.

> 
> Looks good otherwise
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 

-- 
With best wishes
Dmitry

