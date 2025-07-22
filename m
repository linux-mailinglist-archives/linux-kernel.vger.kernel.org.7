Return-Path: <linux-kernel+bounces-740215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E5B0D178
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F420E1C22C46
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1AF29B8C6;
	Tue, 22 Jul 2025 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IDApwS37"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A028CF7E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163470; cv=none; b=hNma37CoxbaO5gQSszSYBxmFcI4uZywHZwSbSE4syOijte+d5qALFrMDCP/CIOeGqoYnAjVl/Ft1POKK/DFLYeLqvpGkQbv4nfhseMjqTmPTEhZ3Gw0csw01dMaNQWbfkJFZfKNzt71e3BJTKQK9ypKLbTXRTE0FTn+QUJB2pis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163470; c=relaxed/simple;
	bh=LkPnRAX/oeMeE+OrufVGyi0NXGZ0qUs+Av8g3FBETwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvEgAdmQtFKENn0md9rf7TIKdFq6l/iqCAyWxHr/wnPWxTGFFuKkVFA+oz4qpRGYsyIwdPz/c6M0aeItUcK1lX8orL86McoRRfGudeCbpP33qX7pl0zxfkDqzFq+NOJOa7qIGacSHWFl/dH5YQPesxzDkT2WhIy4hffqUflRTh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IDApwS37; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LIfxpJ018339
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Zhy0MZ1jZ8F7Jnao5FbZ4vgfFLZ3bbYPjtt
	A+SWufIQ=; b=IDApwS37Ixk4XwHAFqXY43tY/gD5HrrQman+UPEfcacdv1A7gCW
	8aDG8quijQ/kja5rF8LB7Jk21PPDNtfbLy4AnPxRcT3YQgP7dzO3s8QoUK8WdjMn
	CveS8xLEPh92kjpza1XADRhjQBvrUXHX41zAgoL6vC+JWxt8UxN8hvNGi7UYXXIF
	F4jrk0cAbhThAPFRg8oYsJW80AKsIcd9srvhjUkFd614lX9XIbu6fHFdvP1q9OYL
	m+mGr1rGOmbXwk5urvBjibivQrVTBP5ioS4dFqWiPEfAMMot4quhf2bzBfHCAU4r
	Xt3sba2P7sR+pbsgicrJwCvkcg5USID8pXA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804n9xkqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:51:08 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74943a7cd9aso7710787b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753163467; x=1753768267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zhy0MZ1jZ8F7Jnao5FbZ4vgfFLZ3bbYPjttA+SWufIQ=;
        b=tlYsB5EC426K5xcdMPxe83zgZ4Mp6qto8NO8aTRfbjVWtJh1J8AfwJvIn6ttwIHrL8
         A1xyOegwjXEnMpP7mIupaII21gsGfTEAaKD1ttaCqq5cR18nak06d7K/ysT2qX8VwkB5
         zTxkBtgDh6nyDU+jS2F6qm+mYaGKf+bWorK6/z3oOucQn65gxDXyWyKENRQKdLx612Sg
         DYy6rNhlP96kCrlpTWy0TNN+PBvlC/hQw2h8fHEvW5asoKXsKUzZAgsBiW74LzCDIU4s
         1qqpxUbhexx9OdZL1Le/ZoRCt7gkdNETpAaAND8BA0OhwF++2hP2VRBCPcfQGLH4E6yf
         0BEA==
X-Forwarded-Encrypted: i=1; AJvYcCVCieoYmSZ67Cd/6F7Xuq5z1P3T39DveZuVTuek78WqLGCoTm34QhRYq51aAL4EVb+H/FsRPlpeWF8Dcis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tf7SjwY0GunmsycIcPWh2AMnePcbuzYyq8AiA5WZnKqb9k/2
	WLVOV8FLPh0bSVhkyLYch5qjPPwwft5ekiF/MNJelQD9dMIgTTdha7KN8AHhY1FBbyHcHD3UPXx
	L7IRRFNJXYZq9zMWgibdInmEhA2ouyh/e7ys/jfx8aAJ+lmnoFHrwuijJm+nHPWofTXU=
X-Gm-Gg: ASbGncvucKHynUy5oddz9ZynK/COvUoqcyVGR2Im0NLgBhPi84VMvvM8GzFXEn0oDxf
	/gersoY3MmJYbvJgBaYAhDUTK2hb5vd4lN2ZDeWQJiPsbWcmVgbuak3pWSBrQzjPxHiYpE/66Hf
	T7N2jRCodvMG+2w8lHPzVRsEFe6hpBLPaDPoKwDFNQfVI6bJldys8in2cbtQCQO1xawiZZJEZGQ
	0xrOdi4J0T7NDizbtMsevRMXyq9FlgVqzeXIlgQivCPiddABvQDcTSLJKVBZXFeFA0vQOgzbejv
	TdpKqZf1OJ+uWFXR+fApIpkdyo0Kyu1NhH4QeT/w4rahvJVOyGaXV1WM70d0hw/LpCZC2+RnpJk
	tY7E=
X-Received: by 2002:a05:6a00:a8a:b0:740:b5f9:287b with SMTP id d2e1a72fcca58-75723165190mr29279619b3a.1.1753163467210;
        Mon, 21 Jul 2025 22:51:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN6iDLyXNCraZNT8x/1YReDJKwIOmpbnw05LKZnQXeSdXkn2GEn4y/ij1foKWlkejDAgwPZQ==
X-Received: by 2002:a05:6a00:a8a:b0:740:b5f9:287b with SMTP id d2e1a72fcca58-75723165190mr29279568b3a.1.1753163466699;
        Mon, 21 Jul 2025 22:51:06 -0700 (PDT)
Received: from 2603feb0d442.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb155e0fsm6669136b3a.71.2025.07.21.22.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 22:51:06 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Mike Titpon <mike.tipton@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH V3 0/1] Add EPSS L3 provider support on QCS8300 SoC
Date: Tue, 22 Jul 2025 05:50:38 +0000
Message-ID: <20250722055039.135140-1-raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: D5AaTHNQQJvIP-46qWKgLRuDbBaO5Vpb
X-Proofpoint-ORIG-GUID: D5AaTHNQQJvIP-46qWKgLRuDbBaO5Vpb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA0NSBTYWx0ZWRfX2Fkpf9r7nybi
 aY5gOsudr0L9Ja0XZ+5tdjYiKRTxKtfzNc+oMYhjuwBc8rKfsxJPyhQKu0KvcGMsRtU0CqE0lx5
 fzG5EB6PcnJPynL7TacO5UHJyhS8WFogwOWOxg/Zoe2ObS0utL4QMZ4WXuJzFYEqy3u4g9s8ifR
 pmKY8Gi8/xkYZe2Y4Aw5+x4xC2dEBCow3KAarqq80wQGo0+4D3RMTP1aXdb4v4C/VAedGQYzqJ3
 R13nXe0NoYIxO2smydk/xfItRT+0wTUoSBJUQjhz+Bgu0xIfwPeopJI0yc7yTdx1l69Uc1WaE2Y
 oD2WHVKPtVm3/ljGUn2UXyvO6p0Cdusar6OHvqE40JckbF2OFDTr82cUxejOnwnjd+lfPPGvcFj
 j/E5MAu4smypeVKhXS5yh2LaONGS4De80TtTWHvJDmd/KtWy164TeDSIHlrwkIPHfepcCeHD
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687f26cc cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XhFW2igMmoW6a3705fEA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220045

 Add Epoch subsystem (EPSS) L3 scaling support on QCS8300 SoC.

Changes since V2:
 - Dropped the dt-binding patch from series, as it has been picked into
   linux-next
   https://lore.kernel.org/all/20250711102540.143-2-raviteja.laggyshetty@oss.qualcomm.com/
 - Squashed EPSS L3 provider node changes and CPU OPP table changes into 
   single patch [Konrad].
 - Link to v2: https://lore.kernel.org/all/20250711102540.143-1-raviteja.laggyshetty@oss.qualcomm.com/

Changes since v1:
 - Removed SoC specific compatible "qcom,qcs8300-epss-l3"
   from driver and used SA8775P SoC compatible as fallback in devicetree.
 - As the EPSS hardware in QCS8300 and SA8775P SoCs are same, a 
   family-specific compatible string for the SA8775P has been added to the
   bindings. This avoids the need to explicitly listing each SoC in the
   match table and the family-specific fallback compatible can be used 
   for SoCs sharing the same hardware.
 - As suggested by konrad, added EPSS path handles for CPU nodes.
 - Link to v1: https://lore.kernel.org/all/20250617090651.55-1-raviteja.laggyshetty@oss.qualcomm.com/

Raviteja Laggyshetty (1):
  arm64: dts: qcom: qcs8300: Add EPSS l3 interconnect provider node and
    CPUCP OPP tables to scale DDR/L3

 arch/arm64/boot/dts/qcom/qcs8300.dtsi | 301 ++++++++++++++++++++++++++
 1 file changed, 301 insertions(+)

-- 
2.43.0


