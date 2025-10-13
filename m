Return-Path: <linux-kernel+bounces-850134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E2BD1FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEB254ED293
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761D2F28F1;
	Mon, 13 Oct 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oXNudYia"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFB22F25FF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343461; cv=none; b=tPf7BQzmm759cy/9dQl2kWigte/27VXBMKMS9+t0eixSYybuxrsox37/wT8ida1q5Xzr+t9/8muf+yfr/gRc10YD+p7+FdtIJ+SSjUlK9c4fql7+1v51XD1v+uW5Z7+Gk4kTe5fKzHqBEXpyPGONJqZKV410lb3t7sKc8oMUdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343461; c=relaxed/simple;
	bh=SJhw5vhfYi8mELvzUY6nKX3txrFMIMqW1JgIFNGo4Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRZ02MUaTj3Q63k24v81Q1k6oQ8BrRle0QtDe6bA2RLLy0EDtGx0aHeCUPNAkgWqgzz9CESR4Ob6xxf1dDjwM5epLi90HcG6banRT8HP42RjddD6pi9jH8/GfuEokIo+6QoV2pqt+jxV80Pg/Izy2zadv0Nubc/knCL8kNqeMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oXNudYia; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nMQh011098
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D/hSBO4JMIhm+VIzVQtzVCKQOqmVbVETrjuAEMt01aw=; b=oXNudYiavdEHYW6q
	Y7TlxCFzOBkWjTqdGsX+Lj1Ga3kli6kDrejuEt4jsmKwdXgac8vQ4vP27J4vW8O1
	KPeLWmCXXVB64DKVuhDuzNa51D7ydXy1psrHrxUV9QN1LmTFdyT5tbK+nM7yHgyv
	kGoGj1hYV9zF16G+IjEX+M3lq9NYtEzXuSVpupJ3hjQJjD9xfLZogGlF1/sA3srv
	lSBf4asJ8J6OIlCmXtSzP6gfv+DfyC9CkOUjIMrNuj+FdZPj1PTUzWVvDE1Eu1OE
	VKqmGtCVA/esLLSkhDYuMU9JVDUy3b6/i7mFVfLouXt8I6/KlIs53O+ZTW9CRSUT
	RKyOVQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0buqwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:17:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-853f011da26so282617585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343457; x=1760948257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/hSBO4JMIhm+VIzVQtzVCKQOqmVbVETrjuAEMt01aw=;
        b=cc8PEVUt8W5yVPGkxMCSqTriamoFDTxip2+kkgPZYyOGVhSGyDfzIn8pcjWhqmYaJa
         +Ms1l5PQLtHUhEAk7YAw824x0iDd6XeDECK8jL3UWwPikOpq4ybPZekuWU81BanOvQT3
         8Y+UXKB7z0PzG6cxZOWDtkiv/iWtWcdCAsCDn02iwB/AxvC95vstZZXLcdQgUP+lN8TL
         CJZxFVNp/PoonDs0yqmR8n7pvD2Crxlghut8p4WQN5KfeSsLMADsz3TWBXIa3rf5iY1d
         tiol6aOyq6oHn8RmA/0sPn1Bwkzwd2XHyHYpWaAJHaIuq2tQmFtR7DVg0DAl0RrdJTNf
         iaXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQeQ9H1JtogFlKcntyZX0i+6n03DugujvlP0w313/u5w+zAZcGeeQjHsIU7W4oNiNGouVvJTIjKaEd2XI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUiywxw3PXGTBEJPyBiV6gGdnCklnpd4TNqZyEHZ7QrY52wFl
	MZXENPCeLti0VP6OQyBmPCZEowNfiyJ+REq0WJgB1pJmN5qaiLQXjLj4IiEz/wwz0Kc7Xm/ZO+z
	UeVNJAgK6A6fo7NudBX5hEUrc0LZT98M3KVsEUqKj84Ls0CIp+m4hVlysJlSE8jdZ3fQ=
X-Gm-Gg: ASbGncuyf7kalHcAsxU9PNm3kXKcxsp+KUvjiYmkKEtlwdbk/3I7KLhxg8nP8FYAK1h
	FFko07bEbfqNaBtxSZJ6OEDdV9PQqbGkxcBFvr9prhdwq5tqMzEgJuFWCZJybHBkr4NqinRek6e
	Vn50ekyT6PFJYKbbH0IuXz9RIQ92I9dJ/24eO315SBLmbbbTBJvjepft1cZywwH6kumJH2eSSUu
	mt96J/TulsRtn9QIWeG4ddLyIRObItDX3H/9S7a4RB3+0hK6tRQJUDKypKPy+75ChOActb/FCiX
	0kL2vnGWcSDSE+tpr/rJyIH+glEfgYLlZOjek2e6za8voh7SVdRjS3lapm0w/n9R/eYFRuWUjIs
	q7uAJ9F8r81HALbjolkG7vA==
X-Received: by 2002:a05:620a:4107:b0:827:d72a:7b45 with SMTP id af79cd13be357-883525c2e75mr1943379185a.12.1760343457520;
        Mon, 13 Oct 2025 01:17:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEg1Cytc7cxncZGp15l962GuOIDaNAUKx773DxqnPs6dpbD1VJGCA2HzKR8IrepSdXmWy8rtA==
X-Received: by 2002:a05:620a:4107:b0:827:d72a:7b45 with SMTP id af79cd13be357-883525c2e75mr1943377285a.12.1760343457008;
        Mon, 13 Oct 2025 01:17:37 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d8c12d2bsm881038366b.49.2025.10.13.01.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:17:36 -0700 (PDT)
Message-ID: <8554fb52-cbb1-4e5b-97a5-ca6979dc7729@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 10:17:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: x1-dell-thena: Add missing pinctrl
 for eDP HPD
To: Val Packett <val@packett.cool>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Laurentiu Tudor <laurentiu.tudor1@dell.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251012224706.14311-1-val@packett.cool>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251012224706.14311-1-val@packett.cool>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Vu020-nCMsBuGMLUvU_bfusnCYmnhUGo
X-Proofpoint-ORIG-GUID: Vu020-nCMsBuGMLUvU_bfusnCYmnhUGo
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ecb5a2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=uNKBZDDHgDJNm4LnVW4A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfXwgD+copYChM3
 UzBYM4nl//tQNF9bLXiyeLItnEfqvFvE5rf6yHSWm02zJ6Az53ddBxt3QBfSCkNySWKDtLWwNoU
 rdKms7oxYUEK1MFJ6QJj7wCNF9BFNA+4n77gBi/1lphh6y4885Lzllzsi99lE84pv/uKS+jYCnF
 8xenQduAOt216aM8HI7R/LSQCodwsUfw1Gpy2sEEtoJ3wczQB7roAc3O1uIW22iQb00mkNB4QGV
 QLim9R+Wx0GGT/+oaDXK1CCHzcbEgVgZ6/I/U2YedinFSYFds49kORW7S/sBsw1pmQr6HQwSU/7
 5s8u/hYxBCp4mna5KNFYZTSrwrsnixSkt4fiWXtLMeYHwUUVYxow/4OAJ0Rx/f3E6MOIcFX27GD
 8SyNTqOGcJJVLrUDCev8OwG56pkPIw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On 10/13/25 12:40 AM, Val Packett wrote:
> The commit a41d23142d87 ("arm64: dts: qcom: x1e80100-dell-xps13-9345:
> Add missing pinctrl for eDP HPD") has applied this change to a very
> similar machine, so apply it here too.

This is somewhat redundant and not very convincing as an opening
argument

> This allows us not to rely on the boot firmware to set up the pinctrl
> for the eDP HPD line of the internal display.

This in turn describes what the problem is and how the patch
alleviates it

Konrad

> 
> Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Val Packett <val@packett.cool>
> ---
> v2: fixed commit msg style, pulled R-b
> v1: https://lore.kernel.org/all/20250927032330.21091-1-val@packett.cool/
> ---
>  arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> index ef83e87e1b7a..0aad80a1159c 100644
> --- a/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-dell-thena.dtsi
> @@ -1104,6 +1104,9 @@ &mdss_dp1_out {
>  &mdss_dp3 {
>  	/delete-property/ #sound-dai-cells;
>  
> +	pinctrl-0 = <&edp0_hpd_default>;
> +	pinctrl-names = "default";
> +
>  	status = "okay";
>  
>  	aux-bus {

