Return-Path: <linux-kernel+bounces-773091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC702B29B51
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 475F93AED1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0925728750D;
	Mon, 18 Aug 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CDWxzdKw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBDA286434
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503543; cv=none; b=JT95tSXYxNV7PmyohBEyLkiNWdx8FejJydlDOTgZMeNr/6Kttogdx88nKUP2FDUw5E/GXh/D7vj1LCEPRVzcu98GU4B0x/me60Nv/Ju2AAuZfCVrgNzs/4QUFHXdj5ekrCgZW07oOJP+lEILPWbJJXMFjPU4bM/7dIywwiRZIQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503543; c=relaxed/simple;
	bh=pgkEKMAueomDIInDqIv7rp4PxkF7KhmnYbTHvcvQgsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKwYgiyI+h+X78jrMcs/g+kW7Kery8omDykvNQtr1ocf+jkfFepRBNy2z/hchPd9WQLxU6GP9xp5TSvNGWLpJm0XeiCzxEnQpqs1do3mzarMIOARRTh6XGJf1qOkrzLb+9HTjZw1AJR/V6fJB8Qa14LKefYQFaxofPcb7gcPMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CDWxzdKw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HL7u2R008998
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D8DSjaS6Nzqt4Y1X63RBdfnA4n1R0NNiVWDomfR+v5s=; b=CDWxzdKw3ksLzHI1
	QAI6u8TdkTkW49JYAqt6s1P9wlxFrq2ZLt85SuVIsChDo71+97r7wjxelxBud3sv
	1khQvu6V6dICgkN8NeKYp4nl6hi18WGWH7o5r152I5caoIvKxB1Da3C9WE/ChniD
	ACBLMq7Arkz64RNscnslUjO0inkz8AmPJeCptzoODXQ4AJ/bO6cYls26jlXxx0Gk
	W3gIXTr8cYLWSH3/JE+ooe5ENTb82MRMtcw698vX8aPgVOPwqPTGhf5KokvxIOWC
	QvtzWzAtoJxFm7/nJzPugS341qeoPcMhJ14r7XMCLJSWU7Fh4UF9pEIEXEhU4WqJ
	aEPPiw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfus6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:52:20 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174b3427so3272790a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 00:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755503540; x=1756108340;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8DSjaS6Nzqt4Y1X63RBdfnA4n1R0NNiVWDomfR+v5s=;
        b=BTSTN+rrma32RZF0+Q1mSCSk5GcfnDEN411qt42Fedf3TU6PEynbKYq+X6wkkokD4A
         rRhlZcYXN9ppGcUAzWVH4zlBocOdAXl9hHME06pl9qHkeE/kww6LQbxaBbz2JvNVcnat
         3hpN5/sQq/EFMw7WELxJ52D0eT260PU/zVvn4AmZhSFe8JVHOUZYYYHyNLmFbfiD7l1f
         fUfOGuDQ8if8rVCfW64cfHlG9aQ9BJR9iU0csICBvyUs/nYtriPqK1TCltUtw4CaZaY+
         SWSj4HxS7tnMPZEBldaWuExTpx5sxNCUMM6DNW+8TqlSmcjQF7BpoQHTLl4HD9+EUj8k
         aZSA==
X-Forwarded-Encrypted: i=1; AJvYcCXlLLPeUjbUoBTWYuhNfXy+jEisRJh+uI3aLF4ilMrnWDAkOyEijn3M6edRgxY42pC9xJyqJDSuXiSAzxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUbQcdYic6V8aFZy/Lj0rE/QB3d0UMNwoJrUtcHfFUjP6GF0ZK
	+/V0nwWiEjOgJkZAMMtb3s+zPazVn4zfl0JnWwTFtgqXhI9+YpOt4F0UwMvJ8Ir/HuzJYPWr6Tx
	XEnAsgvn54dk6XuWPcCUf1kVQmQ6kerJwUVm6I4JR71DYnI6p3QTwTmKLA+QHzPRFCVE=
X-Gm-Gg: ASbGnctSqolWBIX03Da9MjTj6yqw8t6Kis7ObiAM+mg3YY86o4FsM84dDS2X0ZKDY8L
	pxHvpakCM8WH8j1CzZSmZI4zWGu3sYMMAO9FaUL8YcwFmgnJJNNH6Ls3U8i0iee3kNgmmwgwU9n
	Hf04a8ZHHWGnFwhAeTKoBTQltE0I2JDBG+FW2rjL/DXe4OIW2QIorLvZtkluey9IK9PFpic7Sx1
	5pSo1o3xTLF9O7A+A+OhXDs4e8GDHWn9ei/3G90OqSXoA7XreXDOu/zhtyfLnR7URU08SOO5nIO
	a80wCFTIcfVcYEeWJR9SxTNPa7XdxI9yUJFRG7UCtVfCzPZh7gQSsCjd7nn87IANH0DhaXHcbg=
	=
X-Received: by 2002:a17:90b:180d:b0:321:7a2f:985d with SMTP id 98e67ed59e1d1-3234216190bmr15208495a91.25.1755503539597;
        Mon, 18 Aug 2025 00:52:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv2ygM0PYT7FNcy0ZmFqjfoVjQ4GvBdacyoCcKsAMMiTB8lssJGuToO/HUfO1DKh2BZxqgnA==
X-Received: by 2002:a17:90b:180d:b0:321:7a2f:985d with SMTP id 98e67ed59e1d1-3234216190bmr15208447a91.25.1755503538964;
        Mon, 18 Aug 2025 00:52:18 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b474e146654sm530414a12.34.2025.08.18.00.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 00:52:18 -0700 (PDT)
Message-ID: <378d4f1e-ade1-4549-ae15-f15d387876a3@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:22:11 +0530
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
 <ec0e3b33-76f4-4ad5-8497-5c8c8b42f67e@oss.qualcomm.com>
 <mrsdwtzz7x6uuoakjr6kymqccfxs3lndplols7j33apbru7jii@tjdljisgaqny>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <mrsdwtzz7x6uuoakjr6kymqccfxs3lndplols7j33apbru7jii@tjdljisgaqny>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3G6X_vpJ97Mtp8cQo981-Vtemu4c_tF3
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a2dbb4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=-mV2PR8Q5cfizQaz2gsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfX2U+8bnM1u0lQ
 6vhGvTYhVVDq/UTjrJ/lGcwHL1MxycoQE6S9wum73Xt2KQo9zcmvBhhBE55trEH4WTcN7bSItML
 IugUARATT6aE38V7p8MHDTrce/pzTAX3G39HrdiXERhuUmOXLnYZv7uxWGMKPkDSQzpkOFYu2Gn
 wXqUX1meB3Rsz6Y2FZO7xzBIVu99DAx377EktqEWYFwyAYCkD2tY8vm9l4GtwQwSsCg0dt7HKbY
 25XjaVO5WUVQ19y+kinxCBaKqImMOzX4bzKZiHu1nlIXF2a3Ej/hj9ntE+GUWSiCGcB5cxVrjCa
 0c/+KXzvt7o4KWchuyl42vzee9bNBk6pOrKJloruRh9RVuRs7Frd2Zr+ZP07WC50IWmKNy9Bx30
 gtS4AfxY
X-Proofpoint-ORIG-GUID: 3G6X_vpJ97Mtp8cQo981-Vtemu4c_tF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039



On 8/18/2025 12:39 PM, Manivannan Sadhasivam wrote:
> On Wed, Aug 13, 2025 at 09:25:03AM GMT, Krishna Chaitanya Chundru wrote:
>>
>>
>> On 8/12/2025 10:13 PM, Manivannan Sadhasivam wrote:
>>> On Tue, Aug 12, 2025 at 09:35:46AM GMT, Krishna Chaitanya Chundru wrote:
>>>>
>>>>
>>>> On 7/22/2025 4:33 PM, Krishna Chaitanya Chundru wrote:
>>>>>
>>>>>
>>>>> On 7/12/2025 4:36 AM, Krishna Chaitanya Chundru wrote:
>>>>>>
>>>>>>
>>>>>> On 7/12/2025 3:06 AM, Bjorn Helgaas wrote:
>>>>>>> On Mon, Jun 09, 2025 at 04:21:23PM +0530, Krishna Chaitanya
>>>>>>> Chundru wrote:
>>>>>>>> If the driver wants to move to higher data rate/speed than
>>>>>>>> the current data
>>>>>>>> rate then the controller driver may need to change certain
>>>>>>>> votes so that
>>>>>>>> link may come up at requested data rate/speed like QCOM PCIe
>>>>>>>> controllers
>>>>>>>> need to change their RPMh (Resource Power Manager-hardened) state. Once
>>>>>>>> link retraining is done controller drivers needs to adjust their votes
>>>>>>>> based on the final data rate.
>>>>>>>>
>>>>>>>> Some controllers also may need to update their bandwidth voting like
>>>>>>>> ICC BW votings etc.
>>>>>>>>
>>>>>>>> So, add pre_link_speed_change() & post_link_speed_change() op to call
>>>>>>>> before & after the link re-train. There is no explicit
>>>>>>>> locking mechanisms
>>>>>>>> as these are called by a single client Endpoint driver.
>>>>>>>>
>>>>>>>> In case of PCIe switch, if there is a request to change
>>>>>>>> target speed for a
>>>>>>>> downstream port then no need to call these function ops as these are
>>>>>>>> outside the scope of the controller drivers.
>>>>>>>
>>>>>>>> +++ b/include/linux/pci.h
>>>>>>>> @@ -599,6 +599,24 @@ struct pci_host_bridge {
>>>>>>>>         void (*release_fn)(struct pci_host_bridge *);
>>>>>>>>         int (*enable_device)(struct pci_host_bridge *bridge,
>>>>>>>> struct pci_dev *dev);
>>>>>>>>         void (*disable_device)(struct pci_host_bridge *bridge,
>>>>>>>> struct pci_dev *dev);
>>>>>>>> +    /*
>>>>>>>> +     * Callback to the host bridge drivers to update ICC BW
>>>>>>>> votes, clock
>>>>>>>> +     * frequencies etc.. for the link re-train to come up
>>>>>>>> in targeted speed.
>>>>>>>> +     * These are intended to be called by devices directly
>>>>>>>> attached to the
>>>>>>>> +     * Root Port. These are called by a single client
>>>>>>>> Endpoint driver, so
>>>>>>>> +     * there is no need for explicit locking mechanisms.
>>>>>>>> +     */
>>>>>>>> +    int (*pre_link_speed_change)(struct pci_host_bridge *bridge,
>>>>>>>> +                     struct pci_dev *dev, int speed);
>>>>>>>> +    /*
>>>>>>>> +     * Callback to the host bridge drivers to adjust ICC BW
>>>>>>>> votes, clock
>>>>>>>> +     * frequencies etc.. to the updated speed after link
>>>>>>>> re-train. These
>>>>>>>> +     * are intended to be called by devices directly attached to the
>>>>>>>> +     * Root Port. These are called by a single client Endpoint driver,
>>>>>>>> +     * so there is no need for explicit locking mechanisms.
>>>>>>>
>>>>>>> No need to repeat the entire comment.  s/.././
>>>>>>>
>>>>>>> These pointers feel awfully specific for being in struct
>>>>>>> pci_host_bridge, since we only need them for a questionable QCOM
>>>>>>> controller.  I think this needs to be pushed down into qcom somehow as
>>>>>>> some kind of quirk.
>>>>>>>
>>>>>> Currently these are needed by QCOM controllers, but it may also needed
>>>>>> by other controllers may also need these for updating ICC votes, any
>>>>>> system level votes, clock frequencies etc.
>>>>>> QCOM controllers is also doing one extra step in these functions to
>>>>>> disable and enable ASPM only as it cannot link speed change support
>>>>>> with ASPM enabled.
>>>>>>
>>>>> Bjorn, can you check this.
>>>>>
>>>>> For QCOM devices we need to update the RPMh vote i.e a power source
>>>>> votes for the link to come up in required speed. and also we need
>>>>> to update interconnect votes also. This will be applicable for
>>>>> other vendors also.
>>>>>
>>>>> If this is not correct place I can add them in the pci_ops.
>>>> Bjorn,
>>>>
>>>> Can you please comment on this.
>>>>
>>>> Is this fine to move these to the pci_ops of the bridge.
>>>> Again these are not specific to QCOM, any controller driver which
>>>> needs to change their clock rates, ICC bw votes etc needs to have
>>>> these.
>>>>
>>>
>>> No, moving to 'pci_ops' is terrible than having it in 'pci_host_bridge' IMO. If
>>> we want to get rid of these ops, we can introduce a quirk flag in
>>> 'pci_host_bridge' and when set, the bwctrl code can disable/enable ASPM
>>> before/after link retrain. This clearly states that the controller is quirky and
>>> we need to disable/enable ASPM.
>>>
>>> For setting OPP, you can have a separate callback in 'pci_host_bridge' that just
>>> allows setting OPP *after* retrain, like 'pci_host_bridge:link_change_notify()'.
>>> I don't think you really need to set OPP before retrain though. As even if you
>>> do it pre and post link retrain, there is still a small window where the link
>>> will operate without adequate vote.
>>>
>> Hi Mani,
>>
>> we need to update the OPP votes before link retrain, for example if
>> there is request  to change data rate from 5 GT/s to 8 GT/s on some
>> platforms we need to update RPMh votes from low_svs to NOM corner
>> without this clocks will not scale for data rates 8 GT/s and link
>> retrain will fail. For that reason we are trying to add pre and post
>> callbacks.
>>
> 
> If we are targetting OPP only, then can't we do direct OPP setting from the
> bwctrl driver itself? Or we also need to set ICC votes directly also (in the
> non-opp case)?
we are targeting only OPP, I can directly call OPP API's from bwctrl
driver.

As recommended, I will try to introduce a quirk flag in pci_host_bridge
to enable and disable ASPM before & after retrain. And will call OPP
API's in bwctrl driver itself.

- Krishna Chaitanya.
> 
> - Mani
> 

