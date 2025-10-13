Return-Path: <linux-kernel+bounces-850137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D16FBD1FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9643AEA82
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3302F39BF;
	Mon, 13 Oct 2025 08:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VgZJW0Ml"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887C2F3622
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343589; cv=none; b=cu/ZHQ6iUAdm7he7av2UUBn6+zUQBnUahq6+VLQajLUxUVZswlv+QM9zoYd+qZ3Z586rm8e5d6rWwXuw8lZWdrbkDHPyP9hqvqliIGHLrgOO64c1YmfjWSv9gpCgk+rkEe7ECllwXAkYYKABGufTO56JRSHO39UvkOIp2EJlDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343589; c=relaxed/simple;
	bh=nbyUnGNC6iVkZvoDa9txOSKwAbxy+aGL/94mTbuV1Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdBTSZak4G2Gd10cC1Kwc2PJ1nEGOtGjG6P4K+Nue4kQXX8KxU69PtM/hj+Jh+HvfDMBx1RBT/6NG82mijzGCn0Nr9NQaTwA9KJ+PiWR6nHeORQpO+rgdbl/aUAqKA/w6YOOjKYYS3YHr5jN54ws/tb2bCukpFF4G5Ifa8nFMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VgZJW0Ml; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nQJK029645
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AjJaopS3DAoZEJ7/MA+CTzo8Z6j33qR5fjkH7kQjqNg=; b=VgZJW0Mlu3siiy2/
	dVjYVlnPHzVjP9lGh2L4CxvtLD1ZJWRxVuOWU7z2//gS/WCGPSBk+4oRD3lipkzu
	Feqw8Yl2cdhzNuIfllTorZnpEKYb8csWQM95K1CoPzhqA3oszsJL2F2UvJQpqy1W
	01vlvhOEXU7zFPtH+3gXAgaVemPJe/WQWQJDVxZe1JkJh3+JaeLJgjkqIVO/5XmZ
	vPExBQY1cPRbEeS1ovdFyLrUxXeJuA0AuNNgu1RIQ4ozfujr9sONY/5sRo8b2MUH
	YnyD4/cFmJRT8Fr2YfuLc/8GGP+JG+MWx0pJdStLp/rGRpCzrBbo4ojRELyWuFrn
	W6boFA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5bsm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:19:46 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so6785992b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343585; x=1760948385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjJaopS3DAoZEJ7/MA+CTzo8Z6j33qR5fjkH7kQjqNg=;
        b=wm99p3I+uDDjriMleR+gzw3NYdh4RTHjcwaXPCmWXEVTc19f2xpQon4g/Tnkz1oTtg
         stsH4lvfY97CAIOtu6veHM6fRG5rYp43/nrndgE9pYmWb/f1qGMOD0rXYuKLgm6L9avY
         txYs0ULBzD51+z1rvrwqbfWGsVZYIe35d0/ZN4N5HDCw3FyLKF3Z1HXvp5LuaYFNYk03
         JBVFBiu+X44jfDmNjZXUlfUx+vN1+Y8L+igPe65/RBJz0J3OqEDW/i8MCr8k5Jt0pTjC
         xUgvO+o6QQZWUZwJEkYshoEEUw3DSNn6CHeGPu1aCuCkrQzHRLs7wwxE8TQGqmbE1mdZ
         Aqnw==
X-Forwarded-Encrypted: i=1; AJvYcCUva169oFIi4WpjJ1HQIFqNKpBDOodj510XpZamJc30WZb5FcFbacL+WSQfyOYEyH+zIaR4aEmIzNkhRXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5BFdTfSZyfbJkO4lzpjJNEZCnkZiv6v+Ujx2K5Rqi9XDaCzU
	afNHKEN61xeQFwSETEboWcNmesbLc/lRvWCGPi+mgls/UfGU9uh89oCXVlEak5L8gh7EEQ3L0tm
	WT6S/yQbRH8fUTeq23tzm6LsA8152VsKez/zVXA5gjY0x7uYUi4LozHSfbZ0qbpRoHS8=
X-Gm-Gg: ASbGncv00qNNgtz5Un740BkVo9xbb09r2yhD3Sgrgc6vM707+JO2tb5s/4Cahjg/KV5
	Hmf3PRDVvMQ0xCK+Wo06poW+2Abt6J0bvCiKukKTSeHJoTagl3t3cOpZrAdOP5kauPnwAGLoFZ2
	nw1WKIyDRo934/oGMvVqcP9M/5019tqfhjZZmghWvSOkHmYL/+9oHq4xBfIPjHe68lWRv06V0cm
	CtSNfqCAbGCQazSBRxnDRntMXFS1Q0H3OVC+688QGJA5wXgZYjWFETQWysopN67/toOhvMTTUZ0
	+2EjgHL8S+0AqXoDzVGxzIYimGrKf65B0OXMUbY1p+Z0+fvNCNX1ZFZvLbJZyQVtup2b3ptSEw=
	=
X-Received: by 2002:a05:6a20:431a:b0:2ff:3752:8377 with SMTP id adf61e73a8af0-32da854263amr27466079637.59.1760343584825;
        Mon, 13 Oct 2025 01:19:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHNAWKOFDk92n8UbYkabdHidddN3fqxBwTK3LAi4Pw/9wjCPtct6Ntx+TbA7ICVZ9FA1FWWw==
X-Received: by 2002:a05:6a20:431a:b0:2ff:3752:8377 with SMTP id adf61e73a8af0-32da854263amr27466054637.59.1760343584368;
        Mon, 13 Oct 2025 01:19:44 -0700 (PDT)
Received: from [10.218.42.132] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb18e28sm10786156b3a.29.2025.10.13.01.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:19:44 -0700 (PDT)
Message-ID: <bc7f397c-1739-465e-b195-e1a41c34504d@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 13:49:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
To: Ron Economos <re@w6rz.net>, bhelgaas@google.comk,
        rishna.chundru@oss.qualcomm.com, mani@kernel.org
Cc: helgass@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <eac81c57-1164-4d74-a1b4-6f353c577731@w6rz.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UOsttGGpNF1chVX9rZD_AxR_3eBGAnu0
X-Proofpoint-ORIG-GUID: UOsttGGpNF1chVX9rZD_AxR_3eBGAnu0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX+Stfn9Z/jDJJ
 f1Fs7wSHHhYtCcpl/Iv519Y3XdqI/3MtsMMM1YgFtxHhKvAispEowu4JWtvVCR6crYf1xV+adCR
 MktjH6K24x6ODagsj5sBEjD2p97NpgaunW7yk57Urb41WDC1B6VXPDBZ8xsUtUyuhf7D5ubmzuP
 qulbbNIQccN0eJzu65xB2lAA0zoUjK/nf6yi84sL34Y/z6MmtEUABLojz+KIIMxbTu2LwZ8C14m
 TKGEHV3unAewTDoNRHkP7NKv50Cu3D04ozmlPnobXqd+Z6JwvjykNZjuQE+Vy+toYAeSgB6oWNZ
 +bUF5v/LWrXfOkzaDahgCc5iHBRi02ESkJPPHGcx4yKmBn/NAWZnl17lUfi6hLQyzWgeIUxWauq
 EFwCaxDQjCXBHkMQ3/UTboa/vycLRQ==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ecb622 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=0_2MnD8HFQHHBmd3TK8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020



On 10/13/2025 12:44 PM, Ron Economos wrote:
> The SiFive FU740 PCI driver fails on the HiFive Unmatched board with 
> Linux 6.18-rc1. The error message is:
> 
> [    3.166624] fu740-pcie e00000000.pcie: host bridge 
> /soc/pcie@e00000000 ranges:
> [    3.166706] fu740-pcie e00000000.pcie:       IO 
> 0x0060080000..0x006008ffff -> 0x0060080000
> [    3.166767] fu740-pcie e00000000.pcie:      MEM 
> 0x0060090000..0x007fffffff -> 0x0060090000
> [    3.166805] fu740-pcie e00000000.pcie:      MEM 
> 0x2000000000..0x3fffffffff -> 0x2000000000
> [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem 
> 0xdf0000000-0xdffffffff] for [bus 00-ff]
> [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
> [    3.579552] fu740-pcie e00000000.pcie: Failed to configure iATU in 
> ECAM mode
> [    3.579655] fu740-pcie e00000000.pcie: probe with driver fu740-pcie 
> failed with error -22
> 
> The normal message (on Linux 6.17.2) is:
> 
> [    3.381487] fu740-pcie e00000000.pcie: host bridge 
> /soc/pcie@e00000000 ranges:
> [    3.381584] fu740-pcie e00000000.pcie:       IO 
> 0x0060080000..0x006008ffff -> 0x0060080000
> [    3.381682] fu740-pcie e00000000.pcie:      MEM 
> 0x0060090000..0x007fffffff -> 0x0060090000
> [    3.381724] fu740-pcie e00000000.pcie:      MEM 
> 0x2000000000..0x3fffffffff -> 0x2000000000
> [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 ib, 
> align 4K, limit 4096G
> [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
> [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
> [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
> [    3.988164] fu740-pcie e00000000.pcie: PCI host bridge to bus 0000:00
> 
> Reverting the following commits solves the issue.
> 
> 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc: Support ECAM 
> mechanism by enabling iATU 'CFG Shift Feature'
> 
> 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom: Prepare for the DWC 
> ECAM enablement
> 
> f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc: Prepare the driver 
> for enabling ECAM mechanism using iATU 'CFG Shift Feature'
> 
Hi Ron,

can you try with this change.
Looks like fu740-pcie driver has 256MB space of config space so dwc
driver is trying to enable ecam and seeing failures while enabling.

you can try two options 1 is to enable ecam if your hardware supports
it and other is to use native method like below. If you want to enable
ecam your config space should start with dbi address and should have
256Mb aligned 256Mb memory of config space. Uf you want to enable ecam
and had this memory requirement fulfilled, try to change your devicetree
by starting config space with dbi start address and give it a try.

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

