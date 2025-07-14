Return-Path: <linux-kernel+bounces-729259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B878B033F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 02:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DB03BAF50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 00:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211E212B18;
	Mon, 14 Jul 2025 00:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hx3SdW3j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1517208994
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752454242; cv=none; b=pKv+9xTiOy93TDoE3dU/7K5GFIae/MthXt8VM9xLaYkok+4NBBnkHuOyYADn47W+WLp67HtVk3OPoy4qmEhSgIXS6rk0EnUDxQneYEiCCn93O77VLQXbxhPKTjpHFjVnbA2Sou9WiuL67sMF3Zi8zAWFAswP/GP1zeEP5Bij8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752454242; c=relaxed/simple;
	bh=oUzmLIFl9vCPfoPNulUuSOSohYJa56PJu1YTll4mynw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kO418o1v8ZGSYo/NwxelF+JlrDa1oGSWO5Tdj7SrvHnEIgzMb0yj1hgMR0qMDCokvhIdWr77fCX+DQJEJ6ZaX8jdzAqh5mUERwisQis6MWNXOm1U8yqkIHEODbwkpEizWUE4zYZxnp7cCTacPdfHewFLxcSiVRgpnt7Eiklepjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hx3SdW3j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DNQUUK012297
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ytumVm0CoQT2UiSI9m4EbOedIWBaTexPn7wx5CCAvew=; b=Hx3SdW3jIaJ2J6kn
	qs34+ISXzB3q/nhpt/OvBf9CeFhOdrG2AZUhj3X8IoS0GfUUlyUMahWMRQrX+sou
	hIeoJidq+je9jw0pm6kQOk7ZFcIJc/Pu6ZZf9qcHDtOTvYPDnX0hhZdJgOl3GMzf
	VX08q7RaIU/r3t1MkjjYeal6yc+Q1FxW9UyAjNGQDIszdAbEo3Nq3kn25L5fSVd1
	i66kzfI5GADoeLojAyGk/x5EB5plrIvxoC73rWwidbVSMcoYbwdvs7zEkGFtKhw8
	OV4OtQmkP2lJ85t/w+Z8A0R4NVeHbWoHhzGf3lHjdlNuSZVH2qmtz1cYPur9nhHt
	2xGUZw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufuejw04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 00:50:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31366819969so3755742a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 17:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752454239; x=1753059039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytumVm0CoQT2UiSI9m4EbOedIWBaTexPn7wx5CCAvew=;
        b=Y00wpGANUlwnsvXd/MWjcxWBuccd6aWCd18HdymK9gONfTlr8khGVHvjaDV1esl2Ik
         f885FA+u/eaiJMsg07qAahLR+OaCQZg+txYKcuMrkNw+rFsg+4JZj7/KPhK2lU2OyrjX
         j1A/Lv4yFgCgNPvqDyHWIQOhAnN+CMffZk/kPAoAiDY0CgUmCA7tQ9GB3HcRPyS6dMlp
         7yuj/5DVNPXCnffV7uhM7pYZ0AEZayh8NV87TS4JVXKnpx5ireTlEKNNg4fXzFkJiquK
         NQhedEMDrSbQ0esddt7d1M3R07iSYaAA/yIhT7KXsHz2rEAA3o0/wttsVot9pisHZBi7
         zCDg==
X-Forwarded-Encrypted: i=1; AJvYcCU6FooBeEfLgcg9TAhGjYqO44jzYDE76S7HtuRtFc0AEMgfkFQWvMyeMpa2CzjIXLjdjgCAoXZghWSX9m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIFQQnF5y78uGUvVZ3dzZCu8XGdHX3/ESyvBtRbGJkOA1azzhs
	i09V9CO1Du4H2OCvMvaEsipFAYsuig2NhxUekPJF0RFPD4ncoXNyFdKXeolVcXvsQelTF1mEcvz
	0gucKN7k8HEKuR5omJjCQdssldc28N70RBU50OWn+eshOsIDeZJB3xyeCXNV9jgXvDQ==
X-Gm-Gg: ASbGncuHMW6p7k9A2hXlkl4Beru6rFR2l8YDrVH/BRjYFNxp6j5NSrIbk+L31U3eRVx
	/qFUr4v7pxOGU81CNn3gae8/cX4C5m29qwpJwwRp1CahVPJIgXDNm9W4bk+zi6EjtV6wDZUmzcD
	trZ++yTSqKdu45FoxyW8upwjO1pvdxdObFbax+lxCt+GIfqFBB6Xie+bvjQp+uAANgV/Jc44MtK
	nOwjgoVvE2QiA7x22sMFiuXngZw3yu0cTkb5elwsC1UVYO0/FAnbATbE70X6ty1zPG8LbQueK3B
	vG+PyYTXlDIwzXlxSzRXsLiYHYGbfpNxZNS7J8nuRX3YPLii36qgNLzM6R/N6Nh+FOxIxr9GhwQ
	YMMjkqOc1EvEa9KHZjSHUbnU=
X-Received: by 2002:a17:90b:5804:b0:311:b005:93d4 with SMTP id 98e67ed59e1d1-31c50e2c50dmr15386685a91.25.1752454239099;
        Sun, 13 Jul 2025 17:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3jGL0eHjBRDOFcNGYXTZVoUK2+ayeWgQN5DlcGBALaaf5nl7YCP7GQ2hWPGEb1tdZhuWi8g==
X-Received: by 2002:a17:90b:5804:b0:311:b005:93d4 with SMTP id 98e67ed59e1d1-31c50e2c50dmr15386649a91.25.1752454238650;
        Sun, 13 Jul 2025 17:50:38 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de428473fsm87562605ad.13.2025.07.13.17.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 17:50:37 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Sun, 13 Jul 2025 17:49:24 -0700
Subject: [PATCH v6 12/12] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-12-697fb7d41c36@oss.qualcomm.com>
References: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
In-Reply-To: <20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com>
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
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-ORIG-GUID: QiOYOytp8HUBAa7iaYZMD6rGhHPcEVvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAwMiBTYWx0ZWRfX5rovleiFvdrU
 VlQbRWE40ATPjCinEuCG7tyDgAIldFR78peK/4u228bPWZqb5WOY6FIFZOVLGdQdhdJygTsYKnG
 J8IbcfAVJF2sdIse5UjlLA845bTSJv25IUSRplc5QzZABWX0tmii6qpTkI05B4OPpeFSUtEol1l
 cFqErsTZ59SS/OMxGA0yUGr4vrhYsSfUVVyidRfEG3OWgUcxG/vmdNfojFFoTRZ9uQb44LZoJNM
 AB/6xbFqLQuULE4Y1OMrj0oFhdlalnsAcuwnPEVpdr9rS9u1cM5lcJcHZZv1+bJ1XkrdJllXf5q
 vdYx77P+VAhEvXtYtXjSQc1g3UWEbwT8QkoO0/8avRgzQkERNy2Op2YBfd/kr82wbrNhEMyW7aY
 5KUSLB9VBFUezqt2wmjyQRR44NtpnVWllzx8Akvg1MkPGs+m3l86RFNsMOupu+iPdWa7O+RC
X-Proofpoint-GUID: QiOYOytp8HUBAa7iaYZMD6rGhHPcEVvl
X-Authority-Analysis: v=2.4 cv=TL9FS0la c=1 sm=1 tr=0 ts=68745460 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140002

Add documentation for the Qualcomm TEE driver.

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
index 9fc58f48fa14..391fc6e6defc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20706,6 +20706,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1


