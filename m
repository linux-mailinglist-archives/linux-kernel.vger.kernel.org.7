Return-Path: <linux-kernel+bounces-699616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7DAE5D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 08:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9141776CE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 06:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFB924887C;
	Tue, 24 Jun 2025 06:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WsUMJ0Ff"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F8A42065;
	Tue, 24 Jun 2025 06:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750747692; cv=none; b=nonDOokRdXjcZwuoZ41CriJYceMmz0xhESYWSOYv1SAHTt0f5EFrmnMRtRlQjtp7XQvWzl45bGL5Z9e9lWPhvoGCVeoiiJ3paYtGpEIhzK9xdu8wTyF2Y9yImCDllOWAG0rcCLOBR6B9sgZ1ifo34xAQ5VlMYtw2/7JnKtiHPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750747692; c=relaxed/simple;
	bh=/RLz7ZWKKduxKsdrG3WYD/VRMrtgaduZg/mTx88WVlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GCGf1A9Jasx6FSV38QJkbnt/15Z76fDY0cFX42NnM0uJ/e4QaXm7+5SnNpAVpfpzeChZSkEEt9FpdZRwEe3NZnIU8+KkqMeEyIbAFxt/RRmbD5mTkTKgpLs4f2sDvlf9B2QdjMNYG4h4XfsyVxBpj3EMX4oBkd1oQ6u6Q2ki/fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WsUMJ0Ff; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NLBvhq015282;
	Tue, 24 Jun 2025 06:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JOcx2mcdCS/K82vc/hHLsVo2PCuKIVAjHC3ol4pxKUE=; b=WsUMJ0Ffm/l44UFZ
	6Tcbcj8GcAxFhXPsfg5bkyTjAnLsnm2M9BYTE3JAC7cfpXV7O7sxENw7k78BVLCa
	3mAGVxvIW4K646KTRJT18WkJ1r1HMnDCpUdlTBrr5cMojzjTJ1sxVuANUAh/3xyt
	eQaQWaDXjV/ny0QTKyn4cebe7Zmw5asCSQTdeDeIZAiM6MLjInmhWAs+xpZdl7AY
	cZ9PO5LR3D1saR9bslo47MYaP/nP+gsfJH4cwW7Qf5c1ti01gtQ+2dVFRehswCN3
	JcWpCf0bvVM9YdOGauKSQwsTG7l0VVsioOAMmw3q4LMtTu2X/lvyGtHSknkFS+39
	GoXkbQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47evc5m2vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 06:00:16 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55O60Agx014606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 06:00:10 GMT
Received: from [10.239.29.49] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 23 Jun
 2025 22:59:35 -0700
Message-ID: <57d65846-66f9-4f77-8f6b-69f8341a5607@quicinc.com>
Date: Tue, 24 Jun 2025 13:59:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] misc: fastrpc: add support for gdsp remoteproc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
CC: <srini@kernel.org>, <amahesh@qti.qualcomm.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <quic_kuiw@quicinc.com>,
        <ekansh.gupta@oss.qualcomm.com>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20250622133820.18369-1-quic_lxu5@quicinc.com>
 <20250622133820.18369-4-quic_lxu5@quicinc.com>
 <loeqgkxkep54mrxwchvypqr3omogwpdukgvfc2dwuhp3ilxkhr@vtgxbgdoy2gu>
Content-Language: en-US
From: Ling Xu <quic_lxu5@quicinc.com>
In-Reply-To: <loeqgkxkep54mrxwchvypqr3omogwpdukgvfc2dwuhp3ilxkhr@vtgxbgdoy2gu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CtIR83-zCYzwwaRvx0MJPr9Wz_xy6oe5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA1MCBTYWx0ZWRfX6+1OKacwsGWs
 tnlIDrdE9szb8u78poqc/+U3EHn8j5Cup4jfpWqFz5H7KYqWUzL7i9ypyTlSdMlMWSggFTEZbb8
 mXUr+weHc3MYJhA3dxehjS3LEWz6wWuwHGoKW4Z4TneAd33EpeFaCwBZPLwXYR4DX6h+AJR/qF+
 E536b1SIdIaxdb7ut7EPCz5MGzfdOYfazli07d6sQBQhSH6GcAQidpVdeTZnWbF27hdGPQjzm2A
 Qb8JIGHk3ooVVHJe+aZDmTWLJQInCF7KXxjNBqxFaZQXFWpdfdQiFAYWRiwsIjk62N76jUvoCoW
 PBhcGmT06h8W8usgw3hrs1nqeH949rObgcpgP6DdDCYI3ng5mHRu1ySEfWXwwxvcuf2ZZBryJhN
 dL3MD3Bn8m70cZwTG4I7HOnVSF5dAA005RJtDzdUYlJIUJFe3oidONB+vIqEZcMFmIov41Fl
X-Authority-Analysis: v=2.4 cv=caHSrmDM c=1 sm=1 tr=0 ts=685a3ef0 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=d1jN1tAPt5WcxSkl4i4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: CtIR83-zCYzwwaRvx0MJPr9Wz_xy6oe5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240050

在 6/24/2025 10:37 AM, Dmitry Baryshkov 写道:
> On Sun, Jun 22, 2025 at 07:08:20PM +0530, Ling Xu wrote:
>> The fastrpc driver has support for 5 types of remoteprocs. There are
>> some products which support GDSP remoteprocs. Add changes to support
>> GDSP remoteprocs.
> 
> Please don't mix code refactoring with adding new features. Split this
> patch accordingly.
> 

Okay, thanks for review.
I will update in next version.
>>
>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>> ---
>>  drivers/misc/fastrpc.c      | 57 ++++++++++++++++---------------------
>>  include/uapi/misc/fastrpc.h | 11 +++++--
>>  2 files changed, 33 insertions(+), 35 deletions(-)
>>
> 

-- 
Thx and BRs,
Ling Xu


