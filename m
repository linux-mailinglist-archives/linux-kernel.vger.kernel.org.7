Return-Path: <linux-kernel+bounces-856342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8EFBE3EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE3D3BE7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F56A33EB19;
	Thu, 16 Oct 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CmxDICrl"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED101D54FA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625059; cv=none; b=HHzJqA8zVnXX/wRcmX5ilBpot86k64L85Z6meTKlHM8zs6wCF9DkUwtttTMeeplL8nYd40w11QGv3Zl+RDhGSTcPzrLQ7IhEBOIvNiqEssCIMAhoMD34FCeUwzx7pgKfYu137ME7p4VZ7sSt923jB8fxofloCC8fhBU0hho6mpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625059; c=relaxed/simple;
	bh=Vf9afqU7EXG8hwFv191ZCiB8yGTaOBOq5291xV0z9F8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=aR+j0v3guy7J3un5JyiTVbtzrLBNKk1m1t3s5pLXm977XgAapAlrgml/IIajPPk9PWfZ0cT4gPy5NO/9t+w8BeEQb5uVQaNmmrMNL2gFKUg6QtPE7zb29BU1GknYin5qtCo9eebS4jqdh1YFUCasoU50sVpnzS0B8kjadQA0Urk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CmxDICrl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GDSjuM021062;
	Thu, 16 Oct 2025 14:30:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OJ5tOU
	w8/UzVF1GEEaRRUCl/HTRiZBZEsYxOJDd0WXg=; b=CmxDICrlv3hQMiAYcaUoPc
	ZnEXYlxVBI5MKnCb37hW5nw8nVTZKdCKpuG2oGwcOHa+9EKWPqBdFet2oTwI7h32
	UIBFtOjrk3LdLz5X1kjQ8eHdIWQ+aHlBx7Y/u6yxhrEWG5/5N3R85R5zcovoFnXG
	frHF/d04VkH1PFUnd0epu6xpzym+PhQ5Ji9Ey1Ooe3eg2RinNAjuOUlSJJLPuT5M
	5mjTqm2CV9/+Eh8rxpQi1nGw6O67H6qx6FpIWcx+40mc0A7iWjwIkgZoZFzoLw7/
	YWTyvxR4ynhWW3zYHj2KfNnDgtMqg1vmBUBT3iQVbiWOfa1X5Hpflyf4Pkq8bucw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qew0a3xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 14:30:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEBnSf028069;
	Thu, 16 Oct 2025 14:30:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9dcts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Oct 2025 14:30:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59GEUlE850725338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 14:30:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5600E200D9;
	Thu, 16 Oct 2025 14:30:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B074200DD;
	Thu, 16 Oct 2025 14:30:46 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Oct 2025 14:30:45 +0000 (GMT)
Message-ID: <6f213521-6baa-47a3-91bd-6ec54acca076@linux.ibm.com>
Date: Thu, 16 Oct 2025 20:00:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [mainline]Kernel Boot Warings at arch/powerpc/mm/mem.c:341
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, Baoquan He <bhe@redhat.com>
References: <90937fe0-2e76-4c82-b27e-7b8a7fe3ac69@linux.ibm.com>
 <7b9f9ca0-a6d8-40d0-8195-bbf81377e866@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <7b9f9ca0-a6d8-40d0-8195-bbf81377e866@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XWs6YeKTHds7XJr-JvTYslgJYu5Zc9bq
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68f1019b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=fuU_RVYCY8Oo3qyU2PcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX5dJQRUVl/9N6
 5GFzd2QvX26vCvv4nUnVv6ftSNHQNJ2uD3+lhu7dcW2Y8gcnsp8tyEeWUIHOvetbuXx+aNcuX2d
 usG1++ngxzaR2/l2YquEg7Aux9biW8IM/gVWyHTOWXEIOyDB2rSasWGXGVVs2whbBNvFLyoflYO
 Ohcg4x76Y0LyaOc+QDJ+H1ADf3lsZZSsrr+t8ZEQV0C8sexTpLjTJ8C1otD3DKR5LAXnxRYLUX6
 v+cTnPQ9289H7bKSZrXXf2ydtjTqkDR4kbsPsBpkkfZEwzdCh3EhNwUtY3cyNY/bnYfwQJtw/Qm
 Bc1SO6lGji+5k6HCgyIjBnSY7vEQMCkkKOAFK9azN9l0vhsYG7dg5lwNXiMteTKpzd0VjsJi/BR
 ic1u5aB0BmlLdO3KSKhVTUAwhkNNRg==
X-Proofpoint-GUID: XWs6YeKTHds7XJr-JvTYslgJYu5Zc9bq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

Hello Venkat,

On 16/10/25 15:21, Sourabh Jain wrote:
>
>
> On 10/10/25 11:15, Venkat Rao Bagalkote wrote:
>> Greetings!!!
>>
>>
>> IBM CI has reported kernel boot warnings on the mainline kernel on 
>> IBM Power11 system.
>>
>>
>> Attached is the .config file.
>>
>> Traces:
>>
>>
>> [    0.040098] plpks: POWER LPAR Platform KeyStore is not supported 
>> or enabled
>> [    0.043041] ------------[ cut here ]------------
>> [    0.043045] WARNING: CPU: 0 PID: 1 at arch/powerpc/mm/mem.c:341 
>> add_system_ram_resources+0xfc/0x180
>> [    0.043058] Modules linked in:
>> [    0.043065] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
>> 6.17.0-auto-12607-g5472d60c129f #1 VOLUNTARY
>> [    0.043072] Hardware name: IBM,9080-HEX Power11 (architected) 
>> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>> [    0.043078] NIP:  c00000000201de3c LR: c00000000201de34 CTR: 
>> 0000000000000000
>> [    0.043082] REGS: c000000127cef8a0 TRAP: 0700   Not tainted 
>> (6.17.0-auto-12607-g5472d60c129f)
>> [    0.043088] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
>> 84000840  XER: 20040010
>> [    0.043099] CFAR: c00000000017eed0 IRQMASK: 0
>> [    0.043099] GPR00: c00000000201de34 c000000127cefb40 
>> c0000000016a8100 0000000000000001
>> [    0.043099] GPR04: c00000012005aa00 0000000020000000 
>> c000000002b705c8 0000000000000000
>> [    0.043099] GPR08: 000000007fffffff fffffffffffffff0 
>> c000000002db8100 000000011fffffff
>> [    0.043099] GPR12: c00000000201dd40 c000000002ff0000 
>> c0000000000112bc 0000000000000000
>> [    0.043099] GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [    0.043099] GPR20: 0000000000000000 0000000000000000 
>> 0000000000000000 c0000000015a3808
>> [    0.043099] GPR24: c00000000200468c c000000001699888 
>> 0000000000000106 c0000000020d1950
>> [    0.043099] GPR28: c0000000014683f8 0000000081000200 
>> c0000000015c1868 c000000002b9f710
>> [    0.043138] NIP [c00000000201de3c] 
>> add_system_ram_resources+0xfc/0x180
>> [    0.043143] LR [c00000000201de34] add_system_ram_resources+0xf4/0x180
>> [    0.043148] Call Trace:
>> [    0.043150] [c000000127cefb40] [c00000000201de34] 
>> add_system_ram_resources+0xf4/0x180 (unreliable)
>> [    0.043157] [c000000127cefba0] [c000000000010eb4] 
>> do_one_initcall+0x60/0x36c
>> [    0.043162] [c000000127cefc80] [c0000000020068cc] 
>> do_initcalls+0x120/0x220
>> [    0.043169] [c000000127cefd30] [c000000002006cbc] 
>> kernel_init_freeable+0x23c/0x390
>> [    0.043174] [c000000127cefde0] [c0000000000112e8] 
>> kernel_init+0x34/0x26c
>> [    0.043178] [c000000127cefe50] [c00000000000df7c] 
>> ret_from_kernel_user_thread+0x14/0x1c
>> [    0.043181] ---- interrupt: 0 at 0x0
>> [    0.043186] Code: 3d02010c e9210028 e9410020 fb840010 fba40018 
>> 38685b48 3929ffff f9440000 f9240008 4a161035 60000000 54630ffe 
>> <0b030000> 39210028 39400000 39010020
>> [    0.043197] ---[ end trace 0000000000000000 ]---
>> [    0.043202] ------------[ cut here ]------------
>> [    0.043203] WARNING: CPU: 0 PID: 1 at arch/powerpc/mm/mem.c:341 
>> add_system_ram_resources+0xfc/0x180
>> [    0.043209] Modules linked in:
>> [    0.043212] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G W      
>>      6.17.0-auto-12607-g5472d60c129f #1 VOLUNTARY
>> [    0.043217] Tainted: [W]=WARN
>> [    0.043219] Hardware name: IBM,9080-HEX Power11 (architected) 
>> 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>> [    0.043223] NIP:  c00000000201de3c LR: c00000000201de34 CTR: 
>> 0000000000000000
>> [    0.043226] REGS: c000000127cef8a0 TRAP: 0700   Tainted: G W       
>>     (6.17.0-auto-12607-g5472d60c129f)
>> [    0.043229] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 
>> 84000440  XER: 20040010
>> [    0.043237] CFAR: c00000000017eed0 IRQMASK: 0
>> [    0.043237] GPR00: c00000000201de34 c000000127cefb40 
>> c0000000016a8100 0000000000000001
>> [    0.043237] GPR04: c00000012005a9c0 0000000020000000 
>> c000000002b705c8 0000000080000000
>> [    0.043237] GPR08: 000000257fffffff fffffffffffffff0 
>> c000000002db8100 000000011fffffff
>> [    0.043237] GPR12: c00000000201dd40 c000000002ff0000 
>> c0000000000112bc 0000000000000000
>> [    0.043237] GPR16: 0000000000000000 0000000000000000 
>> 0000000000000000 0000000000000000
>> [    0.043237] GPR20: 0000000000000000 0000000000000000 
>> 0000000000000000 c0000000015a3808
>> [    0.043237] GPR24: c00000000200468c c000000001699888 
>> 0000000000000106 c0000000020d1950
>> [    0.043237] GPR28: c0000000014683f8 0000000081000200 
>> c0000000015c1868 c000000002b9f710
>> [    0.043271] NIP [c00000000201de3c] 
>> add_system_ram_resources+0xfc/0x180
>> [    0.043276] LR [c00000000201de34] add_system_ram_resources+0xf4/0x180
>> [    0.043280] Call Trace:
>> [    0.043281] [c000000127cefb40] [c00000000201de34] 
>> add_system_ram_resources+0xf4/0x180 (unreliable)
>> [    0.043287] [c000000127cefba0] [c000000000010eb4] 
>> do_one_initcall+0x60/0x36c
>> [    0.043291] [c000000127cefc80] [c0000000020068cc] 
>> do_initcalls+0x120/0x220
>> [    0.043296] [c000000127cefd30] [c000000002006cbc] 
>> kernel_init_freeable+0x23c/0x390
>> [    0.043301] [c000000127cefde0] [c0000000000112e8] 
>> kernel_init+0x34/0x26c
>> [    0.043305] [c000000127cefe50] [c00000000000df7c] 
>> ret_from_kernel_user_thread+0x14/0x1c
>> [    0.043308] ---- interrupt: 0 at 0x0
>> [    0.043311] Code: 3d02010c e9210028 e9410020 fb840010 fba40018 
>> 38685b48 3929ffff f9440000 f9240008 4a161035 60000000 54630ffe 
>> <0b030000> 39210028 39400000 39010020
>> [    0.043322] ---[ end trace 0000000000000000 ]---
>> [    0.043520] kprobes: kprobe jump-optimization is enabled. Al
>

Please try the below fix:
https://lore.kernel.org/all/20251016142831.144515-1-sourabhjain@linux.ibm.com/

Thanks,
Sourabh Jain


