Return-Path: <linux-kernel+bounces-875157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E14C18535
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 06:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2184C1C64204
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542962ECD3E;
	Wed, 29 Oct 2025 05:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q/AS/BE4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ilZN3j94"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615042F619F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761716678; cv=none; b=WtWBA8oIp+Sdr1k5Sx2XGTBI6XjN9ufl1/jFqWwePLKhiMvUQoU+yNk7W0bZZX0pKXBF8Jj51zJ0sA0gyBJMWOMgNbceFi3PLAiW0L0OWLfGv82oJXE1/xflI4VFGT3PRVaBev+S2m/lGxNIPs/R+Xp9cr05fn1xDEFE2WGz+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761716678; c=relaxed/simple;
	bh=F0W5k3SvzOe2pljFMvhAaWmKlZxvDKSkyBzST1T5kfw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T7xMljZVdMqEhMxzcSo4jC1CpyWBy00zkfGl5MsRHBVZKONihQ9KemkxGK58vFlO032QMJKkRmfHp49206dxmD+wIuQ3S0Ovqi0BRqSXwH+9RR6JUKalsUwbkpah6K4ieR2dly3qOpBtXSAEALth7aXHioCZHSTibPwm4GUVB0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q/AS/BE4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ilZN3j94; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v3wL3755359
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LC3GMcFuvDtY3XJr35Uc7e
	Y+sExnlTPbLnkdhHO9Mdg=; b=Q/AS/BE4AlEFAuGOBZfT2ZaGNoCEoqt0U8Z8Xd
	MtZ7G9x+9JoKXw9oOm3hnxau2tl4nb4bstc64n/NoTO606lswJWYxYZOvBcVIwrj
	Ikl0Zgq15twGejhfkIVnO7uFe80DLH1LByHLVmsdkymRJtbqPudnpgBqK6nJWKv4
	J/tMaFlGzWTVELu9WGuzRCJXatvVYr6esqKcDsFL8QLlHV2bqUFQdXEGmH8wePbK
	72nKf8k4cAImKxUv4F8OuSm6kVVKtxT1qdR/9Eb+uutnminsc0qUchbwEN0dHNJ/
	mrMmh3z0kqB+i+00DQBm+bEO9Rop1GVO+rGOcGVMhRs5V4cQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a0hafc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:44:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-277f0ea6fbaso80657255ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 22:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761716674; x=1762321474; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LC3GMcFuvDtY3XJr35Uc7eY+sExnlTPbLnkdhHO9Mdg=;
        b=ilZN3j94xnwuZqraVZVgaXvpt+HyZb5iU9JSzwp432HzuhL1ExPL6aQhgCDNYAy4JW
         iEKJ+xC5o5paYQYEjl3IA7nFsp08aGpSox8jtXdVu0DLh/RUYlEckivI4dJqIBEZACum
         khqjK4R8R6DOZyNjWWD/7qIQfAAptVVMZjcxL1tW4mty09Klv2wGCkaCFBv+7IjYc79f
         TpyHgaff3Z8ME9ZK+XBUUNQ4FlivHIwuN4ZZZk+th/jEUI9j+x1pt6NfGmWWLt/3S090
         NFX3TH28DuCuX/aMOC/DCGfeAub1r8WQY7TY5pJ4kPOaGAEAMs6gGPz59grCSUxnwjVc
         9f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761716674; x=1762321474;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LC3GMcFuvDtY3XJr35Uc7eY+sExnlTPbLnkdhHO9Mdg=;
        b=ecJlM6OubLOzBZajzG1Xuq3Y+X7pzz+eXJ3HnC/Io5rh5rHV0lStFJtQ1rUFIeH8QQ
         mzNkl43tK5JwRZB6eiWzdKmMqPVbOmZHmcp9xQxok/iLkvBQzS3y95qAsLW4MmH2gYj+
         17sI+gBlThPgqoHuIj8UimfFXYfIllah440QoPl+1c+FCfyU2dckVdgMZOE1oD+9vckI
         wf2SvXTuBZTh72ckjOY7QmWnFnIwGVicgCF6u6iVn6/3bxPBKER2GQGDm1UYxZ/4iea/
         wY/fQWq5yeljIJlwW2uPCSFhKLzMtL99EHQWjn2qIPGO2nDfM1ywnzTe8Nuj1xiGYpz2
         ENzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN0104Z6K+kUWyh6DdUIcMRMbgA2JBPFMwcdH4kVVXP5fMK/3Uhi0Q9MaMS09fQVGyo0WTuSPaLStS8HE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5oEdRRart6QAydyDwYQFSUUCD/Fgz2nfQWedcAMvjnHoDRdmk
	VsslzkmvHWjtxbOShqpuJ4C+2sPTyxo7Mts8nBJrm8qkWwwT5e8OTwcg7EP6ArqFvxAiYrAIhuu
	q00iLTKZi24QEj3IvbAtGMSLaW+mTwsW+PdznxiMuF2V3l+/mKi6/+sC/eaq38KTCqjc=
X-Gm-Gg: ASbGnctBxI12lXdl1842trjzBgwlEqS29c2zK+q2h7kpINiYuHz4E6C5tZfH3NrdPM/
	sk5UIlTbEUa7VkJ/18p/HA5YXCE8hVWTFMoTDSf1pW/KpSigXgvADTrkZ5m44wm3elyPoYe/wSC
	5+dQsPUGWGiKADU5VqkRCuhIcJbMk4v8OEoic/nQXgZ38FaBJ55M39L+4GEyO/1RqiZPf9Edqtb
	IVLpXNrwShXIw2LdpvTVz4fTkdBtp4aJnawA8fmURcFQm1Iaup4q3ckuZgV7WZtp2n6GE3YSpOk
	50nodVzCb6n6uUkfYb086fQtgBcbAMSLq748DuIuA01oI+zNnYvoIiGr5NsJxj/I2DtyViXHSg6
	b9m0Mg1Rmc77iaf8ZU1pdc6sJl+uR0hXcroj9UpbJ7Ya6syO0AQA0/Q==
X-Received: by 2002:a17:902:ccc9:b0:27d:339c:4b0 with SMTP id d9443c01a7336-294deea9531mr21189285ad.35.1761716674202;
        Tue, 28 Oct 2025 22:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwIT/+Uxh78/COAQ0RUyc4JxApOhZCBiPwjnlxdxjlDaZnqWNHQph4VHfmOmFbB2rlTLvPFA==
X-Received: by 2002:a17:902:ccc9:b0:27d:339c:4b0 with SMTP id d9443c01a7336-294deea9531mr21188975ad.35.1761716673694;
        Tue, 28 Oct 2025 22:44:33 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7d1fdesm14280643a91.5.2025.10.28.22.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 22:44:33 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Subject: [PATCH v4 0/6] media: qcom: camss: Add Kaanapali support
Date: Tue, 28 Oct 2025 22:44:09 -0700
Message-Id: <20251028-add-support-for-camss-on-kaanapali-v4-0-7eb484c89585@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmpAWkC/42RwW7DIAxAf6XKeZ6AJE3T0/5j2sGAWVETSIFkn
 ab9+5y22nrYpB0A2TLP8PxRZUqecrXffFSJFp99DBw0D5vKHDC8EnjLcaWEaqUQO0BrIc/TFFM
 BFxMYHHOGGOCIGHDCwQO1emu1bZXoqWLQlMj586XJ8wvHB59LTO+Xnotcsxe86FUDxzCtSFgkC
 NCdsltLhKJtnmLOj6cZBxPH8ZG3akUt6vu6FLL5z+sWxWTXdk2rUVnn+j/I9R1Z1f8i10wWCrX
 pUYpOu1/In1cfiU4zuy5XKT+q95vbVxTMmWDEZCKUCJZCLFwwIpfp2TlKEOZR82E0GdFJvWvq7
 Z513k/uDre+P9AbmCGaI/gAi1v5xRx8eIWBRwKqdVpS3e1M0/9FUpIvHQlM9tPhHXLBMmdOmRS
 BFyuZBiwsaIS27oU1Uu2Q6IbTyJ9aZfiy3wQ6c8/L4GXHZj6/AN75hRONAgAA
X-Change-ID: 20251008-add-support-for-camss-on-kaanapali-e5b6dbd5209e
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=HvZ72kTS c=1 sm=1 tr=0 ts=6901a9c3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=AVJvM5lMoBLg5W3HYfAA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 3yWquTOyQUKp1E2gDkekLNJPa-ZJYr9V
X-Proofpoint-ORIG-GUID: 3yWquTOyQUKp1E2gDkekLNJPa-ZJYr9V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA0MSBTYWx0ZWRfXzzbUFme8bk0y
 /VmhYrLdGBkYV7PGbysO95f2X1mfni+8xwH0SQLiv8QDBCvCXppsfszRiaV43ScRYY/ro8XQwSl
 djuF1zfw01c4GM0m1e/HlSFE8m0PpewBuq1HLYmdV0qvbM/EZz0PtHDpkagF3XoeRBD/tNaUeY7
 gahIUPiTwv9MyyvLN86uFCYj/ZBtzVb6qO1mtmwzwGKZE2Kht5Fw4UDStBiHTTF8syKpVMn14es
 4uM99j5CorrYnwWXwjcgXLiOKnd7Xmkj7Sl+yZN8cEA7OULYAKduxUxoK3On7SeCo/OdE5EdkcO
 zUAV/PdBbWIpsmSII+IokATUYPIYbaOuEvCFyPO/miwLg8wuXKlANZtW8pYDKq0muy9P0vKSxsX
 uWJUsCct+4hEDcYQ98PpuAR4cmDD1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290041

Add support for the RDI only CAMSS camera driver on Kaanapali. Enabling
RDI path involves adding the support for a set of CSIPHY, CSID and TFE
modules, with each TFE having multiple RDI ports. This hardware
architecture requires 'qdss_debug_xo' clock for CAMNOC to be functional.

Kaanapali camera sub system provides

- 3 x VFE, 5 RDI per VFE
- 2 x VFE Lite, 4 RDI per VFE Lite
- 3 x CSID
- 2 x CSID Lite
- 6 x CSI PHY

This series has been tested using the following commands with a
downstream driver for S5KJN5 sensor.

- media-ctl --reset
- media-ctl -V '"msm_csiphy2":0[fmt:SGBRG10/4096x3072]'
- media-ctl -V '"msm_csid0":0[fmt:SGBRG10/4096x3072]'
- media-ctl -V '"msm_vfe0_rdi0":0[fmt:SGBRG10/4096x3072]'
- media-ctl -l '"msm_csiphy2":1->"msm_csid0":0[1]'
- media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
- yavta  --capture=20 -I -n 5 -f SGBRG10P -s 4096x3072 -F  /dev/video0

Dependencies:
- https://lore.kernel.org/all/20251014-use-marco-to-denote-image-buffer-number-v1-1-f782e4cc622d@oss.qualcomm.com/
- https://lore.kernel.org/all/20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com/
- https://lore.kernel.org/all/20251023-make-csiphy-status-macro-cross-platform-v1-1-5746446dfdc6@oss.qualcomm.com/

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
Changes in v4:
- Refactor kaanapali camss binding style and commit message - Krzysztof
- Link to v3: https://lore.kernel.org/r/20251023-add-support-for-camss-on-kaanapali-v3-0-02abc9a107bf@oss.qualcomm.com

Changes in v3:
- Use the name 'ahb' for 'cam_top_ahb' clock in cci binding file - Vladimir
- Reduce and simplify CSIPHY supply, port properties in camss bindings - Vladimir
- Resolve the dependency issues in the camss bindings file using ephemeral
  DT nodes - Vladimir/Dmitry
- Update hf mnoc name and bandwidth values for icc module - bod
- Split CSIPHY status macro changes into a separate patch series - bod
- Add clear functions for AUP/RUP update in csid and vfe for consistency - bod
- Clarify why the RUP and AUP register update process is deferred - bod
- Clarify the necessity to keep NRT clocks for vfe - Vijay
- Link to v2: https://lore.kernel.org/r/20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com

Changes in v2:
- Aggregate CSI2_RX_CFG0_PHY_SEL_BASE_IDX definition into 'camss-csid.h' - bod
- Remove 'camss-csid-1080.h' and use 'camss-csid-gen3.h' header instead - bod
- Remove redundant code in 'camss-csid-1080.c' and align the namespaces - bod
- Slipt 'camnoc_rt_axi' clock in vfe matching list into a single patch - bod
- Add whole vfe write engine client mappings in comment - bod
- Remove hardcoded image buffer number but use 'CAMSS_INIT_BUF_COUNT' - bod
- Remove SoC specific logic for vfe ops->reg_update and add a new variable
  to determine whether ops->reg_update is deferred or not - bod
- Add description to explain why 'qdss_debug_xo' should be retained - bod
- Add the procss node in csiphy register list comment - bod
- Rename the variable 'cmn_status_offset' to 'common_status_offset' and
  align this with macro in csiphy register structure to avoid ambiguity - bod
- Aggregate Kaanapali items into the definition that introduced by
  'qcom,qcm2290-cci' in cci binding file - Loic
- Format 'kaanpali-camss.yaml' binding file
- Link to v1: https://lore.kernel.org/r/20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com

---
Hangxiang Ma (6):
      dt-bindings: i2c: qcom-cci: Document Kaanapali compatible
      media: dt-bindings: Add CAMSS device for Kaanapali
      media: qcom: camss: Add Kaanapali compatible camss driver
      media: qcom: camss: csiphy: Add support for v2.4.0 two-phase CSIPHY
      media: qcom: camss: csid: Add support for CSID 1080
      media: qcom: camss: vfe: Add support for VFE 1080

 .../devicetree/bindings/i2c/qcom,i2c-cci.yaml      |   2 +
 .../bindings/media/qcom,kaanapali-camss.yaml       | 406 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/Makefile         |   2 +
 .../media/platform/qcom/camss/camss-csid-1080.c    | 382 +++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-csid-680.c |   1 -
 .../media/platform/qcom/camss/camss-csid-gen3.c    |   1 -
 drivers/media/platform/qcom/camss/camss-csid.h     |  11 +-
 .../platform/qcom/camss/camss-csiphy-3ph-1-0.c     | 124 +++++++
 drivers/media/platform/qcom/camss/camss-vfe-1080.c | 197 ++++++++++
 drivers/media/platform/qcom/camss/camss-vfe.c      |  10 +-
 drivers/media/platform/qcom/camss/camss-vfe.h      |   2 +
 drivers/media/platform/qcom/camss/camss.c          | 352 ++++++++++++++++++
 drivers/media/platform/qcom/camss/camss.h          |   1 +
 13 files changed, 1486 insertions(+), 5 deletions(-)
---
base-commit: b09b832c719df5e10f2560771fd38146f2b3fd7c
change-id: 20251008-add-support-for-camss-on-kaanapali-e5b6dbd5209e
prerequisite-change-id: 20251012-use-marco-to-denote-image-buffer-number-cbec071b8436:v1
prerequisite-patch-id: 3ac5d6703a9530eda884720c146b9444f90cf56b
prerequisite-change-id: 20251012-add-new-clock-in-vfe-matching-list-25fb1e378c49:v1
prerequisite-patch-id: aacb03b359fdf95977805f42918c0b6c39889e32
prerequisite-change-id: 20251021-make-csiphy-status-macro-cross-platform-5390dc128aee:v1
prerequisite-patch-id: 27c2ef96f0e747ec6b4bcf316d8802356e4cc3f4

Best regards,
-- 
Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>


