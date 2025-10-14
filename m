Return-Path: <linux-kernel+bounces-852105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B2BD82C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA6C04F97DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E9C30F945;
	Tue, 14 Oct 2025 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TZ9wiWkT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C92FD1B2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430457; cv=none; b=iEeEMEAzlmgoBHbhKXWL0muaiE77UVK19OxMaVmZhoagW4Gnn+9Kapv3g3PC5GhSnBO5+8oqSBxO7pJYhg3cAY5P38taI+dYWvLMdjep8honsWGoKkSreeJiU9Nc1NalntiCwIoJW9ecWjLkjJftepdqkVXH7oG908crkDeVhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430457; c=relaxed/simple;
	bh=63drt+Y0L2AmHZ2njRNv8YyUNEFDYX/MIBoZ/DyBZgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gz6SZ8VsyZ8SsxLXbzfo33TPtbH87ZKV8vXnyzjpp7W7bFyzegKm304ST9VgamZoLUgtBWIgU6K/Xy5JNcXVSVhS1p7YeN/pULkantplrJQGpHybGngWdsNuffQ2RsfERJq0Z4COQMTg+1OefG2O3f9YOJcinkQw9/a6PUenRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TZ9wiWkT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87NTk031481
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6wXrw/9FqovJoYHuRJUtoPyXQUuX2rF0lSfGJ0TL07E=; b=TZ9wiWkTxOeoXR7A
	7JCYYQtiFX8iQfvJW7tZ8KxpW2XVRqwi52e8ta+465Q+AZl4r5Y12d6oANGtkBsJ
	4a7EjjmCEhqFdH0fnsRoIZJNUMdUCsG88QGrLg71H2doLAocgwPt6Wr0Rv/zLHJY
	5wgUGzTdwXJZIrCVXA0jjn4He4hQW52TetqtybidipRttBdRWwZZnYDhwk8i+d0K
	wTywdcVmQw6eBS6fkpn79AA/VuHPk1L27R9yWdrI9HcsxMe9PxtSajOby6I36gqo
	9fifBVX2GvGOYJWhAROb2fk+lcNbG9vVA0KRdAqwDJbDV9Bg/UfUu9Mqtw5hPLru
	v3HEUw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qff0qq31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:27:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33428befd39so21251288a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 01:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430454; x=1761035254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6wXrw/9FqovJoYHuRJUtoPyXQUuX2rF0lSfGJ0TL07E=;
        b=LkHV31or4iIMWOZ2kB5j7f3/swU7KpDKD4PXEvOt2VTTm1rQ35XOOCe7cLUxMN8h4Y
         H4zebncKj449Xv7m//sGwltGWxIUbJTB5EfotxWiaEiZKuC9lM6ppUbAjETdvjge7Zy/
         0X9XBzG2FAMn2yqV5mPS5Uja+AmmPJj3gwpHUaYpYbD/890eIIRGOyJvLIBHBO/OHCQd
         gIdJ6KOqZ39y0rOnXaB4RWECGRXBMtpsWGEcD7KKA7DbqeyQYlyXsHyWBI+4C0CLgqzM
         iMrSzVHxIfozlCdIMCGx8KyusHs4mrNt1YCVEwMTLzqvuKTwgGo5QEXNhj6WqTUCta9f
         pQTw==
X-Forwarded-Encrypted: i=1; AJvYcCXvlw/WQuMTLpeXztZxlenwQi11kRx/bF5KwWgZETel4V6mYwuB+pBmOFbIQk64oNLJXUgDcHDRfaOi6Kc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw73rqz/CyzHDqpYRsNiqMjvFvHr9Lx5YLR5eCyglB2jGUOUxMm
	hMm4lR2i609zsfG0swqH2bf2MH0JkMkl48qYqIF1b5EEg9rV6OyWl9Jd9MrugtoH9JXFsaWzLs5
	6x19sDtLUpcNyGEZ+eDl9Zt0yapJjt3Zd/DA6cG8MPu9TInwAEKt0aBoKS6Gt/1pW3o0=
X-Gm-Gg: ASbGncsG47GJpmSR9l/lt+v+xaUAJ3wWUdOZEpC6i5wORo+jsOZHZ5xg7a/sVYv8OuD
	SJkAwMOqw7jSBBDO6MgWYKCNJc+Cb+4dn5nQNjQLEm2CZSxsYooqV3bUoMitzr5ie5QHR62a7rI
	z+fUshAMss4FEuSR9JWnHQYSsn3vxyoxAr0MQRvMB3nLSZHQHEkDzjmcfjdTgYLix2iqsBHfnXc
	sbTLao2jPnpH+7C682k0HoMZXQbHTSqMHcbJ14VUcxix1jWS/FrOBTdfp5NXVKDkonz6sGYzez1
	dWhHi+UygO5su3NtUQskWdx8N2Ag8fsm9S3DD7vbvL8u9jyV2Tb2r/GTLFtwkHbMGO43cM24
X-Received: by 2002:a17:90b:3881:b0:32b:94a2:b0d5 with SMTP id 98e67ed59e1d1-33b513a322emr32936929a91.37.1760430454065;
        Tue, 14 Oct 2025 01:27:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2qatucYyq+zixxTIuFLs9PC4U6NqhiAm3Cbok6ZrGfZvraa8sbxAwHtKleWsNsu2tad8Kyg==
X-Received: by 2002:a17:90b:3881:b0:32b:94a2:b0d5 with SMTP id 98e67ed59e1d1-33b513a322emr32936907a91.37.1760430453634;
        Tue, 14 Oct 2025 01:27:33 -0700 (PDT)
Received: from [10.206.101.41] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df916d0sm11863256a12.44.2025.10.14.01.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:27:33 -0700 (PDT)
Message-ID: <a4208d2a-e9ff-9b34-6477-54123ccce89d@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 13:57:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 2/8] media: iris: turn platform data into constants
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com>
 <20251013-iris-sc7280-v3-2-f3bceb77a250@oss.qualcomm.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20251013-iris-sc7280-v3-2-f3bceb77a250@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX0SKQi5oz1Ndm
 +hqFyAg4/Nyszo7kcvRwPuu7RLowgxi/sq7Ot7btxoPeA0JIgW+1MmDD5kBt+aHwGi1xEW9mrV9
 fYmKQARql7rVkWBf1n5gNWoTTzXSaLULi/Hjtgl1y/vkB9VQC/7zo6tMOY8+U7sdiUsyR56qzQm
 7nShDH4RMQW6lx/dTvfLNe1gjrRGQcfTW5ufXR1R1GsGln1XyQNORsPr8V1GL/Rxu82i7ry2Xhh
 33YxXB/aE+KfisfECv7JeMLrrW0pKwwDydB1VscX9IjXOSIIxVoKcABAX24RovR2+OYq7kmVc/i
 1g0Pr3h4gDaQMfnFxGGShw58/9SIAQGBxrFXZPp3JHtswWwNugy+csybkMwOHc+izzWEO3bR8AG
 1Pi24uni4vk8DlNSUA8OXCb8V+Nf4Q==
X-Proofpoint-GUID: C3qZQbYPBlUwmOWoqyBchdoYeNZanAOL
X-Authority-Analysis: v=2.4 cv=PriergM3 c=1 sm=1 tr=0 ts=68ee0977 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=5Kv_vQZlazJxXpBqwIAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: C3qZQbYPBlUwmOWoqyBchdoYeNZanAOL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On 10/13/2025 7:38 AM, Dmitry Baryshkov wrote:
> Make all struct iris_platform_data instances constant, they are not
> modified at runtime.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_platform_common.h | 10 +++++-----
>  drivers/media/platform/qcom/iris/iris_platform_gen2.c   |  8 ++++----
>  drivers/media/platform/qcom/iris/iris_platform_sm8250.c |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)


Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>

