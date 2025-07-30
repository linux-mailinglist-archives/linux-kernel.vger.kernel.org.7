Return-Path: <linux-kernel+bounces-750818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA4B16163
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47244564623
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398329ACDA;
	Wed, 30 Jul 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nv/zDsgX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DE529AAF5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753881875; cv=none; b=dpAVbeQcoNSIq+VaT44jaM2PKcIVJuR17cxTcJgt003oHz7yZWoFq9YkRfq+SVsB/fco2SsPBKNhWqMPT5qDWZshpYOISye37iwpfnLMH512IlDR3ZCK90g8BrxsRijz85CtvZ4vPgcFg3B4vzXEFGe2uH7WVGsVeI6gDDGnyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753881875; c=relaxed/simple;
	bh=e5IwqqJeeCUDusazZ7w6XkeOtv7ySZo6uxGQet2ZmjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fg3ZN5sJkz7nMXqM/UWfWF42mybgyqvK3TsN6u9r3D/BYygts2TXtvRky7wAkDvWRlyVv0eKvtQMVIKRjPL3S2pbusNxL66nTrresEuTV0C9Jnw1q/U9BISGGpOIIh+LeL0XtZU+N3Yi18ns2EnelTMDjEMq3zYy6ID5edfbK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nv/zDsgX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCb8A2009681
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xTzI3N8eKRe/dkZlaYa0pONj9a17JsdqA7y1qmJPaXQ=; b=nv/zDsgXDUZzZWoK
	3pnSQwA7AkfWBjxOvzCPQ6TW+45UOkWquG8nIFBRDbPRF6m91LAVzvxw9o2NV0ug
	QgX+aA4I6LG3RtB3zG5SnFUT4LKd5SNwSqGhEk8jjDQ64/kH6azeKKbFm7EKdc91
	5FrMF5h/jMudSgX/C8qeqRjMCyu48IHGNlha09w21tSraKDAw2K35cQYn4KAg2pZ
	nvBUq4EW9uvtTIp2wQjXA5+yBi/QIUU7eZuXCeZYJFiUQ832BYA1Wo8ctjF6mPGf
	y8aJs+Q2+da+lcSfuFVMG57tLzPo5YQMDfqZvk63205ObTIG4unPDPWcy2ZVwInE
	b2JGSg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4860ep179k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:24:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7dea65840b8so54462285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 06:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753881872; x=1754486672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTzI3N8eKRe/dkZlaYa0pONj9a17JsdqA7y1qmJPaXQ=;
        b=IoeVbZReMJyqZVWQAkk3zgG5B0CdILKTeXv1sCe/99sHlrp2dcli3xyg0OinPAhTZz
         40hBs/xQEaOGKwuvA4XCWOQjV9RZkAFzh2FsRoN3CXJPVOggC3YBXG8EcmFOXNoQYroT
         Hf2vxDsfCFqvudduyhD82nzhgeCqCciKeyq0M3phRzUhGuQtu4SYDafsEfYsCR1nqk3Z
         TJCQavY/A2vS0G0UYicQHX0bEkG4s63xVCWu6nTReXDNGI5fa9cVPu1NwTeMJFqCegWo
         FDBcGKgeG13xhbX2CBVqgm9Y5oBO+SO9tuERV7a3mCEGpsXpuh2aBr0gcvUISUGovLHQ
         4izw==
X-Forwarded-Encrypted: i=1; AJvYcCXL4g/V4JNhYXtgSjwLwCS3X7gpLzBdb7DkTOymttajplBajF7kGoja7HofDHtqTSe1mBP4F7uCcCAQ+hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr15hGB2bA0yXvHTabJbzKQDo67C3rsCtQskPHYKSG2G/yfQc4
	ef6z9SSfbck9CUbnstwAFv7fwbH7IMPpFQB7JZDvQZgYho0mw/WjuU6m/YAGui6GfWA/RPYlyyL
	xKE/kXVnUu5qZdnPgjEQgveaB6te8eme+WVzclBmPG56Bq8zlJge8JkIcKZ2jZ04SW/o=
X-Gm-Gg: ASbGncvxx0AjY9OXC602RQqas2yOT5ftB4F9zvTV5+LV2HTjWLNNIwgsLL8Ddt9GGS+
	mvUZ13wIxxE62NSptYnHSmd1bEp3o5ooTPFSG8d/a8RuJLd7UPDIJ5H4TVNIbtwSsA61Y06WIuY
	1VAjxiw8A21OsGENrxopTyG3QL3lpEysc5cmqUKIGfxkftN69vZALLW4+x1uIjVcqNYlSibSfZS
	xFVpppy5meWgb2McAR1KPccXy0h8a9BqvA0NfyDnXryCDA/fYqu1WggPwYUwjUn0vNMpcCLUVU2
	TuFvL0BpekvxDCeAL5+oNzkD1qzS0wmBbWsLb4VBiHgDGNVvom1pfRgYZzmBbn8Qs2ol065PSJQ
	Sdt16fpmtBVtgehJWsQ==
X-Received: by 2002:a05:620a:280e:b0:7e3:4535:4f7b with SMTP id af79cd13be357-7e66f35c7e1mr216229085a.12.1753881872291;
        Wed, 30 Jul 2025 06:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGhiBVwlELcMoRQwGB79Dr2y5jrjodmypBvSVsOqt9WTv9u/8VXfq5aqICzEbt9JwVIxNH9Q==
X-Received: by 2002:a05:620a:280e:b0:7e3:4535:4f7b with SMTP id af79cd13be357-7e66f35c7e1mr216226885a.12.1753881871792;
        Wed, 30 Jul 2025 06:24:31 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6155181f641sm3377347a12.36.2025.07.30.06.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 06:24:31 -0700 (PDT)
Message-ID: <a58eb607-74e5-4f31-8ea2-b38ebbca5344@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 15:24:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcm2290: Add TCSR download mode address
To: Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250730132230.247727-1-sumit.garg@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250730132230.247727-1-sumit.garg@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NvAVLeIRF2aDWUzV7T1dkUDtz5EqjsB8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5NiBTYWx0ZWRfX4CSog7pBc4WY
 Puj5gGSL1GJ6elaRcgnya0EHBD5BofAnWDE6pQ7T5J2cXuxRzrHOFZpCTLunhvn960BO/3lT0OG
 ccPNNPvmZP6HpTpuJXL0Q+wPlswKxM01lGFZWjevhSl9LcYGS5PDIj6HL3h0Ui6nVMVqi6L28+t
 GFeOhOR+tNF5VxkBaQxJUlk7Mv8qRH3oUsQdp80IAw22ksz0vhoR8qro8sOrbFo/A4q3iegCq+1
 gAFOIMHTKn195Uf4GpcIn39dnjR+t2/+iYkAVCzBWVLYVbOXKYux5nUQBpEujRzKrSlxm8Y4xva
 Amsu5dTOIfNuJrPPyDeJyGdXCiRVayGAtcQ940vYiDjmi9DqparQc3H6/3wvGVlDWy9FyA+Rzh8
 ufMH3qWu/gwuuivnvTJFQCxD6DsWwSVweUhfKcX59JjnAQE8pNePkNKLrj3+hl2nVEl3uyGG
X-Authority-Analysis: v=2.4 cv=DIWP4zNb c=1 sm=1 tr=0 ts=688a1d11 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0h7C-uHhpuvjb9gYxF4A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: NvAVLeIRF2aDWUzV7T1dkUDtz5EqjsB8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300096

On 7/30/25 3:22 PM, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Allow configuration of download mode via qcom_scm driver via specifying
> download mode register address in the TCSR space. It is especially useful
> for a clean watchdog reset without entry into download mode.
> 
> The problem remained un-noticed until now since error reporting for
> missing download mode configuration feature was explicitly suppressed.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> index f49ac1c1f8a3..08eadec59882 100644
> --- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
> @@ -154,6 +154,7 @@ scm: scm {
>  			compatible = "qcom,scm-qcm2290", "qcom,scm";
>  			clocks = <&rpmcc RPM_SMD_CE1_CLK>;
>  			clock-names = "core";
> +			qcom,dload-mode = <&tcsr_regs 0x13000>;

Can confirm it's the right addr

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

