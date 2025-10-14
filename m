Return-Path: <linux-kernel+bounces-851841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FCBD76A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AF344E1EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A559F296BBD;
	Tue, 14 Oct 2025 05:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="j/OmbZLC"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3FF1D90DF
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419625; cv=none; b=aOoQ5kbQuUI8a8woa6i/Qj0ASiT5VnVrEXTPlJN7HpCQHDWMyUDQMqkdfRPZv7hiH2Fx7NaZv9AIh8msvjMFfKHbdm8NLJAUHERi0R8A2Iq2iL0s/z3W3R2iNf6BMjn3F3CKdnCFuaO7Yo67BWafPDcEvsoU2rbY697NnwOdGac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419625; c=relaxed/simple;
	bh=P4BWQigDaXi0JePdZl4bWrKwTCdNdsH0LmVITb6M1Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RerqnX9WF3jPbl51vH4qaR6MQf/2yhuI+0Hrz/ngSB3Xqxu+wz6M7w7E8aJ2YzIcWIT9SZh8qi0fBE7YUEag7Dyct172GE4j5xOLzF1z2q7Rq/IqhqtqmtXyuupxF5aC42iefJ7/wXrJV3fBdd3drvgA1g941FKjTExzFl1xScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=j/OmbZLC; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id 8VtLvvloYaPqL8XYsvec0q; Tue, 14 Oct 2025 05:27:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id 8XYrvVL1QrMH58XYsvAbeS; Tue, 14 Oct 2025 05:27:02 +0000
X-Authority-Analysis: v=2.4 cv=eaE9f6EH c=1 sm=1 tr=0 ts=68eddf26
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=7vwVE5O1G3EA:10
 a=9VXFyi0rFAJFUNMutsYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Wh1V8bzkS9CpCxOpQUxp:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iVnTJ/Uow+/494pNjGbD8AvWtc0PjGDVdzmx39Dv63o=; b=j/OmbZLC9Idbxfaax7ubCwFCXT
	XnLEEHXdVWJ1rQcyAG4ZmeBuNrZznVH9JNcJxYxLHpTDz/9Yj+NC+Bl4iqwXn5onSgLUButHEZNaZ
	p5xToOdxAAUDIWsAeZAnHyXBQfN2B3NBj1fGKoA3o8oWST/2FvjnlLogBk++lenB8n8tFZBWAnDr8
	uF/YOdN13QapPS+freHb3rJ3Oal3N2Ge0vwemYjB04OyDnS8LD+zFYxWk9HD23ZuS0H6xht6/cOKU
	8hklJmsv57qDKV7MTvTed0+qWNaMkbiHYXpgXIXi/0/jgCq777jbTEIUTU5k6VgB4ns0NMB/J6Bl2
	2NJwfVwg==;
Received: from c-73-92-56-26.hsd1.ca.comcast.net ([73.92.56.26]:36646 helo=[10.0.1.116])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <re@w6rz.net>)
	id 1v8XYr-000000038nP-0TGO;
	Mon, 13 Oct 2025 23:27:01 -0600
Message-ID: <95a0f2a4-3ddd-4dec-a67e-27f774edb5fd@w6rz.net>
Date: Mon, 13 Oct 2025 22:26:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SiFive FU740 PCI driver fails on 6.18-rc1
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: bhelgaas@google.com, mani@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>,
 Paul Walmsley <pjw@kernel.org>, Greentime Hu <greentime.hu@sifive.com>,
 Samuel Holland <samuel.holland@sifive.com>, regressions@lists.linux.dev
References: <20251013212801.GA865570@bhelgaas>
 <bc7deb1a-5f93-4a36-bd6a-b0600b150d48@oss.qualcomm.com>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <bc7deb1a-5f93-4a36-bd6a-b0600b150d48@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.92.56.26
X-Source-L: No
X-Exim-ID: 1v8XYr-000000038nP-0TGO
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-92-56-26.hsd1.ca.comcast.net ([10.0.1.116]) [73.92.56.26]:36646
X-Source-Auth: re@w6rz.net
X-Email-Count: 6
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJsE+UDewd8VQcRyfwP6qf14dT1LVmsxSzRWsPvU4BjKhGgVMjde6vqLjlynIksg7iu/qHQHDz0ss4etJKMo5+KPfnCmQSOCSB7CjwMjukGLK013XE8z
 ImckQhE5so1+fu5Xd46DD9L5hT/8nNbOcj65F+3IMsZvpcyEM1GMyKCbBvowavwH23WGEbZzD3hEeL8WIFYLFD2xG6/tHlSWyPY=

On 10/13/25 22:20, Krishna Chaitanya Chundru wrote:
>
>
> On 10/14/2025 2:58 AM, Bjorn Helgaas wrote:
>> [+cc FU740 driver folks, Conor, regressions]
>>
>> On Mon, Oct 13, 2025 at 12:14:54AM -0700, Ron Economos wrote:
>>> The SiFive FU740 PCI driver fails on the HiFive Unmatched board with 
>>> Linux
>>> 6.18-rc1. The error message is:
>>>
>>> [    3.166624] fu740-pcie e00000000.pcie: host bridge 
>>> /soc/pcie@e00000000
>>> ranges:
>>> [    3.166706] fu740-pcie e00000000.pcie:       IO
>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>> [    3.166767] fu740-pcie e00000000.pcie:      MEM
>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>> [    3.166805] fu740-pcie e00000000.pcie:      MEM
>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>> [    3.166950] fu740-pcie e00000000.pcie: ECAM at [mem
>>> 0xdf0000000-0xdffffffff] for [bus 00-ff]
>>> [    3.579500] fu740-pcie e00000000.pcie: No iATU regions found
>>> [    3.579552] fu740-pcie e00000000.pcie: Failed to configure iATU 
>>> in ECAM
>>> mode
>>> [    3.579655] fu740-pcie e00000000.pcie: probe with driver fu740-pcie
>>> failed with error -22
>>>
>>> The normal message (on Linux 6.17.2) is:
>>>
>>> [    3.381487] fu740-pcie e00000000.pcie: host bridge 
>>> /soc/pcie@e00000000
>>> ranges:
>>> [    3.381584] fu740-pcie e00000000.pcie:       IO
>>> 0x0060080000..0x006008ffff -> 0x0060080000
>>> [    3.381682] fu740-pcie e00000000.pcie:      MEM
>>> 0x0060090000..0x007fffffff -> 0x0060090000
>>> [    3.381724] fu740-pcie e00000000.pcie:      MEM
>>> 0x2000000000..0x3fffffffff -> 0x2000000000
>>> [    3.484809] fu740-pcie e00000000.pcie: iATU: unroll T, 8 ob, 8 
>>> ib, align
>>> 4K, limit 4096G
>>> [    3.683678] fu740-pcie e00000000.pcie: PCIe Gen.1 x8 link up
>>> [    3.883674] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>> [    3.987678] fu740-pcie e00000000.pcie: PCIe Gen.3 x8 link up
>>> [    3.988164] fu740-pcie e00000000.pcie: PCI host bridge to bus 
>>> 0000:00
>>>
>>> Reverting the following commits solves the issue.
>>>
>>> 0da48c5b2fa731b21bc523c82d927399a1e508b0 PCI: dwc: Support ECAM 
>>> mechanism by
>>> enabling iATU 'CFG Shift Feature'
>>>
>>> 4660e50cf81800f82eeecf743ad1e3e97ab72190 PCI: qcom: Prepare for the 
>>> DWC ECAM
>>> enablement
>>>
>>> f6fd357f7afbeb34a633e5688a23b9d7eb49d558 PCI: dwc: Prepare the 
>>> driver for
>>> enabling ECAM mechanism using iATU 'CFG Shift Feature'
>>
>> As Conor pointed out, we can't fix a code regression with a DT change.
>>
>> #regzbot introduced: f6fd357f7afb ("PCI: dwc: Prepare the driver for 
>> enabling ECAM mechanism using iATU 'CFG Shift Feature'")
> Hi Conor,
>
> Can you try with this patch and see if it is fixing the issue.
> diff --git a/drivers/pci/controller/dwc/pcie-fu740.c 
> b/drivers/pci/controller/dwc/pcie-fu740.c
> index 66367252032b..b5e0f016a580 100644
> --- a/drivers/pci/controller/dwc/pcie-fu740.c
> +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> @@ -328,6 +328,8 @@ static int fu740_pcie_probe(struct platform_device 
> *pdev)
>
>         platform_set_drvdata(pdev, afp);
>
> +       pci->pp.native_ecam = true;
> +
>         return dw_pcie_host_init(&pci->pp);
>  }
>
> - Krishna Chaitanya.
>
>>
I've already tried it. It doesn't work. Same error message as before.


