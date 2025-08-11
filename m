Return-Path: <linux-kernel+bounces-763624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5202B217AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550882A3D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE932DECC5;
	Mon, 11 Aug 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eR6u/6zX"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3221FF53
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949071; cv=none; b=Ziip2O6/4vsB47M3v7V/+f5rzuz4Fs3TF2S+jQu1HSYXWhX7dUmwz7EEup/XK1lKBlwYqZ6oMBXzqbkILFZsLr3Wp39c3VdAVLPwqlJmXnfOxVhsxJvLrgyd5ivv0dxENlOqiwDFr6h5MfHfOgxDKgelkinpLzv+BdPwzVDY7iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949071; c=relaxed/simple;
	bh=65KBFE8BPkwfcVg4jB53IPo5ajU1y6uRPFrKkfXA1XE=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=e7WpD9IZ1j7CZuvoLLCqTBXRfMVwdACte4RKfBHonEcR+mT2cQXOyc9JWSzrYiEw+awLFS5vEyiNX59T/cln26YjmEyGpKkZVDib+mLpnt5DEhz0XMjfscFeVoB4AbIQQ0G5ir1PWXug0jA6PxCZyCCpI3tjwxoqjfuqRVYeQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eR6u/6zX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-70e7f66cd58so79454997b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754949069; x=1755553869; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PwqN/lxE9mJd9ssQF3LX1cWozaXY1hjV8p4yifpV4WE=;
        b=eR6u/6zXDWQwzMHfidRoApAwSgGQeT0IqQGOjZOxI2fWDcl6Xq1NlO0mMK0GpyA7q2
         sAsbJkoWZtkNHLsoHDQg77gTGwxyJzTlkL8XViydFWGPFx2ebft4SOoEEbcmMf/hb+EN
         yiFbBugI4Fu03ClKyPJRCFronpF2lMUGsnIcBaYf0hICxRJOhJadsdO9kDiNLYnMOzoC
         TtYvXDFzdWq8YU5pBNXN9AH1nYxLRroCeNcR/tgf4pUZd0q+YIYeuN0XOUw07bRO4yeb
         LgtBPJYm6r47+NQKkz5C6RdPutIpOkjGxAZ0aT1Ol4EJ3RnMUo+ei5JHBqaCwuKPXunQ
         Lsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949069; x=1755553869;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PwqN/lxE9mJd9ssQF3LX1cWozaXY1hjV8p4yifpV4WE=;
        b=D2I+OeAE1CL4aS3AG/B2WEHb3PzX0NS7mGd+5c1hoDvgCHqZWXuAssxXbZl0d1koIi
         xadbxtfNfouQ9ASSQfyXldvZTkqPlwJfVxk6RX/y/39duY7gSwwIpEqauAFI4VKimTE0
         NQJpqAFLRkpePMCp6H0RtMwKlC7g1ubrMKbSXFTs1sqbZPNflH5EHxaCvNrsqJ8L3sTU
         yU3TXL/BA8QAnIFzwJtX9A8tirKxlFUcYS1uZaM1uiWUNUh8uLD5fKOHQm+PwvBibiJn
         mFXLE7tH7AUPyqOns/gThsCTUo2TKlF1e+JCbwQ2w4hGGOXB4jwD7mCsK1vwkuy9IJe1
         XjMg==
X-Forwarded-Encrypted: i=1; AJvYcCUOhBQzlT7BkwLtzP3nzIzZIoiAb9FIACNqPGXsb6fvI5/Rh7dlIYcqTArXOywqYwUYz/PVwyjmj6/HpGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiX0azGD4RUwD7X5BID/zCKihaWuLRkQ6yeJqsuia8c6X5NJrD
	0i43oBDkR+/Si3A1tsGqi9r6krejnJ5lX9yBUfPgpRJWkJydiSA++mzMxssNobFJGhdI++yeVdZ
	as0z2L8OmO7faiVu/wQ==
X-Google-Smtp-Source: AGHT+IF31yJIzZLtZf5YwIdgBObPTDKaUsdt3wMJGEuBrPgQE/hPpRjSKmjXjoSc2epK9tktnhTagTOMcM0pXQk=
X-Received: from saravanak.san.corp.google.com ([2a00:79e0:2e51:8:345d:d6c9:e5b:7ae2])
 (user=saravanak job=sendgmr) by 2002:a05:690c:a750:b0:719:f0a6:9166 with SMTP
 id 00721157ae682-71c42a9b396mr327b3.8.1754949068275; Mon, 11 Aug 2025
 14:51:08 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:51:01 -0700
Message-Id: <20250811215104.3469878-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Subject: [PATCH] MAINTAINERS: Add myself as virtual-cpufreq maintainer
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Forgot to update the MAINTAINERS file in the initial patch that landed
the driver. Add myself as the maintainer for this driver.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60bba48f5479..a825321a7c45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6245,6 +6245,12 @@ F:	kernel/sched/cpufreq*.c
 F:	rust/kernel/cpufreq.rs
 F:	tools/testing/selftests/cpufreq/
 
+CPU FREQUENCY DRIVERS - VIRTUAL MACHINE CPUFREQ
+M:	Saravana Kannan <saravanak@google.com>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/cpufreq/virtual-cpufreq.c
+
 CPU HOTPLUG
 M:	Thomas Gleixner <tglx@linutronix.de>
 M:	Peter Zijlstra <peterz@infradead.org>
-- 
2.51.0.rc0.155.g4a0f42376b-goog


