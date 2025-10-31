Return-Path: <linux-kernel+bounces-879467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CF0C23312
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D47440549B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD527A91F;
	Fri, 31 Oct 2025 03:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iF3Waumu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cOiXJEe+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9226CE39
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881954; cv=none; b=WeMHEffcUj53YxYBlj7y1MkyH9swP3bP4ckC6BsGMYtdznjJj/tRJJ9/Aj93/AT9n5McksY75nSNZ3Zs0G67fb35uc0/sYHYbQqxgGmerjsf72kNhTcRE1A2oXYzX0azBdbi8zj6lHX0c6UYO6LtWkxnKyC4jznJz23L5mi0Q6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881954; c=relaxed/simple;
	bh=b/c0TtRbUx8JtnHR4dV4m75OEsqkoKzuORRPKWB222M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZQFrGx/mXL2b6889hMTDh8FDT51CcM9ydqrquf6vxgFI6xxyKysaTAg9jtheg+FWTYtB2xGvhMTCkyvSgG7w/PGESOr0QEbf3WPAbA0DRvubBMT/TMS5yom+kl4d3Df0qFBgA0/Gq+xRUOdOwuKPeLLwF6jgHACczz08sIvbVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iF3Waumu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cOiXJEe+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V39Tlo102648
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=i4IorI58Uj68IO5CjjCNPB
	BlGw6Gmk20pgNjO40wFiI=; b=iF3Waumu7YmzPqbhZFaigxE2atA0dgJS7+Ag5K
	cjdyrTZhJethbkNtaKLPtNQYBbzgV/wRgJuYKlhqNkinz6lRsq4cLsmqXkjEch0N
	x1O7JI7GwqA937Vakt5JrtvZ398AaE36bB+TVqO3sjrueSD7UveFXPrH0uBgjh0D
	M0EUTKHZg+02JQQCRasy4g8/aBWsI6lq0UORJmPzhrNHJ7xD8FxtwN7pcUDJwSHx
	qJwhJo4EQt61Z+wA+/1FPo6sAki9ZqHiBfss+qG81HaW95+jP3C0KRu/b9oWHuul
	vaS2by/UJKtTBPFjbGbi5rRlUrK6CEYnIu/Cg/dVYua67NEg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ahdhs3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:39:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3403e994649so3792652a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761881952; x=1762486752; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i4IorI58Uj68IO5CjjCNPBBlGw6Gmk20pgNjO40wFiI=;
        b=cOiXJEe+aO/A2h+2o1+JeIVaXajXDlx+Bq/pzhnoXtHX9FHr8OQCF5Bp3q6V6Z2FOA
         awlBjKhBnI0qszdxvq5+T9qGcvXQw+9fUeuB6mqVRRm2aHZEn+aULbvCOTv242jx565L
         8hbqkCoGG99xUK+tLC0vscrdDCiUa7HSUs0o7Iep5s9tlMK9T7e95c3JYjwjUY7ilnr2
         Kq+wmXNe5DTGOdrdXhdwgjkuzQ7AtqB5gYbJOCOL9DXkCvP1I9Kvj3ZmHQlxSS0mH99M
         9aiuo0VhBTOn/MhijyHICscy7JoR8C/rYxCclgOeTVlaoi3I5ZhQmxfDHPO3O6bkbG3G
         uQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881952; x=1762486752;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4IorI58Uj68IO5CjjCNPBBlGw6Gmk20pgNjO40wFiI=;
        b=fXj9onXULqiSKN7H5ARpnkcug1+pplqg/V+rUm5+JoBWLFBhPCsqIfbNo03RzsWmhT
         LzesESwGSrGh+uyybKTiA7aLpha7+C3g4axXBmUU63uHZWlvpu5mL9bqNVEucWQlBcWF
         iYzhFM39bz0OR2KhD3gfUpTnOlRgJKiLO8RsY4jDXyoAEdGwUeHCgob6gHUIuVfL+1US
         CC3peDO/+nMYi5OfEnhiy9AFJ1B5A85hSXRHiWK6ZJaKakL9PPHDTY7xXSvevQwJKOUZ
         8myk5hoj9MOcW2NLBNMsm8eV1Nt0N2CdU8r+plGDW0mtHEWuI1f/n6fEmhHQeBCxTwQS
         +TNg==
X-Forwarded-Encrypted: i=1; AJvYcCXNqaVzicNt0au4YnVIswHu524x1G98TSuZY0hE9HRVkxdo06w80K3KIAPdF8QP6RiolWWHSldsLuARNXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6RzXcMPVMrFVQWQOCkqmWvMSHsRboPoxZblvfhF2Hjmomrcg
	Ql9qK2/fcsZpPf0QJJmCvfXZQTFH/ns0PNrjABf6eLEXl3Tl7VC33k/dw35vkqcdVrU+nUHSLbu
	LpWTtBzzymyV3FexIz0r4UUdA6tiot8xvRN9SZVH06idKys9JmaLy49kt0lb/47AxnZE=
X-Gm-Gg: ASbGncsfXbU79Xb3Remk68+KpRH7tfw+KontD0k0HSXJYwA19MHqdbwEgSd44eEHX+8
	nDqQA8A2uGMon1YV336kCNGu51V7uLrQ9201zvscqNy1yLATDvv540kIw/yWKh8bI/0jYtiAwmV
	IWPnysU2yy7+BUKaEj0lBx+Y6bKQY4w/z3lxl+vUH3fNE8sWPrK24QelvXPe5UTs68x8TLTWlcG
	QdhwtIT9tew5enfh3I6K7KhgW0sS0sRbFER+Ml92KuNWN6/PYqMftS+WB+EAL8cVM81XKhBnaAt
	7+uqsBmWpSvxQKO1vfH64vWYGBar6Zu26hJsaaZh1vy7QxHIsZoW/46QiLQNPOe3WPASKLdEuY1
	3Rc+XE13dyCDgZCfnmHYJgw==
X-Received: by 2002:a17:90b:1f82:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-34082fc7b43mr2536968a91.13.1761881951750;
        Thu, 30 Oct 2025 20:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjnJe4PvNt1debsSjTxLEoIU/F68bM+PqIGJDGv+FMr2j17u2RS7apMk5Va8eik46A4OJF4Q==
X-Received: by 2002:a17:90b:1f82:b0:32e:a5ae:d00 with SMTP id 98e67ed59e1d1-34082fc7b43mr2536934a91.13.1761881951267;
        Thu, 30 Oct 2025 20:39:11 -0700 (PDT)
Received: from [169.254.0.7] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407f0845d1sm646419a91.4.2025.10.30.20.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 20:39:10 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add interconnect support for Kaanapali SoC
Date: Fri, 31 Oct 2025 03:38:46 +0000
Message-Id: <20251031-knp-interconnect-v4-0-568bba2cb3e5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYvBGkC/2WOSw6DIBCGr2JYFwOIEbvqPRoXSMdKWkEZNG2Md
 y+aJl10M8k3+V8rQQgWkJyzlQRYLFrvEshTRkyv3R2ovSUmgomS1byiDzdS6yIE450DE6lURpi
 at11XKpJsY4DOvo7Ia5O41Qi0DdqZfg8aNCbzVxhgmlNl/Kl7i9GH97FnKfbvUc1Zwf6rl4Iyq
 pmSWgolKl5ePGI+zfpp/DDk6ZBm27YPmPMqGeUAAAA=
X-Change-ID: 20250917-knp-interconnect-48c2c91bff58
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDAzMCBTYWx0ZWRfXyvJtnBr1tf3A
 2n/CKR7FNyZ3rrv+X8Oxu4Lv8rJVGf3yrI1p/7im7TAOhv4staeU+eZqQtNL3mIhd3WMXbZy7Xv
 K8wBiryJbCBEpYmojKoMc/0UJVUBsRIjxDdwvU9UVeWtAnav879IbwoVxdNQPIAG+ACliIAfJ/h
 xCMeGginA1Ha1FkdDbt3AbEsBE2yecRhsVK3kYpvcd2vMMALQqYxmDdslW0JpXjW6wIW+OKXraH
 is4HKTFc2lBh2tizJx7lmx1wwnNCiGn92F3UYk+GbTL78Y2dVf3Ks9ETpy9D0Tg4Hr1H/73QhhH
 X+YN3bpgZeDMexLMmSQeAzYsAM+UAGvuqoARRojXT1FGVr9AuDFkx15RD3Cs90NdOngtfaw70nB
 6c1pQu12WhRYPU/zbUmEjzTnXNiuYw==
X-Proofpoint-GUID: vzydTUb14I-1lPimspnAFoUo3h6r8FWC
X-Authority-Analysis: v=2.4 cv=TsnrRTXh c=1 sm=1 tr=0 ts=69042f60 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=06_svp_evkBEmB2vVC0A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: vzydTUb14I-1lPimspnAFoUo3h6r8FWC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_08,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310030

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.

Change since V3:
  - Removed unused header dependencies from bindings [Bjorn]
  - Link to v3: https://lore.kernel.org/r/20251030-knp-interconnect-v3-0-a084a4282715@oss.qualcomm.com

Changes since V2:
  - Removed the dependency on clock header in "qcom,kaanapali-rpmh.yaml"
    bindings file [Krzysztof]
  - Corrected the patch revision number.

Changes since V1:
  - Added b4 dependency on the clock patch [Rob]
  - Updated the Module Description to "Qualcomm Kaanapali NoC driver"
    [Dmitry]

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPMh Network-On-Chip interconnect in Kaanapali SoC
      interconnect: qcom: add Kaanapali interconnect provider driver

 .../bindings/interconnect/qcom,kaanapali-rpmh.yaml |  124 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/kaanapali.c              | 1868 ++++++++++++++++++++
 .../dt-bindings/interconnect/qcom,kaanapali-rpmh.h |  149 ++
 5 files changed, 2152 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250917-knp-interconnect-48c2c91bff58

Best regards,
-- 
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>


