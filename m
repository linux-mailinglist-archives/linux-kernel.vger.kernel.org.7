Return-Path: <linux-kernel+bounces-743776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF8B10335
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DE41CE2950
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729BC274B37;
	Thu, 24 Jul 2025 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TlFDArXX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5562749C0
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344963; cv=none; b=XH/ShMC8c545fE81WmGNZjkCJoQBdWuOJ8tKna6MmWNVr14to7mnSQ3DXOHkveyQJPHQ1GdptsIlpTveB4eR2c39y+8eQ7Msu/9duFD3o+xUDUOOT+RbafD31M8eUGCrPZU/hTjgkN7GxC7xl5x4K9fEZGTyX2SNkAJmhkVUZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344963; c=relaxed/simple;
	bh=ZcJEhMl8aRXGhWKoedNGnq1deLTIo6Y1rB5+WklLcZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q/bNQ8tkPa6B7WSd9a+6XBrYju0UxzSckZZApI4wOAS7K30u/WuwqwzdBjj2ie0emj6Z5anoKDEJLFRafRJYE5KLveFSPMBgarydeytneRzHE1HIZ1QtdYPzlWxjIhqWHaca84EqkPl/GV4ujs+kaNF6JhzkgE/wzvFGGDW4YHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TlFDArXX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NMXHhJ028541
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bm3aovFQ/K0kdRKvGL94PyzsvpCmxQWUujwTzg2h1Tg=; b=TlFDArXXRyqs6h7Y
	G+GN1cjqYrEwafzY8lQxHId5bEGmCoahaegwbrx7JmTxsImVqV2KQPjcKQzk/o2M
	a3ck6USDZwnmsT1MIkZH5FtJPR319eVN6tWuKKnhZ8Q1OAn8O9KXDhTHn5MYxAZX
	sh9KkLnk+aHi+qo3L/ujeEC8qarM6MRlGwr4zy5x4eDb1aPnYLydO9o5iKZd+5v8
	pgEOU38T82lfABFNa5h+KXxmPOxN2eyCeOOUwiE/IiLwD8Q8N1/WWe0/g1znxGH3
	jW7eEK7eYOeBb/3CCj093XVFRR1tLf3SnNPpiZnQau5iLdceGws0LTUaHKNC8Fwj
	0T/UCQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1f98a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:16:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23632fd6248so8013665ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344959; x=1753949759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm3aovFQ/K0kdRKvGL94PyzsvpCmxQWUujwTzg2h1Tg=;
        b=QKEg7wP1kEf8+QK6Y2wVE6FAFpyRiFTEJNusWrTvkvyJqe5JcM1mbqdwAZ5pb1glYE
         LV1rLGMn8f0ZoJScUS6OvxXsybrDilsKqglXoW7QULBzShluoCDkPGKTImCRMWNOJNzz
         j2e46+rChfpTeCeMfVsCVtOhqB5yoayJlJFpftfzIKjLpV+7RgzF8Bhx3jtWtBwt8gaY
         d7cNYy1XDRxEVYSkDERD+LdEqImkzLcN2M6RFnZ2//SK9ZeHzZG6fvP+PKXbfCM5bt45
         Yy75azf4I4zHM86yoOFijC5M9oNZ8vuD0RnXVoFuMAwEsBmNL9kPPvXQyxTO6A0qagO3
         5BIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlKxcQ+EU9KA/SlXvXvF12/WOdS51YqydXO/Ngb/Mwme07QFKid8gZHQuxgYETZTmjKMa0B0nMlQunEtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmaUcVI5JQ86ndJIneNyzFXA9+XQD8g6gRNm+ydhDu/wqzbAJ
	99J7IVBOZNLbxaz5fzzIWx1wzZ+ID/kCZ4iHuOWZmgeGAyd/IiFKpLZDofGIyCF+L30KanZnVFk
	o8KB/CLK1cqffuXVjTct8qLv2M2El2hIdH2jxcMRmSbwSABWVUOYcGXndn7LeC78jMWU=
X-Gm-Gg: ASbGnctybmf74Rv9hRyRVWL7TG64wlSLcqLT8icVkFpKINJAZh14DOzOibJERf29FYg
	9jXj1a+gbBjEmisPkWbxfquj4mOMdqOUhL1iiFtsUv1NUoeUQhQ+wt0J7WuEXAdNjsxR1hquBaN
	y8t4uCOdrU82cZu9V30UlxumPiPg5g2EH3FiGnBlOni0FKV3FXip6T1eLMmhljFnGUenUWIQ+Ed
	b+MraDvZf6Yw5iHXY6ZeLONc9ZtbAs5PI5/V/FawM4lBzKqVAkWV621W1gpFV+b2gbmiwbaa+Sr
	eS5aVQA7Lr4i58sYucRPUa121vOH7M1MvesgNTo6/oVAwtiycQkGahk1AhJpXKQapDXeC7M71iW
	cz2f9/alhGoIeEWW0JcE6N0QBZ8Gq72+Mvw==
X-Received: by 2002:a17:903:1108:b0:235:91a:2c with SMTP id d9443c01a7336-23f98222756mr80195995ad.42.1753344959557;
        Thu, 24 Jul 2025 01:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8QThZMPnBD5usjJurD2Nco802MoUQDuB84FdLmRcEGGnZ5jABk3voC7kE0hdHOcQyT2fWyg==
X-Received: by 2002:a17:903:1108:b0:235:91a:2c with SMTP id d9443c01a7336-23f98222756mr80195675ad.42.1753344959117;
        Thu, 24 Jul 2025 01:15:59 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa476eb07sm9770595ad.65.2025.07.24.01.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:15:58 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 16:15:23 +0800
Subject: [PATCH v2 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-hamoa_initial-v2-1-91b00c882d11@oss.qualcomm.com>
References: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
In-Reply-To: <20250724-hamoa_initial-v2-0-91b00c882d11@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753344953; l=1359;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=ZcJEhMl8aRXGhWKoedNGnq1deLTIo6Y1rB5+WklLcZE=;
 b=rs/99e5tfSDn4Oy32jYJUz1CY7pa1am8gw6kaWuQH4/GStUUMCtJVnjq5XD5Pw1HdZYlDKNcS
 GeyxYTb44U1BITSwGyXn8Sjiupbw4PytE7IJgGrfHwuxlLJAHGxaLL3
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-GUID: 9Fsf-rz5R-qqw6fbGIw4n2fyJ2v3ct0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1OSBTYWx0ZWRfX7oQWT1iO+/RY
 CS8YvzkU7IJwCiRPuwyFZ00IFUUcCU2BSdy1i4RTkMi6GnX8Q9Aha2sBuJNOE+f/aHggtVVYq9h
 S8aqSGa8pJZr7NH99iiRiKkBT+M3udHzT476c8IIFWrMC8vUjSc3z5ovsdcXthStEmRUwkXH6gX
 76pLCP06jo+nWpA7e124vHWpV7SC12Dhba7cfXmyQ4ThEusqdh4eHry0XFSLvDNEfWJUCMsbsRd
 DY1cybCrV1Ndcb0vJcZAEBesTH56vxI0VKCkul2MkKGr3tjDbKkz0kiXVK4ksrlj8oZD94fT8E4
 6BH20miIPTCUr99OXl5qlAug+5W62ZcoVVlHFCJSz4skYMiNTxDgwoR5dRrpTr1yyBxDX45PYkA
 TfDkaQZjSwSM9RBadxh6hKwIA6QILRodLjKbg47tx98HyX4oZsG6WtjvMz9NBRs9EVxsEA4k
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=6881ebc0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=X4CchLBkMRYhfesQTxMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 9Fsf-rz5R-qqw6fbGIw4n2fyJ2v3ct0V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240059

Document the device tree binding for a new board named "EVK" based on
the Qualcomm Hamoa-IoT platform.

The "hamoa" name refers to a family of SoCs that share the same silicon
die but are offered in multiple speed bins. The specific SoC used in
this board is the x1e80100, which represents one such bin within the
Hamoa family.

Although "qcom,hamoa-iot-evk" is introduced as the board-specific
compatible, the fallback compatible remains "qcom,x1e80100" to preserve
compatibility with existing in-kernel drivers and software that already
depend on this identifier.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 47a7b1cb3cac1150bcde8c2e2e23f2db256ab082..f004019c5691e0a9a3d56a0e3af395314ceb3745 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1161,6 +1161,7 @@ properties:
               - lenovo,yoga-slim7x
               - microsoft,romulus13
               - microsoft,romulus15
+              - qcom,hamoa-iot-evk
               - qcom,x1e80100-crd
               - qcom,x1e80100-qcp
           - const: qcom,x1e80100

-- 
2.34.1


