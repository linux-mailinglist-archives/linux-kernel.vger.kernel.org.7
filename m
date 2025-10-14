Return-Path: <linux-kernel+bounces-851837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFA1BD7686
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D902019A283E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F86291C07;
	Tue, 14 Oct 2025 05:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fX41j3W8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7920264A8D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419256; cv=none; b=erTOSGz9Rj9QqN0NQdLp+vfg8ZQROE0IWWMZWqXLGO/Yc1WWnS9dh/D4ZHZNRTnOVuJH1LyXHfOvEvy/dNIbMBNBL1OEOEDO9DGcsD8eHyS6RKCGEoQ3hN+G3OK0WpjrsP4ONy2AB+tRktv5KKrsMPePtMd9/+JMQu8pAvlHT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419256; c=relaxed/simple;
	bh=UxrCrURIYoEaGcszpb56z3jQjOCNpu2sTBsM6wrz+yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPirCyInojeHWZhymcihs2CBKiUsPh2svp2lCcJGUGr/hFHEGXugOYKNfWm+P2tJOg72UhrdpPERneVBfi+jAHeeangb/NNXAxEJ0exSpRryl+0hx888XjYsQPwmyTVK9LVxW4fOuD7v4yea2uUJT3LzE92tO5GlJtcP3Fwr+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fX41j3W8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDXV8019427
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yvqF8DYLjafvi+gMij4k/ZfLIN5YYyS6USXN/Cv/VcM=; b=fX41j3W8rvIocm7p
	JUQz0BlDwmPhjDPs3ykoqGHbg0BTCr1Y2rloEKSmcmY5XcZOzI0BLc4kpZDngQjf
	dLEDXdq9fiMEj7qY9JOH9Jx4boZUqzR5Xr3/EO792xJJuLT7VO2h8Tkvxb7l1OUR
	qYK1rtiH32nzpIFzsg1SF/8rgXyxrlNdOnkuRliU082bMP66HVirpOMCaP9J3YpF
	kH4f0ClRKlE7oi1E74lqHWiTQ4etfv9Hfg6GFcqCSro6Z+7tcKdXqwGawsb375tK
	93jnhlzHGqUHBlbutNlr8FHuwXw3cGGVzaeK/U4apiPaGf/T6+gjk3Klld8cXm9f
	pa9WXg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfery7tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:20:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2681642efd9so87466635ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419252; x=1761024052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvqF8DYLjafvi+gMij4k/ZfLIN5YYyS6USXN/Cv/VcM=;
        b=BH0MJ9tM19P5xARqhrQ985QUQ/rx4lLa9sDTr32n26ZlppdYiP+HVELoVFeWTldUnS
         k3XSfLPQgT17j/1fg13rTaWwM2RADGs0sx70Yn/dQcbBzUc/pX9TA3NVJAoKaxZMvEdr
         9xo5tIff8BdvE83Pig1B8LZjR3DNELTLKggSZtZHQcTt1VwoKIAQEBl/yShOC+9oM0US
         GPxtcsTEbYlK/xK3BKt3/7q1h14VGpe0SqhYBhgnK53KTD9i4qmzSXmKDga1iYNKVeR8
         rh0EcMXiruvD/IPDfo8It2Q+rwDtYOAPqJaEijuToyqeCNZ4r0OEehZcMxzO7T7fUOkG
         IAow==
X-Forwarded-Encrypted: i=1; AJvYcCULBduQAjvpUXqPhUFB4Q/YDMGGZeKAsGbYzmto0ckMUX3YFWg4leS7lCEMz7jfrdWjupwcTXWxJDKRhzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS87XukjMUA/OYBO7XG9fN+5gX2ef4B4/DsZSordUHI360UQco
	wz3jHSC1oWNgR1ILsyEmGijvaCkSV5+w+2HLBKryGUhlSefLxurm3AKoc3fzsDq9gCxlIcaGwHL
	mSRarjrk9dr6iPlVMbBgFRZwBFYEO4Pij0wbSE/zvn01Y8kvCVDUZ//2cLbUD7mSVPKv8N7xFVq
	A=
X-Gm-Gg: ASbGncv/QM6Zg0DjFGKa7gxH3bflajgj7HbgqFAOUTppuMyMQqP6e5encXQ2Wei53Wv
	ykWFGNwH78lDN1I9io9CGgpATe2QJWgyH9+R8aIR/Es+bbFBqk1XcVCaClD6ydHcIAixbGTenmP
	Uz50FeYW0pDc0sVSpwv9hx9sCbKj/C6L0yXkqM7SoSwxtflUzIorfYgK0ZwPLu4LDDusno5aQuI
	Eb4aLdNiuVyB0I8i+4JnbTx0eCI1kDodre61XTDL0PW+fPGYtjOPcu4zt1+qCagzIixelTvS24y
	FUMRFwdklrHxltbLPTwRHRi3lcYZ7wVTFIVy2+0Mox8i3GxxPYluIx6j0E0j7hc+bAwgXHwePQ=
	=
X-Received: by 2002:a17:903:244c:b0:27e:dc53:d222 with SMTP id d9443c01a7336-290273713c8mr281598395ad.44.1760419251723;
        Mon, 13 Oct 2025 22:20:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsL1A/NUIg/+/5DcYNeqv6XyMlYlzj4jSQQAAeiL0ON/Muf4qcSsKga9vyJuwXAaA1wTT+9w==
X-Received: by 2002:a17:903:244c:b0:27e:dc53:d222 with SMTP id d9443c01a7336-290273713c8mr281598155ad.44.1760419251227;
        Mon, 13 Oct 2025 22:20:51 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f894c8sm151716115ad.122.2025.10.13.22.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 22:20:50 -0700 (PDT)
Message-ID: <bc7deb1a-5f93-4a36-bd6a-b0600b150d48@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 10:50:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
To: Bjorn Helgaas <helgaas@kernel.org>, Ron Economos <re@w6rz.net>,
        Conor Dooley <conor@kernel.org>
Cc: bhelgaas@google.com, rishna.chundru@oss.qualcomm.com, mani@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley
 <pjw@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        regressions@lists.linux.dev
References: <20251013212801.GA865570@bhelgaas>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20251013212801.GA865570@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R64O2NRX c=1 sm=1 tr=0 ts=68edddb5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fhfb3jyVSOwbcj7u4KkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: hguuRFd3vPqOflRrHTEp6kxSdQfN4nFq
X-Proofpoint-ORIG-GUID: hguuRFd3vPqOflRrHTEp6kxSdQfN4nFq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXxoBmz3yT+UfE
 DgNSkU+GeI9km7wIWsFpP6lPqmqJQ3DLl7xiUuji8YGcwuoiXkMZODdBXzwYfE8ZXLun32sKmOp
 kf4FmHwa2E21J2gRPeEzW/s5mBcSWqFyP2U1CiiArhiezK49RGCfggUdH2MfteQZg25PTWxrzH3
 r/wVeMXgZzJoOZCpZeyIXr3yPlc95wlCMhLbHkE+ELEy2M45M+IELyKt+0YGyym6jRAZBiQ4xfp
 DJKQeLihLuFNKiHQwRUhnGTDFR62LZMzix7l+UIRolFjBvUW9hqxax6e9hn1FGhSCLj/lnBGbQ1
 cNiH8x6jKaZX2wHMCl6OvFamVh3ju6h3rZjZ2wL0kIjvU7ADFrpUepfR54QokV4p5blHhrI1S0F
 GHKfTPXlhyLwsPpjoRG11LxnBz85lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018



On 10/14/2025 2:58 AM, Bjorn Helgaas wrote:
> [+cc FU740 driver folks, Conor, regressions]
> 
> On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
>> The SiFive FU740 PCI driver fails on the HiFive Unmatched board with Linux
>> 6.18-rc1. The error message is:
>>
>> [    3.166624] fu740-pcie e00000000.pcie: host bridge /soc/pcie@e00000000
>> ranges:
>> [    3.166706] fu740-pcie e00000000.pcie:       IO
>> 0x0060080000..0x006008ffff -> 0x0060080000
>> [    3.166767] fu740-pcie e00000000.pcie:      MEM
>> 0x0060090000..0x007fffffff -> 0x0060090000
>> [    3.166805] fu740-pcie e00000000.pcie:      MEM
>> 0x2000000000..0x3fffffffff -> 0x2000000000
>> [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>> [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
>> [    3.579552] fu740-pcie e00000000.pcie: Failed to configure iATU in ECAM
>> mode
>> [    3.579655] fu740-pcie e00000000.pcie: probe with driver fu740-pcie
>> failed with error -22
>>
>> The normal message (on Linux 6.17.2) is:
>>
>> [    3.381487] fu740-pcie e00000000.pcie: host bridge /soc/pcie@e00000000
>> ranges:
>> [    3.381584] fu740-pcie e00000000.pcie:       IO
>> 0x0060080000..0x006008ffff -> 0x0060080000
>> [    3.381682] fu740-pcie e00000000.pcie:      MEM
>> 0x0060090000..0x007fffffff -> 0x0060090000
>> [    3.381724] fu740-pcie e00000000.pcie:      MEM
>> 0x2000000000..0x3fffffffff -> 0x2000000000
>> [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, align
>> 4K, limit 4096G
>> [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
>> [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>> [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>> [    3.988164] fu740-pcie e00000000.pcie: PCI host bridge to bus 0000:00
>>
>> Reverting the following commits solves the issue.
>>
>> 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc: Support ECAM mechanism by
>> enabling iATU 'CFG Shift Feature'
>>
>> 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom: Prepare for the DWC ECAM
>> enablement
>>
>> f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc: Prepare the driver for
>> enabling ECAM mechanism using iATU 'CFG Shift Feature'
> 
> As Conor pointed out, we can't fix a code regression with a DT change.
> 
> #regzbot introduced: f6fd357f7afb ("PCI: dwc: Prepare the driver for enabling ECAM mechanism using iATU 'CFG Shift Feature'")
Hi Conor,

Can you try with this patch and see if it is fixing the issue.
diff --git a/drivers/pci/controller/dwc/pcie-fu740.c 
b/drivers/pci/controller/dwc/pcie-fu740.c
index 66367252032b..b5e0f016a580 100644
--- a/drivers/pci/controller/dwc/pcie-fu740.c
+++ b/drivers/pci/controller/dwc/pcie-fu740.c
@@ -328,6 +328,8 @@ static int fu740_pcie_probe(struct platform_device 
*pdev)

         platform_set_drvdata(pdev, afp);

+       pci->pp.native_ecam = true;
+
         return dw_pcie_host_init(&pci->pp);
  }

- Krishna Chaitanya.

> 

