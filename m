Return-Path: <linux-kernel+bounces-795535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8F3B3F40A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1729616206D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 04:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCF52E6CB4;
	Tue,  2 Sep 2025 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tx4vpK2W"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E7A2E62B1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 04:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756788993; cv=none; b=HLOX2bWDgD/TCvCG+SDVe5GuWtD0eiTLfEsyjGHTBytUr8Lk0PNNBVa5dRwI6dRDg2/ObATLxlO3lvYWCRH/ar/LhxMXKQy3cS6DLpOeHn9VF7wqn4a3xmXrIasZV4Og4NZZu80dzOhyV793BP7xKR2j8ZmYfnx2CmIsdPE/Z/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756788993; c=relaxed/simple;
	bh=696U7/FWwaaFIGlzeZRWykn9zjUkr8pce7ma6fekJEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c9liDWJF7JB4nqSG2t2TWrVv8oNzrbF9+/AE8HjhXvgw9aPqWrmHG9GR3w0/9iB+xX/r9Hvd1t/43bW35KZKQ8DWkJgp66HBDaMriuM1XQok5+mvpXKeaqXBB7esVxDPdEGG7INLDMoTej+gK8/xT91OiORHUWcsBuA5cBmIeCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tx4vpK2W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822TUM8027881
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 04:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4C5VhC/4pFCnYsmQJ5EmNbV8HXu0TRSksgnPURzlR3I=; b=Tx4vpK2WBWhiCtNY
	sm8/FoCB0SlXn37FORfYCgOjeQemeJ+LUOOETXQnEpU3iT1gg48+xYQYmiqqEDjH
	YlLvUrEakatZJT2NVCkbY8cC1x0OY4F28Xd89XznVUJb6yGUmoebgKRG9OMfZASS
	cVB+1BG8wKyNAk8rId4bZlpUCSiZ0jW0y2HCxJgJ9tJ1cQt1nh5nlA/6noek+//f
	3lr9VfvgN2Ogih1uKI0Y40B0KWdbBNOm6OTbb+JmIJnk+7IdDbq4f7ICQkKJiXV4
	7hOBQeX0qItaRIg7VEu2hEnVwuUVNMUcXIz1lrWg3kACSeXjqt3ZCYTboFHAW90v
	G5CdVA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxjv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 04:56:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24457f59889so52414515ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 21:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756788989; x=1757393789;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C5VhC/4pFCnYsmQJ5EmNbV8HXu0TRSksgnPURzlR3I=;
        b=NE/+qxjtEsn+U7whYpZJv7lJITSgQCcXFz6iPrU6/hXLYyZfVHjXeu9niKbQc6mZPE
         h4QYaZA2Xp0FVM9QZ8IEJLEWnfgNS3XAPl5watl3pakA8KMPOAt5FJ+ZFzLZzq9ciEIZ
         wR5/Hi5e3sgbL7DPa6rfnIGw/ho/XczrJW73/Mp+rdiw6bpA63VFfsjb0KE+lBInn8nQ
         21/gnR9YfZfZwhGJNLGQD7xiCpQoR/ePiZw3FeMOmI7FsV+unxVilBir5SBA8ZILYGnb
         LMveARmpHxtgFe0rb0mjwTmYzI6Lu+BlWmwJGHFvYFeeArJG8Q6QNmNghlBF2kj3cTyo
         H4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9HLIG0/nwFkydx51MIEuZHkI4riCU6aM+bC89Gq8KA6WBaxQyVlbQexAs5uO2Hi22QvMwLzSk4AnCLgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxULpolCH9Yjre88m8rXTm0Vpl1c4/3IrjaMGG4KrIp7INfXrul
	nJOH2vmn1z2VMqbuollUgbZfGupnnqdTW1JW5Odx97fs2ubkNvDUQL7U7fymnpBKHeAKBjNwF4d
	36SUAYliR4gw3ilKk3qKDRO3LJa66Pd1eVkaDh5wNvT79FVK/4uDsNSeKmWs6Di94UA==
X-Gm-Gg: ASbGncuwghQfnTtm7OrnJ0GQqajlvNz2cQT9LxEaOvKAuNOugF9hFRN3ZabKzGt6tnK
	kIzd7oaH3mnVCQZfI+VTgZadhXPP04aByE1iCpxpMt2PwlHvBNqK0noFHLAeillLyprtSX50Fmh
	x96bl6UhS1klRoTe0q93SFNJe2oNDX7w6eXfDAjsijqNLSBE9UqkYMP50jru9BLLDE5NFxZKPJh
	VW2sPZlgP6F736mkNulguS0/cnxc6QBeKYTODBk8OK18g/lWTyjGA8lpdZ5sj0TY1L9dmialh6A
	UukJmaH45joPabU6wuFf6vQNgfGn4+/NoMZmBfDS9RnqqUU2J4iHhd/QCsDGXh7I+olRksno9we
	1teJxavZEcewfwhfjwIcmypI=
X-Received: by 2002:a17:902:d502:b0:246:fdf7:2c71 with SMTP id d9443c01a7336-24944af12e2mr132951235ad.47.1756788988626;
        Mon, 01 Sep 2025 21:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7F0eEjJmAaiuShpIkxQfExITaVHfEaEVCThMdzzbDlLzUzKrz3dCFXLdIOBLWZwLgt+OxrA==
X-Received: by 2002:a17:902:d502:b0:246:fdf7:2c71 with SMTP id d9443c01a7336-24944af12e2mr132950855ad.47.1756788988089;
        Mon, 01 Sep 2025 21:56:28 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b1f30a63asm1795345ad.66.2025.09.01.21.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 21:56:27 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Mon, 01 Sep 2025 21:55:58 -0700
Subject: [PATCH v9 11/11] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-11-a2af23f132d5@oss.qualcomm.com>
References: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
In-Reply-To: <20250901-qcom-tee-using-tee-ss-without-mem-obj-v9-0-a2af23f132d5@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX25yElSxYIY1G
 Yxt0s2q8gu17t5D3QSgiNkD+7bRyO8r+4wzJ2K3SMEC/82+P43eI52YkAqFacWjR8H20NDQENXu
 MQ2EWNNej+9Fp9rdZiigNFwLe7tAiTojXr0r801DNxg/hKHXQcfhvHAAHx/7rGjyYpJI5H3ZEwu
 zpeEHXPG0F4wzqw2kzrkx8H+DL2Z3ntA8Y46ybSH/4ZJrJRFWJcdLMHNrJOYbe8Hey1Xp1idYGa
 byXh0N4tQtnlR7mj7leH5Bx7oIo2ZeOUU8gnw4EOPvcMEdS0XHsI9iRwM1eO0N+nYCbygmMoF61
 LHPcfm0Vv1lhJw9K4+6AWq8UJqiC0ILYdouqxXlHld2G813Nth7I3Y2qKO4xuBWvVQPZl32FI4x
 pL3vxaYF
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b678fd cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: j_bxDFgtAZlaOnbQfYxkoGEZVFtC_T7t
X-Proofpoint-GUID: j_bxDFgtAZlaOnbQfYxkoGEZVFtC_T7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

Add documentation for the Qualcomm TEE driver.

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 Documentation/tee/index.rst |  1 +
 Documentation/tee/qtee.rst  | 96 +++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                 |  1 +
 3 files changed, 98 insertions(+)

diff --git a/Documentation/tee/index.rst b/Documentation/tee/index.rst
index 4be6e69d7837..62afb7ee9b52 100644
--- a/Documentation/tee/index.rst
+++ b/Documentation/tee/index.rst
@@ -11,6 +11,7 @@ TEE Subsystem
    op-tee
    amd-tee
    ts-tee
+   qtee
 
 .. only::  subproject and html
 
diff --git a/Documentation/tee/qtee.rst b/Documentation/tee/qtee.rst
new file mode 100644
index 000000000000..2fa2c1bf6384
--- /dev/null
+++ b/Documentation/tee/qtee.rst
@@ -0,0 +1,96 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================================
+QTEE (Qualcomm Trusted Execution Environment)
+=============================================
+
+The QTEE driver handles communication with Qualcomm TEE [1].
+
+The lowest level of communication with QTEE builds on the ARM SMC Calling
+Convention (SMCCC) [2], which is the foundation for QTEE's Secure Channel
+Manager (SCM) [3] used internally by the driver.
+
+In a QTEE-based system, services are represented as objects with a series of
+operations that can be called to produce results, including other objects.
+
+When an object is hosted within QTEE, executing its operations is referred
+to as "direct invocation". QTEE can also invoke objects hosted in the non-secure
+world using a method known as "callback request".
+
+The SCM provides two functions to support direct invocation and callback requests:
+
+- QCOM_SCM_SMCINVOKE_INVOKE: Used for direct invocation. It can return either
+  a result or initiate a callback request.
+- QCOM_SCM_SMCINVOKE_CB_RSP: Used to submit a response to a callback request
+  triggered by a previous direct invocation.
+
+The QTEE Transport Message [4] is stacked on top of the SCM driver functions.
+
+A message consists of two buffers shared with QTEE: inbound and outbound
+buffers. The inbound buffer is used for direct invocation, and the outbound
+buffer is used to make callback requests. This picture shows the contents of
+a QTEE transport message::
+
+                                      +---------------------+
+                                      |                     v
+    +-----------------+-------+-------+------+--------------------------+
+    | qcomtee_msg_    |object | buffer       |                          |
+    |  object_invoke  |  id   | offset, size |                          | (inbound buffer)
+    +-----------------+-------+--------------+--------------------------+
+    <---- header -----><---- arguments ------><- in/out buffer payload ->
+
+                                      +-----------+
+                                      |           v
+    +-----------------+-------+-------+------+----------------------+
+    | qcomtee_msg_    |object | buffer       |                      |
+    |  callback       |  id   | offset, size |                      | (outbound buffer)
+    +-----------------+-------+--------------+----------------------+
+
+Each buffer is started with a header and array of arguments.
+
+QTEE Transport Message supports four types of arguments:
+
+- Input Object (IO) is an object parameter to the current invocation
+  or callback request.
+- Output Object (OO) is an object parameter from the current invocation
+  or callback request.
+- Input Buffer (IB) is (offset, size) pair to the inbound or outbound region
+  to store parameter to the current invocation or callback request.
+- Output Buffer (OB) is (offset, size) pair to the inbound or outbound region
+  to store parameter from the current invocation or callback request.
+
+Picture of the relationship between the different components in the QTEE
+architecture::
+
+         User space               Kernel                     Secure world
+         ~~~~~~~~~~               ~~~~~~                     ~~~~~~~~~~~~
+   +--------+   +----------+                                +--------------+
+   | Client |   |callback  |                                | Trusted      |
+   +--------+   |server    |                                | Application  |
+      /\        +----------+                                +--------------+
+      ||  +----------+ /\                                          /\
+      ||  |callback  | ||                                          ||
+      ||  |server    | ||                                          \/
+      ||  +----------+ ||                                   +--------------+
+      ||       /\      ||                                   | TEE Internal |
+      ||       ||      ||                                   | API          |
+      \/       \/      \/   +--------+--------+             +--------------+
+   +---------------------+  | TEE    | QTEE   |             | QTEE         |
+   |   libqcomtee [5]    |  | subsys | driver |             | Trusted OS   |
+   +-------+-------------+--+----+-------+----+-------------+--------------+
+   |      Generic TEE API        |       |   QTEE MSG                      |
+   |      IOCTL (TEE_IOC_*)      |       |   SMCCC (QCOM_SCM_SMCINVOKE_*)  |
+   +-----------------------------+       +---------------------------------+
+
+References
+==========
+
+[1] https://docs.qualcomm.com/bundle/publicresource/topics/80-70015-11/qualcomm-trusted-execution-environment.html
+
+[2] http://infocenter.arm.com/help/topic/com.arm.doc.den0028a/index.html
+
+[3] drivers/firmware/qcom/qcom_scm.c
+
+[4] drivers/tee/qcomtee/qcomtee_msg.h
+
+[5] https://github.com/quic/quic-teec
diff --git a/MAINTAINERS b/MAINTAINERS
index 5086db700aeb..bac9436f65c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20984,6 +20984,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1


