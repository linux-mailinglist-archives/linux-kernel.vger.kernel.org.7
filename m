Return-Path: <linux-kernel+bounces-823769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F12F6B87685
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC942173551
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF89E2FC017;
	Thu, 18 Sep 2025 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJ01flzC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9D62F531F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239249; cv=none; b=AxTpV/B60BfXsPsL8Wi9CvRuI2/6ntG3Up2usQet5cwCUx5zUD1Q6oho9p3uUqW9R4zwtzel3YQFhO8SgC0GyEgoa+lbKxCguqNbBTrpwM4vbPJbt4oRFPn7YCIUhuOd16MGEtymaYyEbsWaf5I5Mu1AS5d/Ac/XiISlFIv+qPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239249; c=relaxed/simple;
	bh=ZtBQlEYE2IpLPBeAXjIankcZ9vAoUAI2Fx4glxQeQrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S/eXuvtcX9FQ5fY43qs5ssl+MZ7KAfsWXzOhy8u98tZ3AS8M94onwMXM8s7tmXF0/JnJb/GYrQqxdUV8xl+op23tQW9c1fh1nj1s++3OVXgQKiGUZ1aS6U4CgPHdYZ6UnG91agjhM07Kht2yTDCVeQM9o/BHSekq8JoS0RnxTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EJ01flzC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58II4NHF032434
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DWQsi9VmAY5hiqVKebmic+3ASrWfi4KXkGubaITn6fM=; b=EJ01flzCwkFtMRZK
	T/RYwcGfQh7mf8XXddL0Ui0VcOZz2A6flttG5M7XQbCwjYNGmdBMK63qKLAvnowG
	AYDOSC4X8F+SnZBDp8eL1GBkozGVZqG1UzVQoe/U5YKYE0CMHYDxkSYP2mWPCife
	0lQv5Gjv7kVzbyV9gy2kxQywJd0GQu432WTzTPrMBWdTZS28FI0Y9EVbJgq3rFQL
	lL00fHz6EZuDpLilei9elg++fCHtsyykO2niHyB1kXtvkGe3oXahPU+wQiWOBHYP
	A8UC62HJEnJCthXzU5wRLl5cbKyET4MD8aE5PwbU+0T17BfzBSjWMq3OWM/19PTe
	KqdWZg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxyrd2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 23:47:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-25177b75e38so20199585ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239247; x=1758844047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWQsi9VmAY5hiqVKebmic+3ASrWfi4KXkGubaITn6fM=;
        b=CKtWpqVoOt31OcYC89YQfnNq8vRq/GOCysC7ESKypXKgUrrChxrN8clYAxUz60jD8J
         5T475GxkG333uBGziWAFmPIWkSLurbw2fG8LWv1NgYIpYdXFN2EZKZimesrBJR7YjYY7
         TBVT67sd5K+I2Hs4FSL4vM5K5pgXHNoHfGvTABOuXDpgsBOnhskwV/PenoHtptsma319
         MGknfsBUAa05DoWOmc3qryl/1FRqFpi8b0NFTR9VGbTf3rFHwxj68lDUH7VtFT0V/jLQ
         Pid+aR303kpk3FXZqvfU+1evVM3QV0zWTnjcSljFWgh2TucLH4TlXJW/Hyv5xU7Ptt1p
         ojjg==
X-Forwarded-Encrypted: i=1; AJvYcCXX19ykgtLuK55RmOivIxch3NHhXID7gwmm6GgaUb2PbBE6QJyO7GhD+OVm8qk4aFUbkggA1/LSVQ9Dm/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlcImJJmAwyGsE3kP3tUlVb1wGK5bbrupTjvZCV5j1JKMGlqoY
	GopzvG/ItWfAF6FmIkIb9nHdUB3ssl+PbrsJCdzcpXaHzHfYKEZ4idoWO/CeC9VkeQs4pUtXHsx
	vfXjxdQwreCtd/9UA29rRVxdc8KNTX5mV3y7GR+/Sk8AD7ajMReNFeLyFvQn7sljQDYk=
X-Gm-Gg: ASbGncufN9QIrmcKbKT203w897ET6pqxeF3Wf5sN9gNIXVINW2HyLdfZaCwB7RGEIZz
	+pyiLugZhi53Qi6G44fKjyUyE9zYsOHjgTP1oWl014z0GsWDrHskd4WSmbN6WF2YHxMVU1x6pvC
	SQvZqy2qkDbVOc/mh5K0lDG4svLfB7BkA1ILenzhtcbCU2syRGsfcsU5IE/cGfV2JeVUqXRmiy9
	GD1VVcbyzgXVXVak6m9QKfaFtIVF3qDIsulJ+GxGyJDy/0W6CwGvrumWno0bFGDRZjzoM6K+vwr
	TaQf38REiscvwhRDZLaw6SHVQlmTP47QIJGAOUtGhlGrtmROiCZTXky2FR/QO+Xkc53EvfAln/T
	1
X-Received: by 2002:a17:902:ccc9:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-269ba46f141mr18837395ad.23.1758239246986;
        Thu, 18 Sep 2025 16:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGUIIqhflA5H84k2bWq7ZhzyXkWqR8j08pCl2uE7f7Dhq9Ex2ocDiHIw+vHMRY0ZZmX+EKrQ==
X-Received: by 2002:a17:902:ccc9:b0:267:b2fc:8a2 with SMTP id d9443c01a7336-269ba46f141mr18837115ad.23.1758239246537;
        Thu, 18 Sep 2025 16:47:26 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:25 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        Jeff Johnson <jjohnson@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808151822.536879-17-arnd@kernel.org>
References: <20250808151822.536879-1-arnd@kernel.org>
 <20250808151822.536879-17-arnd@kernel.org>
Subject: Re: [PATCH 16/21] ath10k: remove gpio number assignment
Message-Id: <175823924545.3217488.14660135878915431565.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=e50GSbp/ c=1 sm=1 tr=0 ts=68cc9a0f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=0JjSHZ6I5lEitlysoQ8A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: u5XvA72JTEHk0WDIO46R9bvVlWhnUMKK
X-Proofpoint-ORIG-GUID: u5XvA72JTEHk0WDIO46R9bvVlWhnUMKK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+GNa1o9011Tt
 MQCc3sJldjoFkBKZWi4+Foe/8R2wi4NSepNcyJYDxjzbCdLiMSv2dPH3AbbzUI5Lgy9fBrXByeH
 LzM6VUmAboEfKmqF4ylcWiMPjYM9UYsKwpl6kz0XlUv/y4FbKGVGSVXbmueoLt1/rRfXxChBTRS
 XL1uKrpB0zwk4G2/tk7YYAHJsecxz9gAotnWDKVuCbcKNyPFp+wERSBWcmxOtYY/g8idmW8CXpt
 GUhbC2flDr/pmmR6rF9Rv4+ciVIz6LZIgtmtEJpLBlt1evOOKg9QGhy2BTN3Kaqhpo1ojKKDafx
 L1QIf+d7xhTkjCv1WrsIj2FRh63m+/RMHPQipDQLBr0pkWzpTKj9X9EASeSGKjWtLFDjkCivO27
 SlV9ad6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160202


On Fri, 08 Aug 2025 17:18:00 +0200, Arnd Bergmann wrote:
> The leds-gpio traditionally takes a global gpio number in its platform
> data, but the number assigned here is not actually such a number but
> only meant to be used internally to this driver.
> 
> As part of the kernel-wide cleanup of the old gpiolib interfaces, the
> 'gpio' number field is going away, so to keep ath10k building, move
> the assignment into a private structure instead.
> 
> [...]

Applied, thanks!

[16/21] ath10k: remove gpio number assignment
        commit: 5b345471752701ccfcfa6e86e15d2cebc6e17343

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


