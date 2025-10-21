Return-Path: <linux-kernel+bounces-862455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC6ABF5586
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BA23A7A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91F320394;
	Tue, 21 Oct 2025 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YRwpxmaY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE011E5B71
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036346; cv=none; b=saajtUIEQ7CrgXNgox8UYA9kZkOeFziCiUlGX7eyNR7ROXB3WxMISEU7FDGmB0GZ4RWF2b+Cz7/UpxezQ+rTRd6J7Rc+v6o3sFdtM+0gS3bgCUneEvf4DFyXJGbHiL4uXIUHGLLk2U/p4Afq056watXJkl83bkAYyKyNhuIGL44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036346; c=relaxed/simple;
	bh=e8OIztMbIriYuc5EqoSW+bjrlPbXrjnNXj6AVSTUj6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c6qDFLNM1qJ9epUXIXVmuFD1H/WQnZ/LX6odgm2LpeOQwsSUuiMrRfxfU0+QO5vTwqx5lURL5ylnaOt+5+Sq4G7V22RYnnYnkNBSCK/fgbp6UMpkZmRcMVwpZm8YIdbHEu3JfkxsUlelkrUqzelJ+NvbsgKEVI/Ilo8Ref+fegs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YRwpxmaY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8MSg7010752
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Elhh+Em9NnvOSVsDt7zbpL
	za4b/6zrwnAqOm1QlEHSA=; b=YRwpxmaYCmY4Dzc2B7MSRRIeNjGn0+oipPBvt6
	cD51REKwRoGgWo4Oc1/e/w/XYVSbKXSGiMSt/Fv9MlkXV2077iN0Ju1k9trXaSqU
	I3CYBZQTSJSv8mS6u6heoulaTKGxOKtjAYrWEPJrFtwd0UuBBJQyltXiKij/ExMu
	+f2P/xB7gkSVshpRNgziOoaAQaQBzHJ1IFwR1hsbw3a9Hn6jbB1b0sYh3EP9A+eY
	piBlV8xAYNYM+VEBu08vy2cpsOgeNtz2hNfY01+gadvtQYGeUaZf1vHzYMxnzBPr
	TNYvMo8T45S/5zloZ+L27IwAYV0X1dDj4xHEhZs6xAqTyh3w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wtget6ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 08:45:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28eb14e3cafso107242025ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761036343; x=1761641143;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Elhh+Em9NnvOSVsDt7zbpLza4b/6zrwnAqOm1QlEHSA=;
        b=SNELChJ8RJUvNcOM0yHjY7dwJnR0zPuX3pIzBYDkd6swOyqRdVhUUc4SmDS6PDbQEi
         3e1Giu+H7alF6HNPWiFlb4VUNEqXp/BvsWQAkOslR09KCSNjgXsk2e+lHgI2UNRDmHII
         8YMwVwsAw1Ker3WcUW6XL+buB5lXctmIPzVNqXtsIBzeSl+O0xg6b7Pn0TLPIAdbut0r
         Pbbisw6fA60Fz02vgny2JJiUp+gXmojCru4Wmb17s4cKDl2xRMqWZgdhqdw7RmHE0pKb
         D6eG9uouSWodMXNB/PyRF+tBd0xqaW5xYFUutUqAz+IqTxdBEbFNbKQIuNG2fru1Bovq
         cEJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe0VN4Sr0floFjdh5Dx1Z/SlhGGCHdu9/e4wEgmibZQMYkPDSpTrGh0gHp+jCAkMBQF3k2J8ats5DGSrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gJu/8kNuLUfG2SFgYEP89u4HppLN+qL22THiKEXZsFtmMUJz
	Ul+/VBtnTRBg8SI/tmi1qDvse7LNgTQsIPjjelv0J82J8zJmNzUGZK5bK0UcdeP14P2XkiDkprk
	0B43MY/WDLh6YFyqSx0oXmeGSLE1vnOXm/3cIbLAXwaS/1qH51ni0iZOsPS2tLIbg5WU=
X-Gm-Gg: ASbGnctLtIvy94AA56NNpnNWns8yU7GmQGrmFVOnUKcPYavssBcpcR2ghjoBAu7KDMt
	2pAV6+1ooKh5Wq7AiViFqEsHYMXBNgqUg/vbhFtgcQXh9V90btPYIiI7xOk/l0vGpOUFaDCsTAf
	X+LFwYxIw94Fiqe2VABEPw2gqdBc+0STKemGQeWs8N6kJ2fnuOHLhZn1EIT9VZG8uhDnrOx8OW/
	6hGYeCIIZ/vRXyprdP7ZYZjxtT9bDqCbz512gRiy1rM1emtl+fJ9yjRa3F4hvdAVZPle43gAmZN
	2NrOKZMSMeba3wK51YGhzCU6kwY7j00mJzJPKxSZA//LBjs/nOjP/6fRLRWh61YcPZcMn8z7mBT
	IKh8uy4rtm9weuo0NEb8UtA1qSB+vf8gSqZ0E47t/cnKFWT3YzuLCRL/uLDEB9QiYHdwBLiQN
X-Received: by 2002:a17:903:1a70:b0:267:9c2f:4655 with SMTP id d9443c01a7336-290cbb49970mr225048615ad.41.1761036342674;
        Tue, 21 Oct 2025 01:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeDozYIzXs+r4izATtwH8K7/YDy4VBNwxTHm2BbitvyzgRq84sjpyhEpzvedomP6vHq4zULw==
X-Received: by 2002:a17:903:1a70:b0:267:9c2f:4655 with SMTP id d9443c01a7336-290cbb49970mr225048285ad.41.1761036342226;
        Tue, 21 Oct 2025 01:45:42 -0700 (PDT)
Received: from xiaozhua-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d5868sm102080565ad.60.2025.10.21.01.45.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:45:41 -0700 (PDT)
From: Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 16:45:25 +0800
Subject: [PATCH v3] coresight: ETR: Fix ETR buffer use-after-free issue
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-fix_etr_issue-v3-1-99a2d066fee2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIACVI92gC/3XMwQ6CMAyA4VchOzvSTRDGyfcwhowyZYkwXWHRE
 N7dwckYvTT5m/abGRlvDbEqmZk3wZJ1Q4z9LmHY6eFquG1jMwkyFyCBX+yzNqOvLdFkOEgs4NA
 2WCrF4s/dm3iweadz7M7S6Pxr44NYt/+kILjgCqRuclEU0GRHR5Q+Jn1D1/dpHGwFg/xExDciI
 1ICZoAKNZb4A1mW5Q2ept5h9gAAAA==
X-Change-ID: 20251020-fix_etr_issue-02c706dbc899
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linu Cherian <lcherian@marvell.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761036338; l=2039;
 i=xiaoqi.zhuang@oss.qualcomm.com; s=20251020; h=from:subject:message-id;
 bh=e8OIztMbIriYuc5EqoSW+bjrlPbXrjnNXj6AVSTUj6E=;
 b=CT4tBWJtsym3+buKoCXEL1VaPVn2qIEfnKDDcw+xbFgf4Cjd/HGjUjiQIXLmXeALYT5lZTIEC
 okfiW67jkeiDEiZE+7hTO57vbWDSIBB1DUtoq//7Vm8sQbfv9MBFpVZ
X-Developer-Key: i=xiaoqi.zhuang@oss.qualcomm.com; a=ed25519;
 pk=zuq+lkjngHYEDk6qmD41kiqDaQuURxgU/sjQuARnCrs=
X-Proofpoint-ORIG-GUID: ec54aWYWP_UfRTwF6vtNEj0ocajSaAwN
X-Authority-Analysis: v=2.4 cv=JeaxbEKV c=1 sm=1 tr=0 ts=68f74838 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=oKJ9ntOD2-YCvPZDK-EA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: ec54aWYWP_UfRTwF6vtNEj0ocajSaAwN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE1NCBTYWx0ZWRfX57tmxJnnfD9Y
 rO0ZQUSfCSzShrYcn4iXR3OSGwSiFEKEP2KB5li0Sv+TZp+WgyAxTjm9HfYmGyljUoeXEpkesQu
 /d5v//SXWMXshrZucr0yHIN3ePM6/vqf9TmFaq+SXmKXkIrwqLZdekgypwCOtzX2iovFGzt1Evs
 i9iz54dgt+HgVBZhzE2QJdXk1YpZMJLU9MwYv0YiAiqOeKVbf+BAtjNUvkqE5wNe3p06s5rDxCR
 jVv83fNSIePato/mrYyzA32xK83WFy1zNVqMyBTmCxh67TBZZs2NYpxkcsfnp2sDmkahuOcdJaC
 B9qVBbYIqCmOJQVI9GqtjGh2sI4N4zP19mGBPiSSNiAvDZg0Kpgp013YwSM+c6vUshj/k9hsS4b
 XHJUV0NP8j/6x5rwu52pFbDpuJzEEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200154

When ETR is enabled as CS_MODE_SYSFS, if the buffer size is changed
and enabled again, currently sysfs_buf will point to the newly
allocated memory(buf_new) and free the old memory(buf_old). But the
etr_buf that is being used by the ETR remains pointed to buf_old, not
updated to buf_new. In this case, it will result in a memory
use-after-free issue.

Fix this by checking ETR's mode before updating and releasing buf_old,
if the mode is CS_MODE_SYSFS, then skip updating and releasing it.

Fixes: bd2767ec3df2 ("coresight: Fix run time warnings while reusing ETR buffer")
Signed-off-by: Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>
---
Changes in v3:
- Add a fix tag for the fix patch.
- Link to v2: https://lore.kernel.org/r/20251021-fix_etr_issue-v2-1-80c40c9cac8c@oss.qualcomm.com

Changes in v2:
- Exit earlier to avoid allocating memory unnecessarily.
- Link to v1: https://lore.kernel.org/r/20251020-fix_etr_issue-v1-1-902ab51770b4@oss.qualcomm.com
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b07fcdb3fe1a..800be06598c1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1250,6 +1250,13 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 	 * with the lock released.
 	 */
 	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/*
+	 * If the ETR is already enabled, continue with the existing buffer.
+	 */
+	if (coresight_get_mode(csdev) == CS_MODE_SYSFS)
+		goto out;
+
 	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
 	if (!sysfs_buf || (sysfs_buf->size != drvdata->size)) {
 		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);

---
base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
change-id: 20251020-fix_etr_issue-02c706dbc899

Best regards,
-- 
Xiaoqi Zhuang <xiaoqi.zhuang@oss.qualcomm.com>


