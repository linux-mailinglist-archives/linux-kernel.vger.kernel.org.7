Return-Path: <linux-kernel+bounces-764075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A7B21DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8592A1682E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 05:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A682D2398;
	Tue, 12 Aug 2025 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZB6D01sr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAC626C3B7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754978152; cv=none; b=CcjqtJ0WAasD9gQ1awgjCJgQ1eAxNMfgjD4y4VDocNJYK4mukosIBdrQk/xDZlMl4xUhqT+l4mfNt3oum4PpG+f4iON3JKx9LMnQE+AfTSMu3RsdMm3wl0L9uyWqvpbWjtZNqYQwYOFnrIrCO1Xb0XjcG4O+xbLGGW5m7Ib1inQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754978152; c=relaxed/simple;
	bh=Yheg6I/35trUnbBJ7j7xz3R2vgSRMnN5w+YUila8Cio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TV43xJfVTVC2imK35ha1QJirWx7iiB2G2V+U5br4PTSBJOAwBsTlkygdHlW+lQxerG6bXOtobgviI4jTeAzAcgWZ4hKswxPxt5Db0LXBUuLAyPDQNZBd+OGjhl1kwZb0dLXCJKMu9BWTJN8dpIVtobFYbIQ+xt3fi8Yy63zKKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZB6D01sr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BK2gAJ005519
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=X8/t48amNz5Y5I/LII5CBlUVRP7E7iiuvo0
	c7s+eEcY=; b=ZB6D01srLVAiYNQdFPxS5AKmdaB3rb0ndb2HlbcJBKIEnDoOYdC
	sXfaVu6jG0vbu0q9/nAR43NFAR8+aF8Gqv3Zt3mWykn98NAgYoZNMWNTvNhXrnBG
	belTArDI5JxESrKVmmrOJNNwdcMIH7fxzW+IkhEJpSJKlblcfqsLBKMZebPUrN7D
	hnhKUAsEaj9siwcja1Qm5ECOcNAc3cw2u8uq79ml+5V1fjv81jYQFU/Y+vuDV62i
	BZP6HkroBjwsKlft1o7kkDBZmxxD8zeH/SfWoXullnxqtSZ13wES2PBXdLy2F1Qw
	Ef1wirHyGRU2eLJTGr95M4Sw0LGsZzQUEYQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6jthg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 05:55:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2400117dd80so38829455ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754978149; x=1755582949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8/t48amNz5Y5I/LII5CBlUVRP7E7iiuvo0c7s+eEcY=;
        b=cZP5AdORjpUlA9lMeNTlYe0fMY3wFXfUSPKXjp5kNQM6wqPqQU71L8FyoA9UQn+s8w
         Rx7EkEO75j/avaI7CpRptm0mBaHoK0Gxh0bhOTxU6Pygj6LXneeeJ5ULbmmpPsP53ZOJ
         UbZXN0W1Jd8ttk5XgDNlIR/Kjb9BKAZo05KPuxA21bzJ+O63xtu0yP35R6lYd/ublHSY
         Q3ZSCVa5Hkt+y3G+6UIhH5kdjt0lzz26SvqsxxY6AHoFllcQqMVNvde6VHUURpIdRN2F
         5twQdkW0BUw/4ua4laLXVTRNMt19q6q4d9WrLj3+l6cT5CdVPO8ybHxJmfTJL3O58PV+
         5zLA==
X-Forwarded-Encrypted: i=1; AJvYcCWow94RHx28acQw0o97+fs42NkRnrOMHpuOzsY7v/rJSdOWPGsgDNsbaPFWP2LlLIRTp892FldXxVmg/QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAx7RSbexRsU8cM9XfAL3uBqO9+SqgR6hceFC+8sOROeceKgY
	TtFVSfnwe6nHm9wwpQs5z/2oKsUrwJMR0+Lldu0aPI2AiV+eT0BWnsZ+CU3gGlzsb1blwmGiESs
	Qz9Pg7RbFswkid9lGuI7QmPVUfCnhrT9+IIwSDKKY9HChJLks8ZxH048rKsEivTbsseQ=
X-Gm-Gg: ASbGncs3dF5heqBITcwVPyG6PujhKdBeRWzk2fIBP4Vy+hq/IiJYHZK72HDLV3k38NM
	Z/+6ZyR81R1DqDhNnC3u81moVgsgIKq+y4IE8GRlmKDiVqgEqkWcU80kTDDGvILpI7rYg1ktCBW
	FsUM7fBB/uaOxk7oK2BDlhqUDoD24SGimsT8eDPRuLElESbU+UMEbLdcyx/2WrT2DZWtQ/TryhA
	sl1nNM9VFiXwLJ4vf+oJCEyZLyUSTyTYlBa4/2Y3jAsE7GX94Jnpd1mkzKA1nrdz/CFNn9NihlV
	BatSlQ+Vv72srzbYwNVAprXEgVnOqUkAYf9GMPF3l56CtKp+D+W40UrfLlbOo08g1VQXg9nM+Dj
	9sg==
X-Received: by 2002:a17:903:2a8b:b0:240:6fc0:342c with SMTP id d9443c01a7336-242fc29a26emr32028605ad.11.1754978149340;
        Mon, 11 Aug 2025 22:55:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlUsjaJb8koPD5Sg2TIon9Iy4UMzUrz2urZj0cwHINo1bgRLZQnc8zXMRb0Mzkr00lh7hzWw==
X-Received: by 2002:a17:903:2a8b:b0:240:6fc0:342c with SMTP id d9443c01a7336-242fc29a26emr32028265ad.11.1754978148847;
        Mon, 11 Aug 2025 22:55:48 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e585sm288585985ad.40.2025.08.11.22.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 22:55:48 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v4 0/3] usb: dwc3: Modify role-switching QC drd usb controllers
Date: Tue, 12 Aug 2025 11:25:39 +0530
Message-Id: <20250812055542.1588528-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfXy3Rvn3rsqmQ4
 3ZG8lfPiQ8bfcwPSWkCQMCpvH09Tm+CjVWVMX5JHeoV3Mqd2ci+9meMpY3BA7VvbvTd891/RFlr
 D+KwK0GtNS338kTXo8LsS6OBn7VyYs0XzhR/PQwHXVVl/VYOG3OS5SCARxuvLsVkepk/YzwQYqE
 JJI6kGabRQZQu+V1CEScmm/vgR8+lqXlaahvEIgtQJIM37QmNvg03sh7zAjJbpcU3KVE6MDx0qY
 RGB+kYyyFcY/7puImYCaEuBpswORVFfifVL4Beiec/tCG4SosPcxd6fUpRp5EEEYEXI/W03TqFx
 se6XbVbtw/SvLHufS7l7Cqo6A9QU6gpqDgjAhozfWiFrhe6vR3JeuELnfxHWbiBn7uW8U+tYw8E
 TqbCsHj0
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689ad766 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=aun3V7K2MoTQ9LCyWAoA:9 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mpINwGCWTxFaU2LHhcekuzXnoDjo3Aqi
X-Proofpoint-ORIG-GUID: mpINwGCWTxFaU2LHhcekuzXnoDjo3Aqi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

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

Tests done:
1. Enumeration in device mode:
After creating symlinks to ffs.adb and writing to UDC node, ADB is up and
working in a stable way.

2. When none is written to UDC, device enters suspend.

3. When cable is removed, cable disconnect notification comes and when
qscratch registers are cleared properly, it is generating disconnect event

4. Device enters suspend upon removing cable (host and device mode).

5. In host mode, when autosuspend is enabled from userspace for controller,
xhci, roothubs and connected peripheral, the controller
enters runtime suspend.

6. Upon removing cable in host mode, setmode brings back usb to device
mode (which is default setting), it enters suspend as cable is still
disconnected.

7. When in host mode, if we enter runtime suspend with wakeup enabled,
clicking on buttons of headset are resuming the controller.

This series has been tested on SM8450 QRD.
This series depends on removal of extcon functionality [1].

[1]: https://lore.kernel.org/all/20250729092708.3628187-1-krishna.kurapati@oss.qualcomm.com/

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


Krishna Kurapati (3):
  usb: dwc3: core: Introduce glue callbacks for flattened
    implementations
  usb: dwc3: qcom: Implement glue callbacks to facilitate runtime
    suspend
  usb: xhci: plat: Facilitate using autosuspend for xhci plat devices

 drivers/usb/dwc3/core.c      |  1 +
 drivers/usb/dwc3/core.h      | 26 ++++++++++++
 drivers/usb/dwc3/drd.c       |  1 +
 drivers/usb/dwc3/dwc3-qcom.c | 78 +++++++++++++++++++++++++++++++-----
 drivers/usb/dwc3/gadget.c    |  1 +
 drivers/usb/host/xhci-plat.c |  1 +
 6 files changed, 98 insertions(+), 10 deletions(-)

-- 
2.34.1


