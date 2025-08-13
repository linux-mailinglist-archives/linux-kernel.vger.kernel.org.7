Return-Path: <linux-kernel+bounces-765705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF706B23D1D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A29189FD7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A471487D1;
	Wed, 13 Aug 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RqPUQT0X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08EF9475
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045423; cv=none; b=OhyRHbHQdWdnIXzPxIujPXe1Bnk7l4DdXPjn8WL8owIFAsfH0QxIh8HyisYn19TtVHWLmriqR9SC5A54ygi/vojAf2XIfVb52kZTjBakp5GYZYfMkO6TuHdw9WD0MYFvZ04rSFVAE4efmUWUzkHMMwCY5ZwBCnKShy6h5a2lkzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045423; c=relaxed/simple;
	bh=QX957BjAjnoUOlhk25dVwzhchUJ1uzuC/cl5DNFswQE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HP8zGWhiEFnnHzMCbLGUopNf/2SocwBOW3JZw0u+CyCZ5vm+SSPXMiQuPa+6eMwFJDeFmgp9V5AecSMkoLjCvBaIZJ77Sjd2hNbyrMbZc7kQgOVv8II40xVYW/G+ytxxQKrqOxRWm0ZNN+x8lj7WbKB1Bl+NkBpNd3Ooejd7Rt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RqPUQT0X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CL4QeZ005890
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+at0yp1fk6YHwdPkFxkEOr
	EmiyobcZzjjc/xbyDxBjM=; b=RqPUQT0XZ4wgeUfXL/WL/qX70hsUtidKn0qOi4
	Nl5Atg7yJtBn6/MlNC4bgiQRykHD2BbfLT1lomDvvCiC8se5araZEClPG9gc2dYB
	V/CBqUJgHnUTcxPKI0eSBLlbDUPF2YYsplztiLlkLYwa7H+mUXc3/7kDtvbKKwpf
	mu+iHBrNMUMjjWYd1LvNSHqKWIFNIEOEQEm8ldHpjJI+l8gkqxb+e+n5yp49W2op
	snboGxav5oQngd6bjmdjSL4+Ex7Rr2Xx/h5AalwcYrM/nEMl80kr8B6b7c44MICt
	H7IKyZBChPp6Bp/d/qzhmz2VUgqzWWXyNJ1N6msliMr3YJPQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjnqb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b423aba05feso5643261a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045419; x=1755650219;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+at0yp1fk6YHwdPkFxkEOrEmiyobcZzjjc/xbyDxBjM=;
        b=o+nAXYLGUjtY6OCWM+RCeA54FTwt+IQSg467bVrPSITOIX7C+VaY5jR2LwwAJTAm+l
         Dw825AKqPsAqss8dKrfRW9MKEiMHziZzi0ctbBwjLlN84pQBI4DHY3O23jkADgdDjQsB
         IfAzwifxJOEFlaGKfe4Urdcz2roos1FJSWAUc2EK8M1SPsTxRZcurIXpbVZpzoPlYo0N
         ERJtwEOeyn5i3qBEuGoQybNS/XvdYg5ZlIccGC+aOAkF/11UBfuFMZPW6E0YPSX9K4ex
         J7mUN0UNF6dKtdY/Xuiepdd+fdzJLZOZh1+JDFkQuOGkc7SZeecpwyjDSuNBe8/JNt49
         spKQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4NJo3ST8KMo6ayTtEo0l4SSsIfTuMz7ByRmFuva60U8nZo8ZHmT2FG+KtRd0OlL3+YuMOTNt4EzKt4x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLAa3OK4Jbomi7lj9rmRIUMgyzEtTQn4A5OgpWzcMtjbz58QR
	zmA91w0uk7G3EcXVPvTJKz/8MWvknc6Q2qnS64r3/ks9lxE3TK67aWF7meT0vWwwHI2wib38X8e
	lVCLfhpYR2XncgNuTR1W703n2sWxycug+ye25FCp2rIDVsJ8V0vUzUPy7be6U68ckcg==
X-Gm-Gg: ASbGnctS36/cNvFG0Ld+SoZDQc2GKrhkPZR6+L6q54rUL/LGwxf5qKo85evSMF3QBdS
	ymwAFEP9KI5axRp0VLKqedVFbL3rLEBTCXKDZ+nr/Xv0Sc0XM4rWJquWLpsFm1bvJYGo5CCLDwr
	RR5rqE+PJi/eDQ9HFSNuvHkGRCTg+qzA665IiNAUTVmSHiLKEoGQrGUTv84kMqx5fDNNjVBJ6an
	0YraGYdireMHcOLrwGmF8TryYENLFrZOn+0lVD7KIIAWzyKu37A+vex+RHKsH2fwNPr192aXC7r
	CfH9smheyoEo+2mO63YI5bSxnAYpxGi9tPTXUZ+tzehfRlRIt+y+jDads50IiqwI2xNh9zyx7XP
	sWV2hxdHepUQeJ/oyKSc9cd8=
X-Received: by 2002:a17:903:240c:b0:240:1bdc:afc3 with SMTP id d9443c01a7336-2430d2193damr14893645ad.44.1755045419282;
        Tue, 12 Aug 2025 17:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJS7eo4tDELeKFQF7o6fGP93S3xH2lApW5s+v+ChcpJiGLSDQ318ZWJrTWyyix9r5Xna8Tmw==
X-Received: by 2002:a17:903:240c:b0:240:1bdc:afc3 with SMTP id d9443c01a7336-2430d2193damr14893355ad.44.1755045418773;
        Tue, 12 Aug 2025 17:36:58 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:36:58 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Subject: [PATCH v7 00/11] Trusted Execution Environment (TEE) driver for
 Qualcomm TEE (QTEE)
Date: Tue, 12 Aug 2025 17:35:29 -0700
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANLdm2gC/5XRTW6DMBAF4KtEXteRPf5Lsso9qi7AjIOrggsG2
 iri7h2QKhZtJLqx/CzP9yz5zjL2ETO7HO6sxynmmFoK7unAfF20N+SxosxAgJa08M6nhg+IfMy
 xva27nPlHHOo0DrzBhqfylSsL3lqlhQHHyHrvMcTPtef5hXId85D6r7V2ksvpfxsmyQUPRgAGI
 VFIe+3G6GPrjzTOlo4Jfly6td8FcuHssPCVqJQOv121uQrcXleR64I2TjgFJ6iuKedjNxZvNN5
 suN5wDae9uCbcFlIrq0VhffkANxtuwO7FDeH0OagAZCnK8wPcbriTai9ul5efXShdpaVX9g98n
 udvwFg1NKgCAAA=
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
        Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfX0uXMEx8xkuTj
 qf8aaEhONPTuy/lKsgz0oDiZxAVctzRrLByGW1VzTyw/HphNNeC9tbhnqbkEwzPgH8JFAtwt0bv
 Y82dgn8jLItxUVQeEtDb+GQtJGsgppk8JB3oKGLH2gkKmSLmZRmXQftZ1cQUVhCV6ap1Df0kAu4
 l1jCdLCkFhPKXKF7OqgUZF6wev4X+omfv8Zn67yLDLl6ZDj/PYJP7lhc3Ld9G1w3gjok/RxRFNs
 YUebJQHZKBlgZfy2DlfR2Aysz13EzJ6sVRnNOWbwO0H+1ip1MmbqV39xv3gnDk9iktZzIOyTtwk
 AgBsy+fcH8bNAVhiijFb69zbv5WOAPgpHomAL28ZJQe9JgJITzrpY1hZEwGhUHisGrFlCIgsGkG
 OrNgUjAV
X-Proofpoint-GUID: sJ7gQE2_t18V7miIEKx0oULNZ5rTUZZ8
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689bde2c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=-DpCeiEA-uxMJwXcxG8A:9
 a=YJIRHeAgBRZYVZEh:21 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: sJ7gQE2_t18V7miIEKx0oULNZ5rTUZZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

This patch series introduces a Trusted Execution Environment (TEE)
driver for Qualcomm TEE (QTEE). QTEE enables Trusted Applications (TAs)
and services to run securely. It uses an object-based interface, where
each service is an object with sets of operations. Clients can invoke
these operations on objects, which can generate results, including other
objects. For example, an object can load a TA and return another object
that represents the loaded TA, allowing access to its services.

Kernel and userspace services are also available to QTEE through a
similar approach. QTEE makes callback requests that are converted into
object invocations. These objects can represent services within the
kernel or userspace process.

Note: This patch series focuses on QTEE objects and userspace services.

Linux already provides a TEE subsystem, which is described in [1]. The
tee subsystem provides a generic ioctl interface, TEE_IOC_INVOKE, which
can be used by userspace to talk to a TEE backend driver. We extend the
Linux TEE subsystem to understand object parameters and an ioctl call so
client can invoke objects in QTEE:

  - TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF_*
  - TEE_IOC_OBJECT_INVOKE

The existing ioctl calls TEE_IOC_SUPPL_RECV and TEE_IOC_SUPPL_SEND are
used for invoking services in the userspace process by QTEE.

The TEE backend driver uses the QTEE Transport Message to communicate
with QTEE. Interactions through the object INVOKE interface are
translated into QTEE messages. Likewise, object invocations from QTEE
for userspace objects are converted into SEND/RECV ioctl calls to
supplicants.

The details of QTEE Transport Message to communicate with QTEE is
available in [PATCH 12/12] Documentation: tee: Add Qualcomm TEE driver.

You can run basic tests with following steps:
git clone https://github.com/quic/quic-teec.git
cd quic-teec
mkdir build
cmake .. -DCMAKE_TOOLCHAIN_FILE=CMakeToolchain.txt -DBUILD_UNITTEST=ON

https://github.com/quic/quic-teec/blob/main/README.md lists dependencies
needed to build the above.

More comprehensive tests are availabe at
https://github.com/qualcomm/minkipc.

root@qcom-armv8a:~# qtee_supplicant &
root@qcom-armv8a:~# qtee_supplicant: process entry PPID = 378
Total listener services to start = 4
Opening CRequestTABuffer_open
Path /data/
register_service ::Opening CRegisterTABufCBO_UID
Calling TAbufCBO Register
QTEE_SUPPLICANT RUNNING
 
root@qcom-armv8a:~# smcinvoke_client -c /data 1
Run callback obj test...
Load /data/tzecotestapp.mbn, size 52192, buf 0x1e44ba0.
System Time: 2024-02-27 17:26:31
PASSED - Callback tests with Buffer inputs.
PASSED - Callback tests with Remote and Callback object inputs.
PASSED - Callback tests with Memory Object inputs.
TEST PASSED!
root@qcom-armv8a:~#
root@qcom-armv8a:~# smcinvoke_client -m /data 1
Run memory obj test...
Load /data/tzecotestapp.mbn, size 52192, buf 0x26cafba0.
System Time: 2024-02-27 17:26:39
PASSED - Single Memory Object access Test.
PASSED - Two Memory Object access Test.
TEST PASSED!

This series has been tested for QTEE object invocations, including
loading a TA, requesting services from the TA, memory sharing, and
handling callback requests to a supplicant.

Tested platforms: sm8650-mtp, sm8550-qrd, sm8650-qrd, sm8650-hdk

[1] https://www.kernel.org/doc/Documentation/tee.txt

Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>

Changes in v7:
- Updated copyrights.
- Updated Acked-by: tags.
- Fixed kernel bot errors.
- Link to v6:
  https://lore.kernel.org/r/20250713-qcom-tee-using-tee-ss-without-mem-obj-v6-0-697fb7d41c36@oss.qualcomm.com

Changes in v6:
- Relocate QTEE version into the driver's main service structure.
- Simplfies qcomtee_objref_to_arg() and qcomtee_objref_from_arg().
- Enhanced the return logic of qcomtee_object_do_invoke_internal().
- Improve comments and remove redundant checks.
- Improve helpers in qcomtee_msh.h to use GENMASK() and FIELD_GET().
- updated Tested-by:, Acked-by:, and Reviewed-by: tags
- Link to v5:
  https://lore.kernel.org/r/20250526-qcom-tee-using-tee-ss-without-mem-obj-v5-0-024e3221b0b9@oss.qualcomm.com

Changes in v5:
- Remove references to kernel services and public APIs.
- Support auto detection for failing devices (e.g., RB1, RB4).
- Add helpers for obtaining client environment and service objects.
- Query the QTEE version and print it.
- Move remaining static variables, including the object table, to struct
  qcomtee.
- Update TEE_MAX_ARG_SIZE to 4096.
- Add a dependancy to QCOM_TZMEM_MODE_SHMBRIDGE in Kconfig
- Reorganize code by removing release.c and qcom_scm.c.
- Add more error messages and improve comments.
- updated Tested-by:, Acked-by:, and Reviewed-by: tags
- Link to v4: https://lore.kernel.org/r/20250428-qcom-tee-using-tee-ss-without-mem-obj-v4-0-6a143640a6cb@oss.qualcomm.com

Changes in v4:
- Move teedev_ctx_get/put and tee_device_get/put to tee_core.h.
- Rename object to id in struct tee_ioctl_object_invoke_arg.
- Replace spinlock with mutex for qtee_objects_idr.
- Move qcomtee_object_get to qcomtee_user/memobj_param_to_object.
- More code cleanup following the comments.
- Cleanup documentations.
- Update MAINTAINERS file.
- Link to v3: https://lore.kernel.org/r/20250327-qcom-tee-using-tee-ss-without-mem-obj-v3-0-7f457073282d@oss.qualcomm.com

Changes in v3:
- Export shm_bridge create/delete APIs.
- Enable support for QTEE memory objects.
- Update the memory management code to use the TEE subsystem for all
  allocations using the pool.
- Move all driver states into the driver's main service struct.
- Add more documentations.
- Link to v2: https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-0-297eacd0d34f@quicinc.com

Changes in v2:
- Clean up commit messages and comments.
- Use better names such as ubuf instead of membuf or QCOMTEE prefix
  instead of QCOM_TEE, or names that are more consistent with other
  TEE-backend drivers such as qcomtee_context_data instead of
  qcom_tee_context.
- Drop the DTS patch and instantiate the device from the scm driver.
- Use a single structure for all driver's internal states.
- Drop srcu primitives and use the existing mutex for synchronization
  between the supplicant and QTEE.
- Directly use tee_context to track the lifetime of qcomtee_context_data.
- Add close_context() to be called when the user closes the tee_context.
- Link to v1: https://lore.kernel.org/r/20241202-qcom-tee-using-tee-ss-without-mem-obj-v1-0-f502ef01e016@quicinc.com

Changes in v1:
- It is a complete rewrite to utilize the TEE subsystem.
- Link to RFC: https://lore.kernel.org/all/20240702-qcom-tee-object-and-ioctls-v1-0-633c3ddf57ee@quicinc.com

---
Amirreza Zarrabi (11):
      tee: allow a driver to allocate a tee_device without a pool
      tee: add close_context to TEE driver operation
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_UBUF
      tee: add TEE_IOCTL_PARAM_ATTR_TYPE_OBJREF
      tee: increase TEE_MAX_ARG_SIZE to 4096
      firmware: qcom: scm: add support for object invocation
      firmware: qcom: tzmem: export shm_bridge create/delete
      tee: add Qualcomm TEE driver
      qcomtee: add primordial object
      qcomtee: enable TEE_IOC_SHM_ALLOC ioctl
      Documentation: tee: Add Qualcomm TEE driver

 Documentation/tee/index.rst              |   1 +
 Documentation/tee/qtee.rst               |  96 ++++
 MAINTAINERS                              |   7 +
 drivers/firmware/qcom/qcom_scm.c         | 128 +++++
 drivers/firmware/qcom/qcom_scm.h         |   7 +
 drivers/firmware/qcom/qcom_tzmem.c       |  63 ++-
 drivers/tee/Kconfig                      |   1 +
 drivers/tee/Makefile                     |   1 +
 drivers/tee/qcomtee/Kconfig              |  11 +
 drivers/tee/qcomtee/Makefile             |   9 +
 drivers/tee/qcomtee/async.c              | 183 ++++++
 drivers/tee/qcomtee/call.c               | 820 +++++++++++++++++++++++++++
 drivers/tee/qcomtee/core.c               | 920 +++++++++++++++++++++++++++++++
 drivers/tee/qcomtee/mem_obj.c            | 169 ++++++
 drivers/tee/qcomtee/primordial_obj.c     | 116 ++++
 drivers/tee/qcomtee/qcomtee.h            | 185 +++++++
 drivers/tee/qcomtee/qcomtee_msg.h        | 300 ++++++++++
 drivers/tee/qcomtee/qcomtee_object.h     | 316 +++++++++++
 drivers/tee/qcomtee/shm.c                | 150 +++++
 drivers/tee/qcomtee/user_obj.c           | 692 +++++++++++++++++++++++
 drivers/tee/tee_core.c                   | 127 ++++-
 drivers/tee/tee_private.h                |   6 -
 include/linux/firmware/qcom/qcom_scm.h   |   6 +
 include/linux/firmware/qcom/qcom_tzmem.h |  15 +
 include/linux/tee_core.h                 |  54 +-
 include/linux/tee_drv.h                  |  12 +
 include/uapi/linux/tee.h                 |  56 +-
 27 files changed, 4423 insertions(+), 28 deletions(-)
---
base-commit: 2674d1eadaa2fd3a918dfcdb6d0bb49efe8a8bb9
change-id: 20241202-qcom-tee-using-tee-ss-without-mem-obj-362c66340527

Best regards,
-- 
Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>


