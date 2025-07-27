Return-Path: <linux-kernel+bounces-747056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D71B12F30
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32DFA1894B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB9320299E;
	Sun, 27 Jul 2025 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkTASEIu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA271F5842
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753611786; cv=none; b=c9G5uk64NYgrqkZhaxu/49jUA5nFp9xZsFy+yXiXl+G1JkAfmyiyH5sLBARhByf20XWrjI0RTlbk2xEMoj1WBfLWMyrWgLP3EzLLT+S4SqmrvRDeRBPzAIigdbb5KSwVYpVICdhqueYsVZGbpujA9SQZgx+kvotu1v8zXMSLVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753611786; c=relaxed/simple;
	bh=8DwKT04rjXh7gfbZDcGLfNPPJTn3YtOLy32/XEy6SVs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uNxfOgV9PQcEJPC4MvyKMsOsrL0Ymp/aC76c+17BthbOXNBqNkslCNZTbqN11OWmIO6YDjis6kaGrobcFE6H1PrWpEEMwqzQ4iBOWMi4psCsWuMIZm0K1awTLITWOphC7AwGuVwYtLcAp4DQ/eyfpVDJkpkOrabcnbrCG3p64oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kkTASEIu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56R3QlpG011808
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=e2o60zCqNZTINfuz6mdS8i
	U8eywS1k6uOxBKlOKGowY=; b=kkTASEIudwePFUObEUNg3oURWma+py6sDGWbg0
	bRuXgf2QwuvWWA4bPw8OOarSaEP/uSlLb8g3/OsmER4Z9p+q/LeX8wXNPhEl7qzT
	9yG9jRgGg/OlKlRtC4xXZ6yFe4FelvmmANkC6mIMFW5Jdu8lvsHMQWoZFyec5f1A
	4aISrbtN1qG3+3fHycpvo0QdeqCO0I5NGoDEcfLkKXrkVVAtX9+1Jv3sOM1J7Zs5
	IBhp2CdFaq1NWSz7egqqrasVTPA9jKPrEZ/880nHP2hoA2ypz49l+M02xSPuAIXk
	9Xys1TOKK5m+/lJuTMdzLtUg6SfYll966mYrVYy3X/JBGFIw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytt3kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23824a9bc29so58771265ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753611783; x=1754216583;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2o60zCqNZTINfuz6mdS8iU8eywS1k6uOxBKlOKGowY=;
        b=vE9Vkvehdz/Xypoa9eIWHmV+96FNUSqDJWjmgbXcnw2KTfk5Oc7eaZaqyhMfIgo/vG
         qSrYkCRyOmxlqVIHux/k9gUaOuWNRpHWSGaO/rJvrRYDMm6dT7wohWjViwBzkHHNxDSp
         1zFrZOujYNHhmK9G9pVjPwsIIGbP2ehRy1YTIxTG6FXQuNceaXuihbuM2bce+N2Mc0mC
         bBHtXA59dTIkV7tVqJZ3sSQ+4Hd76XEHWJakh38GJbYhIS2gHyVYgX2wHewAPUEagfMg
         0B3kgF5qL0hFA/pkE1TkwpaWHvLovplfXWvtLxNUwX8q6F4By7+NoN4jPMyCKUDGirak
         5F8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYlkLtuxcmLr7EZee74J0GzwUeVQb8Bzv9N0WZcbYqaphD8vDZn/U0ad5vt+Lg9YnDcE5abl9lSHLxh/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzone4l3OqewBnoZQpGXK4TkHurxVGLyFEddqWvgfHEB8p6B5ab
	akU1W+5aVB5gZ8SfJzJncTiEWh01SlTLLO0ka5HEhviUjZ2dC8/hwW7Eyr9N6chZhw8JpwASJMu
	bZvV1Wx3LuElO+F4hZ2LUTsxi7+KVbc5mWm4l1Oshay9wTipnDSHVLfCgF8hU1NXiLHkYX2sJ/s
	M=
X-Gm-Gg: ASbGncuojISl/vHZbxeLdWOa4M6z/gcQkoZe5q4lQ5sHqVZ8uBtY+xTi41tHEMbYlpZ
	T0i3xxPLeiI5hoONnqjnG/j87qeX/RJXKXN8rDlytz0G2cNb5HTFp0orSATWzVr9I1r+XRxNufe
	WzHoXPVTTUjI9qKICDqpA9ZppaqSqlgTsxY+1kt9MdOZjbvJP4jOMRKVqehIKskMPvg9fwg8SuC
	H5Nb7VYUPVQWwSrjbS+rSpLT3Ym14opOIwE4d9fTa16MnUR017TVuqzRg8XgOEuOLK8nuyorbBl
	/JJ0Pyku1lLDwKR+ea7pfDswlGWAzf5smlXdgcKgm/clm+ShKkdZ9WlV57+DCKDaxm4SBPp6bHN
	0lbGB4GBsjUGVP0C6HCUrpg/pyl4=
X-Received: by 2002:a17:903:32d1:b0:234:b44c:d3c8 with SMTP id d9443c01a7336-23fb31b3056mr100413975ad.37.1753611782665;
        Sun, 27 Jul 2025 03:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzXHfyaoToeve/vbtpWJhmmneI3J3cmISb1enYYBovamI61z3WMPaTMwxyqWBWEQwGnYNVeQ==
X-Received: by 2002:a17:903:32d1:b0:234:b44c:d3c8 with SMTP id d9443c01a7336-23fb31b3056mr100413755ad.37.1753611782216;
        Sun, 27 Jul 2025 03:23:02 -0700 (PDT)
Received: from yuzha-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe533b1esm31869715ad.158.2025.07.27.03.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 03:23:01 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Subject: [PATCH v7 0/2] Enable WiFi/BT node for qcs615 ride board
Date: Sun, 27 Jul 2025 18:22:35 +0800
Message-Id: <20250727-615-v7-0-2adb6233bbb9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOz9hWgC/3XQzU7DMAwH8FepciZVPu10Qoj3QBzSxGWR2Mqar
 WKb9u6kLYch1kskR/n9befKMg2JMttUVzbQmHLq96XAp4qFrd9/EE+x1EwJZQUKw0FarmRQVkp
 HjWxYefk1UJe+55S396Ue6HAqYcflku0oZz+Hbarn3ywtGgta1ACNMIZLfknnE9WXqe1rn3N9O
 PnP0O92dTlepj6tz8Snm3TcVC5CsE5rFdC71pfMLnQewTnXQtAY20ANaM2mibYpH/vhPK85ynm
 kPxuNsvQPTSNNY0xHqP8NMMeM6gFVhZbPiAgiWK/kCtUPqOaCl1mdIWFQdGqFmnuKCzWFSq86N
 FECRlyh9o4qtVBbqAFEQkHKelqhcE9hoTBR1TppRRtihAf0drv9AOqXpOFWAgAA
X-Change-ID: 20250704-615-21c25118e919
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Yu Zhang (Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753611779; l=2003;
 i=yu.zhang@oss.qualcomm.com; s=20250625; h=from:subject:message-id;
 bh=8DwKT04rjXh7gfbZDcGLfNPPJTn3YtOLy32/XEy6SVs=;
 b=xpeZg8CmWgMk2/1bVi6yUmqLdhepGb6dgMgTlIOC+JN9hBoDCIIrR2iNJLoB35xllsr8AutA6
 bQfte9oDGmhBOQ3/CLh/QFCc96U0g9+8wwz8L/gd9yHN/VEmppEmMGj
X-Developer-Key: i=yu.zhang@oss.qualcomm.com; a=ed25519;
 pk=ZS+pKT1eEx1+Yb0k2iKe8mk1Rk+MUki89iurrz9iucA=
X-Proofpoint-GUID: D6N2J9tseMyvl2HottLWLBBi8IFyYsHJ
X-Proofpoint-ORIG-GUID: D6N2J9tseMyvl2HottLWLBBi8IFyYsHJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDA5MCBTYWx0ZWRfX+bbYn+4ahMrX
 BmuPnqIPZiOf2rt1B64FnsF5YU9Q45e+lMCZ0LLyuAf963/kItt6hJUTZCPhlVd5lUMuOq6Nb1M
 GkS+Y56ydkSbYrzds1JNeZi3aPclwUG/o38QA3mGue4NQf/hRryP+2lt2HR93gFAic4wfIDZsFY
 tudfYcXotVup0OWSHLl7IkxepC+f1PlOo11rEBe4bMidtAPGUkYj/WCmu/5fDgfsI6j0ww3i3ht
 AYSrSok25TVYmbssJdH5er+QTJhkJWt4xZRBQKFHrFhMbO+56Numgifp8uR5G6FAmjHo28XHajH
 24OYcIWgMN/KlsKJk2MLxyuh+24FU3EZB8x/eKF7XG9aHpVf1dJiT42RAs5Ifsyil4p+Afb/LBd
 z28YVqAAEOio0NcxelP2ZRlfw/5qAU50W93WyqPPTW3ijujAmTyQYRR1Rm1qxdeqpKl6XM9H
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=6885fe07 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=COk6AnOGAAAA:8 a=TmzUbGvDyKMaPb01JRcA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507270090

This patch series depends on:
- PCIe
https://lore.kernel.org/all/20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com/

Changes in v7:
- Fix DT node order.
- Link to v6: https://lore.kernel.org/r/20250726-615-v6-0-42b8150bcdd6@oss.qualcomm.com

Changes in v6:
- Fix regulator pattern.
- Link to v5: https://lore.kernel.org/r/20250722-615-v5-0-4677e70e25ae@oss.qualcomm.com

Changes in v5:
- Fix DT format.
- Link to v4: https://lore.kernel.org/r/20250707-615-v4-0-1a2f74d167d7@oss.qualcomm.com

Changes in v4:
- Fix node placement issue.
- Link to v3: https://lore.kernel.org/r/20250704-615-v3-0-6c384e0470f2@oss.qualcomm.com

Changes in v3:
- Formatting: adjust layout based on reviewer feedback.
- Fix DT checking warnings.
- Link to v2:
  https://lore.kernel.org/r/20250625-qcs615-v2-0-0f1899647b36@oss.qualcomm.com

Changes in V2:
- Correct the version metadata of the previous patch.
- Separate the modifications to the DTS and DTSI files into different
  commits.
- Formatting: adjust layout based on reviewer feedback.
- Updated the email address.
- Link to v1:
  https://lore.kernel.org/all/20241203060318.1750927-1-quic_yuzha@quicinc.com/

Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
---
Yu Zhang(Yuriy) (2):
      arm64: dts: qcom: qcs615: add a PCIe port for WLAN
      arm64: dts: qcom: qcs615-ride: Enable WiFi/BT nodes

 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 135 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/qcs615.dtsi     |   9 +++
 2 files changed, 144 insertions(+)
---
base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
change-id: 20250704-615-21c25118e919
prerequisite-message-id: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
prerequisite-patch-id: 37d5ab98a6918dba98ef8fd7e6c91ab98aace170
prerequisite-patch-id: 1693faa1e23bbb0a37d4fb9cbe13e5dd43148ce8
prerequisite-patch-id: efa688b2ddd5744df7aef40182787ee4ceb90c98

Best regards,
-- 
Yu Zhang(Yuriy) <yu.zhang@oss.qualcomm.com>


