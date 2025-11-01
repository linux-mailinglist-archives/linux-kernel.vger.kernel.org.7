Return-Path: <linux-kernel+bounces-881164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9626BC279CD
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 09:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4E5C4E3290
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 08:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A729829BD9A;
	Sat,  1 Nov 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YiHyVG1/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dQTz9N+Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46F29ACD8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761986407; cv=none; b=uH+sQqJS+06CjZy+Ma5SXWy0EoSlOhFEGB0YS7HHaB2MWVZ4gwsPeaHMkST3bJAB0VG+LDlR3bdeZB7OkhH6eSrTRMaom2zuhOHgeiz7cJBOfr7os2572mhXQpSlyDLzElsIhmS2tdZDF9RI7ajwvfCMk0guDcp4DPkrVGlrC1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761986407; c=relaxed/simple;
	bh=Da0py1Y0E4x4inIQd2G3+AMVd3teJHimqtvZ03C6K1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=po3vo06rLUzIKZoniwEtPa9lBaRFI/5vAuVp952ZJ+tVQtWyH9FyUF5L3L4LE552lDxo6YisdoyyJkYjkPNVBOGx0H06R0TafONBsQUujHoTQBHIFSQTSpulunmlOQWqoquI9R0cvDdSyScvT73a26fnwtG98QOrv/QE2dzq9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YiHyVG1/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dQTz9N+Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A13iANa447301
	for <linux-kernel@vger.kernel.org>; Sat, 1 Nov 2025 08:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iiDPYD1MU46TmXyxWiXXTtTFKJuO4K8jYXckjJideXM=; b=YiHyVG1/6H3wiyse
	PlS+APALLWJ3BKu/yiRG/e8AEuOFKTGOxz9TofFfn58A0aHY1W2PShNZp98Z9fmK
	KFEcGgevzKGJ7JL/O97TMIufwY/58Oy/ekUapb/RxvmXoSu3YEYMEwI58lPwAV5x
	ERPJdjU3kTj0feqA7C5SK+Mw0VjAS7tCLp7v1U8FpBTtKF2ztOTfkUqM/B0/6vP2
	U5XFqwCD4/IVHUyvl+Iin1dHoSrUKwoK87X3TjWsExB9T+ZeW9yBVfMThgf3AOca
	VA3bNGzyW3jckxejoAKLLclTyKy9sN1DALHaaz/KDHq2BwFDDWIMLd9APFaAuira
	jUp+Sg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a5ae30by3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 08:40:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed240c3d93so27548071cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 01:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761986403; x=1762591203; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iiDPYD1MU46TmXyxWiXXTtTFKJuO4K8jYXckjJideXM=;
        b=dQTz9N+Z885HYE2TyHkik4d0D9rWoj7Bfg5HpEIYiEHMktBRN0ch+BM1Mlifl8kMoM
         2Yp/lvVMxGJGxOgMjFSEUImfHpcVOd0NkPzYFtNOsyeZn1yJ6dnOsIbwzitJHLHAipkQ
         qIN3IE61rgNwwSfCcjB7dFvQseXw7cys9SYZJyhRU+rN+/LtFdqn9HfTGQxM24tcZG7c
         NzhKs7p+UN/2EHLIofbKznFg5AK5rWYOMEAqMpyb4GhmmlCcMd3YLHDEs1/PwwSJP+GF
         qy7Zs4A/M/m0JusriUoDlUEdL1FmEuIu90+Dr7VazBVL8XbOEoQXHSlf2i1k0kyvJy6v
         8W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761986403; x=1762591203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iiDPYD1MU46TmXyxWiXXTtTFKJuO4K8jYXckjJideXM=;
        b=bXHde0iJ4b1BVVlx3XQuOSiIZhwpb0NiXNwakbohpTjPjVNKTeK4XOOwcUbvLgfx+U
         uU3vIvwpOlTQ1boGjzjXtwP2A1kR7QoEZyfrNdJ71KmCdmrgpZbmOdbD2ODtHYK7fk3e
         l9FkQ1/wrsOQNPensZWwRmXBrgF5cpJW31/UxeRdQVt6BJQNB9lu+t3zYxJLAHve38nu
         hau/2xsJdp/8M1sOAebi9daCFlIHibAwabiT+kEenPeLZKhVj54e0Cyj02C71C87FsEF
         GlSabH1juzu/IpvUJETgKTnbCZQe/M0ZkSO8UqitkwQtqhO6qOJhDAUeSOmsxJcrJI0O
         YNfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG8FGajHOvh13H51kHx7COmQcEJlAG7TYYXwLeklrrpWf5RGGE8W9QePOhYCZLdFkb6xlq6u8XYdhYuZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpC5pb6FP9OYtTHI3zGWRiPbKG9iWKOh7b/JFI27L3DtnSAoz
	I+UvJnLJkhpPPNCr3skvCCgaAiZjI/VhDAqxPKM7CQauwzlzRChZxG2GgZAidi6DYtyBQwz701h
	lA1dlpZJBWWGHJeu54hnFuChzGAu1St5FaxIhva2PRbLzYmsibFPIvF4HzE/QCO4yE7E=
X-Gm-Gg: ASbGncsmVcwc/pCxgj6RXvia+RcD4GTXwUJVwuNh5nCkuvPKD3Ly21T10qzai672ZKO
	PcY1eT7znsF+CKFqSDhDT+HeWiwiwPuoEJ2wRxdiFm36C+onUwQAtg2vpcad1DAw15nHMCSSl0J
	CYYEfDzNsgHrsS6dONIGbc0+4b5vvfh2USmwtQLy50R8tCbjqgvCc+43UaSv644NHlxtVbYMQiv
	nfYIgsUn3e0TsJFCZvCV4VLLrVhEdRea0h6awIt4tOSxyDrcJoNpOU0ywlsDhz+9u2vApmbpHPc
	St5a0TCyQ6YCvow8iQDqnnLk9FNkuXlcpuCb0jPZ+wnOjqtMwRjEpFF/6BwDHOmAeExlrVYchWs
	Tu3yrdnfgXHLVmkkDN1VhVUxARm/uZUMuUDTYGhTQAFJMTJFhZRhmzO3iuFtLDl5hSuMsEoxros
	uo/522wMiFX0UQ
X-Received: by 2002:a05:622a:1b19:b0:4e5:6c5e:430a with SMTP id d75a77b69052e-4ed31077a89mr88339371cf.64.1761986402545;
        Sat, 01 Nov 2025 01:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU9EgMJhiC16qX9D2bKMP+GqfW3n0SmoSciun4HYpBFMbXg5yU0XcuPEvAwldmaDJv1QV+1g==
X-Received: by 2002:a05:622a:1b19:b0:4e5:6c5e:430a with SMTP id d75a77b69052e-4ed31077a89mr88339241cf.64.1761986401945;
        Sat, 01 Nov 2025 01:40:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f39d2c0sm1081455e87.46.2025.11.01.01.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 01:40:01 -0700 (PDT)
Date: Sat, 1 Nov 2025 10:39:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Tessolve Upstream <tessolveupstream@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: talos-evk: Add support for
 dual-channel LVDS panel
Message-ID: <mit5xey5rorafacljgnayvjpnbkvtpxis72pzhgnuvjmzmc7sg@c2v4bl6dm6wq>
References: <20251028061636.724667-1-tessolveupstream@gmail.com>
 <20251028061636.724667-2-tessolveupstream@gmail.com>
 <d05fe82a-640f-4a09-9d83-39bb5aff179d@oss.qualcomm.com>
 <9208d2ef-79da-4e80-ac1f-e01fa5feae0a@gmail.com>
 <sfxvtfzzstdbt7in6z6ztsjfy6e555fr3sjbi5kqkv5sk77b26@kl57zs7iuuvk>
 <ae9021dc-e0ca-4631-b45b-3cf9f526bd14@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae9021dc-e0ca-4631-b45b-3cf9f526bd14@gmail.com>
X-Proofpoint-ORIG-GUID: FsiCYW-NJjbbaIKW_HGH8wirSpXixjhM
X-Proofpoint-GUID: FsiCYW-NJjbbaIKW_HGH8wirSpXixjhM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA3MiBTYWx0ZWRfXxRu9UEH8LULn
 XMQpGDqBmmRPVptmQlmfQolc+zGXmCBWFV3QDd5r7W9QxelOahNaxf+ChPyE5Y3n+9VCMWMICDh
 DUclDJnPZMrCeatA8Kq1UEhhtozAAZEqfYCSVijaRe0t+rE5J/yONW+tNQizG4P/+ntw4SNuu8B
 c4GO+RFrj4ypE4TmeA8MywNHpjBqEaKe5YuY4WS5DSt63lw27hVNbE2PcWnfCYzTnkmlgN6rwL2
 C7PwGms0QCDl/iw2hAXDqquhuK+PUuduXCNynlbaI05yA36IueKW9dwm4V92p4yVeI3cV+c1Siu
 fU2OY81zqPRj/7ADiv9O9qpyctBgR9zPsyaUQAwCrPukdqVX4GEQsbC0PQgHXldaM1pInSaIQ6C
 mt23R+qkhkKHwJ2McTb7L+W7ubuvOQ==
X-Authority-Analysis: v=2.4 cv=CfUFJbrl c=1 sm=1 tr=0 ts=6905c763 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=DJbqY3hvPHzaRxFNiBYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-01_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511010072

On Thu, Oct 30, 2025 at 02:24:15PM +0530, Tessolve Upstream wrote:
> 
> 
> On 29/10/25 18:04, Dmitry Baryshkov wrote:
> > On Wed, Oct 29, 2025 at 05:50:01PM +0530, Tessolve Upstream wrote:
> >>
> >>
> >> On 28/10/25 14:55, Konrad Dybcio wrote:
> >>> On 10/28/25 7:16 AM, Sudarshan Shetty wrote:
> >>>> This patch introduces a new device tree for the QCS615 Talos
> >>>> EVK platform with dual-channel LVDS display support.
> >>>>
> >>>> The new DTS file (`talos-evk-lvds.dts`) is based on the existing
> >>>> `talos-evk.dts` and extends it to enable a dual-channel LVDS display
> >>>> configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
> >>>>
> >>>> where channel-A carries odd pixel and channel-B carries even pixel
> >>>> on the QCS615 talos evk platform.
> >>>>
> >>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> >>>> ---
> >>>
> >>> [...]
> >>>
> >>>> +	backlight: backlight {
> >>>> +		compatible = "gpio-backlight";
> >>>> +		gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>;
> >>>> +		default-on;
> >>>> +	};
> >>>> +
> >>>> +	lcd0_pwm_en {
> >>>
> >>> Use hyphens instead of underscores in node names
> >>
> >> Okay, will update in next patch.
> >>>
> >>>> +		compatible = "pwm-gpio";
> >>>> +		gpios = <&tlmm 59 GPIO_ACTIVE_HIGH>;
> >>>> +		pinctrl-0 = <&lcd0_bklt_pwm>;
> >>>
> >>> I think your intention was to use pwm-backlight and wire this node
> >>> up to that
> >>
> >> Soc does not support the PWM interface hence we are using gpio 
> >> as "pwm-gpio" by setting the duty cycle to 100%(i.e. "no pwm")
> > 
> > Why do you mention PWM here at all? It's perfectly fine to use
> > gpio-backlight. That looks extremely suspicious since you are not
> > referecing the pwm-gpio device at all.
> 
> Thanks for the feedback.
> GPIO59 (LED_PWM) connected to the panel’s dimming input.
> 
> Since we can only drive the LED_PWM pin high (100% duty), 
> it does not provide true PWM control.
> 
> I’ll remove the non-standard "pwm-gpio" node and model both lines
> using the standard gpio-backlight binding, like this:
> 
> backlight: backlight {
>     compatible = "gpio-backlight";
>     gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>, <&tlmm 59 GPIO_ACTIVE_HIGH>;


You will have to adapt the gpio-backlight bindings and driver to handle
multiple entries here.

>     default-on;
>     pinctrl-0 = <&lcd0_bklt_en>, <&lcd0_bklt_pwm>;
>     pinctrl-names = "default";
> };
> 
> &tlmm {
>        lcd0_bklt_en: lcd0-bklt-en-state {
>                pins = "gpio115";
>                function = "gpio";
>                bias-disable;
>        };
> 
>        lcd0_bklt_pwm: lcd0-bklt-pwm-state {
>                pins = "gpio59";
>                function = "gpio";
>                bias-disable;
>        };
> };
> 
> Let me know your opinion here,
> Thanks in advance.
> > 
> 

-- 
With best wishes
Dmitry

