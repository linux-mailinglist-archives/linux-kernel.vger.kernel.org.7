Return-Path: <linux-kernel+bounces-862505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7E3BF579E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EABF4FF02F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5BB32B9A2;
	Tue, 21 Oct 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lm7ZDnRm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082E32A3DA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038502; cv=none; b=Qeqj6KZp17L9hbpIUhCC4UTXj8IDIJdRw7kazw307hk+YLVmCdTY26EgQCOdCJewrnyOf91dgyeTpnzvyZjOVFqRKJ+0KHjP5eEYkkjzM7okfi+IB2Swieti8NtiovKKxy4dlYaQM8YiY4FAbUB4K14GVcEsmF/p4HFlap/RR7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038502; c=relaxed/simple;
	bh=NhZSOWqFlau16XfGWbBrZ4xuo9l8EcbCN76SJ/B/Vj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PAGnjf1iACvAUTLQQJlExJX79YYS9Xf2xMEWaJRlFKiXn0LeHiKcVdrFuF66lxzEjreMCCrXorDRDgxzg0eDQ+zLG9Pg35aPqlrauAUeJSm7mhmNA8+88JoriqFdU7hh6s0QGFUjNY8c4xzONRZnDVHiJXz+Ks3b5Uwn5lHY8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lm7ZDnRm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7Tll7015154;
	Tue, 21 Oct 2025 09:21:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s437rT
	zYUnWFi33s/IAzTngxdxGHleg4CrKG5h21jWU=; b=Lm7ZDnRmEm8Asih1h3HfR9
	GlYeecRoFSzxB+kD2w8Gmo3FsZEW7tbB9mBHGeWY1ShXrkl91lQzhxHU67vI0C+7
	VhrUfLTVoJqrV/RYAH4xEEEkvDOirIBy8wY/ApffZQRtsZi/eDsqixytmW7fNztK
	R7AOjlO56+UbfpP67ubVIznpayfyjexyiPXrPJdzBw0yxxb7L6EbrkmvrWPzHXJj
	PBRVe72iF4XjCkvJ+vgk2i6/vt0LogFIKgcJOImUBWwiKpGqIkuBPIqZlKXL4fL5
	7IWIUW8wVKNKNsNHsFwQX/0nb87vEO9PnuwqJYLLTY8XORxySnsmc4zV/1y0FqZQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rx5dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 09:21:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59L95vJl018148;
	Tue, 21 Oct 2025 09:21:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rx5dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 09:21:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L9KIZ7002281;
	Tue, 21 Oct 2025 09:21:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej9sv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 09:21:18 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59L9LH5E21234242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 09:21:17 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8128C58066;
	Tue, 21 Oct 2025 09:21:17 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B1F358061;
	Tue, 21 Oct 2025 09:21:13 +0000 (GMT)
Received: from [9.39.24.41] (unknown [9.39.24.41])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 09:21:13 +0000 (GMT)
Message-ID: <8a8ba27c-f924-4feb-a63b-565f385dd60f@linux.ibm.com>
Date: Tue, 21 Oct 2025 14:51:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/vmstat: Fix indentation in fold_diff function.
To: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jinnasujing@gmail.com
References: <aPc4I/8zXCGyiapN@pilot-ThinkCentre-M930t-N000>
Content-Language: en-US
From: Donet Tom <donettom@linux.ibm.com>
In-Reply-To: <aPc4I/8zXCGyiapN@pilot-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VKfjcMz3bHcS-Ai5IZ4jR_yl8h3-KwmI
X-Proofpoint-GUID: PMGkBWgGzlnpISJrr7OazhVD0nUf9Q_T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXzKYg+W7wkVe+
 ZXaeyILcadj83zh2g2OBfsHgPQuD4l9rCifJRWlFP5XRXKRRPmwSLQja0zoOec6gqz3Y14f1DdG
 GwVufDdEtMlVvp+Ty5wObJa8uA9pAykulIvwmPdySsd1fcr+DLC3qreb+IXMqsIukyhdqsxoSrF
 h4Qe/yxEZViGd19UrrWTcHzWdDpZsnMkqK2lA9LjVP+Le0xThRPBRLVL4ZNp1HLt5Uic4KvYC3E
 cbb56slDMtkykNepEH1ouYYNNhhSFlnnBGyNLvhvwrlD0k0QdXr4y4g9G0/94UPsitzZiBZkcDd
 Z125HvGQs30hj1N10t++oXRYNn2a0xExjKgcPHjq4+j4eau6bOQLdhfwCjfLohXjPlBm8H2zXi0
 DQNwg8GKfAYDmykJtGuYmjTOjNmLMA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f7508f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DyMV3BnNAAAA:8 a=VnNF1IyMAAAA:8 a=2ecftfDPbqYspBDr8a8A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022


On 10/21/25 1:07 PM, Jing Su wrote:
> Adjust misaligned braces in the fold_diff function to improve
> code readability and maintain consistent coding style.
>
> Signed-off-by: Jing Su <jingsusu@didiglobal.com>


LGTM

Reviewed-by: Donet Tom <donettom@linux.ibm.com>

> ---
>   mm/vmstat.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index bb09c032eecf..63860c3d22e6 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -782,13 +782,13 @@ static int fold_diff(int *zone_diff, int *node_diff)
>   		if (zone_diff[i]) {
>   			atomic_long_add(zone_diff[i], &vm_zone_stat[i]);
>   			changes++;
> -	}
> +		}
>   
>   	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
>   		if (node_diff[i]) {
>   			atomic_long_add(node_diff[i], &vm_node_stat[i]);
>   			changes++;
> -	}
> +		}
>   	return changes;
>   }
>   

