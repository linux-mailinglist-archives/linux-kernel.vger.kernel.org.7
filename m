Return-Path: <linux-kernel+bounces-846362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41FBC7B13
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 09:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E434F2B99
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 07:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9EB2D0C79;
	Thu,  9 Oct 2025 07:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R2hqklOQ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB42BE7AF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759994644; cv=none; b=bD9JEdGJi2DAHK9sLSOeM65luDDgaL0JQvRvQs++VOKP53IzjffYQT4jO4hGmVkQXSsnxeZ3GyCvZ1Ey1iDguuCIZvlIRi32tZyl6ONAFlFec6OHoE4qBQffShNomWNRPz3w0hhUuR/T6+YfAfQXyvOzhFGnLuC0fRTwrb9Vh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759994644; c=relaxed/simple;
	bh=xFhAOL9D+6VbluHAY5dJIKgDyRUqAMGuNjlcR38sUoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DmdvEfptngc0WutIdQ4TgTgRFCafrBhBwNeBsvfgol0QIpdsgFLMDNUDOTR38BoNYp3oIT8h6bKV3ghL93II/ypSyDnDjQcM+qmDp7KqFMoAAahZ3A8FARfsGY/PKOMsy027wCCCXp7EDBu5ZNTfqk9Wd32N1n1NKLoXUd/9bIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R2hqklOQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996FSVo006842
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 07:24:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Mxv8YyGMVYgIKFtVyXoaJQ
	aGgEgwcl5eDLsadDRJ2SE=; b=R2hqklOQGwIx+ud1Q10r5U0owCET2MxP1qxcdI
	mHqN6fWO4OAaz/CJycbtXHXH/0yyoXK7SPqfmW6Cbwt0vPA1BU/uJm9crnHiOba4
	Ob7fCIVpzbBz1IUfOKcOMgSA4VDfshDuLu5/YgIX/mZ491fQWODXlZbhk+pAN04e
	X8wc1LDEqVJ9KwadHAKusmqgyc6SupvDw0Elt0tw387Wme8W81T1aBJUDqAsOYRq
	WfbmhiBeyGHasyItz8fLT4DRooMuX5CjMIOUp7jKQqL+aBThynlX/5tOnn9HY3G/
	1Bi4ebccfiC7+FPmxtHTmygVSPyLWUFUZLsrgzATQ0t3BNUQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4u1v6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 07:24:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-78104c8c8ddso862037b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 00:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759994640; x=1760599440;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mxv8YyGMVYgIKFtVyXoaJQaGgEgwcl5eDLsadDRJ2SE=;
        b=YzhKzpIUZMAaHDD1Ycb6EOZf3iulLC6A0huQRsEnL/9QxRpAFo2UkandporIrcpuac
         kT4Y9lElbLmWVX9FX5AGcL9l9qejw5/OC89eH8DvATn3huoeIJc6JKcX5lqOOEc9MK95
         SaeLULyKzMXmi76r95dCjeHy/8A+93FlmnDGZPM7X+pYBR1HKMMvb92oAF6aBH1uW1fZ
         JX7mj07VU/MFm1Zjb99voRsAFGD4K7ul9v5bDCBBRWEbDontBt4MEN46bLK6H1gU9DMh
         7kc2Vl+OxE7qAwJ7FxEM/MJJ7W6i76nC+rE8qvl3h+zK8dbceVATUq/NfjUHBtLTYtRF
         ElWA==
X-Forwarded-Encrypted: i=1; AJvYcCVaX1Agf4oYcYbFgLYDMJDWSaYyXvbUfBgMC2LdY5xBHZjbScqrF9MCuMhhgUymEcc2T9wfqQw/g+lkJGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwciiLsyD4oQr6LkCTI5efN/6Ef3I/yozwY2/t/yvKPhZI6iFVT
	K6psTA4UyQwu9wSIyTBk07u1sqPaO1v8gxrCl58mPmqiVzHUNtjxTPa1DpiPwz+8UFxqBH8Xx18
	Rw2sKXsTl4pKD3KkpMcCgMSixauud0qpDomSdC7uo4gfbnuJuFWicYKQWg/nEx//W8+VR1yFJ/c
	KtOg==
X-Gm-Gg: ASbGnctGBkO+09SewxB+s4mYPEycGVw0ZyHSVDztJHR/gM8txw2lFCg8sAlp79PisFk
	Z72PkCTw5L858oX5O28JxbQJCbty8c8CbI4nSLswdCy9PEK2g/LuM1frBaVFzD3UDx+tLhoZj/s
	p/EbTHdOV6ewqWyPtdzPbE2Yuj/MlFkaadfrgCo0zvE6MzhSjcYH2MwiqNYMzrCDHlGUeUevh8O
	8dKDeixToI2HrFJPWTs7qnirmgWpD06ceeLE/IKOBJRkLsC04disvOhx+wyKwowC/tyH1CcPWXp
	/HW0FXuUSqZD7GPjXtZFpyaobTgF0otdvXpNUQJ8UtSBBUh4DI9C4DLyqXhuydEr+kF8x3A/ahq
	iqrL7IqA5zL79o2LGaKvnDw==
X-Received: by 2002:a05:6a21:99a1:b0:302:c800:bc0b with SMTP id adf61e73a8af0-32da83e64d7mr8234578637.44.1759994639630;
        Thu, 09 Oct 2025 00:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2f9GN8thHThus6DTKRYSTOTh+3cOhWWX0cQQgCUPBvLH/K4oTt8oWPcQ5HJM1Jk08nIqlfg==
X-Received: by 2002:a05:6a21:99a1:b0:302:c800:bc0b with SMTP id adf61e73a8af0-32da83e64d7mr8234540637.44.1759994639143;
        Thu, 09 Oct 2025 00:23:59 -0700 (PDT)
Received: from hu-tengfan-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099af38a2sm19935370a12.11.2025.10.09.00.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:23:58 -0700 (PDT)
From: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
Date: Thu, 09 Oct 2025 00:23:55 -0700
Subject: [PATCH] sched: Recheck the rt task's on rq state after
 double_lock_balance()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-recheck_rt_task_enqueue_state-v1-1-5f9c96d3c4fd@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAApj52gC/x3MQQrCMBAF0KuUWRtIglXrVUTCkH7tUIg6k4pQe
 vcGl2/zVjKowOjaraT4ismrNIRDR3ni8oSTsZmij33w/uIUeUKek9ZU2eaE8lmwIFnlCofQD8w
 njufjQO14Kx7y+/+3+7btWpyFSm8AAAA=
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-arm-msm@vger.kernel.org
Cc: kernel@oss.qualcomm.com, linux-kernel@vger.kernel.org,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759994638; l=2580;
 i=tengfei.fan@oss.qualcomm.com; s=20250921; h=from:subject:message-id;
 bh=xFhAOL9D+6VbluHAY5dJIKgDyRUqAMGuNjlcR38sUoM=;
 b=gLDq5KqKJT7Lpw92ZpO98N2DE5AjJ4EaqQphcPjfDP/Io2R/HMbRaNE/Jz7vs+gO4Ske4Tfnh
 ee+5AA/QoxeC9fWjhtxt2e5rs01SO9WtkF+tfsN7IwVzpog2yC8Veqy
X-Developer-Key: i=tengfei.fan@oss.qualcomm.com; a=ed25519;
 pk=jIu6/WoJgeGAd0Nv7f7DYqUogDnHT8kjrQZuDeAApjI=
X-Authority-Analysis: v=2.4 cv=Vrcuwu2n c=1 sm=1 tr=0 ts=68e76311 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=ObOrrNpX8wvxKiF1MUIA:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 3LDuQfDcX-kiPFHS4vh2uDN-ii3NAE1j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX23+HxxnuF2c+
 mNKx02NGGRx8gLdWkJ0a5mlkA5jEuAVAiF1GZ4KySlAreFlBzziR73s5lg0JFJYxIvv91p2m3p8
 3BZsLE60pViu5ToU2QQEWbRRzomghioFIYkxLK5+o8p71gPM9vcl61e+IHsvHxq9ztcNNube2WE
 A6sUbDa/0BRyHgCSU42/fbHrjEOlymiI2P53LiN738/Yw1QlYsb9RxbUzxYPgh2IUoKDvjtdbOM
 EDMZc6IbOXqU2WHBiTwquaWRgNcxXwSBh3Is5xiICPz96QpZ+B9hh0hjLo0NTwBkwPZH4Sg9dDe
 vy9QObOobZFJ5dcMgIfv4PXAl/wlbf163/6YZI+8BoGGpcfBLlXCurKTSgEr4pHOUDu6mnhpfHr
 mcRYdiwO/8qe23BT/6FODUHzUvGGMQ==
X-Proofpoint-ORIG-GUID: 3LDuQfDcX-kiPFHS4vh2uDN-ii3NAE1j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Recheck whether next_task is still in the runqueue of this_rq after
locking this_rq and lowest_rq via double_lock_balance() in
push_rt_task(). This is necessary because double_lock_balance() first
releases this_rq->lock and then attempts to acquire both this_rq->lock
and lowest_rq->lock, during which next_task may have already been
removed from this_rq's runqueue, leading to a double dequeue issue.

The double dequeue issue can occur in the following scenario:
1. Core0 call stack:
        autoremove_wake_function
        default_wake_function
        try_to_wake_up
        ttwu_do_activate
        task_woken_rt
        push_rt_task
        move_queued_task_locked
        dequeue_task
        __wake_up

2. Execution flow on Core0, Core1 and Core2(Core0, Core1 and Core2 are
   contending for Core1's rq->lock):
   - Core1: enqueue next_task on Core1
   - Core0: lock Core1's rq->lock
            next_task = pick_next_pushable_task()
            unlock Core1's rq->lock via double_lock_balance()
   - Core1: lock Core1's rq->lock
            next_task = pick_next_task()
            unlock Core1's rq->lock
   - Core2: lock Core1's rq->lock in migration thread
   - Core1: running next_task
   - Core2: unlock Core1's rq->lock
   - Core1: lock Core1's rq->lock
            switches out and dequeue next_task
            unlock Core1's rq->lock
   - Core0: relock Core1's rq->lock from double_lock_balance()
            try to relock Core1's rq->lock from double_lock_balance()
            but next_task has been dequeued from Core1, causing the issue

Signed-off-by: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
---
 kernel/sched/rt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7936d4333731..b4e44317a5de 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2037,6 +2037,14 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}
 
+	/* Within find_lock_lowest_rq(), it's possible to first unlock the
+	 * rq->lock of the runqueue containing next_task, and the re->lock
+	 * it. During this window, the state of next_task might have change.
+	 */
+	if (unlikely(rq != task_rq(next_task) ||
+		     !task_on_rq_queued(next_task)))
+		goto out;
+
 	move_queued_task_locked(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;

---
base-commit: 7c3ba4249a3604477ea9c077e10089ba7ddcaa03
change-id: 20251008-recheck_rt_task_enqueue_state-e159aa6a2749

Best regards,
-- 
Tengfei Fan <tengfei.fan@oss.qualcomm.com>


