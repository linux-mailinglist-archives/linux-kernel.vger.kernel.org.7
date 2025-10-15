Return-Path: <linux-kernel+bounces-854072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA2BDD7A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4802D4F7194
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5073168E2;
	Wed, 15 Oct 2025 08:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IURcAa4O"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4D2BE7CB
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517946; cv=none; b=rkF4iUkzbxchzaQ6YTFCp6er/TGTtw5js/GgeAO0Dmyjq0apuYIQe58NSFiTPHJT2lWsKgdvJDJujealNpBcCTQZXYz4McsiceoLSnCEdftNyNoSfh+MX9ntxmIPbaovr2qs9aHAQuUG8xEW3hrdzG2ePCQsZyCmYgTCuSbyZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517946; c=relaxed/simple;
	bh=u0ikA4MtFcf5qdBMLNH0y0YZHeQh8M8PZH9kzqqmUjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdgEfxN9JcS4nwBNhG3c2Kd3NQTFsYiTQNQFMLNHcLNb7i5OEjncy6W7WVfeDcMC7a0EeAfvmM1i/Txt4AzP79xGQxh+CgbEfNg43N0TTEBD2gml9xwMFOP+pI4KBhXkECFRpI48Jfhuwz0tQx4U0lRbP/8Clzt+P2rBpbc4Vz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IURcAa4O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sLhb003664
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tT4lZcR4ZBn0xrtO1ZVUt8Qt1hpqfjpfEUFhsYPVrd4=; b=IURcAa4OWNIyJpVU
	dkvIYnvv9CxyWyiPfN1Ayf/7fdLEaBNrnnowSgk+6ysNQV+QAvov8bdIXdv0dlia
	OAy1vdwUHRlVqVzzY9eM7n2lZxup9Vp+xuTt3/oomYvLT5lQ3V5TMv0OUTzZtrBV
	Hjdayh/XwxnLQEtxIiUyN1F5M7JTVPcxQOK44/+Jj/KcKkVdCQbKJJfTJYuL15Ko
	ONaEosj0SVOYB2TWVJMG3xDith2hfUicyMOFBFVnDcicT8ECuoyp0yPWki/qzjqd
	YjBdA+V7mci9/R6qI3utMV5s0JFCBGZZ3cfz5xKgCOwSMT1XCvjqD/Rj376uPaLX
	bZ+D+Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd93spk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:45:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2698b5fbe5bso133388295ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517943; x=1761122743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tT4lZcR4ZBn0xrtO1ZVUt8Qt1hpqfjpfEUFhsYPVrd4=;
        b=XKhpUXnFdl2xpwPLZmqP1AFQFjQMLnA7X5khsBdbm6dYSeADUTze0Q3NSz7bdTrGTt
         Zr+MySrrFH+Rq6/kYfFoUTt1LUaokaXySwwFSL085un+7xmaVVI8idgja436zUquyqgY
         zE9Oh54xjSSWVYl+p/+SF49HESRP6imLha0pPKFezZXhDGr+bCrArNtKU9xa+2rGXDtk
         KgiQ//G9j8N5TBz16YrgOSlXUSM1BH0UJm6Vst5Ms4xfIBtZ/AxylIsT0AX1w3aDke3S
         JKSwCwLlMUl7DuTqGekku4Y1CI/1gHTPni1RJJV9p63cNx1ciB1aLdKhirgPwu8IqU1o
         HB4w==
X-Forwarded-Encrypted: i=1; AJvYcCWBG7BwBVvwCr/++fQqYVIXJ1LIFBOu/z3vIpSB8HE7d48/2wAswPw9MPBisAfkZtwS0l2QXz/wEiljwKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPAD3dBKWSJy/3qOi6kvQgc1rdBZVZ8BvmDYPRe/lZdbu5yQM
	cjXRUOAtjT3xxZCiLn2Yb8e5ksOvs0UMWuo8X+7S2A+Sjg/XCRD2TQYZy98F0Zcc6TGpSbpr8mF
	0Rv91zRHur6YZjO5H1c/gr9Mu0ZfQR7Q0IukuSfzczL9RhLeqwd8mIGqXn/oKS8IWmyk=
X-Gm-Gg: ASbGnctZZS5nO/iW71iwMdtH+kvBhtxr4SrfCMT9tcMJGDMagJ/14gDkAtAyZQOHOVP
	xNDHDStOLFE0cejWdFtO94NA80sMlhKlISinBHgLJFTIDXWFB5sL2lYDqP08jzhzJkYPhk7JAIN
	NmhpKezml/PxlmFB+zNwozV6mO4I7jQlqMQhZNjK5j9sJgA6nlL42Ddghtu3aC6qdLICJfo1uH/
	DbFKb5pUpih57bRqXuk62LegczaKIy5cqGSqkq75KDgElOSvpvZm3HIVahRybmQrCtaMhH/eJtW
	DFQk44wAVeyjantLg0YF3IX/c+MLqvOUH61UmLCijEBxYgL95mbvwk3f5D6z1a+seyIOu5Q=
X-Received: by 2002:a17:903:4b46:b0:27d:6f49:febc with SMTP id d9443c01a7336-290272159d1mr366508605ad.1.1760517942817;
        Wed, 15 Oct 2025 01:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGU68B7KHWBtJSF6bpxGSTAtxK+b0Uk28zSKf6ArLdpmJzPhB1kHcmTwbavGcRZRkHHk+Bc9w==
X-Received: by 2002:a17:903:4b46:b0:27d:6f49:febc with SMTP id d9443c01a7336-290272159d1mr366508125ad.1.1760517942284;
        Wed, 15 Oct 2025 01:45:42 -0700 (PDT)
Received: from [10.92.210.195] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f07741sm189006475ad.61.2025.10.15.01.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 01:45:41 -0700 (PDT)
Message-ID: <f44083bf-a54b-415c-8650-a57b3b482572@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 14:15:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 05/14] power: reset: reboot-mode: Expose sysfs for
 registered reboot_modes
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
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
Content-Language: en-US
From: Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-5-b98aedaa23ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: GIgoh3jWp2NTSwZkbLd9IHLHFD0SrsID
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX9viICy8k5l3t
 ucNlBAnBNPBJvQGywKWWyo3HFfC+jpTk9ClwytKGkEQ4907zKmCwHIQYL8QxOK/QwGrjVg1MGao
 V23IuMi6zDwUkXJY5eyl2CA40jZpF1Z7/QwHUacbGeEF8LyzcnexbJKVwdHw2O5I8JxZ5SP37jf
 so3bSD/3envcwN5xLM2+y1igD+xMIPGWGYn5hq8x0efk7+1uGCCOxhsqGox3La2FNhH7JxI3tuh
 LH3xZg0C26yw1iT4RZ6M9NuOofcdBufHTs+XmnJuDxkP7Rby41mawGhikQjoHHIzMS9rLTTs2Oq
 jaTBrhXgu1SKVTmaEkIu6MwLWaKMv7sa3JmhRJMlk5HPRdBQ/6Iuazjte9bpHXZRKBKHDQJDr1D
 vwZQPNnkhntnQnVrHiI7/s3aQxGuJQ==
X-Proofpoint-GUID: GIgoh3jWp2NTSwZkbLd9IHLHFD0SrsID
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68ef5f37 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=obQkJn2dBRx5tTod4cUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018


On 10/15/2025 10:08 AM, Shivendra Pratap wrote:
> Currently, there is no standardized mechanism for userspace to
> discover which reboot-modes are supported on a given platform.
> This limitation forces tools and scripts to rely on hardcoded
> assumptions about the supported reboot-modes.
>
> Create a class 'reboot-mode' and a device under it to expose a
> sysfs interface to show the available reboot mode arguments to
> userspace. Use the driver_name field of the struct
> reboot_mode_driver to create the device. For device-based
> drivers, configure the device driver name as driver_name.
>
> This results in the creation of:
>    /sys/class/reboot-mode/<driver>/reboot_modes
>
> This read-only sysfs file will exposes the list of supported
> reboot modes arguments provided by the driver, enabling userspace
> to query the list of arguments.
>
> Align the clean up path to maintain backward compatibility for
> existing reboot-mode based drivers.
>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> ---
>   drivers/power/reset/reboot-mode.c | 127 ++++++++++++++++++++++++++++++--------
>   include/linux/reboot-mode.h       |   2 +
>   2 files changed, 103 insertions(+), 26 deletions(-)
Reviewed-by: Nirmesh Kumar Singh <nirmesh.singh@oss.qualcomm.com>

Thanks,
Nirmesh

