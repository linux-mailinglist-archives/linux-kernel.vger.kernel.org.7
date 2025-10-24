Return-Path: <linux-kernel+bounces-868635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50EDC05AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492E318845AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7007231326F;
	Fri, 24 Oct 2025 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C2yJjS/a"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C6031281C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303030; cv=none; b=r8xEZW1gTCG5sQOpvVy2pj+gHtYPuS+ipFoJ9psRKgG+wfvTtnYwE1uZR/THKO7D8fuU44zOSD6Kn8KC9Zan9Cc06kXzifUGz4NtSLPYXP0mcmppvTcgF8vOrvcoPUSBpDrM+s2SHUBi2GU9qnCYHfwpQMdyHH9NFCffuPVzOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303030; c=relaxed/simple;
	bh=hBfpYSbUdnlWTsvr+6iVKoFyAgicRcUZDbA7264mfvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CjM/+ohVurFEaOb+mMnknuxHccL/R2oatvo17l52TqlrknH1fdkdhcDCLO2ZGtfa92pkZoxHuvBB5jf6AFLYQev+EfWGnctUF/AuE8jZmp39R4ziFXfj3luO4UHbtEd+HJ+3JUVV7U1/h8rgRA6yqkCd+p1EsIoiZ/ZTVqAyVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C2yJjS/a; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FL2i022330
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6NHuX3Ved4jhx9iPo+t4FNZicrm8s8ruSWh
	6+iigvtM=; b=C2yJjS/aDzwyEUl741orozy4cB0q3rg2p8KLC+4y8IEv0K7olM5
	w2mMh12KtMyiyfSTAzHngaVcB51e1iRy65JRJpdDk5fYzXNuPU/73wDYk6nQfowu
	bi3gAfaQkGCeHiav4x57AFVNmzeCWnZlYIEVqKfTlSnYBFII/oYeiextdO9rj1ec
	iNKBHUGdm10k3bCs4Rkf6EW5yaHBLl808EneFkGeHanAhUmb09I4jN45mwKk6x1u
	Kiax7a/Iac/7kpzq8ISS55iBFE3u/EUpZIzyV0TmGzX/uMjO508Jg+xeKXWDDuEo
	JCefEV0dp48BheArBvnHpqqE75Wt2EAQX2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qnqa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 10:50:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2930e6e2c03so20936825ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761303027; x=1761907827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6NHuX3Ved4jhx9iPo+t4FNZicrm8s8ruSWh6+iigvtM=;
        b=ZxGmewSPjWe0oAlxeTtxpWc+K06z0fOpLIDllHp+MvhA+8knZhyzQadYPUiLYySMdd
         xoNKTSLfUVY8mkYqVueP/5KEriKTAhi1SlV/vPbYYhApLUcTfVpNgWNrDReZ1NgBjycx
         0sp26D9bI49a6B2B/xjZm1aHizeAraDlxRpD2+s+uBcrC+JHoY5MgJllwsOoF4xy3s7i
         UuJFitn3zCsLpuQJHh0yvyyHK8xAldWCNsqtg8aSEfQF5w22l719pVz1opfxdulRqmjG
         ziJ9UsgplyXT+AsRUgEVmCswRltkRrS1eSGKB5J6bgaKLUS8vGmdBF/RTJUEeere2lNG
         evPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfCBkWDxyp89Y4DZvavEtw31ALNViw00bi7r2+IA9/FCCjJbmEOCaYt7kX+ai7EnX8WC/xHuN8z6y/W/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbrJREH1wP9znz2uZlK7HNHBWZRESUrEatMBojOpzSU8rZ5ah
	Ww1mvKX4j4ouyJU7cDXSHR1v1KRIGic0BZAM29b+jLbkTbpcudbMdPWeuqlbK56dypH7FDWpxOj
	Z0/mliFHvo/lWcgsrMKuB/84IGb6XQNe0IITlGXNSWRyswy7TDqkfyptUH1x7stcajDc=
X-Gm-Gg: ASbGncs/V92/apIF7Yw4im+2LPRQ+dunv0+HWtllsNscZSZhIWvS6a1hll/YXV3Zr4A
	LGjmS9r3tYnHHliY9OXgYw7P+SH+q6jGf1thQE92WkD1IyLi9Ms7GFm1hvPV9Mj+zcZy4cx+Y5l
	56UxiGD7kBbK/vJ84vlbwmsLLYFaMgU3h0sPJUksnYiZ0lhxU53dDZlpher9ij65JXeYT7xKAjI
	qIpivdTyMi/XCFVfntUbC/juAuoBevOH7WVdDywHqSLTTsul0O90JQZp3CXwTUUNcIAE2GXnFee
	k2p+GLAIR/gT+6Q79kvcHVFrjJ0auUtep73xqWU8Ff05rTWMVh7R8Odjqb0DmjtA39gyjqhXTY1
	xBSzNI5jMd6mJdWe0dW8El5f627tkwYOpauNb
X-Received: by 2002:a17:902:db0b:b0:24c:cc32:788b with SMTP id d9443c01a7336-290c9c8a77dmr356305815ad.3.1761303027509;
        Fri, 24 Oct 2025 03:50:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4SSG/itxqgnKdgGyiFrTllLTfNfrUJwGLhCc/khz0u7V03VEfJTQRXCZctfAwDYJoqUrLBg==
X-Received: by 2002:a17:902:db0b:b0:24c:cc32:788b with SMTP id d9443c01a7336-290c9c8a77dmr356305375ad.3.1761303027059;
        Fri, 24 Oct 2025 03:50:27 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e23e4b3sm51236775ad.103.2025.10.24.03.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 03:50:26 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH 0/2] Add missing quirk for HS only USB controller
Date: Fri, 24 Oct 2025 16:20:17 +0530
Message-Id: <20251024105019.2220832-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX+pXlfyM/U++z
 pneGGvGu28SPcLUV1ioRWh7HW1nuduK5oXmMJ5ilxiuIsaXuVwYGFPn6AS44sl9VfWi13k/GoKv
 usDebgMlBOM26W6+Tz82fITooLjGbcQLQlj27up4V8zSUYlcPfTXWeKQkYedoYBlX52W5deZaA3
 XVBwtTc3O5D2Mdg/E9TpwsD9Vhs9qid/ly4aJN1jknbRFAbtYwfThWbVJVutODEuo1c0u/fSci1
 oizXqJIZqBY49Q96Vklj2pPLmH2PtfkgUT4+9IefbL9KG0eOWUhWvg4i5UWQ7UtsKLA+/oJn/LX
 s70PtNSPeok9WHj4fr/wQtRUG28QEttBQVIY56xbENiXno+2Fd3LjUcd8pYDBvGOJBAKpyozopA
 idqhszzaPD6/CKXCj23XHtAYBejDiA==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68fb59f4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=d1616NNI0-D16vPRn74A:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: j6lzb4X9S0otw0XyI9yMDSX8PeVcGvnV
X-Proofpoint-ORIG-GUID: j6lzb4X9S0otw0XyI9yMDSX8PeVcGvnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

The PIPE clock is provided by the USB3 PHY, which is predictably not
connected to the HS-only controller. Add "qcom,select-utmi-as-pipe-clk"
quirk to  HS only USB controller to disable pipe clock requirement.

This series has only been compile tested.

Krishna Kurapati (2):
  arm64: dts: qcom: x1e80100: Add missing quirk for HS only USB
    controller
  arm64: dts: qcom: lemans: Add missing quirk for HS only USB controller

 arch/arm64/boot/dts/qcom/lemans.dtsi   | 1 +
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 +
 2 files changed, 2 insertions(+)

-- 
2.34.1


