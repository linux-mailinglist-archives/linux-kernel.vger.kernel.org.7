Return-Path: <linux-kernel+bounces-869852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E790C08DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEE51C21EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D755C7262D;
	Sat, 25 Oct 2025 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPj9xKuh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23871EBA1E
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761380173; cv=none; b=LBljRZMyOC7nT4vCPjDTIgkTzpA/SxOPdXSVdgtn7OWLX3UQqpQ8pTJMXUvHgWKDKrifzF1JpbbxRisWvVqZSWQB7StFmsLTFp9NcnCCmionRWUiYliPpi62wgJ0mJCfR1ugDYGHyhyTihi5Nkjch40HBbyE1b0nD/qk3Ayziq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761380173; c=relaxed/simple;
	bh=IxC5YX7J+SgXtCh2T+p1tfMOQwdzT+eDHjVVpy/jUlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O82QaIdr5HBgYfU7Si8Z/TK0P0gTTnNX3fui53NMcEkZcgWXbbo7HY2al0GKsTXCffmmCp/4GrqPId7Fa1OmtUTcZh6Kvpd0oFR/DguQbSbXu+RHfg/08IZAD/zLJT7BuR47ihdPERgYjpzBRlisKkEVDsKEknFvQt2jfbNv+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPj9xKuh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59P4Bgj0262976
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gyFb+xRxtZhFQMvSVeO7HCcANmL/wXCaDrxCWExaGRI=; b=IPj9xKuhr2H3JD6r
	KDA8wlUEB/efKAnyYdw61oMSSm5+x5VSnJUjP15eqblS3Owh7ULnK/0YqHmwzenQ
	Y6wGMsKVFnXn4ByQQjLEFSWKrz+ZIqjoWzAO+98xBGrZL4vWOe330YOo13dsbdAu
	sK8oRmpquKPu2q7uV35BAbSWDih7uPZlSuDltCrwfXRp9R24vnvGy4dXcJJceRQ2
	FpEhvZYWCM+eryTSu/oC9zjm0+h/9/3To5ZtnVI+eSMT1Tf55nhzE0NoIBzvNo2X
	6lMxllX3ivknjkn3WKrpl2vH1ZSim6m4spw4L/u4sMBGcUsJOoiw7mS2cn4Hr9fm
	kQkKXg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0qad88r9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:16:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso6181490a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 01:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761380168; x=1761984968;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gyFb+xRxtZhFQMvSVeO7HCcANmL/wXCaDrxCWExaGRI=;
        b=GlGiuna9zdqfyNaxZv/3CWKgdTP5MLoDJQeXAXGTzF67K4k78vwPhfyY7Ptp5kOjjD
         OisbMurlrqX6i/ob2vjVCgcKF3gW96ADcVAoZsfK13V8tNFT566drfFPNcnqrXd9bw4g
         Gt49jtCH4vUjGncn7LXyZgZlmTaqECHpGRyi+EFBpdqukV7JQta7R7sh7flnqVeTi2U6
         ldvcQipuSOy3L73VYisrznFnrafK8EQ3Huq7dPbrjaG8zrj2WT2mMJKRXTey20Ijwbbj
         NCBwqGpizYnLMOwOj8895z4/g42EI/wc0DdTLCidJbpGQsxFuprEQrsrmHv2A63VNJrH
         +yBg==
X-Forwarded-Encrypted: i=1; AJvYcCUDvvAmgq3YEpicoKk8ARQYb9gyMQswebBnVxHkTAdWE36Q4z8M+7tx0HAXPwS/2WKmKhHpg0wL2Kalzyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIOhAaKsJf/ricOyDD3oevaL9XwDZrCaXQvYH3hHbcyWxrI8E0
	hBakbVnhYPIHRZXVpp1YX+2qOBefZo4OOT1tmCQl/9SnCNTbekuXsJcsGl2+lpGfwel5issZJSM
	NOClohKPtY6qAeFXQcbDe0eTG1wOAgGGYJu4PZRmJl4SQ9C0VHnWLHk6TE6qW8ymcn30=
X-Gm-Gg: ASbGncubb/JUICxrEIr2aNStTKiIlOnR6TgPNoXzbJDgytXANgdb8VooFOtiOF1Pn7s
	YJ07I7EtE74ugqzxa3cxEEfjTDP/3CBAZaJU8Jz/TLi0/ZfPFvjaYRPGHzO87AiiMtXjiPAaGXE
	Xyjwwzl5RCCh8GrfqIK8KVVY8wZGVEl101CvOw/9TbKPS1E7RBL3AE+Wwi5k4PrjfP0WAvjjwdw
	1e6yQQePMbuwvDcmRL1eROvvVn28YxYxBlennGHhnWaLvIYVHf1c1x+yhEXVPztCDJ1CjFpaV80
	/lPWNR5KophNMfOJdH/+REoPI6f8hYkPp4qucgpofZJCKPjiXC8ghcLIYJHz6BjQJb8mf9YsBL+
	bXSyGVlycLmBgcI51YDvQQ8oLw7TroNbzYw==
X-Received: by 2002:a17:90a:e70f:b0:32e:3837:284f with SMTP id 98e67ed59e1d1-33bcf8e312bmr40739882a91.21.1761380168334;
        Sat, 25 Oct 2025 01:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQK6A80+DTKcXQdWtaZG4mXuVOm3Ek50bolbfrhY+96Ndyrab4VH1N693+DBIK/SMJMPQuag==
X-Received: by 2002:a17:90a:e70f:b0:32e:3837:284f with SMTP id 98e67ed59e1d1-33bcf8e312bmr40739862a91.21.1761380167884;
        Sat, 25 Oct 2025 01:16:07 -0700 (PDT)
Received: from [192.168.1.3] ([223.184.28.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed830b5bsm1500586a91.21.2025.10.25.01.16.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 01:16:07 -0700 (PDT)
Message-ID: <828cbef4-6b4b-413e-9f76-d61d35771192@oss.qualcomm.com>
Date: Sat, 25 Oct 2025 13:46:01 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin
 state
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com>
 <20251024181832.2744502-3-krishna.kurapati@oss.qualcomm.com>
 <TY3PR01MB113464EA259DDA069E7453DF986FEA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <krishna.kurapati@oss.qualcomm.com>
In-Reply-To: <TY3PR01MB113464EA259DDA069E7453DF986FEA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lOZKAJPF3HS-HIJNoC1RKGswf98kD5hH
X-Authority-Analysis: v=2.4 cv=TcObdBQh c=1 sm=1 tr=0 ts=68fc8748 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=gjDjTnFoRXNpaGG0BYvefw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8
 a=yC-0_ovQAAAA:8 a=QOQcQmI8CtnSw2ojkTwA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: lOZKAJPF3HS-HIJNoC1RKGswf98kD5hH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDA3MyBTYWx0ZWRfX3luf36LZcCTT
 cmKvGElxo278Cnly6/ZGH3eKJiDwZZ8zJqzZY5poohNLjtIRPleGXB/yhmXKSSKy2oegB1jmCsD
 uv9bUXHFL8HsppOL6mrDgb2HzdKWVlISds1/oGg3k8ptEQFyTrd0s+oYrRXt8zb+ohBkk2Fb7tg
 Y5aci/Qb4Z/LaA8XwDAWCr+yxWRwcydPRARZSELUaMHmCMx084NPHGdn3eJ19qoYPtHKadI/70t
 agDH7yA2BfeJ2QscWR6IQJnhpvIjZkEDieXfuUX4yLFZ93YR9PbfNZLMrl5Qwc6ZudQqqrWwa93
 1YAeGwU2t37ZLRuqSTYQGFdhcPaSmbTtTXlyJD45pzXwhRLB5nqB16wPVdEe3yDYSNgmlK6lCm+
 BcO2mjEe3YFB18SyLsk89UK+BoTkSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510250073



On 10/25/2025 12:31 PM, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> Sent: 24 October 2025 19:19
>> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Rob Herring <robh@kernel.org>; Krzysztof
>> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Heikki Krogerus
>> <heikki.krogerus@linux.intel.com>; Biju Das <biju.das.jz@bp.renesas.com>; Dmitry Baryshkov
>> <dmitry.baryshkov@oss.qualcomm.com>
>> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Krishna
>> Kurapati <krishna.kurapati@oss.qualcomm.com>
>> Subject: [PATCH v3 2/2] usb: typec: hd3ss3220: Enable VBUS based on ID pin state
>>
>> There is a ID pin present on HD3SS3220 controller that can be routed to SoC. As per the datasheet:
>>
>> "Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is
>> at VSafe0V, the HD3SS3220 will assert ID pin low. This is done to enforce Type-C requirement that VBUS
>> must be at VSafe0V before re-enabling VBUS"
>>
>> Add support to read the ID pin state and enable VBUS accordingly.
>>
>> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
>> ---
>>   drivers/usb/typec/hd3ss3220.c | 101 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 101 insertions(+)
>>

[...]

>> +static int hd3ss3220_get_vbus_supply(struct hd3ss3220 *hd3ss3220) {
>> +	struct device_node *hd3ss3220_node = hd3ss3220->dev->of_node;
>> +	const char *compat_string;
>> +	struct device_node *np;
>> +	int num_ports = 0;
>> +	int ret = 0;
>> +	int i = 0;
>> +
>> +	num_ports = of_graph_get_port_count(hd3ss3220_node);
>> +
>> +	for (i = 0; i < num_ports; i++) {
>> +		np = of_graph_get_remote_node(hd3ss3220_node, i, 0);
>> +		if (!np) {
>> +			dev_err(hd3ss3220->dev, "failed to get device node");
>> +			ret = -ENODEV;
>> +			goto done;
>> +		}
>> +
>> +		ret = of_property_read_string(np, "compatible", &compat_string);
>> +		if (ret) {
>> +			of_node_put(np);
>> +			dev_err(hd3ss3220->dev, "failed to get compatible string");
>> +			ret = -ENODEV;
>> +			goto done;
>> +		}
>> +
>> +		if (strcmp(compat_string, "usb-c-connector") == 0) {
>> +			hd3ss3220->vbus = of_regulator_get(hd3ss3220->dev, np, "vbus");
>> +			if (PTR_ERR(hd3ss3220->vbus) == -ENODEV)
>> +				hd3ss3220->vbus = NULL;
>> +
>> +			if (IS_ERR(hd3ss3220->vbus))
>> +				ret = -ENODEV;
>> +		}
>> +
>> +		of_node_put(np);
>> +	}
>> +
>> +done:
>> +	return ret;
>> +}
>> +
>>   static int hd3ss3220_probe(struct i2c_client *client)  {
>>   	struct typec_capability typec_cap = { }; @@ -354,6 +427,34 @@ static int hd3ss3220_probe(struct
>> i2c_client *client)
>>   		hd3ss3220->role_sw = usb_role_switch_get(hd3ss3220->dev);
>>   	}
>>
>> +	hd3ss3220->id_gpiod = devm_gpiod_get_optional(hd3ss3220->dev, "id", GPIOD_IN);
>> +	if (IS_ERR(hd3ss3220->id_gpiod))
>> +		return PTR_ERR(hd3ss3220->id_gpiod);
>> +
>> +	if (hd3ss3220->id_gpiod) {
>> +		hd3ss3220->id_irq = gpiod_to_irq(hd3ss3220->id_gpiod);
>> +		if (hd3ss3220->id_irq < 0) {
>> +			dev_err(hd3ss3220->dev, "failed to get ID IRQ\n");
>> +			return hd3ss3220->id_irq;
>> +		}
>> +
>> +		ret = devm_request_threaded_irq(hd3ss3220->dev,
>> +						hd3ss3220->id_irq, NULL,
>> +						hd3ss3220_id_isr,
>> +						IRQF_TRIGGER_RISING |
>> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +						dev_name(hd3ss3220->dev), hd3ss3220);
>> +		if (ret < 0) {
>> +			dev_err(hd3ss3220->dev, "failed to get id irq\n");
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = hd3ss3220_get_vbus_supply(hd3ss3220);
>> +	if (ret)
>> +		return dev_err_probe(hd3ss3220->dev,
>> +				     PTR_ERR(hd3ss3220->vbus), "failed to get vbus\n");
> 
> Does this code backward compatible? There is no vbus definition here [1]
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts?h=next-20251024#n208
> 

Hi Biju,

  Yes. If there is no vbus supply in the usb-c-connector node, we just 
mark it as NULL. The ret value would be zero if there is no vbus.

Regards,
Krishna,

