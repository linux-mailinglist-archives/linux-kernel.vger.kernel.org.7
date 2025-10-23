Return-Path: <linux-kernel+bounces-866204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE95CBFF298
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E1F1A02741
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A05A221F39;
	Thu, 23 Oct 2025 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iuESghfv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C31F5851
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761194816; cv=none; b=pZbVS1lCvNgw2JUJMw5opI25R1UcAw3lf6N8QN1zM/sZRy/ymHRIMd2P+xhWvyxd52fDig55/S6qVWgvZUAHPu8SwR0uYwIJwdhFNVNEri0s0eKOyRpSvErWGievqS/7hPPSZ/9b4j3vIeUPoymo+wA9RbnUfJPGDbP+m+XQDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761194816; c=relaxed/simple;
	bh=RQKtk6VRABQ+vBOTGNpTUlGbKB9xzSwEgDGBB7enF5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPTLTlmyFGdyNTyxMeOMu2mSe/fq92Rbds9wfoQzpNe0pwI7B6EDCbVTjANMfEX/RByT9rM0ur6kxIIaHuTANHaeZLIQRH7BOoz2K0k4KGwIxWESitQaoRPVjLu0ERsnC2hTwW+s5GBcIRBqdEIGEXrDkNDmFzc7/uhR86BxUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iuESghfv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIenQ5025819
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gk8IGEC2YqxXgoqIuJ14jd80rHVy4Sx5PMH+RdrI/zw=; b=iuESghfvwcO2UjYB
	T+Vz8dJDuP/AdctHTIXWLfq2jmTl7/ARLFKyrTwRPQAVnIteBHxh7V0lUN2EpxVl
	aRpFJW3fWh+jEw1VPPz6jHiLG8B6VTSyHbAVCyIx8JV8sZmvjt00984uJGiLyny6
	DcAEDQNM6kZ1r2gSvpSEHpaoYSKDzvbgx5E2nPgBz3BB7dCHEuyRq0/c+Npaj8lA
	ytNdYcx0/nElPsxjuYrlh6EaxXrEhprtkQIgceuYUVrzUbi8qVs6uYxkx1pCA64F
	5iZ+0FFkR27vp8rKbLJ6rfM5ENoMRlki0ZjXnSkin2QU8cCBaIbOb+XRVEj6bK7/
	9otZKQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42keuq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:46:54 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697410e7f9so10128665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761194813; x=1761799613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gk8IGEC2YqxXgoqIuJ14jd80rHVy4Sx5PMH+RdrI/zw=;
        b=ADHYfbUZ0nE5C4bciFZKuBM0Pp0i73Z9AptCBDwI81f3qYbPkfONInABzKk2myGOQe
         jm7IiXtiFEJRgtaAP6/oP0jziIfma/Oq3mw7bvCd1r018nZgz6MJvAbbh07vmJtnZDUH
         OMnYZ6Cr1O2833TKx9VQU0R+WYvwMJ61rLZQ/PAfYaDwE0clrrCxdPqH59DV3NeYDCYZ
         fg3sgqffsSVy16NrJmkpy0PpzBr0jk9sT6Hq1Q8IBABqvKGftCWomaa9YRszoYgcB+WZ
         EIm1ggQqQXjE8+oSOsxeY3T2EcN0n9cXwJeEhyM3gevySnWqQe6C6xdyCReEFEqnmNMT
         U2+A==
X-Forwarded-Encrypted: i=1; AJvYcCUP8e/vrmUfE2RKW9L1nOEE1bil4blFNKuS4ur1AXNmVx/oR4ybhjl5sTepKLNL57i9/NN9Blhf0RkyKYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuKrWmX9lAXhnjc3WLw3cSNoYXSdCDWwmSdBikH8u2+qyvaRDS
	n3xyHluQLul8gptV0aHBRSHvEM3SlvAyfTolD8cl4SnOhuZFJIC9SqP4CduZp4qs33c6Gzz3wjs
	Hen6O/x5gjT8pB1Z6D78NGtLxeICy0k5eiR+sBijBhlbx0GFDTAx3BRSQZ9AriuqtW8Q=
X-Gm-Gg: ASbGncuDaqfM2gJlOev2GEi4Dc5kmcXD5lquh4lyWCIgfyJzATxBG5MlbQDSOo+z89W
	22P6prxsbReICGDFpSxQllhM182POpDokiRUQw939RaAn0Qv6I6OL3QATdN6+MJuj343rfq0v3R
	3n+i2SOA1T7YxSjOgD7i57J9AnZmJ+BzYNjzwNRXAOjuKT+VTi0qCKTG596nJlLubXCybjFdhVP
	Bqt6A+Y0LLqtk5MPX8pBlWwr0MC8kC50Wt/MbGXHKiUZMODiXZnPg5tPVw6BppKG1MzSqT5wEeM
	SSi8+cGEd/zJIETTFp5p4/ZXkPVtsV1XXAQir4YOfMMUASaxjzKij5mXDF6jw+JAAs0+VISk2Fm
	rjVrVxLXohgQxDvhphGnzcTc=
X-Received: by 2002:a17:902:ecc1:b0:293:623:3265 with SMTP id d9443c01a7336-29306233761mr57706425ad.34.1761194813375;
        Wed, 22 Oct 2025 21:46:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtUb1Wy6VbMGMaIZJ2YrmZqxzkjXSfCmpKXsJsxh6/rcBZgAjsqgwz2PjE+JV6X78IUnifdw==
X-Received: by 2002:a17:902:ecc1:b0:293:623:3265 with SMTP id d9443c01a7336-29306233761mr57706115ad.34.1761194812942;
        Wed, 22 Oct 2025 21:46:52 -0700 (PDT)
Received: from [10.217.199.21] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff383693sm3389881a91.3.2025.10.22.21.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 21:46:52 -0700 (PDT)
Message-ID: <4831d12b-a42a-464a-a70f-e0e40cf4ae4b@oss.qualcomm.com>
Date: Thu, 23 Oct 2025 10:16:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: Bjorn Andersson <andersson@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
 <litd6qcxuios7uwwcrz55ea24kj26onrjo2aekouynsce6wslj@vatjbulg64mb>
Content-Language: en-US
From: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>
In-Reply-To: <litd6qcxuios7uwwcrz55ea24kj26onrjo2aekouynsce6wslj@vatjbulg64mb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: yvCLnqo1xOckf9NXdjkpRe1d-vLqkprl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX0//2g//DyKAP
 p/kaJPe96H3tf+0WJuXaoVsaoAROCRku9A9/LbzPbkUzL2wipqUls/v91OY0rQepdglE7aGMdbD
 +j0tVKzQ8dE0YZLHcR0WZWuDE0x5WEpHEji3n5YE97JP3IuYFoGvHJrUOCIRreXicrPUJGT4R9j
 nBM0LehaIOJA4qdlYbS3OrGo82gsKEXnYJmeX4jUcIps4dttY9UwmJSVMq55YEayk12VmyST8U9
 JBvkyvGDRVxdwMEjJ+PXtuWfMljONFFqfNd6+vWkE9ZGGfdoBdm17SwJlhXGFV++v0jjxEfpkNw
 ELU0+q2IF82M761M9+l2cew3+h/OrVY93UBIME0ORwUDnaHuPomVnsv29Im/urdP4mSpFG3Lvnr
 FKytCDz9ET+/8ZCNoaJJYWFeikvd7w==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f9b33e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=eVGerQaZic2NLa4W9s0A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: yvCLnqo1xOckf9NXdjkpRe1d-vLqkprl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031



On 10/23/2025 2:51 AM, Bjorn Andersson wrote:
> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>
>> All rpmh_*() APIs so far have supported placing votes for various
>> resource settings but the H/W also have option to read resource
>> settings.
>>
>> This change adds a new rpmh_read() API to allow clients
>> to read back resource setting from H/W. This will be useful for
>> clients like regulators, which currently don't have a way to know
>> the settings applied during bootloader stage.
>>
> 
> Allow me to express my disappointment over the fact that you sat on this
> for 7 years!

This was a dead API (even in downstream) with no user since SDM845/ 7 years.
Read support was eventually removed from downstream driver too for the same reason.
There were early discussions to remove read support from RSC H/W, due to lack of users.
Its not realized yet and all SoCs still supports read.

Now we have a regulator client requirement to read resource votes and reason to bring back this API.

> 
>> Link: https://lore.kernel.org/r/20250623-add-rpmh-read-support-v1-1-ae583d260195@oss.qualcomm.com
> 
> Why is there a Link here?

I will address this in next revision.

> 
>> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
>> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
>> ---
>>  drivers/soc/qcom/rpmh-rsc.c | 13 +++++++++++--
>>  drivers/soc/qcom/rpmh.c     | 47 +++++++++++++++++++++++++++++++++++++++++----
>>  include/soc/qcom/rpmh.h     |  5 +++++
>>  include/soc/qcom/tcs.h      |  2 ++
>>  4 files changed, 61 insertions(+), 6 deletions(-)
>>
> [..]
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> [..]
>> +/**
>> + * rpmh_read: Read a resource value
>> + *
>> + * @dev: The device making the request
>> + * @cmd: The payload having address of resource to read
>> + *
>> + * Reads the value for the resource address given in tcs_cmd->addr
>> + * and returns the tcs_cmd->data filled with same.
>> + *
>> + * May sleep. Do not call from atomic contexts.
> 
> * Context: May sleep...

I will address this in next revision.

Thanks,
Maulik> 
> Regards,
> Bjorn
> 
>> + *
>> + * Return: 0 on success, negative errno on failure
>> + */
>> +int rpmh_read(const struct device *dev, struct tcs_cmd *cmd)


