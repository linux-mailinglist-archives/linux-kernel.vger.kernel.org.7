Return-Path: <linux-kernel+bounces-846241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB16BC75B0
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 06:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184F33B77A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 04:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F382459F8;
	Thu,  9 Oct 2025 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XHZFYLgZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12297240611
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759983388; cv=none; b=oSWAabn8k+UG8a6n3STTMCMNH5ijcgaNj8k3UralVtYuHl7OTjVs320cXwzH8ac75Nxxpdyb7z3mqAGQhWbqwLUW8Zu8mYvdGUNnXewrlEkE75plwrbocYerK0LiH5VEQOCyXYJueGoiEJ3PNw/WGM3fIN3tCkUibBInQ69rxgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759983388; c=relaxed/simple;
	bh=u7Lz+ubu4/1tXnCu0JIWk++I/7M7DTEbDaUucDlh2Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJUIlvhYu6n20sad/gGDS5tHL1P5Q7+QCom5g1AL05Tiy6BiPlsycQoznCDfyqrlpV2IaJVIUBmLbDpfBkeOFHZ0i3MhMMCfNLJ5YdE4y9W9o4euIVCzeBkqnK48e8q3W/6E9RbkNCOrOItrTxcbZWUy/7syFUJX9iuqnmiwyGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XHZFYLgZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5KRv014334
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 04:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z/wdRyhztOnxEiG33RJa6Kf0OnFSv+4r6++4AXqf4jY=; b=XHZFYLgZg2Ow6PRS
	JUclyU+TF0z+pY12ZqtzQNQ8VrlNuUg4Xhs2eCmPHAsMuCEbCoWLl6Ys5FMv8+E8
	89gfBpvct8WYZs9kbHFEk6okh2RczPluDauSmMVRl+lkdVU96NV+QtPgzwPUWJQm
	h6zb3/e4EaXHY0MBqFk9RCBk8n/AJAm5HY9N7x2IE8aDV9a4jkhwtqTyXNjLHRaC
	t0b0eyL2VXf5Fr5Q1DHjvqo+HSD0rwxgop4rzn/M3rRAe9+rD5erQYhu6h0y+N+r
	oyPAcpW4+DhSvZFelpYG8LFvhxtKhQzLFhLqm0ZFGIv9n5wijiJW9KMVTFbQUaeS
	SGgAHw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u1dh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 04:16:25 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54aa407bc7so164858a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759983384; x=1760588184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/wdRyhztOnxEiG33RJa6Kf0OnFSv+4r6++4AXqf4jY=;
        b=feishiXV7XRZptulcpxuYXKiL2twM5vgQkgJvVwtB2KROoL7mR6XdAZoC23RvVk270
         +CF6v5un6DKvoAJy1Y+OPlhCRbmvbZt0PEIICRJ3kQVF05fJX1UtBhNbfpeWMfVerksA
         KD5TFofkZR8P6wVIoOyaxMW717Oh8Oo2chSorTRR7G6LAniyhx0kOxleqYZ9ZfB09I7X
         xqhSuf6UiK4pmBV65Gwr2KFe3Y+rNj7nGYg6jFMEQPnhenHxMcR24FV2uBrOUu9Cp8gm
         sSqysDxzmvHKZRPUI2I5ajtiVAZwAfhQ6Bnb7LfP4Un77r1+LMyhU7/7Jg4iGpU/Y+VZ
         x8ng==
X-Forwarded-Encrypted: i=1; AJvYcCUt8io0uK6ncOJp303Iuw9gLY8A+WCuhv0geUUq9c9SOLmwFSHAG33XgW6TtjoQR0OWFQ/ptPxSKpagHlk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1LBA3ojJnJlbk/v9/+QBJ4dbrx+5JfPWHaX6/McJ05Mvvsus8
	jGGa2gwCMm5BzLh+xqhwg6KtVTWM0ztomRQ9tAR5MEmvXo2QCOGSZnmUtEbx4Lig5g4Il8SjVpY
	AqLxAB/Hudb0/vmn6m2+MYdJZ/KfgGVE2+zqWcHi+omLhhptuigoHB10Os6F7U3wvQ6Y=
X-Gm-Gg: ASbGncs3nrtRpo42CECFM98g89t4pW4L8j4p5WCoDyG4VCGUN9GHO6r2pqw/T8kjoLw
	iF69i1V2VJVVOkOGZH9mnZRqTBg3tYxNjthEkv9tYHiqU7KbHVIWk75cclP7aICvc+wzSKmun70
	1yvlzizPsPHLVjPPQTtoKeLNZ18MfAzasozDGxquwKIWQ8HVk85CRLx5ldG3kG74tlCzC3OPpJF
	W3l+E2hnSnmVWm6jciz/yjvNlyVQ6p/x71X/dE+A0gu9jcI+GV8Q/3n7dAACNG31OMl5N0M9oEd
	J1KEJIceGgBhgOLGB805dKlO325F5yv9hlmtGvbMZ88nRjFLgoIpaRCjnq0rfU5ZAgkbVUTdZ0E
	rV0r+trr/HWRwxwR6puv6ck5Dh+5p55Lh/n9fZMEa3Q==
X-Received: by 2002:a05:6300:619c:b0:2bc:1f29:1232 with SMTP id adf61e73a8af0-32da84deb91mr4229039637.7.1759983384478;
        Wed, 08 Oct 2025 21:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfQd96vAGN51vtHjr82AtIlkinA4yVsIrZBAw+ojodJrmawHih66RQcFW7/2SrnnG0euQhHA==
X-Received: by 2002:a05:6300:619c:b0:2bc:1f29:1232 with SMTP id adf61e73a8af0-32da84deb91mr4229010637.7.1759983383989;
        Wed, 08 Oct 2025 21:16:23 -0700 (PDT)
Received: from [10.240.201.55] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-794dbc5a6c5sm1359671b3a.54.2025.10.08.21.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 21:16:23 -0700 (PDT)
Message-ID: <090c08f4-b1e8-4af4-b665-7894a1443ebe@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 09:46:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 03/14] power: reset: reboot-mode: Add support for 64
 bit magic
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>, umang.chheda@oss.qualcomm.com
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
 <20250922-arm-psci-system_reset2-vendor-reboots-v15-3-7ce3a08878f1@oss.qualcomm.com>
Content-Language: en-US
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-3-7ce3a08878f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e73719 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=xyQZWzCWjP-v2z6xiYIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: AlgL0aVU32-icANy7Owq9I8WAVhbnNu7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX86mZ9K5meycG
 UmFXmc9g7nF9iNRgd6ER3b3ZghggU6vTsTNNLStqtaExxQCu6C9o75DSygKOXaWfU62O5Fitbqa
 bou+kRPaA7D1Iwak38hnG8Ta+O1TnFFYiwATlFcEaGGqgP38i7LebN7SvIG0WZr6dCvGE/nn+xx
 3lH/IK8TyEQ7nd1R2DtvX21gAYqD+nRfOdJo9n8AVXKPrV7jD1CL03TtsJ1ygZ5j0qxdYB3cGpQ
 oB8Xcj8HrumaRagjT51yEsolQfKYOmIUzLm9usc1DwWFKSieOq/bbXEz1phvORiwF7pJF9rYIhX
 L5rtD0Izr2jYxII4Dz813/KPv1bqtbP5EO+S5lX9F1y2klfTM3siirOpMaYFPC65TC3Pf2efx3V
 3FvniE45wBMdz7y44n5u6Q5CiGz84g==
X-Proofpoint-ORIG-GUID: AlgL0aVU32-icANy7Owq9I8WAVhbnNu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121



On 9/22/2025 7:10 PM, Shivendra Pratap wrote:
> Current reboot-mode supports a single 32-bit argument for any
> supported mode. Some reboot-mode based drivers may require
> passing two independent 32-bit arguments during a reboot
> sequence, for uses-cases, where a mode requires an additional
> argument. Such drivers may not be able to use the reboot-mode
> driver. For example, ARM PSCI vendor-specific resets, need two
> arguments for its operation – reset_type and cookie, to complete
> the reset operation. If a driver wants to implement this
> firmware-based reset, it cannot use reboot-mode framework.
> 
> Introduce 64-bit magic values in reboot-mode driver to
> accommodate dual 32-bit arguments when specified via device tree.
> In cases, where no second argument is passed from device tree,
> keep the upper 32-bit of magic un-changed(0) to maintain backward
> compatibility.
> 
> Update the current drivers using reboot-mode for a 64-bit magic
> value.
> 
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>  drivers/power/reset/nvmem-reboot-mode.c  | 13 +++++++++----
>  drivers/power/reset/qcom-pon.c           | 11 ++++++++---
>  drivers/power/reset/reboot-mode.c        | 19 +++++++++++++------
>  drivers/power/reset/syscon-reboot-mode.c | 11 ++++++++---
>  include/linux/reboot-mode.h              |  3 ++-
>  5 files changed, 40 insertions(+), 17 deletions(-)
> 

Reviewed-by: Umang Chheda <umang.chheda@oss.qualcomm.com>

Thanks,
Umang

