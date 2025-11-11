Return-Path: <linux-kernel+bounces-894712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EE4C4BAB5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CCC3AE93A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49E2D63E8;
	Tue, 11 Nov 2025 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IpobtpAc"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164592D3A75
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842271; cv=none; b=cFWu9KcpjSFpIAiDc4528zR6mz1uHJGZZf0DzSto8zFAU4uucOvu9oDZpncKod0/liP/9APOTTqulhTomwcU1DWSdovZ5QZ+7SaLp4lmCs5Lp0RQVBkCfsbPjve1A7AfSDKPKkn4sBXSLk1l6F25ZSH/EDsLWN5G9qokH8Ibh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842271; c=relaxed/simple;
	bh=Qq3kShmT4mdn6+8D0AZlmIg446YPwEzIws+XPodZW8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URMxUNggj3kb9xNJa5lLDd7wkU8vAfP7xcxQj+rxsdXth4eXtLaP/fyXn33HEJ38Cj39AVmOtU4eiJWrKlUe+z0TkZGREARTsDkXH5HOjO1e9lW7KLBYLewNSpSq4l5pUF3AOrrep76FwbJPHr8EfwCgrR1J9yHffrad2wUTABk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IpobtpAc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAK4jIq032510;
	Tue, 11 Nov 2025 06:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/Cl5kt
	BF+kR2ofhBkBReaYBZVkiflK+2fHt7f/GTOa0=; b=IpobtpAcW9ZbWaLMMeL+S/
	uvOJTY0/T7cY1ROGqpQXJZkuChrilWywWn2HioIcBEry3TqydEjEwHILyTEmrNyQ
	jWF91DSJuhvYfivdT66RnLnLp1HhxOXagbg/vZ13AosJWzRWrP6CZYK88lWSQSpD
	fPaSfyUHgMVt/7znn9u6EBZNSq2BufI3giAUSaydlpPl4bH79/w9q68doFceLxwO
	b3e+0ySAYAHVo7Hfh1wVpdkNwdpPhBSnBUB+AlSfx4giU2qIpktlHprfyAB9YI6t
	PExPXxna4h37bue3s0PRJl98u7fBXIVaaoauFNYvWlME6Z02mc5qoBLm2BEzCrpg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwtheg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:24:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB55rZ8004726;
	Tue, 11 Nov 2025 06:24:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxsg9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:24:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AB6O8u315008008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:24:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAC2520040;
	Tue, 11 Nov 2025 06:24:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7555720043;
	Tue, 11 Nov 2025 06:24:06 +0000 (GMT)
Received: from [9.124.210.43] (unknown [9.124.210.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 06:24:06 +0000 (GMT)
Message-ID: <fe64e1cc-f80a-49f6-a2b4-bc936bbd5916@linux.ibm.com>
Date: Tue, 11 Nov 2025 11:54:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/fair: Skip sched_balance_running cmpxchg when
 balance is not due
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <6fed119b723c71552943bfe5798c93851b30a361.1762800251.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A8zxKZIyHUsG9f-1IcC-3DSNlzWwmrZY
X-Proofpoint-ORIG-GUID: A8zxKZIyHUsG9f-1IcC-3DSNlzWwmrZY
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=6912d68b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=QSENffHbnlRO23lpVA8A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX3t1kx9aUBm90
 P2WhAUReCfeLZObBpx1U/8iXcVHR4P3KRzxl4PvzhHrQZ0r9FERyU4oxQ8SE6lLPR/1gIjgxxzx
 3S9JyBi3tgUfP8SvfeNrngFOO7f3dQwNDWUpXRD7fWTXUprv6p8OXsiPFNEJUkhNxUSDHXBTObS
 tLPHRe6SID3HaWdhEvSKtaJIJdFmQzNEmNgB8JHR4wCOEd7+Rw5Bryk26hK2W2TVbSaT49aC/nv
 U6qY9lU3PkMlaSD3k9S3O70a1rCwjKY2ShPbIEn1mQ6xnQqtxE1P0A7wdx6T++bhBJja7uGGHuA
 LIhIgZ7jrRgYl6+nERbPd8tD6tr6SFfTgCzVDEludJwWAmhuwWFxQuz+tv4PJIM8madlH0FDzCB
 42vnDTbqSXpq8NTYO7xTlBlWtzOpbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Hi Tim,

On 11/11/25 12:17 AM, Tim Chen wrote:
> The NUMA sched domain sets the SD_SERIALIZE flag by default, allowing
> only one NUMA load balancing operation to run system-wide at a time.
> 
> Currently, each sched group leader directly under NUMA domain attempts
> to acquire the global sched_balance_running flag via cmpxchg() before
> checking whether load balancing is due or whether it is the designated
> load balancer for that NUMA domain. On systems with a large number
> of cores, this causes significant cache contention on the shared
> sched_balance_running flag.
> 
> This patch reduces unnecessary cmpxchg() operations by first checking
> that the balancer is the designated leader for a NUMA domain from
> should_we_balance(), and the balance interval has expired before
> trying to acquire sched_balance_running to load balance a NUMA
> domain.
> 
> On a 2-socket Granite Rapids system with sub-NUMA clustering enabled,
> running an OLTP workload, 7.8% of total CPU cycles were previously spent
> in sched_balance_domain() contending on sched_balance_running before
> this change.
Looks good to me. Thanks for getting this into current shape.

I see hackbench improving slightly across its variations. So,
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>

