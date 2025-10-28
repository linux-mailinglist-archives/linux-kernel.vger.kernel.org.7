Return-Path: <linux-kernel+bounces-872921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E57C129DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D758A501C80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702E31A8412;
	Tue, 28 Oct 2025 02:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EOUSOwS3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB131917D0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616969; cv=none; b=IfsL62T6trhajpgcBxgIT1OhATxevnWyYAagOVTWgbAzmblc/AnYXNzxRHHh4e6QZOnI1HSVHcH1GOScSDUaGq+XPu4ruMdV4B0K5oIkmYLaF/V/qxpWdE9ryWxR+oYM1h6qKGqozi+43x4pru9q8HiApUCLvuWGOw1lpoD0dk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616969; c=relaxed/simple;
	bh=ppNs98+/KrCTp5WuAgd66xHUOepu6zq784Z9Tp5Ab1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AKmTJqNGK/kf6kM2dZlthxMMAn556fGQGK9KRb92tcWmyDTLBVfbavFemhZ5lZOWvJfq0OOYKcPEm+XRp9XkXT79P+CqVJAn21je+z1QETUPliolTJjzOpQIZHdp0LdSWH6D+2BKDcmCMwbNN3eY9aeDeK2HS2EKW+iqQgoz/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EOUSOwS3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RKkUB63813900
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Va8zu6hMrrLXvLI0XHE958jJavnC6hBBXG7asoWjNaM=; b=EOUSOwS3tn//2yEP
	kLIQaKrO83DyzLqykfk/ZNg2LTTJ6XHIYARFugHeTC/HedfD4K4Tf3zQ6rltVKTr
	O/j3KwsOA3LqYBXME5v+zyaKtAaphVzVSyYufZq0ibCy9xmPAjBkUq3rU98C4mrX
	5OHFU8UtHa+YAGO68oNq4P2TDZy9Af/Vy4jzvXoI0FYPJVhjn7LTWjnoq/mFW8Rj
	/kUJqInquKAAL8fbwe8IhPSwCGYVO6bNLFboR/jxuXKChywfERKB93JGc0E+raeA
	RkjpLA2K+fCqyHkQXA4CS9j1GUcNSNNvBkjwDUvN6j6UMxGm195yOmVEhANmIOEo
	kAW8UA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2g2frm06-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:02:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-269880a7bd9so54204515ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761616967; x=1762221767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Va8zu6hMrrLXvLI0XHE958jJavnC6hBBXG7asoWjNaM=;
        b=OUcWiHe2BGks5BUXwADSJy/hPMsJtfOeudmOYVEosgBkxPlL9laZyQ2LvMAi+SyvGh
         CR31h6Qqgx0smjgDU48JEKROCQtYDb9zFXoiZ02YA0SDZ6qWa5fQTBf2475eTwZVou5i
         X5YcNKMTrDCiooh+EnOVtoIUPkTHFoZjYYuAzr5+e+pgND54/nWgnjiAHCEK9/duIz1r
         WOgBkSRLlW8dpcOvRCj0SUfHWwT6ir3y1TJ/wsO93+U+KCbwrI3JQ9fyPJWW90ULaz6W
         02hadTv67BhrFezkRCtf2l/2pH9muq3+zCAC8Eg8ka609jcJDtBkkjI3paMrlog5f7I/
         yFMg==
X-Forwarded-Encrypted: i=1; AJvYcCXMo4HY3No4ifV6wnYeXZ4OT2aK7Ub4XKsC52uWcEY3YkxH4JID6YHT0tEjG0dTsI0P8ZVWOOVUPpTjZZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMan/sqrovz6suYXae5mQKr1dROasQVHGeLs3lrye/bB0pC1d6
	M7GUCiVKx7jY3kOkA2g083ltPf0tU5BDgU8yd32kD2cqxSTaoF3J9R2+vaAmo6lKiVFBPTFl0l0
	49R8N8V1idbg6hIVC8qcVCXAQkJhX0hsZFTyNQvWGdmDVFW1CH8t1LammhjVh/Z1WeRg=
X-Gm-Gg: ASbGncuzMGOEQl3spvja8A0s+NjxFQ3tOyn9Pkdcuj8fppiZqx3ga0TuLJbHh5LXUc6
	3Q6wTH5andOQH7Ui+W67bW3k7BBBr5cp6V7s+oBgO4YEgn++4GrQc6mRr/bp12c5tIjh4Wkn+of
	DjmG9BKSGq4SBi4Ge6kgs4hc2/1L9dg1wJ3nJ/krwcj1RBO2FUlgP3iQLnYmQKrH5mcOU/sTvPn
	OQLf97ANiVewr+hbSH9Yy1e1a2fn6XW42x5hVuEdtNsHH9qzI3UeYy6CYfff45o5NGX3bbOhjvc
	OzA8Zc47pBrSVmWhQjPan7CV2eOZ4X4GTdByYdJkPFMsb+7U/+g4T6KYgudGhNrypvj1Qhy6iAZ
	XHJqBROynWDPIUIg99XDQ4JT+ZgkyP4z3un4RVQSHxWt5/DaISDrDQmQNCovD8ytuxA==
X-Received: by 2002:a17:903:2311:b0:25e:78db:4a0d with SMTP id d9443c01a7336-294cb52e55cmr22641855ad.36.1761616966546;
        Mon, 27 Oct 2025 19:02:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr/hPPl1psVSnjAW2Lr1uNM8tJffTyOs5FImuh36CnZYvweWmWbGcbW3fSoaAOQLKLUvHMRw==
X-Received: by 2002:a17:903:2311:b0:25e:78db:4a0d with SMTP id d9443c01a7336-294cb52e55cmr22641425ad.36.1761616966043;
        Mon, 27 Oct 2025 19:02:46 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2789bsm95861895ad.62.2025.10.27.19.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 19:02:45 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:02:16 +0800
Subject: [PATCH v4 2/3] coresight: tpda: add logic to configure TPDA_SYNCR
 register
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-configure_tpda_reg-v4-2-23000805d21d@oss.qualcomm.com>
References: <20251028-configure_tpda_reg-v4-0-23000805d21d@oss.qualcomm.com>
In-Reply-To: <20251028-configure_tpda_reg-v4-0-23000805d21d@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761616954; l=2127;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=xMq1hphT88tb32w6fNQrV9hkQFyegvz+mX42/327QPs=;
 b=v6thXMIadp7v3974Nue9BRcN9ip4OkkCsEdc7yL0US0Rf8afWL4VCs//fGMH/9ZSfSuf+f2sf
 DKu4n2NxLKoCvisXnoL+FR6586rj22+vcSGFAf9TqvmxvT/CbTpivPX
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDAxNyBTYWx0ZWRfX+WikH7X0VR4r
 Wp808wr/XCQOarCA/WPqsuwNfu/1CmOpAXnsA5rOyNq4i0CDRJN4BfTg6fk2AXzjSreW8zek/iW
 QGgIhznJA47yCYB2bs1n8jeUjhBVN95a8SOT14XVQmE3gKBghjvPAEgXBd4NcwyH3/ZDKtY+R1I
 RtN+MlYu/PGM02M/oROG3OioQnEgBcgPwwdksAkFeWqk+PXokiDIU1vVo1ZC2cKLWRkDffWmeN0
 7AM6zniLGeQFqzoCTx2WOCkTPyU/1z1nHJXXiHwNdo8z5DM9sFsWpzzje5uhkITBOppjXjZgw/3
 qMi8d2PlUJEEBtpOyfgiLijv6A5jMNm0XOUIkAeg+JRFUJcWsngtDD+49PJoCq2IH/MhrayVZgE
 bAA3ZrWzVdIKOnO18/2vN4QHrbV8aw==
X-Proofpoint-ORIG-GUID: -4MjwNXzIZR7vwS7B4XhCtYgjvm9dVzu
X-Proofpoint-GUID: -4MjwNXzIZR7vwS7B4XhCtYgjvm9dVzu
X-Authority-Analysis: v=2.4 cv=FIMWBuos c=1 sm=1 tr=0 ts=69002447 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=6Dbyrv6SX_ztr3m6kfUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280017

From: Tao Zhang <tao.zhang@oss.qualcomm.com>

The TPDA_SYNCR register defines the frequency at which TPDA generates
ASYNC packets, enabling userspace tools to accurately parse each valid
packet.

Signed-off-by: Tao Zhang <tao.zhang@oss.qualcomm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Co-developed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tpda.c | 7 +++++++
 drivers/hwtracing/coresight/coresight-tpda.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index a9a27bcc65a1..f079861da279 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -178,6 +178,13 @@ static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
 	 */
 	if (drvdata->trig_flag_ts)
 		writel_relaxed(0x0, drvdata->base + TPDA_FPID_CR);
+
+	/* Program the counter value for TPDA_SYNCR */
+	val = readl_relaxed(drvdata->base + TPDA_SYNCR);
+	/* Clear the mode */
+	val &= ~TPDA_SYNCR_MODE_CTRL;
+	val |= TPDA_SYNCR_COUNTER_MASK;
+	writel_relaxed(val, drvdata->base + TPDA_SYNCR);
 }
 
 static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
diff --git a/drivers/hwtracing/coresight/coresight-tpda.h b/drivers/hwtracing/coresight/coresight-tpda.h
index 0be625fb52fd..0c9bf2fade56 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.h
+++ b/drivers/hwtracing/coresight/coresight-tpda.h
@@ -9,6 +9,7 @@
 #define TPDA_CR			(0x000)
 #define TPDA_Pn_CR(n)		(0x004 + (n * 4))
 #define TPDA_FPID_CR		(0x084)
+#define TPDA_SYNCR		(0x08C)
 
 /* Cross trigger FREQ packets timestamp bit */
 #define TPDA_CR_FREQTS		BIT(2)
@@ -27,6 +28,10 @@
 #define TPDA_Pn_CR_CMBSIZE		GENMASK(7, 6)
 /* Aggregator port DSB data set element size bit */
 #define TPDA_Pn_CR_DSBSIZE		BIT(8)
+/* TPDA_SYNCR mode control bit */
+#define TPDA_SYNCR_MODE_CTRL		BIT(12)
+/* TPDA_SYNCR counter mask */
+#define TPDA_SYNCR_COUNTER_MASK		GENMASK(11, 0)
 
 #define TPDA_MAX_INPORTS	32
 

-- 
2.34.1


