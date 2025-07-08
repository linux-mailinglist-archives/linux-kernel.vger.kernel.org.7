Return-Path: <linux-kernel+bounces-721896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B663AFCF37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276B2175F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022492BE042;
	Tue,  8 Jul 2025 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PaLiYB+9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074032DEA85
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988547; cv=none; b=ulSo5yxIZKhz9vUxbMX9a5906eatfyo7Wf4U7dO/3muKCjeHKw8IVAZmfpHQeQOZ6YXSEI/u4Pj5sllm7VXOw1TwKNnvkQ5Z6MVstCQKi0YR/Hb9MyGl/IRsumH2POVLOh8glbpoT8fYrXpIy/4NXl6p4Ef7Beil/wbZkisy8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988547; c=relaxed/simple;
	bh=v3QiLAwgJgyOMTcG8VOnoqZL5d47L+1i3KmT8SpcDak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa4wkyJOSAD6VZQx01H6a+QvBwR+qLRMr/4YxjLk+3uHzQJJgjqn6Jp1o0ZzDvspMFGk9/Z9II0wztN58F82s5HRDiNwj7omLpxpPQFOC8jivJUlyU70HW/KELarY70iXzawxxNe1txFxi1c9fxZ6N88gABVApkZSmS19o0jxog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PaLiYB+9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAcKw017173
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 15:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f2VkYsy8wJYahFxVTA7K93nD8ZG70Y+num13V84YJeA=; b=PaLiYB+9U6VBe6Zb
	Z6YD7vyUP0p8mXTtqP/KSfgqZoppbEvZV0wrg40L9oMe1yMbWORWzkUbn/9qnAuV
	wDsM4S/vYAUL4eOXe+eD1s0gy1ValTg4vQOTePXTF9AST0cnh2yxlOili05+KEhy
	io8Kvcmsx1GXMDKeVzMRaF/U+e6tSoWeQR+hYfLRovrGjqL7FBZm5R4721lxXAxB
	TjBEZDJ5Z76lQUCKr0iTNXqTUh66leirPv1wHEEQUVfYu1+CacKjw3nWaspTUnY+
	QM/0uRUCOtDFsJ7Fv7yXamhtBhqye7u7e0yeI9B6ZNkJJb9JAld3jR/vKeDCqlXS
	r/W6Eg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pvtkpssw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:29:05 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d0979c176eso45131385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988544; x=1752593344;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2VkYsy8wJYahFxVTA7K93nD8ZG70Y+num13V84YJeA=;
        b=JrkY3mEN+qOthyTj0x7KYYm2AIEXAa48wWTEFeWN9PevWEKBRFkvHH4veThz9/nVQW
         E3oR7gx24KJPxxbnLyAp3/7d+H5GBjf9mMEGm79RdRFiNwSKwq0StbAY9+utVR9iAODV
         zPaVzn3B0+Igo9rA2YGvE/sSY2q53uN1clEqgHSJIS7XRzJX7wNtwbFYx/4Udv+NIoX0
         3zvaYHIX+xo0gjkLa+iouVnE/GqOFfuxPpsUtoDSE9UE9vk0BOAGOcnhMikiAoPmCk2+
         J7h3J4Gg2xYHgZ7LJ+vgXDg/fc87piP3G7EUjEQxinGSpfjJeOxCQEtQy7jFXVY3NOnf
         tVVg==
X-Forwarded-Encrypted: i=1; AJvYcCUtQr544k+4e6wqfM1mc8+SwOvNo8oDYJEmBl9AXX+fXe158Ts+9Q8y5FPzUJZOsZLLYU9gNZCVuOECoDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqHymH8HTgKla0zLAHTEcOQbWASndhuWfLoXCw3APxIImA7JC
	3zBpzviul/5yrg2urUJhzTvaQ55KR3sinIESjoDdkTF3pTgjsFGBj1NUygItiFfdL/uqvxHUacH
	OdDwKIYYMr63AaUWWfnQ34JvyalzXoAcaqQMrcZ5gEg3BEWwBboxf0AEyZGsLAtL+2pA=
X-Gm-Gg: ASbGncvEu6x5ZZsqtc9BcaBZgZ/mOrbr0tGTZTYuljW1bsjQLhDenDoYAl07xpK+jgP
	O6oxYCEUg8T8iNOuedg7LZkXrz1fVLaq5Sf7dhpiufMupOU4X6B2UsX2DqiHy5QPvhn1pegMHQ1
	9UmaQwa9bD19FUoWtmgDu2LaVqkrbRYPFQStuuxrdVapE3R6OJiHFGkH6e+1AiEmkExmVbSRzFl
	ok+Pt3qiMU3dyDHGdQVRjoy6ZIq2O5/0HaYEohTUHoyhEKqAMxc9970bcAZKsn8GMzvbISCpOtc
	jFJfpBGAanxg0NymTWYRcTVj5/RMC4cGrLfUcI9inBPQAZglAw1RlMu8/y7o/hagt94/ll/M/Kw
	+Png=
X-Received: by 2002:a05:620a:278d:b0:7c3:c814:591d with SMTP id af79cd13be357-7d5ddb5ef03mr1007279485a.1.1751988543751;
        Tue, 08 Jul 2025 08:29:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIGLnfwf0hkf6haNlDbkMD8YH39A4+PUocC7CjST5W4oc1Te5ti4lqXAliQlmbnF2rJ0WVCA==
X-Received: by 2002:a05:620a:278d:b0:7c3:c814:591d with SMTP id af79cd13be357-7d5ddb5ef03mr1007277685a.1.1751988543250;
        Tue, 08 Jul 2025 08:29:03 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d920asm919310166b.12.2025.07.08.08.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 08:29:02 -0700 (PDT)
Message-ID: <9ae0d97b-e68d-4255-8ab5-18007763babd@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 17:29:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC/RFT 2/5] ufs: ufs-qcom: Remove inferred MCQ mappings
To: Bart Van Assche <bvanassche@acm.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
        Can Guo <quic_cang@quicinc.com>,
        Nitin Rawat <quic_nitirawa@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250704-topic-qcom_ufs_mcq_cleanup-v1-0-c70d01b3d334@oss.qualcomm.com>
 <20250704-topic-qcom_ufs_mcq_cleanup-v1-2-c70d01b3d334@oss.qualcomm.com>
 <3c8622ed-db52-46e7-86db-c170b4aae55a@acm.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <3c8622ed-db52-46e7-86db-c170b4aae55a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEzMCBTYWx0ZWRfX77tzEDNWCqM4
 tXFTqgQqzBMaVJ+cgRQV7iKkJ5hYOZThU3Xna0y+49x1drMmpMVwZ6vkwDAg5nneEQ/Z7FqO5YN
 gKCmNJNqSgvNVRO8+uWWKJBCmVABa0W8nSJntTajnVnVHug8qZfQ2q2Terzg2oh2cG0ZJRJl6vw
 1IHYnk7ZFzYaIUZA3ujXzybJ9RtA8b9ELbgkNepJjBaCRClRNp4jcU9iUZwZ1+zX8j9o4LyBSbn
 OT8wPvXJPbglQi1VEBxYW47CKR0FPw6tZzdXFjGDQI4U28ZrrSPQrWeQ4ez0Qw0HfFetTz+ub4E
 U3I8OSESiIkEiYJ1WTSwVncyAv+Sj2QhEBxwrDd/V7gR5RGbBTd4dQRwYfPlSnOU1NLrZE83YgB
 ev2hyIHaIu2R9Q3dCHgKWbhx0JM+vYQroSUp6yXLs1lvsMGDJ4bajzZORc70jfglzx6dbj23
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=686d3941 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EJ2a9uInbOJvoxFTTbQA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 0G-2XqmSoPr8K4E1dkxlnlQosZMFqbGe
X-Proofpoint-GUID: 0G-2XqmSoPr8K4E1dkxlnlQosZMFqbGe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 mlxlogscore=800 impostorscore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080130

On 7/7/25 7:51 PM, Bart Van Assche wrote:
> On 7/4/25 10:36 AM, Konrad Dybcio wrote:
>> There are currently no platforms with MCQ enabled, so there is no
>> functional change.
> 
> Hmm ... my understanding is that your employer provides multiple
> development boards that support MCQ?

The commit message refers to the state of the upstream kernel, where
none of the platforms we support today use MCQ (which I can tell as
it would require describing an additional register region in DT).

Konrad

