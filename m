Return-Path: <linux-kernel+bounces-768998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DD4B268DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9939E11B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C71DEFE8;
	Thu, 14 Aug 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XGzXK/mV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC01DE4C2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180114; cv=none; b=Upie3h3uhu/CGPPduAHC07dEf/UzduIsbM2KBYg5+FHYewmanA5tJ6SXZbRaqhSKMevwIHPBGOnUzmlcRVDj3jnBqQMKqi03inta8do551/omeNzd2UJVR96aNj4Ff9RZUsqIga+f3SRcNc1t1zT9sja+lReRyojPbsNEjPnkik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180114; c=relaxed/simple;
	bh=8NTSg+6raBarlKo8knJAbkIzdsRfGJ+Fz1wgg5XTVUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YM3P1mezjcQyB2yLCDJGu38oiDx8khkJYa9BBGRPVmyAg0z+EDK9qnfPq8soarqyMDUHlL/0YiE8HWoqUA7CikWPSFWHU+hOzz7V0XZNkymhFPxEhN5U3U0SQ87UO2vGGEUJZSG5DeGlbwVzCg6x015hT73/7FM4YOCYnpQ952I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XGzXK/mV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8uYNh027030
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Iio6GvPxtaPpYrjCRWU0cQAtNammqCoSqGv
	G5IKA6ro=; b=XGzXK/mV4qEm4mE5Ux0ckxZ4mgexfVt9jrccRcsBX42DQPE7E21
	TDJESW8mYvDVgpD+o3autl4eCdTO00bMokh4Ye2SAsKKyOtucCu9XfE+skLPDwkt
	0Yp7wUmfDqBEfaVgFabnUYfDl1NgSmV9rQDV90N88LGjGpmrKoIT8az/aBsfv2sn
	QNcu9ZJv57tIiAhXvRCQ9cyUrbcvEuFGSPDq+vm0CziEA3DdSJ20odMxrXSuRr2P
	4PhHJcJNKjzoD9TGVadumYzsiHjosWOdzjmSRTFQKrLoRem3KeV5B8PJ5vqsKaJ4
	HpZGCCKSReoQYdBZHifI8aAFikLk2U5LPPQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjurns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:01:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eac5c63so868966b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180111; x=1755784911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iio6GvPxtaPpYrjCRWU0cQAtNammqCoSqGvG5IKA6ro=;
        b=OVT9R00Cy4es9vLkwych29tO8NuD0il0FjeNdGZzJ/Ycg5/gsHb4yu4jLJnwfZRwrK
         QIO1+eytJewl1f5k1pCHi8z7lqjIjeUCSOtTVnw2YTLm7BTF42DATDg4QE6Ldfl87PgG
         KS3Y1HyQFskyf9cQxtvao9xSDVSmv5/vlHGlUBInsoiDq9GEwiXWPkoaJzQYsyfyEGVJ
         asmF0umflO4tqTuH6NxKNF9zd9AKg78T0d4Cxtv7QYlqoqhd846tl8AaIZtxHKiReJvb
         bFCoYoCJdFaxT6poh1Rj48a53HZ7yJHvrKcacSn+GLI+Z2G+R4AE+l2q9iLgbZDiXtR6
         Qolg==
X-Gm-Message-State: AOJu0YyZ0spjIyV8HCToKm1M3AW8shMSXVqdDLTxopwIFn/eoAFrrz4s
	Pz47Bp6fS83yL1dySu4BO+b8D4F+BbqwjCS3EI3EAxYaAfB+GSwQUx4GOj7e8sGyVhfyJPNbR8x
	edF7wHXTNOmyg7sR2MbJLLsgCT7UT7Ih6tA876NNVFVzOFI9SJnu3QPdgBWY+y3JQhgo=
X-Gm-Gg: ASbGncujzo9lWERc6JAyo+f1kSYc/WkVNHjLMEmfwBOf+Ftf9ukeskKlkFZWJLfXdUn
	y10FjCU9ns2CdCOSn08ef52CEy7OjdJgqsOceF16vG8AjPXHgWed1lYK/yjdFDra5hlxq6sflSZ
	r3Wq/P08ojj0WUL7GP+wPuCcOh0km79AYbq3NOWV5nOADIMs27YC7wu/6BaEhBhNDofIC3ufyOm
	h1DNayf+oC8CnAn7YL00mFM74bYuTsaqPgljADlF4kVqeRpQKaO62lKDEsuE/PbJNT/lpWEY9Qh
	fkYH5HNU6XFCaZxDEyDWI/zaBNpgy3hP5RrB2y79HKfM5B6Z3cWW/rJDcB0ioFHttRBOuM5T24z
	9I4gQgMsl9Mycj9Aw7qHBaj9muv6y9TQ=
X-Received: by 2002:a05:6a20:a10a:b0:240:1327:ab3e with SMTP id adf61e73a8af0-240bd06cad9mr5085384637.9.1755180109111;
        Thu, 14 Aug 2025 07:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOvosArng0S7qphdecmUl0JoyeS0s3Wem2n7Seq6uzjjT1Et6l/Vmf2CGVUhXoKbpJRkW4gg==
X-Received: by 2002:a05:6a20:a10a:b0:240:1327:ab3e with SMTP id adf61e73a8af0-240bd06cad9mr5085317637.9.1755180108573;
        Thu, 14 Aug 2025 07:01:48 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4722e9c1basm435239a12.5.2025.08.14.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 07:01:46 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
Cc: linux-kernel@vger.kernel.org, quic_zhonhan@quicinc.com,
        zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] sched/fair: Save cpu id locally to avoid repeated smp_processor_id() calls
Date: Thu, 14 Aug 2025 22:01:41 +0800
Message-ID: <20250814140141.2655087-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfXz9TJ6VOFlJUW
 G0WtT/ufGfGZFbZr+hefZ7wjH0qfyHoxDu2+MZ0z3u8qekRbKcu/9j1aTlYvY5XeW+XKJL98Wb0
 UGkmrMbZO8d0lUb0g3BwYyFJ++X3BN37VMH1tr8mRjAhtyNxW4/7adzdn7jBKJfpg2pzNfOFfXe
 nXdX6ACpz1AeeCjvCeMaZrpYWbsqFM1Z5WugiTE3RqT1a3YhF8OF+stnJUEo+i97tLDHsZTrjX9
 hWJKE3elDDYvEySejczVSWaP6kUp5N/pGAJzr5EUYn/qmLgu36hLaNcBf8IkLKxB8knoT+mJ8LF
 7qtNipiZReU78NGAYJtRJKfJwyDY2JLuf8C+iRV18T/vgcPU3sylumUf8byBZHXTCo300qbcV1a
 mUQECzsA
X-Proofpoint-GUID: v6_OgD0fNBWLPkDVGY30uwMWBzs1YA17
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689dec50 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=so28Ua-aKlcwq8TSCoQA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: v6_OgD0fNBWLPkDVGY30uwMWBzs1YA17
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1011 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074

Avoid repeated smp_processor_id() by saving cpu id in a local variable.

- find_new_ilb(): func called with interrupts disabled.
- sched_cfs_period_timer(): cpu id saved after raw_spin_lock_irqsave().

This improves clarity and reduces overhead without changing functionality.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 kernel/sched/fair.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e256793b9a08..60a9830fb8a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6401,6 +6401,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 	int count = 0;
 
 	raw_spin_lock_irqsave(&cfs_b->lock, flags);
+	int cpu = smp_processor_id();
+
 	for (;;) {
 		overrun = hrtimer_forward_now(timer, cfs_b->period);
 		if (!overrun)
@@ -6424,13 +6426,13 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 
 				pr_warn_ratelimited(
 	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
-					smp_processor_id(),
+					cpu,
 					div_u64(new, NSEC_PER_USEC),
 					div_u64(cfs_b->quota, NSEC_PER_USEC));
 			} else {
 				pr_warn_ratelimited(
 	"cfs_period_timer[cpu%d]: period too short, but cannot scale up without losing precision (cfs_period_us = %lld, cfs_quota_us = %lld)\n",
-					smp_processor_id(),
+					cpu,
 					div_u64(old, NSEC_PER_USEC),
 					div_u64(cfs_b->quota, NSEC_PER_USEC));
 			}
@@ -12195,12 +12197,13 @@ static inline int find_new_ilb(void)
 {
 	const struct cpumask *hk_mask;
 	int ilb_cpu;
+	int this_cpu = smp_processor_id();
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
 	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
 
-		if (ilb_cpu == smp_processor_id())
+		if (ilb_cpu == this_cpu)
 			continue;
 
 		if (idle_cpu(ilb_cpu))
-- 
2.43.0


