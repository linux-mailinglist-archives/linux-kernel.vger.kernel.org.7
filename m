Return-Path: <linux-kernel+bounces-831490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E421B9CCFD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C46E1BC2CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8058D1E50E;
	Thu, 25 Sep 2025 00:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZTjssyr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7821FC3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758746; cv=none; b=QyoRmESDsbDlM8rzLLffHvwZuDqQEdQ3oaLJ9Ra4kLXF1QbluirRowKx/N6cGhh9pxExqGztCi6htZMCj6ZTp2juCUzhHivSKHpbIsofUJWvr6uuefx8B9TpgXg+xdCnV9hC4EHCwTlmhACPg4os+s386rJt2p4zv/rUAPCBwvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758746; c=relaxed/simple;
	bh=0pJ4e9b2YsUb2eS5f2QimNQbtaplqOANUg83w8SfdiQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kI6dRALqlp1bKkMS9kfm9U7VPpqBElcshFMhO6Ev1dO8hTYv7BIEpqlNf9m+0Km8JobA+tArDhB4AwbtM2yxGGFu4d9lZaLVD2+BuWEiKcwlQ9CmEJQFLABIXHolbL4x6X/+9yZmbWzQYpcxaXJ+F7Fum+TNXIxS7YZHjyQx9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kZTjssyr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONhlws025089
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4o8tPMRVDFLTbRqPrFNvYj
	X9roH4TrzF+SJtG3yRhOs=; b=kZTjssyrqxuZzHpuP1uzsPUA/u0Br3m7D1wMw4
	lUrUxL4d/lTor0Wy00CFrhAieJkBesEQE95AhyNPRadxBGpsnOoiXZYL0rZgkKoi
	iXzQHcE3uvYHrNt2lQGqFpk5/QddIl/TUuuIiySHJpjSCkykTZ/HRNScEwqFdZFu
	l6+LmVhcOMpdQHLjmsg/NSP++Pc/UZzkZBIF1MW4ZyhvTVdfhYsAtl5qXXiEmpks
	ZONDo/UAxxvDUL0X5PK6X8IENZ4MQapY9UfEhijwHQNYbenFH9xy9MKwu4rCYp4w
	y5hZLqo7HTNkSwnnWk5n1z5eQmVv3dsbP9f131tM7uFXOjXA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexeg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:05:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso251517a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758743; x=1759363543;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4o8tPMRVDFLTbRqPrFNvYjX9roH4TrzF+SJtG3yRhOs=;
        b=fbrL2Ma/4ZP1Ef6oNN3NJWJBasdwGMwtpvOGnbKYzABLqPJFSgFC62XuGV6Gj+gvxq
         9lto5Nz3Z1M+WYEbwnf2INp5ShLuGa8xnU8t+ugBzAwF9nAnvPp67xYpD/QSGMlCtAHv
         pZMbS1MRhHnkWg3ROQTxHff6nydvqoUttUczV910+26tD+JCq1KyWwIdujxuD+KiKx/X
         FPYhwnSZ12Yq9K9+nzDoMYcB+PetO21FphICNUuBRpNvDqA6NhaLDgvL0KeHSw1j5BHP
         OkqqHKXlMX7r8ZxQDzM/6f9XppreOT2Nkr81saw3L9iHM1Ww0F0uGtCkP1DQUJ90aSc0
         7KrA==
X-Gm-Message-State: AOJu0YwH93/6+6XJxR1DjyRrasER+g4SMuVFzk+1gIO6F/7BbsDysF1H
	V/dTMzBsBpwT1Z4vsd102shxLuvbv4ginDCmHkKoXWGSjffltysQxOZ569kvT4qcLsfPLKP1xB6
	dWbFOHq7B2bVzt0TCqP8cBQ9htZPM7Z14rzFFBaHiWb5asCkDAOpYkQGEs5ATlU28j9U6+AK67v
	2eIg==
X-Gm-Gg: ASbGncv0oLkke/4xC5osqlmfZsaOMTiseQh08mwqXpgp4UYyqwBRVGp45fsqINZ6Wg7
	7FplLbE0xThChaFnRKBPtQ/AiIRmpJ6OwvqJhtgIOTivSKpkhOnTvK5jju1tS/Z0BjBzFD6/SfW
	RFGse94DjXs8Pyw1kDJHHcRP7C4B9CtahggbJFo+zvHLsvwbXhafldTLG0ItzF6C2t6JuT6LYXn
	4UgNstb4eScNzfQtgtw9QciPUr98ZGRvHkTuE5+z9H/9OiadhIExq12l+bzqu/Oz5ghDsBJu2wr
	cWxfUWXpqTUph6YxG+YbFklYyb9kprpAnook7ik42PjZBBarhWGuRmJoeZLxKpcH+Lt7IuCN8c4
	Z0cGBeoaiQlBjZxk=
X-Received: by 2002:a05:6a20:3946:b0:250:f80d:b334 with SMTP id adf61e73a8af0-2e7a8a7c22bmr1700948637.0.1758758743466;
        Wed, 24 Sep 2025 17:05:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq8xCLjbjLd7d4DmoDXO5M5BxEMylKhzXGd6kpjOpboI1+Suo/hzj/GCc3BDFfjQR7K6o3HA==
X-Received: by 2002:a05:6a20:3946:b0:250:f80d:b334 with SMTP id adf61e73a8af0-2e7a8a7c22bmr1700922637.0.1758758743005;
        Wed, 24 Sep 2025 17:05:43 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b274dasm234024b3a.63.2025.09.24.17.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:05:42 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] arm64: defconfig: Add support for Kaanapali SoC
Date: Wed, 24 Sep 2025 17:05:33 -0700
Message-Id: <20250924-knp-config-v1-0-e2cf83b1932e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE2H1GgC/x3MQQqDQAxA0atI1g3YocK0VyldZGLUUBolKVIQ7
 +7Y5Vv8v0GIqwQ8mg1cVg2dreJ6aYAnslFQ+2pIberae0r4tgV5tkFHZL5Rlly6njLUYHEZ9Pe
 fPV/VhUKwOBlP5+JD8RWHfT8AVAoLgnUAAAA=
To: linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758742; l=952;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=0pJ4e9b2YsUb2eS5f2QimNQbtaplqOANUg83w8SfdiQ=;
 b=G6S3uQhleJg5UOXbMs+dn811yTJXOzJJwC2hPNlH0GzIWHr9JzfPHmBbOSAsdJUr+67o58J6U
 wkqlzNyXpT+BCBblzEF8Ol093fx2KEiLT/+YnjiomuguCAoUDFR8ing
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 6dcTQm0HFSU1zWY2CozqiTFu1HpGZiNP
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d48758 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Jf7HJl0tfl6guTJI0LQA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX/GnXvYlEPssv
 hYBss8GlKnKyiwO3DtEYo07cSdsnC1/JRw/l79nAnJhDNghDk69MnN7bEIuC0RBB0m5thiDz0Ti
 9x8uni39X39bTfp2jQ3C//mUjH+E5v/7a/mkKqjxipxHa1sNeuRDmu5lBNizaNaU0mN7t1kHa8Z
 NZh8uYoiA2xydoVMFk8cPMQUSBg91WLh+6KhBg6DyejGifJKtgBVuxYbgDfT5ibQ90zri69Lf9n
 MbI+PPEs2loC6WhcHA8/N82F24AQmz12lByP8e+BFvlazC7skdec65QP2bq9Xkm0X2KGVcH/3ix
 IEh61caECotfjQNKfijXBpLoW6E3ZenQUwDMqgWYOnoxMt4bDGdXNOqjybd3vr3PoyolIzAgSVt
 vvCTUt4y
X-Proofpoint-ORIG-GUID: 6dcTQm0HFSU1zWY2CozqiTFu1HpGZiNP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Add Kaanapali SoC defconfig.

dependency for patch1:
gcc: https://lore.kernel.org/all/20250924-knp-clk-v1-0-29b02b818782@oss.qualcomm.com/
interconnect: https://lore.kernel.org/all/20250924-knp-interconnect-v1-0-4c822a72141c@oss.qualcomm.com/
tlmm: https://lore.kernel.org/all/20250924-knp-tlmm-v1-0-acabb59ae48c@oss.qualcomm.com/

dependency for patch2:
multimedia clk: https://lore.kernel.org/all/20250924-knp-mmclk-v1-0-d7ea96b4784a@oss.qualcomm.com/

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Jingyi Wang (1):
      arm64: defconfig: enable GCC, interconnect and pinctrl for Kaanapali

Taniya Das (1):
      arm64: defconfig: Enable Kaanapali clock controllers

 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250922-knp-config-cc4a8e8b5da8

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


