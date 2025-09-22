Return-Path: <linux-kernel+bounces-827286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7BEB915C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA94918A5701
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216D130C348;
	Mon, 22 Sep 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f8QyDB+O"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C0266B46
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546959; cv=none; b=BSzXdCa2D/RO/PCYCXNZPoIrHnW9l+GzEvJk4bkvb3qWUhKW/P5PArQMmwn3iSloCyQ+bsKN4l86X3lx5jD9QXRiG7CZInVi8lSeyvhwX4RbIMZcaL/ugIHFT9eQz5yLe3UtaEja+xwoBvGahmYIY9+LJtTABgUmxYm39MWoH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546959; c=relaxed/simple;
	bh=H3IP16ww0WDCJ+jXWGBbAdfLN4zv66+LQvFJvHx81q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2jZwyhSphiEAomW8cAMagTRs34J1GsovljEonhBTcNvBKdhU947xLfyy+8Y9lL7VTtE+nSakg9/v2zHW5AkATAOqLbgJep1AFlEB3pLckUC+hjjnN+gTv0qa00MlU9uNXese4er4dttHlGsbtjl+9PhXLFxIi/arQQTeUqFNGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f8QyDB+O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M92XSN023868
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6qUiWWx4TK1U0L43SvL0E376P5VuAjOTkFKo8rMJQnM=; b=f8QyDB+OyBdt5TbW
	qumxL4YZgxV+3ACms7uE5A/WK/LdbdGnJWYY/Z+Ny+lfbAbz32kKrnkqO+M7W62j
	12MDyGp1VNZhZ5XTok8ugiimGNvd7fznuv+DzbZw9FTzB1Loq8Jfr84FGIgE2TZF
	2VCpTFW+8/l1SkH1pdqJ3NrJpohNNXHG5U0pOmjNQrUSgMWWXLfdccwhy7U2P3Im
	I9ih6FJ07YCxFcVQdGBspLpWOAj9J0AEGmd0KjZep3Nu3/Tgtl3fG3JcBhtru7ZZ
	ovzFR55mykbF+gi4lZq93yGG5KIDtDXz//Sdl1AYFWYVJI3B9DXEgrp3josV2Biv
	1tsx/g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mn7cu9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:15:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2699ebc0319so48406895ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758546955; x=1759151755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qUiWWx4TK1U0L43SvL0E376P5VuAjOTkFKo8rMJQnM=;
        b=m+cE00T342JG4laYAfiPvcy3v/CzGhuedcE3VAC+H93ex5zsUODc3fj+HZa7UCpZs4
         rqw94hRyYEwJl1ktsIrd7zi647NgQEZ4uMDbBc0sLP8mgIOrZ24lGah3l1ZjC8b9pknz
         Df3zGSDg40hf73vUYseHkgMXtoDrIQBB9ElcX8AXr33jjp2l1evixs/3eeMbkyCOTmpi
         k/Ma7FwNniMJcbetGzg0sEqn1IRWskMXXQPCv5xayEiX5tanhvQ8kAEVz8SG8Lb5LnlU
         qYsDZpGenveLlG+uw8GTop4NEin+Fk8kqFhUTnWaoVbUGVeFMcrG9s9vlU+UhFc2YTsR
         rueA==
X-Forwarded-Encrypted: i=1; AJvYcCXqBal0nrMzrlovOus9o2KIXrjI2KLg564eVxYHCxX9eGF4JSlMSeXfyoLthin3GoSUjB7XW/jGFrT1V+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsw48UH4juSBFcrbkig286ZkzxiNaeCAvCCI+YmY8XrzOCg7QN
	seT1AiVHYN3E2RuDly+FoiIh8Bm+NX5XaJUH57HxVxdshmBH4NcFOzlc/hjkZmJqa1uGN7RBQop
	C50wqLcN4arZHeLlwTK4TfSoGBx2ggR3e6WkddTIGvol072r0aDXKwMORvK9LeoQYPcQ=
X-Gm-Gg: ASbGncsGmavh8B7sVuwxmy/ywU1l+5ZHGrK6ML8iomA7hCefgctVnwSDa5cOEL8sift
	KQ49s45A9tsRTlEm6yQU65qqaMw3mTpFYKSFasXhyULFmyRHUvsZ1wTTO8SmI7P8GTiFvJw51fc
	2/s8F0uZjHHsbxLyz86O4+caOumPdCJJkpFmA8Yk3LOwyNfmecn/yNEdUIQMmawbeTvwW+egdg6
	/azm+PMOmHYUJOW8Ij5maQCRm7DhXMfX5DlxOug24/qIKBUN3u9yddpisb4ky8Dy89XqY9tM7Mu
	0iQLZ9MyBiHi7/g3HAcRTyqzW3amxclMgNuzZrV+Qt5CE6KxhBbIWAA6YphYuVf7rIk8oAvM0cM
	=
X-Received: by 2002:a17:902:e88f:b0:26e:e6ab:66fe with SMTP id d9443c01a7336-26ee6ab6903mr135902235ad.5.1758546954573;
        Mon, 22 Sep 2025 06:15:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8FceqNmu1Keq5p5ZZARdjJs04BUAGVHKikSD6fdT+RdHvPij1E8fPv9RnSnlMfQIj4YbyZg==
X-Received: by 2002:a17:902:e88f:b0:26e:e6ab:66fe with SMTP id d9443c01a7336-26ee6ab6903mr135901545ad.5.1758546953855;
        Mon, 22 Sep 2025 06:15:53 -0700 (PDT)
Received: from [192.168.0.102] ([49.205.248.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5531d90d1asm6729316a12.18.2025.09.22.06.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 06:15:53 -0700 (PDT)
Message-ID: <fa832a39-268f-2347-df01-e6d8c06547e9@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 18:45:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 5/6] can: mcp251xfd: add gpio functionality
To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Gregor Herburger <gregor.herburger@ew.tq-group.com>, mani@kernel.org,
        thomas.kopp@microchip.com, mailhol.vincent@wanadoo.fr, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250918064903.241372-1-viken.dadhaniya@oss.qualcomm.com>
 <20250918064903.241372-6-viken.dadhaniya@oss.qualcomm.com>
 <CAMRc=Mf2ycyKbL35bdy5m1WBEap7Bu8OO2Q9AdZYgc04Uynf8g@mail.gmail.com>
 <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20250918-daffy-steady-griffin-5299ac-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX509Q/mHPyHBe
 qbljwEdRvoK4JZrLvhMwr9YiAVev8fGAyUZ5B14jr3ne1uN1fJameqPHQ5DOkPEAzDhZGJZyaMX
 QNZPS63BW+r+jlnGEzv5AsaEfbm90y6YOU0ESh2ect7IeFQE73HeO7LIWPUU7/nqzYjUKHXzAdY
 lPedvA26NoJHmSGGo8wBu4RUYvRp6qcULmb9mJbFOZ7rdc64UrfOgy4V5utdzndRkDMVexs3u56
 DsGG++RbhT5PIifRcB2LguUctQBnES1tZvSd3C1iGlotOy2AhizZ/DHIU2LkMp6lEH/EVnKP88I
 xYwbX52XHZpjCVNyN9i3RJrzH0kgwNwIBrtwU0E7CmF2CwP0jXvGHspfyVM3JktGTRchDVfSZyZ
 CEUFKYf/
X-Proofpoint-GUID: XIMX0kbZO5ZLWcCE5r-e7Cx4mboJWKSY
X-Proofpoint-ORIG-GUID: XIMX0kbZO5ZLWcCE5r-e7Cx4mboJWKSY
X-Authority-Analysis: v=2.4 cv=EZrIQOmC c=1 sm=1 tr=0 ts=68d14c0c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=t7+/ES3qvP6ClPp5AF2fig==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=DlECaWPWOyncsgY1a_UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033



On 9/18/2025 4:28 PM, Marc Kleine-Budde wrote:
> On 18.09.2025 05:46:44, Bartosz Golaszewski wrote:
>>> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> index ea41f04ae1a6..8c253091f498 100644
>>> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
>>> @@ -16,6 +16,7 @@
>>>  #include <linux/bitfield.h>
>>>  #include <linux/clk.h>
>>>  #include <linux/device.h>
>>> +#include <linux/gpio/driver.h>
>>>  #include <linux/mod_devicetable.h>
>>>  #include <linux/module.h>
>>>  #include <linux/pm_runtime.h>
>>> @@ -1797,6 +1798,178 @@ static int mcp251xfd_register_check_rx_int(struct mcp251xfd_priv *priv)
>>>  	return 0;
>>>  }
>>>
>>> +#ifdef CONFIG_GPIOLIB
>>
>> Any reason why you don't just depend on GPIOLIB in Kconfig? There's no
>> reason to make it optional if the device always has the GPIO pins.
> 
> I don't mind having the ifdef. But it's up to you.
> 
> [...]

Sure, I’ll add depends on GPIOLIB in the Kconfig and remove the #ifdef CONFIG_GPIOLIB
from the driver in the next patch.

> 
>>> +static void mcp251xfd_gpio_set(struct gpio_chip *chip, unsigned int offset,
>>> +			       int value)
>>
>> You must be rebased on pre v6.17 code, this will not compile with current
>> mainline.
> 
> You mean "post" v6.17? Best rebase to latest net-next/main, which
> already contains the new signatures for the GPIO callbacks.
> 
> regards,
> Marc
> 

Sure, I will update in next patch.

Thanks
Viken

