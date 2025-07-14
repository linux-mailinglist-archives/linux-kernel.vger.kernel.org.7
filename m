Return-Path: <linux-kernel+bounces-729976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCF1B03E80
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BCE166702
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1276B248176;
	Mon, 14 Jul 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E1uRVocu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE224167F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495586; cv=none; b=anR8Y9A3bdMel1EOxIz++OKLxSX8jkNBB25drBrZdUhSUeLWw2fcy4tGfR4jp/brCijiGNZ6rsoVBGQW7hTfyJV183eDdzJ8Vulvr0r8/UVrVj9AXJPg/MKKhH8k4LOyqK0kdoVAbLZuQ9mI1mxVW6emG1bURtgxTLJqmTcMN1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495586; c=relaxed/simple;
	bh=vg1LPvtok41V62jKgVCViQqz2vZuvfhY4dzciIbvWQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSD1rL8tlM1SHYo1XPZitK7XUZqNseipRad4gN4f944AFutOe7ngocgWZ6PUVsPFj6rzl2ozFPQn3D6k9/ZkRhBK33SLu+Gw2+a3t037n+6d0WAPQbYbmT1THcNG782IpVkOAew+cL7PDOhFk8Iz+fd9bwggBvXQs6qwYHEQnTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E1uRVocu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9MB92011638
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	to+jAqKUwFsv0AkY0GQhPmlDuQ5+LAk2TMq6Z7FQa2s=; b=E1uRVocuyHFzbOsE
	SDOXrepOxttpPH3XsT7PdQ7+jLPEu7tD+Jpmzx1aIJ6UQOKjYW00inJro8y5rIzS
	Hx2PrhXS2FOqeo+g6j0Z9S13BH3dLGvjK8C8Vssh/E2Jyy1biYQvnFdafuUTxYzG
	PJR9dtqhXuuFM+6bip/DFAgMsGiprQBNz9XSHaU99RAw7D++zeXCZo8C3meXl/E3
	sMTN4UDkxV6Y7d6jX+cSasFcGY3u2FFrvS3DzRWpWsllC1jfMb39ccmMQhljPi1h
	vnUjNpph+H/NkD7/pyLbquKzOVqf4RGuBm/OmBcy2flVbY9AC6Gr5e2byhAmwJRe
	XFJLTw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47v56a36tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:19:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7df5870c8b1so45677385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:19:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495582; x=1753100382;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=to+jAqKUwFsv0AkY0GQhPmlDuQ5+LAk2TMq6Z7FQa2s=;
        b=p9loaM43Z+BetpPsCmTTEfMPnG2cuNp7tamGXRAB2jyxCveOPGEgSIoTmhFrwjWjgN
         LF2KO1AjIJgBhajkPbUONNxN1yJZNgPrC3Mr778Ddmor9dPa7lWXdJQWLgoIapel+qAV
         vYklvL3fikaHv1uzPafL8Az3n3rbXhPeBi3UB/edOotaOk6INz2YhuG6mjlbZqhKE5Ex
         92DJTFNRc3jIE6ZsAwywSdkfBzrPEWC+koGpVIUu4azYSz9VrROMHff7QlNtp6FmWr0g
         wHNgu6YsKNiX2rAghApu6P/JOTuQGPUQ/Q1n1Xpx5ndyC2nYmt9zenWF5V9x49rBxRTV
         Mr/w==
X-Forwarded-Encrypted: i=1; AJvYcCXKMALA7Dly7WsBtzgJ2dBB7GDzNjWWubty13+j3ISyPXnmUK5D0B72S6h2vWhh9jhfNqJ+2KHsGxGHF9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMHK/+OeNwwb6DY3djHxFKdaYbSGTRSDNHRyXo1WIvWiqa5eY
	cRemEjDqzUlYhP4exROKDxEgi4I79Og1j3rqgH1ehRKjOKsuoEJ2pSnqrYCCbIxwi9HD5dimuMA
	y4YlQdJvWCHeCJAxEYDCgfE06rZwNw1mlfrcRkpxLkbBjIe2/3T0iFTUJmdCcqigW7n4=
X-Gm-Gg: ASbGncvpVYdgolKKcLOOaE6AcZNAG1won0shNkDm5+xf9OOcnrQvv54Raut1qjLV23r
	ThNv9o5jd+03tJ7bphkErv5OvriFMAquytIkfkZ0RzeBrzzOGRTpk57LV6UlvVJ12HhQvOuTvZH
	Hr2pRz8PW16Ec/5L7kByF1DdFwXhuLiV3tJuSnctOdRkIQyyjU98RPrGGGreoMSocXCOF74jxbX
	L4ZZbNspky6jt4dgnx8FQ79FvIr1hFsJ9VYVXajP0U2mSxPrzSrMkCyS9zM2TdbSHTEAZnbkj8F
	26CafsfLpM9nA/21jv4HmU6zBqiNqHYqXfuXDf5xT73rpZu+gpmbYIvKqJh0edomI5gGcPm3g87
	VZ7WtQpCkiWSmms3DaY9U
X-Received: by 2002:a05:620a:4514:b0:7c3:c814:591d with SMTP id af79cd13be357-7dde99543ccmr786275785a.1.1752495582230;
        Mon, 14 Jul 2025 05:19:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/vV+coe8tEVfro7qq/0wCJ9/o2FTg1Dgu/ZwIOZQR1tYnvSopD2hrjhYTvFm/GsULL9+YrQ==
X-Received: by 2002:a05:620a:4514:b0:7c3:c814:591d with SMTP id af79cd13be357-7dde99543ccmr786273785a.1.1752495581726;
        Mon, 14 Jul 2025 05:19:41 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9733e9fsm5990826a12.52.2025.07.14.05.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:19:41 -0700 (PDT)
Message-ID: <6f8b86c7-96a5-4c7c-b54e-25b173084d95@oss.qualcomm.com>
Date: Mon, 14 Jul 2025 14:19:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] arm64: dts: qcom: Add The Fairphone (Gen. 6)
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com>
 <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-15-e8f9a789505b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: pPC03dhYKlEhQU9jUAmqo4kLMZAN_LkC
X-Authority-Analysis: v=2.4 cv=X7BSKHTe c=1 sm=1 tr=0 ts=6874f5df cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=6H0WHjuAAAAA:8 a=ZwcaOx7IXxPg4YioGooA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: pPC03dhYKlEhQU9jUAmqo4kLMZAN_LkC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA3MiBTYWx0ZWRfX6SGRXp3pRjoI
 WpPZGdM/aaiIWaNg8vVyzaWwgIKHGruYeABigfBWJx8gQd6ylOOYPZQtUWZ1Xpf/K5PztNxKY3a
 fN3dLzYXqgYimAiXqgF3zrX4ouBreJmaUfGG4W6hWXC4tpqxqWM8mGDUMyUw0kLKJctqRr28Rac
 Y6cDz//4p4okcSI1ACvxZlP3tiDNe/bPXHvv8qTFzq9iZbnxZKML+SGuUBNA00GsurzRGFECZm9
 g9yQc20zPpIfvgpFk5KJBk8yMK+TMQG8L852sADlRDXy/FzHPI7z5N0uCjUc+PUD9jhLvX1+fTy
 K+MeAYQSbRYz0Eqr8wXnMdy9wf8AGbkgJVH8C3W8TCnn0b+i0Gmq+M+cJWQk2QKQGzEEn618Kgk
 7ff3v7Tec9xAxiJ66IWh9DPBhHD6ee/z/lphZ6Gf08a7iYXZB6SP0mZCYxdxd5TJq7mw3wMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140072

On 7/13/25 10:05 AM, Luca Weiss wrote:
> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
> on the Milos/SM7635 SoC.
> 
> Supported functionality as of this initial submission:
> * Debug UART
> * Regulators (PM7550, PM8550VS, PMR735B, PM8008)
> * Remoteprocs (ADSP, CDSP, MPSS, WPSS)
> * Power Button, Volume Keys, Switch
> * Display (using simple-framebuffer)
> * PMIC-GLINK (Charger, Fuel gauge, USB-C mode switching)
> * Camera flash/torch LED
> * SD card
> * USB
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

[...]

> +	reserved-memory {
> +		/*
> +		 * ABL is powering down display and controller if this node is
> +		 * not named exactly "splash_region".
> +		 */
> +		splash_region@e3940000 {

Was it not possible to arrange for a fw update after all?

fwiw the rest looks good

Konrad

