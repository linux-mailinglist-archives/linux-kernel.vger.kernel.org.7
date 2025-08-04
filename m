Return-Path: <linux-kernel+bounces-754724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869E6B19B77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC9793B43FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC4D227E9B;
	Mon,  4 Aug 2025 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ivYrg4Nx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F1D2BAF9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754288227; cv=none; b=kVLOecMlSqBDnyEmJ5gFePvcgkA/+a6oYVWqFo397GtDdDk+4olAShHB3u9FoxSg09QMtQye9PqdVIIm3QVn/Z2rnIXeUbNMspPOSsKPTC9skGTJxRuILhdUcMxLHWH3lUrEBfY1tng071yrHefd2Y1aQShWBcDA0FlnXOGsPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754288227; c=relaxed/simple;
	bh=eMgZLpYqsrpOYSyhN56WZXWGJLFAvTwwAGp1XIsrIP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E8jAPsA6OfJLcbL+e9ihE5irs5gFzXbPOraa/z1WUce1SPUBhgOiUNxQFc2YhXuRCqy7vjfz2Ttj6s9rp3Y1nJW7wMFYjTvfNL5PIDKTtGJ3AsTo98vEG3tVRlR7HUm+a4Vx0g3cUQxfgcA091BMNRVXBvtiBTlg9KEDjl3HJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ivYrg4Nx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573MNAnR006898
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 06:17:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iAHnqwL0yHem+mv+4tLl/cNCAGcUR4yxE51
	d9JO/2jw=; b=ivYrg4NxISrmRz/IrrTX7ypIm5WthPveyLFfTFHReGoXg7fvoRz
	2r0l6hAoyXjISER3O54JF+xtz0m4GbY9d9RU/845FAB+pobOU6DvmsJwtt5PFy3d
	8k0VH5TSlItBMXwQEhMss5E3+XQuM2RzP6TNtGwas1fLSA/PyfGtWS5cxt0GBNfn
	lT6ftKg+E3V76Fe7KtomdoP3KFOW3PLnIBr2dGnydiWkRVqsSW+vGVCys0QlPVjE
	+6CtHgpWCnjV2RgWOLwBgUKpAzjmbZWlsb6S3oBV1XS3DM2O0ShLpAYRjGHBO5ax
	FNxbTpWY/1aox0GMvjQqPcOBputFTPHnlbA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4899pabrgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 06:17:04 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2400b28296fso59272635ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754288223; x=1754893023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAHnqwL0yHem+mv+4tLl/cNCAGcUR4yxE51d9JO/2jw=;
        b=j34VhvtjufH5Y9hEpezxNtjgU23+i7J9e9jT7MvWehEART0g3gEHuHL5lq2C4bg5Y9
         Mf9vGCxx3se8DGVM393YbasxEDedIFxdi0S+PmkHAC1Us2ob+cYb0UxEa7Ej0aTE+Py3
         PYTZNhNP+Q6zcSf8xim9doiH27p4NSQ9378YeV8ksgMLryo/hk7uWlHChPvj1JWyQJH2
         hgdEmwuPF2KVvIR805lq6I7vKFdPGxYOa/P3hMZPZy+2ATLBCLOcmHinbH5ffKvbqQyI
         wXBhx4lhalzxLJi0HCfKAopWyqY/ZEoA7JueDGdkTyujnX/kzotStHbw1TR55Xdvayc4
         f6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4KDt7RbGWJWgeAs4l4UJu4gwYJeXgbA+f99fh2GG/T1ACvnItethW9McTqGH5jFhCtdvRV0CkuaClSw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWgY2oW/zABvAxEQAzkLoVkNhGttb36PjtyvU83XJxbANRHYZO
	+NIKUQIL9fdhT4JtGg6fAI4YtDjH+XbCrUBdMewmOGj9C+2QqxV1iU9XUjodGQ/+TyYIT3sE4xG
	AkzMdv6tDrX6nZi1nKXWnDyJdial+XRXuHA9+Xcqf+dynttJZw5jH74Do1UJG+o/MqPk=
X-Gm-Gg: ASbGncsJzDJS1DHUfSkYlCtgIz2agaXYfdD9gTqAOAtSF92wXp6QMsroWQSDVw9+S+h
	ZdJG86n09Q70RBnxZQmX80/wlXAetQTLMfreLXZ7HUwwTfV7P7eLMVbQc1bIPKJIFi9nr2k4fJd
	GD+YrZPjp9GqtwBl5lPz4pBfYSRvI8KvqouMh7TIca4YNZO0Bmztz98imnttOmY2h0q6yiCIRfe
	XddBA5LqRR82/gNqpiT4dLzRHqZu5q4S086YUU0W/h5G/lEwnGPHpwVAaTy7vYb5bJ99EM/kglm
	vFV6eaWTZ1xLazb9h6Tb6OQapTpCbI1xlfW798+M832gcg/6bB6pEACYHLNQqEVy+KzUgfCcKqa
	PuPE=
X-Received: by 2002:a17:902:c94b:b0:242:460e:4ab8 with SMTP id d9443c01a7336-2424704c466mr116862515ad.46.1754288223557;
        Sun, 03 Aug 2025 23:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwDfmm0C9LYhQxt+pKGPY5NUnAnjrRTEjtgxOftkxmDC2olfkZxAdQ9Xd00d821Hb/WvJUbg==
X-Received: by 2002:a17:902:c94b:b0:242:460e:4ab8 with SMTP id d9443c01a7336-2424704c466mr116862235ad.46.1754288223102;
        Sun, 03 Aug 2025 23:17:03 -0700 (PDT)
Received: from a3fd830d25f9.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976f08sm99786785ad.103.2025.08.03.23.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 23:17:02 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Imran Shaik <quic_imrashai@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V2 0/2] Add OSM L3 provider support on QCS615 SoC
Date: Mon,  4 Aug 2025 06:15:34 +0000
Message-ID: <20250804061536.110-1-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAzMSBTYWx0ZWRfXyYIno613Kva4
 ZcmGTo88Kxg/flQ/JqDaABrJ2E9aHliX1AIdOg0pmlnFHjPRA/2wvRWAUC63WiDa8GHYnBu0NVC
 tbP4XvhcYRONOUO8HNghZR0KUnJ0fpDxiPY+v6JFZiriJHYfwTyGFDq9GoGzfRTi4NaFYp7fBxr
 Y9ck79ZdsXrYLooFbQP3k/HsSi3o0Sexm6Uqi+3BiQPj7z6vps26HqGuNziNrU96BtRnYukPyMb
 Z4gUzke5SUOg08UQpRks16+NiIPZZ2OMJfvsPAN0zsSU+MTH0j+ItAq6uGQdQix1PqfK8ZTdidP
 +AkPlR3w0jzlSJtVZZoTbSZz0mSm1c+lSB9SeIbPtQBH18dKbLfdfjoCZvwajXTkXA8/0mYtM5W
 /9vpQHzxkjjPxIugE6llEEF3Twe7dmFMpLh5vv+6gtAGVbBk0Jwe353bWmMIzBfWmKzmAk44
X-Proofpoint-GUID: 8NcK8HMr9fXFtRQa-GPmRgXqZIj59h5Z
X-Authority-Analysis: v=2.4 cv=N88pF39B c=1 sm=1 tr=0 ts=68905060 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=VdEDuztqGucW-MqrkSEA:9 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 8NcK8HMr9fXFtRQa-GPmRgXqZIj59h5Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 mlxlogscore=841 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508040031

Add Operation State Manager (OSM) L3 scaling support on QCS615 SoC.
This series has functional dependency on [1].

[1] https://lore.kernel.org/all/20250702-qcs615-mm-cpu-dt-v4-v5-3-df24896cbb26@quicinc.com/

Changes since v1:
  - Updated dependency on cpufreq patch [Imran].
  - Updated SoB sequence [Dmitry].
  - Link to v1: https://lore.kernel.org/all/20250804050542.100806-1-raviteja.laggyshetty@oss.qualcomm.com/

Raviteja Laggyshetty (2):
  dt-bindings: interconnect: Add OSM L3 compatible for QCS615 SoC
  arm64: dts: qcom: qcs615: Add OSM l3 interconnect provider node and
    CPU OPP tables to scale DDR/L3

 .../bindings/interconnect/qcom,osm-l3.yaml    |   5 +
 arch/arm64/boot/dts/qcom/sm6150.dtsi          | 148 ++++++++++++++++++
 2 files changed, 153 insertions(+)

-- 
2.43.0


