Return-Path: <linux-kernel+bounces-688087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A3ADAD8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 12:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B39E17A2938
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80B32882D1;
	Mon, 16 Jun 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SLaYQj5F"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD9273806
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070311; cv=none; b=Nv9cP1b7JVelo6n8gpZdUmjWExk/l75o0Gx57RvBD4YS4U/Hms1dBn71ObNIBmdWAftdOz5ROjmlU2pNucBnQR8kFrRWLS20tX2UwSBFzXAdpuJ3Gn++tlMnquhC2GaEYqPacK5EWmmHrE3kDKELX9IsipXxWrFFc5XuMYFp5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070311; c=relaxed/simple;
	bh=++eG27sdjNKGmba1eHbJfrIWJAqcB4ygjN6cif1GOJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=F37If8DqtiT6mzoI28SiR/ap7eQZTpmdTREMeHXzNM1lVi+AfUwy7aDNjdkg755Lkyz2vsxyE4KwMhzp6pV+gUeOXVdoGnZytjUMVmpPktsiIdkR25Jh40NBR3I9BeprC8is5lCfbTH5mDFpvtQTYgAmgZ7/poRbRiAdW56+NLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SLaYQj5F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8RcXP025023;
	Mon, 16 Jun 2025 10:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0ISiqlgdeklg0xXzY7P5H11qqfuhoLzTN1XNx0iDv88=; b=SLaYQj5FwcUd7Fkz
	nVcDL4oy7JsNIk8h4D4ljzLxsZeqaGlKMyWIRvgaUgIbaIv9ms7RUw7iJ90t9AEs
	nSyDP9zqEsUX1FsXKYQv3yDfziMvz+AY1F6QgqNXnH0d2aEQhDoEv9XYcD+DFer8
	oeGoF/eX96okIzWFF1oXmIO6yaTXVAelFLcOUnVuuny4XaK+GPNVIftYlEMcJCfd
	eNJM/1Te4p7V00LmEQV0VWkKuEPFKR+eVYCjN4ublb5u2sp99HVWZdlBtkPRilAw
	MVqzDXiePL6+j1TRF7NjE+GdNlW2Jx9aU60jSz2ncxrPRmgnK47nMhsf/b/60io1
	Viq74w==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791f745ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 10:37:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55GAboPm025787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 10:37:50 GMT
Received: from [10.253.8.97] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Jun
 2025 03:37:44 -0700
Message-ID: <94b40ff2-9e9e-4eea-8a66-87d8976aeb70@quicinc.com>
Date: Mon, 16 Jun 2025 18:37:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH v4 2/5] arm64: tlb: Convert the opencoded field
 modify
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>
CC: LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
        Andrew Lunn
	<andrew@lunn.ch>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly
	<joey.gouly@arm.com>, Julia Lawall <Julia.Lawall@inria.fr>,
        Kiran Kumar C.S.K
	<quic_kkumarcs@quicinc.com>,
        Lei Wei <quic_leiwei@quicinc.com>, Marc Zyngier
	<maz@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Oliver Upton
	<oliver.upton@linux.dev>,
        Pavithra R <quic_pavir@quicinc.com>,
        "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>,
        Suruchi Agarwal
	<quic_suruchia@quicinc.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        "Will
 Deacon" <will@kernel.org>, Yury Norov <yury.norov@gmail.com>,
        Zenghui Yu
	<yuzenghui@huawei.com>, <quic_linchen@quicinc.com>
References: <20250612-field_modify-v4-0-ae4f74da45a6@quicinc.com>
 <20250612-field_modify-v4-2-ae4f74da45a6@quicinc.com>
 <3537a4ce-b5e8-44d5-a884-70a81562068d@web.de>
Content-Language: en-US
From: Luo Jie <quic_luoj@quicinc.com>
In-Reply-To: <3537a4ce-b5e8-44d5-a884-70a81562068d@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NiBTYWx0ZWRfXxL04GAagHQk/
 iEBZ6i5zu1j3cfjMK3KLHbVCqeDrf9/G3eQRUWTa19X7cTJXtW8z2nJIt9FPHw4MpLCdb+ZNbj6
 0xvZY710scyODKuCUU7fg166gB922eWjk2Ja904dbfhGzZnQfq9LpC9XH14esfAa6NQTLH0NSGg
 aP7qk4r6+3Npd7hld/6BaK7Sg9PGsqGAgnp5J9jyObQZgaK3vd2KwnLsEQ+HgRs2HKXJ8Ejrcwp
 c9/QC24nqe8dMQnkFnSOp3luLJsaU1zIaAaE9InlzlhUif9cwGyamJEBghnotr1/ExSEHnkgV0b
 ETz/4V2QaCtZSiflKcBnn69YZR61zRrj6Ape/lHYj7Z9sQFOvI/ur7TH5z7/tF26Nl4xJyqYVw+
 V9UCAFEgOjl0Ucmg25eMosVMn2Xs3tCGrymwDYob3i7SrT79VzWhKK2oZbpYoUZuqkHCllv/
X-Proofpoint-GUID: yVUHwgEeVxAwRXZvEU52f2yZasbGvHsw
X-Proofpoint-ORIG-GUID: yVUHwgEeVxAwRXZvEU52f2yZasbGvHsw
X-Authority-Analysis: v=2.4 cv=FrIF/3rq c=1 sm=1 tr=0 ts=684ff3ff cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=YgwN3AOMAAAA:8
 a=wkcNY_LD72BEM5X7UyUA:9 a=QEXdDO2ut3YA:10 a=ztR1XV6QG-NWxUt1dNgd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160066



On 6/13/2025 4:15 AM, Markus Elfring wrote:
> I see further refinement possibilities for such a change description.
> 
> 
>> Replace below code with the wrapper FIELD_MODIFY(MASK, &reg, val)
>> - reg &= ~MASK;
>> - reg |= FIELD_PREP(MASK, val);
> 
> * How do you think about to omit leading minus characters?
> 
> * Subsequent blank line?
> 
> 
>> More information about semantic patching is available at
>> http://coccinelle.lip6.fr/
> 
> I suggest to omit this information here (and in similar patches).
> 
> Regards,
> Markus

Thank you for your suggestions. The current commit message was generated
by the following patch mode command:
```
make coccicheck MODE=patch 
COCCI=scripts/coccinelle/misc/field_modify.cocci V=1
```
However, as I understand, the discussion on the ARM patches (between
Russel/Marc/Yury) has concluded that the ARM arch changes may not be
adding value over the current code, so I will drop the ARM patches
in the next version.

I will review the generated message to improve the formatting as you
suggested, the next time I use it.


