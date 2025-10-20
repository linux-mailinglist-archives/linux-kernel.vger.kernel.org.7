Return-Path: <linux-kernel+bounces-861869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22491BF3DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E184718A7261
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FB12EE263;
	Mon, 20 Oct 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmDaECqO"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E962F0692
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 22:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760998669; cv=none; b=pHMBmclm7mASZXYlQ6RSbO0JWGrZuBe9HCRJIF5hGv2RGnJGTr/8NFI7pBZ7xl1EpcGmvRzaOtKVJyZ4cCYw2XQahQ+5JcFRjxMrYs50K3v9cY6OYc0kaFHs2rOJHTGuJeMcjhq8yNCHzHgR26FgBvEFbzR6D/p5Zo8Mn9Js3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760998669; c=relaxed/simple;
	bh=dqLUTQtrogMRwD9T7RlSJAgfRt1ty6J00kuax1CPyrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djF17LmBB5gp6Y6nL1wB58Vel94s6z6PJZJ7aHXEp3UuwxuGnXvKFNu3PKNcVyFJ7uFAARWQicXyjznv/kWrk89afu2vPJ4uJYTAFhpSgr8/Y9yEQu/GNYGWfbLA5vKdn/fZkM0dxpj075qTrc8yiWjvnsTbu7PuVxByl30OG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmDaECqO; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso4343948b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760998666; x=1761603466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYe+HLToSqnPHzo5qQ3tUxhmTMS46tnuV2MTLktf5XM=;
        b=DmDaECqOQd4vbeCuFm41tPsPlLsjRJQ6CXxm8Ic+R82IpNghG/Fd5dGm0lWV1iaO0p
         f/RClxZi86YylYLfflL1CCnWc9aHE26Hzggfd2l0ttljsC/3tmcpo5yTy+Gvc9eYduVv
         0fFCmDeKk6L40865vxqEOupcqvmBgkxBOItGH6xlzIB42uSraY5mzQ/wqt3zGKiJ0KIn
         NLeW57e9mesHnacHnulAsMuKTw3K3pGimVdmrxFUOpXankxSJjCcYsH5yn2S8LT5oGeK
         9DhZEqG4ML2pKI82LR26mbZhF2Z6dpT2k+vhK0tDmk2UrGbh+b8mb+Q711z9DVSXHoE1
         qeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760998666; x=1761603466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZYe+HLToSqnPHzo5qQ3tUxhmTMS46tnuV2MTLktf5XM=;
        b=TlU2lcrS/dgr1sfTr0YEqMKntBJffXfsIVRCHq9wjlGD0JOXIDOXAJT9s0tuPkSlYt
         qdQatnmohWPcXWszFO1b4WNJewLFzW9Z5M9yCYBd8AG3uPdpJDJGCnrl0FB5uZrGJFfd
         PLA2qOBIJLNUF91q80a6UhVB0ktLUbxH6DA+LS0UIUEIYB2IFR4QnkHI/Mkfe8sBAdh8
         lslZW4sM9+NVj2LePk6gex6wVoxhrnMMYm/4DBBzmlfNXuLFZ2M5YYcqgFsRnniG0Lim
         0HWu671IRvZGXqanvGNand++jy6GtWuqeRWJQm0qOQt0zlJIcVd9JOJ6Ea+r1KosgyLy
         BJyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX/lhYLllEBT+ouNCI2yAIQbV8YikzpKuCach/s2Ilg1gqPrf3movMGElHLkKrd1x1go65Ls/phGPgd6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzer8ol9JIpAOP1gn3W+1oADOar4loiw6uI/yVUSnjpVIBsJaWJ
	BtcMzMa5j683Grwq7FIaOPtu4lB4kuVTTTuctYqiZKZa20XiddzJ8QJ5
X-Gm-Gg: ASbGncu91ELGSSZMg/8/8EdUNloChLiAt/XBoAYAwkGcUsWx1Y8qg62SmJn1hpayv1D
	bAvHhcRZ9QYRFOV46R8wQkQWcZOwkg4qOgHR3W7dVs0AsyvNSPtanElwggqOAS5FLxV4fxNIp0u
	MeznRIvGrLmP9i1DT66IZxmBcVYHdgCTbNrqX9JYt/EilVN5fgWGeFRqHRVnjsyqGTvTtHVm02C
	29r2OZMSqIuRsAW+xY0W0iOsXToPi/2sBShA5BRq3BAS/tAQfL6vfgns90IoFPk73jfH2Ez/e/d
	vZ5527OEywMLdzvOjjVGc/k6HNN2thm7cief7dCRzQGccYfHgZHdf5gDB3lrKd8IZacnKywd5Ym
	iUkPcpzKVbpSbM4tf+sFc36z68XpE4+xkWB/UYSAPpa0u9POhdenBKMYs63ancO/Lrhm4k6ESSU
	SOW68L9s1T6Y/o3F/puLAQF+CBF7p8riKlyhUe0yyoYmJDlsak3EqEhXaNi5ya67FEPvkUYV2J
X-Google-Smtp-Source: AGHT+IEwAV1H1jekOCC4ydVC+dRMSVyEabfMHN/K6LLVUceoYcZR+5J3fPFE3xeXZJ8nexnAecjFUA==
X-Received: by 2002:a05:6a00:94c3:b0:792:2dd9:d8e9 with SMTP id d2e1a72fcca58-7a2208fe6camr19226459b3a.4.1760998666322;
        Mon, 20 Oct 2025 15:17:46 -0700 (PDT)
Received: from linux-dev.dhcp4.washington.edu ([205.175.106.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15985sm9617030b3a.5.2025.10.20.15.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:17:45 -0700 (PDT)
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
Subject: [PATCH v2] kernel/sched: removed unused *cpumask ptr in kernel/sched/sched.h
Date: Mon, 20 Oct 2025 15:17:28 -0700
Message-Id: <20251020221728.177983-1-adigollamudi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251020220601.176639-1-adigollamudi@gmail.com>
References: <20251020220601.176639-1-adigollamudi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adi Gollamudi <adigollamudi@gmail.com>

v2: fix formatting and style errors found by checkpatch.pl. no actual functional changes

v1: remove use of cpumask ptr initialized at the top of the mm_cid_get() function to nothing.
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


