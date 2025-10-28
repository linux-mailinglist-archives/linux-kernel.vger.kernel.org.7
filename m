Return-Path: <linux-kernel+bounces-873650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961B4C1456F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3467B584687
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBAC3081A9;
	Tue, 28 Oct 2025 11:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yi0sBzHo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0446222D7A5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650736; cv=none; b=b5Rq9FAyaa6R1MfCc+xOuvkMJzAUYaeOxMcRIVPEhRejbsxZGUqPLw3KnI4VyWA5H6gVl7kFY0unXV56UzNCfMYu6bEipYoK0jhRhLhCUGomI+EMiGvqyM+TeNJQjyGFgVlFEPjHwikrbQMnupb2AVEtnLLFjt5em3uQgoRyZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650736; c=relaxed/simple;
	bh=aj7arItzhDrBhaPol0o7I8Tdjx7mOqSnlqwdibhKbgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DMY3jEaaEaKDsvm20uGOWHNraBnjd+RlS7WJ1M1D5bT4DgI/j35/YmOjmCLyYR+xdEONn35czCw6aOYnk3Gip8thvtrYCOFkh0Cvl1m8s9lPSyOfh0vtbVS7eaoQGlGHfq/Vtdoxfrgag4LVvQSDoClnKHXMwtYf6OCtZu2wrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yi0sBzHo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SBGtEi592015
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cx6xnPmLOnFqOjJjOh0mLlbJfxAt7938vxQ6lj5CpG8=; b=Yi0sBzHoHw9HbDWy
	6jAsFakvMULpOpjuLvKwPLN66Epxo0mJBaxV5+ObrReZ9zNjqhtD4moOsGOiQp+b
	9Rx6vRaz9FCAxuAzsZ1gW439S6H5p93dCgPnSyG1vqPsS1SbNRw090J0wUEBEy9O
	Nc6C2WNPPjbfGVsMcEmNqB+Uq6QA7XgoLAcGMA53S+mk3v58eEq1NI18vE6WG/SH
	vcXwf5SG9tuqSLGhuvw2c80yyTAG2DsJ1JCfeTelObE7g2KaChxhPVouPoZxyUwx
	OtJieuQ+MBN+DIdped5sqLFWLWjUpoGl3RQZs52iZ5wy6Bh3rGwL40ZRKoKuXwSw
	KukirQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2q5u9521-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:25:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-26983c4d708so44806245ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761650732; x=1762255532;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cx6xnPmLOnFqOjJjOh0mLlbJfxAt7938vxQ6lj5CpG8=;
        b=BinY0vLjc7TgyNu63zfT91VGikBPd+M8QA/V9wMZaknU3QDjNgmwuUvPd3ZXwMP14n
         hYncm1+wpoyG3vjRdO8C4Cp10IVDGwYuKuPAqrdNv/iR26ufonK4P5kWCnDLIrXzo6/P
         mhlhzFB1/l5U1ik97Az36rQOuoEUanQO86WbCUXEFfsya+vKRs5oHjXd/CeamvMGaxBF
         VljBzt/q0YjxG/VA2b7Y59fc62pBFdtiF0RtkUL4oP/D5jRAqy898aJDb8sU0GlTfsCs
         P4TT5iZKT9kOuVTCzsYkOs0AYK6AipZa2JK9W8f3etqafXZAoz6d8nqrldGbj5JcOdmC
         Hc4g==
X-Forwarded-Encrypted: i=1; AJvYcCW3q4qJ9RIwPxyiQnhQMqA9yW/Tvg9j7QG07ZTyQltcHfxB5PxMUPbTEBFtqTjo50K4TjxXHw0AichBPyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3amf5KOp+w0z7ejo1jR9IgiuO0nH/89hZaTw3DopdC7uF9tPU
	Z8AqRQE8oKiTJUupWvSrhbo+OsT2ZlEPCdLhD1iiebYXyZQVgNymHcRGSFQU70+Axy0GZg5+X8k
	jShomQ4FhyfylGjKN6V8g1tIsfnVMRXix7SKuyv8lYVc9bgqrMweZbUp+bQmP1ok6nkw=
X-Gm-Gg: ASbGncuRVLkXWvMx3DMHGfqc9W1AYvQc4DF/eSCCgPn/1KsnaB7NjIjmmE7ZMw4t0dA
	1kj2HlGDoVECAoqvyR5yBYcQbKaYRczUCxwWmNUJ4ffIrN6/u9vTowhgbzH84ltL/9KtPQfu339
	xSZJfxl6APPSJvuO+r/77KoF8NvT8TJgtfCFyxesyQUbQqhgOZ3ZfNZciBmxcoSFNz12CGvlxRf
	AC0aZq6BHpJP8gkZ3+0cnmTdUa2iJS5HGuRoXdybJs/Es0hMW0DgC2CpC33jsGZeZcEvY4xeCm+
	U0ad3s2hcA098XVInEwAMSdH5lRumLTC2or/pMT40HYR/QnAwyGhXwCgUibeBkd5kCwfRwcCucd
	jTH6t4GdZjgSANj9pz72FN/hrBz8Kwuin
X-Received: by 2002:a17:902:c94a:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-294cb5101f1mr40635285ad.52.1761650732541;
        Tue, 28 Oct 2025 04:25:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY3Jz2kyVL8x1xEmP9ZzU1xtZ8Uh8T8WFyYcHsG59aOo4z3gOrkOezjUjfrIwtGh4L53AqZg==
X-Received: by 2002:a17:902:c94a:b0:269:b2e5:ee48 with SMTP id d9443c01a7336-294cb5101f1mr40635075ad.52.1761650732059;
        Tue, 28 Oct 2025 04:25:32 -0700 (PDT)
Received: from [10.204.100.217] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm113375575ad.16.2025.10.28.04.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:25:31 -0700 (PDT)
Message-ID: <44f821dc-33e0-0a42-bf7f-e43fe9f00775@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 16:55:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] media: iris: Add support for HFI_PROP_OPB_ENABLE
 to control split mode
Content-Language: en-US
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251008-video-iris-ubwc-enable-v2-0-478ba2d96427@oss.qualcomm.com>
 <20251008-video-iris-ubwc-enable-v2-1-478ba2d96427@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251008-video-iris-ubwc-enable-v2-1-478ba2d96427@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA5NiBTYWx0ZWRfX3tyzMrBPdq6L
 xwJwH19sZlEs1PDvBXxKQlIG/m94z0jdWmASIcyoptSPKyy3SvFDQ5P56ZrXsuqwlXr6yjx9cUI
 tUj/2H/UvVN2pvpCvDnfGd+Luf1wdHvZJQjr1y0yl9Jrl0QDUDrY4Bhe0wIlnkoRzuZ/AUFr9k7
 BjalDyIdFqcWrbttx/sinz7/9HoIiDNX6vzT8pFPy3/u5G/dWGLKTUgqMIDXVg/SQNkqyxf/ppw
 CIvbeWel/cScWTcQcB06BBVu1W+IKk9FiYdspoyuavyQbzEHrri+2I2yyB9jkPn2mTmzTXmOpS4
 8w0hI4JZGNbJleuv+ffrYIpFyqYHoHOBoKc6ubDCq0WD4cfNu1XRHepPUTtBy7pF8b6oUkbzoUv
 5COVOwcpK1OMoS9j+mxqoAJFQm2F6A==
X-Proofpoint-ORIG-GUID: d_6JeQth-XbwHc1MOnfPdzKYmHUPYwuX
X-Proofpoint-GUID: d_6JeQth-XbwHc1MOnfPdzKYmHUPYwuX
X-Authority-Analysis: v=2.4 cv=c9CmgB9l c=1 sm=1 tr=0 ts=6900a82d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Iixf843HBMwuVF7wJXAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280096



On 10/8/2025 3:22 PM, Dikshita Agarwal wrote:
> Add handling for the HFI_PROP_OPB_ENABLE property, which allows enabling
> or disabling split mode in the firmware. When HFI_PROP_OPB_ENABLE is set
> to true, the firmware activates split mode for output picture buffers
> (OPB). The OPB format is determined by the HFI_PROP_COLOR_FORMAT
> property, supporting NV12 or QC08C formats.
> 
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 15 +++++++++++++++
>  drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h |  1 +
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c    |  1 +
>  3 files changed, 17 insertions(+)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

