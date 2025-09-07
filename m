Return-Path: <linux-kernel+bounces-804765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30369B47CBF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D454E17DE95
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BD329ACC6;
	Sun,  7 Sep 2025 18:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GauMgnjW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A2C1F5433
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757268864; cv=none; b=CUilXKr6YKpCb419AWY5iawAIlG1cVzPzLTpebJ84upUvnzWBhbJWlMISb1jghuVqvs3nJeSa2c7dzMdfAda2QVE4avQE8QZubKX2ZefDo4MsCEDizNFyETEzt2S2VaovNau9JAc8wCcyOwKwI5a+HqzjKhihEiNsaoTrwA2ISc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757268864; c=relaxed/simple;
	bh=11/dD3dDcCOc9MsrcPqs0qbvB/s/is+nEp2ZS7rQWfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jd7toX9RpJGjsor4FUlmjdchQ8/HmGqipXgaT8wWXeBUOsoSGZTmF3bfKMX5wsHTlRYbHpfyZryzAMySOQNdvhRVC3MvKF7LhqT61e9hyx8eoiMV0scb8OR+u/+WPF6bLL6qiw7hP8zd6hbxct7d112QRy8OsbU9kbkSG0ZNv7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GauMgnjW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587HcaJx023169
	for <linux-kernel@vger.kernel.org>; Sun, 7 Sep 2025 18:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8UMw1xCRpkP/WZEjhmDx4M+05aTIY2seDc4
	onliaA1Q=; b=GauMgnjWWmWyWiEVqykL95sY8fp/QrekbaishAfietoABQa71rd
	Ye8/dvIx1shaN+x+qgEDoHu9asL2eRtcll0IdHK31RrsgolL83UxLDvyPMjQxb4N
	Agz9JBgeuPQI1UAezcND1jteut2FFLn0lw0CWTIwhZlBcw+MxW1cHd/UkQXGFcnn
	uj69uRGMRDg1uIfA1tfxOSKUrIHZCiAkPjJ4pHH3BPmhmebWt9FlJGiWIFym4BdF
	V71wJo0Z4Xz66PpU1js1UabAD41bx5haK6zDXVC+yYjjBU7gh2kUGl0xVuIvp+Fu
	6RwHjGWXE5z9ISc8BUo38aYzOa9hWu3CAJg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8ads3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 18:14:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24457ef983fso78854395ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 11:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757268859; x=1757873659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UMw1xCRpkP/WZEjhmDx4M+05aTIY2seDc4onliaA1Q=;
        b=BjDJIhZdWxCVKysYfXAW1EaRz5OjzYNU4y0KYUbLQr6YQOSTkMwCjqZ/K/Yoe5aMp7
         U+8uLB5zPp4RHdE0sM+cw4LqVUAdfwXVUcKWKZn+HcLo+oMLCcZ1YympMRz02rENMkvK
         axtD0au0liBmvC18ZI1McBENCXJcd0cb5pMoYD81FLsiiinqDa2THkFh8gsyX1b+D1y7
         Px8Rb3BIq/Zbw7lDsVYA2ML5cbfXkB/kxE8TPdj3XzXH3Zwhbf7y0M80Npps+n7rtV6o
         3+HS5wAPmAnYeTKO90pWB+r1dileBNZ2gtCyglsh2tKW9sa0AVS8vOMJbTjz2VGJPJO5
         iFxA==
X-Forwarded-Encrypted: i=1; AJvYcCWTYndwL4+66UEEacc/4HKmUgQ7+N++/+3pU1BT8UOI/8K8Vpsu/wxP6UJHKUth0lyA7IfY59jv1g48iCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGePXmkVgUVbhNwpuEazS9dSzanY7vJR9wAiCCM2Wemo88des
	3+XXIR/Pc+fda6G6TvJrT4EfOdZKDPCaU7v7LoGWGSRI5a7uli5F8G+z8jB12H6n2hB01yH4ZsB
	CT93PboYPdyxeypL5G4ZHNUnJ414DcOiF2G/rTz1ZywYjqmDB8mPsdVovsoOqa42dUkOoOKPIvP
	Q=
X-Gm-Gg: ASbGnct6WqOgsgNTIOZeYU+djuqB3dGdC6Z91ym7mSEmRS1qvosF2gtiq7bH/f3K5k9
	gtdqx3d9cqaWsuH8+7e9g1twRUAKbu3kri5Tg7MGt871lDEmL/dSzwouM6gSAk3O0MyZ6q7fXi5
	oulsybOzWE8a+1pBghcTa/BPggsd3LQafXPW6Gghd7S3F/K1vhxnfziK7lNMEX9XkIdFxroGFVJ
	5CGaqOONn4lLYNlpGy+gU33J5XDufpWRbEpVurm7joNO261AmGfCDbnVWE6LIj/Z4E4RESKP9Un
	tRhjdVrE8CGYnZgUl1jAuWbN4r3DEFLZ26HbQAivuojiPmbvTIa8KozOKw3PQLmVSke9zKKZC4R
	LaQ==
X-Received: by 2002:a17:902:ebca:b0:24b:15b3:223d with SMTP id d9443c01a7336-2516e4afbb7mr77564455ad.16.1757268859240;
        Sun, 07 Sep 2025 11:14:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+UNmMjk66/DHR5BZpjwkre26K4bock2ih9UrjjrcOP8jRkmrHlvdcCEFIq8xuAbsJqi3xg==
X-Received: by 2002:a17:902:ebca:b0:24b:15b3:223d with SMTP id d9443c01a7336-2516e4afbb7mr77564175ad.16.1757268858705;
        Sun, 07 Sep 2025 11:14:18 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cde5b6484sm84074765ad.19.2025.09.07.11.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 11:14:18 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        konrad.dybcio@oss.qualcomm.com,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v5 0/2] usb: dwc3: Modify role-switching QC drd usb controllers
Date: Sun,  7 Sep 2025 23:44:10 +0530
Message-Id: <20250907181412.2174616-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX1eJkITpLrGQ0
 IjVdUv4ypVdk2CWQzOWr3fYXOEftnm5wgFmSyPiSAxo18wN9RBbQVpqbyBbGPZecd5FHpGdeO8g
 YPf7ni+H4cdT+H+I8224DeexHysEepvBxJi/o2rCYNdAmtB2SvOWsqp5zTwHzcrH8Y1p8atK2Rk
 kS1yU5sJyNEFn08nMxza3+T+yw2iKrxheFmpuU3XZkE6O9NGU+c5KaEIHEmSTJx2VTR9Rm6pGmD
 k24EnTmWV2J41T8jqU2N0AAgNCM7jN4Z9PLB5/9kwfdyLsanxvGSMs2M1R95kH53p60jl55BawM
 RhU5ppOM2SH//OLBDFNLE4frenfAlfPM/+IY5QWZK6BNSzsbmFsfJmhbrfzRycsuO8z0YpQoLaH
 KpKw0wmP
X-Proofpoint-ORIG-GUID: I22wqwMsP_-Oe2V-n8UZk6RED0EqOgN6
X-Proofpoint-GUID: I22wqwMsP_-Oe2V-n8UZk6RED0EqOgN6
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bdcb7c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=aun3V7K2MoTQ9LCyWAoA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

Currently on QC targets, the conndone/disconnect events in device mode are
generated by controller when software writes to QSCRATCH registers in qcom
glue layer rather than the vbus line being routed to dwc3 core IP for it
to recognize and generate these events. We need to set UTMI_OTG_VBUS_VALID
bit of QSCRATCH_HS_PHY_CTRL register to generate a connection done event
and clear it to generate a disconnect event during cable removal or mode
switch is done

When the disconnect is not generated upon cable removal, the "connected"
flag of dwc3 is left marked as "true" and it blocks suspend routines and
for that to happen upon cable removal, the cable disconnect notification
from usb_role_switch to DWC3 core driver needs to reach DWC3 Qualcomm glue
driver for it generate the event.

Currently, the way DWC3 core and Qualcomm glue driver is designed, there
is no mechanism through which the DWC3 core can notify the Qualcomm glue
layer of any role changes which it receives from usb_role_switch. To
register these glue callbacks at probe time, for enabling core to notify
glue layer, the legacy Qualcomm driver has no way to find out when the
child driver probe was successful since it does not check for the same
during of_platform_populate.

For flattened implementation of the glue driver, register callbacks for
core to invoke and notify glue layer of role switch notifications.

Set-Role and Run_stop notifier callbacks have been added to inform glue
of changes in role and any modifications UDC might be performing on the
controller. These callbacks allow us to modify qscratch accordingly and
generate disconnect/connect events to facilitate suspend entry and proper
enumeration.

The series only allows autosuspend to be used but still relies on user
enabling it from userspace (echo auto > a600000.usb/power/control).

Functionality checked:
1. Enumeration in device mode:
After creating symlinks to ffs.adb and writing to UDC node, ADB is up and
working in a stable way.

2. When none is written to UDC, device enters suspend.

3. When cable is removed, cable disconnect notification comes and when
qscratch registers are cleared properly, it is generating disconnect event

4. Device enters suspend upon removing cable (host and device mode).

This series has been tested on SM8450 QRD.
The previous version [1] had one extra patch to enable autosuspend for
host mode, but it is removed in this version. The two patches in this
version are independent of the third patch. Since the third patch has
review pending, sending the ACKed first two patches in v5 to get them
merged.

[1]: https://lore.kernel.org/all/20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com/

This series applies cleanly on top of usb-next and usb-testing branches.

Changes in v5:
Removed autosuspend functionality for host mode. Will send it separately.

Link to v4: https://lore.kernel.org/all/20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com/

Changes in v4:
Fixed function names in comments in core.h (Thinh).
Fixed nitpicks in dwc3-qcom mentioned by Konrad.

Link to v3:
https://lore.kernel.org/all/20250806095828.1582917-1-krishna.kurapati@oss.qualcomm.com/

Changes in v3:
Removal of extcon functionality has been moved out of this series.
Addressed coding style comments from Thinh.
Instead of adding notifier and enabling autosuspend for xhci, it has been
done in xhci-plat.c

Link to v2:
https://lore.kernel.org/all/20250610091357.2983085-1-krishna.kurapati@oss.qualcomm.com/

Changes in v2:
Rebased on top of usb-next.
Removed glue's extcon handling and made use of in-core handling.

Link to v1:
https://lore.kernel.org/all/20231017131851.8299-1-quic_kriskura@quicinc.com/

Krishna Kurapati (2):
  usb: dwc3: core: Introduce glue callbacks for flattened
    implementations
  usb: dwc3: qcom: Implement glue callbacks to facilitate runtime
    suspend

 drivers/usb/dwc3/core.c      |  1 +
 drivers/usb/dwc3/core.h      | 26 ++++++++++++
 drivers/usb/dwc3/drd.c       |  1 +
 drivers/usb/dwc3/dwc3-qcom.c | 78 +++++++++++++++++++++++++++++++-----
 drivers/usb/dwc3/gadget.c    |  1 +
 5 files changed, 97 insertions(+), 10 deletions(-)

-- 
2.34.1


