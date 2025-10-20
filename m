Return-Path: <linux-kernel+bounces-861851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9137BBF3D21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44D054EE68A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615F2EDD74;
	Mon, 20 Oct 2025 22:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOTRont/"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2D3EA8D
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997986; cv=none; b=irZWrS31P3KOqopSH8vQdIUo9exeCaDbXX5fZepvOoTfyRmZfohavmw1MevUGQM9u+cGBJN8BchtgWunpgKeCfCwm39oRGhKL3hPAO4ADDXv4aG3tdYjibg7cx9H82KnIReDVVAKchWuOtInuacRROTtEWtJIxgze17M/C2P0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997986; c=relaxed/simple;
	bh=XwfxJpkuKRhpMHP25aeZ14Z6h+rFhKdoC0myaWRs9Ng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IH3zZG8nuxGm0+R50fkOPaPoY2B767CmMQVxcyzGCvM/jfqcBQikSgrCY6FVN/R1ckRWL6UVGekkkIPtDG7y37bOq6arOCtzkD7A8YbsNvy3uODX48RlPZ6XjufzLEIrKiz4I9vIn3hQrIC9Teb8kNmEnwn9IT+HygPhLn0529g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOTRont/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b67684e2904so3412513a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760997984; x=1761602784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gXeclBXp+p/82bfQPtilxTPOoghHByuuBPmA7Z/irA=;
        b=SOTRont/OzeulKH+Ixnx731L36pZodPZWoNkIaC77q/Zwq0wgcvosJH4RDjtF2uWDb
         HRqKg3B7btPggvumZmmzLijHRQf7P+XgOGEICT64RldTvt4jhzJ+MTDq5mdLXgsXYzkJ
         lPr69DL3Me+Yo5Mp8MxRLx5UD/f4KvP5RTOX8t+fD0RdNwSSzUv9lJHViptsVViKJxLA
         Eg0SM0Zf67r99OW889Nzi7+HWSrews1NCBh8n03otKJ7sZkRM9+54X8yFDbX7o1q1XZX
         CTpCVXsyT2EE/n42hjFikoSGzEaKSVwZ/sWUhFjmy17dxmdrS70a9mrYDXRxENWQ+CIX
         zzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760997984; x=1761602784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gXeclBXp+p/82bfQPtilxTPOoghHByuuBPmA7Z/irA=;
        b=MtVPvJfLJuCARy7haNLdzsZTATH5LpB69qjZwVANEY/WqM4uuKCOgIcy4a24MhGssU
         O6FO6FbBIAMN+sd6YA4FIexVCdVEMFmPxxEmea1whsTs892tg9ceT3CBX7lZA1tau/D3
         iDdQfV6bjspF8fBXJRc44m1gVzY2zfsaaVMyR1xBCXErClB+2x2XoUCF2KCLm30DYIpa
         TJiHuHqd1ck4djdj7jwJd3sA/PmVHtK5ca8zlbZGxOJd4SuI2cnDu9PE+Qof880ZufU2
         SLLZ5mCkXw9CPS4Ph6wqpqwmLufotQvXLhLEVKUtSUrEs+20yb3diO2m4B5w49YQzANM
         hVwg==
X-Forwarded-Encrypted: i=1; AJvYcCU6yOEijJS6CBQ3F3c1Hp9LCLpf7/Y7kkQsS/hmQCNaFz8Yfu8wplf0co9lGqTvrOHm46t1eNWaNpih5Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx99pbF8Vj5SnT27RrkYbODidx+solfKdVBiYV9GbuG1i6D6cPT
	rD8hi7biC+ElHZk7QEF+eHtH4Bx8LVp2u20OxdipTuEoFqrOTvCS+hKJ
X-Gm-Gg: ASbGncticASlUK6OFZZ9D8keICEpDNozDR2TSSpkWvB+qIlsiadjUrPBm79bZmm+iCC
	Del1y6EEoS4PfKnCG6Y3wKPwnhVZKcshArupsrpDTk5/KRhVJINzzhUiYCinnQzuFLLtwU6SDCo
	h23bO0jDLXThXMHwAD4khsKmc46RxTLu0D1hC9LojCbP4DI3KPuWOHQ5AxKij6ap5nM9nHrS2Ie
	P6yEUMbjSaMg8QD5Ei3Al8dRn2NzinX/mBc76MsA7naiewWxu+BOPclvS+MgI24/ig1UTV8elnP
	GYzg/nMoU4SVlgqrS8iyvzF0LnYOXiL+ITufsr/OULd13uwqVoZFFK4dV5KvpU8Wg/snWljJ7pc
	4NW2qaVm9toI1rrElu7zocG4S9RGk7ymPbEYYs7zaK1FvEE1tGH3CSSs4fzDoRLCZLwFOucCx8d
	jW8ZRO53+Iiri8k/DM5ssvKwiDAJTLnR+Ob6vDUvQrq29n7cTq1UKu7YMAEvzkr23WpaynIoPU
X-Google-Smtp-Source: AGHT+IFdzHcDeIueYeHoyFWOW/jaiU11HxIcfnBthDUJXild7yFBmKI/g7gmzJXllA5w0fq5gf9swA==
X-Received: by 2002:a17:902:f642:b0:28a:5b8b:1f6b with SMTP id d9443c01a7336-290c9cbbd49mr189078095ad.21.1760997983958;
        Mon, 20 Oct 2025 15:06:23 -0700 (PDT)
Received: from linux-dev.dhcp4.washington.edu ([205.175.106.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdee2sm90216975ad.92.2025.10.20.15.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:06:22 -0700 (PDT)
From: Aditya Gollamudi <adigollamudi@gmail.com>
To: mingo@redhat.com
Cc: adigollamudi@gmail.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/sched: removed unused *cpumask ptr in kernel/sched/sched.h
Date: Mon, 20 Oct 2025 15:06:01 -0700
Message-Id: <20251020220601.176639-1-adigollamudi@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adi Gollamudi <adigollamudi@gmail.com>

remove use of cpumask ptr initialized at the top of the mm_cid_get() function to nothing.
remove initialization of cpumask ptr in the same function, "cpumask = mm_cidmask(mm);" because
it is not used later.

Signed-off-by: Adi Gollamudi <adigollamudi@gmail.com>
---
 kernel/sched/sched.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..d5d943681bf8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3710,11 +3710,9 @@ static inline int mm_cid_get(struct rq *rq, struct task_struct *t,
 			     struct mm_struct *mm)
 {
 	struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
-	struct cpumask *cpumask;
 	int cid;
 
 	lockdep_assert_rq_held(rq);
-	cpumask = mm_cidmask(mm);
 	cid = __this_cpu_read(pcpu_cid->cid);
 	if (mm_cid_is_valid(cid)) {
 		mm_cid_snapshot_time(rq, mm);
-- 
2.34.1


