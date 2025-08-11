Return-Path: <linux-kernel+bounces-763267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E73DB2128B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB0A3B764A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59716296BCE;
	Mon, 11 Aug 2025 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pvUcqneq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475431A9F81
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930824; cv=none; b=pIh2mFV8pLmH+8slQeFcfh27/qcVjU2N3dQ9nKOWKkswfbNtNKhdF7dfzY30nfaLYxrUWIddT4iSS9J+ZDRyLYPmeF/BSXTHl0sWiz8PWk8nCRpjvtj2fx6t3FabUWb/91i72unMMiSO0qS4WjR1hJFrSbm2Xuot2B7ejQ4jy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930824; c=relaxed/simple;
	bh=Prp8WzqA6YNKxb8OzECBYLVfoH/qg6qLGJ5psfyRxgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YQ6eQkvVbP7QfVRewoZg3In7RpaCJlskM4jEJI+6TmlwVxJrd4sZfSRrTY0PB7BRRhVCETCgPO/L2uNn4P41siLdJzLl86m77oSeQXIEM9/munyIluc1ijb94kMF/jDWif+rZdqpIw4zmjpLhujSxWOiU2VspDBHEgs0FNT2tGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pvUcqneq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BA8WMr027956;
	Mon, 11 Aug 2025 16:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=i8LsXB
	MRBe/Icg4da9jE4AlWAsPYCbJGuzx7DJqs7+8=; b=pvUcqneqANvc7ZJ3wXGNpF
	8d/UNG2ORVtv9z8kuz1JFSj+2Pf307wacnhWibXtJ8MvSudc2ZRNc6MALykKZysf
	p9svoc9ee2SxmWSto1ih9W3gx9757J/a/K1EsSGhlnYJyJUn6F8bAdJLLilQAvUx
	E/OrYd6sUwcZ/+tbMhVNqOLWFMq5narkdFfsWfMP/rv3yp79pxqR139nJz2Qy0N6
	ZnmQkT4EYmlu63YOcnCzC9oL4KXtPqd4VIotCVAuOB1aF33VN93o7xoUYtGukMtj
	rd51vZ9kuqEOcgF6gFkgXCKIpKu7k6dicxxpXbgix/vXQtf1ZBQ4AN8ahdTQ6eSA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2ctdat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 16:46:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BG7uH8017617;
	Mon, 11 Aug 2025 16:46:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3ed6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 16:46:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BGkeJZ47448424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 16:46:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59F5A20043;
	Mon, 11 Aug 2025 16:46:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 023E020040;
	Mon, 11 Aug 2025 16:46:39 +0000 (GMT)
Received: from [9.39.30.243] (unknown [9.39.30.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 16:46:38 +0000 (GMT)
Message-ID: <f3ecce9f-22cf-48e2-843e-63f08a577e69@linux.ibm.com>
Date: Mon, 11 Aug 2025 22:16:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc/fsl/qbman: Use for_each_online_cpu() instead of
 for_each_cpu()
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: frederic@kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
References: <20250811065216.3320-1-wangfushuai@baidu.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250811065216.3320-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNiBTYWx0ZWRfXzUjSuxKKKX8J
 NIaAIJsCrluSo5NbhwWQJ+X9uLkf919nigjMkco6BbFFc5a/uHZT8WzAC+py6gT6myDO/mgBYve
 +HVOAOr/0qvkXD66X2bNKuE5c4LzorK3dQrdvFz+ZXC/0UTx8CmLBk0dOWN1A/mJg/kEFqt5C2E
 ggZhjUhfdNwm4QjQXJ2M+6ysrhYzMelsLKVvVt50crY9g7uUKJ81EDEZn/lGr5yNdvtouZoDk0I
 wjLYwCHZ9WNXwrWu5a4C/3Vi5io9qe8jsxEykyGqG3v5eXfozxE81sgwoR08weXvGNWy/5noMk2
 d6ny8FdV7zbFkMT8OUNk3cEiMJsU6jw6gXpvoCCWE231RkZ3d0FcJPjowMA0LELm7lijW1kgr25
 T0XItL4i+K4UpQKRn0B2g8GyzubcCNPnRBaQxrcwdqaZft4uPn0oEcJxJ9naryoEdT63hryq
X-Proofpoint-GUID: TDgLOFCUzs6KSeu4QXexSOYJXoB8Jad6
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689a1e73 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=zuLzuavZAAAA:8 a=VATuJ96wsPKbvXY_zzoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TDgLOFCUzs6KSeu4QXexSOYJXoB8Jad6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=977 suspectscore=0 impostorscore=0 clxscore=1011 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508110106



On 8/11/25 12:22, Fushuai Wang wrote:
> Replace the opencoded for_each_cpu(cpu, cpu_online_mask) loop with the
> more readable and equivalent for_each_online_cpu(cpu) macro.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>   drivers/soc/fsl/qbman/qman_test_stash.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
> index f4d3c2146f4f..6f7597950aa3 100644
> --- a/drivers/soc/fsl/qbman/qman_test_stash.c
> +++ b/drivers/soc/fsl/qbman/qman_test_stash.c
> @@ -103,7 +103,7 @@ static int on_all_cpus(int (*fn)(void))
>   {
>   	int cpu;
>   
> -	for_each_cpu(cpu, cpu_online_mask) {
> +	for_each_online_cpu(cpu) {
>   		struct bstrap bstrap = {
>   			.fn = fn,
>   			.started = ATOMIC_INIT(0)

Yes. This change makes sense given that for_each_online_cpu expands into the same.

Why not do for the remaining ones too?

linux_tip$ grep -Rw "for_each_cpu" * | grep  cpu_online_mask
arch/riscv/kernel/unaligned_access_speed.c:     for_each_cpu(cpu, cpu_online_mask) {
arch/riscv/kernel/unaligned_access_speed.c:     for_each_cpu(cpu, cpu_online_mask) {
drivers/soc/fsl/qbman/qman_test_stash.c:        for_each_cpu(cpu, cpu_online_mask) {    ** current patch addresses this.
drivers/infiniband/hw/hfi1/sdma.c:      for_each_cpu(cpu, cpu_online_mask) {
drivers/cpuidle/cpuidle-tegra.c:        for_each_cpu(lcpu, cpu_online_mask) {
include/rv/da_monitor.h:        for_each_cpu(cpu, cpu_online_mask) {
kernel/trace/trace_osnoise.c:   for_each_cpu(cpu, cpu_online_mask) {
kernel/trace/trace_osnoise.c:   for_each_cpu(cpu, cpu_online_mask) {


Rest everyone seems to have moved.
linux_tip$ grep -Rw "for_each_online_cpu" * | wc
     416    1141   23047



