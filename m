Return-Path: <linux-kernel+bounces-813173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE26B54191
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742513A0515
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FDE26E6F8;
	Fri, 12 Sep 2025 04:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="maeNwf1F"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E022874F2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757650090; cv=none; b=OIDEzBt01tGwmU1hEGm1HGgIIRorgJOoOBvXP4d3SGwssSnTnFinB2fu6uZnv3buFCT7ls4DZZOLSGq/BwePoePpe1zFbL9+vgYjaq6Jg5e7QO4f9nN/ZsZ9D5Rgh8oDqDFdDciXiYFsKmLgx1+vSKDegFQhOZccxACK4xOFjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757650090; c=relaxed/simple;
	bh=RN0nKuxToKAQ9VOhyNYte58FvHuKeDhMEOShy3rUoJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvKmJwQ0br1Q6F6z9Q7BDzouY8EfUTUM6l1b67ZXmLhwCHU7jgu2l1pWMl6mekbLzYcs7y5dcFVlBh80ofWkWOjNbVCCWt1bFiRi/K2lGTVzdquluSmxM7GxdKZ3hKeqj31KW4Bhxjxz4wT5jXNl5GSaG3xmGMXwdT7Ab9UHRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=maeNwf1F; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BIcwYB006035
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OdVTKF925ssMm3cQuiq+O1uNYUiJEhXOdcH2WTZnulA=; b=maeNwf1F+KqV/B09
	GtrNuOj9VsKp8/indOeA/tp7PIqvqOgB0XvIZkZuKnJuhuNhhlGT5xrlUKumPPQl
	61EhqbLE+O1bLU9K5pnTBp6DbhJDAED/bC60gnvEziBinzmbIwRKKI5LU5XarMsK
	TUe7d4dFy3/E8mpnP2AalvLD6ydWhv8Us+JIynxCqLvio5Q2uDhWUpDA1bU1ClJZ
	28oAOHl+c+ZVszJ1NyyO7VGIyzBJ9en7iGiKecFwV+GucH90LBa9Q3KpVIgEM+xt
	2NYl8E8evrO2QsEN3BYZfSUHfBlghVFHIcJUKPHpRtq8SAind5kJTqIvteNzd4NN
	/KKN8g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8aj49g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:08:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-323766e64d5so2206479a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757650086; x=1758254886;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdVTKF925ssMm3cQuiq+O1uNYUiJEhXOdcH2WTZnulA=;
        b=K3OBwMhckumfzZt8XnxFcFT/krVochhenfBws9JVShvkNHJKoBEVaHQcMHIb2poln+
         4npGdMas/Acwu53+XVw6KDzQkkwp6tcBNcv9EqAVtXx243yor4BCDh/e8SQK10d4kS4j
         V957R5fUv59WTL+VTkoQNaoo+AeAuWwqx1Cf7+UoYtrve6lk9vyOXMvY+4v6IgFmk2hd
         cHO31LF3h9DLSJz1cG/k1jvb4kSUzw4xNzxi/cCm4106/nmUgSy1X+R9+e6JBAhDdWm7
         0w2wNVK5tjOsEKDscn8NzeQ7Qgw5VlZZFHy0yT7gZN6KvqbOqThM3NTwHYB5PRgzGFZ5
         ufBw==
X-Forwarded-Encrypted: i=1; AJvYcCXfyiN0vu0ZKK7ycwb5f4Plgkb+2oUyla2aVVz8pM6joM+VupT/QoWt/DLoD8kSIS8ROHz6LhxU80buVSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRX0MO5QBzzdfUFidXJAelCytYcv4gYP6LPI2tWf5DYfujx5NZ
	1eV8d93REdqJunKmehiCRM8VQ7TQu01AWwZERi84Z2/fIY92yg6YWSpRomm5Dj7fkUmvZB0Od/e
	akKlicwl3AGudWaBWBrulfuqJub05Kq951RsJqpauy+KF+f/JeYEsFtmUhdz5fvIcIQ==
X-Gm-Gg: ASbGnctTnOEh50k4A0EhTB0/IzugXWHBvtNLxsdlgF7QvTZn/3jHKsBDknoaNyAR+KI
	cWMtNn0gD/PLJAMka9P3wrwbcxzs1lleWGbfAmgCfgAsM52XID+clCyddTmW+6tGjjE4Kzdo3ew
	bk5pwEBmif+J/nSLHaf3pdjZncCQuKgryXnJqLubI4feOMl6YAPEAq6yAl8SBNJWTaWaPOvqbTI
	jxcjLsuFaX29U8/lis9QSlmbSY2YwIWxxcXtFDp0oGHw7bFA1HDQERPLGKtwoWEk+fICGVaCZs6
	TMlHRv79BRLdgxddGCXqFB3u/hYdMQH+CnrU11a5Zwiww63hBXnoMH21VF5PSqIV3p7aOqE9XaO
	WJav/wU8udXE9Zqs+0RXJjvM=
X-Received: by 2002:a17:90b:35c3:b0:325:25fb:9128 with SMTP id 98e67ed59e1d1-32de4c33d52mr1818632a91.9.1757650085539;
        Thu, 11 Sep 2025 21:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX1RaQl33ilIfwxao3aJgpnfFU7FLqmjTzLfuny6Mj/xGDe+7OnVCAMTCzx6nAXfuI73Atcg==
X-Received: by 2002:a17:90b:35c3:b0:325:25fb:9128 with SMTP id 98e67ed59e1d1-32de4c33d52mr1818571a91.9.1757650085067;
        Thu, 11 Sep 2025 21:08:05 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ad5e168fsm690960a12.13.2025.09.11.21.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 21:08:04 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 21:07:50 -0700
Subject: [PATCH v12 11/11] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-11-17f07a942b8d@oss.qualcomm.com>
References: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
In-Reply-To: <20250911-qcom-tee-using-tee-ss-without-mem-obj-v12-0-17f07a942b8d@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c39ca6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 72yuloVXn_y0WZvY9eAnHoXYZX0ucM5-
X-Proofpoint-ORIG-GUID: 72yuloVXn_y0WZvY9eAnHoXYZX0ucM5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX/w/0hMtskBVx
 JIABSJVUwnvneQLUdE0CwB9o/cl88BXI6gGq9HTb32pwAxxPeX7OVy7AtHMvX1TSCZvPUAiUUk5
 HihSqIq4Ln7XFMvmCe8TXl/rR5bKUoGbY+VixQNug2r0GuTZtjVJQPtb4hZp1xw5iTCwQo+Z2zw
 e7HEShCfQESMkTwd+VhuRuYPpjK8LmGGH/JDW2kuF248FdxvPm3o3nDMiVqVG66ZJQdk3uDilIZ
 b3iOMzd/cfkqXGunK8UwFVtbUpJFXkRjoIwZ+KhGDgh7Fwa/PIJ3VknagL1TjwcFu/p8fRrq3nk
 t7k7/5m8z+1nBiKk/60K27kPasbcOeOVxJICjGMhFrwgPFpVlunpTEy42zZ/h6sM2IBxncFiWDz
 0i60Cwn+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

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
index bde449308736..589f8ea62bcf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20860,6 +20860,7 @@ QUALCOMM TEE (QCOMTEE) DRIVER
 M:	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	Documentation/tee/qtee.rst
 F:	drivers/tee/qcomtee/
 
 QUALCOMM TRUST ZONE MEMORY ALLOCATOR

-- 
2.34.1


