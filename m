Return-Path: <linux-kernel+bounces-882516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 193BBC2AA3D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 863104EDF72
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D422C08C5;
	Mon,  3 Nov 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G07ZWxKE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HBSWID1D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7324A27144E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159920; cv=none; b=j522AFCJFIDl2E2wmHK6hFem1Lv+4TCJTNu2jTyJuNRGpT8hBy4N0Apmr2Melv2DcxUU5DWNyLkSMTlLqMuZhigJ35Sfvrkt4gszQiYYC1p7gf0rJH4XeS0yNYq/6YgBbQV0ugcYV8CZbuh5Yl2R2qLbHaldgp1TEQXojKk9U/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159920; c=relaxed/simple;
	bh=HZekR+X1QQ8T+n7KBLJNAnNWovL2r7FAK8kQNXZzh34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o6+IJPKdnTdpyUzVD2V7ili3+XBtNZMU7keYzI5GBPbnNrqbYatfQt8ROGL8qY60wXLgSPPSxxO66NaWCtgAlI6r0LbvTzB3sx3HBZ73kBebItaay0LZfG21DUszZFXOTMc5P+TyDZ6bUnTJytoHLOS9DK1x+1D5lymmAA3+DAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G07ZWxKE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HBSWID1D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36BNOW2267923
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 08:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=c0vqi6jj/b8CbGVumVnkzg
	xG3KjKbgL/ynWKTJBgytI=; b=G07ZWxKEJdR6yvZAoy96zzRTt1U2QH7asRKYYw
	lfl/7uruRMFLgT6INo0nTZhp5ZDJLqyE9SHtC9IOMZbhlNCH392Vjanp0Rhj0oYy
	BYtaGQoeVky2ToDZ8TNrHugUi6RIzo9JMzvBk7FhfKn57sT0v/OzmSP1hnB6b3W8
	2ba/TgZwLnk8thbKer7gtc1lW1AKPxRNpKojDi+3XmA5Myx8vGlVZDfCKh+Comdm
	mRzfb3eW0t2w+/MwMJv9W3Y2TbUhtByt2KBGMQLCgPpQsM74jf8ufDOEnMdEJcgP
	tmANYXG6wGiAZ6uO9XmMxhtlXiwHraG0Et7l4DyS1GdlIsVg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6pwagg07-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 08:51:58 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2954d676f9dso14528195ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762159917; x=1762764717; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c0vqi6jj/b8CbGVumVnkzgxG3KjKbgL/ynWKTJBgytI=;
        b=HBSWID1D8Wxq081UP/8ANSXHVTM7xRYjaattsjjsAyFEYIdMeHH6VA6PH9DPJBjqFc
         oHKeY7c8EiGYiRzLHsOPkWK3enIS6bo3bTi46Fg6aCEMwlPdcdH6z8nmnf/Ye5JYpuCf
         tF+4AiDrwQI8TkW5U2CqmCAl/TxG0hl3y0/3IzlCCBtYECOZvesmLSeyxbSTa993EsY+
         h3aPezkxo4c8MmxM1B330AaQQr6Sc8ZwyHg4+45vARrVNQi7mRisHdD5gFA6mJQjUjD9
         R1eo81XMkAycYJJTEFFnR/LEKO9PWwJQmh5mVrmiIMd7fP4zwtNkrjxW0Ui9MrsYwdEy
         bLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762159917; x=1762764717;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0vqi6jj/b8CbGVumVnkzgxG3KjKbgL/ynWKTJBgytI=;
        b=XUZqGwKIf1kbeJmKN4yU4n+oocdIfs9PHbNl4lORymewb7iCm8plfHFL2+idw4LGxG
         P/qp4b6Cx4Rk370QpmbSHUnWbu4VuDW+hRXJVJDAUdcbhmAYoYCZ/QJx21R51gOVmcsL
         O/Iwju5uTc2T/pwvLo8WRjXkJOAS8phaphs/TkZLzD9/4+BPjqOqPqy44bBesMN3ozKP
         zyZESipItDW91eSyBVEWWpcEIwhJX9KwsWHP9Lx8z1DnUc6hDZlFrvbjDruZ7UNCHXRe
         RsX4UdhZzUZPmlf1dq+9nK56G9P8rY4D/qWK+OcPaTlfIfYNZgKidgJRFZveWCyl4g8L
         U5sA==
X-Forwarded-Encrypted: i=1; AJvYcCWVxBmX2mrGI3Ut9fiPjIf9NuzPqGqQfyc6cyPSsLawnIzBCxOzZh0C1d3+lhNG2DUjyoKD2iwTXhEIx1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrrc4zzNfMl7JsabINJhd/hh6cjHDR3QyUfIYCuK8oW5UIhWer
	MdHuknyNXVDIlCQwaAXiE8Gp9fCBhicAahNu7yJuSkG3SLvN+ix/HtmBDiUXP2net5PLo2+bCfi
	Ybyl+BBHL27OAg9PTIPsMZRO6DXFfpyG4hM0ifO8OexrxKKt9Z+emL4Amjnz+k/RkWxk=
X-Gm-Gg: ASbGncu+cP1l6vJtqrhRJJHZArbGZSrxr07Qe3Yj3qaJhtmV/iE6XcwpyILz8t5Lp3j
	80u+DC+3PldjO3fx2sQE770tt5DqTTckkMrHeCLO4gsUkFhMCdO+lNqyWnOJsvHb8dN++tqaILh
	/cXhvU3RhkODT34jy4dC2/EcZrGad+OU7Ys7eAX843LHCfG70pZKbdhq4ynC0GLSvHkAkk779Uc
	FcqDN/eaF8oZ6KnH6Tae1HTwNEU0Ems2O9Bd+F8h4To6Mc/WDaQKx9+M8m8OLW4obxo06v5/6jU
	8Ote4VtFg+w1g6Pg/o0+jRwO7TL715c8/MTdjYRTEtyQ1xz/1yRO+slzZ6Maf+VdIQtjCaEL5EW
	6+I86QLrCxzYHVf6MWqR/ZA==
X-Received: by 2002:a17:903:24f:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29524abfc57mr117895415ad.22.1762159917462;
        Mon, 03 Nov 2025 00:51:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdFWZ5eL263AhpbzBjcsP/SoG/gFdyoVlX/8S0qnFen85cVcRcaeE00KTs+4TsynF2ykEGmg==
X-Received: by 2002:a17:903:24f:b0:295:24ab:fb06 with SMTP id d9443c01a7336-29524abfc57mr117895035ad.22.1762159916789;
        Mon, 03 Nov 2025 00:51:56 -0800 (PST)
Received: from [169.254.0.7] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599676d6sm255142a91.9.2025.11.03.00.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:51:55 -0800 (PST)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Add interconnect support for Kaanapali SoC
Date: Mon, 03 Nov 2025 08:51:17 +0000
Message-Id: <20251103-knp-interconnect-v5-0-f9929faddb66@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAVtCGkC/22O0Q6CIBiFX8VxHQ4QkrrqPVoXQL/JSlBQV3O+e
 +jaasubfzv/zvnOmVCEYCGiYzahAKON1rskxC5DplbuBthek0aMMEEOtMR312LregjGOwemx1w
 aZg5UV5WQKMXaAJV9rsjzJWmtImAdlDP1AmpUTOGPMUA3pMr+665t7H14rXvGYvmu1ZQU5L96L
 DDBikiuOJOspOLkY8y7QT2Mb5o8HbQwR/7LoRscnjhiL7VWzOgCtjjzPL8BQZPlni0BAAA=
X-Change-ID: 20250917-knp-interconnect-48c2c91bff58
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=69086d2e cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=NeJqaqV_MRuGqkmvWOwA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: iLZSYT8nChIEmMF6-y3Tr-7v_AIBlOdR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA4MSBTYWx0ZWRfX7H/hL64ZULUq
 H8xY8cerRamn5GoGrUkngNpGfz1f0AEfstD6vhRciD/LTRRvOli3FzV6vW9XkdlG0RMZoa8Hz3Z
 MZnVnaXYm5fVinCjQL+8JvlUfvON2lT0Vmh2AlHcv8CK02+w3y9x/FyQFMMJlzJUqsx+/3vyzRY
 BVpDpZRRwsI9wnyKukBedwgBoV7hhwiGjVF9NrVDivcTVOX3GqDA7TLmEDEW0xTBnJ8qjXRm5L+
 6nNz/tz2m7IDEfe+bggBta4/5I/sgDnj2NbPjjBkPFQhEIGS4q1Qq7gnLB7KcUAjiGU4C/Jfd1e
 fJDIMkeHMxYMUEmnqWyt4C/kw4ijUiY7I0VpTPJ9upExV5jjtmb185z/6+4ipzJa+QfbGwj8hn5
 38rMPnDHflGBmquyzy+TyorM2IWzCQ==
X-Proofpoint-GUID: iLZSYT8nChIEmMF6-y3Tr-7v_AIBlOdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030081

Add interconnect dt-bindings and driver support for Qualcomm Kaanapali SoC.

Changes since V4:
  - Updated the SoC name in bindings [Krzysztof]
  - Link to v4: https://lore.kernel.org/r/20251031-knp-interconnect-v4-0-568bba2cb3e5@oss.qualcomm.com

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


