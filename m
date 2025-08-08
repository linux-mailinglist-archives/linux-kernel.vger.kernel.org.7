Return-Path: <linux-kernel+bounces-760342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7017FB1E9DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7791C25256
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B051624C5;
	Fri,  8 Aug 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DKviQFxg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CECA38DEC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661834; cv=none; b=REBEFnUst93Pc2hQBRjUo0LdcCdgkSiM7/BbD/ojdKEMLki9pyGcRHBUOlJMAhXZUPLC0cO0pXKrOZsG/jQn1ncaWeeoVatiE3BldL90XyosQ/BnlSZo5IpWlRnESi70ngFGRpi18Mah7tuKBdKWfqcmqcbpFfzknWbr+dLCP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661834; c=relaxed/simple;
	bh=KNSFSQ6elscxyJktPMiz3bx6RWsh26XGE1bHk9J/sMk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BxpIWgMcomk1Qfgv+dgzFDywC/QI+V9JAf4pSpHn9YVMkY/uAinA8UyaY/3RNPt90ffrJdYZkbkN3S0Z5C93y0X3lPSd3KqE4UEOW/8zPlRgYqVTcP4+W5iVfcZY4cEqzjMkjVJ6N8elzktEkveD0X9Xz1zZaVBccWSRdpid0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DKviQFxg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786lMs2007839
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 14:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=DYlHBOVdDgh8
	f6X0diGns/kpdvEmUjNJzPbxdtZIxq8=; b=DKviQFxgcNbCFRu7UrIYxRN6rqLv
	xxwgRnJ8I9LDf13Igcj6+VdmT+8/lKTNIQlVhfWSMawT2ypn8UGhCaHKy8emHAXF
	raleNzgVAZ3GhwucBTNmC2l00pmtWIrhDafhdAbRHX+aJiY2QTfANWQDLSzwHcmv
	osW+7toivqOUvuJFMIcIjnU9RtYzpqEPX4eR3EDCmlZUXbPnF8eglulnQvQiVqSs
	3FP3kvHbDpB/LZ4QhbUpAPmVHCXxhHJOpn3Z2b//SUvQf6aXMI1yZy/842f6PJXz
	ekRBLC/y2EOj9q3EUdz+nsPCha5ANKekfzcZI+DlYPpQZ2YxwZJkwv+mWA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpy727dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 14:03:51 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bc511e226so2385433b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661830; x=1755266630;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYlHBOVdDgh8f6X0diGns/kpdvEmUjNJzPbxdtZIxq8=;
        b=Wy4nP+qQeQpkimGbTgGbNA7VEzh71pRMKWMBKvvvFW8kq3O2kO9sJ4dxFOApaBCOs3
         24O/OTLyKlZKOdYU0Bj5BR7BPQ4N5Lj/hSKkD8MuQRBH+3x6eetaaGeulPw/MkGGq8Gm
         Go3dXTNnGTSGAoPomfHQ/zQ6KzHjHBA7EVewxBGxJts2JE5bF/qCz2hmzthNtIu8kURF
         8KnSxvrMReBPB3Af5o/8sj9L0gjgs9mGphMB6FXOim1VGObZYFiDPWP7iUGu/8OTLYZk
         8Nkxbb/LaLWzcspCY9bHGqQLn3oyzCkM5dgkimNWQKCnEu6UOrfRJJpUZM69JzT2UXaz
         94iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjxEDzgQ8O7kJEb05looIM7RWLzkLmUP2LmVKYeXVQDBQ4zoYcnwdvozUgS0c8jGLRLIo/bpFDB92mgwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQd47+1GkwurFTnixXn/fnRhGHwfpE0Hw2vXjhGgQdEVQpl1zV
	Q3Bj8C27Y6xhsfscmp2Oku/yk5WIojhnvAE6lKx4BDwsNTk9EiLCZG0FkiwnivGt9OV3KcBl67Q
	t30ljcBUWPZOmWxuXdfFZSdfKx5SzSPQ4n51QfAKJkXekNGITgsmswOr6vv3aSMZAE78=
X-Gm-Gg: ASbGncsuoI8xE7ZGUPl1ngMxUzPdsDYptoVVroJ/lmNUdDKSlUVqVnli+o+IC6bt35Z
	lPVjb7RgU84Qg4/Kr12tWYxliwewOHOY3zkGpW3MQVUPal6W1ca0pQ8PL5HseUismU2hc6mshz5
	4Kj/eE7qREGTFTeE1bHjv3T6f+KgssONfvMM2bOB9BdMSkI12t4aX5blVyf0u/MmDgOJAChgkRA
	KniJaQIWTSJHmAmlHSff2zEL4HwzH+tEdb48HEcDkCdsY+kPiAoC8XhPl54l+3his8ue4dFki99
	VoFf0P6i+Sf/FWkONty6PgKDE1WgyRwhxwLhnhKOcf3VIT4s6JGpWWoiH7CCX4rD6u/YX4IgHg=
	=
X-Received: by 2002:a05:6a00:14c8:b0:76b:ed75:81a with SMTP id d2e1a72fcca58-76c460db4a0mr4025986b3a.5.1754661829747;
        Fri, 08 Aug 2025 07:03:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhEiM/0PtRwCDBt4ZjihWPSb0Kaib7rt7yZ/T3fusuqcHUJsYFV6dtXZ0fUfu8FH+LqK+L1Q==
X-Received: by 2002:a05:6a00:14c8:b0:76b:ed75:81a with SMTP id d2e1a72fcca58-76c460db4a0mr4025894b3a.5.1754661829052;
        Fri, 08 Aug 2025 07:03:49 -0700 (PDT)
Received: from hu-okukatla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2078afd8sm8595621b3a.117.2025.08.08.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:03:48 -0700 (PDT)
From: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <mike.tipton@oss.qualcomm.com>
Subject: [PATCH 0/3] Enable QoS configuration on SA8775P
Date: Fri,  8 Aug 2025 19:32:57 +0530
Message-Id: <20250808140300.14784-1-odelu.kukatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-ORIG-GUID: zslNVJWQlZiNbJtxvQrN9O8Gg0bM1TXG
X-Proofpoint-GUID: zslNVJWQlZiNbJtxvQrN9O8Gg0bM1TXG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfXwtrH8bj0Yd2y
 FczgUmYVfvDca7FJwEmz1oZXJYf62iqDGmF37vo6CWLPnUSI2ypPtpApv1XMJF3HE+KgheyF6v7
 QBMBv5NQykDwPEvu7DxuOGWZL5jRTayQPHgsSGXPFvUGx59GxIQ1v95FXcLFfCX7x6NIk4IdySv
 Co6jlNa2clZbo9rGZH/2QllAFaMtqfsng/MekCcbMkCg32QpxU4SxhuLE/MEgdFEPQ73VBPauGX
 b34anTyEWj54+3TSU7yIr8iPOFf8dGNSvC8CfTlCDD3gRf7pGdtK1lbtGJQi3kFHdGcLEhfwEFd
 swh3/mO34X0S9eXh9399uOs8XIO7N610vL2scrpY3d/LdCojtjIOIxRl8fh0eekhoByuG+HJVpM
 DG5D0btY
X-Authority-Analysis: v=2.4 cv=LNVmQIW9 c=1 sm=1 tr=0 ts=689603c7 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=2OwXVqhp2XgA:10 a=pgtP2bmdoZ-auWmCWbcA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060009
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This series enables QoS configuration for QNOC type device which
can be found on SA8775P platform. It enables QoS configuration
for master ports with predefined priority and urgency forwarding.
This helps in prioritizing the traffic originating from different
interconnect masters at NOC (Network On Chip).

Odelu Kukatla (3):
  dt-bindings: interconnect: add clocks property to enable QoS on
    sa8775p
  interconnect: qcom: sa8775p: enable QoS configuration
  arm64: dts: qcom: sa8775p: Add clocks for QoS configuration

 .../interconnect/qcom,sa8775p-rpmh.yaml       |  78 +++-
 arch/arm64/boot/dts/qcom/sa8775p.dtsi         | 163 ++++---
 drivers/interconnect/qcom/sa8775p.c           | 439 ++++++++++++++++++
 3 files changed, 607 insertions(+), 73 deletions(-)

-- 
2.17.1


