Return-Path: <linux-kernel+bounces-762528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC6B2080A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05A9D4E2F75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB452D3738;
	Mon, 11 Aug 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cGBZsmHz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF312D29D7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912429; cv=none; b=G6UVtZFG5shwr6I1GdaVeckD0eb37wKxizMqZjhuIUeu9PRO804WAuudNHGOtKJv8xH1isOfsrchKEpJTUEwh5GpJKmH/Q4qzDUtUzioCzXCesNrRYJOffKBt8BoSFuBRG0gNhXrfSfr53mCDyXDGqh17Uj52xgeQ/o00JVgPzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912429; c=relaxed/simple;
	bh=6lFao+Zb7QpPd8YuHQG/nU2Wug6imx5UBEuBoNzE88s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPWZls/oahJMC3rMq9NR8HijkFMWKD7UA1/GPPCnvOw5OsctD/8gyIH7S5zikquzfb+DzQRLKHGMaQTRObAeomDXiMYnCUick8qoIiGn/K765OLhvzduUYO0mHoW9U91Pdh/81tN1G4EEfsP/DO4/392RTKVNDYkE6yg4SH9/lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cGBZsmHz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9d98c019056
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MI7eOWlhA8wMryLN7DmMCKNMSC+NaTn6BOa2zl+P8EU=; b=cGBZsmHzqQa3K8cg
	aNlqzxrGZNzagDvgTVYlPOUIVixavEVjuA+9qXI7IODtbXS4GIDclPvYIK788uOg
	dBr24Bb++1teD74Qpf6QJU/hiWfKHfDm+aT489OpTw+ykU6oMca+AvDKFpsHGP2q
	n41FnnRow9Cfn4x3BTaAzArfoNDhaHj1rTgkCsu3AkzE+JnknjUgJeMeBKk02QL6
	tr8surAZ6TRk9/DG2eJFK2dgp5VsRdlFQqqD3Dbl4/WXM3ZqTyVD/2il67Oo+UZO
	HcbtQ2aisCxfr/Pl3HQ4cqu4qFTMrwAEX3Y/aLrzWQOhs3c/sXm+r2zqxYVXqgTY
	0YHOZA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduv7q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:40:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b0c502e87bso2049121cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754912426; x=1755517226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MI7eOWlhA8wMryLN7DmMCKNMSC+NaTn6BOa2zl+P8EU=;
        b=VXX0ZNUXQgrIlSoueabXxRDKoyQwooTlWH4pNYViZTboaj46av2qnKnLOHGh2C9Rkw
         Zo5EFpn30i+6twZdWNnPlO0UTF/8K3ynpvZ+HQs3xEqy9RmYqdbSgfLQpNUvxNB+CrkS
         wp0f+73AcbcVbquh0bEMSpsi4EwRsn+fGwAu1Ma5Tfeco7Mds5dRqC3s4jHZIidSg70N
         RLXT1gEf2F6QaEdZaVQg4eD4TeIYgVzKF1jkQylF3sZf4x/N7cutozbEgScLFt1Je1QX
         pz/PWpOVlBzNTZQzA65oEF84BznABYqkHcytbdr2GI55gmZAVT38kTP156LC477rV55T
         NzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwMyb0ZVSU07qP/UnUoeSRbgYW/e/i8xb5Olh6yZdKeoX36lZ23ijY1R3DeUc2MlNqnpu8Xu2Y0gx8gJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2UW2kMWZUGM+qj2J/tmG3gr0wdLcJb9YO84hLjN9g097RnEBH
	GZ13kiAHZag5pfXuUWMLGU/HxXe0Kw3aw1SOUC3+zHUjjXzDRILo1t4wQ+Rl/ZwBwaEcvxvDNEJ
	CRjADVhjREVSRJDFMSlTLZ9pi8MSEw6gQ4lIs824FQJ26G1svu1YQqWTHy3QNLkK+ixI=
X-Gm-Gg: ASbGncuN3YUH6dCbt9y3HVDz8ZcMN8Rfe8YrV8G36jJFCw0I0Wvmwl4pYeNI+Md17DH
	e2D5/L7uNImp3B9RIsIlMvTzv2zKb4ILzckpwgi34VIN+qtQB0Z0Fsf+IugqnPnGElV6HAnhjsG
	JqPrdUt9YCKvzYmehIIulkHEsm8pgezPZ+ChaULRcGDTbZ0W14NiXH4rdT9eiScZxR4zw3/KdwF
	TC6WlkweeVsQvNJBXQPKVduuyB79cnROiPEIloQbD9/bX9WkUVMtjpMd4V1oOEPl6ZaI/DKUxMg
	8tArzqqHygGYoqP9vppBoMRdrD01CoFHzfR647dvXrDDw+S/KLeigIifTHTBr52Pk2vfqfwnJK0
	j3E7AB3S+K9dkcMcCiQ==
X-Received: by 2002:ac8:5a8a:0:b0:48a:80e5:72be with SMTP id d75a77b69052e-4b0bebf823bmr63470091cf.2.1754912426088;
        Mon, 11 Aug 2025 04:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIIAf6uSUuU4xC43V1tuCSDMHeT1D1YgDQ6raFA0BynMKaAicqiW+cWh3QOPFeReGv9rWEcg==
X-Received: by 2002:ac8:5a8a:0:b0:48a:80e5:72be with SMTP id d75a77b69052e-4b0bebf823bmr63469761cf.2.1754912425547;
        Mon, 11 Aug 2025 04:40:25 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f00252sm18323144a12.8.2025.08.11.04.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 04:40:24 -0700 (PDT)
Message-ID: <d7058c31-8591-4e7b-9580-218888c13738@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 13:40:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 vibrator support
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250811-aw86927-v2-0-64be8f3da560@fairphone.com>
 <20250811-aw86927-v2-3-64be8f3da560@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250811-aw86927-v2-3-64be8f3da560@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=6899d6ab cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=wGZfWhOSCpwZsoq7SDQA:9 a=QEXdDO2ut3YA:10 a=a0DIy2mVpJAA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: B3Y7ourQWNVuCUG_xIf1yM1dvZwaecZT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfX13/HOqGGo0hi
 FwpR5GmaI8HpUelZdiQjzeaOc0J9X0FFKVzWTICyyJ1+PP+W1SUweQTl9QInjCrnRrYjKYhYGv4
 iwkiOQw7iO1TthPvOQdDVdyJj8gxFG9Joyx+FqjRVnPUvgtKTxnUXq0LTdH36Q25m830zVVP+2w
 9j1X/qAbvcc6Y6hWgXr50/HI0EU7rYZDtHCairvJwTP8q2NJ3pI33BOnyMLpYWjlA/xhmhpF4Id
 MHcKCHvSaZfM1BXoY0uj5GPzAYmABhr9vKmM8/bVO2YUiBIBYnlx7hlPve+glDgTGdcYwzMSyD/
 Lduy/ZyLiWqGbsEm090RLVlVAjWTFeb+qz6ydbh853w84M20mjZZgcu/TBHukQclKe/vj4n8Wge
 kPKn7AFt
X-Proofpoint-GUID: B3Y7ourQWNVuCUG_xIf1yM1dvZwaecZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On 8/11/25 1:12 PM, Griffin Kroah-Hartman wrote:
> Add the required node for haptic playback (Awinic AW86927).
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---

I'll hit enter harder this time! ;)

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

