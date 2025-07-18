Return-Path: <linux-kernel+bounces-736547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2528CB09E59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A663B1D34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD937293C5D;
	Fri, 18 Jul 2025 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OPzPpa7X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624F1FECB0;
	Fri, 18 Jul 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828722; cv=none; b=tP80LMXMpRr/7LJDj2cAOATcNCNA+GM2lRJRlx1aWm4imgpxdHME+6ts7Qjvsz/EVyzBthSAPBJWR2wITw4aTjmvcgCh3RekDtJleiqmHLXvxkC/aNCk9XzepC+2ft7znb8+a10tsecJKJ1U4xK6dlv6UAO3D7D5PBF/iZEO1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828722; c=relaxed/simple;
	bh=+jqEHhXno7Zpndq7I+vRk1NaRpqQfy8nak/b3qYDcAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dbhpzeX+Fqe4n/Ms6k2eZF1KTZWNAoLPYgIvv9zI4Sh2dUr5Yg1b/kTRr6Ck20wdzhpIzMrhw3vGQ+hwl6Da7uZuex+XrjUzimROtrKJDP+0tT6ftcNfCt9Iy8iAzDMtwrZdFVgg/HWDDqdFczJaasdFALhniKO2poUSQRe67fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OPzPpa7X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I64mVT022220;
	Fri, 18 Jul 2025 08:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2gfUuQo+Mi7tnnr8c7hryY
	G5lSkkAwC3ADHdjy2cJ1I=; b=OPzPpa7XcyuCGeSJOPeozjZGq5Fy6yP98r9Ooa
	o4Avd9ltvSgx1FZXat6HsfJwlqggZ6IDHDV4QFELcENeRtEkSOTXF0ZWRkRQ9TBO
	F5z+zF4c4gzfuofXhPOC4j4IRIQiSw2NFAzLz07xTw5WGqaY3BL1DuEyC3DbxKGp
	6x5I5ACUN44NTc/9GV38maNmFL83MxvsXyxSCTyFR0y7yPy490Wu98VZzQPPhhi0
	vXylI029iX9jNb54pXOCpsqmgBEC9d3h7zZ/brcx7Px+Ds1lvpyhP7kWxjxIW4XB
	remtqyf8ginnQzszzxb2+4Fn0e6zYPQLkGNZuWKPARuZyH9A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsyatch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:51:53 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56I8pq4l031690
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 08:51:52 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 18 Jul 2025 01:51:48 -0700
From: Akash Kumar <quic_akakum@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, Jack Pham
	<quic_jackp@quicinc.com>,
        <kernel@oss.qualcomm.com>, Wesley Cheng
	<quic_wcheng@quicinc.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Daniel Scally
	<dan.scally@ideasonboard.com>
CC: Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Akash Kumar <quic_akakum@quicinc.com>
Subject: [PATCH v2] usb: gadget: uvc: Initialize frame-based format color matching descriptor
Date: Fri, 18 Jul 2025 14:21:38 +0530
Message-ID: <20250718085138.1118788-1-quic_akakum@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2OSBTYWx0ZWRfX8/rxJX8qNrhb
 0x2Mow3k/oA6FHFxeJemte5dAj3cghhqClFhcYKAOgLC9Io6C1UmfKbQ05fKlMgwSooKfHDqpQ+
 6CMwQqAH7QqomvcJf4R/gfL+bzS9KC+KwLBNmtgnboDqpvIGTZnSHWjDdf4gizBExELt4CurlZr
 FpNHxp7i+VD0Y5q98b7eJ0W1g58ZmLYwDXygvoUIsoA84838isVwNtaMEJjlVepBe6Ij9LkKcQ/
 2a9k8YuC7Hsy4hIRwxkvLkpBh1b1oCeVBUog5TCJCZgX9ZkIvbMxtlx4pj0Zws7bEvsbKE9z0XX
 LH8WbhD4Gu/0fzfnHtzVFio9P/zNxjve6dE0V/yEyAQPUi/bBmGMUxID7vSCPWoDnb5H9usfYpf
 NkFoP0YmYGW+GzXq85uwDNs50OO6RMo/5P37+dR0Fqy0W1TEg6ZD7F+O1HR28y4vnw4B5xU0
X-Proofpoint-GUID: c-PUQCcWS60uPWv3coCvhkSn7TtquqZ9
X-Proofpoint-ORIG-GUID: c-PUQCcWS60uPWv3coCvhkSn7TtquqZ9
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=687a0b29 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=tGrIPOYPKiXRmnHdYUQA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=713 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180069

Fix NULL pointer crash in uvcg_framebased_make due to uninitialized color
matching descriptor for frame-based format which was added in
commit f5e7bdd34aca ("usb: gadget: uvc: Allow creating new color matching
descriptors") that added handling for uncompressed and mjpeg format.

Crash is seen when userspace configuration (via configfs) does not
explicitly define the color matching descriptor. If color_matching is not
found, config_group_find_item() returns NULL. The code then jumps to
out_put_cm, where it calls config_item_put(color_matching);. If
color_matching is NULL, this will dereference a null pointer, leading to a
crash.

[    2.746440] Unable to handle kernel NULL pointer dereference at virtual address 000000000000008c
[    2.756273] Mem abort info:
[    2.760080]   ESR = 0x0000000096000005
[    2.764872]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.771068]   SET = 0, FnV = 0
[    2.771069]   EA = 0, S1PTW = 0
[    2.771070]   FSC = 0x05: level 1 translation fault
[    2.771071] Data abort info:
[    2.771072]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[    2.771073]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    2.771074]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    2.771075] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000a3e59000
[    2.771077] [000000000000008c] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[    2.771081] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[    2.771084] Dumping ftrace buffer:
[    2.771085]    (ftrace buffer empty)
[    2.771138] CPU: 7 PID: 486 Comm: ln Tainted: G        W   E      6.6.58-android15
[    2.771139] Hardware name: Qualcomm Technologies, Inc. SunP QRD HDK (DT)
[    2.771140] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    2.771141] pc : __uvcg_fill_strm+0x198/0x2cc
[    2.771145] lr : __uvcg_iter_strm_cls+0xc8/0x17c
[    2.771146] sp : ffffffc08140bbb0
[    2.771146] x29: ffffffc08140bbb0 x28: ffffff803bc81380 x27: ffffff8023bbd250
[    2.771147] x26: ffffff8023bbd250 x25: ffffff803c361348 x24: ffffff803d8e6768
[    2.771148] x23: 0000000000000004 x22: 0000000000000003 x21: ffffffc08140bc48
[    2.771149] x20: 0000000000000000 x19: ffffffc08140bc48 x18: ffffffe9f8cf4a00
[    2.771150] x17: 000000001bf64ec3 x16: 000000001bf64ec3 x15: ffffff8023bbd250
[    2.771151] x14: 000000000000000f x13: 004c4b40000f4240 x12: 000a2c2a00051615
[    2.771152] x11: 000000000000004f x10: ffffffe9f76b40ec x9 : ffffffe9f7e389d0
[    2.771153] x8 : ffffff803d0d31ce x7 : 000f4240000a2c2a x6 : 0005161500028b0a
[    2.771154] x5 : ffffff803d0d31ce x4 : 0000000000000003 x3 : 0000000000000000
[    2.771155] x2 : ffffffc08140bc50 x1 : ffffffc08140bc48 x0 : 0000000000000000
[    2.771156] Call trace:
[    2.771157]  __uvcg_fill_strm+0x198/0x2cc
[    2.771157]  __uvcg_iter_strm_cls+0xc8/0x17c
[    2.771158]  uvcg_streaming_class_allow_link+0x240/0x290
[    2.771159]  configfs_symlink+0x1f8/0x630
[    2.771161]  vfs_symlink+0x114/0x1a0
[    2.771163]  do_symlinkat+0x94/0x28c
[    2.771164]  __arm64_sys_symlinkat+0x54/0x70
[    2.771164]  invoke_syscall+0x58/0x114
[    2.771166]  el0_svc_common+0x80/0xe0
[    2.771168]  do_el0_svc+0x1c/0x28
[    2.771169]  el0_svc+0x3c/0x70
[    2.771172]  el0t_64_sync_handler+0x68/0xbc
[    2.771173]  el0t_64_sync+0x1a8/0x1ac

Initialize color matching descriptor for frame-based format to prevent
NULL pointer crash by mirroring the handling done for uncompressed and
mjpeg formats.

Fixes: 7b5a58952fc3 ("usb: gadget: uvc: configfs: Add frame-based frame format support")
Link: https://lore.kernel.org/all/20240927152138.31416-1-quic_akakum@quicinc.com/
Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
Changes in v2:
Add misisng crash structure, added commit ID Fixes.

Link to v1:
https://lore.kernel.org/all/20250625101639.19788-1-quic_akakum@quicinc.com/
---
 drivers/usb/gadget/function/uvc_configfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index f131943254a4..a4a2d3dcb0d6 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2916,8 +2916,15 @@ static struct config_group *uvcg_framebased_make(struct config_group *group,
 		'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00,
 		0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71
 	};
+	struct uvcg_color_matching *color_match;
+	struct config_item *streaming;
 	struct uvcg_framebased *h;
 
+	streaming = group->cg_item.ci_parent;
+	color_match = uvcg_format_get_default_color_match(streaming);
+	if (!color_match)
+		return ERR_PTR(-EINVAL);
+
 	h = kzalloc(sizeof(*h), GFP_KERNEL);
 	if (!h)
 		return ERR_PTR(-ENOMEM);
@@ -2936,6 +2943,9 @@ static struct config_group *uvcg_framebased_make(struct config_group *group,
 
 	INIT_LIST_HEAD(&h->fmt.frames);
 	h->fmt.type = UVCG_FRAMEBASED;
+
+	h->fmt.color_matching = color_match;
+	color_match->refcnt++;
 	config_group_init_type_name(&h->fmt.group, name,
 				    &uvcg_framebased_type);
 
-- 
2.34.1


