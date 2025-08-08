Return-Path: <linux-kernel+bounces-760042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DC9B1E5E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F3F5189173A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195F22701B8;
	Fri,  8 Aug 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gkMAqT5t"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881726C397
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754646440; cv=none; b=BJuKvZo+tg8x5KJXyIgiGDrAiuMqYH41wmBGW09LCNi6pxdY7QYVf1YXBlI0a09lcCir5yv8+BVlKcg+x4rtn6EzPoEHRBD6FXxhmfHZAQxp6sCAxcRwXYGoTdreQidNpY5s847a1Ezo0TFkI+oL5TOS8b7uptXAmt100iUUSco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754646440; c=relaxed/simple;
	bh=N76AjeKqWWaDCP1rb8c1+wvNKkVDpoXrk1DrDsc9vc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=if1kirw4vp5XScDk2Jy1lcnyva7DMacMPwcU4HoTsb8kFVT8I2lyoFD4rnyst/yRZpHH/Q/qUZJD9tN6SXmFCnDfumiLf7R1zGfw8+fPPg7vnfkXq5Xo5ZR9XSDeIJwT+9/NyQgv1HLD3e3/WuGcoXEzGOBo7jNORUHZEUgDa+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gkMAqT5t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786v9h6020676
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 09:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c5LHAQzvnX1on7gg4etzzi9ms/GGnbrPCaWqPhltrcE=; b=gkMAqT5t8cQfD9cS
	qcYMunlCYEiEYe3EyORPs9nF8uLZv36b20wjbimXWWWE9FbJXQVZfttf/PRvlors
	GY/fOxK5yXW205ktkdNQW2QnGpU/F0jfjnT+NE343saXYDjeGoR4Yc6s4iXZTpYh
	WnfiY7SiKWsAtSoOtn2XPndGq31sAOnYJgWLxl8EB+tmEL0uqufsOyZL8ajxFZvf
	ihUjZl3sxUL4PzPGYBZbT8dFgZrG1MAK4AabRWhKKiG9YHQfezvYijya2MDNVAgT
	AkTt6XuyZIovmdU71kcJcrMGeRKeNNRfkEomxHHUrxLgrnDHKHh0mIu/FDg5iRYf
	tsHy6w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy8hm1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 09:47:17 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7092ee7f3cfso4983616d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754646436; x=1755251236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c5LHAQzvnX1on7gg4etzzi9ms/GGnbrPCaWqPhltrcE=;
        b=OdHXS89YFOS9Xzg1RaESKJFwQGwtU+djkDJ9IYM24otKo2zIOi/qsF3dGoTNV7y0Mb
         L5Vu0rihRG/ULxEw2WMzhdo9L97zTthKqdJDFU3UzPT3Ikd653P1QoESbpEYIrEd05R7
         1+mZmyr+hD98oPzfTkYamdZdmcqMeM8kFoGKpMJbeemfVZljJ4Scw8SBWS69Rgk27R/z
         twF/yRnYYIbKkKRrz/utMEZOTdt53NsVv8/xpGBj5oIdEwSz3a7xDepD+ZHzSIlYWCZw
         ofP/h24A0x8OA4Z8YZuG/kvHMcKbtO9q4PIQO6anjBZ9UW59+LFCKXozZ9G59wgVgT1Z
         EQiw==
X-Forwarded-Encrypted: i=1; AJvYcCVnqhU3J0bwJ6fSIPy49qTsQ6OTTyHqO+Nd4pG2A+uDhvWE+jHyxjI1HUmVGNFmo6A9SBv2TEA7y0387w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSyZ2Qu7/rqkfigcqZjDXs5eblXlsn30J70fDulimMdGmJ1fsr
	saSLU7HhKUGhUrJJ9DizTcEaFhMR5ZKe6I/B/CD62ASO61VWdvE5Mz9JRCv7OvyRFZoxita6J3s
	gH0p9RIorobJmhYXyCYAwMaFC1k5kmTDff7lJQF5mDzBXwejggYPq6Rm2gOWVLnt+HdE=
X-Gm-Gg: ASbGncvrI/yTUQihB+kYobTtmB9587Ut8Tl2aLl3OFfVivM/NbzY+Kn0kQntJrfd2Vo
	PGwLHZSxwvSgS0YNOb9xzJdBlEZ2ils0c2BVfE15KDs8kczXO7jTzLMJiO4mHYfLv/yTDntX2pY
	XatL/4GQukpYRESeSBQaCxPzfGBgYptBV5nzSE84/l0TJt+TNUgUrZiNQ+yL2wYo8oWfSESZpo9
	LguesU76QdsXExCyZGb90gI19NcYeV+3knohk7493um7rDDyb0Y9QNOjRU/AVrbTXAALpvW/3Pg
	B24Rw4mxbRZa9vTva4gf3iSEqKLOIqECxn7hS4g+s1MCnnhfkeFHl4UXEqzSCtQgj8g+/88T7cK
	7iXeSSOed5iXXnRtWRQ==
X-Received: by 2002:ac8:59d2:0:b0:475:1c59:1748 with SMTP id d75a77b69052e-4b0aee278c8mr15475171cf.11.1754646435979;
        Fri, 08 Aug 2025 02:47:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf+bmZXtrB5iN1ZcDOo7CVlLIU0Jwj0Do2OpnxiPusVz7TYkqt0exOl8J3+oBRed9YiUlNlg==
X-Received: by 2002:ac8:59d2:0:b0:475:1c59:1748 with SMTP id d75a77b69052e-4b0aee278c8mr15474971cf.11.1754646435422;
        Fri, 08 Aug 2025 02:47:15 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076620sm1457229666b.10.2025.08.08.02.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:47:14 -0700 (PDT)
Message-ID: <488da4b7-1017-4582-808e-f8f244d8a975@oss.qualcomm.com>
Date: Fri, 8 Aug 2025 11:47:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add Xiaomi Redmi Note 8 support
To: Gabriel Gonzales <semfault@disroot.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250308013019.10321-1-semfault@disroot.org>
 <20250311003353.8250-1-semfault@disroot.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250311003353.8250-1-semfault@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Jys50ISqWbe_2N3O2OOe7azdAVKHahEk
X-Proofpoint-ORIG-GUID: Jys50ISqWbe_2N3O2OOe7azdAVKHahEk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXz/lOmfPeX3BR
 WR7Y1TUfUPFieFBSkfx+vv2fr1u5O819cv/YAE/oPcywVvrrk6PQeS2Xmxzjq3OMM8e6XskKGaT
 N1pVp2or4nACKBwF3z1yIPsAW7tf036D/JH3uA0QdT+NSmm5c7Zjr0D+kHieXiETbnT5LvOFR8a
 218lQpXhcidAjsHEx7WEKgZwcXNvZIRSNZYiSa1TWMu+p767GJo7RKQZ7EIWGjklCAc1/jkKq0/
 JGWaIvjZpb/xwYms5/11rfpzhNsadsZSR/blX683VT1h/ivU1rQYh6BL0W8wIH/3FDPigmWm7Gm
 PW7DR21ogQe9so3RF4F7VVXcDHm2PzrKT0IjEuKW0SokXM9GsGrxgXul3zcdwriMnGyiYAmhAx7
 XE/IACt9
X-Authority-Analysis: v=2.4 cv=GrlC+l1C c=1 sm=1 tr=0 ts=6895c7a5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8
 a=dqPQs9Fgn_eni4IfNrgA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

On 3/11/25 1:33 AM, Gabriel Gonzales wrote:
> This patchset introduces support for the Redmi Note 8 (codenamed ginkgo). 
> 
> Changes in v2:
> - Add missing cover letter
> - Fix up commit message for schema
> Changes in v3:
> - Use qcom ids instead of hardcoded msm-id (and other changes suggested by Konrad)
> - Switch up model properties and qcom properties position

Hi, I noticed that the msm-id is failing the dt-bindings check (need
two values, with the first one being the SoC ID and the second one being
the revision - 0x10000 as there was only ever a single rev of 6125)

I also found this dt:

https://github.com/xiaomi-ginkgo/android_kernel_xiaomi_ginkgo/blob/main/arch/arm64/boot/dts/xiaomi/ginkgo-trinket-overlay.dts

which suggests that the board ID you used may be incorrect

(you put in 22 and the link above says 34 - FWIW 0x22 == 34, maybe
that's related?)

Could you please give the below a shot and see if it still boots?

From ccef64e4058ba657ada5000ec3c2aa9b682c552b Mon Sep 17 00:00:00 2001
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Date: Fri, 8 Aug 2025 11:45:06 +0200
Subject: [PATCH] arm64: dts: qcom: sm6125-xiaomi-ginkgo: Fix up msm/board ID

Include a version in the SoC ID (mostly to appease the bindings
checker) and fix up the board-id according to match the device's BSP
kernel.

Link: https://github.com/xiaomi-ginkgo/android_kernel_xiaomi_ginkgo/blob/main/arch/arm64/boot/dts/xiaomi/ginkgo-trinket-overlay.dts
Fixes: 9b1a6c925c88 ("arm64: dts: qcom: sm6125: Initial support for xiaomi-ginkgo")
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
index 68a237215bd1..52f74f22764d 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-ginkgo.dts
@@ -19,8 +19,8 @@ / {
 	chassis-type = "handset";
 
 	/* required for bootloader to select correct board */
-	qcom,msm-id = <QCOM_ID_SM6125>;
-	qcom,board-id = <22 0>;
+	qcom,msm-id = <QCOM_ID_SM6125 0x10000>;
+	qcom,board-id = <34 0>;
 
 	chosen {
 		#address-cells = <2>;
-- 
2.50.1

Konrad

