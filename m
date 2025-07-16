Return-Path: <linux-kernel+bounces-733912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64485B07A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996C9189B2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0119B262FC2;
	Wed, 16 Jul 2025 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2RIXezB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184FF273D72
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681626; cv=none; b=LC7+KbGbyeL9wTTM9EzMfstEKHbf+uqZAQrpQl9Hj1WyR8QsFQHrk1PTLD3cdy2muxnv02py86wDjrNmFnGDd3gTDREDjkOAnqBO4Fl3JpRWj3MGeZSupNZupv9B5dVlf6i3u0OAaWwvkA1BGPa7XhyEcwNkQKO6LwvOHI77wUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681626; c=relaxed/simple;
	bh=ADfJz7MDETMJX4ewoMWeIUjHHd+wXJLC8WGJglMDlo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MhFY20ikVuLoxy7vyr7xKdCJO2osSg6gxDVnZSA9QaMfDflB8nS0puE+hB3d1lHsT7P4hEAytrITXsNU23LSXoEXYOxvzI+6yxEY4tztZtojmS/J0BLcfDYg7WNx7oFZGRNQoFhM+unJlB8JtzGTY3SmgFTMn0xjP6ZprVe0N8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P2RIXezB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GCsow9007299
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lj+0IuuDHDUmFIdwpugsUGXQmeDRIR2QIraen0zZdPw=; b=P2RIXezBtOZUtoCo
	dCu0E3V0aCFawd4kNaX0k+sNp4yFzOd8fmTgSDDzD/YcO9ct1P5oMVipzHc+ejuj
	cqpAuxQ60o2Qirb989CUCowLHUuOsU2LnAkjT+/jpA2oq3aX1i9OPkEkM6staE1A
	Rd8G/bNp2J/YTcJvO/fP7LwMGaiymm9rHl0UJfg2r6eQ8wL99wNhuCatfK59IznS
	9mJfP5nipEAt3E0ET6lzW5nbm5ITCF7M8whpvKlVFIfUEA/SR5Pe6RD3cPCPGfyU
	eSiKN9BbJaUOFvaSjVvi/WOXk5fVbOnUVyP7AKt0ZqRBecraELBQ0rkFvJiQwJIU
	cMyDSw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wnh5vsxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 16:00:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ab716c33cdso194321cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752681607; x=1753286407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lj+0IuuDHDUmFIdwpugsUGXQmeDRIR2QIraen0zZdPw=;
        b=enizQL6ndydciK0NxlaS6u5lpf0xyOKskZUCvInxwha7W7VIsZBnpn2ZA2j9XQcGHn
         Tk2HquQTJdFIdPSXjYvS3hZjmqz6wRe6uuVGeABNOsXhZCS+8tUkRYsjUaiKKiiv4iXx
         Fiq4HTTOqq7Tlx62YIXkOvgtJ+p+pV92/c/mI578QwoYq+RKguthYYbrASnhH6dClrSm
         5o1ZCSnbUx08zeCMhxq0O3xctz0IiBqYGXKnkM8fFgapqr4ZMTYl3f68vSmNGBUBk7yB
         r5t3tvNUk6byyMB2480nr9KjWFiQ/1AHnM+NpaJ9zq93mzl1Ex6HAApDGRpnXhq/n2Um
         TEig==
X-Forwarded-Encrypted: i=1; AJvYcCWfcEAcFcIx4QobHryGuTec6cH03W0ql2b3FujuLEKXJ0othIqprI9xQOtjprBLuIzc6kT19L09/jUWpv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvQY6bD35LJmW/f0Adhngh9h/vN8rvduhtwyaZ74+3om5gsvu
	bbBXxLnTPVV6KsUbclct3PfzFabEugzub7eUSQFIDgAbe2OGG5zvDTrdKm8JJwj69V0UDESTdJn
	wc2uLzs/mVwF7qfhWTd9S+Se16fJRwxrD6FYfikE6b+WR3eswyFXzT5z27ZK1mat+hyQ=
X-Gm-Gg: ASbGnctaGEQO6ye7WO0/oGAy2k0mn7YKlHR+nHff8M7dNIt4A53aQyONeoFaxobQvqA
	wHe5PWtusiOqOXUfr9lEfl4L/ve80MbM9VCu7z22n09NccrxVjuoclCHs8+bJLpdhbA1iKUEs7i
	F35WiYXF9HzDqgVYAx+YpyNI+8fhihXdfPi7ytb8ib/tYZjK/VF8GyRLqQB3m4ixbZdbQQ8xYhp
	HR8nB4mwaE5wQp295QPPsgcPU3xoe21H4FemeDRr1UF9v05PKaYphdgmxKYZBupnjLNXItFEPIt
	uLrcLO82RfQYjDgDYGEwQGNh8I78qsyfXCS1rEwM2H4MBkGzmG7LxVETkJHz3hnictLCvs1FHCU
	ob5tmBsEK8vcHowwDjjsx
X-Received: by 2002:a05:622a:1493:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4ab909a993emr26718311cf.3.1752681606781;
        Wed, 16 Jul 2025 09:00:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERe9JVAY73uRoPOiv1ZYx9NVNl6QHqwUVE2Ldheh7YUqMzUCoLVYSOkjII3/ToglVnN0G05Q==
X-Received: by 2002:a05:622a:1493:b0:4ab:63f8:ef30 with SMTP id d75a77b69052e-4ab909a993emr26717951cf.3.1752681606283;
        Wed, 16 Jul 2025 09:00:06 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c973439bsm9070642a12.47.2025.07.16.09.00.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 09:00:05 -0700 (PDT)
Message-ID: <9429c00a-b044-4da9-b380-a03d298da7a1@oss.qualcomm.com>
Date: Wed, 16 Jul 2025 18:00:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sm8250-xiaomi-pipa: Drop unused
 bq27z561
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Arseniy Velikanov <me@adomerle.pw>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Luka Panio <lukapanio@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20250716141041.24507-1-me@adomerle.pw>
 <20250716141041.24507-2-me@adomerle.pw>
 <c6od65q2e6bnz6jxq65ox7burhjavjmooe3vq6nhhfq3ikglz7@4ufcxbjhp23o>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c6od65q2e6bnz6jxq65ox7burhjavjmooe3vq6nhhfq3ikglz7@4ufcxbjhp23o>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dKimmPZb c=1 sm=1 tr=0 ts=6877cc98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=bjYnimzL4-PixQkOYsUA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: JwFWZJc6xwOdtErK8N1UaSEYLO5zQHoo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE0NCBTYWx0ZWRfXydt9pi5xp+6u
 duRMg6GmFs0rgIwHQ3stYciyAv6A5YcWp+JZNVlRTjtwHj5tONwYb5CgYBKzf69Zq4hK7vy8Xzb
 ngAtC8HCESalCuPaZaonlpvPF0dO6TLl4l4g/OEg2NDXGCsTD5TnK6APyMw56TURaUyruwFEHig
 U57CZUhs1Xs2F2eebpF2Ss+BRsjLadYLfNQftErFeAeViW3KfuPwB7wW8m1fIX7ZPAt7ygGdPfL
 +ai7spsS02/Mvhk7e1frSIWAGT8ptoDVl/nmxxjBI5jICFII0+5VHbjbBpvST/LcKjjE7CbUsTY
 gfErqPSs2p+XV9tCb+hGEbaPsDL2e9ovRH5O6dvok7Um4eb49NmzOFRupFadtKWF99Pvjbd4rvY
 WSc/Dg4/F1MVKl8TDAdKqB0jJr7Ux+unN598D0rzds+0Il1Hjl/iZD9toiI99qso/HpDWvbY
X-Proofpoint-ORIG-GUID: JwFWZJc6xwOdtErK8N1UaSEYLO5zQHoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 mlxlogscore=844 mlxscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507160144

On 7/16/25 4:59 PM, Dmitry Baryshkov wrote:
> On Wed, Jul 16, 2025 at 06:10:40PM +0400, Arseniy Velikanov wrote:
>> It looks like the fuel gauge is not connected to the battery,
>> it reports nonsense info. Downstream kernel uses pmic fg.
> 
> If you have to repost the patches for any reason, please sched more
> light on the 'nosense' you are observing.

Since it's actually onboard, it would be fair to assume it's there
for a reason.. Does it also report nonsense when running a
downstream build?

Konrad

