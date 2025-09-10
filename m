Return-Path: <linux-kernel+bounces-809189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 905F1B509D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 02:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452557A8AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 00:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13F1D9A5D;
	Wed, 10 Sep 2025 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+XGAoiS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773471F428F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757463102; cv=none; b=u6mR0tRb/ANrbZdNZRFiHUjbDsHS9XnOQ7Begqbo/AzoZmICu+Xx/fGa9VITBvqYpxSlV50dDIfJeVx12x5135gIEV39Zgr/LtlQ0unsrngeWF0RrXI22SLYcEi1BXXqzqP5szyHX8cQrlYNuFVYMRtlizohcE3xUPwVSwIptZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757463102; c=relaxed/simple;
	bh=696U7/FWwaaFIGlzeZRWykn9zjUkr8pce7ma6fekJEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pGVyo75gwY5hKd8fH+QiPqOgaOBRsSnsMCSz0PXGOWtdLOeKvGhtORlWU4FsMHs8RwnG8VbdR0Ku+fTNLD2ZPuZez1qfoVQJUjyamUzJUQfey/fllNgEpUa8l6sdGECFkM2hEOT+724TXVsrJcwyB6JEaryh9LsY25AODjBO0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I+XGAoiS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589HQs0B001029
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4C5VhC/4pFCnYsmQJ5EmNbV8HXu0TRSksgnPURzlR3I=; b=I+XGAoiSsp98TQ5x
	6e41NhkRmZ6L5Kid75CcmVKFH9YO7mxf/7QjQ6Z7AYipA+hINDWTRIigDW2guaUT
	TtSi0Rop725hS7g0+80aIzm5HF2sLYvIOdJSr+EJz690Wyf+p/65yGgXm42N0XZK
	DN2I4MKDUxQugIw77lqLYw/b2k+9uKo2M1bEEIAZJwdvoF94JVFuFSn5IKTxxu22
	PaRxo9J7SDEa4DRe9AHR9Vzrd2ZPYbLcl20a5vb8ncbU2W10oTuEdn5iOzu5quC3
	TaoIRVh+tawxZq2JLVqXf+6KQ8dXW8lXXdXjYEd3py/b5hgV88wWltWEN1AOA6Zq
	LGYeFQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m1wae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 00:11:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-329dfdc23d2so5670273a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 17:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757463098; x=1758067898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4C5VhC/4pFCnYsmQJ5EmNbV8HXu0TRSksgnPURzlR3I=;
        b=jl5ccg32yAHJUDPXwSXq0k2JCvKMjNFRUQ3udHMIo1kNIWM+kMIXtpWbwFTcf37kgI
         1UgBRkh89ZBqeIIuP74Swbzcv4JC/IKlrygD1P562XjNclVUC2dQt6+tdLzQiv8uB7iz
         fdA9nJQBl6aYuxLzqTVz7Z2sm+XCNK7MhhuWWCmmOU2wjFbBOGzhNEjlfbpjpGIbhJ+p
         qLAxm00TB9mti0ZLduvBxZ/ovD/tfNvp8qVsfvi8ScF08KzpIVE4N1QtbRTO6+lOMCP7
         f01dV7bFTTBr+T2XlqG6JPSLjNIDVFCybo0sN9QHHWIIlIe3nM87ZYticn24hL2kk35J
         TF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUl70M6GnwbKFVIppTbqTftWqrehpT8Dx+mt0ME2Bzw1r7aWzu0xd0tpD0SrYmY4lI/jcrH9QCszIVmSi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLeOUJGxQOq5+VSN7rJDUq7s3LYkwqjGiA14hV+fG6Nlx2SpUZ
	wDDfobqiseDFmLlzo6BbeZ7lU5PPL9wxLmpekq2yE7jmSZxDeXQuEcB/sL3Vz/8/e/CsosGWhUk
	XPhvQTG1PPrj+XF+yq4QTPhyKLfF4HPl7sMUG5C2sL9uGJhiEeol12x3eCNRRIHN6Rw==
X-Gm-Gg: ASbGncuLqKHrYurWumEVQfSgAAdu0zBBuNxDr+XlGeanh6Wwbv2FBtr0A5BC+D8KEZY
	Z+5nwlcW4ji0kIIXGFUyF/mKmwUPEcJ3SEWZG/Hlq80lRAqVtB2brXFUwYVHMghGK/ak0Q1ewR/
	7elZSXQuIrtUZPaXnDWExmzLrOWqouNpTeLrs9m0Xpfe6Ci8pLxqTLBUNMPFRdqADHQIVd6TJIW
	vknDgjOPmI1bz/ckLDqA2X82DikrZ+GL0aUU6NITnVEDOrMnJCBlFui4jjMz+Z0zCrbKQnPM9kg
	s6lqWpvC3wGxaqyHc2C1X6HuYkwnfOm+9EgmmgEpzPkwNwKEPNArxO8iJvsVggv0uS0Yax+XpCx
	uoK+S8HY8SmlC0WtUHiu97O4=
X-Received: by 2002:a17:90b:3e83:b0:32b:dfd4:95c9 with SMTP id 98e67ed59e1d1-32d43f65178mr18315518a91.23.1757463097221;
        Tue, 09 Sep 2025 17:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpzGJa3zoFNB42rtvfjajYvfcc9erQFUhwdKHNTg2RVQc2elCXFRJ+X/Uvoa7tYLTxRWAgEw==
X-Received: by 2002:a17:90b:3e83:b0:32b:dfd4:95c9 with SMTP id 98e67ed59e1d1-32d43f65178mr18315479a91.23.1757463096596;
        Tue, 09 Sep 2025 17:11:36 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dab6bb655sm1285672a91.10.2025.09.09.17.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 17:11:35 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 17:11:13 -0700
Subject: [PATCH v10 11/11] Documentation: tee: Add Qualcomm TEE driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-11-20b17855ef31@oss.qualcomm.com>
References: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
In-Reply-To: <20250909-qcom-tee-using-tee-ss-without-mem-obj-v10-0-20b17855ef31@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX5n9HmhrJFK47
 OiTX0DN/yvm+Nv0kTXgKS1rNZgr1i/jC9YFb3lHFkDvPQneOIXe2s+ZNCbp1iC9qqxjT6wtRF5f
 o4Lm+/POJAt6lStyIbxh1Drz7xsZfTtAqH6mSg+Jp2CPYilnnB4wWsn+Mi147dnj/7ZmjFk1lkE
 E9eINQN0UrYUeIClinDl7cNpjXs+KymaqwRbRfu4ixqL4l96YTSRYEcd/j+ozS7B0eA/UXbrxh3
 z/80mmWtEDTB6ijFPwSNVjOZLT+ggSI18wYiTHcw/R+wGBKMTTGaEq3qtKlPqXvB5Ay6ae3ZNXt
 8AzN2nRDuFK1H5p+DYN3VoGXqf+eY3ePxXZqyBR+zL2ndwNSuvRsi8MnZzhrSEt0a8hprt0BRnG
 Hx5XcqAZ
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c0c23a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=vCTlBN6rBY5pDr9NrAkA:9 a=QEXdDO2ut3YA:10
 a=M0EVDjxxv-UA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: i38atp1tPxuiv3j4HFytjBGUxAM4K7vb
X-Proofpoint-ORIG-GUID: i38atp1tPxuiv3j4HFytjBGUxAM4K7vb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

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


