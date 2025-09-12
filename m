Return-Path: <linux-kernel+bounces-813794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AF1B54ABD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179F3168D7D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8A2FF658;
	Fri, 12 Sep 2025 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cGl4kyBQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A89296BBC
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675605; cv=none; b=IINYMEYymYkepwihs4stULPNd8PrLuIyLc4LxF4I6n5H8k1p8YRgqNV4XU5bpKDMOnIW2vn4x6it1UPKstOfmMzIwVOPLEj24QSw/Ly2UquAsre9iVHOt0VDeiQuJS4wRcD4vM8RvF+MLWY+Y0sxrflBguw3+tciM8SVJB/alPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675605; c=relaxed/simple;
	bh=lszRYL+Ecrj6hfbLW3rI/V8o+x71pST7A4pgIK7ORtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNcK3Bh4zv8sQR18In+WCSEvR9aavrrbRD1wqBa4461mLWgYE6HJpv40CeFXsbHLTz4dCJzCIO9UIvZcPM4YuLy9C68hBZrqiiQr1DIF0qw4uZdJgpbAzu/QDTZP3qWAvN84gJ4AqUdVPOwZM/tARC7MD06wAXzvvhyhwPD2gYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cGl4kyBQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9fHUh017701
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qxXLgShVqwLGUck55r1aiE1BCAAIyCD2UObsyto7kis=; b=cGl4kyBQUadgXMKN
	r/Kpk7zQoOLgT6yLqdil6OEl+Uj67NiXb64AzHo+RUkoeY/fSohHUEpOaAI683Fd
	y6WtlhUCyhQiD1RMdbNC6D4RL79bqXSWMfEkJXXl1NzlGK6GUDLMpIZyx7aFfqHM
	IPx/aUFqtkzwB2+jnldQ+QnsjlUPs9vvXy7WHb/XHtd/lb5QQBdVqDUuiK7oIFiv
	YfdnUaLM8b8YbC5NJctqtmBej6nvJoEBCbJUTUR1+9mja1MnOMKEoXSQB+KD+zfQ
	4PCjb3m5ukcObS+KZihMYHaCLBfgvBHIJbnaxhtZMAEXTzCpiAvVL65rrCgnuC7F
	8MDN7Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8ugt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:13:21 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b33e296278so392911cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675601; x=1758280401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxXLgShVqwLGUck55r1aiE1BCAAIyCD2UObsyto7kis=;
        b=A74JCS8Fix+lYzLCBB9EjnHExkF3YICVPEtJ8nqOtXsauUTJnHGO6SL+k2pIHP4p5J
         mCCW+20HtiTncaWIqmbdKuzfpdZoSm38nlhSJMWuEsBYgqzMDWJ8LrGTi8ul8LEZBEwv
         NuBSzWsqkLa2ea45YTvqPQ5LENtLP8ALTa1D6lX+hKhqQYshT/xc9PAR+SL90jlJC/bY
         wO09v7JehcvwIQwcP9S4D5pihmwI2GjQ7TcJdnuFl8DZ1Aozc36fKCfu4ZdNcPSlRWMJ
         P+KPaAdUwiUEXYADpPcdF7Yaf6+e0CvsijphdICyFdnm+Li3dYAw1F7LRlXgtD1vJxZ8
         Ljyw==
X-Forwarded-Encrypted: i=1; AJvYcCUPA8/P0v86LddwxHEQcH7jPVMPss2Oz+eJSc1axYOo0k3lFXVQJ0eH7VJC1iVozPCi4QRPir2CtHPiayc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+TIZuZ3jnAK2jqI51KEX6d3yCHAoeVTN8r/dp/Py28L1ynfwe
	H1l6X3GR/o1NQKky81tPzAKmQV84aFYsq1lMv2sWEHvezhwnotwz3hHBjRko6HNo48QK8yS4HwH
	VqeBVOr78pdMBhAy5GEoT1IxWG9Fu/bqQKaW3ZcO69KqNgFyE/+MdoPnz+1RZcGjVOSc=
X-Gm-Gg: ASbGncsVqmG8Q9m7SqF0HHTyzghxB9l6FMhH5JEVLVQdkL0O8BnGNrXSzpFllLMNG5r
	Lze6g1IoA31UY8gd7kM/6zF+vUgATksGa7oo2rG/9IWr/Ug4m6CXkmfNjmZfYQl4EuJ0g35ZK3c
	bIktgiwqY+a9QwNgcoj54uhkCC48pPko6ODWBMtZ+SaHM3HaA5LnTA1kOF+VHGRne5Z/dAFv65l
	sIzWFKSxGcWRk95x2kA9OXhXeFlf2KdYmhxuj+N+sncCmUO1HYOOgE/DClkrwQfJWz8ew82FNFA
	nUJ1kueCwi1p62P+dmTim6vnXM6pdM7Yx/K/1ExzJPqamyaDfoC2sZY96F3aNNOpaGPfqnU7/cD
	DZIQ0FU+z81gbSTeR9Wsaxg==
X-Received: by 2002:a05:622a:216:b0:4b5:a0fb:59a6 with SMTP id d75a77b69052e-4b77cfb714fmr19387111cf.1.1757675600661;
        Fri, 12 Sep 2025 04:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd/y9V7JIR0J7uzETTEsfcWKwZ60LOjy/zwNmRMp4881XwtyUxBdsIb+OOjUIc/XxzrjG+Qg==
X-Received: by 2002:a05:622a:216:b0:4b5:a0fb:59a6 with SMTP id d75a77b69052e-4b77cfb714fmr19386931cf.1.1757675599937;
        Fri, 12 Sep 2025 04:13:19 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d09e5414sm38020366b.18.2025.09.12.04.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:13:19 -0700 (PDT)
Message-ID: <ec31257b-fe10-4de7-8fb6-d649677f680e@oss.qualcomm.com>
Date: Fri, 12 Sep 2025 13:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm6490: Introduce the Particle
 Tachyon
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250910-tachyon-v1-0-5090bfd133e0@oss.qualcomm.com>
 <20250910-tachyon-v1-3-5090bfd133e0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250910-tachyon-v1-3-5090bfd133e0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfXy6ugUx2XsHO1
 kRLbJDHDNbxg8N19vbcSte4J3q3b61IsmQCWxJPfgdFZvsa5TZodxEMDwiXEpgLtwrHDX3pAFXW
 srH1K6fxPw9E6eiCEFU9uRzs7sIeGf8owXr9cuZ9ZLxpaJGJEsG29nePQRzJ3QS2LMapeoc16LE
 0Rsd8V9ghNYr1fGl9Iq/vh/Thwwzna04xNeZa+qkxVwG1LTcqvr3O0qB2TyG1Pg+RMCy3cn5qxU
 8UCDFnaVo/rSyfODCERkPLGx7ARg+ggrxpONsXxdThQPvx1VD+nV776lxGX+n6iQHJrFSkdyeph
 pg+K3r7zBowACU8DGGZsoI9X/r4g4xqOjKHohphQjWSqdz0FI7vDB+SVCGWo+x/t3lbRZmcaDs8
 C5LGjoXJ
X-Proofpoint-ORIG-GUID: z6mKwYiwM_wBr1XQ1u7WT1mAX545bkSZ
X-Proofpoint-GUID: z6mKwYiwM_wBr1XQ1u7WT1mAX545bkSZ
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c40051 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=_Hxo6uU0jCpJE4KgPD8A:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 9/11/25 1:05 AM, Bjorn Andersson wrote:
> The Particle Tachyon is a single board computer with 5G connectivity
> with AI accelerator, based on the Qualcomm QCM6490 platform.
> 
> Introduce the board, with support for UFS, USB, USB Type-C PD and
> altmode (DisplayPort), GPU, charger/battery status, PCIe shield,
> SD-card, and remoteprocs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---

[...]

> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&activity_led_state>;

property-n
property-names

is preferred, file-wide (you currently have a mixture)

[...]

> +
> +&i2c1 {
> +	status = "okay";

This likely results in a "falling back to 100 KHz" warning/notice,
please specify the bus speed explicitly

[...]

> +&mdss_dp_out {
> +	data-lanes = <0 1>;

Is 2 lanes a hw limitation?

[...]

> +&pmk8350_rtc {

I see no reason for RTC not to be enabled by default

[...]

> +&pon_pwrkey {

Same here> +	status = "okay";
> +};


> +&uart7 {
> +	/delete-property/interrupts;

/delete-property/(space)interrupts, please

(yes we desperately need a formatter)

[...]

> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l6b_1p2>;
> +	vdda-pll-supply = <&vreg_l1b_0p912>;
> +
> +	orientation-switch;

This is specified in the SoC DTSI

[...]

> +&usb_dp_qmpphy_dp_in {
> +	remote-endpoint = <&mdss_dp_out>;
> +};

And so is this link

> +
> +&usb_dp_qmpphy_out {
> +	remote-endpoint = <&pmic_glink_ss_in>;
> +};
> +
> +&usb_dp_qmpphy_usb_ss_in {
> +	remote-endpoint = <&usb_1_dwc3_ss>;
> +};

And this one

Konrad

