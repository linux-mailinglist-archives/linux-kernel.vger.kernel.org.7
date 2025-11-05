Return-Path: <linux-kernel+bounces-885760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E4FC33D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 04:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E07054E4406
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 03:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6495E221FA0;
	Wed,  5 Nov 2025 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fsh1zd9X"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DB1DDA1E
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313676; cv=none; b=j94VBvR5OTsfIAIlvCR33lS213irC2CSQm9b5dZCgN/161t31WUd709IaKi7fdf3TP3NcZQB1LS2Eusb3a4qqYjxcPRAwTSxu9BBM5/30ST64MNMZf9VDyQG1uJGlgTMsR1Toy/X0fHxvMWadHoyxpQvFX7k98i0PbHNRmwvw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313676; c=relaxed/simple;
	bh=mqwLGxE4Y564ZewohM8e+2lOgfE4v+q7gK0OGvckDt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+TpXLU6Xtwtqm/Bo7Aw5R7Zm8KqEKKfx2uUUVDhJf52NlWD71CpQHr2cCTO0GfAlrGRFXaUFpiPK4n+48PXSBm+Gwj/kh7ExVUn2cje0Iy3oytSvCFzBx4KYf+ALOS9oG7BfeDnFPqSuR3mL7Yl2W97dtS8332imLcc5/AibwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fsh1zd9X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4EgECR024476;
	Wed, 5 Nov 2025 03:34:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mqwLGx
	E4Y564ZewohM8e+2lOgfE4v+q7gK0OGvckDt4=; b=Fsh1zd9XmM+0Qw5AshzRsz
	Gm3WrqmmPdjasc5DhPIlxPkc0zyRd28dbqtSNgmszN6AG18OZx++I7ERTsxWUD9G
	pnxa0RnFKqJMCieG5Iet3ObncZlkpfZSrICpywsY49OOBHlh/oz2lJM0AoWJv5wa
	ObDVX+z398WMx4K0rY4HatkaGdj5t097nbzN9xQeIShY0KjDIf416745mmG2vUk2
	F2ukfci6aU5Ym3gvAtsj3dOM8UZDv2o2IoejlXCj3HjhfIg5SvAP2bHnNffIgCeZ
	x1rTNVQYTHIfXxKLqdXZEWg4ATd0LlcTzA/CznUXsOXeE4JbeXswRAQfTxDv8KyQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vuf6qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 03:34:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A530ZDI009855;
	Wed, 5 Nov 2025 03:34:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1ke6ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 03:34:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A53YH7B59769142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 03:34:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57CD420043;
	Wed,  5 Nov 2025 03:34:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C732F20040;
	Wed,  5 Nov 2025 03:34:15 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 03:34:15 +0000 (GMT)
Message-ID: <a81bf9c0-f8c8-49f9-965d-26f704a73517@linux.ibm.com>
Date: Wed, 5 Nov 2025 09:03:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Export kdump crashkernel CMA ranges
To: Baoquan he <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Jiri Bohac <jbohac@suse.cz>, Shivang Upadhyay <shivangu@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
References: <20251103035859.1267318-1-sourabhjain@linux.ibm.com>
 <aQrBbYVEQleExjpk@MiWiFi-R3L-srv>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <aQrBbYVEQleExjpk@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HXZlabnTa8h_DEIcxvl6Sm-kK7acfCMs
X-Proofpoint-GUID: HXZlabnTa8h_DEIcxvl6Sm-kK7acfCMs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX/2AOhhSIVWQ3
 CEMlQwF3PoJSFF8N6w/iSrlQZ7dH9aqMHwpp6EAayXxRCihpo2E+PpouVBw/L4wmuBokZSRU3Y9
 VWx6Z5TFWqNJwggDUgDUMkW2t9bloYQpA5VoIshtPdqjOWfxlQJHXzsZVYX0ofHtT9d/qNA9G4g
 bN4sjRu2oChRnZmA+3iW5eDQNoF9gazfJY2UlR7dtYKL5YZQcCTk85zg7AJ/dSkdCEutsyTHJnM
 LsFv+idoiWRcjDSW9wRj3802H6uRnqKxa7YO2cnyi5cNbLOKGXLiB1te07/cptx25ISLlO/dCiF
 ykzxtk4L24YlaTHi3y73Vwx9EMsHqHCvaZ2xaf/2Bq8phBDw9+RddWG1PN321EhNFpPDCcYnAHp
 8GvFpss+rLobSzBRzYDKw+EwC6OnVA==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=690ac5bc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XWi_oYZyp0CedhVi0gkA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_02,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021



On 05/11/25 08:45, Baoquan he wrote:
> On 11/03/25 at 09:28am, Sourabh Jain wrote:
>> /sys/kernel/kexec_crash_cma_ranges to export all CMA regions reserved
>> for the crashkernel to user-space. This enables user-space tools
>> configuring kdump to determine the amount of memory reserved for the
>> crashkernel. When CMA is used for crashkernel allocation, tools can use
>> this information to warn users that attempting to capture user pages
>> while CMA reservation is active may lead to unreliable or incomplete
>> dump capture.
>>
>> While adding documentation for the new sysfs interface, I realized that
>> there was no ABI document for the existing kexec and kdump sysfs
>> interfaces, so I added one.
>>
>> The first patch adds the ABI documentation for the existing kexec and
>> kdump sysfs interfaces, and the second patch adds the
>> /sys/kernel/kexec_crash_cma_ranges sysfs interface along with its
>> corresponding ABI documentation.
>>
>> *Seeking opinions*
>> There are already four kexec/kdump sysfs entries under /sys/kernel/,
>> and this patch series adds one more. Should we consider moving them to
>> a separate directory, such as /sys/kernel/kexec, to avoid polluting
>> /sys/kernel/? For backward compatibility, we can create symlinks at
>> the old locations for sometime and remove them in the future.
> That sounds a good idea, will you do it in v2? Because otherwise the
> kexec_crash_cma_ranges need be moved too.

Yes I will include it in v2.

Thanks,
Sourabh Jain


