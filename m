Return-Path: <linux-kernel+bounces-739895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E2B0CCC2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B86FB7A86E3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB65248F4B;
	Mon, 21 Jul 2025 21:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8WmnVEi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E462242902
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133824; cv=none; b=PrwRLOKPFAmvywrJGQeqjxKotg6Ix3jwqso8FU7YDIGwyrURXBKvu3gSbT8fXGSjETfDClyvdHH6HwHz0GvEzdiMKz47XmwxFqAZNGZlZ2360vBXklGOentMnHOZ+345DViwfEwuHW2CN9xjtTad6pqi6oMbdmnD53ZlEooeA5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133824; c=relaxed/simple;
	bh=6/8sh9FIRrN/onOMmrd57UvJNPhDQ5MWjmDf9Xwi6AE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mjgu7u3AybBAmKlXBvSARtpjbS8JJIryfOOn++p/kuhSWj69TZ24z/2UdZUY+wlFQYW9iEllyj8gCI6MKuxiUlmzN/TU/qFBOVkiT2GXLBJLRlW28LfvtutHaI2ZQjSg6Mh+yTIu+0vARkNdSl2A0FyjTS7huVgpvjnUI/pAxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8WmnVEi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIiueq008155
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lPcgGzbA0KUdErOP1JgC40238+925SiPcxECv0Z461I=; b=k8WmnVEi3w/vwsXW
	PwPEk9Ty1pJh8wC6vP4mGm9uNQ75iYArLUuF1I68umdLkyEEgzmEcFO+wLtSn8FV
	hbylqOYIabCi6xOU+s0M1z8Jdk1YoTNIkpAstVwmija5sjaOjtefEJDNAm5INhK7
	NNbdTkY3dQ4m2g73kRgy1dwqkE/G5IL8T4UDgWUmMhIisdHyFH7kVouUW4n3EUYF
	NTSUc0yGoAIS5PLSHzbxY6ggRUOxZuaF9iC7GIsob2EuCVW+/4eWxefUvJAcYHrc
	bBbJV34B0coeeFvaD6t/Hmad5xueBCevf4Bj7/cWE468cSVqO5yxe/6gd5ESXidT
	BnYZwA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048v5k0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 21:37:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b31ff607527so3414924a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133820; x=1753738620;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPcgGzbA0KUdErOP1JgC40238+925SiPcxECv0Z461I=;
        b=sszunON+yQIXBzRYt6uu1tXcSak2ygUXwhNy1hAZGzdOzCQ64iiXb4BZ3LRbMeAQq4
         nnc0ZT1m2eU+2k86bV0hYyxIr1FvkEJo6V0rghLwmr/fr6A4R5Ac79/6mDIG7LW6XTir
         p0+iLTdG9PqDYMFCc1uFbNU+xNH3RwI/Sqtg5W1O2Xfv5OoU+3WPKtclx0guAKT+P8nN
         i+9Tmj6uirahT/PcCKam+QZW6OoQ2j0E4DIHPjDnnvr6yl7naqXJOdXL+QLUTicdczsl
         n7w8EeIrKNXjOfWZS1ZyqruciPfp8FroHj8302r1aYBmAZTBOjpUFEe03FjS+La0wehJ
         fLrA==
X-Forwarded-Encrypted: i=1; AJvYcCW/uki+WnJ6p75D7SNljZ5a2c19pNJuDnJ8jgqldUPa2cy4PLyVNzhiTGQ3Jfyy06+M+soLGrvq3Q4Mv3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVyPnhxZwJZWQyFfRcWNP5ha+jgco4R36Pshp5J0ieG3ZsjVQ
	6EhMfQZfNEylGjH71bIrTb57HorunGhBgGXWGXkWJQLpO5Udi0wx9uMuJmdRgnEMSVrLWr8t7u8
	md60M1/hPMz2VqvAiO99u4nG0qsmfP1sK+m7YJ/sHUzCpYIrAMz59jELSdUDWctTc/nE=
X-Gm-Gg: ASbGncsZ3ulvtdXgSg+P/T1GOfONlggXT2PE7mLtqVp7nJ8B/RHMbODyNCvDD9hhSoo
	apGL9pMQHYUIB83oIKqCHb1/ASHbaT/hT2Km609kXbucACCxFSKmMSQ5hoJz+JYlYPhn+km21Ba
	5nca6D/f1gNqJWipjnE2LOtqUnUoXU6M3Ya/UkBSH/DVFo3JHsdpyE7cYtXoW0yUU150sY+0Noz
	J3q/mAwUCmxeHhqPPVUM8/KcCXV5hOYg44ORhbXBZdFws+L/udzCaIoamGdDip6K0KtF4tIV6hm
	940E0sKeJ9aalTMYDuO8aSURwynNDgsEkfPQIp9yIk8CYb0BI4wQMgZsAITEPYTk9OdQ1Vvsiwb
	J
X-Received: by 2002:a05:6a20:9190:b0:235:d440:ae6d with SMTP id adf61e73a8af0-2381325b204mr32639337637.32.1753133820579;
        Mon, 21 Jul 2025 14:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELTqLiRg4xv5sYJl9vyevXPnhafiBzP9GM1aTX2FGfEeKB47zqZOfLEblRRt8Uo61FjlipPg==
X-Received: by 2002:a05:6a20:9190:b0:235:d440:ae6d with SMTP id adf61e73a8af0-2381325b204mr32639319637.32.1753133820183;
        Mon, 21 Jul 2025 14:37:00 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbc68046sm6201934b3a.151.2025.07.21.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:36:59 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250720-ath12k-zero-brace-v1-1-d8c8ca9d40a8@oss.qualcomm.com>
References: <20250720-ath12k-zero-brace-v1-1-d8c8ca9d40a8@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Prefer {} to {0} in
 initializers
Message-Id: <175313381950.971667.2781590137376114302.b4-ty@oss.qualcomm.com>
Date: Mon, 21 Jul 2025 14:36:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: XxdEvheBbNVT6owtoPJ5lY1mqSPju6G8
X-Authority-Analysis: v=2.4 cv=SYL3duRu c=1 sm=1 tr=0 ts=687eb2fd cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ezxbitWhmWwidbw5SqwA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE5MiBTYWx0ZWRfX4DON71dwuZ32
 VTnMId0354nVv5mOK62RnJEdM3/jTGpAQiywBqkxPbw+NtckAp/c6u4UhnzxQhwmq1GO/H0zwGb
 kZ1mewSP4FyMivYl8wTi28RoLKR9y+LkB6p31JZkU/vQcL/m26l6AZjUv2vwNpqbO8xKiyj/qZl
 7+lLfToc9sHtTiSAU2CKoerkr7uTF8BAzGqRORYFYOvfK9z46p1HNp5v+6Vg4IlnC6GUt7TSoae
 CvjUTxkC9oUoagdv0D/UtLCu6WFgsZwvOmVXf8Ov87RMktIrNRSehQz5DoOeppGlf0b8xJtaORo
 PYs7yTbO5YX6vZbVcaLFxBIOd6ik6P5h0jNQ2DKmeg1jPjogRTfJ1I0ENpuLkDQO6bGM6sCCwhn
 dLxBIou0rsovTiBSiafeRTnCwMlWFOyTPCMnBMGERLXtPb2Af/zCL6FuKgcUo+rWJHJlesNh
X-Proofpoint-ORIG-GUID: XxdEvheBbNVT6owtoPJ5lY1mqSPju6G8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=656
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507210192


On Sun, 20 Jul 2025 08:24:14 -0700, Jeff Johnson wrote:
> Prefer {} to {0} in initializers since {} works even when the first
> member is not a scalar.
> 
> Generated using:
> sed -i 's/{[[:space:]]*0[[:space:]]*}/{}/g' drivers/net/wireless/ath/ath12k/*
> 
> Compile tested only.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Prefer {} to {0} in initializers
      commit: 306facc029ba8d217ef5a46e8cf4bd50c70603d0

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


