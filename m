Return-Path: <linux-kernel+bounces-846461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB9BC810C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 10:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCC5C4EAA0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 08:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A22C027C;
	Thu,  9 Oct 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lmfj4wba"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270727B327
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759998960; cv=none; b=BVmbUjHsocoFlQ1k8KV8EVxnBl9AeLC+clHZ/6Gbeb8gh/YMxDsCm8Que1omzsPU38LVuh8hBiSeorri4FhonhzdAp+3xqRLmwUfLMlNbZeKEfiCjTMBQs0ubwvLdZRM84EvvT8L7vqEyNNToP5qd1I2nkJNpum2LmiyXyG7afA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759998960; c=relaxed/simple;
	bh=7SWnQZGkOgz7eDNwlU+qvn3WuBJRX72GuIMwJ21d7Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od6ZMF0rLr3Hae9oj2PpQTsWUquZVy5ymOZobuP8hNttJrRhQBIWV0d75aOIme6OJHbekzLJC+oEhE6aso66WqdDC1jPUZ0XQp/onc/iaKpB5/rRCKHF6K0qfyQcRMQYV+q9l1Zlx7lmOuKqeiLmNPdof7SxXmIh7ShtpESNt6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lmfj4wba; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EQLN029793
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 08:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hu/pRTCJV3pDmrBwILASxYyavlvjaPNiTFHY9r2ayxs=; b=lmfj4wbabWDD13c6
	JeVHr+pPCPe7kDK9Y1i8X1lQ2nCVMO8lTSxi5q0/7SVBB1xnzPSfyk0o9CdVTVSi
	dMqevlhBiPJR7OiUkwAMbtnn5eLCmrsOzjk8QLV6GKiZWDO9ykfb7BA1atP/fZzN
	pkGg+sQyzvjcG1qRxrEaRzUdkgKoPxaPUjPGq1o4VC/v8ooGB56K5URUllq2Vp/h
	FrrOfnjOgsxskL2nu3FWXMqf2qeqNkUQugSC2nirWS7yCZExFcVKpr5gl6XnTRvV
	AkyZkJjhSxeHarMBiqY5+AJdvPre1Gq2u8ZXBFE9wSMuwCjovPJebEkcRR5Y0Y32
	5Nk02Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4na2ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:35:58 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-826b30ed087so2347686d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 01:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759998957; x=1760603757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hu/pRTCJV3pDmrBwILASxYyavlvjaPNiTFHY9r2ayxs=;
        b=LqMgKcnhnLPmHE+/Y2ot4s9e/q0dHK7ySuPVAdfkHVjT/+t0UyCW8hbKXsok2kWjon
         vbtsYFskbH21y8TjhBYiXKtE1nnGvwmqBuei4jxDc5vjPwkeAa9Z65W2JG3hO5khOeFI
         Jakn2t+HXRCLGR17oRu0tdpXOqH2ZqvDkGehVjzcTqUyt3rEbNFwKk8A87x9p1vEmIk9
         8mPyMBBLHowAc8VHZmJkvKd5aJ5EZsNF/p0K3GZS7v0fw9F/H2S1CZB0VBgWx0ZQCZ8G
         Zq715slYmEvegYAWfEQXEYp+N5n5uJdkTYD0ujyOAxSSXtWZ/pMItdMfKt11r2Rx6FRb
         8XEQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZulAq8y8XXA4u3a0oxHzmDuF6hmqMUbq28yzEDEFPFqwsJ9brViZXJL+8t792uJye2F1mFhPCw4ZbMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysEuTvGo+OYVxN5qjqTgVYdbxDGqTEfRZ9UfXPEj+q6xOmwRP+
	JLqwIONZp5/oUbS+I/YpgC6E1eMS5j9fpLVWQGNsXduayGXP3/lORRLVSefVfmWoQY2gV7KStlK
	Rc+UNLDMNF8/YMpOL/y5eCKb8fQqNRsnOC2P2cuMc9BIYgjjfGZx5rnDv+fI05727k/w=
X-Gm-Gg: ASbGncv91lAYFqqa4VcNhepKaJ4acyaxrHFJcRiWqF1YMht7CgqKa5WlyozEWQ0MsZb
	oP6iuXCe39yudZQFbsCuRNcW+oLC4c8EJGN+VDbru8f6H8w8mI6x4+IR/9h4qWueM1SZPehh+pK
	ueEDqhuKOXqMuyYFM+5JFAZ/91HbColP4pIKlSb39gIhJxtz6ouSQiO7JBlbeDM2OAlDxghT5Nj
	A6up8Rcp/b6G06YdnsLf7IBS6CvS1c0FpDxpTTkFrhb8XhJV3nrKmavy9q42PSjMcXyGDYCH0xU
	g3cCV54GdpzFrLiIW3j21WeA0f4FsuXEixf//CvLdXEH3rHOyPDpaSoSPhPxjbxkO4KPzsH5+7z
	h+hPQKTzYsPfiHflmTXyZ+YtyiQc=
X-Received: by 2002:a05:622a:51:b0:4dd:2916:7983 with SMTP id d75a77b69052e-4e6eac949e9mr63918051cf.2.1759998956716;
        Thu, 09 Oct 2025 01:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgYQkiD0jOWnmXizRtOekJynoqnzXlVrb6i9wWQzty768o4CoBlYGKZEKsuxy0gFmxG00SRw==
X-Received: by 2002:a05:622a:51:b0:4dd:2916:7983 with SMTP id d75a77b69052e-4e6eac949e9mr63917901cf.2.1759998956230;
        Thu, 09 Oct 2025 01:35:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9bd7sm1875117966b.3.2025.10.09.01.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 01:35:55 -0700 (PDT)
Message-ID: <b5538a86-c166-4f20-9c3a-8170d3596660@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 10:35:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8750: Add PCIe PHY and
 controller node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
 <8f2e0631-6c59-4298-b36e-060708970ced@oss.qualcomm.com>
 <qref5ooh6pl2sznf7iifrbric7hsap63ffbytkizdyrzt6mtqz@q5r27ho2sbq3>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <qref5ooh6pl2sznf7iifrbric7hsap63ffbytkizdyrzt6mtqz@q5r27ho2sbq3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZJzaWH7b c=1 sm=1 tr=0 ts=68e773ee cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Nv7edSWLeOU3OsZLW8MA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: 2L1eJXWpyHlSuUlTL7QU_5UIr4YJSEas
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX3ZMaFoRLRJHa
 AzEua89dzrkmTf6kXsJ9hnyNTYKBvP0z4E2gn1fg84Sizc2Kc3F3fHx2UKXS/25TmtOunlDfcdA
 FX0G0RJk7xdCtEP8UFjAqWIuiB6xSzdC/E2eu1XUrDNHawLadmjD8/bCK9zJQTYN8iCkncbYQOy
 qpNze3+IO5i6Ylkk8miOPv+LviAMhRuttc38AKqCc4tdbq9qQ5/ptY/6Y/1j5pbQ6LV7HfGOgTx
 EJQmniZgozf0KDi+uvcWft0w85u60AGg7/TQVOoeGKVXk2CqFhsvF+Eoprjhjf+qg2lG6EdEZaL
 czAVZW0CNicz55qKudPs5tKhSGqTh/yvz9qpzP0EsFWzk/zmnhIskAbZBwvaS2sSRPxSxZvuYhK
 DajqIwAfkX+FcgOf5pRfRGmNUu2sbQ==
X-Proofpoint-GUID: 2L1eJXWpyHlSuUlTL7QU_5UIr4YJSEas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

On 10/8/25 9:08 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 08, 2025 at 11:11:43AM +0200, Konrad Dybcio wrote:
>> On 10/8/25 10:00 AM, Konrad Dybcio wrote:
>>> On 10/8/25 6:41 AM, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 10/2/2025 5:07 AM, Bjorn Andersson wrote:
>>>>> On Tue, Aug 26, 2025 at 04:32:54PM +0530, Krishna Chaitanya Chundru wrote:
>>>>>> Add PCIe controller and PHY nodes which supports data rates of 8GT/s
>>>>>> and x2 lane.
>>>>>>
>>>>>
>>>>> I tried to boot the upstream kernel (next-20250925 defconfig) on my
>>>>> Pakala MTP with latest LA1.0 META and unless I disable &pcie0 the device
>>>>> is crashing during boot as PCIe is being probed.
>>>>>
>>>>> Is this a known problem? Is there any workaround/changes in flight that
>>>>> I'm missing?
>>>>>
>>>> Hi Bjorn,
>>>>
>>>> we need this fix for the PCIe to work properly. Please try it once.
>>>> https://lore.kernel.org/all/20251008-sm8750-v1-1-daeadfcae980@oss.qualcomm.com/
>>>
>>> This surely shouldn't cause/fix any issues, no?
>>
>> Apparently this is a real fix, because sm8750.dtsi defines the PCIe
>> PHY under a port node, while the MTP DT assigns perst-gpios to the RC
>> node, which the legacy binding ("everything under the RC node") parsing
>> code can't cope with (please mention that in the commit message, Krishna)
>>
>> And I couldn't come up with a way to describe "either both are required
>> if any is present under the RC node or none are allowed" in yaml
> 
> What about:
> 
> oneOf:
>   - required:
>      - foo
>      - bar
>   - properties:
>      foo: false
>      bar: false

Oh yeah, this works.. would you mind submitting a patch like this, with a

# These properties must either both be under the RC node or both under the port node

or so?

Konrad> 

