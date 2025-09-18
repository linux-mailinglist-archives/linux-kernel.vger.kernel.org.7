Return-Path: <linux-kernel+bounces-822380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D299DB83B03
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFB01B21A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7CD2FF149;
	Thu, 18 Sep 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iasrYwn/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D32F549C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186352; cv=none; b=Hdlj2zUXHnhKTYzVDMElIb3vR5XCPx6irDXuuE6yHIBFIys7buwyv0lIhytyi5y7qtJmLII46aprKFKM0uJLr3krmqycUbKgGwzTQHHoK6ZxdPwWNB/DUBDoHdf4MeIQyMTJGGQsjfTsPUHmy/LbZwFrZt8h04RMd4bh8J3LE0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186352; c=relaxed/simple;
	bh=3jNolqJkapC/Ko3tIVGHtQ6koTpXkWQZS6HoZP9KJ3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i2hXWLDiLr8XEl43kS5R/Gx4jAh/wR8k1083iKhXXBN2iIA8wGLT4fE6/FexeV/zHvzsLbbUnS+TAiPNIu3T2PiEcksvYxXF0EKCvlqow/G8yzww5UgtZuwyAphj6Jj+xRxpS5znAZTs9RLt77kczbhgc2ordNq4qfW/uZsn3RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iasrYwn/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I3G3So027077
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	efwfuR0XZuIlYyd3jHeDV9GXnA+hdIP5wvjI/VjJjUc=; b=iasrYwn/9pH8hb8G
	GQWuNQoQqOP+gTGpFNe+OrrORZJb/JnVA5//h2oL/HI6l7PBAXj6MupId/BycE8L
	WWq3eCzQGm1t4/MqsNbYmtG00kp7m9YZoWRmYgruE6ZeMkFHGsj/7Y23vr2JOxDJ
	1QxQhSiXaUvqxc953YkjJbmr2zCqxUZOa0bysKsXqjm5cywbG9NVY12t2ame+qfp
	kAisG1Fv2FCoW4oIeWf7Vd+jpzcEUB5c2OCJAtVN/m5gdaFOUVrFyDqk3wpskgNF
	M1z73/iupTXGViwl6eLLDyNDd2KoYrqhW520JIGhH5c8vyc0xNifME75mS9Pg71N
	t2dX3Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt5prf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:05:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70dca587837so2107306d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186347; x=1758791147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efwfuR0XZuIlYyd3jHeDV9GXnA+hdIP5wvjI/VjJjUc=;
        b=UZoZ3EKq4VGXb+arcwfhzxpjhIkGem8qqBJVJYABpXf9CFyFTHa3TZERJDHfKna77O
         iXl09VSBm0jYQpMPl2nryK7fc7j0H4kRTmAIA/pDP5VCv6oyiiAGkvJivHqGD1ndeQAu
         Kvaq9hBZL12UNCY0NQrb5temzvwDmrc43Bu+vg6mkReKmUkFynI8MzwyAs1Oj38xC2XO
         OIIACnx0TTC1nRVBqEte/BGH26/4pqa5yCrMnroQYxywRKEgx3u6/Gqo7f+zdUJ+heLp
         S5zPAHC4gGDsz37iToL8DxroS0TsFyNk2kHtTvG7tdoAcGUys0z6RFZ2TMg493NbViI7
         cstg==
X-Forwarded-Encrypted: i=1; AJvYcCXAQ6o/B04u8dVcIs62lYFOMIiBSzfx1FmOGc/rbLuuL1kXiFezXRW+r3AIf8YUrhr/aIBIu81lmVe/91o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsyzxOdFwWj6CLbvINxQ7n+abS6qqUfJ/u9I6ALLKMbvmHhrCP
	ustyTpe2Yk+6nKY0NSs8EdxQqYwocv9xA8kn8RVuwcrRc12DsB0NHdOz0ghsjJ4vh/NbAlMLGZg
	X6JI0QRPl2aECTCe93ib4n4mmNHSFuCg9cRl8aW66wXRO45WqMe2cMgtxDOJs0qSxEEE=
X-Gm-Gg: ASbGncutyhhsTpqX3c5OgzDdaS+LUGWzndLqNj5ytRjy914MvhaAXPwR7vK8BLa8j1F
	17GOzVwwaeCGDnioIs/9DsitB/vOLkFgAsJXniBZQVgLh/VorjFzOvSDYVD4qeKO825aRWBkmPc
	vSFB4DrvhTUSv7DpzHdK4RIDJMjLc+MaLk2Hz1S4P2OU5Q36zxfv+zGBS/AYzNay/lS/Hx8YGsG
	CnWtgU8SSzIW5/DNZCLOjPkZPOt3m71N1xD1pCcyqdYoWrpsxMhQuW0NI4r3g73qjoTzq4Wfm7c
	e72+/6bNo4+uTnLpY2pwvy/GGLLGxprLYuiqR/plKApqwZ6mUGGorECfPSBdfBsp3LSQJo7IUqh
	+OyixQB9MpV0Hfdb7yjyieQ==
X-Received: by 2002:ad4:5c4e:0:b0:773:84c1:396 with SMTP id 6a1803df08f44-78ecc822080mr35313386d6.1.1758186346600;
        Thu, 18 Sep 2025 02:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFbRLbBIv3u5UrETuMfbcXFVbaueQuIikLkfQf7q3WwNCyZ+rot/De/umJEGNwkT7guFXU/w==
X-Received: by 2002:ad4:5c4e:0:b0:773:84c1:396 with SMTP id 6a1803df08f44-78ecc822080mr35312996d6.1.1758186345967;
        Thu, 18 Sep 2025 02:05:45 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f287d9sm1085733a12.44.2025.09.18.02.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:05:45 -0700 (PDT)
Message-ID: <035c0d66-bddd-495c-bd23-e1d98570ba7f@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 11:05:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] dt-bindings: thunderbolt: Add Qualcomm USB4 Host
 Router
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Raghavendra Thoorpu <rthoorpu@qti.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mayank Rana <mayank.rana@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <westeri@kernel.org>,
        Yehezkel Bernat
 <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
References: <20250916-topic-qcom_usb4_bindings-v1-1-943ecb2c0fa7@oss.qualcomm.com>
 <20250917061236.GF2912318@black.igk.intel.com>
 <e648a71f-a642-4f5d-bcf8-893484cfe601@oss.qualcomm.com>
 <20250918051244.GJ2912318@black.igk.intel.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918051244.GJ2912318@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: JzBNEzDCDwtcSeIZChK-Fo8KecKwT0bS
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cbcb6c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=yMhMjlubAAAA:8 a=EUspDBNiAAAA:8
 a=Nf3ZQrY7d6tcd-rdNfQA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX2WGacbNNRz8v
 vn5hMTnI+WJuL7GRH12uS2bWjffwsOben/nicpv9LD/Xt3ETxMitkLAs8qfeXjidz0hqeW4pjhz
 Nu2OlgPTlHkmgO4a8DL1pL23Z4L2J7SQV0kGECNSiVyzIgMSViVi0aPeYbW1sLvrkPz+aN0zUFZ
 yRkAFI88haK8Xuh/Oe6Lrsnw+8aASHXH3hcHN/mH6HAY97wxjoFkXMZvQqGqDhQ5pnqKQ2yeSmJ
 6KDk1Dod83/kqjnQtJIXOhRCS1tNtO5iIsYnfgdHuDTjezeF5u2My+Hszb5w63909Rz63A3Jih6
 Wvsxrjr/i1fdD07Odfy/R78IBk6+9mLbFFOh71QQTaVxHQvPWUHWjSWFuJ09jND5lX4lGd1B15r
 CzTylhuY
X-Proofpoint-ORIG-GUID: JzBNEzDCDwtcSeIZChK-Fo8KecKwT0bS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/25 7:12 AM, Mika Westerberg wrote:
> Hi,
> 
> On Wed, Sep 17, 2025 at 08:36:19PM +0200, Konrad Dybcio wrote:
>> On 9/17/25 8:12 AM, Mika Westerberg wrote:
>>> Hi Konrad,
>>>
>>> On Tue, Sep 16, 2025 at 10:06:01PM +0200, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

[...]

>>  struct tb_nhi {
>>         spinlock_t lock;
>> -       struct pci_dev *pdev;
>> +       struct device *dev;
>>         const struct tb_nhi_ops *ops;
>>         void __iomem *iobase;
>>         struct tb_ring **tx_rings;
>>         struct tb_ring **rx_rings;
>> -       struct ida msix_ida;
>>         bool going_away;
>>         bool iommu_dma_protection;
>>         struct work_struct interrupt_work;
>>         u32 hop_count;
>>         unsigned long quirks;
>> +       bool is_pcie;
>>  };
>>  
>> +struct tb_nhi_pci {
>> +       struct pci_dev *pdev;
>> +       struct ida msix_ida;
>> +       struct tb_nhi nhi;
>> +};
>> +
>> +static inline struct tb_nhi_pci *nhi_to_pci(struct tb_nhi *nhi)
>> +{
>> +       if (WARN_ON(!nhi->is_pcie))
>> +               return NULL;
>> +
>> +       return container_of(nhi, struct tb_nhi_pci, nhi);
>> +}
>>
>> I suppose I can probably get this decoupling sent in advance of the rest..
>> It's quite delicate so I'm hoping I won't cause any random nullptrs for you
> 
> Instead of the above is_pcie thing, can you split it so that the PCI parts
> live in pci.c and the "platform" parts live in platform.c (or perhaps this
> is fauxbus now). Then the core part of the NHI code (nhi.c) just works
> regardless of how the controller is wired to the SoC.

I'll simply try to get this decoupling sent soon, so we can debate
over material changes

> There are plenty of examples in the kernel how to do this.
> 
>> - Additional steps are necessary to take the hardware out of reset, set
>>   some magic values here and there, load the firmware (i.e. memcpy_toio())
>>   wake up the MCU and perform Type-C magic (more on that below), all of
>>   which is handled in a new qcom_usb4.c, which does that and ends its probe
>>   function with a nhi_probe_common(). PM of the hardware and its providers
>>   also takes place in Linux, just like with any other IP block on embedded
>>   systems
> 
> Call it qcom.c. But please try to move all the non-PCI generic parts into
> platform.c and then only the Qualcomm specific things live in qcom.c. Idea
> is that we can re-use all that when for example Apple Silicon support is
> added and so on.

That's the plan

[...]

>>>> +
>>>> +  interrupts:
>>>> +    items:
>>>> +      - description: Combined event interrupt for all three rings
>>>> +      - description: OOB Firmware interrupt
>>>
>>> No MSI? If not then at least I suggest to support it in the DT description.
>>
>> No, it seems like across the SoC we only have MSIs on the PCIe RCs
>>
>> Because I don't know what a valid MSI setup would look like, I'd like
>> to defer adding that description to when a platform with them pops up
> 
> I it hard to change these DT bindings later on? If yes then I would
> definitely think forward and make this support MSI from the get-go.

dt-bindings (attempt to) promise an ABI-like interface, so bindings
for *a given IP block* ("dt-bindings describe the hardware") should
not change, unless there's something critically wrong (e.g. "this
could have never really worked").

Adding new properties is always OK, marking the new properties  as
'required' is not (unless it falls into the aforementioned case).

It's also totally OK to add MSI properties to e.g. Apple Host Router
bindings specifically when they come around, as it's simply a different
piece of hardware. It's also OK to create a usb4-host-router.yaml down
the line, which will act as a common include and perform any
maintenance/code churn, so long as it doesn't end up in the bindings
for any specific hw block (e.g. this QC one) becoming more strict
than they were on HEAD^.


> 
>> [...]
>>
>>>> +  wakeup-source: true
>>>
>>> What about the "power contract"? Are you using the existing we have for
>>> ACPI:
>>>
>>> https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#map-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
>>>
>>> It was designed DT in mind but I don't think we have DT bindings for it.
>>> This is needed to make sure the driver (Connection Manager) creates the
>>> tunnels before the native protocol stacks get enumerated (e.g during power
>>> transitions).
>>
>> I added a custom entry to drivers/of/property.c, matching that name.
>> Seems to work fine (tm) so far, but then we haven't yet tested sus/res
>> much.. 
>>
>> Just to make sure - are we expected to ensure that the NHI device is
>> resumed before any protocol controller drivers (at runtime), or do the
>> latter have to *probe* only after they're necessary? I firmly believe
>> the former, but doesn't hurt to ask..
> 
> The former. The TB driver needs to setup tunnels before native protocol
> stacks and their drivers (e.g PCIe and the like) resume. We have the
> device_link from the native "port" / device to the NHI that deals with it
> but it expects the property to be there.

OK then we're on the same page, good

> 
>> [...]
>>>> +            port {
>>>> +                usb4_0_mode_in: endpoint {
>>>> +                };
>>>
>>> This describes the Downstream Facing Port (e.g USB4 port), right? We have
>>> something similar used in Chromebooks so it would be good if we can make
>>> the bindings close to each other if possible. This allows binding firmware
>>> description to retimers (and also to "fixed/embedded" device routers as
>>> recent changes to the USB4 spec makes possible).
>>>
>>> See drivers/thunderbolt/acpi.c::tb_acpi_find_companion().
>>
>> Yes, this binding assumes the Host Router has precisely 1 DFP (Linux
>> Type-C infra isn't ready for anything more, at least not on the DT side
>> to my knowledge) and this port (which isn't necessarily the same as a
>> connector, i.e. a physical receptacle in DT speak, it simply refers to
>> an abstract data connection between two devices)
> 
> Okay I'm not too familiar with the current DT bindings.
> 
>> Notably, I don't think we currently describe the USB4 port (as in, the
>> usb4_port.c meaning of it) at all, but for on-SoC HRs we know all about
>> them, so perhaps a subnode description could make sense. This way we
>> could also point them to the compatible = "usb-c-connector" node
> 
> It should be something (eventually at least :-)) that allows us to describe the
> USB4 ports and on-board retimers (to make it possible to upgrade firmwares
> on those even if there is no link). But also if there is "embedded link"
> device router.

FWIW on DT platforms, onboard retimers (such as the PS883x) are often
described as children of the I2C bus (see e.g. "parade,ps8830" in:
arch/arm64/boot/dts/qcom/x1-crd.dtsi), marked as 'retimer-switch',
which then typec_retimer_xxx() APIs look for using of/fwnode_graph.

Because they're not opaque, but rather self-contained platform
devices, FW updates can/will happen without the tbt subsystem in the
picture.

That said, the retimer being TBT-compliant, still shows up in the
topology:
thunderbolt 1-0:2.1: new retimer found, vendor=0x1da0 device=0x8830


I think adding description of a usb4 port should be quite simple,
I'll look into that.

Konrad

