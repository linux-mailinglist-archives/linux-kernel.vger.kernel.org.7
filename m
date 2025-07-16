Return-Path: <linux-kernel+bounces-733754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1773BB0789B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AA23B780E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB62F5469;
	Wed, 16 Jul 2025 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha40lCp2"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1292F6F80;
	Wed, 16 Jul 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677330; cv=none; b=dflcNN0+ospZFPQbEw/fMTRenya2tnYO6VMn/fkrPf9S4Ev52UswNEjFAIwGuM48gQ3+sQr+ZuiQ6ipljJhIl1HkXTmobT3ycGGlzycTPvmUAHAOgr1aY+oteZMOIwPv/UMMJrZ/dxP6PBFb+bKz+0LxlNCHLYOFXF+AexghCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677330; c=relaxed/simple;
	bh=8Tj+JHkTNEx+hl3qlKVGHGmM2l+ZAe08j4LiXZhrd0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LpdMJeZ/4qsE5rbIcA8AnMo/88+mb+hDML+d6KIip2fVWYenc9rnb7brQfxNDWPzWIpk0Qpm+MboSBevJ2ERARL1fUugkTV5q/tI4nhIRMT9h4xMKISFlQL0dLapvct+Q1Td4neEQ7e/siUrj2gDm9dNmH0883bkiBFYrGW9BDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha40lCp2; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ab58720d04so31654761cf.0;
        Wed, 16 Jul 2025 07:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677327; x=1753282127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NfhJQfY9tw2Iu7jEp+BpHBNpDnlJcB4F41a7W8IB/gw=;
        b=ha40lCp2awDr+dcTMT26nit5WR1+eeLbWlHB7xV+9/QA2K4zE5N5uyLNbbQu+i/l1s
         qC+o4n6dccBJcoNxtjOkJn0GyvRhpCqpFgwmdsH8u7vow8Lt+j2/a69+PyZcNvu0u7+q
         Zi8p2sZ0GPoPQJUCicAXmixP5MekylsPY20SxFCgrMFHNcKsWnTpPZSVVq/9OX9x3XDG
         i2q01XIyYvfK7lMijmu0CT2AI+CeIw2cGCjX8KyEsXKVusaIKx90UhcaYyGvKO1wDOH7
         ZjPBeUcb3WVzx5SdWejBKhoo2Sg5Xt7GvF9+g0gdAXKLGvC4Wak5IklhpzPwxTkgqXoM
         K+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677327; x=1753282127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfhJQfY9tw2Iu7jEp+BpHBNpDnlJcB4F41a7W8IB/gw=;
        b=uOx0MEbTvwW0IKxyAzw5+mIUjfmAjLgtn4aWaPVG5SEb4XOXvs59zUhYk83V9l6gRo
         AkbBp/ZRB5jTcyT8oVpuafIXhiQ6mmbUcRRWcaCBkfj5Kyk8FKDHpe/ALVKPtHDwufw9
         UdN+BjH8xtcgqqvaArUcMdQLy68mNoc+qWcmzjAMonutmWFeCe1fbD2l1mz/E7kmy722
         oxGyRaNf6SR4kjwV1UF6LpG0FIS0fqK5UDavU1A2X6a9DXnvToES1jarlgrdlf3m4iNU
         QCmz/uVvK1mCUioyKBoSPt4X1xe+QO5Rmuh0Ra+7LjnMub0fzITYKarndizqAjbMoMiV
         Wqpw==
X-Forwarded-Encrypted: i=1; AJvYcCV/Aaf8d5HcFR2iL7XoTom7kGGOihbis/OD204laUj7BQ61Z7IDVHhovTWUtzkPbqSmZPaOWntXXIInODM=@vger.kernel.org, AJvYcCXJy/eQpOa81D1g2SUsXHOg0tp4vVsv92aRvWGUne4tkcg6HYzwHYLNd0sZxRfUvOt5jVLM3i+Hpe3BtprUPo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXn2HrFY94+NrdA1sJDk/iwGzZCWCWqx2gnrIcXFL3wFqsm1sM
	kdE78KOW1WdklU6t016LQvJzWn4tKi6sQN54iC3cV4azqhbFt+OUPNuv
X-Gm-Gg: ASbGncsWbLapZHbuIcSkC2MzJz2m+WQUntbjIqWWSyE5nz5wKNNGDrUWhf1f0B7lvCv
	pSZt7ZtUONpZnDA79u2FiwCe/L+hQzrjZIRlIcb5tzRB2wc2j1oBejUG/tjlg92F6le//wVHvo3
	kHW2KstzZDJqDw3W61wxwSeX7UoNle66lE2tyveQn4JUtZyL2AxbY1eIKVPcKT1DgXCvPQDb+ap
	w9wQ08+qrbLHGku/e3upAY9JKuBzrvcafHtxSWstW5fU2FhHIBmS3FGx/1V57DPiw5xa48/5Xr5
	P55gtAuLryj5j8eglMLq90MA3Soo048iK8ih9yO8hiKCcLIqwZn2vOm0CbbnXz00jr7INaadRZr
	gbTWbGCgaAWrp+gAQD2qWhHRHQl+WcVn7pHKs6Xt36VwmLPlGgobxl/q9es5NkheKInmyFz5pHr
	cj4+vh4wn4RZbB
X-Google-Smtp-Source: AGHT+IGfkNiO+nudRtiBFeJqMkyuXBbTQ4zQecyTmX4HX7T86mgVvwL8zqM6boelNc2dviOijWaapw==
X-Received: by 2002:ac8:5d16:0:b0:4a7:6586:8e4 with SMTP id d75a77b69052e-4ab93dbd972mr46510201cf.36.1752677327343;
        Wed, 16 Jul 2025 07:48:47 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab602cd0c9sm40149921cf.65.2025.07.16.07.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:47 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9002EF40068;
	Wed, 16 Jul 2025 10:48:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 16 Jul 2025 10:48:46 -0400
X-ME-Sender: <xms:zrt3aOI9_H4nZKb6Y6-Qv0aeshJtUUMv7Y6TFSKvdWufeKI5Y4Ig-w>
    <xme:zrt3aAlz8IL1evdInCpvQRlb7kllWVC_YP51ctM0dyIJ2dk7DAu2rN777y4ywCZGQ
    4KyTRD-vbZVSPDrvA>
X-ME-Received: <xmr:zrt3aGOPcfSC6zzkpRc76s3zZoP-r5dGLhrXl2IkXqzUzjN89vAcU1FoDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhnghhosehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:zrt3aK4gYaHXiAE5O-glpz5tmf0Gcqpqyk70xMZKpejARsMU5oi17w>
    <xmx:zrt3aKbdjGO5sqMc5fO87XFwORPjVpPg9Gg6xKnXIep8CQiQUZ-CMQ>
    <xmx:zrt3aHeOD9RQa-0WTRe_0QOJz_itN7M0YBz2OkG2Kk_lsma-VX380w>
    <xmx:zrt3aJ7e_NlIypvbhZo7Ksc2FkoDdJW0Z7FkTjvJNz_QWhbWLUDLGw>
    <xmx:zrt3aEagQriuermE-jZreJYmY7F6LFT4i-_tPiSEP1cxN0weWwH2IctV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:44 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: "Will Deacon" <will@kernel.org>,
	"Waiman Long" <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 8/9] locking/mutex: Remove redundant #ifdefs
Date: Wed, 16 Jul 2025 07:48:17 -0700
Message-Id: <20250716144818.47650-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716144818.47650-1-boqun.feng@gmail.com>
References: <20250716144818.47650-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

hung_task_{set,clear}_blocker() is already guarded by
CONFIG_DETECT_HUNG_TASK_BLOCKER in hung_task.h, So remove
the redudant check of #ifdef.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250704015218.359754-1-ranxiaokai627@163.com
---
 kernel/locking/mutex.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index a39ecccbd106..d4210dc97b6a 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -191,9 +191,7 @@ static void
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
-#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
-#endif
 	debug_mutex_add_waiter(lock, waiter, current);
 
 	list_add_tail(&waiter->list, list);
@@ -209,9 +207,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 		__mutex_clear_flag(lock, MUTEX_FLAGS);
 
 	debug_mutex_remove_waiter(lock, waiter, current);
-#ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	hung_task_clear_blocker();
-#endif
 }
 
 /*
-- 
2.39.5 (Apple Git-154)


