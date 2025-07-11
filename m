Return-Path: <linux-kernel+bounces-727539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC13B01B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685281CA5B13
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D51E5729;
	Fri, 11 Jul 2025 12:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f9svvUfD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B043228B50A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235879; cv=none; b=Gbx/M7BUZhvhKKU9RvVJIQDcrnytbnk1lDuW5H/x9k7h7rLvFEY5+bYSdT/gyR9m7HWoZuWgdY6Klf4sIrWLmrnjxJ3r3AVN5ZT8xDA9cri3av4elhpa7RfLqxvNg/8hd68c9jzN6T4wm01Ir44i+dExhCFKj0C8JlyqFgDhcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235879; c=relaxed/simple;
	bh=20yEYpgMk2k4hfbLWF68tB2yj+fPDxYnbRbzutQZA2E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4U9WK3cGW/XGKwmfObr+RXB6k/uPRZbr2RifTi4R+2l6Vdhkdot46Pntp5Vzc1p6u4J0ay3+7oHaGYSYFTITz8aOL5Vpy5QYQ6jGFBD9NsOVo7bdfjAj1DQBiqX4eePM6dShagDht32fQYIKjNRFEq22CS99n9B6YWUuMV1OFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f9svvUfD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAxb02012021
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	E1hO5ND6o1S4IRbGj5wj/0aZsDaznogj0eIPmth2a0c=; b=f9svvUfDp9Jnkuro
	/Otf52GwrL6hVPRd9W5oQmoDmEYwa21m/RQqDUHw5OGpbuwno4jCiWK/Kc8e7Isv
	O2m2Ryc+idFGStcBUEQR5p+IWt9/VmY6oA/3PliR2cwLxoOjhHj0FkB1y6+JcX3T
	5F8WUupJkLnggtGntEnJcwZFSrs42I0R37W00CpY6tY5L9kALE6v+IIM8yBqfQDp
	/karLPWu4A0wufUCQ6GAliMqT5LDws45/59sOVF6+7Y7CjpXyai5khQYLGzh5XMy
	66JtVxS0330kRMHJNeExIsRyHrWsaA9Ez7ne6yEeZEtPFBcDNMND4XOG9ECPWgp6
	eP/lOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47sm9e0ffa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:11:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7deca3ef277so20219785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752235875; x=1752840675;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1hO5ND6o1S4IRbGj5wj/0aZsDaznogj0eIPmth2a0c=;
        b=PwQT5XYZB1C8tOPCDPP3+btGKDitX4cbW+NmjWgI6ugF4qmaUKptaJy25aXUbe+FB1
         wYk03nh/6ddasVHjl03DHAA1HmRps3VueCqwmuhzGrkY2Lv2PPMs0QnRRBOtrLtwlxhO
         uIyBQ1w7TWf6VTlJEM+0nnKGNeD3Fb3w6IVQEB6dfdkaNcHkK6xg6rH4o3fhIFSEu0IU
         a/Bs4UoYW5Ycf7N1KjlBII4X1vJMIsPRZB8oVH+UegpDfVgviGrUSSgouGqCswwnTPjW
         G5W7O8kdKrfXrqxEZqImbzkTqA486dAiP5QLMweaPIJCeGUTUdfdskkhT+OMo1GKS5oR
         xomg==
X-Forwarded-Encrypted: i=1; AJvYcCVvkWAQK5ahxf8Ikp0+Y7Qa7SrA50mWbAmQvNdTs3ItD3geWKqGRPOrBiTSLPqHsZC9QENUvUz9/JyWqwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCP2dcwY9qkau+j9pZW3fOre8rBg+s3oLNjcevU83u3sDC7UWE
	6Fk+PDmUe01eD91jA/4VqrFzeB5e2/IP0gqmx5nPSv5GBaAsEm4YWWMuVCugaPz5frEvRxgJo+J
	KzrFk7c9y5RPWzPB7zJEq21rQjpbhTKIZckIq5SJB12DqwZ8ENqfuLYRMGZWRyLXh1WA=
X-Gm-Gg: ASbGncteegWwJkYqXrC/T+21UBnbEOfh2XgONDlIXJyPVlUAUaztRHWJbb4ZLfZ6Jux
	WmybkJ5lysPJDVndaSCEW8l76GOAuIY7ntSxYr+FkKaDxlghQiSpB06QnS/+55vyWbwnnV6wbb1
	eV5Wi2MCSpVH+6X6f79gca4PPrU5oh3XFqqAYkbsKCOJt3+tdt6XFTb7IwjWXyNcrn+DaNdizhP
	W27DczfIk4FYgCPt3by/Rf6jB+dfrdDR5VLywZBsuyxCyNIgUcmJKHJO5jOqStqzRc2xmlDGjYM
	z32Qy+MvYCxQ/7701C8fICmcVuApwG9JtXVKuF/SSNxiZZJ03cQcJn0MrljWDfH3QbtnPM5gZfM
	bEEt7siItxkEHGKNuVPoc
X-Received: by 2002:a05:620a:448a:b0:7d4:4372:c4aa with SMTP id af79cd13be357-7de99b58108mr141907485a.8.1752235875188;
        Fri, 11 Jul 2025 05:11:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG75AwJO8klriW48siiGrNDo4BitXOJrFV1MfgzRcCNWaXRSKsT3osDC+MWRuxa7QZti87jFw==
X-Received: by 2002:a05:620a:448a:b0:7d4:4372:c4aa with SMTP id af79cd13be357-7de99b58108mr141904985a.8.1752235874558;
        Fri, 11 Jul 2025 05:11:14 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c95256d0sm2135423a12.24.2025.07.11.05.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:11:14 -0700 (PDT)
Message-ID: <3cd5864e-e6cf-404f-94b5-b85866086d76@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 14:11:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: socinfo: Add support to retrieve APPSBL build
 details
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250711-appsbl_crm_version-v1-1-48b49b1dfdcf@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250711-appsbl_crm_version-v1-1-48b49b1dfdcf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GN99rqwR0iPs6ULe2dGj5OVmwrlofJwS
X-Authority-Analysis: v=2.4 cv=W7k4VQWk c=1 sm=1 tr=0 ts=6870ff64 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=GUEbe4ff609SwjsIVCAA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: GN99rqwR0iPs6ULe2dGj5OVmwrlofJwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4NiBTYWx0ZWRfX02KaqCD/+Ost
 vpaFnHt7kcMPXWnZ7fveZHtNRlNarux4GbbkOxSDWRuXCFPAsFLWL0/IS3Zrc3FJ1MQ5aV+0qsY
 m3xryQR6FT3McxuzVttMJFtgXzDAxR+ZkN+QjyBOwegsaDINbRynXvCPFchf7F9rkzP7cJHdIUe
 pjlSIGklQB5QeDPvRJHYyqsscb35L+Gx26jzNP/O1nFT5tmKPUykitJ3eiIAhm/J7ERw9HnI2xj
 itYU/DmanIiSk+yx4QBkD37VcWlv+KLNZgSxnN3jZTHLeBTk6GAf9QzzD2SZBh/pmqtoEl5FnSr
 tUGRLQqh4k/WJ7lnlw9kfh76palwpZy7Ppve9iYeukPqJsy9T+cyKkWMqB4sJe0ptoww6E2IF48
 9bRAQgTtrZ8qQmhPtJjI6lZs1//QG3wbDYM9dzWrwY10Ab5MCxbTF/s54MvbNPKoztsk1Uwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=576 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110086

On 7/11/25 1:03 PM, Kathiravan Thirumoorthy wrote:
> Add support to retrieve APPS (Application Processor Subsystem) Bootloader
> image details from SMEM.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---

Can we expand the driver with all the known IDs at once instead?

Konrad

