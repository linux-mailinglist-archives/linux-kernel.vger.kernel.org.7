Return-Path: <linux-kernel+bounces-802808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BE3B45739
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DED17314E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED0734AB07;
	Fri,  5 Sep 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g+az5kPI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9592134A326
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073972; cv=none; b=tYgUjFpxABPSezn7lJf1xMMMh5eFsWTeWnUQMXotR9+XtRrN1k0uJoasyclkYT4egpxb9nFxxmd1rNmd2Qrsqs36VmaGI8oE0oUP9NBRP9VWPRs7dDlTkjzoxKo4aIQNCBm19p8l7XSH6UR8tFIx/WV0rWgOgjccWX3oK3gYXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073972; c=relaxed/simple;
	bh=ldlxiteVjgDeP8xEo3N2AmqNAbePsfuqyTzaH+6MAcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nj3toRqIp3oI53YflODPgeCgOBX54EMMMJ6IJcQ9ovRJU0p3UHM4PapqoqaoT0f/C03VMapm2CrjIGqvniAw5hjZ57bNepXr3GG64YRWbVc2IxE4yndKubGmSWv1z7wjzC7thSdAaSNMzHYYJJbyz3bezrNsMxwFAraEGC/Zi4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g+az5kPI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857nn9s031806
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 12:06:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dIUWCEcqZtXBeXsUMytwaz17zqmex3UoROOIhHg+zWE=; b=g+az5kPI9X9pasaF
	y1g7Irqn9G/L3wLDcrG63AV1iuDyN+JhWgRrtSfkhZiT2mlDD0PTQ6TQxbFi7DKD
	n5xCwc6vd5QRrdgaX3bcYJzUc0+lNd98YxzUQKkHDzTSYxvJflEAeTE7WBMRb/nq
	FOwMtQTPsxCBQCohxjSlWQa7R4qSbJdRRpu+Y+IYBt1+KhQvu8vLD5T5XN0r2ckJ
	QfirlxHrePqRSDKVfzhFh04+XPymQE9jpDyOKg6T2NpbCKDkRv1jPmURDb7AdW9z
	YsPl/d8Ltuhv/xVl6XPf5886DHagCrHUsam//vdc7g5sGkhoPE3mYgWnOhsBzMZU
	XF6tsg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urw0b450-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:06:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e87065670fso70867585a.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073968; x=1757678768;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dIUWCEcqZtXBeXsUMytwaz17zqmex3UoROOIhHg+zWE=;
        b=eeDlE0naFIjJk5vwHM7xdKFJv2uFPjpFtOvVaXK400cGJzWpjKJWZE7td7AY/YkDlj
         CPdKxGkKDdt/Cn7mM84Qig0qSMxkMmtsPE7bxyXSygmaPUy8uJKnZYDf3WX9NOnoP7gw
         SwHSRjSKjKF18XefYNvPGTOEzHrgETAUndPOVN0g6velA1hwemj7QjI2My6vR4SMC7rm
         Zno/hjSE/+us9lB24LcqIdiew2u7WA5oaJk4ctn8Pg4IANuXg3FYd8J5aSBJD2l7xaZO
         y/5RmddfdTJiZXvqU7WV/4rAULWaP1+KBDrEZAULU6UeZ0jNkk49ZU9MOLjCgncQXkoa
         W7qw==
X-Forwarded-Encrypted: i=1; AJvYcCXWt6wkX3uL35/bA924TVZoNBu8VSialWQWsT9X3+UPXwmZNM3ni34Mip2rQpPjIM/rztLx3XtxXj7X6oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7IaLyEIMU9yyb2gAZ/EDnJX+YLvBVf+iWlG7doU5QUWl1tXX
	CYOHrfBoGHENqCE7jltS8nDSFZmD3D05Jp/T2AMRV8Ggd2z+AsRBU05dGL1FdJlECBzU3R9BXye
	N0nf6aEaDMf8Up8AnIe3S4m/C6mmUWNB876QppYlD/QYCBYdRAcO4tEElhkCP8ses8Rc=
X-Gm-Gg: ASbGnct5hMQvLbU3h9YJ6J8RYpPQ9hR7kmg1PWTafTvVIwQFffAlsrrmoE/nWN7+iZF
	7H0Od3t/U6mF/kSPVAmj/L0cGM4QVFmp4csGGAxLBasXBhUvGRpywBB5CY+3/1ZqGnue1ENAOUr
	mqrDTJwtVFqA4YLipoth3fhtGdXjsafT9vFggdu0v7F/DiIYGjCBML8FoN+jdFG+NYSCsPKQbb2
	ilgP0NOHPQoihKdFW9YuMIzfFu8d8cmd/vK5cqfqa9Mz1k4+MWR5Mr49oYdaFxKzJGeJw6TV6Nw
	OjGIj6Kzq/6ush6UBbemu6ZiyW7TvpYM6jMcb0MoHCH01595mA0k21vTPR2HPJ3TsBio34ngku5
	xfhkrqQ7ip6BX8QKXK1zwPQ==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr59876801cf.2.1757073967356;
        Fri, 05 Sep 2025 05:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbClop9hg8atD+aWFohh2CZ/t3jFlq5ci05mjat29SqiFLYOqxeot/a8+aYFeKlmRNuQXfyQ==
X-Received: by 2002:a05:622a:295:b0:4b5:a0fb:599e with SMTP id d75a77b69052e-4b5a0fb5d27mr59874841cf.2.1757073966067;
        Fri, 05 Sep 2025 05:06:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b045e576edbsm785026566b.75.2025.09.05.05.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 05:06:05 -0700 (PDT)
Message-ID: <b7d1985f-3c3f-4776-9990-42a343661c51@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 14:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
 <20250904-lemans-evk-bu-v3-4-8bbaac1f25e8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-4-8bbaac1f25e8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: FqhWzvzuOg-LFjnQ00FbumyWxm4xfFS8
X-Proofpoint-ORIG-GUID: FqhWzvzuOg-LFjnQ00FbumyWxm4xfFS8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNyBTYWx0ZWRfX2E1s2n8IbMoV
 yGHr/hdOYN4G/gI0pLck4Yp7/uwIzSWvxYZCodTgdroLhdTzL8Wdv75WyuweN1ERBqr8XrcVt/l
 GivHpuAzqqKph32zDh8AWHBCynTCLXiPoM1wfrUUfbkM5B4eItbTe8aY6hM8AJYCd3F0Xh6QIR9
 g88mvw1/jaWSGjDPfbbnLpyZmFwDw1V3wGjFVbTHRvxCQvC+fDjAAUrvkjVboZEWLqRJUkce81R
 s5r7YcK1N69zMrQ8Fabh3V7bcjydhz3xoJIGxVAMakF3wVw1EfFSSLz4dydiw2jk83xO6g1wrRx
 f+pFo5a9h6zRWJ46lCp2eTL6w8eBMfN9v6pYi2MgKiCemzg4GLb1k8k+R8zjHmHNupB1u3cP5Fu
 dd102O8t
X-Authority-Analysis: v=2.4 cv=NrDRc9dJ c=1 sm=1 tr=0 ts=68bad230 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=TqwOrElcE3fYHNaCTFUA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300027

On 9/4/25 6:39 PM, Wasim Nazir wrote:
> From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> 
> Integrate the TCA9534 I/O expander via I2C to provide 8 additional
> GPIO lines for extended I/O functionality.
> 
> Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
> Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

