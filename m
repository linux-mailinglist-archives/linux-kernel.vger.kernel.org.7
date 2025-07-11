Return-Path: <linux-kernel+bounces-728055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4CB02327
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 19:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185AA588272
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6D2F1FDF;
	Fri, 11 Jul 2025 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gApSY9r+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043D2155C97
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752256229; cv=none; b=qBKI4qVkLjzEBaSkHyneD0QwGgBvYF3vQfOuieEbdNjTU50fMeGQOcibJF/PlmKvdOSLnhk0bkW/wD8i/F4VR5zJcN+HeGKVbWuhEW9zqGi0cgVuUfFifEaOkrWa5nPsr35gDCjrAuzoMnSqjGcWkLH2U+1zPfNsmAEuDDAX1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752256229; c=relaxed/simple;
	bh=86r/sDTlSeSMo/+bzTvTxRRnHkxkb+sDRT3RGVt9qwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+Vi3mpczQhWXzQxeSkzbu30F1tuPbdGobM4vAM7HQfsb0lFPHxO4ekYHcfFZDHlZ0BzHmYyjYGhmh1RBq/yoqdqS+jGo9aobGrPg8iRTc4kpWjqguDld6NS+T4EdR2JB8zxaTXgTWNwWGyqccyEPY9xgiAvZeULNjTqZ8VyvNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gApSY9r+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB7ZIZ001770
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zODF07FEndKVYerePzf13yZa0v9IMBpC/Vm6umRGgcQ=; b=gApSY9r+2eAhMTb/
	78i0vkS9emlIFK2N5TD+V0KqbqrE+DJTruHeob27jHnXjtuMt6rEH6OnMoIKrZxX
	3Jq4Hr5MiTU8vX6sUu6IL//2V4H3anIsaXpeuOu0QaYGh6EQ5x45kEy0GonU8Lv/
	nLN1jzwClGo2Lr3s2CEXqhRwP8bFtWyp5WkI8xz2IMmP/8P/jxUqHbb+orW6fkJb
	WtBbHDz+O9dVEaTTVpNR3QLe7fR3brxtWx7elNWmJgiibuy2YvnEBP1TFmDrkja+
	dCF80k5Kjn7KMZFjQb1pJYRpF25bm1DDZDkX3l+rxZqa+NFHLEzIEUJvOagwF9/t
	k90SgA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucncvdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:50:26 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-234f1acc707so19147055ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752256206; x=1752861006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zODF07FEndKVYerePzf13yZa0v9IMBpC/Vm6umRGgcQ=;
        b=ksvrI1HKYDiIlIM4QJATdGpDMKz8Px9GkXSc9RNX8yMOitoO1z0f5h7GNd1oBfoEHD
         vM/WUdcGaYVFr14Nndtn+zzvSLQwII0uvacRkP0VfY+Y4fm+hYtEdAFYKPj8jGi6xF3k
         MDyhGmd6QvFhtW0VZ1sRTtcOjW+DPHJDaZg1QvA1KKCIapXR2b8jChi1LYZqY+7p8xrA
         fN+SK5i6VLC/107noosZahdAhpfiUPRm+cGosXJ6WMehf2WfxDZJX0nmw92wjZR9tDXp
         +bdU6+2WwmPUZZoMwx3rX/VJiTMKUmiF8FfekFuGOG/y0uTL+3gvqFY1x58msbLgDVcZ
         qE5w==
X-Forwarded-Encrypted: i=1; AJvYcCU1vPQt1ffYvVXvFazoE5E2iWQtPbmOj6GEK5jEi1Kg1xLYuu1dw7uSoAwcllRE1VbSI565Lq5pXTsmrco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyuzTBm7REsq67TfXA/c1LobMs2UhsGj1H2Bx5enT5KnhKYJH
	+5m0Tlu1oD79QKQcBvyO0i0D0AJtxfgLcB8qLAGX569Fh72mu1I9oicDIpKLUk3jVfHOAUn1aO8
	14eaGRk4ItIEhl1ljarg6YHJKwp+wiJpQXAq9yyeC0fmMnzZK0dpdlZMeJtwbSjLsCz8=
X-Gm-Gg: ASbGncsTT/7bGjr8LwOVtDhMU1+kFIfVRNSl0nb0O/uMTo0jDIOeMdLOnf4V8RZmE6X
	ikU6wEdThYIzviyAoeGXjpLHMY9g2pQ6U7qTyQaDd3RLCCLkMIKex0BvQU6oRZwGudUio5xH5ch
	ezuJvkP+E4+3DH6fIN5LTS2EA9kh82asabXJoKBPRk8Dbb/vpGRqxPTddAi7hJvDztVRv6JPPIT
	BtchlSDkx9eJM4BqrcxHFpbaSBQURqMCxnTHXPTqfr4CfSd/eQOSqh+CyCk0y3coveWPZDz/TXX
	TMxyxXy5ky9uvoGRC8ZiWjGekkQH429LObXrU9MI4yE91Ne7VDn6/EsAFhWy+aRjQJvA7Y3EZg=
	=
X-Received: by 2002:a17:902:f545:b0:235:efbb:9539 with SMTP id d9443c01a7336-23dee1abb0emr63643185ad.17.1752256205863;
        Fri, 11 Jul 2025 10:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoW1pfrpu8TJ9bIwQOf4KOWgHALwSOkO1BYsTZCrJkUsn+7Lrx4ekRpFxTdtXkf6n8J7ntUA==
X-Received: by 2002:a17:902:f545:b0:235:efbb:9539 with SMTP id d9443c01a7336-23dee1abb0emr63642755ad.17.1752256205266;
        Fri, 11 Jul 2025 10:50:05 -0700 (PDT)
Received: from [192.168.29.115] ([49.43.229.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e160sm50153985ad.172.2025.07.11.10.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 10:50:04 -0700 (PDT)
Message-ID: <42a98c8d-7287-8aa1-ad39-4d5b79e177b7@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 23:19:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v10 02/10] dt-bindings: power: reset: Document reboot-mode
 cookie
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Elliot Berman <elliotb317@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        =?UTF-8?Q?Andr=c3=a9_Draszik?=
 <andre.draszik@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        linux-rockchip@lists.infradead.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20250710-arm-psci-system_reset2-vendor-reboots-v10-0-b2d3b882be85@oss.qualcomm.com>
 <20250710-arm-psci-system_reset2-vendor-reboots-v10-2-b2d3b882be85@oss.qualcomm.com>
 <20250710224740.GA15385-robh@kernel.org>
 <cdadd6cf-18c9-15c7-c58a-b5d56b53452a@oss.qualcomm.com>
 <454c8361-151e-42b3-adfc-d82d2af62299@app.fastmail.com>
 <28f277af-9882-2c70-5156-123c95adc2ee@oss.qualcomm.com>
 <b870ed33-7d4f-4b0e-a9ae-b9c374ea854b@app.fastmail.com>
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <b870ed33-7d4f-4b0e-a9ae-b9c374ea854b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=68714ee2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=8g6h00HoWaIZ3EdQG8aEvw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=xZdgJlt2tE-EQpnRY6gA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ir9TmD-QyEW22CdrMrJxoqlz3oVjZGbG
X-Proofpoint-ORIG-GUID: ir9TmD-QyEW22CdrMrJxoqlz3oVjZGbG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzMiBTYWx0ZWRfX/JOR9gH+VODc
 ePxvHGFAdG/YDzuwpD4nqA3t3CA0jKxgyC4UYvWN6DA2TRrCBBpEN725GhweG3ze7a+JfQIKvYh
 tpljHzwnevXvTU1K7Md/XqK9wyu4X36/k8YvaTtsXMR4zV1y5Qs7ndNzydh2e9VzXLgPRiFsNFC
 krVuBoDYu9QjF6UdTQLVH+zaIknv5bqJlUvysvE2DC4HwNI/ptDGiDf+5WUTz157znqII3wqoBV
 m3T0/HXZbaEHAhY6hfbwb+nbzlsUK/IlxW1UasSiaXLny+sYYOw9ZE2oGr3xmxyAMqub4NVgE4Q
 2WFDPIfrcSA4D60eYPPfRFFnsP/hpiH3UJtd+YPjWB/NzjxzlLeo+wYSuV16dDum50uj9/zfkqq
 xTaR42Sni2Sf+ZGpqxpay895hPisMok2x9nt/5cTW95UsETvenjnLOA/dFaLcsyN9BCjxjzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=646 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110132



On 7/11/2025 11:09 PM, Arnd Bergmann wrote:
> On Fri, Jul 11, 2025, at 19:00, Shivendra Pratap wrote:
>> On 7/11/2025 8:14 PM, Arnd Bergmann wrote:
>>> On Fri, Jul 11, 2025, at 14:32, Shivendra Pratap wrote:
>>>
>>> The distinction between cookie and magic value may be relevant in the
>>> context of the psci specification, but for the Linux driver, this is
>>> really just a 64-bit magic number.
>> ok. then if i understand, this binding change for reboot-mode be dropped
>> and driver can internally handle the two 32 bit numbers?
> 
> Yes, if you can easily keep it internal to the psci driver, that
> would work, or you could just change the callback type to take a
> 64-bit number and leave the interpretation up to the driver.
ok. thanks. Will try it out. 
> 
>      Arnd

