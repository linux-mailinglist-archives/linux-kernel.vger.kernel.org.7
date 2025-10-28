Return-Path: <linux-kernel+bounces-873122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A1FC132AF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AC694FD31A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAC82BEFFD;
	Tue, 28 Oct 2025 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KIEPuW91"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731C2D8760
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632912; cv=none; b=qJlhd5iwmMOfnI37b94undeZFuaU2NZiutiw3zkBoMyNBfaL0D2gnNllM/fBVuUIkk7odYleqbXFeHF5EQ2KSX49WT3D4Eefd6zT+jdi9qE1uX+23LGaAL2Ns7iWYo0Ra4/Ew/wxMUDjWdtUlhprdLvxolFxI51pTdgGhIEloW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632912; c=relaxed/simple;
	bh=4+85nU8xoAz0ySe0tncInYyQsGyUu39pardgvBh8hvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rrnZG6aK4oMvneBuetvnHYXSDMrXxv+e2ntl7vsdB/tMI4uCv+LMhZ1Bq/4jAIdEpb30N1hAG9/CxMF6UsIi4myOm3Il74z//dc160I63FG5QbpkA3FLfQ7Zwdkrur7M4FiG8T1AU6x+MGjitgWd/LBvSapQRi0b55wJfeYS7sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KIEPuW91; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S4p7hj591592
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t3PKgoQRhDz3xj/TTAw6S8lRYEfHhvbc362HXPhuaQc=; b=KIEPuW91mEx74jag
	wKfkedfFkzluRgMpb7OwPeHyMBXMhmXWVeC66Hks2fLtKgHvrFD00m1NMgOK6K4s
	DKI2JZ0n8l4XjCG3Sh8guMOoshwhegTKMjCyQuE+4gQP6cAmlHShVKSHlhxuVnWe
	Anbl+YYqXdPYK56OlFGLW68Er0PwJzLk1l+ceIIAPQizdrcWmZw6fdX9WuhTh3GQ
	NSBck71nsnxGTzTe3LNV487iATTHyOYfX4I2tCbrmd5c/EcTKPfGxl8n1gJTMha5
	sJmn1Bpz6sM9hsK2bfDRnPAggz1uvA2OURqbFa/frFDy+Ih/plE3DsPdydPSbGOA
	jmmyzQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2q5u87ha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:28:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-27ee41e062cso62909425ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632908; x=1762237708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t3PKgoQRhDz3xj/TTAw6S8lRYEfHhvbc362HXPhuaQc=;
        b=VkSb3cMSroVskh3EMUea3vCimAf34Yme/LLIjgJOejsuX2cPRR9hiz63IEuNHwG5U3
         TpEJ3SLHN/3BemJGOK5a8fZeXFc5xT9EpADy5ERHGRMCAzoh0og74QPQIjUMaKPxb1of
         /cqRQwKWQHGlrkykguHR88dPAIt08TnAq18xfdbt7KI6CjeIdyxt0uejnSJnM3ti5ZyK
         ELlCsVxZsLqhrrMauNzsa1UNvhQnB0rRPlA0GKgn/UmbXNVJz8LvoWYWQh5+qFQIFZGW
         bWLXAZe8pCzrnBtMbU7l1qVdtIz3r7sG+79nsu1HOfDcEXPgwhx+1Rr+No0TOo5NiVxr
         9EZg==
X-Forwarded-Encrypted: i=1; AJvYcCWp2+9G3aNHSk60TFlZqvtAGHd18waBtMF994qjKh/dWMIOncDApU9MYs2765UnImJv22U3FEkpV1wjWQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycM4zXts9retCdGcN/BY+ug4Axj90OddxQ5OmVYMKUrZ2oDjCq
	QYBEqNKZ+n5q8GWEGRd6ZKaPQSFySxjUoiWzFV0s4sgBPkEdPyXRp0uwVP9kxA91Dj1cpq3Pnb8
	2dxXS7FDy0YVvJYLrHhwHC2GSsK9FVxEw7S5dOLre0mI8DUOs+d73E9lwKV1Qu7FJLo4=
X-Gm-Gg: ASbGncujlZj9EciHIjn0z7WUqzx+tHO+XY1S2MPxZ3HNh+QpannyuMbH4kCqjZrw56W
	QwQ1VQFa6TuWV1BEJvpOvoTTF7S0kDSte+U/djsH8mgOHnPZbYOR3LT8R0vtHlKSMd8qeBSP9Po
	U+0WoACSYzXova4bQcrYXb3V0yAO/lq6dzVFqljuvPT6vlmWaqovy4h3/HQ4QQuNUFh4a1lF+G0
	Uu3GvFKqyoFpKc+SfsEwfhn75dmbMRgsECwt6qwT3mHwyc1I1xyW2XWgBrUV2zdt9cs8nMFokE3
	Cf0w+XNREhEQ+wb5H6GzTEt1xRe3NgrbyIjUQUq05smDUy7YfucflU5Zdu/78x/dVfN2PPpwhxx
	7m/Cs4wdvUVbC5cP+m8e8AiOTiSi9vkRWVnR/YnCEoIMyi1wbNrDNzU7g
X-Received: by 2002:a17:902:cecc:b0:276:842a:f9a7 with SMTP id d9443c01a7336-294cb523d54mr34137285ad.57.1761632907817;
        Mon, 27 Oct 2025 23:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbF6VkJ5hNQYX9ifMUJ2BxNPDyPg/K3YdJ3vJi56Pq5avhHEfGcHnz4I2DTdPfdjFODVgmNA==
X-Received: by 2002:a17:902:cecc:b0:276:842a:f9a7 with SMTP id d9443c01a7336-294cb523d54mr34136965ad.57.1761632907337;
        Mon, 27 Oct 2025 23:28:27 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf359asm102503265ad.12.2025.10.27.23.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 23:28:26 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 23:28:11 -0700
Subject: [PATCH 09/12] coresight-tmc: Update tmc_mgmt_attrs for CPU cluster
 TMC compatibility
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-cpu_cluster_component_pm-v1-9-31355ac588c2@oss.qualcomm.com>
References: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
In-Reply-To: <20251027-cpu_cluster_component_pm-v1-0-31355ac588c2@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linux.dev>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761632890; l=4826;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=4+85nU8xoAz0ySe0tncInYyQsGyUu39pardgvBh8hvk=;
 b=wxyUwqrzqepTBHvSNDoVG1J5TCtBtVofgulY7h8uIIFRx6LVPZ2z4HU6ZzJRzpZURhWASLs00
 86cQ1kU7FdkDaS9taTrSS7RKGeoMl1joGb6OwLlagIPIOgezuc2XZQ/
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA1NCBTYWx0ZWRfXyNvVlCYGDa8F
 z5ppkX2ZrFvqyD7Q7hD/4JRZzP7SXD2z7bX/NS9kGXfbd2eqTeCi68eRZfqBX1nfANl01I9tOpy
 CB7dnwRhUSQm5MkVk7UBZH/Oq2+B1fkWosmsSGYYBU+E/cO7FzXQYEtuCRIygMhN4mks7ZlPi1u
 yKPVRyMb6KKIZPZ/wjkQ+y4annWCaSJu9JtDN84FBeoMcNf8f5jSg7SqQ3R9qRx2jlmdz/M9ylP
 cjhpNjCBYJZI5MwXkzsEEiZ6enOejO6nNSu53Y+8mrAyiJLztQUgi6Gfp58bUnx6L8LuZCPgC58
 ajFwaBI1hnUk/MiLFRlub5h0u4iSaPxHTUeD7MRwfCOMQhyJobq47ZnmoD9ayIS4S+hcJZu1+Q0
 Ec7noON6osrpngL915FLIz8qVwZBPA==
X-Proofpoint-ORIG-GUID: WEVq2g6I-5lCvrOJ3j1-jaVVk3bCXqoY
X-Proofpoint-GUID: WEVq2g6I-5lCvrOJ3j1-jaVVk3bCXqoY
X-Authority-Analysis: v=2.4 cv=c9CmgB9l c=1 sm=1 tr=0 ts=6900628c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=C6fT43XAjLT6VXuj5BkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280054

This patch refactors the sysfs interfaces to ensure compatibility with
CPU cluster TMC. When operating on a CPU cluster TMC, register reads
are performed via `smp_call_function_single()`.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-core.c | 137 ++++++++++++++++++++---
 1 file changed, 123 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index d00f23f9a479ee9d4bdb4e051ed895d266bcc116..685a64d8ba1b5df4cff91694eee45c6d6a147bc1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -458,21 +458,130 @@ static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
 	return memwidth;
 }
 
+struct tmc_smp_arg {
+	struct tmc_drvdata *drvdata;
+	u32 offset;
+	int rc;
+};
+
+static void tmc_read_reg_smp_call(void *info)
+{
+	struct tmc_smp_arg *arg = info;
+
+	arg->rc = readl_relaxed(arg->drvdata->base + arg->offset);
+}
+
+static u32 cpu_tmc_read_reg(struct tmc_drvdata *drvdata, u32 offset)
+{
+	struct tmc_smp_arg arg = {
+		.drvdata = drvdata,
+		.offset = offset,
+	};
+	int cpu, ret = 0;
+
+	for_each_cpu(cpu, drvdata->cpumask) {
+		ret = smp_call_function_single(cpu,
+					       tmc_read_reg_smp_call, &arg, 1);
+		if (!ret)
+			return arg.rc;
+	}
+
+	return ret;
+}
+
+static ssize_t coresight_tmc_reg32_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cs_off_attribute *cs_attr = container_of(attr, struct cs_off_attribute, attr);
+	int ret;
+	u32 val;
+
+	ret = pm_runtime_resume_and_get(dev->parent);
+	if (ret < 0)
+		return ret;
+
+	if (!drvdata->cpumask)
+		val = readl_relaxed(drvdata->base + cs_attr->off);
+	else
+		val = cpu_tmc_read_reg(drvdata, cs_attr->off);
+
+	pm_runtime_put(dev->parent);
+
+	if (ret < 0)
+		return ret;
+	else
+		return sysfs_emit(buf, "0x%x\n", val);
+}
+
+static ssize_t coresight_tmc_reg64_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct cs_pair_attribute *cs_attr = container_of(attr, struct cs_pair_attribute, attr);
+	int ret;
+	u64 val;
+
+	ret = pm_runtime_resume_and_get(dev->parent);
+	if (ret < 0)
+		return ret;
+	if (!drvdata->cpumask) {
+		val = readl_relaxed(drvdata->base + cs_attr->lo_off) |
+			((u64)readl_relaxed(drvdata->base + cs_attr->hi_off) << 32);
+	} else {
+		ret = cpu_tmc_read_reg(drvdata, cs_attr->lo_off);
+
+		if (ret < 0)
+			goto out;
+
+		val = ret;
+
+		ret = cpu_tmc_read_reg(drvdata, cs_attr->hi_off);
+		if (ret < 0)
+			goto out;
+
+		val |= ((u64)ret << 32);
+	}
+
+out:
+	pm_runtime_put_sync(dev->parent);
+	if (ret < 0)
+		return ret;
+	else
+		return sysfs_emit(buf, "0x%llx\n", val);
+}
+
+#define coresight_tmc_reg32(name, offset)				\
+	(&((struct cs_off_attribute[]) {				\
+	   {								\
+		__ATTR(name, 0444, coresight_tmc_reg32_show, NULL),	\
+		offset							\
+	   }								\
+	})[0].attr.attr)
+#define coresight_tmc_reg64(name, lo_off, hi_off)			\
+	(&((struct cs_pair_attribute[]) {				\
+	   {								\
+		__ATTR(name, 0444, coresight_tmc_reg64_show, NULL),	\
+		lo_off, hi_off						\
+	   }								\
+	})[0].attr.attr)
 static struct attribute *coresight_tmc_mgmt_attrs[] = {
-	coresight_simple_reg32(rsz, TMC_RSZ),
-	coresight_simple_reg32(sts, TMC_STS),
-	coresight_simple_reg64(rrp, TMC_RRP, TMC_RRPHI),
-	coresight_simple_reg64(rwp, TMC_RWP, TMC_RWPHI),
-	coresight_simple_reg32(trg, TMC_TRG),
-	coresight_simple_reg32(ctl, TMC_CTL),
-	coresight_simple_reg32(ffsr, TMC_FFSR),
-	coresight_simple_reg32(ffcr, TMC_FFCR),
-	coresight_simple_reg32(mode, TMC_MODE),
-	coresight_simple_reg32(pscr, TMC_PSCR),
-	coresight_simple_reg32(devid, CORESIGHT_DEVID),
-	coresight_simple_reg64(dba, TMC_DBALO, TMC_DBAHI),
-	coresight_simple_reg32(axictl, TMC_AXICTL),
-	coresight_simple_reg32(authstatus, TMC_AUTHSTATUS),
+	coresight_tmc_reg32(rsz, TMC_RSZ),
+	coresight_tmc_reg32(sts, TMC_STS),
+	coresight_tmc_reg64(rrp, TMC_RRP, TMC_RRPHI),
+	coresight_tmc_reg64(rwp, TMC_RWP, TMC_RWPHI),
+	coresight_tmc_reg32(trg, TMC_TRG),
+	coresight_tmc_reg32(ctl, TMC_CTL),
+	coresight_tmc_reg32(ffsr, TMC_FFSR),
+	coresight_tmc_reg32(ffcr, TMC_FFCR),
+	coresight_tmc_reg32(mode, TMC_MODE),
+	coresight_tmc_reg32(pscr, TMC_PSCR),
+	coresight_tmc_reg32(devid, CORESIGHT_DEVID),
+	coresight_tmc_reg64(dba, TMC_DBALO, TMC_DBAHI),
+	coresight_tmc_reg32(axictl, TMC_AXICTL),
+	coresight_tmc_reg32(authstatus, TMC_AUTHSTATUS),
 	NULL,
 };
 

-- 
2.34.1


