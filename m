Return-Path: <linux-kernel+bounces-845239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB67BC41F9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DCE3BE79B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C768B2F28E0;
	Wed,  8 Oct 2025 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JMdemdZa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE42F25F3
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914711; cv=none; b=Yv4OxiYvvqq1ZIJG2Iz8WYmJ30PhHlLP5+B+JEN7Cbr+hWs80XlMXY6qVlfRAd4AptE8uIemQ/ZKdZW6UK4McHOy5KlHM7+X5xVaMX0OqBDDy34lZtmCwZCdST4g2zCxLtwOBLkA+ZV/Q0tkF+Nxf5mSChq25oiUCyfdCNyH3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914711; c=relaxed/simple;
	bh=7tlsNYw7jry2YwQr503x8M7vYIit29lQJU9LWiYHdcA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4c4E7y33f8pspjj3oLvMRUOQkzR4DAdz8mWySpI0WQVlmV8YvXwq21VHT+1o8jCC6ka/TFYKqa5v9s0DQwYz5TJ0RASNTyg2J6tTbn0AQt+m9tbDOXvv+310CSB/OMux4YRkzloPrRZVQ+3egbGx3ztQrNmeFb0c49c8zg2sIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JMdemdZa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890aXs002267
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 09:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RzZHHkGJEfwd1Se8SA0pc+Db37+3AwYJluCV2KmgWEU=; b=JMdemdZaJUP+7wpa
	tW65ekjIBzNsC2rjj0t390yqI8Je2vQ/zKEpOu3tDrLVjRwewQYBVk6CKdutPXhD
	sDX6bRkzP4QOuIcamCuWFUUaLez5qNg07ionp0vpEjeMzbv81yNp1cFUQqouTYDB
	FhuhZAkG9POIvcKyvLsVGFPy6WKwyzpnp1X/ON+9BLC1aT1LybN0MPBu+c+s4tL/
	lwzE+e2MWuFiIiPt1G5thxNVYorjUAuk+Bz5SzgFcM1ztbtVaGRZMMGZQvZz/9uq
	NXXuDobjlkURwW+JhlE3xBD1yymCRRBBHgOwsQKCjvQlXfFdQKWV9OQB9/6ja1A7
	IbpZow==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxna7ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:11:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d6c3d10716so13443201cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759914707; x=1760519507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzZHHkGJEfwd1Se8SA0pc+Db37+3AwYJluCV2KmgWEU=;
        b=tji2HIdB0W69BymOBy6+TDuydLSdNejNX+rDD7OVQxB5y+gykl5li+3eW/PFZg7eGt
         TMfR6NIe2ZtMqXglTIquIjgyaqM6MTY0ddElgN3Y+OmStzWzkpQeyIUv0jogEtm7L4yx
         liZp2ISCFdwc4zs1OxcWgHFHNDwhxOJ3nEYHBs4IhPcUaWGKk9T8DvSKpcmeBJKrRLDO
         LNlTeJVuBkj1D6Uz0jkOa+NlaOXJKi4JHCRp9nGQMtdKIqVzSJuX96EncRxqcFZURwPv
         6ezAwvaVdF9Rl8VrAOr5ikUQ4yHLvp8ZtTslf3sIVuhI/AaRJPZ6+A+8WD14EzHqi1jw
         /I6A==
X-Forwarded-Encrypted: i=1; AJvYcCUb81Ay7u59viZyhEVXLDJeFnsq7wYQ26G4a+ttnT+6hsZWQBd2KqipPGj/MiDbcqxCgaNDEXgJ34wlkKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpmRTKiJDGYqM3EEMUfW2P8P1+wtfk6KkEE3JVcqTJYJg+ZTj8
	bbrKEliQRCdu6u+L6hN+7Rn8LPZdMcV4nJh11R3zyUGTzt3meQeTYb2XiLTHc7CJGvik8qtehhX
	f/sVI81dxeCfDH3EcR/J0g8bFUnuaYGP52sL+766rEuYXdXbXiyLyhtBM4f2f5Qc5gr8aJTP1lo
	s=
X-Gm-Gg: ASbGnctfAlHMtrUTpIJhSRf19OFPK9IudLvE7jL/P840JYmpCC4xvKVP1aPRlJ3oLJt
	gnZo7M9fN6cn0D8MjhfwSXWrsH7UxzNh/pJFtmnXCg51lVP4NETVaaNF/POVE1D+N/nuuPpz0k3
	SR2Hj8XRSHjL4Y5PBfIlvNBPQz8+NJMDO6Ck1OvcuzxQszRHI8JwUBPhXF2mdl4Ibr/3r7m3be2
	mt4Oue1W9Tq6qkeHeIJAZlUty1EF7DeKGzf5RC9ldP5QgBYhYZoKnKwJicJQvxpU7wSvrMSf6Qu
	ZWqh1Hxm0RA0IKfx8BPEoQzeiUZ6utNfVlgGROGpsAwerpNP5IOstkDngMi37rpPLeqyLromnF+
	fW6uuIQxWZOTt6N3D7qTB5ChkWGQ=
X-Received: by 2002:ac8:58d2:0:b0:4b6:2efe:2f73 with SMTP id d75a77b69052e-4e6eacd5b7cmr24322251cf.1.1759914707449;
        Wed, 08 Oct 2025 02:11:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgmdkC0LE3dHLfUFj4RWEGCX/zas7y0dJ6kj/ES5PA+uvEzb5Ga7Acz9kcOVJYjeSkLcG61w==
X-Received: by 2002:ac8:58d2:0:b0:4b6:2efe:2f73 with SMTP id d75a77b69052e-4e6eacd5b7cmr24321931cf.1.1759914707010;
        Wed, 08 Oct 2025 02:11:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6397c9355c3sm7862106a12.0.2025.10.08.02.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:11:46 -0700 (PDT)
Message-ID: <8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 11:11:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas
 <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
 <20250826-pakala-v3-2-721627bd5bb0@oss.qualcomm.com>
 <aN22lamy86iesAJj@hu-bjorande-lv.qualcomm.com>
 <4d586f0f-c336-4bf6-81cb-c7c7b07fb3c5@oss.qualcomm.com>
 <73e72e48-bc8e-4f92-b486-43a5f1f4afb0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <73e72e48-bc8e-4f92-b486-43a5f1f4afb0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX9Z7jQTnUOjOD
 EjCaPSTsXZmLWSupCunNEoTFG8vWtL2bODI4cjhJ/Hg6JrWpHLIVCflRFkQfoVBuJURVsJIzF3n
 qDyuJrc0BRLGcLSjWZC8y1IXjXSlcmZSP4ZHFuz8fvGQ3fWB2PM9NGt6jERTP6ElHpBXgkZOrHl
 panXR+cIG8lwD28DQlgHYl2If5wtXaScf0TmRTcAeMGP6llLmsJa+qTfgJ+2hPU0enOnwKZeALp
 iULScC2F4PV6qnxH/jqowWUqwQ3jvcblPP6M0/OKf7pgIUiPmAaDPi9OqGQLW75QLXZ2mDRssg4
 9NLq17R9FueBt6GXuIdMPHzMw52+eq7i2PFc57ATkXGQVVLWAEwK7RaDCswiDyag3K446cU8dLV
 bhPp0A0TkDVfndMj62ojrxJIelapRQ==
X-Proofpoint-GUID: mWsjfRiQN-iV2dYB6ZYS1oUJXSIvw9DL
X-Proofpoint-ORIG-GUID: mWsjfRiQN-iV2dYB6ZYS1oUJXSIvw9DL
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e62ad4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lX_GYFQQ6rhPkfvadcQA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 10/8/25 10:00 AM, Konrad Dybcio wrote:
> On 10/8/25 6:41 AM, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 10/2/2025 5:07 AM, Bjorn Andersson wrote:
>>> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
>>>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
>>>> and x2 lane.
>>>>
>>>
>>> I tried to boot the upstream kernel (next-20250925 defconfig) on my
>>> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
>>> is crashing during boot as PCIe is being probed.
>>>
>>> Is this a known problem? Is there any workaround/changes in flight that
>>> I'm missing?
>>>
>> Hi Bjorn,
>>
>> we need this fix for the PCIe to work properly. Please try it once.
>> https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com/
> 
> This surely shouldn't cause/fix any issues, no?

Apparently this is a real fix, because sm8750.dtsi defines the PCIe
PHY under a port node, while the MTP DT assigns perst-gpios to the RC
node, which the legacy binding ("everything under the RC node") parsing
code can't cope with (please mention that in the commit message, Krishna)

And I couldn't come up with a way to describe "either both are required
if any is present under the RC node or none are allowed" in yaml

Konrad

