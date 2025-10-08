Return-Path: <linux-kernel+bounces-845820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24355BC6389
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 19:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33BC405613
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3200E2C026B;
	Wed,  8 Oct 2025 17:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eNGipyua"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468B221271
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946289; cv=none; b=soL6QH5iEpxGv8vLE8yTbxvrd/IJlPq/PvsRDoD3IoDbxeuz0Y4gmrI6izUAxpnxGCGgiCEShR8FJKZgshhr1inGS6A8JPD2CapI9o8IDjjfHfVbk9hsj+phIntbtRgZMgyo9NdLOvnmJr3mSy7hiS9zdi2IQxQQ3EGE6113Y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946289; c=relaxed/simple;
	bh=GNUvo6ahqMDDQmc6VatbjGcaUHeIlPCtEx1Od3v5Zoc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uy46Q46zsrWQOSGPeX7wnNODceLqHcBL4qswZsxNg7WaESHQA4o/gLqDpxlIbPfx8YoOBF8/W3t05RZnX/KC+OIevqmQECOEHpjzI/kitITf0U/SNqhzqWLLU20hvSnqg6d9SSb9RrdkMTHJubJct5xEM8hps5IpLArCmYCrqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eNGipyua; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HLVJd020004
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 17:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5Lnlm0zjjWiQ7ki6NUOp7Ssyybk7floF+zN
	XKL9UuRo=; b=eNGipyuavhbm2x+sRx8cMbG2Ca9vzdFVHmRjSZ7Hw2o2F6chXjv
	aA5Z1xDVa5KQ+2rFc4d4d4i4U5pTkbtCsJOJ2m9ixiGxTSUQdPzmN5YC3KmV1u//
	jZgVRhZEYZurUI0XcDCYcgqNpUA9Zc0Fm7eP0hVOfDSomKwdJLMX4TmN4NwwixUe
	l4jU8DMGmdLdR/CFHaWCDEJEIuLNOW9zVJlGh+DQ3joTrtvG8pzA65tl+uk6nI2m
	r76wak9lv1dOCxAAIS84/31fqnMxIAFFAvytOglG7ozbmBMT7tMcOJoiZf+EnuUO
	htazily+3FXBekPB6+cj1+x91XW7JxNW+XQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv9a83we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 17:58:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so268277a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759946285; x=1760551085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Lnlm0zjjWiQ7ki6NUOp7Ssyybk7floF+zNXKL9UuRo=;
        b=DjEz1Bz1EHlBNGGWIxYCCoP3jsWXHcgWACwjobYcAfFFVQr1RNZk6QuIiYqWoN1ydI
         Nx1z2cfIkwzsJ/SeAHgAjzVXUCbEKA+m7gZpK5d9SU3mq/5JoCkHSTVHX5c3E8EYggV+
         QKZLWJPMWJHXhPgPFFdAjU5Z9ZNQMo0TMtjMQvq3SNXZmPTUKtrU5zF+eUZELRNu/OYe
         8EZwMvJhxJO10K1BnUhd3A9dCDatLW1U4hseUdwRwtfpS/zy9YoxwkwN9jE59Pznsp6W
         0ifWckwHuvpA9awMr/78CxYQI/YXLCOpSDRriginroHV1gPhAxLveXWf5hbmi/GukfHz
         jASQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTs6RXYXCiatPjy07jkROtpgbgXPnXSYA7cxGoUsvGZHLzk3/DpEHu/fyWgFxcmtDfsB/aZMz+vfTgC9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhGzP66+xmAYR5C+MYw20Kpj3lt6cGrA8Rpq8KbySv72CvS8Q
	D4cE7CX2Zrrg1Xyr4dTujDa6bsz3JvWISHzPEb4+zDwy7ANjtcpbJSDuRUDdBfKNvfTdhuu7tDM
	ifUEc9SWLbfNaAiTAJpU9ESS8I0h6gWkOCK/ekD2wsMnQPS++8rSpzjNdx+x0rkVEYSU=
X-Gm-Gg: ASbGnctX04mxNOIFmrdGIFkHX9HUSpZAJhM4bK+Wu2IQ8gV+R+HB/Q8El1ycsCtkeJV
	QnY4SrBnJO1wAbH9Q58r5rUrwZEKN6c//0h+tPxkzALSUuKjQK2c3I9+orGRJXT9l49MXNq/gJZ
	y0esumdXhixqCj6ofGZKKieM/DRz+yD8Wz4LyHFsVv34MLe5JB4ByWsBZFYppoLkpv94DOND1Fx
	8cnl6U1s4hueGBpI4bTb0dkmdEUTrnW2zJUwK1qTzra/2XA0l7sAcACSOHoZbYHjB5hX/yj4CGw
	GoVuCyEXzrtxlx0FDI9GZJuGZiaMvq8Jm/mt+Sx62a3GrPUX00BQ/sUd6ayJu49fVn52acknp/w
	N/EJcO40=
X-Received: by 2002:a17:90b:1b41:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-33b513d0b37mr5027249a91.28.1759946285382;
        Wed, 08 Oct 2025 10:58:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVKULYrHHKoUCwdURosQLoIlR8wgg927L9HtEPvDdQ5p0v4OJcirdLLPyK7xjfNTlVbUm18Q==
X-Received: by 2002:a17:90b:1b41:b0:32e:8c14:5cd2 with SMTP id 98e67ed59e1d1-33b513d0b37mr5027210a91.28.1759946284796;
        Wed, 08 Oct 2025 10:58:04 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b529f51b5sm1275726a91.7.2025.10.08.10.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:58:04 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v2 0/2] Implement vbus support for HD3SS3220 port controller
Date: Wed,  8 Oct 2025 23:27:48 +0530
Message-Id: <20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX+418Dj5y38li
 WN54nrjyM2tJmbzASZahOPnbjwIFTmtOg5S/kWJs35M9ClCeP4nAvHPTpvqPuunUu/3oMPFnLwd
 TcQ+y3IEpki65oeTySVL00ofMh/ZSPNALwItDYNSIlyg0fvsVcPfuH3bvxyLDWq9CZhgWtyKTst
 Rvo2QuaNs3SAk3LEznL9TSd+K6f/ZvU1heueh+sOgLUZNg8xdi227G1pXAqyu1egs+SatEKuNEa
 xbsPmVAgqibuUXjNJ3z6SlmJuwI0pC/4ExZDoTAPF06a4W0A13SOQ08zavy69CcYw0D/Cah2CSD
 x3lc+iEgV789JcH5XMeOwHruuAomZdAR9B2gMMGoGiGwludjUot5cl7m3luF0P5nAneEP+x1lQO
 jLhnb+LeNSSzY7jbVg+KqmiLbPMgGA==
X-Proofpoint-GUID: 5TlDx7OZw5STWObH7V6reZZAz5BB2K7D
X-Proofpoint-ORIG-GUID: 5TlDx7OZw5STWObH7V6reZZAz5BB2K7D
X-Authority-Analysis: v=2.4 cv=JPk2csKb c=1 sm=1 tr=0 ts=68e6a62e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0ZYI1qUNTW_HKTauMVIA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080122

As per the data sheet of HD3SS3220:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

This series implements support to read ID pin state and accordingly enable
VBUS.

Changes in v2:
Fixed inclusion of header files appropriately.
Modified commit text for driver patch.

Link to v1:
https://lore.kernel.org/all/20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com/

Krishna Kurapati (2):
  dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
  usb: typec: hd3ss3220: Enable VBUS based on ID pin state

 .../devicetree/bindings/usb/ti,hd3ss3220.yaml | 13 ++++
 drivers/usb/typec/hd3ss3220.c                 | 60 +++++++++++++++++++
 2 files changed, 73 insertions(+)

-- 
2.34.1


