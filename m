Return-Path: <linux-kernel+bounces-780918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C701B30AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21A31C27F04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9261B4236;
	Fri, 22 Aug 2025 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gvMD08bF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5564A2D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827622; cv=none; b=WWvj6wQAGgtH8BysfWglp1yccRyYP5BBRdq4tgmFCWrtfKsGeZCKxmz9tFdfYbeWz79mIVQMXbPBQlT4lUE60TuauVy0Qdmmt6+uzTWH4jEj6GI0KdiD2+1awtcoi+5PgpI36gyOKm1ubexWa/93fJ9PqNNmjCzyJbNm9E7gYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827622; c=relaxed/simple;
	bh=lcRbF4s/PQ23VSgcKM0p1j1KRQGCkTB/i7Aw1lz8Rf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4k1ZKVRy6THrfkK/1PCsBwBBQ/ghh3OZCxBBjChisprHZh23ehVvisaUlUMb1ZLgLAvOvlu/p0kEhZeAyYCMjOnN+39rBr9/dyqxQr789KGefrZFOxbh9RHMkfciV6gJjLFC7mfimIsArssjW8YdSodcptRBIgeubr7eBMcGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gvMD08bF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI92NP003002
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fQ6jAh+MsWJrW0ys+uDSW5pSsMHNRIQOD8QB3d9ba7w=; b=gvMD08bFuD3rSToW
	SecdwBe6Lj5LswT69wQ/2Tf715JQYvBfIZncY3lXN3AVpABeqNlCmW0mMIrc2/ue
	8EMe+e0Zw+uGiSXhwNl0cEeV/uayB1EfB/kzaXMQoJFqLWiwoRtxeJ32nyPYnlye
	9D1HD4kpSRFh7nRVI/tpk3u3HY6RLPMtaP4SXFuyPaOpoACFeq18GxVD1/jtQPSX
	byYb84Dqsjn9FIEXITDzjxbfFvvj/HhyyZl41ihq6nRVFjyRUrfQtHHlOESst1oB
	2QPZBSZkp4KUNmmFQJtwTQ8YwYRexFbwRhS/cCYKAl1/ZuY5bUl6DbIhi95mBg3o
	VwAUmw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5297efa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:53:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32515e8e4b3so425677a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755827618; x=1756432418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fQ6jAh+MsWJrW0ys+uDSW5pSsMHNRIQOD8QB3d9ba7w=;
        b=KJXCrCKWckval1tP5/oRnRUx8rz4uaHQU8l1ge+i0hymD/64KJ6+s5H+PNRK5rHLYY
         BIRJlFo8RTGalL+X8nbKWQ307AAsw5YLvxEqKcl1w/8AisjZLCyOH/OUD4x8P3p+MDLv
         6Qz3eQBfnc/F7kcv50cWcRamPiE0IFXCqzRlwN3ld8OyLJUEQBMrNwJ56nCMRr5jkGOE
         FT5BFi/q5oviKeD/j3rwH1cT/MAdutBfGCpjxuNlH3HHFk5yuO3sCFr+cDvV+p5490+U
         I+qfYneKaQMAc1VI1SxI1lnK6paDH5pe0osG/+v+6qvyzZDswr4Tsem/Y2ckDmhZTjGE
         HA1g==
X-Forwarded-Encrypted: i=1; AJvYcCX/7Jw9LUSS7F4w9x69JCiRJuPSjew3Mx8YopMTkcUkEZofdRQ8h9BX/wllBqeMcx0alWNdT4AC0ahOpCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAqWiNdDCYs3X5E3yLWPU9CJ8oUq2rHADtexzxk0sNUPWhA3f
	/mP4qZOYHoNwedg4JXyWFW73RHhC5gOX6wp49ffpKYxLLpWh1x0PYzQFmgGg/kjPNApk4jtwmUY
	Q5DA4PQ2A9tbK6yhunl50LfDdKdThYcHH6mDe/2nwVAlpmjlG6iSLS2ZjAkt9OHUbnE8=
X-Gm-Gg: ASbGnctgSmx/i1Y5q4n6rSAeLgcbv5LHpw4lUglUOa6j0d7Gfzp3MEgGOdPDOIbG7pJ
	XB52qpDdhh7v06xq/u/eeKAjxtWycmcBpXxIOR9zjNQOprK9FRUCXjVKVCnPVdB3nv92lxUhFZR
	yuXEPs3FxkSUqYXcQU3S3W+xxV9vXwOohDT7xbgRgdXDACuqdERfyQMu459MpE42a3eeqHVGRAK
	O4yPuW6U4bUPFKaQgJ7WTNMmESAdC9oXTpFuUzDqePcnoYSeEllSdPYYga7j1NQJ519q6fsPhDV
	JrJRBvxqGzMY202m5fScEtyvb8HQu09snf7UWAbgLnea+U3/42u5U7P5vo3yaLhXc0ipK3nU0Oz
	Ft4pO9wJXGOV6s/4Mr5h7lzOl+555yA==
X-Received: by 2002:a17:90b:2ec7:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-32517b2f78dmr2092817a91.26.1755827617887;
        Thu, 21 Aug 2025 18:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9I9vJOh+MwLycDuGMJzFuq4TmcBJ+szXaNAIctyyZVVpI/P68vxK3Jv34spYw+h3HbRLGtw==
X-Received: by 2002:a17:90b:2ec7:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-32517b2f78dmr2092783a91.26.1755827617441;
        Thu, 21 Aug 2025 18:53:37 -0700 (PDT)
Received: from [10.249.96.170] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325129aa68fsm1012282a91.7.2025.08.21.18.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 18:53:37 -0700 (PDT)
Message-ID: <74bbf915-23cf-46c3-b9f8-48bb43ce9c56@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 09:53:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] phy: qcom: qmp-pcie: Add support for Glymur PCIe
 Gen5x4 PHY
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
 <20250821-glymur_pcie5-v2-4-cd516784ef20@oss.qualcomm.com>
 <bm3cp2vyw4rpllkwoxoxwrvsjxrtolcroqwx76bkpwmcdvx7ag@b6hvybyouq7m>
Content-Language: en-US
From: "Wenbin Yao (Consultant)" <wenbin.yao@oss.qualcomm.com>
In-Reply-To: <bm3cp2vyw4rpllkwoxoxwrvsjxrtolcroqwx76bkpwmcdvx7ag@b6hvybyouq7m>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yALpv4o-JdAjbJLGvOof3fn8A6DrtmCc
X-Proofpoint-ORIG-GUID: yALpv4o-JdAjbJLGvOof3fn8A6DrtmCc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1zO9lZbY4HEw
 dE47OZZ1uG3LBAGMiRzBXPbBfm+zSiOmVheVYF9cmkje1OgHSbboGQTeM34zSx2NOJD1YjPKpZu
 43gj8ku9Ce7G/8qmC9uWA4OTPi6sRLvBcnsLassJDfcmQduaLcURqhpHu0LptCGaf5W1m0b9JPR
 uVew3QWZlyq3MUKl5ttmr56lWhwjgIg0WPrWr0+/M0shy6/hUgSbCFCnicZCGxJ5rZ7tGD1nZXx
 6TZJeHM/Of9KwbwahgVuSoeuJiNu8oehvlWoZTaJzxeAzS2mscTVdWR7hu53N3lT0BRezTzu5sw
 cYzA8B5Hq7QQ/nIh47S20r+0NqwLVcY1C3TjQGjhZY1m/Rr8ujni+7hgJosPMvDo1w3NIfjXZQR
 6gyd4A5WT2Xi3WEZcSBe9OTS9uEHxA==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a7cda2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=AsWi3nSQ2um4y-UoW74A:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 8/21/2025 5:57 PM, Dmitry Baryshkov wrote:
> On Thu, Aug 21, 2025 at 02:44:31AM -0700, Wenbin Yao wrote:
>> From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>>
>> Add support for Gen5 x4 PCIe QMP PHY found on Glymur platform.
>>
>> Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
>> Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>> @@ -5114,6 +5143,9 @@ static const struct of_device_id qmp_pcie_of_match_table[] = {
>>   	}, {
>>   		.compatible = "qcom,x1p42100-qmp-gen4x4-pcie-phy",
>>   		.data = &qmp_v6_gen4x4_pciephy_cfg,
>> +	}, {
>> +		.compatible = "qcom,glymur-qmp-gen5x4-pcie-phy",
>> +		.data = &glymur_qmp_gen5x4_pciephy_cfg,
> Please keep the array sorted. LGTM otherwise.

OK, will fix it.

>
>>   	},
>>   	{ },
>>   };
>>
>> -- 
>> 2.34.1
>>
-- 
With best wishes
Wenbin


