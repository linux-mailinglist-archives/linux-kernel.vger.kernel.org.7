Return-Path: <linux-kernel+bounces-653473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8838ABBA23
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8592C7A2741
	for <lists+linux-kernel@lfdr.de>; Mon, 19 May 2025 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E6F275112;
	Mon, 19 May 2025 09:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QPMkMvjZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD39274FF2
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647803; cv=none; b=pZ56cND5l6EhnxZ/EMcxL08saLRLiya2l3MDpmnGftCAsHIUs5XHNlx40uTkdcefr1C1Tf1JtRDgEwuxNm3UaBa91m0ZYBUP4BGWbEGbCTfsw5VWmAFdZzJyqzYXTgNKyjER8I+HYszzq7OcsNNZe0AtJgAnZwKXGDAy5CZCrxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647803; c=relaxed/simple;
	bh=Ceg3nCUiC8Paf2SFFHD1odF3vqvioKWqRgzD0hpAt34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCzjkemdc2nrqZJw4wq5HNLxXWDzMkAgRebJ34WzJ6hGOvSZ4MQyhgjOpm26LiCUUfPo4vIvoitD/JNucFgfe7BJrUbEl7Vyl4JAhhd0Mq9S0ABJoEH6dlqaPqTJxiYtVrn43nI++tNkKDfD/Mom73q72HpNVANLhzNkf16s01A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QPMkMvjZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J7GiGM023369
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KeR3wneLqJWBjT41LvW6zbUz5WcKmSVRWcm4lb/DGyc=; b=QPMkMvjZqPcDiXP9
	5W/nqKYIxZ+wp3vB2FjptmkNNc6rlWb8dXILQLv5FbReZ6ypIpuhtOGBBbKfP4I+
	RBoQmMSd6CShFVXMdm6xM6C2U0nOHOwX9VqIDsCNF58ZYnftfbdcDqjAh7I2hRyJ
	7yUEj7dRyDkdHwxJ3IYty1VhCgX4cbYZwkkBRZD3a8RnR10HvZWXjEhVpVG4O8pU
	VurqLPbzdenrLXd5Pe4XJiEhN9CMp21/cHSPUtzdhniW78eDI/Oh1jITXhHoGJUS
	d/A6CztaVuMaUT3Opq5iWk5QxBv1EumxiZSdQYys+yE61sTODfEwOplMwQo8rdBn
	/3Ri3w==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r041rdsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 09:43:19 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-742c5f7a70bso1399850b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 May 2025 02:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647799; x=1748252599;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KeR3wneLqJWBjT41LvW6zbUz5WcKmSVRWcm4lb/DGyc=;
        b=iUs5coGH/+DnUQX3VRFA7ecp0vsPAW1Ci7kRv9aDf8e9q4f7SOkQTs+y6RK2EPAehw
         LxprR0OPiUXtoBaLI32D2soNYRFS4N++5Yz1vgddyjEn8CH2U3Iy9JC+3fILdox3aNEf
         McyNADMwbLBJfIwLJaVzaw4z3QNmuHsFhWhTYZv2uTG8tWUBzWy7+Q8xtQfKfktgsAYM
         WQxvuwav4RQjciJzWT8DGs3CiplSBTDCSiG6uzSJPwkMqaZUukgWvGYtBi8pIBOj/L0+
         msvMnkfSTvlSsp7KAgcH7rAddnj6gkuaIpd+GaKrydA9LtSoY0yrjNLCszZNpExv0kSh
         DEgA==
X-Forwarded-Encrypted: i=1; AJvYcCXPnUlWwD8DS8e67/YK8Vzp3k52630xD/WxLD5G2yrwwromOkfVv6/nWJCYoXltoOB4gTgkJUAUy2VZsBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg2xjM1od372ksDhqj6NH7jVuorF3HGshDJ0/tRd5E5BZ2j6zk
	IKv0mq3UsDbb9pjsPW8/gjexnp/4mHh2OczMR4i61Z25KeS3loeD+pcOZcOwxM60fgishQu5qkK
	TpcB2efRuqzlycFEejTt6RsUSAngmcCNH7Gg8QEQ+0ozEB+ScHIhcgG6ikvnewdotpy0=
X-Gm-Gg: ASbGncvC6g6Wr4BqJNcAddyZ7ra1y7iaQ95/t2mNNQ2O1XZTXO9zN0xeI8c7xxB6e6L
	kfmW9GBSyIatHue+HTRUk7OQc5ps/3R0MKDn9qZT8lZRccDpW0x5wvOq02eVyQFi7ViBZpQup4i
	R+IcwaNbFeThVhFRJAlktwqtbm58gaSafOL1RwIoMV+vrr/qlH4Z3pfjdTT3l8XUGFqj/N3iRcP
	eprY1Npuf9DLGcy05djZfAy2qmvFwGJkHu8uclhJ5Cer5Ztc/RvwyAv9SPORv+nRn4ROYfTnXiw
	WPYafdarXiwSvIXTkaQZKlsdD7zJDoKdAij43PYXChHWtLc=
X-Received: by 2002:a05:6a20:728e:b0:1f5:7df9:f13c with SMTP id adf61e73a8af0-2170ce3aa79mr17245806637.41.1747647798849;
        Mon, 19 May 2025 02:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOIYnkjlC7FDC21OeUSmO8HXqsyVarXHkSF1i+56Hadctzf6ul1zvPJ/Z6FbDInw1RFvrxbg==
X-Received: by 2002:a05:6a20:728e:b0:1f5:7df9:f13c with SMTP id adf61e73a8af0-2170ce3aa79mr17245771637.41.1747647798374;
        Mon, 19 May 2025 02:43:18 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:43:18 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:21 +0530
Subject: [PATCH v3 08/11] bus: mhi: host: Add support for Bandwidth scale
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-8-3acd4a17bbb5@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
In-Reply-To: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=15157;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=Ceg3nCUiC8Paf2SFFHD1odF3vqvioKWqRgzD0hpAt34=;
 b=tZ1y8Rrb0VRiMrLQifYw98J0BmxvAM/3x9opg8//YgiI9V/9KNnvNKfcrl6zTgtDoeGLh3G3F
 RRI4wL1g4sUCszgBIl2c4q11gO84vyre3B0BosfL9vg4Q2YU+OAnAIR
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfXw0+E/7XBwd44
 YrsoD1rt7LTULgKj26CQyJk+rrAq2Vjmc8KjV3XzHpkqol5NjYg0OZYmsJHA8LDR6Q0IC1vr+Ad
 AkIsWtc8Mgetg6Q2q8m1hYVFnIco23RDD6ZBEmztXA9UHGp/w4M8u6G8oJoPAV0GznEB62q7Ca5
 LWLDTCH7eG86g6D2cPxowyI4Xn3WCeKXorP4uLD8/LE8H2PG0DxOnAwm3kGZR2Ir6mP7reRMG+E
 STW0/ruuXLqBf63ho5skVgQ/9ZAzif+dhAExgH5mBhEnt6fuk3pZ1JAO8UHJGlmTqcrGWl5DbVt
 midC22bAUNrcXLGbalaIg0Bi7kvizk6M5InQcxejS/2ShYvXqfQm6vNS5FnwwXxQeg2Uwco23Cq
 pudQprnx0dakCz1vSsZXmYzdXGioMY8G0vKilSh+78cMEu4TSdScOWzvBK66ta3pK/yo7Ew5
X-Proofpoint-ORIG-GUID: sf5voqAro3aIOEgqTEJhEWMJPTWZqnrw
X-Proofpoint-GUID: sf5voqAro3aIOEgqTEJhEWMJPTWZqnrw
X-Authority-Analysis: v=2.4 cv=HIjDFptv c=1 sm=1 tr=0 ts=682afd37 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=ILaLg5SBoNPcuQyJPx4A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190091

As per MHI spec v1.2, sec 14, MHI supports bandwidth scaling to reduce
power consumption. MHI bandwidth scaling is advertised by devices that
contain the bandwidth scaling capability registers. If enabled, the device
aggregates bandwidth requirements and sends them to the host through
dedicated mhi event ring. After the host performs the bandwidth switch,
it sends an acknowledgment by ringing a doorbell.

if the host supports bandwidth scaling events, then it must set
BW_CFG.ENABLED bit, set BW_CFG.DB_CHAN_ID to the channel ID to the
doorbell that will be used by the host to communicate the bandwidth
scaling status and BW_CFG.ER_INDEX to the index for the event ring
to which the device should send bandwidth scaling request in the
bandwidth scaling capability register.

As part of mmio init check if the bw scale capability is present or not,
if present advertise host supports bw scale by setting all the required
fields.

MHI layer will only forward the bw scaling request to the controller
driver since MHI doesn't have any idea about transport layer used by
the controller, it is responsibility of the controller driver to do actual
bw scaling and then pass status to the MHI. MHI will response back to the
device based up on the status of the bw scale received.

Add a new get_misc_doorbell() to get doorbell for misc capabilities to
use the doorbell with mhi events like MHI BW scale etc.

Use workqueue & mutex for the bw scale events as the pci_set_target_speed()
which will called by the mhi controller driver can sleep.

Co-developed-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h        | 16 +++++++
 drivers/bus/mhi/host/init.c     | 61 ++++++++++++++++++++++++-
 drivers/bus/mhi/host/internal.h |  7 ++-
 drivers/bus/mhi/host/main.c     | 98 ++++++++++++++++++++++++++++++++++++++++-
 drivers/bus/mhi/host/pm.c       | 10 ++++-
 include/linux/mhi.h             | 13 ++++++
 6 files changed, 199 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index eedac801b80021e44f7c65d33cd50760e06c02f2..0a02acee709af7a2a6abddcb9547ef56564ce453 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -208,6 +208,22 @@
 #define MHI_RSCTRE_DATA_DWORD1		cpu_to_le32(FIELD_PREP(GENMASK(23, 16), \
 							       MHI_PKT_TYPE_COALESCING))
 
+/* MHI Bandwidth scaling offsets */
+#define MHI_BW_SCALE_CFG_OFFSET		0x4
+#define MHI_BW_SCALE_CAP_ID		(3)
+
+#define MHI_BW_SCALE_ENABLE(bw_scale_db, er_index)	cpu_to_le32(FIELD_PREP(GENMASK(31, 25), \
+							bw_scale_db) |				\
+							FIELD_PREP(GENMASK(23, 19), er_index) |	\
+							BIT(24))
+
+#define MHI_TRE_GET_EV_BW_REQ_SEQ(tre)	FIELD_GET(GENMASK(15, 8), (MHI_TRE_GET_DWORD(tre, 0)))
+#define MHI_BW_SCALE_DB_ID(er_index)	FIELD_PREP(GENMASK(31, 25), er_index)
+
+#define MHI_BW_SCALE_RESULT(status, seq)	cpu_to_le32(FIELD_PREP(GENMASK(11, 8), status) | \
+						FIELD_PREP(GENMASK(7, 0), seq))
+#define MHI_BW_SCALE_NACK			0xF
+
 enum mhi_pkt_type {
 	MHI_PKT_TYPE_INVALID = 0x0,
 	MHI_PKT_TYPE_NOOP_CMD = 0x1,
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index a7137a040bdce1c58c98fe9c2340aae4cc4387d1..9fe6020f7868ec8bd114d0d96edc9d17624cbac5 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -496,10 +496,53 @@ static int mhi_find_capability(struct mhi_controller *mhi_cntrl, u32 capability,
 	return -ENXIO;
 }
 
+static int mhi_get_er_index(struct mhi_controller *mhi_cntrl,
+			    enum mhi_er_data_type type)
+{
+	struct mhi_event *mhi_event = mhi_cntrl->mhi_event;
+	int i;
+
+	/* Find event ring for requested type */
+	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
+		if (mhi_event->data_type == type)
+			return mhi_event->er_index;
+	}
+
+	return -ENOENT;
+}
+
+static int mhi_init_bw_scale(struct mhi_controller *mhi_cntrl,
+			     int bw_scale_db)
+{
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	int ret, er_index, val;
+	u32 bw_cfg_offset;
+
+	ret = mhi_find_capability(mhi_cntrl, MHI_BW_SCALE_CAP_ID, &bw_cfg_offset);
+	if (ret)
+		return ret;
+
+	er_index = mhi_get_er_index(mhi_cntrl, MHI_ER_BW_SCALE);
+	if (er_index < 0)
+		return er_index;
+
+	bw_cfg_offset += MHI_BW_SCALE_CFG_OFFSET;
+
+	/* Advertise host support */
+	val = MHI_BW_SCALE_ENABLE(bw_scale_db, er_index);
+
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->regs, bw_cfg_offset, val);
+
+	dev_dbg(dev, "Bandwidth scaling setup complete with event ring: %d\n",
+		er_index);
+
+	return 0;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;
-	int i, ret;
+	int i, ret, doorbell = 0;
 	struct mhi_chan *mhi_chan;
 	struct mhi_event *mhi_event;
 	void __iomem *base = mhi_cntrl->regs;
@@ -633,6 +676,16 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 		return ret;
 	}
 
+	if (mhi_cntrl->get_misc_doorbell)
+		doorbell = mhi_cntrl->get_misc_doorbell(mhi_cntrl, MHI_ER_BW_SCALE);
+
+	if (doorbell > 0) {
+		ret = mhi_init_bw_scale(mhi_cntrl, doorbell);
+		if (!ret)
+			mhi_cntrl->bw_scale_db = base + val + (8 * doorbell);
+		else
+			dev_warn(dev, "Failed to setup bandwidth scaling: %d\n", ret);
+	}
 	return 0;
 }
 
@@ -778,6 +831,9 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 		case MHI_ER_CTRL:
 			mhi_event->process_event = mhi_process_ctrl_ev_ring;
 			break;
+		case MHI_ER_BW_SCALE:
+			mhi_event->process_event = mhi_process_bw_scale_ev_ring;
+			break;
 		default:
 			dev_err(dev, "Event Ring type not supported\n");
 			goto error_ev_cfg;
@@ -1012,9 +1068,12 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 
 		mhi_event->mhi_cntrl = mhi_cntrl;
 		spin_lock_init(&mhi_event->lock);
+		mutex_init(&mhi_event->mutex);
 		if (mhi_event->data_type == MHI_ER_CTRL)
 			tasklet_init(&mhi_event->task, mhi_ctrl_ev_task,
 				     (ulong)mhi_event);
+		else if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			INIT_WORK(&mhi_event->work, mhi_process_ev_work);
 		else
 			tasklet_init(&mhi_event->task, mhi_ev_task,
 				     (ulong)mhi_event);
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index ce566f7d2e9240c64044407aa4124ad3cdb98003..cf64adaecad2aeec8569da5276ec60dd7e97e5e0 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -248,6 +248,8 @@ struct mhi_event {
 	struct mhi_ring ring;
 	struct db_cfg db_cfg;
 	struct tasklet_struct task;
+	struct work_struct work;
+	struct mutex mutex; /* lock for synchronization */
 	spinlock_t lock;
 	int (*process_event)(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event,
@@ -410,7 +412,8 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 				struct mhi_event *mhi_event, u32 event_quota);
 int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
 			     struct mhi_event *mhi_event, u32 event_quota);
-
+int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
+				 struct mhi_event *mhi_event, u32 event_quota);
 /* ISR handlers */
 irqreturn_t mhi_irq_handler(int irq_number, void *dev);
 irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev);
@@ -426,5 +429,5 @@ void mhi_unmap_single_no_bb(struct mhi_controller *mhi_cntrl,
 			    struct mhi_buf_info *buf_info);
 void mhi_unmap_single_use_bb(struct mhi_controller *mhi_cntrl,
 			     struct mhi_buf_info *buf_info);
-
+void mhi_process_ev_work(struct work_struct *work);
 #endif /* _MHI_INT_H */
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 9bb0df43ceef1e54e8817422516aab1def6fdc4a..f87e9550b59227947fc7268c5799eea274c66b98 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -472,7 +472,10 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
 		if (mhi_dev)
 			mhi_notify(mhi_dev, MHI_CB_PENDING_DATA);
 	} else {
-		tasklet_schedule(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			queue_work(mhi_cntrl->hiprio_wq, &mhi_event->work);
+		else
+			tasklet_schedule(&mhi_event->task);
 	}
 
 	return IRQ_HANDLED;
@@ -1049,6 +1052,99 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
 	return count;
 }
 
+int mhi_process_bw_scale_ev_ring(struct mhi_controller *mhi_cntrl,
+				 struct mhi_event *mhi_event, u32 event_quota)
+{
+	struct mhi_event_ctxt *er_ctxt = &mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ring *ev_ring = &mhi_event->ring;
+	dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
+	u32 response = MHI_BW_SCALE_NACK;
+	struct mhi_ring_element *dev_rp;
+	struct mhi_link_info link_info;
+	int ret = -EINVAL;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state))) {
+		ret =  -EIO;
+		goto exit_bw_scale;
+	}
+
+	if (!MHI_IN_MISSION_MODE(mhi_cntrl->ee))
+		goto exit_bw_scale;
+
+	if (!is_valid_ring_ptr(ev_ring, ptr)) {
+		dev_err(dev,
+			"Event ring rp points outside of the event ring\n");
+		ret =  -EIO;
+		goto exit_bw_scale;
+	}
+
+	dev_rp = mhi_to_virtual(ev_ring, ptr);
+
+	/* If rp points to base, we need to wrap it around */
+	if (dev_rp == ev_ring->base)
+		dev_rp = ev_ring->base + ev_ring->len;
+	dev_rp--;
+
+	/* Fast forward to currently processed element and recycle er */
+	ev_ring->rp = dev_rp;
+	ev_ring->wp = dev_rp - 1;
+	if (ev_ring->wp < ev_ring->base)
+		ev_ring->wp = ev_ring->base + ev_ring->len - ev_ring->el_size;
+	mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
+
+	if (WARN_ON(MHI_TRE_GET_EV_TYPE(dev_rp) != MHI_PKT_TYPE_BW_REQ_EVENT)) {
+		dev_err(dev, "!BW SCALE REQ event\n");
+		goto exit_bw_scale;
+	}
+
+	link_info.target_link_speed = MHI_TRE_GET_EV_LINKSPEED(dev_rp);
+	link_info.target_link_width = MHI_TRE_GET_EV_LINKWIDTH(dev_rp);
+	link_info.sequence_num = MHI_TRE_GET_EV_BW_REQ_SEQ(dev_rp);
+
+	dev_dbg(dev, "Received BW_REQ with seq:%d link speed:0x%x width:0x%x\n",
+		link_info.sequence_num,
+		link_info.target_link_speed,
+		link_info.target_link_width);
+
+	/* Bring host and device out of suspended states */
+	ret = mhi_device_get_sync(mhi_cntrl->mhi_dev);
+	if (ret)
+		goto exit_bw_scale;
+
+	mhi_cntrl->runtime_get(mhi_cntrl);
+
+	ret = mhi_cntrl->bw_scale(mhi_cntrl, &link_info);
+	if (!ret)
+		response = 0;
+
+	response = MHI_BW_SCALE_RESULT(response, link_info.sequence_num);
+
+	write_lock_bh(&mhi_cntrl->pm_lock);
+	mhi_write_reg(mhi_cntrl, mhi_cntrl->bw_scale_db, 0, response);
+	write_unlock_bh(&mhi_cntrl->pm_lock);
+
+	mhi_cntrl->runtime_put(mhi_cntrl);
+	mhi_device_put(mhi_cntrl->mhi_dev);
+
+exit_bw_scale:
+	return ret;
+}
+
+void mhi_process_ev_work(struct work_struct *work)
+{
+	struct mhi_event *mhi_event = container_of(work, struct mhi_event,
+						   work);
+
+	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
+
+	if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
+		return;
+
+	guard(mutex)(&mhi_event->mutex);
+	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
+}
+
 void mhi_ev_task(unsigned long data)
 {
 	struct mhi_event *mhi_event = (struct mhi_event *)data;
diff --git a/drivers/bus/mhi/host/pm.c b/drivers/bus/mhi/host/pm.c
index 2fb27e6f8f88ebc701dad56dd60844d8470dd418..8b518da4995d83a299f419908b3753e6b78c8803 100644
--- a/drivers/bus/mhi/host/pm.c
+++ b/drivers/bus/mhi/host/pm.c
@@ -523,7 +523,10 @@ static void mhi_pm_disable_transition(struct mhi_controller *mhi_cntrl,
 		if (mhi_event->offload_ev)
 			continue;
 		disable_irq(mhi_cntrl->irq[mhi_event->irq]);
-		tasklet_kill(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			cancel_work_sync(&mhi_event->work);
+		else
+			tasklet_kill(&mhi_event->task);
 	}
 
 	/* Release lock and wait for all pending threads to complete */
@@ -670,7 +673,10 @@ static void mhi_pm_sys_error_transition(struct mhi_controller *mhi_cntrl)
 	for (i = 0; i < mhi_cntrl->total_ev_rings; i++, mhi_event++) {
 		if (mhi_event->offload_ev)
 			continue;
-		tasklet_kill(&mhi_event->task);
+		if (mhi_event->data_type == MHI_ER_BW_SCALE)
+			cancel_work_sync(&mhi_event->work);
+		else
+			tasklet_kill(&mhi_event->task);
 	}
 
 	/* Release lock and wait for all pending threads to complete */
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index dd372b0123a6da5107b807ff8fe940c567eb2030..2041bbb2e2396eb2e19e6bc0a5e981aa2917ebdd 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -102,10 +102,12 @@ struct image_info {
  * struct mhi_link_info - BW requirement
  * target_link_speed - Link speed as defined by TLS bits in LinkControl reg
  * target_link_width - Link width as defined by NLW bits in LinkStatus reg
+ * sequence_num - used by device to track bw requests sent to host
  */
 struct mhi_link_info {
 	unsigned int target_link_speed;
 	unsigned int target_link_width;
+	int sequence_num;
 };
 
 /**
@@ -183,10 +185,12 @@ enum mhi_ch_ee_mask {
  * enum mhi_er_data_type - Event ring data types
  * @MHI_ER_DATA: Only client data over this ring
  * @MHI_ER_CTRL: MHI control data and client data
+ * @MHI_ER_BW_SCALE: MHI controller bandwidth scale functionality
  */
 enum mhi_er_data_type {
 	MHI_ER_DATA,
 	MHI_ER_CTRL,
+	MHI_ER_BW_SCALE,
 };
 
 /**
@@ -299,6 +303,7 @@ struct mhi_controller_config {
  * @bhi: Points to base of MHI BHI register space
  * @bhie: Points to base of MHI BHIe register space
  * @wake_db: MHI WAKE doorbell register address
+ * @wake_db: MHI BW_SCALE doorbell register address
  * @iova_start: IOMMU starting address for data (required)
  * @iova_stop: IOMMU stop address for data (required)
  * @fw_image: Firmware image name for normal booting (optional)
@@ -355,6 +360,8 @@ struct mhi_controller_config {
  * @write_reg: Write a MHI register via the physical link (required)
  * @reset: Controller specific reset function (optional)
  * @edl_trigger: CB function to trigger EDL mode (optional)
+ * @get_misc_doobell: function to get doorbell used for MISC feature like BW scale etc (optional)
+ * @bw_scale: CB function for passing BW scale info (optional)
  * @buffer_len: Bounce buffer length
  * @index: Index of the MHI controller instance
  * @bounce_buf: Use of bounce buffer
@@ -376,6 +383,7 @@ struct mhi_controller {
 	void __iomem *bhi;
 	void __iomem *bhie;
 	void __iomem *wake_db;
+	void __iomem *bw_scale_db;
 
 	dma_addr_t iova_start;
 	dma_addr_t iova_stop;
@@ -440,6 +448,11 @@ struct mhi_controller {
 	void (*reset)(struct mhi_controller *mhi_cntrl);
 	int (*edl_trigger)(struct mhi_controller *mhi_cntrl);
 
+	int (*get_misc_doorbell)(struct mhi_controller *mhi_cntrl,
+				 enum mhi_er_data_type type);
+	int (*bw_scale)(struct mhi_controller *mhi_cntrl,
+			struct mhi_link_info *link_info);
+
 	size_t buffer_len;
 	int index;
 	bool bounce_buf;

-- 
2.34.1


