Return-Path: <linux-kernel+bounces-750132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF78B157B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 05:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD3D5476EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3653C1DE4E7;
	Wed, 30 Jul 2025 03:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crxv144I"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786A13C8EA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 03:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844820; cv=none; b=bNsbyuo8mFZIzkC/wj8V7ZXYTt2kw5UJIsCGoFa2koWRLh9A5meLyJtBW+6Y62D2j+AZWUmEf65VYDTRt/222jHyD/skm0IujhQtJimoK7KHsWv+lMMDd+u1nbxI2+EC7x7pf/BLk74C2AQ7Q2Ubg+qG382YgP89n5Gf4l6ZrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844820; c=relaxed/simple;
	bh=chDKZtyQp0dUcQD+TRZi77cal4E4MJ/s/K/kQyL44JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CAkWqwZ7oAT+yuSyATTISWX6AjTPLCbaOQo2fVIC6c429qhGYc0N3wC0QAhCsWR1CzoRcSZsSPCHSuPiFMJMUxLTv5hoFZLmOBfje24MCtbdHJ6RBr3wCJF3ts6WsdIt6/Mmmqywm4AitiRMRbTDUWJ2xSwYW8R5qCxFY9BywIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crxv144I; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23dc5bcf49eso87051585ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 20:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753844817; x=1754449617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8wUtH74SdiggAwWn19JDZxA61lgUtCCkwbJ7bEtQLs=;
        b=crxv144IGOIUmVl7maZGzhZfZ7ZihYiUllMcPzBWQdKkna4AkZ5e0NSYq0V4Xg7SV9
         ZrjUpBYTe6oGSlYydcV4I0sIsA1jZ5hQLREHuNYfSZAy5v6L9k0MmbLWZYSfADoVswrn
         IvdeUGmnjCRQKNvbHKLuVxt2ZfdaOkDD5rzTDQW+RiuT1XLK7rpU0CLRin+Jg/tnPW0C
         Z9njM5i5CdBjpv+Bgi/bbztBzdEEPeI33xaWFwgGEA3CkNjhU3gvzU7ddvtjLO3NepLc
         TpRXceOBYVvW3YnSasSrmMMcm2vD+i2CPasqXOzprXOQex1bzLJq8DJlNhDXbyULvPon
         A45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753844817; x=1754449617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8wUtH74SdiggAwWn19JDZxA61lgUtCCkwbJ7bEtQLs=;
        b=OMAc3dmOfeRQ2Rh9Ud2FXOO6X2+Be4UoJENcg+SjLP+nM7cnyqZTLFApBDXmKejpcY
         bFqcJouGHJoG+VHlYNdSP5IMprknJJKdWc6Jb6q2EIu/UMP3fYcp6BCaIRok4YL8Scww
         vJsVHxb7rk+9MnROm3gEys8IAOy/hhFKqmYyQnXkwOAryClzXnbN9PAoMMjTJmJl3G/a
         ezbOb75+YsxTyNYnFLz2OOO2zJmJkME62HXI36BZIzJqQKDwDFovSlRogMamuO1SIQgy
         XH1B5G49/+o4PilKmehtU8bmSeTj0nZWIq2W4Ej5mbBr87bjgrrSGcuN9cBa+9z2HlyW
         YdeA==
X-Gm-Message-State: AOJu0YyGjtmMj3rlKJJJve81zuAzl5OBd6ftGkARc2tUfodJYi4/2gmL
	CNNyw7f7GBlizWZOsC7BDKnbq6OqNM4ofq01dJZ5uJPO45mxEqqGPwGh
X-Gm-Gg: ASbGncvvitfH1sIE42u8uSsh0D7/WDKqQKdGiybVcW05LGHp+cBO6yqIuC8qQ6UkbFc
	tlwLz29VCZ/UIA2C9wclSHXiuLIVXFBbaTcZZaNyhM7/93eSCWVb5+3GS6gvcTMuDMgbC+GKszt
	N+A93MZMLeIo97ViQMMsKLz+E0DwUu1itL9WglKAMmMuxht3AYd4sIx7o0iOaJ8WnNhPAg4Toz2
	Wl5krlARRgeeYTGsJFxSt3O9iFmhN6F32Jxm3sYWY4FBSdAO07PCYWjG5Sp5TpNqJ5s/rX+cwG/
	Cbhn2w6Tiip9kn3YCNzeGIeOaIhWR+EY+l6Ebe3texdLYWuPGk2yAuNRN0mOSnzz1e3MW2pMGN/
	pIgDHrdJ+sFyfdeCyvVjtWh9Lxju99OHJ4A==
X-Google-Smtp-Source: AGHT+IH1guDyoZ1HseCMplpcCL8qj2IsIapBb0UW0NFlcli1/Ck2HPYo9Eo2f+RmRvj7CVW95cQqpQ==
X-Received: by 2002:a17:903:18b:b0:240:11ba:3842 with SMTP id d9443c01a7336-24096b08dd9mr29378415ad.35.1753844817423;
        Tue, 29 Jul 2025 20:06:57 -0700 (PDT)
Received: from localhost.localdomain ([2403:2c80:17::10:40f3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24067035e9esm31625105ad.102.2025.07.29.20.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 20:06:56 -0700 (PDT)
From: Wang Jinchao <wangjinchao600@gmail.com>
To: Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Ryo Takakura <takakura@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org,
	Wang Jinchao <wangjinchao600@gmail.com>,
	Wei Liu <wei.liu@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] panic: call hardlockup_detector_perf_stop in panic
Date: Wed, 30 Jul 2025 11:06:33 +0800
Message-ID: <20250730030638.65355-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a panic happens, it blocks the cpu, which may
trigger the hardlockup detector if some dump is slow.
So call hardlockup_detector_perf_stop() to disable
hardlockup dector.

Signed-off-by: Wang Jinchao <wangjinchao600@gmail.com>
---
 kernel/panic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index b0b9a8bf4560..52a1ac4ad447 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -339,6 +339,7 @@ void panic(const char *fmt, ...)
 	 */
 	local_irq_disable();
 	preempt_disable_notrace();
+	hardlockup_detector_perf_stop();
 
 	/*
 	 * It's possible to come here directly from a panic-assertion and
-- 
2.43.0


