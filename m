Return-Path: <linux-kernel+bounces-857980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E1BE871E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F365E49B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1F332EC8;
	Fri, 17 Oct 2025 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QeCGYLQy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1392332EB8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760701408; cv=none; b=Tq4DVmSHuZ7eYxH1t1OQZ7AuLMHOuAWYgDuakMXLobvRbe4O0buXzEB6ThZcos0H7bHBCv5DZE1t5uYgN5+hS9yiZcl32PCiJze/UPIKiQZxmddV9CPE5a0Am+uTLsCCm7Gm4PsDH35Ug5SIFp4yYNaQNMaiIgrgiSEh+wzt0kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760701408; c=relaxed/simple;
	bh=/vO1+Zh9nTD9YAmpAAylCJljek17bD4xTv1JhSGAhcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+P6rIusDwuIt3K6eBLSjN4QtD43s33Uv0ONYnttOrYRUT49Pmyvp0dA2oSn+JLpC6vtODAhJeLa5vJQfuprSKOitPCXoKYiKhTaXa/1EqMGV+dlP+kd8bUHrPo9t9R6hurEBYsS2uPVipb/7DXNS6yuPl88NgRZ2KAkBgXKU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QeCGYLQy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8LlGZ022201
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:43:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4W55KXlYCq2tg9cOzmliCyi3kjaRFsOqXZbQeSMbnIc=; b=QeCGYLQyBHmejqFG
	e4NpYD2eobLd1ZhrG4Ot8rRa0c/T2ie2XjatUQx8ldxRBAmJb9HMEYKeTTdI2nGO
	1iYsMjthNQC9qc6lkVqdzAqCoocd2fulwx2cvf6eGk4G6HtXxylyugAYi1WEUHwd
	zzOiAvm9u4Sx2rNSbXxXGW/qMRQ+Yi+NE9yM8hronTB/7FwmJHlT4w3XrqqqlD4A
	NNPal/EAe7q5QhOQ9qhgbzgAfj7/2Yq1ZBxcTQzYlKCVqH8WThKeiThaG8Tz/To1
	xTRNXSKzYnQr9HMD53kbmHglAW5S/ImUgkjkxppG+asPgnb0ZQRMzOCvmiO7aqhc
	HgEvZg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrth1vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:43:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33428befc08so4137382a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760701403; x=1761306203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4W55KXlYCq2tg9cOzmliCyi3kjaRFsOqXZbQeSMbnIc=;
        b=vlajqSSy9wvud0PoIcNR/2xdpT2D08fcZxXsOcl+r7+q31dnRWzjSSo14hSaG7qV50
         FsCIojXLdeCPbkbPViPF+6aDz5dnQx0wYyiz8uSyWVAhoa+ZAwTe/tPwwGrDS6xt5Yvq
         LI00XXLs66FJyW6xcI8bIh14xy7JkYHB4j5yiEVJs5sdpD41my6DqFANjfMkS0E+7coh
         4enbERuXqmgLG7raitZllWpCVPPEPL5eY0dDHuaipmw1zl+0Ar66QPHk0VXxvdtTZasD
         Ipq/soZ0C0R71rWNKYsGLoQWVvvyoq14B5trSZB4meulPToxQtAVQxz/OLnvYoFUGq8Q
         zBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDzkfuKqVycB4YP0VMJzce2W0/P9wXMRIFeepCo9nMHJ92M7SNgzUvm90CXY29exo1dh+0jczmc3FYark=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPiKTUor1qztwm76cJ8qh5oFISHNN/oyBiMZrw2OQxwzWqtbK/
	2UGa0vu0zPjyha+WMYElLBJHfoGeO4wagQO4vcyfwArP9GlCmYSpe9QyspaN05XP3BcH9EnJxHH
	xbCM+iRw7+Y1o9E2DnDEZCO787/orEJ/wCVvStCz9SrwJVnT4tVVfEhx3S6pH/fEzxO4=
X-Gm-Gg: ASbGncur+Nu8F00naAqiD7OxDL9DlAFlXt8TkV+Amfd4hY3Af1fHt7YK8qIiL+SqObt
	2s01QWrbfKrEvhaL0sZOucNheCuZVZfsANHEuH7JJvHQKCComLWmXQZWfZKNlSAhCzsU+STWwb9
	R8JzQsR0iHiCbYO9dVEtSbarQY4zACp12bmx9fFafbXfiaCLUG53eMupcYYBo/x+b3lWEy0SokO
	dvbgDiGHPwnRn3ADgP9O4mIqLmpN5YGEye5c3KskPCSQFCjGIadakmDaAjsT198ozNxs52JIvNT
	dXThsdeiCkKwD6QDCzkzjbd0XjJtMwwg7P7V3Ss2sYxnY+0hXKlR71j6xDjaWnjbI8xljuH4sjp
	Nc7vYDgvBcVbvBw+uuZ1Yo2rHSwNdpQZA
X-Received: by 2002:a17:902:cecb:b0:290:c94b:8381 with SMTP id d9443c01a7336-290c9c89dbbmr43351265ad.7.1760701403170;
        Fri, 17 Oct 2025 04:43:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHIuWf6nFCUylOReGxBDbEW114FkdHVUYGIcgi5VzOO3e9hKGdXl5u+Ees0bSNS9np3dFSOQ==
X-Received: by 2002:a17:902:cecb:b0:290:c94b:8381 with SMTP id d9443c01a7336-290c9c89dbbmr43350855ad.7.1760701402643;
        Fri, 17 Oct 2025 04:43:22 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aab62bsm61665225ad.78.2025.10.17.04.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 04:43:22 -0700 (PDT)
Message-ID: <432e4026-208f-459e-82dc-e74ef5da6a87@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 17:13:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
To: Manivannan Sadhasivam <mani@kernel.org>, Ron Economos <re@w6rz.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Conor Dooley <conor@kernel.org>,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <pjw@kernel.org>, Greentime Hu <greentime.hu@sifive.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        regressions@lists.linux.dev
References: <20251013212801.GA865570@bhelgaas>
 <bc7deb1a-5f93-4a36-bd6a-b0600b150d48@oss.qualcomm.com>
 <95a0f2a4-3ddd-4dec-a67e-27f774edb5fd@w6rz.net>
 <759e429c-b160-46ff-923e-000415c749ee@oss.qualcomm.com>
 <b203ba27-7033-41d9-9b43-aa4a7eb75f23@w6rz.net>
 <yxdwo4hppd7c7lrv5pybjtu22aqh3lbk34qxdxmkubgwukvgwq@i4i45fdgm6sw>
 <18ef2c73-fb10-47b3-838f-bc9d3fd2dbc2@w6rz.net>
 <xfpqp3oign7c3336wxo5yexgitxotttrxgkyzbfknjmfk6pmdc@drsk3ardfl5t>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <xfpqp3oign7c3336wxo5yexgitxotttrxgkyzbfknjmfk6pmdc@drsk3ardfl5t>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NCNIvpgpLnXroeQ54hEjO6LtfAWNmGOp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXzLsLTta1NUxC
 h0SF0Jp13TadoCQdyOid9JQ84XcHFz3wsf7Vggq0HP6KPZsjK4LD/J1t5BqlgCVMWrseBU3kmiK
 4hlp1+A5hapItHqvC/kjgZhhp1mXlHeFD68DnHQsWNrkN4U1fH02GqEQwDHUauyJq2ClT7Pbw1n
 1/mK9QVYGdu6IbQRR53HURh8tLlaAO1iRDf4lotOs64c479lly2HpvQnuZsdElTUlWYGgG4i233
 7gVTo5Gu2kQ8QkGbqqIql7Kl3V/rM8kkzH1WyUsC+jgCwY1ErcH2D4bCRSRs07vA8FtBQKXtLCJ
 ZosVyXOiiVlz3Fp0xiACOJLTDAPHqrbl5d8CE7WvUfia/fS/TL/41bs+8Bln3CdzaoYT9avWq6x
 Ix6sL0Zmc+Gwp2Mo3nZA3LT/9+Qi7w==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f22bdc cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HaFmDPmJAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CY4USPus8yibsuyneK0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=nmWuMzfKamIsx3l42hEX:22
X-Proofpoint-GUID: NCNIvpgpLnXroeQ54hEjO6LtfAWNmGOp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022



On 10/15/2025 7:33 PM, Manivannan Sadhasivam wrote:
> On Tue, Oct 14, 2025 at 03:41:39PM -0700, Ron Economos wrote:
>> On 10/14/25 09:25, Manivannan Sadhasivam wrote:
>>> On Mon, Oct 13, 2025 at 10:52:48PM -0700, Ron Economos wrote:
>>>> On 10/13/25 22:36, Krishna Chaitanya Chundru wrote:
>>>>>
>>>>> On 10/14/2025 10:56 AM, Ron Economos wrote:
>>>>>> On 10/13/25 22:20, Krishna Chaitanya Chundru wrote:
>>>>>>>
>>>>>>> On 10/14/2025 2:58 AM, Bjorn Helgaas wrote:
>>>>>>>> [+cc FU740 driver folks, Conor, regressions]
>>>>>>>>
>>>>>>>> On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
>>>>>>>>> The SiFive FU740 PCI driver fails on the HiFive
>>>>>>>>> Unmatched board with Linux
>>>>>>>>> 6.18-rc1. The error message is:
>>>>>>>>>
>>>>>>>>> [    3.166624] fu740-pcie e00000000.pcie: host bridge
>>>>>>>>> /soc/pcie@e00000000
>>>>>>>>> ranges:
>>>>>>>>> [    3.166706] fu740-pcie e00000000.pcie:       IO
>>>>>>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>>>>>>> [    3.166767] fu740-pcie e00000000.pcie:      MEM
>>>>>>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>>>>>>> [    3.166805] fu740-pcie e00000000.pcie:      MEM
>>>>>>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>>>>>>> [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
>>>>>>>>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>>>>>>>>> [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
>>>>>>>>> [    3.579552] fu740-pcie e00000000.pcie: Failed to
>>>>>>>>> configure iATU in ECAM
>>>>>>>>> mode
>>>>>>>>> [    3.579655] fu740-pcie e00000000.pcie: probe with
>>>>>>>>> driver fu740-pcie
>>>>>>>>> failed with error -22
>>>>>>>>>
>>>>>>>>> The normal message (on Linux 6.17.2) is:
>>>>>>>>>
>>>>>>>>> [    3.381487] fu740-pcie e00000000.pcie: host bridge
>>>>>>>>> /soc/pcie@e00000000
>>>>>>>>> ranges:
>>>>>>>>> [    3.381584] fu740-pcie e00000000.pcie:       IO
>>>>>>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>>>>>>> [    3.381682] fu740-pcie e00000000.pcie:      MEM
>>>>>>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>>>>>>> [    3.381724] fu740-pcie e00000000.pcie:      MEM
>>>>>>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>>>>>>> [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll
>>>>>>>>> T, 8 ob, 8 ib, align
>>>>>>>>> 4K, limit 4096G
>>>>>>>>> [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
>>>>>>>>> [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>>>>>>>> [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>>>>>>>> [    3.988164] fu740-pcie e00000000.pcie: PCI host
>>>>>>>>> bridge to bus 0000:00
>>>>>>>>>
>>>>>>>>> Reverting the following commits solves the issue.
>>>>>>>>>
>>>>>>>>> 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc:
>>>>>>>>> Support ECAM mechanism by
>>>>>>>>> enabling iATU 'CFG Shift Feature'
>>>>>>>>>
>>>>>>>>> 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom:
>>>>>>>>> Prepare for the DWC ECAM
>>>>>>>>> enablement
>>>>>>>>>
>>>>>>>>> f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc:
>>>>>>>>> Prepare the driver for
>>>>>>>>> enabling ECAM mechanism using iATU 'CFG Shift Feature'
>>>>>>>> As Conor pointed out, we can't fix a code regression with a DT change.
>>>>>>>>
>>>>>>>> #regzbot introduced: f6fd357f7afb ("PCI: dwc: Prepare the
>>>>>>>> driver for enabling ECAM mechanism using iATU 'CFG Shift
>>>>>>>> Feature'")
>>>>>>> Hi Conor,
>>>>>>>
>>>>>>> Can you try with this patch and see if it is fixing the issue.
>>>>>>> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c
>>>>>>> b/drivers/pci/controller/dwc/pcie-fu740.c
>>>>>>> index 66367252032b..b5e0f016a580 100644
>>>>>>> --- a/drivers/pci/controller/dwc/pcie-fu740.c
>>>>>>> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
>>>>>>> @@ -328,6 +328,8 @@ static int fu740_pcie_probe(struct
>>>>>>> platform_device *pdev)
>>>>>>>
>>>>>>>           platform_set_drvdata(pdev, afp);
>>>>>>>
>>>>>>> +       pci->pp.native_ecam = true;
>>>>>>> +
>>>>>>>           return dw_pcie_host_init(&pci->pp);
>>>>>>>    }
>>>>>>>
>>>>>>> - Krishna Chaitanya.
>>>>>>>
>>>>>> I've already tried it. It doesn't work. Same error message as before.
>>>>> Can you share us dmesg logs for this change.
>>>>>
>>>>> - Krishna Chaitanya.
>>>> [    3.159763] fu740-pcie e00000000.pcie: host bridge /soc/pcie@e00000000
>>>> ranges:
>>>> [    3.159853] fu740-pcie e00000000.pcie:       IO
>>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>>> [    3.159916] fu740-pcie e00000000.pcie:      MEM
>>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>>> [    3.159953] fu740-pcie e00000000.pcie:      MEM
>>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>>> [    3.160039] fu740-pcie e00000000.pcie: ECAM at [mem
>>>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>>>> [    3.571421] fu740-pcie e00000000.pcie: No iATU regions found
>>>> [    3.571472] fu740-pcie e00000000.pcie: Failed to configure iATU in ECAM
>>>> mode
>>>> [    3.571529] fu740-pcie e00000000.pcie: probe with driver fu740-pcie
>>>> failed with error -22
>>>>
>>>> Same as before the change. The entire log is here:
>>>>
>>>> https://www.w6rz.net/dmesg.txt
>>>>
>>> Weird that the driver still creates ECAM even after skipping it using the flag.
>>> The flag is not meant for that purpose, but it should've worked anyway.
>>>
>>> Can you try this diff and share the dmesg log?
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> index 20c9333bcb1c..58080928df9f 100644
>>> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
>>> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
>>> @@ -523,8 +523,12 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>>>           pp->cfg0_size = resource_size(res);
>>>           pp->cfg0_base = res->start;
>>>
>>> +       dev_info(dev, "%s: %d native_ecam: %d", __func__, __LINE__,
>>> +pp->native_ecam);
>>> +
>>>           pp->ecam_enabled = dw_pcie_ecam_enabled(pp, res);
>>>           if (pp->ecam_enabled) {
>>> +               dev_info(dev, "%s: %d ECAM ENABLED", __func__, __LINE__);
>>>                   ret = dw_pcie_create_ecam_window(pp, res);
>>>                   if (ret)
>>>                           return ret;
>>> @@ -533,6 +537,7 @@ static int dw_pcie_host_get_resources(struct dw_pcie_rp *pp)
>>>                   pp->bridge->sysdata = pp->cfg;
>>>                   pp->cfg->priv = pp;
>>>           } else {
>>> +               dev_info(dev, "%s: %d ECAM DISABLED", __func__, __LINE__);
>>>                   pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>>>                   if (IS_ERR(pp->va_cfg0_base))
>>>                           return PTR_ERR(pp->va_cfg0_base);
>>>
>>> - Mani
>>>
>> After testing with this patch, I must have transferred the wrong image to
>> the target when testing before. The "pci->pp.native_ecam = true;" patch to
>> pcie-fu740.c does work.
> 
> Thanks! However, it was not a proper fix. The issue seems to be due the
> assumption that the whole DBI space (Root Port + misc registers) lies at the
> start of the ECAM region. This is true for Qcom, but not for all DWC glue
> platforms.
> 
> Krishna is working on a patch that decouples the DBI region from ECAM so that
> the driver will continue using DBI for accessing Root Port config space and ECAM
> for bus > 0.
> 
> This is one step backwards for ECAM since the driver is supposed to use ECAM for
> accessing all devices starting from the Root Port. But since DWC has clubbed
> non-Root Port specific registers in the DBI space, we have to live with this
> limitation as ECAM is supposed to access only Root Port specific registers.
> 
> The patch will be posted after internal validation asap.
> 
Hi Ron,

Can you try with this series and let us know if it is helping you or
not.

https://lore.kernel.org/all/20251017-ecam_fix-v1-0-f6faa3d0edf3@oss.qualcomm.com/

- Krishna Chaitanya.

> - Mani
> 

