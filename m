Return-Path: <linux-kernel+bounces-722010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E02AFD14A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123F21C22705
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1A92E5B13;
	Tue,  8 Jul 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTmkHCVv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762511714B7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992369; cv=none; b=iSMfE36VdTBgfMVkh/mJtK60015EC3x2slbZulIQZixP65cz7GHOTiutIUivlDrU3PaLvmpE5x2KpQP7E/zBHRdTocy4vJC9b077kZ3uupriIaCf9KrfH8qOF+/mB+m9u5iq17Oc9wrOhHKC5QP13QgKtdHRr9jaU+k2JsQjxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992369; c=relaxed/simple;
	bh=UArFT/K1nPlTDJiWQnFIAlmXUzoFAJFWuniA93+0gjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DcxzBKqMmgSoST9sTDf0APyrRIgIn14Ipike22Si77Xup14WH/YUqDzIAGKEfI5T+m1fZXtUBITvdCYfRXxgji2G+U3prQZ+Z18Nqqi+u/N6GC0whaEoX0EAtP3hYeDnepOuTsgLbepfZ4LOD28UXyGkQ9sH9R5h7o87NN4TjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTmkHCVv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAEoM032668
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 16:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TA2vLnQ8qEkrvWVMIaoxqMeWoxg9A2VtG7hX+L0UhSQ=; b=cTmkHCVvcKn7KmjP
	7aMsur5qvUNzNcXqRWKQ3FV1m5RYptT7LdRBfTtaj45/KLhRVEyYLEG0kLFrWAOh
	0Pn6paAxU214tf3LYovk2Jg2NB5vFwuMedDWPUNNryTAGfg5eSX4zQRG2IFwYSN7
	eDb1XKxVwXvIbttCAyop2q2fAMfRzC3CAR/wnG8JzyG6w1QbPdMlHBKkpJWxwFfY
	t6vpaIXXlcA/IkHTWLN1JB1SQFJrt+UkwOXtEZtcM0czUgzxUtZkeSwY+h2tSTHU
	ScHaXq0Id1RM5kRTq+I9hB7jVHKpiRvKJBqpYg9OYVdADtpLJ3zXjcM9ydDLFeDq
	Y+HtNw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkqjj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:32:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d41d65f21eso34937385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751992364; x=1752597164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TA2vLnQ8qEkrvWVMIaoxqMeWoxg9A2VtG7hX+L0UhSQ=;
        b=HcFOFZ4Xsy+jINHrPoURgGdGOdCSSsvdy2U7PGkWvdibqYEVwiCFdvVUZqDZ2zR9Fx
         Enshws3tJItLGL+/D8O5+W6T6kaqNFd9FdC/sNmoXJOMl9ntQXCfE7JACu08CTKcqCwh
         hqAfkfUapIgfAkv5lVL082LaLrDRE6dwv49QKLibQkAAgzR04aj6Tihi8NKhNS2edcqQ
         6mh8wPf63ZzW63+LX/JBpyM2hQfSYSsFF4eY60XoCXooQutBIrXtBTu9SVyDTTviUkrg
         gFZL3stoACl2L6vf3IqsL3ficVxrSOo92yH5EBF9JPSEq1xW5Gz2WdaIgxXSyT6vtOHf
         6MFw==
X-Forwarded-Encrypted: i=1; AJvYcCX690l/A+4UwPPKpuSDf02yZfl36RR3Dc+Kg7xKqkRRMtjSeXdQhtHWjZQDhOYPKqEVdmGUGgGsOPGUsJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySxcDVnqNh8PhGj+uHoMuhR1yJkJFRThWvxj3SXsmm2MLA4jtz
	KmU37Fev6NmQJc3S0lhfxD3JCC0nEhqh0z7s+MiHx0st1j/Z7zlEv79qz31QBTkoheh6SGshB4n
	TfxNSxcs6WF7+DZzi9aZ0hJDEugraUcEPB5nExytd3xvKobBFaxO0BFejGYRYbDVRM0g=
X-Gm-Gg: ASbGnctUGOoKtmXESKO/8XKKNbJEQ9BHhIRebmnWeCoC9d0/8kyse4sJT4F8w47f9oN
	SSvRwCHkC3rd8rYb7MvjcQIaO3rXyekLkpQr4nx1RYUsW5Utrl5dPzatOa6FXypH0q5AE/ddB8q
	udSHgibCvUt+lV4o6tXSzWMs3OtI8ptLkZ/6ip1l4F9xwaC4RMrFEaSWRC6tJDRECtRnrwOOj/5
	Rv3VMe9wy7OQ3DMn7xM/pocJpNwWA0ZZ5cDuMbEaJwvXG4X4u/tNxuwdCKRWfYdf4Sg2diYWXEu
	575Hboqpp/8vVdmsJJ2sP8hQfMfNZhh/IdL/z94tV0lTpalBnUdIezd64hfyLhyS47iiNV5XTBD
	ko+I=
X-Received: by 2002:a05:620a:4710:b0:7d3:f0a1:2f3e with SMTP id af79cd13be357-7d5ddb31bdcmr940388185a.2.1751992364319;
        Tue, 08 Jul 2025 09:32:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsCFvoBAs8YJH6fp9eQtKsRuq1lo2bD+F8rQZPXJ7oJTlCEQ7nv7k9KIkw5nPgH4kxOBgd7A==
X-Received: by 2002:a05:620a:4710:b0:7d3:f0a1:2f3e with SMTP id af79cd13be357-7d5ddb31bdcmr940385985a.2.1751992363651;
        Tue, 08 Jul 2025 09:32:43 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b0336asm923512366b.115.2025.07.08.09.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 09:32:43 -0700 (PDT)
Message-ID: <e99c8094-68d2-490d-8ffc-53b601449b08@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 18:32:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 2/5] ufs: ufs-qcom: Remove inferred MCQ mappings
To: Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Bart Van Assche
 <bvanassche@acm.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Can Guo <quic_cang@quicinc.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704-topic-qcom_ufs_mcq_cleanup-v1-0-c70d01b3d334@oss.qualcomm.com>
 <20250704-topic-qcom_ufs_mcq_cleanup-v1-2-c70d01b3d334@oss.qualcomm.com>
 <7cdpetp3fuxpu2eeqctc5f7kytfpvoquopfsr7ea5non6bo74z@pu45jowjzwrt>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7cdpetp3fuxpu2eeqctc5f7kytfpvoquopfsr7ea5non6bo74z@pu45jowjzwrt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ABOHeSnx741SQIywx-DtmUPkg1kVFsrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE0MCBTYWx0ZWRfX5cTeZb/bBQf3
 3MqCBWxLE1vzXWhn/JYDkG7WZF5KlpUceJNui5ZGlhRRZaApwssPFqcnuBn4Mtp5yaO4AYyPjDU
 RWSM+ABGBh5yS7hsmTVof5RmUC6247HU3TzpzQsF51KXiVWVGGycmvYjsnmYvGw61wFnFGV1lb7
 ILJ+zDOv2AODEEKqmR0STpBjtQonriaoEJ33nXiB4zz3XF8De/kcs+WvcWvrU0xS/16/c2dKkj4
 UoFgkCwsb3GzEdrzN4+AQmWtnx/A+3wXP31F/9cxF+efBZwjQ4rhsJUWG97WhCKb3G6ycCmXPmS
 g6kxqObiz/feeN227nu2z3X96vV4Vrr5PPFB1M+J6Ta9fkLgj3955XFaSfyso1/NxUn5Tx8DzlN
 JYOaDHH31WdkhZ7A8iJf2ehofCcYs266+Vdvc4as4n1WHF9rRltw/2GAteZ5Fc2EQwZOcbGG
X-Proofpoint-GUID: ABOHeSnx741SQIywx-DtmUPkg1kVFsrh
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686d482d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=keaFY8-lOGZKNXLQRCcA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080140

On 7/8/25 1:13 PM, Manivannan Sadhasivam wrote:
> On Fri, Jul 04, 2025 at 07:36:10PM GMT, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Stop acquiring the base HCI memory region twice. Instead, because of
>> the need of getting the offset of MCQ regions from the controller base,
>> get the resource for the main region and store it separately.
>>
>> Demand all the regions are provided in DT and don't try to make
>> guesses, circumventing the memory map provided in FDT.
>>
> 
> IIRC, during the MCQ review, Can/Asutosh justified the manual resource parsing
> due to some platforms just having a flat 'MCQ' region. So they ended up manually
> allocating the rest of the regions based on hw capabilities.
> 
> So there is no such requirement to support those platforms now?

I read the spec pdf some more and I think that this series is wrong
(but the current state of the code needs improvements too)

The "problem" is that *all* platforms have a "flat MCQ region", because
the UFSHCI specification mandates that. We have a block of:

----------------
| SUBMISSION_Q |
----------------
| COMPLETION_Q |
----------------

register subregions, repeated 32 times, each block being 0x40-long in
total. They're at a fixed offset from the UFSHC base, specified in
MCQCAP.QCFGPTR inside UFSHC (i.e. ufshcd_mcq_queue_cfg_addr()).

then, we have an equal amount of

---------------------
| SUBMISSION_Q_DAO  |
---------------------
| SUBMISSION_Q_ISAO |
---------------------
| COMPLETION_Q_DAO  |
---------------------
| COMPLETION_Q_ISAO |
---------------------

blocks (although these are allowed to be placed anywhere). For
reference, the QC UFS block looks like:

--------------------
| UFS_PHY (QMP)    |      - 0x4000
--------------------
| UFSHCD           |      + 0x0
--------------------
| UFS_ICE          |      + 0x4000
------------------------ # "MCQ" start
| SUBMISSION_Q     | x |  + 0x20000
-                  - 3 |
| COMPLETION_Q     | 2 |
------------------------
| VENDOR_SPECIFIC  |      + 0x20000 + 0x4000
-------------------------
| SUBMISSION_Q_DAO  |   | + 0x20000 + 0x5000
| SUBMISSION_Q_ISAO | x |
-                   - 3 |
| COMPLETION_Q_DAO  | 2 |
| COMPLETION_Q_ISAO |   |
------------------------ # "MCQ" end

(at least on SM8650)

So we can't just map the whole ufs-adjacent region like (I would
assume) the spec designers had in mind, as the ICE is expressed
as a separate device and we don't want to overlap-map regions.

We could maybe map the MCQ region in its entirety though and rely
on fixed offsets within it, promised they won't change with the
next platforms.  I would hope that's the case (so we could simply
mimic what happens in e.g. ufs-mediatek), but I'll ask around to
make sure.

Konrad

