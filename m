Return-Path: <linux-kernel+bounces-859105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD4BECC9E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B14834E9D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4242D8DA6;
	Sat, 18 Oct 2025 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RiksWa37"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DD2773F9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760779842; cv=none; b=EBMSekyvME6V/R6qPuyTmZGrk//z1stbXvjNIK320/Ag0KDgMRG/z5xkQ8JXVFKqkm7p5iBCW3zAml5tVgw+3rOIz8UL/967WL6qj6wX6RoudZpKHEy11Fp+cIrWrgJp623/bJhquijkNQSxTYKyYusGSTN/HlW3fwRxDLxp85E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760779842; c=relaxed/simple;
	bh=oD5lN/WAuYh/HK6Ah4Pkz2gG6gbaVIjcpoVNUvCww8Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bYc4hpBFNZHSgomh4jnOqtSMegovCGU7rhJZ8/wF6ogJQlGY26if1gcVJ+uZqDkLX6U2IaBrKp6/OgJcVAXlUACnj8dhpi28Qx+pFxRwkxFJjBBwVi02yC6a6gQ78zYhLSvBnyfEtB2duVGaqIJK/EmQeXmGIatxZ8fSNTx7yuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RiksWa37; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59I7xfbB014769
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:30:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9FCLY6m2CafM7SsUWCIuGAId+vM7SdE3NvTvT54I0Eg=; b=RiksWa37gPHm7xFX
	4VF3YjEEtVVgrWm2R11NkBfOxl/TocFZVj9jOEAT7U1YqUmxX2VZOKLHmT8XV4aJ
	RV69clwvNFR7jY07jAaoaVcjzzhhEOKgYuL4ePVt1KFTa7X+AiN7LGuEP8iDQ/wS
	1qx8LtkXVEMEHvMmzrYm/+heSMe+7LqVrp25KvvJ2H+49uzdABiy+fgymxJafsiT
	OByrbdbpEmlYHcB3JS5amiSjtHArNYg9biVVq5NOByPYUpVt5de48F07T5EGGpdm
	CZ19SkY3Hc2spFf4i0zLzAjlRQXyu71FkGVbXuHacwLA1gDEbhxfJAkYlp/svBvt
	dZz8cg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v343rexk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:30:39 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-78102ba5966so2693061b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760779839; x=1761384639;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FCLY6m2CafM7SsUWCIuGAId+vM7SdE3NvTvT54I0Eg=;
        b=J+Qqbi1f05XmayFTUOD1VqyfSBGz/ismSbGDLCDAqlvGWGSUBvGbKA+LSProFWl4Z5
         vekshjP+h1H4KZ6KRZwf3RdTPb5IJ+RcXDOLL/ZtPdmWZSCcKR9fBXySpZR5L0TyahuM
         KI62HFJzOilRFTAo4EXqzqBLSlRDvEakKubA6NRi5p50eqy+g/7b/PuNXsKxYuuZlPPB
         EwYzx2Lt6B3a8Es+lY8m8Lm2zDrbkQwRK6PJqnVIJd0xFk76BaKCvAN8kfWoxl7Q8ZJM
         8N6YgnqyyGiyusr4h0gNiBjLxwVvM/Oq9t5PsqrvtrFWB3aVcUGu0QOicMLy9lAx1Hil
         sO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtJRMAxPPIQZu7C/L5IqhcUm7EpGUp2Xv2NIUr3BIw5ygs6KMVvtcX1GQHv0q6/kj0FKHxxyWj6GV1tNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgH3CTzrLJXczS71USiu/6hst2t/lD8XHExmgEnDle3bf1hUik
	pcTaGJDubSbCODGD1XJwfx0wnILe6EmvswprHZ/sk2n8RD1NPrADf0o4D6ZkVIbOGEMtjIMlBAa
	DAyHfQNoTkHJnjb0lb491jS0nlNxSY2SPBK1XFSvV0XM6kEtarvYguK5kF6T1fr7f0G4=
X-Gm-Gg: ASbGncs2E+KJaz6zG3NnrpmheziDEPy415bYYaKSabZrDG2PUHV+LQNN48ICjL82oLI
	aK82xeNqQit1q9hdWPAKFUdXB1sBhJpIO/do04gcTlKeMTIvT9srCr784y+fjna7zmZBZ3iSjzy
	CPWgNZgKSJQ9v9pbNDouRK1hAPJRQfHno7bCyvsLJ8/LtuYpzzuxaQcs3hYnBfmBIakTJ9H+7MH
	X9U3OrLKAl7AmOU7RAhqOVjKo4lTPNpdHCBQkX1s7vWJljxOZy1mJzDrvnGITc1NJy2S1dDLijI
	bOX52qzbYo5t08Qfml8aUaPksGLXR+USDHffGyOFG5VXCNMQ8dd7LICOpMx1H2rG2VLbxCsX+ED
	IXj4g+3GqU0pJS4dkxQc0ughCJ6abrs1oe60=
X-Received: by 2002:a05:6a20:1585:b0:334:9cbd:72ad with SMTP id adf61e73a8af0-334a85397e6mr8837041637.16.1760779838727;
        Sat, 18 Oct 2025 02:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyCmXTNH5ovcv21xit30ZtszwP+05T3cmOy73/7o1arYyQdNGBTWbaWxuW3JMyTMSiOojJrw==
X-Received: by 2002:a05:6a20:1585:b0:334:9cbd:72ad with SMTP id adf61e73a8af0-334a85397e6mr8837015637.16.1760779838273;
        Sat, 18 Oct 2025 02:30:38 -0700 (PDT)
Received: from [192.168.29.113] ([49.43.226.255])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230123116sm2168550b3a.69.2025.10.18.02.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Oct 2025 02:30:37 -0700 (PDT)
Message-ID: <db799304-1551-410b-af07-fb8d9b50be5c@oss.qualcomm.com>
Date: Sat, 18 Oct 2025 15:00:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: dwc: Fix ECAM enablement when used with vendor
 drivers
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Ron Economos <re@w6rz.net>
References: <20251017-ecam_fix-v1-1-f6faa3d0edf3@oss.qualcomm.com>
 <20251017191005.GA1041995@bhelgaas>
 <mtxez55p4hfvtmhcnwtxeetzqxydyq5e4g5zsdhytxpzgvgeqn@s7asinok5l22>
 <0bc6eb69-029d-45f4-a723-c003ecbb11e5@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <0bc6eb69-029d-45f4-a723-c003ecbb11e5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 53SElJIStK1bOiXX_f8ZT39NEqJNS6XT
X-Proofpoint-ORIG-GUID: 53SElJIStK1bOiXX_f8ZT39NEqJNS6XT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX3t8/2FQ9Qnbq
 Rdzb0lQ5DTpefJLQqX9reewDzPocQ/6nlf0NnUknR+46nErTo+YsKi9eSvODSMiGxmjcfF7pdWZ
 RBWQVsKIq5J2cswhMPjdXJjzFAheP8DmDvG8D0LBwFurYTo9KRxI9uNxTDNF6TRG2S2zQAbQwxM
 a5DcCfy6jfGIp1JuofaSupus3SqjDepHmqtkVO7sh2Uz8glA5QLeJ7ynH1Xl6pikf60vXdozz7R
 Jhz7a5B1aYfo7znanLxF1DUGINhKh5W5i1YqBky6CTxaLeb6UJIqMDJ0oNV+PVoaPrb8LCZUfKV
 ZLqeFjx+1Sx4aO5VVdBLsN0rKhgIXwJuA5f9WvV9KqMA4ZhqUUKAy0YuNkbU/OC8m/mM6sUgrj9
 BLfyWsJEZLzOua14oWBZ4Z/bPNeEJA==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f35e3f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=r8OtbAjNO6w9l/f+plF4pQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=HaFmDPmJAAAA:8 a=EUspDBNiAAAA:8 a=BshiAbRQLV5i_FA8PSwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023



On 10/18/2025 2:55 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 10/18/2025 8:39 AM, Manivannan Sadhasivam wrote:
>> On Fri, Oct 17, 2025 at 02:10:05PM -0500, Bjorn Helgaas wrote:
>>> On Fri, Oct 17, 2025 at 05:10:53PM +0530, Krishna Chaitanya Chundru 
>>> wrote:
>>>> When the vendor configuration space is 256MB aligned, the DesignWare
>>>> PCIe host driver enables ECAM access and sets the DBI base to the 
>>>> dw_pcie_ecam_conf_map_busstart
>>>> of the config space. This causes vendor drivers to incorrectly program
>>>> iATU regions, as they rely on the DBI address for internal accesses.
>>>>
>>>> To fix this, avoid overwriting the DBI base when ECAM is enabled.
>>>> Instead, introduce a custom ECAM PCI ops implementation that accesses
>>>> the DBI region directly for bus 0 and uses ECAM for other buses.
>>>>
>>>> Fixes: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM 
>>>> mechanism using iATU 'CFG Shift Feature'")
>>>> Reported-by: Ron Economos <re@w6rz.net>
>>>> Closes: 
>>>> https://lore.kernel.org/all/eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net/
>>>> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
>>>> Signed-off-by: Krishna Chaitanya Chundru 
>>>> <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>   drivers/pci/controller/dwc/pcie-designware-host.c | 28 
>>>> +++++++++++++++++++----
>>>>   1 file changed, 24 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c 
>>>> b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> index 
>>>> 20c9333bcb1c4812e2fd96047a49944574df1e6f..e92513c5bda51bde3a7157033ddbd73afa370d78 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>>> @@ -23,6 +23,7 @@
>>>>   #include "pcie-designware.h"
>>>>   static struct pci_ops dw_pcie_ops;
>>>> +static struct pci_ops dw_pcie_ecam_ops;
>>>>   static struct pci_ops dw_child_pcie_ops;
>>>>   #define DW_PCIE_MSI_FLAGS_REQUIRED 
>>>> (MSI_FLAG_USE_DEF_DOM_OPS        | \
>>>> @@ -471,9 +472,6 @@ static int dw_pcie_create_ecam_window(struct 
>>>> dw_pcie_rp *pp, struct resource *re
>>>>       if (IS_ERR(pp->cfg))
>>>>           return PTR_ERR(pp->cfg);
>>>> -    pci->dbi_base = pp->cfg->win;
>>>> -    pci->dbi_phys_addr = res->start;
>>>> -
>>>>       return 0;
>>>>   }
>>>> @@ -529,7 +527,7 @@ static int dw_pcie_host_get_resources(struct 
>>>> dw_pcie_rp *pp)
>>>>           if (ret)
>>>>               return ret;
>>>> -        pp->bridge->ops = (struct pci_ops 
>>>> *)&pci_generic_ecam_ops.pci_ops;
>>>> +        pp->bridge->ops = &dw_pcie_ecam_ops;
>>>>           pp->bridge->sysdata = pp->cfg;
>>>>           pp->cfg->priv = pp;
>>>>       } else {
>>>> @@ -842,12 +840,34 @@ void __iomem *dw_pcie_own_conf_map_bus(struct 
>>>> pci_bus *bus, unsigned int devfn,
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
>>>> +static void __iomem *dw_pcie_ecam_conf_map_bus(struct pci_bus *bus, 
>>>> unsigned int devfn, int where)
>>>> +{
>>>> +    struct pci_config_window *cfg = bus->sysdata;
>>>> +    struct dw_pcie_rp *pp = cfg->priv;
>>>> +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>> +    unsigned int busn = bus->number;
>>>> +
>>>> +    if (busn > 0)
>>>> +        return pci_ecam_map_bus(bus, devfn, where);
>>>
>>> Is there a way to avoid the "root bus is bus 00" assumption here?  It
>>> looks like something like this might work (it inverts the condition
>>> to take care of the root bus special case first):
>>>
>>>    if (bus == pp->bridge->bus) {
>>>      if (PCI_SLOT(devfn) > 0)
>>>        return NULL;
>>>
>>>      return pci->dbi_base + where;
>>>    }
>>>
>>>    return pci_ecam_map_bus(bus, devfn, where);
>>>
>>
>> I guess it will work.
>>
>>>> +    if (PCI_SLOT(devfn) > 0)
>>>> +        return NULL;
>>>
>>> This essentially says only one function (00.0) can be on the root bus.
>>> I assume that someday that will be relaxed and there may be multiple
>>> Root Ports and maybe RCiEPs on the root bus, so it would be nice if we
>>> didn't have to have this check.
>>>
>>> What happens without it?  Does the IP return the ~0 data that the PCI
>>> core would interpret as "there's no device here"?
>>>
>>
>> I hope the read returns ~0, but the idea is to catch the invalid 
>> access before
>> trying to read/write. In case of multi Root Port design, I don't think 
>> we have a
>> way to identify it. So maybe it is safe to remove this check.
>>
> For multi root port we may need to revisit this, currently along with
> dbi there are some other registers iATU, elbi etc. So there might be
> chances to read these registers like iATU as part of enumeration and
> these can return non ~0 values which will have adverse effects.
> So we should have this check for now.
> 
One more issue is some controllers may pass only 4k memory as dbi memory
so we might get unmapped address access issues also.
- Krishna Chaitanya.
> - Krishna Chaitanya.
> 
>> - Mani
>>

