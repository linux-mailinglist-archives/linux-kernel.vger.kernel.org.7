Return-Path: <linux-kernel+bounces-835705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CA3BA7D93
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B1B1895D66
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109E02116E0;
	Mon, 29 Sep 2025 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hdh1EeSa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634634CDD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759115122; cv=none; b=htJH6cCc7Bf4FGB6Ocb/xLAiD29egv4hL2nXcYvjcGulk6dC9O29QglW1AtsUkzlGdW5wZjC2RUsPG/ky7nB6smWxizVMgP+rFTsSVATyhMjMzYUTa060F9WPySGkUqjePAfvOFb5fGd+QCEhS9yEy6xqufJfJ7CV7DL0h5nLus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759115122; c=relaxed/simple;
	bh=JPKGsUhS1I4F3zb2eZVXvGMv/pIU9wpYzTUlT4YHMoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGuH9tVlRFzYwYwU+q4IN4Wruj8sGnhAZu5JCQuI9vUIbyy+pPBLug0jjKJ26OesTOMKDwdB/+i7t3Pt8V9qYJViRi7Tq1HqKQhhQrw87qy1DDjIFZGXgiE+qzmKZ6EfgmF9gZx5BH3ft/wAEVHjXaEhECUL8aoPdN7ttuSJ85s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hdh1EeSa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58SLnkPB025415
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JPKGsUhS1I4F3zb2eZVXvGMv/pIU9wpYzTUlT4YHMoc=; b=hdh1EeSa+69kM5sU
	rQniWmkLicB2MilQfeQkgtIB0IIabiebzUuxl9DUlwC87cg06vIbVOMm/WrhsbIP
	ulHpsQFX6X4qOScfvptpgTsSonhUMTbhlyERvUBpZW3pYqIreGhw8rex4k2Yk9Lw
	730xt9pNFvHW4f+kijb9XCrmu0gQm65wfLNkxn5skDtaRRyQ9ENkWPuK5XOdnqAB
	ligly1pjdJ/ilM2BC3aYOjVWw22etV6izHQQJIV6Hts9fM49zVeuEoQnZfyxwVr7
	gJ/Z2EiuPZh4sUt7U8F4lxoIVh2C6HH/iOP9Ktl1EXZDD0HfxcapogZNjm5+DcO+
	YASgng==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78furm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 03:05:19 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54ad69f143so5896810a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759115114; x=1759719914;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JPKGsUhS1I4F3zb2eZVXvGMv/pIU9wpYzTUlT4YHMoc=;
        b=RlIaMQPADmhnCq172iA1TNbkSgVoLmhUanlZ8ege0vnzdR3QTZ0NyumhiN8eEDY13j
         yNh2E8o7bV7qBzTnAg7CbhnWcifqHdWYFiIixWzXSzNlG2D3HqR4Hb+JPcTDDwEe4kXl
         eZJtqkMJmvLfPx4usxUBiVNq9CPHbBmtfEbSQiFDMajJHFJYZ3YUnbJWmDyfe8OBPBVE
         P8BBvrcQLEMCp58BXcREfFxEfQ7hCPfFliwoClU3WS6H0hSNUh8iEwR+ZdH392Wj2lKa
         4TUZ3eJgMZactQIPIyl8J7Cmat0b3Sopm6yVUeZS12ZB+etC000CDoguuxD7ysTGv4PG
         tkvw==
X-Forwarded-Encrypted: i=1; AJvYcCVKEtTokj6rW1fJAPoocpJzH03keCZ3e5FKrz3/ghizA6cl14NNYof7SCM3A8L63s6rSHfq2ew/8x+s498=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVymF4LdWtF4aDZQ/dsgbOzYGWLRzb1hRjVXkIoHt8l2LhtYWg
	P+o7UTaOFZZiZ5WtWMPYf/2VEjwlzArQWJPBOUNO5rREBY4t1IM5fP0haiFJPGB8iHBvKTQFErZ
	VzMM98jFxOdiqeFIeOjEPKd/5arb86T65dPlMH9hTctBjntTwgRzj+BY1yEyBOa2TiGM=
X-Gm-Gg: ASbGncuMLEhwjXfJYQDLy6KtU97kJw5KOpU0sh70U/x5jXrDtsA4+CpEh150iguxUkm
	S22U1J/7c7LvzrIf6Dys0ylDTTlU/l/Mi9Le9PCUsXzq3hI48h3b0m1ATL7qA3jOaO6cPAaEqBz
	fSLBMpsByYiPra3P+vzLWt076sMxFtcW2EdHJyI1+FohsxJHUrtqiivOsBVQL5uynptRuzWlR2H
	6LMzhRGZ/74xTBjuEeYyW5JzsyL4UFBs9M8EahjTlvK8oX0pwW+qRLwgFc+ITF6gsZfm6mlFnrB
	QgoRiqTHTWcEQ4+QHOI5cJfxjzIyXUc7vk/w2pfXdFx0mzQ08+Fv/C+I2rcO/KuM7ml3epDuIu1
	o9ItzNag+bGuy5EyGnXikSL27g83EgfCfjHQ=
X-Received: by 2002:a05:6a20:1582:b0:246:3a6:3e5e with SMTP id adf61e73a8af0-2e7d707acffmr18032373637.54.1759115113757;
        Sun, 28 Sep 2025 20:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWFNyeqDnmRHVAipVXJyEJJIaL0vAdHMh8QGKf6yP6H+QJ2ETt1/DVkuRpuwmDnFuSxNKchg==
X-Received: by 2002:a05:6a20:1582:b0:246:3a6:3e5e with SMTP id adf61e73a8af0-2e7d707acffmr18032327637.54.1759115113309;
        Sun, 28 Sep 2025 20:05:13 -0700 (PDT)
Received: from [10.133.33.234] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c5574e99sm9872814a12.35.2025.09.28.20.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 20:05:12 -0700 (PDT)
Message-ID: <389183b2-4a97-4c86-8785-6ca8f4a74669@oss.qualcomm.com>
Date: Mon, 29 Sep 2025 11:05:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] arm64: dts: qcom: kaanapali: Add QUPv3
 configuration for serial engines
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-13-3fdbc4b9e1b1@oss.qualcomm.com>
 <9685e29d-bff3-4188-b878-230d0f161ce3@oss.qualcomm.com>
 <CAJKOXPeFKN+yV4eitGgHPUYibE1h8RH274b6N6ovz_PR5BYw4A@mail.gmail.com>
Content-Language: en-US
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
In-Reply-To: <CAJKOXPeFKN+yV4eitGgHPUYibE1h8RH274b6N6ovz_PR5BYw4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68d9f76f cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=f29FfwvlPiv84d7zfGUA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX0N2t48vAaOsh
 tT33mkSLVU1EyHQ+65wzXd3OvyUFX54T3tUeD3SNnNiZTuQtvi3MqY0cA4RfSQB8Rf7Q6QcCr8h
 iedA7kh9mPnEyT91KEGaM97/a3q1ryPtz2g06rkB7qXS3B66wyhpMvmnHcT3eXTkiOwe3Kr/yNd
 MnJnC7jnYIHiYvx9zp/jJXXmS40vHzWJHgFK1cN6iFYdQHEB1UeFcbGOvJV0jxoJMktBaa8D+fB
 DppQRZxDk1SGZNGFgBmmZevABX5qsF2Pg8vB6568AiL60/x/Xmj1kG/T1B6uaVsEu1QOEAtbLyb
 HsRj1gjQBe6lKP7zN/Fgr16Li3tLlZHXtPb9IjvUHgq+6EqhwpcP+rBJSOLl11CKpEouRWSXwBz
 1ch5cl11zGLdGEzvGwqYZgerFRonOw==
X-Proofpoint-GUID: 0mlyghuM3bDxcdUTAPT6d4fkotPdhdtj
X-Proofpoint-ORIG-GUID: 0mlyghuM3bDxcdUTAPT6d4fkotPdhdtj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_01,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022


On 9/25/2025 9:19 PM, Krzysztof Kozlowski wrote:
> Well, maybe it worked help, but I claim the author did not review
> their work before sending. If you remove lines you added, you clearly
> wrote buggy patches without any sense of proper logical split. It's
> not gits fault. It's author's fault.
>
> Best regards,
> Krzysztof

This patch didn't remove lines added, it is because uart was added in the patch2,

adding other nodes for qup3 which match the same lines and cause deletion here.


Thanks,

Jingyi


