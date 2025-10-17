Return-Path: <linux-kernel+bounces-857202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 882F9BE62C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2E7A4E47C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DA82472A4;
	Fri, 17 Oct 2025 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9jpmoHV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78D7081E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669860; cv=none; b=VYxiX0uSpEfRucSvZhTEnLOuxxaOHSwAub4GUGpgjlfLD31FmYcHFYMZvSHbYjJLHxernej+F5CJbZssrhtlMoK7n8Pj5ZcQ7qUQp+yTOKY88ybdRre6N4K7Z9+uPd6uI3fVs8QjxHhifMr6CfG7FvIKwKN7j57thEsC971+fuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669860; c=relaxed/simple;
	bh=gioq/rreKsGDw5vfDqbUkugeReFdMaJ2zGZblUhmCHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YRxo4ok+aa1zQL42HnY8kjeQPbvAWVYqxtsDYOjqyca7j/0+j0gBGuF9chzkeuaKzZnzoYEREVwQWxzoVEsJVZdLaWlXSpadxfWfxo2P00lqhMyJcDS5RDEjYQzILH/YgZh8Eq5K2FFsiCvQEJrDvT9LXEsuSJhSpshrNuvedQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9jpmoHV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLLQ5001577
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=57abpEGp4rsrQeIj4jVZ6x
	t60b5upYPpH7ku0EvaTMU=; b=V9jpmoHVINxLFqxQwQani2hrxktiCSihFRSNU7
	RWIF7dvihcOzpJDqEKTuke83w0PV139XoMxeyG2CkCT0yPQjWXHZOx/Ax6NsvHcU
	v09kMMfH+MG2xfj+a9EWQAUNWm7yBQs7Frs+g1w6sDDpfk/LoOygb19P3oFumE8c
	WzyaLeAYlbWQl/FDTwNCTCEGXtODopNEcOviFD1pfkKHSkngcaHhZSVEQ0aEaugs
	15RCW/ZRHh4P0vS0NUiNsELuBgmHZLObjHu6JkvhctLRREdoF7MbVr4AdzIRQtAh
	ZUsXSK344DtMaKHe8HA+TanqUDvV0EnUAcYCDk6CKdx6rgVw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9apxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:57:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b631ba3d31eso1039126a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760669857; x=1761274657;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57abpEGp4rsrQeIj4jVZ6xt60b5upYPpH7ku0EvaTMU=;
        b=M3ox2YLxd4pWkTjZwK8+BL0cw4/JK2LyFAtfnqFEb7kLw8tNLWGvZorUM2velwy8f6
         /MT9jISvNcWMtjeCeJAVcFPwvH6dNFe2GNdlZMgauwUOUXssdUfaCzsEwWX/EJiUuLy3
         lxsjWXoRvBArno6qrT/TBeNrRvDlvDIeGou28EnTP2NulYHqA5bidEcBk5SS5QYVTha9
         b9WGZXGwZcf3/nCqdRyuRnUgMGQGcgIkVKKoMiJtkHo9kNyZscKNN3hFtmf0YEcXS8yw
         j2VxQLZHX10LqBnzeBEXh4RCYpLnPh1sjObaux4vtSoSiH1pDyZP21tt8e/qPl/TttDk
         n84Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMCHB4kPnxWHCXMCKQUhZmhVd1ghwCoX5eWUbzQEHOq+Cf3etnHHqaKcSvyqhmXfJouSLB/boODSj2cOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMaIyO+fvJH31WarvYC1Jq4V7ESrhlzk7aU8M+BxeDTXcYwZNk
	9ayaNafSqXQfXp6Coy/Zor6/aic3x+pJGplX2Kiy9TA+sjjmWbM5oS/yBkIy50CG4uKIHXz+YoZ
	HzRcwpyXcsJpaFqAiW9AxNJ74BCYletM5OAvll2moYr21WCNSdlTIXS6p/+ZmrPk86hc=
X-Gm-Gg: ASbGncsIVGokKZaLi6hBJePRd/mS7HotjtcBnpCmzKVII7XddUt2XsoG4TUbz8bhRDN
	pJWkObnpsOxlbN5mNmKA5kT83lYESj+VUhBDAzfcTCYl035RFFKT8ufQdrRIlDGVnwUD/a29Opp
	lgDnyG5IF5Y7/V8jwWZkyibNBRwpu/AD7Qz2wwJSt+/fWOTrTg6OJdtU2cW9A+Qkx/nSmVgAdUF
	MK9bLH4cLolPEYybl4d7LRlIwUEiERTMkSF+Uw1ipACA5tCZdBc7Loc6B3bbAYBdjZEWKR9JIQ4
	q4I6yFF0M2M7vv6MIzCkfsyU3IW1brp2Z0VmBlTXGGdh+YacmCOzToQMdiJXZeayEvdt6YshiY4
	C/GWl1ca6vo6+kWZN/r9btUPvbCRC8rny
X-Received: by 2002:a17:903:2381:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-290cba4ec0fmr21840565ad.38.1760669856952;
        Thu, 16 Oct 2025 19:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELK2esVZmsxe/N1H+g8EIuqchXgfN9778wy2RK38ItUmSSRhLSEWyy7a2rG4oRlKwmCzAxvw==
X-Received: by 2002:a17:903:2381:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-290cba4ec0fmr21840305ad.38.1760669856521;
        Thu, 16 Oct 2025 19:57:36 -0700 (PDT)
Received: from cbsp-sz01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099aab735sm46210205ad.77.2025.10.16.19.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:57:36 -0700 (PDT)
From: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 10:56:55 +0800
Subject: [PATCH v2] arm64: dts: qcom: lemans-pmics: enable rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-add-rtc-for-lemans-v2-1-0aaf174b25b9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHew8WgC/22OQQqDMBBFryKz7oiJxraueo/iIsaxBtTUJIpFv
 HujdlkGBt7A+39WcGQ1OSiiFSzN2mkzBOCXCFQrhxehrgMDT7hI7jxDWddovcLGWOyol4NDRXW
 VUp4mKlMQxLelRi9H6LM82dI4hWx/HqGSjlCZvte+iAZaPO75LGECdqHVzhv7OZ6a2WH8+sW//
 plhmGujRJ4Jpm7ZwzgXj5Ps9oo4LCi3bfsCg+yU9ewAAAA=
X-Change-ID: 20250924-add-rtc-for-lemans-cedb3e630c4c
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669852; l=1407;
 i=tingguo.cheng@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=gioq/rreKsGDw5vfDqbUkugeReFdMaJ2zGZblUhmCHs=;
 b=/ZpZMF7MoNslhltzpF5KZd0zv47Udhhxy/1OZFBwpXoCecTqHjUaiy0ucmwy4uy/LbYQjpnRZ
 Lywv0SHagvtC5Ggrxe3HQYZlUaxxnKUyhqgGomYm7QK8sZRht72mWl7
X-Developer-Key: i=tingguo.cheng@oss.qualcomm.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-Proofpoint-ORIG-GUID: jXOnxj0I0t1jI6oCLQU9nwOd6_t50qmV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX+435Gm11JUDK
 nH8WaAqFnpxALXI1qytUyf95ye5fNy4ODC9ZczztowYrO0CA+a6mM6RAsapl00Y0KAb7v3LQQIO
 giFmilOVsGKDnuVy1yBOT97Q9+zcPeto8PLBgyjxpAfjw3r0Eh/Y6qeqTKTP6AMYTtcm+bxQe2o
 dEtXR2W++lia0kN9zaGsoY4k2SO7pd3m0qGAsWgQ/QNg/iyg88rIRAUg4UOamyBwwMIujVNxi35
 /IpRQnhZKL8YYHZOdesMCIIxkllXMf9kk5XeS7hd9pXKQxJ1UWb/iUVJYdbgn4DiZENh1jXzq5t
 z442iLEGdh89vOy7G3L0aR6AthNAVQQI0YKAt50cP0zBoHV7e4D9p0HcIfqs87D2N9UZIsoK6yL
 QaiaZZHpnJPKnqeZPP5o79r+VHdqKw==
X-Proofpoint-GUID: jXOnxj0I0t1jI6oCLQU9nwOd6_t50qmV
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f1b0a1 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=H458QRQcw-P0b_fo_9kA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Add RTC node, the RTC is controlled by PMIC device via spmi bus.

Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
---
Changes in v2:
- Rebased on tag: next-20251015. 
- Changed the subject from "lemans: pmic" to "lemans-pmics".
- Separated each reg and reg-names pair onto individual lines.
- Link to v1: https://lore.kernel.org/r/20250925-add-rtc-for-lemans-v1-1-17fc56451c84@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
index 1369c3d43f866de9d8cd5cd4985241b99c0a0454..341119fc824406a5f45cfb3f809a07b95f71e0bc 100644
--- a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
@@ -132,6 +132,15 @@ pmm8654au_0_pon_resin: resin {
 			};
 		};
 
+		pmm8654au_0_rtc: rtc@6100 {
+			compatible = "qcom,pmk8350-rtc";
+			reg = <0x6100>,
+			      <0x6200>;
+			reg-names = "rtc",
+				    "alarm";
+			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pmm8654au_0_gpios: gpio@8800 {
 			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;

---
base-commit: 2ec29dae47ca4388367474080fc48cd0cb7a4d8a
change-id: 20250924-add-rtc-for-lemans-cedb3e630c4c

Best regards,
-- 
Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>


