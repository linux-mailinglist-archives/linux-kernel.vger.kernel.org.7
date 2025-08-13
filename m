Return-Path: <linux-kernel+bounces-765868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3B5B23F35
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D7F1B67A66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B42BE7CB;
	Wed, 13 Aug 2025 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MzoMEIEP"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DC2BE630
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755057316; cv=none; b=pFyqIA77Bk5eWZYG9U1BbtC/BEN/sjEdxiWcehrEHzyK0SkBXRlZtcDKggSj1iPW5eS45okR+dIaadFA+YAS6ADPmVMRXukAzFP3I+XGYr+igquREV9dGbtlmn3p+GnAdzq+O5r+XAxaAX/CS4JEfYuYSrkQL0GQ+Mo75A3zWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755057316; c=relaxed/simple;
	bh=dnz52Dgxeba8OreSCFoW8AzKahq6NE+sYCZabA34LQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBb5ricq5m1EtrxRWAX9z7Wztd6U25UNBmp/h0YBJMUQR9CsYSvrNTpNaasJtEUn/RWJX7CDnNgIf4T5sUJaK2DABcYQ66Fa0hKSf5IioTEC76duE5R8JxBK/8REwPrJ8TDAARl3u6Z0pfO+X2ElFnIbUD//6am8zz/Ps826m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MzoMEIEP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57D3ncxn018907
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nL73GNJKLk9gxYhZAyNJw/OghTTtC6l/WSrfhqhdCug=; b=MzoMEIEPMWSVoNUJ
	3sk0aj2VjkqD3b8AyFo6WpEwt8aIVsj4ufroqT3KgThb9nUcDLnfknXUywqb0bif
	jmlCYgJduTOO2IfnHo+PtlO9nwL3z8Xylhf2EFCrE9e0+Ik/45GhJihZqtBptd7S
	LEHKIewo8ZpbSfIiDVo7LcWkaaFump4j4z1DiqqCHuPNexgS0bMwWB8VHS5i9IuH
	1ltASY2fCZ9XrwK9+PDBJc+gFLL4G6yHyxjSirc5jqwrA9c54IBNnVw+hvf1cluq
	bNN9c4oLcG3HtzWd2t1y0ArTQG+4b2mHkhFcPTRalnIJK+8SaTDBn8y+E6TtYFVD
	O+LvzA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4eam1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:55:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31f65d519d3so11650989a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755057312; x=1755662112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nL73GNJKLk9gxYhZAyNJw/OghTTtC6l/WSrfhqhdCug=;
        b=GzWXR34i9UKXfxyDkX0Y4jJ0IvsEbHMVBMm1fjIrtBBBkQ1/VSjJIwLWW+x3r5Lnvn
         CqFY5njfEPEiKyqquGEX6JN5JEXlXZleRCU35X/zVZKe0T7x58IU13m3C/mTohjBSZcB
         X7Z4VALt8glBQ0f5rOoMTlSwYGXlyZrY+3te3uNdosj8py28wChnMDvDSsNn1WC6XnZX
         Gq+dxddKAtrYAhTESTu6wT5g2NiFMwAWoXjWVTeyLn01Bz8/4MNq7nVPtsq+mxB97gp7
         1DAnbOkbpoo01imcGbaF8i1BmJTg5ERj+Az41XAgCGqSBwGTGGulj9Dr9O44OtrGTrun
         We+g==
X-Forwarded-Encrypted: i=1; AJvYcCUilx7O+BvY0XDaTxEVUYmcw8hqA/otgLtCXsuHSz33TzCr9DKnt+uUpPcI2l90bLoyxuJOqklzz7jwnRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4EZCQ0qnXJc19lIA2wo1nALNk+PeW1XEXvf1aHUCGYMEF0C5f
	FaVvGBZWNgNUJS9i8h9V4fQ3y/+92J2lt4XJwd3Qrc9mDqQIIioCp9u/KiImqRt9Gu2k3bKqQ/t
	1oIXHPdExF5h7lm07H787Z9e94sJBS942i5XGQthf/Ou81ZlFKjKcos77j3iJLlW6hbg=
X-Gm-Gg: ASbGncvgvIXhOhXxQ7LUB4Vl8po6ERx9unI2RHUbVZtswnlZXcncIZqDIvbyHyfOhtr
	QU39bWQ9GE376Wkokf5+2hX0qvrcF5D4soOTLL0By0YiOOBIac1DHRhmSSeVBQSBMxEi0NntCTa
	wbgMcYaPUklQvoRH4N7+XoWXfJFk9pQtprLB59YIfamknk06OfWcyG7D+Lu1IO2ZgsD5KPgboci
	hNUInJ+tEUSs53isHfJyBa2D5QqeH+94maiYFPlfQ/A0OlPrxtdNK0eiFSEyjc9K3OLhFaYSine
	Q8cseT4RZNPus75bXB96dAtHGx1H+J6fVA8IitubquF/GiiFZiWX09QJ0X/qdZetCpmGSh9WiQ=
	=
X-Received: by 2002:a17:90b:2808:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-321d0da48c2mr1826580a91.13.1755057311373;
        Tue, 12 Aug 2025 20:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6DBH2kfzGflZ64cNW7+2CaKUESotFcZzef6cAyZ1L/M83j5cwOGYdfHt9J3/vXq3xPUnICQ==
X-Received: by 2002:a17:90b:2808:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-321d0da48c2mr1826528a91.13.1755057310792;
        Tue, 12 Aug 2025 20:55:10 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321d1db5da0sm668773a91.16.2025.08.12.20.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 20:55:10 -0700 (PDT)
Message-ID: <ec0e3b33-76f4-4ad5-8497-5c8c8b42f67e@oss.qualcomm.com>
Date: Wed, 13 Aug 2025 09:25:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/bwctrl: Add support to scale bandwidth
 before & after link re-training
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
 <ycbh6zfwae3q4s6lfxepmxoq32jaqu5i7csa2ayuqaanwbvzvi@id4prmhl3yvh>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <ycbh6zfwae3q4s6lfxepmxoq32jaqu5i7csa2ayuqaanwbvzvi@id4prmhl3yvh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SPoaZVP85GwVYkRdLttPzSrTCWMhkNlT
X-Proofpoint-ORIG-GUID: SPoaZVP85GwVYkRdLttPzSrTCWMhkNlT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfX3rRDEOeuVSz4
 vjNprz5hUugTcoBCi96uJt7JPULMCewxuBIVttbB3/YXC1ylB13qerk5kDbeI6b/TNgSpERIBWK
 m0H97463JHR6sq/Z3Dbifl8UYd542C1CanS0ZKifui1O891Rw9nuVXaG4+R8lQoRZt0dog//lw7
 VZJB9JSeasEyBBBPrsMcR4KbQZLUda+NLCIZNhc3hbQhE62/gjRBxfbJkOq8A8wmgY9a7bmekSc
 Pdbk3pxHQoTXFlTfosnvZPNMEblCiNu4Y2a2a0a/+otVRJhYGtAnSXZ706te7qcDDHTlYZk50CI
 Ml9b9yj7AI37yJHhiG4JJ18OhJNnk/nLyrrF8r9L6GIsEgQoOVss/nW2/EgMsojo46eW+b+TxuP
 FEmvoISJ
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689c0ca1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=Rc7TGh9G46w0mRT8ouYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068



On 8/12/2025 10:13 PM, Manivannan Sadhasivam wrote:
> On Tue, Aug 12, 2025 at 09:35:46AM GMT, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 7/22/2025 4:33 PM, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>> On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
>>>>> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya
>>>>> Chundru wrote:
>>>>>> If the driver wants to move to higher data rate/speed than
>>>>>> the current data
>>>>>> rate then the controller driver may need to change certain
>>>>>> votes so that
>>>>>> link may come up at requested data rate/speed like QCOM PCIe
>>>>>> controllers
>>>>>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>>>>>> link retraining is done controller drivers needs to adjust their votes
>>>>>> based on the final data rate.
>>>>>>
>>>>>> Some controllers also may need to update their bandwidth voting like
>>>>>> ICC BW votings etc.
>>>>>>
>>>>>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>>>>>> before & after the link re-train. There is no explicit
>>>>>> locking mechanisms
>>>>>> as these are called by a single client Endpoint driver.
>>>>>>
>>>>>> In case of PCIe switch, if there is a request to change
>>>>>> target speed for a
>>>>>> downstream port then no need to call these function ops as these are
>>>>>> outside the scope of the controller drivers.
>>>>>
>>>>>> +++ b/include/linux/pci.h
>>>>>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>>>>>        void (*release_fn)(struct pci_host_bridge *);
>>>>>>        int (*enable_device)(struct pci_host_bridge *bridge,
>>>>>> struct pci_dev *dev);
>>>>>>        void (*disable_device)(struct pci_host_bridge *bridge,
>>>>>> struct pci_dev *dev);
>>>>>> +    /*
>>>>>> +     * Callback to the host bridge drivers to update ICC BW
>>>>>> votes, clock
>>>>>> +     * frequencies etc.. for the link re-train to come up
>>>>>> in targeted speed.
>>>>>> +     * These are intended to be called by devices directly
>>>>>> attached to the
>>>>>> +     * Root Port. These are called by a single client
>>>>>> Endpoint driver, so
>>>>>> +     * there is no need for explicit locking mechanisms.
>>>>>> +     */
>>>>>> +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>>>>>> +                     struct pci_dev *dev, int speed);
>>>>>> +    /*
>>>>>> +     * Callback to the host bridge drivers to adjust ICC BW
>>>>>> votes, clock
>>>>>> +     * frequencies etc.. to the updated speed after link
>>>>>> re-train. These
>>>>>> +     * are intended to be called by devices directly attached to the
>>>>>> +     * Root Port. These are called by a single client Endpoint driver,
>>>>>> +     * so there is no need for explicit locking mechanisms.
>>>>>
>>>>> No need to repeat the entire comment.  s/.././
>>>>>
>>>>> These pointers feel awfully specific for being in struct
>>>>> pci_host_bridge, since we only need them for a questionable QCOM
>>>>> controller.  I think this needs to be pushed down into qcom somehow as
>>>>> some kind of quirk.
>>>>>
>>>> Currently these are needed by QCOM controllers, but it may also needed
>>>> by other controllers may also need these for updating ICC votes, any
>>>> system level votes, clock frequencies etc.
>>>> QCOM controllers is also doing one extra step in these functions to
>>>> disable and enable ASPM only as it cannot link speed change support
>>>> with ASPM enabled.
>>>>
>>> Bjorn, can you check this.
>>>
>>> For QCOM devices we need to update the RPMh vote i.e a power source
>>> votes for the link to come up in required speed. and also we need
>>> to update interconnect votes also. This will be applicable for
>>> other vendors also.
>>>
>>> If this is not correct place I can add them in the pci_ops.
>> Bjorn,
>>
>> Can you please comment on this.
>>
>> Is this fine to move these to the pci_ops of the bridge.
>> Again these are not specific to QCOM, any controller driver which
>> needs to change their clock rates, ICC bw votes etc needs to have
>> these.
>>
> 
> No, moving to 'pci_ops' is terrible than having it in 'pci_host_bridge' IMO. If
> we want to get rid of these ops, we can introduce a quirk flag in
> 'pci_host_bridge' and when set, the bwctrl code can disable/enable ASPM
> before/after link retrain. This clearly states that the controller is quirky and
> we need to disable/enable ASPM.
> 
> For setting OPP, you can have a separate callback in 'pci_host_bridge' that just
> allows setting OPP *after* retrain, like 'pci_host_bridge:link_change_notify()'.
> I don't think you really need to set OPP before retrain though. As even if you
> do it pre and post link retrain, there is still a small window where the link
> will operate without adequate vote.
> 
Hi Mani,

we need to update the OPP votes before link retrain, for example if
there is request  to change data rate from 5 GT/s to 8 GT/s on some
platforms we need to update RPMh votes from low_svs to NOM corner
without this clocks will not scale for data rates 8 GT/s and link
retrain will fail. For that reason we are trying to add pre and post
callbacks.

- Krishna Chaitanya.
> - Mani
> 

