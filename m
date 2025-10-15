Return-Path: <linux-kernel+bounces-854481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC4BDE7D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFD124FA010
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E31A83F8;
	Wed, 15 Oct 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oOlk8DPe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CC8450FE
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531710; cv=none; b=UymIw138StcHYlLyQUkGO5aCWaFmYSRls8jPG256ezd5mveqae/ZRUqYr7OTevNBfKTCe05DS3Hsoh2O6XJ7kIljEIXA7+2Muvx4xNPWJgmVhpWQizL/5CMeNnRkvKAyRS6UCRXsO5h6gGcKYY3MPFIsqIaaBQ6xBjh0N1ZSaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531710; c=relaxed/simple;
	bh=X4N17n4Ua7mNCyR6WAfWyrl+7cd5pNOirQVeBonC7NU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BR7OwsFDH63zDWrTo1I3DRe8m3cs0noDvTVhDC2YTiHVoW9ASdzqbyb8+SO6mFt8LJe83c0DRe9EcxZphqq0jK5MbFfiJtw9qKVFByRY48SvzT4JR5c5leyScQwHpRZ0/ERRx6S4cVUAnI5EcFmY+KV7J4+ODRviA4khS95vGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oOlk8DPe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAqu8N017762
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Pzp5Zzc1pFXeaU+Nwva8WA
	BLFh5MZrb4G6fcqC/jDw8=; b=oOlk8DPeuPHxrvywEh9EpALCqUovMqVGiTHQy5
	c/YI1UDP8gMj0fAyPKXTG+9OQ3lrDcfji9GvtdNjlSe8Loc7fz+P8QqnnmohyW0l
	lA/SDI9tZ0emDDZEj0idI11lCQg1mu/+KyACKxBntfgdCIuLv4ljbmhkc3wAmv0M
	PGYck+mWHtReuT7Yq22OMBFenBLOh2y/qrb3azByJnFdijJS+TdxnUeyAQTmz89J
	zwhygi5YA2Ulmaz/5QPHM1HHtphxRWzo45vd2nwOpjFZg/0JPAO8FCNwWxea2AiE
	WPBkAItLri/aB80FVNgQ5wGwP8HhilXk/1yajovQLJC9CQKQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt9atk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:35:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32ec67fcb88so9608978a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531707; x=1761136507;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pzp5Zzc1pFXeaU+Nwva8WABLFh5MZrb4G6fcqC/jDw8=;
        b=FN0QDfFnvMJNezz6uAOgu9NeWOR7CyVo0ycceemIordPbyrz/UHhOcKSXOVVmZWpH6
         EwZxX+SHP7fpW0p7EiP6BQKguaYZWlaE3DFXUojyNJ6tUU3MJLEgowj1S+w9pq+r5QrU
         CX+d/EURgq7nXQ2DjmIOU970G/c2FtwUH9X5tY8Lr/Dq+6syQa0fvmqZJdkBDTVnDq/B
         5p9pOphfSIUbKhHWBZilxi3FtjaPOuawAoq1j0lacbZQ/mIPI+JonkfahNV9M/ud4jIK
         qQ8QQ+96XoUhodTh33znpUA4T7x9kamBt21YEmj3h2vURpsxgiiaxhClkAvgZPWUxq8g
         AbSA==
X-Forwarded-Encrypted: i=1; AJvYcCX5fmGmwlBPsg5mr7dXxhX6Uu2zxOwBk/4cnfl9PnWlpm++r0+7wldAXlAWdxyumICxm/h/VoSoRVz3LAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjdRrfLwD691g1kA6IgQdnnAcZcOj+llkXJlIWZDG+DMt8FIS0
	0+aRc2lVqQy58lNdz77Bpg3IuQXF9ES5Eolv7NxZYiLNInx40G8JSZVB/y9WrHbuUGYCH0W+V6n
	VM+IrjBjJG0vsGADvAf0/jTpx8D3i39qyM1u5X+eJpMgK2oA9piq4TH7o0RvBGw52zxQ7AcZN5w
	==
X-Gm-Gg: ASbGncsk/dj5wquSimGBTXTR29GiuKtkRUfYDc9akhAY5yNX/+mOflMHgNgRpKgIC8K
	bMNsVTyb6MjQtR0t1bUJTnypLwaQTJcawqOH5OaCm7V/bT3aQmvsqVX2KTnRe4XT2fpEZ/aT0N7
	ZX0sn47O8DcHml27MVSdUgdxwISpISR+EXebOEplIv6/BJizv4OamieK2YlozWaCQFaEgD8uptF
	tCLHiSwVihW4La8/ZtFU3utMhuPrMGDIbbfVxXyB001ZvInyarrYwv4O0c32C8aoxPx+hEBXdxU
	DQl2QzTLfjr8hhzlW9+UsOMSNOh6MNqNkB7WXZZpWifXrgZ/JIu9ZuRVL8o3yUdyWDKbbQ==
X-Received: by 2002:a17:90b:1807:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-33b51129723mr36139011a91.13.1760531706483;
        Wed, 15 Oct 2025 05:35:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELMqHeo+HHyB2I1fDjUFGKkYnQoxP4f9ftX6FPP/Z5V2sIvrCOnIckE3CHkoakEpIlcghHVg==
X-Received: by 2002:a17:90b:1807:b0:32b:a2b9:b200 with SMTP id 98e67ed59e1d1-33b51129723mr36138978a91.13.1760531705862;
        Wed, 15 Oct 2025 05:35:05 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a08c4b7d6sm2389755a12.7.2025.10.15.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 05:35:05 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 18:04:55 +0530
Subject: [PATCH v2] arm64: dts: qcom: lemans-evk: Add resin key code for
 PMM8654AU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-add_pon_resin-v2-1-44e2e45de5f1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAO6U72gC/3WMQQ6CMBBFr2JmbUmnWARX3sMQgmWQSaTFjhIN4
 e5W9m5+8n7y3gJCkUngtFsg0szCwScw+x24ofU3UtwlBqONRY25aruumYJvIgl7ZU1vDxpLl1s
 HyZki9fzeepc68cDyDPGz5Wf8vf9KMypUhXF4pbI6Vro4B5Hs8WrvLoxjlgbqdV2/pw0YE7EAA
 AA=
X-Change-ID: 20251013-add_pon_resin-52f54018c35c
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760531702; l=1121;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=X4N17n4Ua7mNCyR6WAfWyrl+7cd5pNOirQVeBonC7NU=;
 b=KE3ICyICIkU3msidOaHXIeqwTq4UdytdyqOAFInA7R2Y8kcF1vZYhaJGh/zR7I8cDi3CJ+KWE
 T7TQb976xwBBW/Ksz3p6/CQl3coCGfC3J0CP/wfQRMH9je478eLl6iw
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: RNeiLgTzwkyYVzaZoLQAWxL7IqScScwD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX1NSvDELIdZmW
 EAFvNzazz5lMPwRMnTSF7et3KZqGUKGws2Lzpz2OkSXpOpMBoZFFhch1vM+aYi2Nm3gDS46vwzZ
 s0VLXLz/GbFeyrkwba/Fdb062+DzcWDBd/ykGN2vmV423UWFLyNiCYEMFyNdFkSVEQPpKvjZKCC
 /RPjHON22FPHzUJPUebEodYzSk0+rnX8ytVbL94aSNvOoFpYGsfisV2DdDzIlxTH20PYSdUBhsa
 IHeQvubtFlpxoUoxhyGY4xaYALeW8cs6J9LryVyq80Bl1gfTgEmnrtoYuN2npUXZFSaH2aetOf6
 R6nw2aO4+cw+UBaf0w5QWDLaO12iI1gPygARl3gcukLfDk6u1EXhntgbZgfgBR721F/VIz8r2gQ
 5eqG3zPLSVsDLOyv7APKZ/xkA/rwPg==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ef94fc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9TsxBIn3MFV-MpTI3mAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: RNeiLgTzwkyYVzaZoLQAWxL7IqScScwD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

Update the PMM8654AU resin input code to KEY_VOLUMEDOWN
and enable it.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v2:
- I have dropped the RTC change. I will be posting it as an independent
  change, as suggested by Dmitry Baryshkov.
- Link to v1: https://lore.kernel.org/r/20251013-add_pon_resin-v1-1-62c1be897906@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c7dc9b8f445787a87ba4869bb426f70f14c1dc9f..0df105755c328706475cc1974fc45557d0a7bff5 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -587,6 +587,11 @@ &pcie1_phy {
 	status = "okay";
 };
 
+&pmm8654au_0_pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

---
base-commit: 52ba76324a9d7c39830c850999210a36ef023cde
change-id: 20251013-add_pon_resin-52f54018c35c

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>


