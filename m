Return-Path: <linux-kernel+bounces-764451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CBB2233A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8293BCCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3192E92A3;
	Tue, 12 Aug 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Llb51V61"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8F02E8E1D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990844; cv=none; b=najY1D8Ulp8BCPi8TXnZBFqPyoAUqkUAGrS/JBxsWkK5W/wFa06aHfcYv5qnzqJy3MI809nJvZck2bFmVRvK65sEec/rr0h8JT8k00sdlNguEdRZP8e7HERPWNET97IBsbWfCrJ6sSC6wUU/RcFAUi3/qBJnfrF3AzBJgJuHGoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990844; c=relaxed/simple;
	bh=c9w5DaCwevdS8Zl6bzjQ1GF90LNgwle0F+O5Q9ZhWPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IduM6/OA1+O0mrZ6zVjDyUzF7sqFSaQCV+t2yPILOalZHIal3z0TP5iXWBSa0aRrBWedzuX6u+Rd4pCQo103Uwxe3K950RuT486GJiL7EkXoUKPTp0dqNIJOU2ytkZj7Ry9xakAntg5/yQvmu2/ib0KVIKyZ5sBbC4Pk1XqrOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Llb51V61; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5l8YY024489
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x1XZQXAHzUdSPrv2me7BRJkLC13h5rEiUYCH9W9cUAY=; b=Llb51V61WCalqt3U
	csS5zlgRdsQaP9rirsXjehj9wFrRWoIpzwoN3a/ZvbQW6GSOFCKjVihIPpyiLtvi
	6ZvbckxLxMKjQliSiJ5d3aWZd/ToSK0xFP7AHWe2q5D5k5ltLLIEOyPyMIXtEcY8
	fF8Tkw12wXduLk07blc+IsIOn7Yf8XNNYMmPkxfVbBN8fIR4FH++rtxie/14+M8q
	cM2J/wm2q+gUKlWjcss4eTuc6D7iq9ukljkMQeLGpkLYLAj9jl176Z+z48HFvego
	XiIVlxp/hdhgqgcOoR0AzSl6mbmx5ixHr1ImmmGtd7N6Zt4OWa5CcbrCFZwE+wEY
	Ldg+Bw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4bk8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:27:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-707778f7829so8949616d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990841; x=1755595641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1XZQXAHzUdSPrv2me7BRJkLC13h5rEiUYCH9W9cUAY=;
        b=kYEOuqobv90zLq0DrmnDezLk78R/l/T9olY6jhpv6QR65Taq2QX2vDZvr5TRXi9DHr
         3DwUtkU0L1TTlgiHjocFjFZ9Ae769dWKb/5bXZkneN1iPJRKBDxHvCCWTiaM7weoBKc4
         zOZQKLrkrM8kN2Av/jE6eHOhZWEquXfaGlhpbbXliCI6jXzKodCjNF07WvfOcP4epbbX
         ogFISOiQVu719/7BrChaZkr9+q1FHWYGbsxoxaLieuJd6JFSwBlGFqfXoL4EpUmzSsQK
         tdQeMJB4IYSpxGRHxV68BROeN4NOS0ElFsPz6ZfwXsyo6zPanwGIrHDhIryLJIdmCJ0K
         QTLA==
X-Forwarded-Encrypted: i=1; AJvYcCXht0/vwIy2vgliQ0by3mUhNPuSauWbZ5aTVZguwzFLBc/EnrvHh5tyTcSjjyeSboqjkaEG+QXNzBEph/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp7SNn4wY2/lnPISYRHml3V130eEZjAgOmI2RRcXmoq8d4EZI9
	Uvuw4mzyfu8hzSLqFNqyLXmpAUedBaHC3mAK+AXnVETVv3cvQ4qLHEMYWL6oh9N+dLBLFybdy3g
	8BXpzqMybL7VeMYls5Gb3pEDncpcgsMg3WvKbWPh5LWozX9yfHxsRuhGcmvvvaS4+tUY=
X-Gm-Gg: ASbGncsPIRFQwj5ERkBRoaIj5OHWXFOIJA1cO57vXLD1x7biVdvNXsiLaLwIddmnyhu
	oCeKSZG+gsJ+aOgPVgcm0NOdGO84l3Udgz+c+eQqmyehqTX6zdTO8i6b3C7C3s+ce4JkymhqeNr
	lSluDNU8IACB5XiC8bpccOf715qjbWWOGwvAJ53nhhFNHQljm0ETr7oae3qgH8flUhFar6VDlae
	J+r6qkmXLBXSnKuRMbftGDCe6tUPSFkMMND6UJPhSg+L5WdFqfKLt+sqeloBwfMfTy7m2aMrDb+
	n2s72YEuQ3n9qJ/eIUc0R1s90k9Mimp4Wrk5GZiywWmHqg4bzomQtF0WFJNlKM0kS8ZCFtF7X8z
	BcfWK4LOmPooNjHpxxA==
X-Received: by 2002:ad4:5c6d:0:b0:707:4daf:62f with SMTP id 6a1803df08f44-709e250c0f5mr1924886d6.7.1754990840781;
        Tue, 12 Aug 2025 02:27:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJKGm+UhBSlPdpnKeF86J93B+AqDA/p+7hYFKAOley2I+WUeLVMJXey9VyfTdFfRU+b7jZRA==
X-Received: by 2002:ad4:5c6d:0:b0:707:4daf:62f with SMTP id 6a1803df08f44-709e250c0f5mr1924686d6.7.1754990840317;
        Tue, 12 Aug 2025 02:27:20 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2c265sm19700788a12.26.2025.08.12.02.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:27:19 -0700 (PDT)
Message-ID: <3939605c-7335-4401-ba32-b88ee900f1d5@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 11:27:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
References: <20250711213602.GA2307197@bhelgaas>
 <55fc3ae6-ba04-4739-9b89-0356c3e0930c@oss.qualcomm.com>
 <d4078b6c-1921-4195-9022-755845cdb432@oss.qualcomm.com>
 <68a78904-e2c7-4d4d-853d-d9cd6413760e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <68a78904-e2c7-4d4d-853d-d9cd6413760e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mpe9j6pTyUORuNXVx84GeLWJnTGBk4Lb
X-Proofpoint-ORIG-GUID: mpe9j6pTyUORuNXVx84GeLWJnTGBk4Lb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXywUbJWsEs8sP
 TVWQb2GcwF54ASvr2xfloDloxwokMJ8OzIroknKxv5atR0etlufey/CBa2obhk1fxdXDYIaYw64
 CWk3LslxqzWdeA1ciA+Up9R179ds88tvE8ss2DZHtT9pFDQLWSZYVOuRXtKLQv7BPZLhe+NZndW
 +aSf74gAjucRoTz8tmV1IWSCYmiW4LSY5IQnctJpQC4shai4BTql1sB41Mwhn4Qq7aVPctaGUsi
 NlFUu9nXLV9IoCulRnsU3AgGWuDeG2gHoLhhTzsWfSguyh+eIBy3fKXQpDmkA/N7ysbeTUCRAic
 EuCv2MSpKJCccKJLx7ChKweULqrUr88hxt+Fcc398bdd1SQgxItWs+npDAxfuL8BGmfMMGJGa8+
 5z7E3ogV
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689b08f9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=PSSt48hOBszhu4C4aVgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

On 8/12/25 6:05 AM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 7/22/2025 4:33 PM, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>> On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
>>>> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya Chundru wrote:
>>>>> If the driver wants to move to higher data rate/speed than the current data
>>>>> rate then the controller driver may need to change certain votes so that
>>>>> link may come up at requested data rate/speed like QCOM PCIe controllers
>>>>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>>>>> link retraining is done controller drivers needs to adjust their votes
>>>>> based on the final data rate.
>>>>>
>>>>> Some controllers also may need to update their bandwidth voting like
>>>>> ICC BW votings etc.
>>>>>
>>>>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>>>>> before & after the link re-train. There is no explicit locking mechanisms
>>>>> as these are called by a single client Endpoint driver.
>>>>>
>>>>> In case of PCIe switch, if there is a request to change target speed for a
>>>>> downstream port then no need to call these function ops as these are
>>>>> outside the scope of the controller drivers.
>>>>
>>>>> +++ b/include/linux/pci.h
>>>>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>>>>       void (*release_fn)(struct pci_host_bridge *);
>>>>>       int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>>>>>       void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>>>>> +    /*
>>>>> +     * Callback to the host bridge drivers to update ICC BW votes, clock
>>>>> +     * frequencies etc.. for the link re-train to come up in targeted speed.
>>>>> +     * These are intended to be called by devices directly attached to the
>>>>> +     * Root Port. These are called by a single client Endpoint driver, so
>>>>> +     * there is no need for explicit locking mechanisms.
>>>>> +     */
>>>>> +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>>>>> +                     struct pci_dev *dev, int speed);
>>>>> +    /*
>>>>> +     * Callback to the host bridge drivers to adjust ICC BW votes, clock
>>>>> +     * frequencies etc.. to the updated speed after link re-train. These
>>>>> +     * are intended to be called by devices directly attached to the
>>>>> +     * Root Port. These are called by a single client Endpoint driver,
>>>>> +     * so there is no need for explicit locking mechanisms.
>>>>
>>>> No need to repeat the entire comment.  s/.././
>>>>
>>>> These pointers feel awfully specific for being in struct
>>>> pci_host_bridge, since we only need them for a questionable QCOM
>>>> controller.  I think this needs to be pushed down into qcom somehow as
>>>> some kind of quirk.
>>>>
>>> Currently these are needed by QCOM controllers, but it may also needed
>>> by other controllers may also need these for updating ICC votes, any
>>> system level votes, clock frequencies etc.
>>> QCOM controllers is also doing one extra step in these functions to
>>> disable and enable ASPM only as it cannot link speed change support
>>> with ASPM enabled.
>>>
>> Bjorn, can you check this.
>>
>> For QCOM devices we need to update the RPMh vote i.e a power source
>> votes for the link to come up in required speed. and also we need
>> to update interconnect votes also. This will be applicable for
>> other vendors also.
>>
>> If this is not correct place I can add them in the pci_ops.
> Bjorn,
> 
> Can you please comment on this.
> 
> Is this fine to move these to the pci_ops of the bridge.
> Again these are not specific to QCOM, any controller driver which
> needs to change their clock rates, ICC bw votes etc needs to have
> these.

Do you even need to set the OPP explicitly? The global irq handler
already does so on linkup, and you seem to toggle the link state in
the newly introduced helpers

Now not all DTs currently have a global interrupt, but that's a mass
fixup to be done anyway..

Konrad

