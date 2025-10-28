Return-Path: <linux-kernel+bounces-873513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1261C1419B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7931982AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33144302161;
	Tue, 28 Oct 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZFcwfuy6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A92C0286
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761647266; cv=none; b=YPDNLFTjYdaaQ5YkZnySa+0XqXXqe5KicV0H7H5b0zHu6sM09Hw4PVvqXhNfEPpPV+dhwoAfZ5NQvIGipE05ML108E/0qssWA928umZQKjsbirTj2IfhezG0nqIhcqnaMJwQ84snIcE03HwMXsCB5YRnOgJaDGx2iUOApTFRtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761647266; c=relaxed/simple;
	bh=JRIjRko0iU+3pC4lIHzKRFyzb1AsTuYmzInlVTjXafA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3p8GFYgbqyVlYTgPxJH/khG90+7ua5WT+MPdGSDSvKym07+R60FPdKhefbYPCeQ2IYf46dPDrOptaVo9uCVWI+zyDykyMRq3LKn+on6fX64khKiZTNgz+zz+B58004Tcafm6lO9TFVQ7VN733F7av9KxefqTwZJUPLxQXfySm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZFcwfuy6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SA3Mvu1238711
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Jchqg3ozjDw/eWeqGxyZ6hjH+Z28PRs9xP9kxhdu6HY=; b=ZFcwfuy6vIKIFkxi
	imJGODU+en0pvk2iwTuHMBkiDpK+NbZNnIIUzv8VbZZJWQ2bh+y5M0Yr6xhcXHP1
	Zcc5gI3wLZ2blW9v5uWTnB3tiMiKDqdRHp10mVxmhCvWnfiiGCk1TU7jlFWkZ7ox
	Gq1c/uylZJKe8+Ipnh/P5HedI3GdVzehjj411CKRdBuOcdRsQh9CnJ/syKQ8EhZe
	XrOrSMhIc8oY/K3Cl3iKN6yVfb0jkezzbImfrI491DFBA/TdF+t38XNb2b1rbwEo
	8OPFO1Tkv5wsz+PoFcQ3vlN6j31GrwnbMt1EmNifhZTqJ1C83RCqr1TJ340zQrwu
	wGwOJw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2ur3g1y6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:27:43 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b62da7602a0so4118902a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761647263; x=1762252063;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jchqg3ozjDw/eWeqGxyZ6hjH+Z28PRs9xP9kxhdu6HY=;
        b=wERvZvi2vbq1jbRwIMWlMKHWRam+a/s2d2ifJVC/S8iMQgF2RrIQANqhFav7RJAI43
         PyA657ynFmMB6TDPYfdWZ+TsWulzvJBwM/BTKlP5j157qCHrknMbEn2oNE1/SobPV3cO
         /wIq4A0SCjSPJUeGhCilrUA9t3soucREWqDCUVK9Op+1hd0V9L9v2s9toyjSWL+UOI+9
         zr16vgJXbbFJGiAb64H3nKT59sF/PoINPqf1zsrQVfjCnUIGjO4BEk7Bpi0l470xNxBn
         YIiFR5bBzUGrHKYYC+/HjhePMa2xUGWDPLzG74sQxHOLGmaeWWOuxCuYizn2rMHYF0OB
         KunA==
X-Forwarded-Encrypted: i=1; AJvYcCUSi5oH2XCyG+WJmh3Om7lSvFmRZShcR5UrjfgfTOXakzlY474aRVcLwYt/K0VDgJltz2zqGjYX1KUKeLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhNoPUFYbk4jMx4EQapWJ6yJl8U6cwAhcae07mMO6KYIIpJV4
	6pqsE1mmz9Xqao+TJ3ctgfUR+w4bGtrvJM0uCWKHBYjon3TpRs8CwLAGmAO+lf95N29VIvwM2Zf
	Me45gwudyJmQOOtck1I4QQXs9DcGNAxIXtYAXMo2YgO12MKifxKTE5nMa+iXqrGAAFew=
X-Gm-Gg: ASbGncumafeM+46mff98yYaqhcxnZtqWb9GRW4JcRBOePsVUIVXnZRzLDwbWtkJzHCR
	E8ygAnUANEac4X6fhwNlwI2ST/gObIfYNMQYo+tlbgRaRfFsWyyYRSJ6q3bzgd9FVJkhdXEfnCP
	AHdh/cF61PP6aWE1U8eP8q3RaK86rj4SOFXMPgid9L2jGGYpgxKtB6WS49lglzC4GZt+YCv/qtz
	OBNGx2ea1BKzqpZzhma8JlVZ6G70vrqR8IwWFvrH6wgHhxvMPgdTJgx0ZK8/Jq2y7AHeYOwlTCj
	Wk0U6Rpm6AdFzi6TekDE1ETWk57GoeGuL8Dntm8dZrkRIgiYiPr/R1/jI0WQnGBU3BpwxAHtPt3
	wY8cTx4K306pcX0Krt0wXIWpac5Zis5Y=
X-Received: by 2002:a05:6a20:258c:b0:341:6c8a:5218 with SMTP id adf61e73a8af0-344d4712b60mr3554325637.56.1761647263030;
        Tue, 28 Oct 2025 03:27:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbJCIhZnhAKWXJ8GYzHMDoc2KKe52AUezo9ceNq2KYJVkwO1Il0nxGryU4eVO50BD0ZWwktw==
X-Received: by 2002:a05:6a20:258c:b0:341:6c8a:5218 with SMTP id adf61e73a8af0-344d4712b60mr3554301637.56.1761647262559;
        Tue, 28 Oct 2025 03:27:42 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed74028fsm11610806a91.8.2025.10.28.03.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:27:41 -0700 (PDT)
Message-ID: <32ecd9d4-15b1-46a4-a496-7619de771f39@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 15:57:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 3/6] media: iris: stop encoding PIPE value into fw_caps
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251027-iris-sc7280-v5-0-5eeab5670e4b@oss.qualcomm.com>
 <20251027-iris-sc7280-v5-3-5eeab5670e4b@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251027-iris-sc7280-v5-3-5eeab5670e4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA4OCBTYWx0ZWRfX8EuDn5lSoHSL
 qxHF0WW3wTta5CX1AxzLLP3+6Bu5QWvyUSYf9tlFqnxRBc64tD2Gr/R/4WPj2Cdu5ktEvCseXGY
 JfKnyNpbnJEaKcnanI+eqszcXxW9eFr+J0zMdpOmjyhTSagbi0/NxGBpIjIBSUG4d5HP0xJpMjv
 vvgbaN8O0aD4Rm4g7iVYkgYZypOlcug6FagxBPZMF00aaGAlEy233EF3SvGA8mzlwhxL0gPEft2
 +pdQvAynym6blo0DYuMN9w0nTg5ia2q9xHvxjMqvdWy5mcOGWzWZ0kuQ8Bw7tG3FK3WMWZLXgvw
 m8UEa/9+/LOOxvMblkQUbCSkBFjVuKrC1w8OtVtTaHcrKkhtnS5nNO8S2muvTHY4eivd5P/s1g0
 J9c1gPPn1cjVf7UGGANCnWuM80p/cg==
X-Authority-Analysis: v=2.4 cv=Jub8bc4C c=1 sm=1 tr=0 ts=69009a9f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=yKFMg8UGa7aLXV3ZWeEA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: pki4Z8IS5WTBQFTlEC_5oljwvU7v_v5f
X-Proofpoint-ORIG-GUID: pki4Z8IS5WTBQFTlEC_5oljwvU7v_v5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280088


On 10/27/2025 5:57 PM, Dmitry Baryshkov wrote:
> The value of the PIPE property depends on the number of pipes available
> on the platform and is frequently the only difference between several
> fw_caps. In order to reduce duplciation, use num_vpp_pipe from the
> iris_platform_data rather than hardcoding the value into the fw_cap.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_ctrls.c            | 16 +++++++++++++---
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c    |  4 +---
>  drivers/media/platform/qcom/iris/iris_platform_qcs8300.h |  4 +---
>  drivers/media/platform/qcom/iris/iris_platform_sm8250.c  |  4 +---
>  4 files changed, 16 insertions(+), 12 deletions(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

