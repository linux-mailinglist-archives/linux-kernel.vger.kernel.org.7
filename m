Return-Path: <linux-kernel+bounces-736382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDD2B09C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17C0584451
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE37D218AC4;
	Fri, 18 Jul 2025 07:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UsuClPAC"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CEF1DF723
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823132; cv=none; b=HpQuIt4LII+tR3fAvbOtU9RFAngxohFM7ZHw+JJAAAp0RbtonbfWx/k36oNWLFXCL9HMRpqPQAII8XaoaTL9TDS1yk9VhuZbPNKvaOjAwdS6htvsDKsX8hRstbFuWQMIcupz8U7hY23VvReWUlZdh1PAI3SIAYu7mZAe7gAaqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823132; c=relaxed/simple;
	bh=Zn59aLe/yWz+Akvmpd38g8gBuiT5an0q8Kyts6xZv3E=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=uwLAoxECcS0HSR/FF8dHheI4CW5OVCMRAD61Sv8cLB8sa+wIvMYAdXllO1l1fPT5Gzsm1JKCVdsOv5z4mmwvJt0Ease1vtdutxZ49LawbfJfIzaTz12m1IUHIUXBqpsS2huHgvktybI229cT1sLSnm7fX85Jm/+P+xBLpLIFOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UsuClPAC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7183bb34e08so17278907b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752823130; x=1753427930; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=43KBDyv3vQltdEHCHHjKL/GypIhMs7xxWF8XQgNgbVU=;
        b=UsuClPACX2i75PYoRgVmpQz/TMaAYVu6lIEvGzq3xbJ2nynVjjpKcZunxmS4FPgU1G
         u/0uBtCt/Sb5OVimKL5rd0C1OVYwYneelnMjG9jp4Av2m+/fESKikehkimHQlI8M+X9T
         df2MPj5VyT0o6idCmAwiYL0TbonYAb7wcgp8mi02JKnwjNFn6Q1cdSAUeLSugtoExX/7
         kg5XOi5umw0MBDT7nQDsTzXvBl7aviPVWctFHuZ/HVBDMNk3uBW6Aln0HLUB4BjjL6lf
         7X8BCFZg8ymn7GHnW7gfeUq3GaOjcEGDs7dwVPw9NxUcqIrIj18RgG/wOdSoklxBmi1h
         uMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823130; x=1753427930;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43KBDyv3vQltdEHCHHjKL/GypIhMs7xxWF8XQgNgbVU=;
        b=YSwMBPIfraY/Ntj8mIc0SAgVXiOlpLofzW+gWrHwQ6zHBPvmHhck80TNtxXihO8Wwk
         YmaHIyyxJOCMqpHuLUdPoTIuucIs3r107g27H/3AmNdScbS+sZmvoNrqsEvXeH8Pdp+y
         8Hupg+LoXeZtBKjGkXpbvh+/xAl8FXEP6z09IgP9Y3e8iWbTwo4saNe3CTfRA6rG+03o
         ZX2qZik0heU/RZ397kqff7g78rvmtGlKYGVsK0g3mnlqk5M1tSSRl2RRQ2HcfJSP+6Wf
         69QeBXvRBYelsp2XUUXcl/xhIsgkxLA6Dg6pze9UbSCPefZsM6BkMZbQiEBRK8UEYNGB
         s0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXeHo3F8QxFGlmz3WuUGCSVRAHV7MLc8sBUWBvenq778TRD7yj7xUf6VLD9dk5TFUdzqMzYY70LcALS9ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnEKcmfJj0V2+ZNJ0EAsiK9TkR0KqiJ9TyPQ8ppHXFj8y4idN7
	CV/gNHoA9u2IrE1CztKbiRHx2SLRsfxwSD9FDqut3KjsoHIhLmLNPIQkbdpVqVU7BUtQG8s51Ew
	THwIegE9NtTySXZkp/g==
X-Google-Smtp-Source: AGHT+IE91J6Y6wOS1CXhtmYH1cHW7yuLtfW/K1B6xSUQnwp1shuMOVCULM8oomcAKJDSaN+euXe4O8uNB1ijuIs=
X-Received: from saravanak.san.corp.google.com ([2a00:79e0:2e51:8:ac70:3fca:7662:ffe0])
 (user=saravanak job=sendgmr) by 2002:a05:690c:8688:10b0:717:b262:b4f8 with
 SMTP id 00721157ae682-7183732f8f6mr15597b3.3.1752823129495; Fri, 18 Jul 2025
 00:18:49 -0700 (PDT)
Date: Fri, 18 Jul 2025 00:18:37 -0700
Message-Id: <20250718071842.2483378-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Subject: [RFC PATCH v1] PM: wakeup: Provide interface for userspace to abort suspend
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Once suspend starts, it can take a while before file system sync
finishes and all the userspace threads are frozen. During this time,
there can be events that originate in userspace that would require the
suspend to be aborted.

The only way to abort suspend from userspace as of today is to grab
and release a kernel wakelock using the /sys/power/wake_lock and
/sys/power/wake_unlock files. This has the disadvantage of:

* Doing the useless work of creating and destroying wakelocks.
* If the userspace entity crashes after the wake lock is created, we
  get a wake lock/memory leak.

To avoid all this and simplify the interface, this patch allows
canceling a suspend by writing UINT_MAX value to the
/sys/power/wakeup_count that is meant for tracking wakeup events.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---

Rafael,

If the idea looks good to you, I can also update Documentation and sent
it as a non-RFC patch. I'm not too tied on what file we use to trigger
an abort from userspace as long as it's possible.

Thanks,
Saravana

 drivers/base/power/wakeup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index d1283ff1080b..9316de561bcc 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1008,6 +1008,8 @@ bool pm_save_wakeup_count(unsigned int count)
 	if (cnt == count && inpr == 0) {
 		saved_count = count;
 		events_check_enabled = true;
+	} else if (cnt == UINT_MAX) {
+		pm_system_wakeup();
 	}
 	raw_spin_unlock_irqrestore(&events_lock, flags);
 	return events_check_enabled;
-- 
2.50.0.727.gbf7dc18ff4-goog


