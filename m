Return-Path: <linux-kernel+bounces-757585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092CBB1C3E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F03A3DEE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39E228A1D2;
	Wed,  6 Aug 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CvccFYj8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B7A2066DE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474321; cv=none; b=D/ekZHQ2Qrv8kKkm7VYo6eUzBoO2RBGMlf37iPQ1XWLJVN6l/RRXhqK9R0LCpXTpfbpruHNFH4/1l8sH9PRm/J/cHtxO9/d85auHj90hOzjltTyC347++Cee8rRsVRMJQygwWMkyj7VBRlJiw1k3V99SbSSLml9/v1vXx2ac7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474321; c=relaxed/simple;
	bh=5MlaPY5JqsVfBvRmIGu781N70UBVX55YyNAVfYDOhI0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h1yrGyR4eyFbJzT8GpEUuHqDKZOHH6k/JL/CqNbvKbwd1WbT23juEyzesQbXTu4MgIzI7sqcI3G8GyOBSLToJ2a/PUCB+XaRNxxO2Pl0wHgVqtoogiVTw842rXDVFe8iyMotYDioxaRvMv5fC2VqrK7Dls9BU5oYMrO2A0N3uhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CvccFYj8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766PUKm030920
	for <linux-kernel@vger.kernel.org>; Wed, 6 Aug 2025 09:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=mlyhGJrF296leOPuzvZ4VKCmY7SZH+3Eg9W
	zVsRykuw=; b=CvccFYj8nN19TLmiPdwEeqqJSyp3ucqOio4a2j80fePnrb1DU2I
	T0Cr2ABG13HASpqWwVRSPiXrFWAhIcfGlbBozIiodmMUgOY9cd/U0mjYZjP+MJna
	fHzyh+KHcle7g6bG5beiDK+DtWNCdtrxVyPKdIHjTgobCGjjFgwk9LUerNuR3vBo
	6e7Gp2Kj3tf/kLYvuvwpZrhX1jTPGyexF95t8RhA/hgiZwSiiXPTJYMJdWa8R0dR
	pPiQybVb5oZUrDTO1GH3o1CWIjnu7LNI8Owmx8XsgFD5Y8GdOXS62BD3iP8C+n7K
	WDbIDbNvQoZpZjKIQ+Y84iq7i+UIf7cKBfA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpyct7ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 09:58:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b3510c0cfc7so4705725a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474318; x=1755079118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlyhGJrF296leOPuzvZ4VKCmY7SZH+3Eg9WzVsRykuw=;
        b=k9FxDeIt7VM2jZUczAleQQOTnclEUYdD6gb5StYnfgHs/4fBnmMxCw5TkxAgvUHRAc
         Nf7pNRj/oN9MH4a8wBTE0smqbY84aUxI2guzHj8kXnNz+mJlgrI1upxyFC9U3TZRCyT3
         /ZNXm33IKXyRYIcHSX/BoJMQ5IiXYCZR/Esa0FI+Qx60+vVv85SbMM5xronXv1f7lIhe
         k28cIn6ZWdGx0jgW0nTu0Kjcq3VFjXbnaaLkfq5zu+vSKnvukHy6cgnbLHG2EHVovvFk
         YbuccLfNb7NlzOCMfBfxM/0bDjrrZex/VZQkty03ivs546djl72Buz6iSikgu2eqtpFw
         bWBg==
X-Forwarded-Encrypted: i=1; AJvYcCXG88eEfTI0VApLH5U3jj+weIfdr/g3sHCn5vIDvfe4YTuIL/6ezyahZ7SaAbebvAaoFZ1NknKnC1PpQlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrRC5pYuxjloU76oHQv37Kt1py+O/wz4gFYqpmSXVJZfMQsQ4i
	SSGFRAExlHK9JjDEWf8zMdDmCjxNGueQRKkLwc7gwK0wJDqRDRgMNIlHEuEnQQJVBmT21/FCZg2
	XYaJE5+oKCcJ3O1/3hSyBrHHOSjVjKr08ExYC2xqz1e0mePWA8pmfc4CxqttlbzSMqaU=
X-Gm-Gg: ASbGncsGFGDT7HodI+pql3OC/SpBLMRPzAqdJYa8WtJYyb6m4hK7hTyW1ymoa6zt6ba
	NVrJsNl2dPS6R01g0aMKCRbPw7pRiMDtUEjEHrr+QUE6oZShK4YEaQzveCU0eHvqSBHgNynX/xV
	vJ4N098u5WT4Tag00hlkKbBN9/rAGkV6vIAbpV9Loe4smHgAmipXVsjCqgJIUmsNUqd0lYv1U0W
	/jX/auotnVQWmGILM8T+3qLO+gc8eDS7jwxsnNVlBK1X2E2xV4Ev8P4iCw0CclWBcZkeLLLGafk
	X0mEdn1tPf27WYue5nMyJyNc8MdlQKAZXsVlU0mPJP+vsFTLzbOADRigRuNMZt03OjU8sC73Js3
	xSQ==
X-Received: by 2002:a05:6a20:3946:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-24031407438mr4100061637.29.1754474317814;
        Wed, 06 Aug 2025 02:58:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo8WUOevOV47Ap+Hsn78w2zaNclD09lWJ9LmarRGiBAcTJtDBqyBfYCadWJS0noTJ+lEKAnw==
X-Received: by 2002:a05:6a20:3946:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-24031407438mr4100031637.29.1754474317411;
        Wed, 06 Aug 2025 02:58:37 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bb0c0sm12908799a12.20.2025.08.06.02.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 02:58:37 -0700 (PDT)
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
Subject: [PATCH v3 0/3] usb: dwc3: Modify role-switching QC drd usb controllers
Date: Wed,  6 Aug 2025 15:28:25 +0530
Message-Id: <20250806095828.1582917-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 30yv-Pm0RLLT5Gb4saJGZqqYzfBtlUvi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOCBTYWx0ZWRfX81HzzlI6BI63
 jX438Wgc8cnAzgsff+Ege3dFWriYq5KypIIKr3PvnC8L3g0B6OZuwrXXcOApW/ISAQhJoxke6g3
 EnSt0hM/XmV5GM0keVfsjADx5xgkE703+HMOr9R0QeeFsaPihXxbXV20NjiMvOZGESZK2o9drpc
 8gkHE4TCfHqVEVZHVhBsGWUOJtJlFxuI6r9j5Ba9F9jLvGtV7CLetsSYBlJQ8uaeQj9jn36lj79
 LCQdRvqipJNBvSApTHWb/w0DhP/xYf4UHuWkF0ie+7qapKjQ2mdqwAoKRPKo4D7V3AaQBIhe30s
 buO7/dSCUh7N8ZeKOIHZJQcaAirsUpBHLN756HpaTQx1lojfmDURC6KMsQ/1bsGwCvALG76F5Tt
 VXZ9M2xC
X-Authority-Analysis: v=2.4 cv=JIo7s9Kb c=1 sm=1 tr=0 ts=6893274e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=8q3CujG2C9GLMZ2tu0UA:9 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 30yv-Pm0RLLT5Gb4saJGZqqYzfBtlUvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_02,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508060008

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
This series depends on removal of extcon functionality first [1].

[1]: https://lore.kernel.org/all/20250729092708.3628187-1-krishna.kurapati@oss.qualcomm.com/

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
 drivers/usb/dwc3/dwc3-qcom.c | 80 +++++++++++++++++++++++++++++++-----
 drivers/usb/dwc3/gadget.c    |  1 +
 drivers/usb/host/xhci-plat.c |  1 +
 6 files changed, 100 insertions(+), 10 deletions(-)

-- 
2.34.1


