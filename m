Return-Path: <linux-kernel+bounces-882974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09125C2C0EC
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAED31894CEC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41526B0BE;
	Mon,  3 Nov 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSYQASGm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U7aD4hgI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19481262FE7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176263; cv=none; b=DmR3/dFy/XKzW+zZjcj4uZ3RTs8fSADN2r35HhSzVUQ5+7eDAXbxM3oQPG3eJcrL99OMpxjg9olpnyg+gPcDO+2sa5WgOkhsim2rj+3iFPUXUuA6EZPcq7BLaQMGGIZ3H8mw13fiZEAKwbDO5uQZ/TVkApNIjmO9vShev0wrMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176263; c=relaxed/simple;
	bh=lQvghmf454Nrr1HSejyrgphE01hNnR8XL04TB97Hm0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oxRx1OojvjMkPazDVcGq42GNElSrc2FMSTYAGFlruFROs17+84Jkw8QmOSedM6VS+JJ5Tik3A8U6o1jQzqpEJlF7uG5x9TXUYHNrjtlNU1TpIpiYTVZ0iziTtpDod9EvnrYEs4Z+KfLgZem5SNrtZQ3XnvgpEIcE8IA5fA2f4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cSYQASGm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U7aD4hgI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3B7ZJa2984011
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 13:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ridrxwGEIpXOZ0gdsUYBH2J8aRIkpNMjp2cQPKRYlLE=; b=cSYQASGmZSVwRO+C
	b4MN4upha8xMMs6t+LuSlHOFIzMJ/9GharfKPyGNAQ1SxWIbq9YJi539TmEjm5UJ
	VXINVCfVhsD/t/A4M9ti94wTb67G9CCAhAC8By9/zN118f31x3gNmJ3eXtNrsPNN
	T1N1l2SDIntHXHuuiYIXMgFrsZS96RkdmP3kv7uXooY1h3UembyWl3PG2Nt1DgXF
	A/moGPjwjky5FtEAaU+fQpos83xPmjylJkz4twAg9zTQ60xwDT60vahtavaTd0A5
	TWf2FQsA3X3InRfytZet8zPHTv6GOWZOxaw3w9NdU86tdN9tv40dqg8FLgc+LMsQ
	GDhyhQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6u8b0a88-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:24:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340ec9b90faso662232a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762176260; x=1762781060; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ridrxwGEIpXOZ0gdsUYBH2J8aRIkpNMjp2cQPKRYlLE=;
        b=U7aD4hgIOgQPYJvbFelFqZGhEIs2XopnTJbCoGfNm+SRLe8v3baMrO5D7cfnfjmCTT
         GNU9gVg7otqLjXEyUAF/vQBavszAkA0dM2NTuQWf5p0m5BIN6hsmNJpwmLWkW44VuoIm
         xFcFK+4ZY8dpAI3SC0V+6KgftalnTqsQwt0uaXHx6C2QNG0ysi6oZkHZLDy3gOCAXFNM
         x5LVuQOGMalgB2aU/tvu/QZjJnG0ow1pjH/85/CM0amp6BsKOo/UA40TF0LShs1XJpfy
         GSO1dNfM9HeWFz1UhYAGarjeTENwbWFovb326eBxcKTLmB2iK0kcTpQfBc7wz7hI3Imr
         eV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176260; x=1762781060;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ridrxwGEIpXOZ0gdsUYBH2J8aRIkpNMjp2cQPKRYlLE=;
        b=hbLcVxz/3920+YlmliQuGOBuIYx5mux3kYdAlhMo49W73QPv5EVCnn3GLajnpVvq+V
         wciLuLzNzHVVdxcIYvsJaxH2MngoPDzHKNKgpj+RxCO8WBgInhdNFCPUlS8UX/HMZrCQ
         +s4CNVrPg33/7pllItjzRcoKQrOPQXjw8n80nfCloEEAjoPaALSbXVN+IFwt65FZuEUP
         24aVQTOW6Ba0+NFyHGw4moUqzHRLg6ZCgFocs43rehVgUoScawyQOVYpbwQaTTsDiPZD
         XIConGtrUnxMnxKp+kLwt+/99UrFdjeVTYfGkc1qURD5tVPQj4XV1L4QDU/WnLaWS+yw
         NaQw==
X-Forwarded-Encrypted: i=1; AJvYcCXiGqn9wkPyjsBir3oFIj3HqT9P9feKG5cnt5mMHGcVz3moF+HQqKZ19Tzia6tNv8WnD1NSL3vT0uNQsxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFTgvBt4l4xPXmN6fEqUpq1kCtoYB7nebTiTUq+9RSYWsw6hr
	LsKEAdaKmOBBqAJ6jMTUOU2aIK+AMg7bT9Z4Ppv3AaBwY9uPOLuZwsENpCIMjr7764XnAABB/MV
	upjMw8sBamNzTUzzhcgCCBmkBQWhqZ265apisH8kQFWZrxYZ5tpJJEZbSer0UaUgub1A=
X-Gm-Gg: ASbGncsEToCSo/0I00/wg+TEvFJstjMOa+5MwqhtvHqmnHxWfAKj6g4ZrFGVo4nvzOH
	4shdyyb56DfvysIXxqSsnCNpYDScFg/U0Hlsp/JztXLJkPT+7f6nruyYteSrwzC+cBrtCS+5e7U
	Q2wuRGWQtpeOzfLz4pTTPNnbUlDXeuy9fAhOSpkcLbuN+DXH2+qPrthkAJ8Ee51EVhTDh9rlN+4
	+1rvEr9EGNXfaniSrroPTxo5DVAka3tLZsTug6XnKPhgpKRztE33fkaGDi17aHN8tROYuFS+xj6
	kuKT4MzlTAE8Vd+PWYIn0GNkGGNF9+wfjrRWiospxKiiO4YjMYHdQqZ0E0a2ChS4JtKjS7CYPhi
	du1OcSuShYLSAh7ZCWlWbpKFOZoBOYrPaIWknxgCULL7QgbC48L7I2lLSj6s=
X-Received: by 2002:a17:90b:2243:b0:340:be2e:9884 with SMTP id 98e67ed59e1d1-340be2e9c84mr5431667a91.1.1762176259945;
        Mon, 03 Nov 2025 05:24:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbQpnGgNePOdLV6tgr44laSI5gUkCBQFkvptxvt0UkB+hMtzVUugM1w2gY/N5KHOo3c0JxpQ==
X-Received: by 2002:a17:90b:2243:b0:340:be2e:9884 with SMTP id 98e67ed59e1d1-340be2e9c84mr5431641a91.1.1762176259404;
        Mon, 03 Nov 2025 05:24:19 -0800 (PST)
Received: from gu-dmadival-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6614812a91.2.2025.11.03.05.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:24:19 -0800 (PST)
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 05:24:06 -0800
Subject: [PATCH v4 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1
 in v4l_fill_fmtdesc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-av1d_stateful_v3-v4-2-33cc1eaa83f2@oss.qualcomm.com>
References: <20251103-av1d_stateful_v3-v4-0-33cc1eaa83f2@oss.qualcomm.com>
In-Reply-To: <20251103-av1d_stateful_v3-v4-0-33cc1eaa83f2@oss.qualcomm.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762176256; l=1278;
 i=deepa.madivalara@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=lQvghmf454Nrr1HSejyrgphE01hNnR8XL04TB97Hm0k=;
 b=unlrN9so8n+4P8zp+QLkA173F6rkQITUlMylEac1SYvbehQz+RJBjiL7McxP42G+mHUm4n3H5
 shaCNn7X1JAD1R2D0zQypHAc217TS7/uCURfrZR3pwqcaQrtXpJ6f1q
X-Developer-Key: i=deepa.madivalara@oss.qualcomm.com; a=ed25519;
 pk=MOEXgyokievn+bgpHdS6Ixh/KQYyS90z2mqIbQ822FQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEyMSBTYWx0ZWRfX12FppU4gS+E7
 tJWp92F1pchJcsJMaPlW3EBH6Pdg+TaHxeoTKGqXVtGYGosLen4aGvfoOX01KAXPqSwhRG2eIt4
 Bgce2y7MLH0xT8T9WtMTDqMl7Pg//TiyAuH84Vi4CoVA9Bira6PlrdLCvlnW28/G4/q77xAGH3h
 4kMyZ5RptNnGumfc7gwbcuQuGo0Fw5uGYqCQpBUjVxiSDTiLy2pDMSqzu7qdAxK0DFoyTsMhQqu
 XAAh2payrN1UXT/eZH4zYFTn+VMOiXvCR4+5XVlhBuGymaDdEhLCqBlFhIO0bZoNupmosAn87nb
 6Xs8vpvt6mP0Dk83zWkPHnqIW5ARO/XrfHsB0/iGdEs1zIeY54G4KR40bLjQjNhjCiFqfDtqo9j
 JYopuGC55irNzVt/MaA5KsPdOk0IFg==
X-Proofpoint-GUID: s7LjXKXSq20iGz8tj8YJKmo1Hg1TXWNZ
X-Authority-Analysis: v=2.4 cv=Ha8ZjyE8 c=1 sm=1 tr=0 ts=6908ad04 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=3VFMuRvh7oFGMF0ZDtIA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: s7LjXKXSq20iGz8tj8YJKmo1Hg1TXWNZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030121

Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..bdfdf45c5de2f2ce885f219007718a54b5c86251 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-bit Format"; break;
 		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed JPEG"; break;
 		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
+		case V4L2_PIX_FMT_AV1:		descr = "AV1 OBU stream"; break;
 		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile Mode"; break;
 		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit Raster Mode"; break;
 		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;

-- 
2.34.1


