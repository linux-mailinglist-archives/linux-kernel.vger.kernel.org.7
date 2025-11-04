Return-Path: <linux-kernel+bounces-884427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3861C30269
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA061881954
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E35D2BDC15;
	Tue,  4 Nov 2025 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ezN95ukD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZcotNVSx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F952BE7BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246807; cv=none; b=cV80fhCE6Ejkerzh3uu+Vm5lGNklfHgqmi/vccf6gXrZJvbnrahB/pna6uTqoWAMkg/tMdOeBod77hzy8kjtRXViSeTOLPF70x6kc5ya5Dx+ZmhLMfVpXqILBzqtUzOHq4XYEzalbAiq2j4Qy9Sa3YceKkmDA3kO+X8n0ue/MDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246807; c=relaxed/simple;
	bh=VJU336hhaZ8Y/i6Xvn0BgBPS0c+fzGU7RnkAwGDvQ9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sMr/aUV/3SLA7/tpX57a3fZSODmgwOniwgC5FkTUcWI3wj4D4aHgGVAnGXLZh1UsiE73dQR+4E6WRySmyC0ao/dCnapyKW7cvKL6LRnpFwB+MaI3J3HF6gzEhZq8b+c96v1qylt1uDhnRllBNQCdKp1e4lfwDV2DlTsQDe6RTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ezN95ukD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZcotNVSx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A48gi881545988
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 09:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FrTRTlMklQUT47bJopQ4g/PDBm+i0TkfnULzFf7+la0=; b=ezN95ukDqw+8IbFR
	PcQuVwcQj0+UzlvaaxgBudiKztG3cga3573GcFZ1A41xwcIi19gw+ZpMKSHjXM2i
	WxQwNpH68VdoArv8fwrPQv/q0ieyFNOt1n+jISkPHZC3IoHhrDEyVpefAOqdwhCm
	J26iHFQcfs9o7G30fqp0aJ/WYQ75dSF8S6ObX9cwWIBF8ky1YBoxyQDw6Z6epak6
	2z+QddTdI1ll4LSeIh4a6UB89JhhPi6I2PISBp+br4lyMdg2w1lFzwTHrYOWTQN8
	JbLKMZpAwrAY4ITt261F91uwf2VUXF/MV2MnlL3n6Igr9p5+KuEb/eb3D/dCl6AQ
	KO55Gg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b39pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:00:02 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so4453319a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762246802; x=1762851602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrTRTlMklQUT47bJopQ4g/PDBm+i0TkfnULzFf7+la0=;
        b=ZcotNVSxhsC4WfCMBdY1D8WLi5o6I7HavW57zx0F5NOdYjngfIOj4J33TT6ynFzNW1
         V1hB+8L5FijnoJKQvA45NBoOHA0+RPCmw1ccY24qGROTw19IUCoGnWibaFW70W4Z3tmg
         i2aeTS7qGie9W81izdKGe9q5MZG4xP+vHXxRIJZkOJGVYQ7v0D9T1YqXtlTowGjIxklw
         tQ8B2vQNclD0EFWvoQ5e6tbTwcinHuT66ad+HTZ8HsTRbh08D/T0Sf7UqV081YRK8cWl
         3ohdpxDKUW5gH9DkH0OhvbPyqra6Ww0S2B5ez9RYH+yODrKwr5+KNPyR/u23R1j5tEsc
         jXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246802; x=1762851602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrTRTlMklQUT47bJopQ4g/PDBm+i0TkfnULzFf7+la0=;
        b=XnPkyFBvv2Uur46yHsrRbu3EKOgB0jKegUhOYaAs121SPFzD6wNI3wt4BgKcPoHltK
         MC2s8wHmuiT6KxqPAJAmiOS0bigDJzL/rgXMbNPgXWMaLGHefgniuE/Agg/ZRqoCgPvj
         L9Zg7fbzGxBXqkG1ao/BtO8g3McsYF0Q9Abj2f3QWgXszzVSNs0qHD4QZnnVQsHO5WXU
         OKTvuE2t7Bmfym2zIYvzKANsyJc7tzJp12d+Zb6czjSWbtjQVBwIlS+ozhkLlYMY/2Jp
         tX7kQ/9L4n12QKuesjJe5F/bU5cmaGz6gs7IbrkSAMliZNrq2cSsTIOZWm8r5vGdY6OM
         SPbA==
X-Forwarded-Encrypted: i=1; AJvYcCW2s55BqlRjqHReKqzOF1qXlSumffKZUFO+P3Cl9fSI4OepRtdDMT9UrnaMRDPGOLWYICAubIjgeo8LKZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIA4fac86VisVT4EsWpVS5b2ysYSw2T6Hj9AH3MYww6gB2X/Uq
	BnYkghJ5Up90O1LzQNDo88B9R3HbGjy93qf9wTMxcc5pUBD5JFrqrWtkSVN9SXO8pfgrI5/y3z7
	nO5JPEfgwXqlvMOGBbdF0M/p+ATbHrd5LZmBftIh0vnRSrQ5UmysgXTdF8UC6/GwOP8Y=
X-Gm-Gg: ASbGncvxddmhun2clCTCjpfYg39QDKLevFK9bmnwC/4vUUloVazIMcnVq36s3QxQvXc
	2A8Un1JAK02HNMOJQ23AIU412rBa13JJ+3ZzvGtk+2O9frqAS1EVcD4YX+8wdS9RLMBqVY4HhwU
	dkx/62MotWFbFyKeqSbHwTKyDExJd92ZYeU9RM7ggTmL3H9V2CHVWoePfUhD7M4jdGmAaHjPYYw
	AIiXq6/wDirtI6aSdb7zL4neTMY34idLRZXT/8Q/L2Di9m2JZGf8oOSkm6ykgPkrXPVjKyWToZD
	Qrn6OREebo9BujLTOwCBRWMRh+kAYPW1U9j8P7ZlbaBb/PnBUehOg3LCXjKYopTmyCu6S/0WY08
	wsWNl9rSk0zuOyYSqT+QyD5EFToIQOOdvFlvuE7atbW5XQ3t3gNJaMmOzuRwNKvKSqXSlvQ==
X-Received: by 2002:a05:6a21:99a7:b0:342:5ba7:dfa1 with SMTP id adf61e73a8af0-348cc2da1e6mr22678006637.42.1762246801948;
        Tue, 04 Nov 2025 01:00:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXLLh9ZpMe31D/zrlefkNxbOKYpTy3/NGJojCkBE/8HyKDsARgDlkuua4gZSMzgowveEGglw==
X-Received: by 2002:a05:6a21:99a7:b0:342:5ba7:dfa1 with SMTP id adf61e73a8af0-348cc2da1e6mr22677970637.42.1762246801383;
        Tue, 04 Nov 2025 01:00:01 -0800 (PST)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3246e70sm2158624b3a.5.2025.11.04.00.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 01:00:00 -0800 (PST)
Message-ID: <bace46c5-e912-4003-812b-c654673be43e@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 16:59:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/20] arm64: dts: qcom: kaanapali: Add remoteprocs for
 Kaanapali SoC
To: Alexey Klimov <alexey.klimov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, kumari.pallavi@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-7-3fdbc4b9e1b1@oss.qualcomm.com>
 <DD6B62STZOTG.L12V3DGNDZUZ@linaro.org>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <DD6B62STZOTG.L12V3DGNDZUZ@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA3MyBTYWx0ZWRfXxquNxfm47qwE
 otUQqSVF8bZm6Tpskye0KIIU2LM9dtBCf1I9/ZiC+EuPf2FbNw5XFEFFr2TvzzA9FJufNiT/8Q0
 DWHE+OSlatpPm/LwtoHqMFFffsQTdFMMSV9FvPON9gaHyT8IBQYUFiPFUC62TKC+bg6Gy8qZRwS
 T55IpNFp6Vcngvw/w0vnuNwJkKogDoSYI2s2OEhzxCzLAtohXbnkjwnteTpUlblYZRaD/E+meLP
 hXAvN7nkrtNRB6WwaNuNhtf1hlhDSmR0ymfrJg42TdML8aA5LeBPYCR8qvWQYAS5sVstSmbzLCO
 GLOVN50r//3LGN1xFzn6D2KA6c1xRy5kk9YjiSsyU8aunpNtg5MkWoV8VLkRlPOLtKCl1ZkNwo2
 Kga+oho3WjEUXHcgps6c6yH/FCHt0w==
X-Proofpoint-GUID: h_RMEQiwF0G5xxomt-dAPk-nqsSo0OmI
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6909c093 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=R5xm6WvEqxduZyTZtAkA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: h_RMEQiwF0G5xxomt-dAPk-nqsSo0OmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040073



On 10/1/2025 1:24 AM, Alexey Klimov wrote:
> On Thu Sep 25, 2025 at 1:17 AM BST, Jingyi Wang wrote:
>> Add remoteproc PAS loader for ADSP, CDSP, MPSS and SoCCP with
>> its SMP2P and fastrpc nodes.
>>
>> Written with help from Kumari Pallavi(added fastrpc).
> 
> Co-developed-by tag then maybe?
> 
> Also I don't see this name in email addresses.
> 

Hi Alexey, 

We got review comments to merge dt changes in one patch, we are still discussing on
how to organize next version, I think we can add the Co-developed-by tag if remoteproc
is sent as a single patch in next version, "Written with" description will be used
to avoid SOB chain too long.

Thanks,
Jingyi

>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 484 ++++++++++++++++++++++++++++++++
>>  1 file changed, 484 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> index 08ab267bf9a7..c3b38fd851c5 100644
>> --- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
>> @@ -438,6 +438,121 @@ rmtfs_mem: rmtfs@d7c00000 {
>>  		};
>>  	};
> 
> [...]
> 
>> +		remoteproc_adsp: remoteproc@6800000 {
>> +			compatible = "qcom,kaanapali-adsp-pas", "qcom,sm8550-adsp-pas";
>> +			reg = <0x0 0x06800000 0x0 0x10000>;
>> +
>> +			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>,
>> +					      <&smp2p_adsp_in 7 IRQ_TYPE_EDGE_RISING>;
>> +			interrupt-names = "wdog",
>> +					  "fatal",
>> +					  "ready",
>> +					  "handover",
>> +					  "stop-ack",
>> +					  "shutdown-ack";
>> +
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
>> +			clock-names = "xo";
>> +
>> +			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
>> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
>> +
>> +			power-domains = <&rpmhpd RPMHPD_LCX>,
>> +					<&rpmhpd RPMHPD_LMX>;
>> +			power-domain-names = "lcx",
>> +					     "lmx";
>> +
>> +			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
>> +
>> +			qcom,qmp = <&aoss_qmp>;
>> +
>> +			qcom,smem-states = <&smp2p_adsp_out 0>;
>> +			qcom,smem-state-names = "stop";
>> +
>> +			status = "disabled";
>> +
>> +			remoteproc_adsp_glink: glink-edge {
>> +				interrupts-extended = <&ipcc IPCC_MPROC_LPASS
>> +							     IPCC_MPROC_SIGNAL_GLINK_QMP
>> +							     IRQ_TYPE_EDGE_RISING>;
>> +
>> +				mboxes = <&ipcc IPCC_MPROC_LPASS
>> +						IPCC_MPROC_SIGNAL_GLINK_QMP>;
>> +
>> +				qcom,remote-pid = <2>;
>> +
>> +				label = "lpass";
>> +
>> +				fastrpc {
>> +					compatible = "qcom,fastrpc";
>> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
>> +					label = "adsp";
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					compute-cb@3 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <3>;
>> +
>> +						iommus = <&apps_smmu 0x1003 0x80>,
>> +							 <&apps_smmu 0x1043 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@4 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <4>;
>> +
>> +						iommus = <&apps_smmu 0x1004 0x80>,
>> +							 <&apps_smmu 0x1044 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@5 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <5>;
>> +
>> +						iommus = <&apps_smmu 0x1005 0x80>,
>> +							 <&apps_smmu 0x1045 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@6 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <6>;
>> +
>> +						iommus = <&apps_smmu 0x1006 0x80>,
>> +							 <&apps_smmu 0x1046 0x20>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@7 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <7>;
>> +
>> +						iommus = <&apps_smmu 0x1007 0x40>,
>> +							 <&apps_smmu 0x1067 0x0>,
>> +							 <&apps_smmu 0x1087 0x0>;
>> +						dma-coherent;
>> +					};
>> +				};
>> +			};
>> +		};
> 
> Fastrpc nodes here. Was this tested? If yes, then how?
> Or was it just copied from somewhere from downstream?
> 
> The same questions basically go for cdsp fastrpc too.
> 

+Kumari, could you please comment on this?

> 
> [..]
> 
>> +				label = "cdsp";
>> +
>> +				fastrpc {
>> +					compatible = "qcom,fastrpc";
>> +					qcom,glink-channels = "fastrpcglink-apps-dsp";
>> +					label = "cdsp";
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>> +
>> +					compute-cb@1 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <1>;
>> +						iommus = <&apps_smmu 0x19c1 0x0>,
>> +							 <&apps_smmu 0x1961 0x0>,
>> +							 <&apps_smmu 0x0c21 0x0>,
>> +							 <&apps_smmu 0x0c01 0x40>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@2 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <2>;
>> +						iommus = <&apps_smmu 0x1962 0x0>,
>> +							 <&apps_smmu 0x0c02 0x20>,
>> +							 <&apps_smmu 0x0c42 0x0>,
>> +							 <&apps_smmu 0x19c2 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@3 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <3>;
>> +						iommus = <&apps_smmu 0x1963 0x0>,
>> +							 <&apps_smmu 0x0c23 0x0>,
>> +							 <&apps_smmu 0x0c03 0x40>,
>> +							 <&apps_smmu 0x19c3 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@4 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <4>;
>> +						iommus = <&apps_smmu 0x1964 0x0>,
>> +							 <&apps_smmu 0x0c44 0x0>,
>> +							 <&apps_smmu 0x0c04 0x20>,
>> +							 <&apps_smmu 0x19c4 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@5 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <5>;
>> +						iommus = <&apps_smmu 0x1965 0x0>,
>> +							 <&apps_smmu 0x0c45 0x0>,
>> +							 <&apps_smmu 0x0c05 0x20>,
>> +							 <&apps_smmu 0x19c5 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@6 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <6>;
>> +						iommus = <&apps_smmu 0x1966 0x0>,
>> +							 <&apps_smmu 0x0c06 0x20>,
>> +							 <&apps_smmu 0x0c46 0x0>,
>> +							 <&apps_smmu 0x19c6 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@7 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <7>;
>> +						iommus = <&apps_smmu 0x1967 0x0>,
>> +							 <&apps_smmu 0x0c27 0x0>,
>> +							 <&apps_smmu 0x0c07 0x40>,
>> +							 <&apps_smmu 0x19c7 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@8 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <8>;
>> +						iommus = <&apps_smmu 0x1968 0x0>,
>> +							 <&apps_smmu 0x0c08 0x20>,
>> +							 <&apps_smmu 0x0c48 0x0>,
>> +							 <&apps_smmu 0x19c8 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					/* note: secure cb9 in downstream */
>> +
>> +					compute-cb@12 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <12>;
>> +						iommus = <&apps_smmu 0x196c 0x0>,
>> +							 <&apps_smmu 0x0c2c 0x00>,
>> +							 <&apps_smmu 0x0c0c 0x40>,
>> +							 <&apps_smmu 0x19cc 0x0>;
>> +						dma-coherent;
>> +					};
>> +
>> +					compute-cb@13 {
>> +						compatible = "qcom,fastrpc-compute-cb";
>> +						reg = <13>;
>> +						iommus = <&apps_smmu 0x196d 0x0>,
>> +							 <&apps_smmu 0x0c0d 0x40>,
>> +							 <&apps_smmu 0x0c2e 0x0>,
>> +							 <&apps_smmu 0x0c2d 0x0>,
>> +							 <&apps_smmu 0x19cd 0x0>;
>> +						dma-coherent;
>> +					};
>> +				};
>> +			};
>> +		};
>> +
> 
> Best regards,
> Alexey
> 


