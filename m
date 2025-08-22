Return-Path: <linux-kernel+bounces-781655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E910B31516
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCD75A3D44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23D263F22;
	Fri, 22 Aug 2025 10:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BB1Myr10"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C02D248E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755858020; cv=none; b=FDjc/MLmx7S8dv9pfI+QilulrPV+38ucC2C5HBS8yrxL4x9zrkZpUDQQ+nPsEjJjHwTyCizjbkwtseOOCFFfUTsp8o/T3p/vyvH5fEtHk1P5EPIDmLVYUiseVfm8ZjZyLqXJJDum8k775h9D1GiVD0fNpMMi4Gs3jko5+5LsnhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755858020; c=relaxed/simple;
	bh=b4BRNmm1LdC2MzYr6xK54HvOoIkn4T79SPIzxJTzBZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Il8k3qv7wKuAu77c+C2wF5np9oVodoAvz8L88meQDbO0dSpvNoYJWioEWHG4ZcuGJwEOzj9vr4YzBsHPjYCrfUunKdXVE0cFkHk2JZs7CUWPZCky5Cc14N2L8L0wg1q3JPWWgHN4ft5L8rFJfBCuk7VrHin/b5rJo68/kKNZmB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BB1Myr10; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UMvu028648
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wcwtoydceysfZ+QalYvQDHtC8HQIqAuICXIVQl1rdew=; b=BB1Myr10xlCwJWt4
	CE+8LDXgJWqYJyvBOIIoJ6b1DR50m6zYyJ6U+uvQJTIFBaFkf8yGLxHT6jOBIhh2
	ILiHlIntAQaFLvabDYSlVvQCz/rCXIJgvXY0+baraR+wWD9vuB3ici9pbEsnFPqG
	ogHqYMlUTa7bFFYFUZz7lkNXgBC3p3qVDRs1FOmTrmvV0PtaP5osoRsrFG2ufI7O
	oUjjvZPRgmQGH24L548BZGZ1Fci21TcNNKek05NjnrwhP0UY2ZJJowo2dcm1brUM
	kXAxl0l2qYAoQ5P+pCx9OWOkn6ks8dUJhYdTEzRjU4MO+Ww6RvvCk2pUnrtlD9WW
	CGL4Qg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52crv0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:20:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88dd1408so43665746d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755858011; x=1756462811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcwtoydceysfZ+QalYvQDHtC8HQIqAuICXIVQl1rdew=;
        b=s/awsrbGQtMdB2VlDox2msiPoef4nu/lM6qSJI72+YokRXxxGOJ3xxewC8Sf8/Vciy
         UrNs2CTDKL34U3PrYqTJf+CaJtNuQ+MSEfZGdKE60e+5xj/QIt+9JhnHwotJp3NNrwfg
         2Y4T80hK045K70EFyRnwjGUqPq/tVifTyLyjW3BrhUPM3hD8uKddkgMenB7bBuDJDxQh
         97UnYsDlAg3GHw3GOEucqFLtebF83y1GBPStVeC48XbLT2Up8JT83UWbdvPMEyJAdpCA
         kPdJFDSgYTatnuGz+ibH+akDIFuEjXDc9wIzcsn11KMvPu0k5eWmRfZXAVOJ00Leaa1I
         NKSA==
X-Forwarded-Encrypted: i=1; AJvYcCUpCGyaoZpFk2DMM9O852slyMUttKNZC3UlFWCi+booDddkBYdFkkYe9/wwW1TB2UpaOdPA+6DWvgUuOBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJM+BgsxIGjW2zevFPPu+su5xl9afO7f7q4W6o1AgKnAdZmuwt
	K2QOeLMJMUr3zzEjRQ04foM9s5Eyc3cIjletu3iyU7PGjkwjrI5ERzoWBouGmzXlreue2mP0BY7
	Ps9/Xu9f8uFqEgR+I4XYzPSJaRoUV594M0lUsJvRpMxpfaGImI1o9YIYbJ+9ZVUkP3p29jSM0t2
	g=
X-Gm-Gg: ASbGnctuotf4K2qOD3HG/KIHLFX9g8Xfx4OZEpmoMUmxJ8CcDAyM7nV8Ot5lTz8djZn
	ph+0SH5OCNss5PFu26+IE2DAECZQhnqL5P+63lKCcwlZ7M8QTa4xuSB8dc0WHGDiV2CoT82hhhz
	aJzC+5LB60Ql9zhwb81Uj+zmmLIdJ8yJFuNcY3BIOBzUn8S7ZBLkgV+hnKWMRuCgQIZ14n4Jz7x
	/YAd77/CyAUcLgmmS6wrrLoy7nouTmKXojU/bz8WBQORzw+RlYWagw7ngUt05YBR+49pdaO8QbX
	QisiB1qcD5+G72HP0JDnBaCcPGM4M/LxrHK4k9lcwnphtZIHcfUczUFEZsKBEBVAomk=
X-Received: by 2002:a05:6214:2b0d:b0:707:4710:a551 with SMTP id 6a1803df08f44-70d9720a8b4mr26236546d6.46.1755858011281;
        Fri, 22 Aug 2025 03:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoVZc7bCJ4naBD4rJSgP7PzSX5ebugI4tw56aD1euvzJ8FFfbMFF5VoeT5a6LEv0kJzKEt0w==
X-Received: by 2002:a05:6214:2b0d:b0:707:4710:a551 with SMTP id 6a1803df08f44-70d9720a8b4mr26236216d6.46.1755858010660;
        Fri, 22 Aug 2025 03:20:10 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c0777896absm14824527f8f.50.2025.08.22.03.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 03:20:10 -0700 (PDT)
Message-ID: <89f8bfd0-d8d6-45b4-bd06-d5507da258ee@oss.qualcomm.com>
Date: Fri, 22 Aug 2025 11:20:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rpmsg: glink_native: remove duplicate code for rpmsg
 device remove
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250822100043.2604794-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250822100043.2604794-3-srinivas.kandagatla@oss.qualcomm.com>
 <54moh5c4s4hssl47tabtlqm5mu33frf3x4k3fdhsrlc6abfltg@n6igz6vf5yd4>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <54moh5c4s4hssl47tabtlqm5mu33frf3x4k3fdhsrlc6abfltg@n6igz6vf5yd4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZJNUOFhvgWvFvwTml0ZS04Zcq2o7DrjF
X-Proofpoint-ORIG-GUID: ZJNUOFhvgWvFvwTml0ZS04Zcq2o7DrjF
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a84462 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VhFYbXtIDa7AXiK5D64A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX0JzG7jCOjWBR
 7XV6lYbg49gmtWirnZzbHMBOrSCJSYd/kr8lkcI/S7ZDi/0lUrhIlAiiPPV9TOyIiQeVX7/5T1j
 6MeY+t2yAg/5pT6osNLlJGEqB7foQdj65jNmwH1yReIpfV/1iHMrAcdKvb02MfTkKbigGLCRvYS
 plzO/fd9YrgMGLlRX4CWXTfDUTLvohaYh8PisAYFO6IJ78KeIL56bLvhTsd0G2gFV0mm7UapREa
 TdHYx/rBcdVvfiT+vXJbUsBJNTkXStwqjecKqBOMH6AA9dxMtOb9MGg6cWvl/j9rSNB3tcVfu7D
 r35vusrmNdfkCqxL/XRZN3z9Fa/CrWnqIcQBSByZycKGZSsTSmkbb+8IjEWDJLl75UC4ELwV8cF
 E3GO/4PFET7V8FBZsA/hYiw1UE7JLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

On 8/22/25 11:14 AM, Dmitry Baryshkov wrote:
> On Fri, Aug 22, 2025 at 11:00:43AM +0100, srinivas.kandagatla@oss.qualcomm.com wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> rpmsg device remove code is duplicated in at-least 2-3 places, add a
>> helper function to remove this duplicated code.
> 
> I think it's better to sqiash this into the previous patch. Otherwise
> you are fixing the code that you've just added.

I did not wanted to add new cleanup code for backports, which is why I
split this up as fix and cleanup.

Am happy to merge these two if Bjorn prefers that way.

--srini

> 
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  drivers/rpmsg/qcom_glink_native.c | 43 ++++++++++++-------------------
>>  1 file changed, 16 insertions(+), 27 deletions(-)
>>


