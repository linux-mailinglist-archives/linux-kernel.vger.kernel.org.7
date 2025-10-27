Return-Path: <linux-kernel+bounces-870974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88659C0C201
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E74F23B1A20
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D92DE711;
	Mon, 27 Oct 2025 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XjMsrNjH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574CF2DC784
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761550073; cv=none; b=Kg+g97wm4PJzkPs4dzPzIhfr3/Vk1BnxYV7S70+gmzZ4l4KiWXd2CddTZcZVOQFfP21B4Z9oRhfimxnoQGhgcTcSJgxPX3xmaEOxle5NNOo5coeMeIHHOcxvlwX7U6UB+aEED4lTK59h7+2k4dNjNeD1Dus4LMzopfxReXPVFpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761550073; c=relaxed/simple;
	bh=zrV2MeFOwCCn1TbSlYoH2QLD7xFQ4yvvx2GUblq4lBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EShEtL7svymw4UI5pUuLo+mJHeeN4bJJPIKf+EN0xk6XE6f6nveXUQ/wiEA8Sc9c3hEzV+9UtTf0t7fNn11NCAnCNgDbqXqrsnNioyZm740xqQLA7+iQBvVQxvObuhmZO4CbwZUFufoRLGCQvBbI59+b8FhtTBT2iW0c+6nOW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XjMsrNjH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59QNZKJp1101662
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mFF9ZA9r3BfOY5XzYGAX3yfLJELJvXztU48
	FwzldOw0=; b=XjMsrNjHMh3KaEYoRYYt5ky4Cen4BKMIn1xPoORT4Nl6Y59IexS
	knvFzFhz6zKj05j8NWMTPZYifqdRyMDZh3Jd/wfAZmCWt5nVY+COuPrz+hoxMLJj
	PyRQcbJEIJ9dYi5k7odW3aLtjM6qPTAu21AIEV4qv9P1o02gVd7Lw78CL5BuQB02
	TWmhFYxhWsxd8H5vuOJWi+uw+f8rZ/nfFs4mbMHWwV7e7Fm1GJZXBKvSQRy0ggq4
	ngfGaeJSEeY0JyaqQu85gKb71IsQq2eYGR5XvPHgCxJh15oBsHgm4VGOQCm6vGsK
	eTHSxAvj1x5XuXalHfaiQ4+hJukxjAD1Wdg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0px6kmaq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:27:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290d860acbcso97428615ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 00:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761550070; x=1762154870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFF9ZA9r3BfOY5XzYGAX3yfLJELJvXztU48FwzldOw0=;
        b=PWUfGyn7MRQV7wKodFB/RsZ1/0Fj4cQtVphbb3NzLOvPAbOpDC1qh3vqoZZAykDmQl
         jbe5xtRUKS8Q8awAH88EJT3rNVBdT5LjFsiVCbuD/JxAWNMVKe7cDnWZThnDkwAcukn2
         Iqr85ePDAjedqRe4j43RPCNzoL/32CfeKy9XG9x5NIsELT3km+sYcysX//rrHCBJYjFX
         A16mpHAEcDD4UJoBRw4QlTFAaqyOCGS8cMalig0lz2SJHdLeRSC2vJZtdoCRiGHtxyCr
         p8oyB4t6ehnh1Mz/KxPkdN1QH3gOnuKrtzJ1kwx6fR3DMvGXyszXivsKHQFEzoarQEfo
         B5ww==
X-Forwarded-Encrypted: i=1; AJvYcCUQ3en3aHTJ1ETf4pWYojlCaZ+3XIR5h42+lokDXS73zyJ1iFjquw2zKy3eT0+R4Ol6ngMZERGEOJ11bjM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPcveKIdfXoxhRiat/w7u0Gn4lHAGdS8L/wQW2n5WijzasSpx
	mg1g5AQnWAcfJOBtstVU0vDPaMjXQlOYN3qkFtNR9N/byRpQtXUYjRkqq23O29Mh8DYAxR9ok9Y
	3GpYDeY8DvPw60+7IOP4h0eEayaU8WFZhbhekypEyRhoNlpeo+9asn6w4NboVjNc8yRw=
X-Gm-Gg: ASbGncuBZimRz3yJ5G5Vv1tUwPmZBS4WIPz1abEA3R4uKK4URNImuaSVBR/KncHkwrF
	pBWKVTMl2lSwV1BF+noKZM//w4d9lOh6DB6WZ3BIuSuUiy0MbouhXi9mII6ZSIfxMCWKPXCe+u6
	zk+AcKOGzQ6kyk3DGQO8ZBhv+ZIvMkGJWMv+N2pup5jhXRjpA2WebFPPnv+sYQ5nrKtVl3wB9Et
	gqLUjpNKrfNi6QSDxPtG/NWNO59V+MtB+QtLuvrZVtXOkSwFmDbrxMNOcsWiUMn0zGSSqVgpAbv
	nZcZGLbXw3y5vxemPK3tbr8bDdcWqDRKz2zUqYYwRs4hpFLQW49aGmeuiGIEayG0OUdN8aOr2Sq
	zKVagL18aH7SAkL+VX2kA5cSt+WMjXw3bOWZO
X-Received: by 2002:a17:902:e88e:b0:28d:18d3:46ca with SMTP id d9443c01a7336-290cb65ca07mr458225605ad.49.1761550069764;
        Mon, 27 Oct 2025 00:27:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpi1TzpQv0X/HWE/wfdrTRqzkkZn2x5d1Nmm2t/H/IAoV6csMvqY2brY5Yod2E4b9v1YvtUA==
X-Received: by 2002:a17:902:e88e:b0:28d:18d3:46ca with SMTP id d9443c01a7336-290cb65ca07mr458225315ad.49.1761550069290;
        Mon, 27 Oct 2025 00:27:49 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e45a4csm70710965ad.108.2025.10.27.00.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 00:27:48 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v5 0/2] Implement vbus support for HD3SS3220 port controller
Date: Mon, 27 Oct 2025 12:57:39 +0530
Message-Id: <20251027072741.1050177-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA2OCBTYWx0ZWRfX0P5+wS80H3hg
 83RpqbxsEpQc4C/L7JmhN7bHiWOWg3n3eWbsfTk5TzVb6Vlac0Bs+lk2zshXwJTm7zLz5FtGo7q
 oXisiRuG4bISI800SrH8XGs/JVOrt00muAY6Ny9bPcIXtageW8URa3QPh+7lSKdCuZg1XTNl2gf
 U6xonmBx/f7StVY5zwQPL3yPdLNub6W0PYtfmhxqLNitvifeqZYgAHg26Y/qknr23p7wQDvjt3U
 FYQv7GpJPv0KrUSIZbVE+nW7QBGozOTmDvhNysVW9X9g+w0Oa3607ACGpf2is1aGUM+AKGTv9tQ
 kXTY8z6sw82SGjwjfHItIo2w86l3LNuKs5Wu+3jg7EfaedDr8sEkO+pZFOYwaPwnWQd/nAA3TmN
 w5wrEc1IzGhQOeRYScJKFz/G1S1Esg==
X-Proofpoint-ORIG-GUID: GFEB7xujBcTM6zgZjsfcY2SUilZzdffU
X-Proofpoint-GUID: GFEB7xujBcTM6zgZjsfcY2SUilZzdffU
X-Authority-Analysis: v=2.4 cv=WqMm8Nfv c=1 sm=1 tr=0 ts=68ff1ef7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gs8g10pPhjI8XjwtQ3cA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270068

As per the data sheet of HD3SS3220:

"Upon detecting a UFP device, HD3SS3220 will keep ID pin high if VBUS is
not at VSafe0V. Once VBUS is at VSafe0V, the HD3SS3220 will assert ID pin
low. This is done to enforce Type-C requirement that VBUS must be at
VSafe0V before re-enabling VBUS"

This series implements support to read ID pin state and accordingly enable
VBUS.

Changes in v5:
- Modified error handling in driver as per comments received on v4.

Link to v4:
https://lore.kernel.org/all/20251025122854.1163275-1-krishna.kurapati@oss.qualcomm.com/

Changes in v4:
- Modified logic to check for vbus supply. Directly checking first remote
  endpoint.
- Used of_regulator_get_optional instead of of_regulator_get

Link to v3:
https://lore.kernel.org/all/20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com/

Changes in v3:
- Removed vbus supply from hd3ss3220 bindings.
- Implemented getting vbus from connector node.

Link to v2:
https://lore.kernel.org/all/20251008175750.1770454-1-krishna.kurapati@oss.qualcomm.com/

Changes in v2:
- Fixed inclusion of header files appropriately.
- Modified commit text for driver patch.

Link to v1:
https://lore.kernel.org/all/20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com/

Krishna Kurapati (2):
  dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
  usb: typec: hd3ss3220: Enable VBUS based on ID pin state

 .../devicetree/bindings/usb/ti,hd3ss3220.yaml |  8 ++
 drivers/usb/typec/hd3ss3220.c                 | 74 +++++++++++++++++++
 2 files changed, 82 insertions(+)

-- 
2.34.1


