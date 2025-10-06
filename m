Return-Path: <linux-kernel+bounces-842685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FEBBD4CF
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1149B4E6697
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85BF25B695;
	Mon,  6 Oct 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S8hZO2eW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AA1B4257
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759737933; cv=none; b=EpHQCi5BQmNtfK7IYqZe3r2dfqDh8mNRijE6WII2WIGRSNOXdDXIcBS4dJ1J2uvS2JRhbAvJGbQcLtmg7j7752ZfYAC5Q54Y4EJ1nKLS0yJHMp0vAjFtXHAHOkrwYseIuogdjCfuNGMw2GKf1ueMVzWCoVNIUs9z3Q+HBO9WcfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759737933; c=relaxed/simple;
	bh=QA5XuDVb2r3T1rUhSUw2wU4hB4uJTsCr6nvMKYFQzzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO237n7kJZP0HceE8N/1Ja3dGsgR1BMCry76yjsejMiQHnIacf2NZNI+ov1LktjYE+PCFZTyxglCm5kl9NKY7dqz4PsG09vMPqXijWqZqpxW+1ybdhhqGv3lC0XgozhiFSXuEzt0Z7viRQsN2C2wV8PIeMh3mu29O+qxMK8Xubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S8hZO2eW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595Mt2a1027377
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 08:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YHQSGZR9GO7rC/pjCE3xxsdC8DURJ2+fIVFYs/vXeMQ=; b=S8hZO2eWAYjlF7yS
	9sM+q5XzvCTMir+y2JSYydRu8Pb/Mus6Bnp9KV8wLl4RB20m203amqSyyA/7OsPH
	X0BJTb8ZIPcWzK7u/Ro/UX6ABEGJTk0YCa0vh1DGIN9Pi8F5dr7DWCIwjiFHxxqx
	PvTB7DwfR3isd9RAXoEcAT/UM1OYzq6lPrd3q+PAuTwZfiYyIZzlcYlbKM3W1hUD
	pHQhZIAPDQGkXggZM60q0a1Yr4efU0Ppev8cYpI+7O7yNqK6P2o2O3n+cc3THgI6
	uHdYMZHkPe6s53hXHcCRQ0HgMl3bPln5OLWRHHIaEo3lEccgYgJy9m/2l8TSR6Nf
	ujuz7Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn3hes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:05:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-860fe46b4easo167554585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759737928; x=1760342728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHQSGZR9GO7rC/pjCE3xxsdC8DURJ2+fIVFYs/vXeMQ=;
        b=m6BBzILtOUiy0SJdiwxrBWwv8XeVE59Nqw9GtnSJzjzLvTyZo8I6/RL1jxz/VP87XE
         tN0KwxmxIGv6EEb5W/cCiE3lwVJrNkDm1Hees8Omxrh0dmOX0PUE1QPsXpUXcNI47cJx
         i3dXImw2TbTv/Jk/zf3IpVjXxoDhjR+smybbuAcLzprcUeyOpEcQ5meBMT+flZOqOg4i
         USA9+NsO1B80QavRW0boyNAruqxVsM0HhEeGFhipbepbKo9q6KMKLVhuZw6P5s5Lpsyi
         rqOOhdb66NLiYfooUXRVI7GTQe0knt58a+s5QEApAN0fJodowC/6ZmCDDnE0F2aeuQd8
         UrAA==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2UC6f9vIIYunrkDCCNS/E4FDuin5BJU3xF6AANDCHhOeI707XrU7jMhncVpfeTLvX24Lz4VGM33iVT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrcQzKQ3wpRweRtn2ruC3P/yccoKMX8Ixod/YoOKZCwgLTeOZ
	VpQvdvwQjqEBJdQHMeqSv+no+7cdV3bjEmwJ6dGUA3Bte8njSNvzPKY6zh6x0+5etMqofR1uH7P
	zMoljC6kXvzc3DzTcWr1HlrIaEN0+sEX0+zKbvIHENmCUlipsUPsfL7NGgR3aF/eFsSg=
X-Gm-Gg: ASbGncue4Zb1+1D3SOGbWxaRa/Zul14eoaG9sinRIz/eaXtF0vnO1J07hrfEws03//M
	eH6gCkEfEHuSekAnMeI91tSy7HLfDpN5EBLCSOSBWbe4ej5thLHgNEviTSCk4BOvFiywX7avZyf
	ZnRwbrHPHN7N1NDI0cBFoQRq5sGK87a/Re+XXZPWx3CtHGKxTAh+7xx8XKShu1QH2DcvQ5CU8+s
	z9qv5VtHOUSqjSao07xmvPXuHF8xRflnuBivjJFQb/9gGxRRE5aVSM9LVfE8DQvAPzFI4HFdz6I
	PqVGIO0G749IIOhQ/wEW42+U5dUZEj3+zitqTb4lTUKijILjS35GIXcIYMc8hGnh7BzSD1meWsY
	sHGa1U02E1P2BRC5pJk2zv5MLmsU=
X-Received: by 2002:a05:620a:1a1a:b0:864:1d18:499b with SMTP id af79cd13be357-87a36779e3emr986276685a.5.1759737928265;
        Mon, 06 Oct 2025 01:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiHABiaY7kNoovBaU7TywNPovpCiqTpnopBNDWVEUf2OLmzGt7ShaBnEXJHsNVZXcDkLZ+FA==
X-Received: by 2002:a05:620a:1a1a:b0:864:1d18:499b with SMTP id af79cd13be357-87a36779e3emr986274285a.5.1759737927723;
        Mon, 06 Oct 2025 01:05:27 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b2ffsm1099083366b.47.2025.10.06.01.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:05:27 -0700 (PDT)
Message-ID: <b85df7d5-01a1-490b-b223-e968a862e9de@oss.qualcomm.com>
Date: Mon, 6 Oct 2025 10:05:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: sdm630: fix gpu_speed_bin size
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Konrad Dybcio <konradybcio@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251006-sdm630-fix-gpu-v1-1-44d69bdea59a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251006-sdm630-fix-gpu-v1-1-44d69bdea59a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfXyVbQrSLOzdMP
 F7FSWROAzAIFhNKtI0Lv9k6Kjt4JKg15fzPWVll9H1j4+a7PHVsyNLt9qeMEgblTW/b1TccobHs
 ceRfYRbP/grw0/NkQoSQKpFO/00Qtz/o9Z75xdd1l5TuC7Tj8DBJManhgqeQdVcCks+VLWFOseu
 eoYOtuOc5ZBLLS7gfAbiy0PjTdFI4eDXy+RsT5T8dCwFNLwVJfVSdRhzje1DhPbta5djWnBixo/
 9tezo191npdYf3C+wJqX5egOrbOBip28GiJpy39wkh+PMEGz+1S4hDJSI8lzsOeF0HgBE1QuPO8
 CuVfFwZ3OA8mPXvgBpbV6qT/7+cBf6LwxCC2meDexOCYjogv5IQqsvhuAwHSBKr/+MMPNkiY6x4
 iMdVd7+cZ/RK0MTyXOy55E8M6+yIIA==
X-Proofpoint-GUID: uGFkOokasNkJ7aEWPHb2VTuKugx539EN
X-Proofpoint-ORIG-GUID: uGFkOokasNkJ7aEWPHb2VTuKugx539EN
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e37849 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=19hG_fmFdy9UMJMDlhIA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_02,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 10/6/25 12:16 AM, Dmitry Baryshkov wrote:
> Historically sdm630.dtsi has used 1 byte length for the gpu_speed_bin
> cell, although it spans two bytes (offset 5, size 7 bits). It was being
> accepted by the kernel because before the commit 7a06ef751077 ("nvmem:
> core: fix bit offsets of more than one byte") the kernel didn't have
> length check. After this commit nvmem core rejects QFPROM on sdm630 /
> sdm660, making GPU and USB unusable on those platforms.
> 
> Set the size of the gpu_speed_bin cell to 2 bytes, fixing the parsing
> error.
> 
> Fixes: b190fb010664 ("arm64: dts: qcom: sdm630: Add sdm630 dts file")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

