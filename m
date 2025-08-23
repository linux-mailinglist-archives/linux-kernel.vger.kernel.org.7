Return-Path: <linux-kernel+bounces-782821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B392BB325B6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 02:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0171CE03C2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 00:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA4F17555;
	Sat, 23 Aug 2025 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx+GLxMQ"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D263CB
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908386; cv=none; b=rfdubTi5HRBg2iva2r5KmrC7cuuiONDrp/5UtCcXPv2SfummPpXNo6bNa7mJMJ7ZNI1D1vvnSx3EXwrFZy2EQfnqnU+Th5iv+Qi/arFr12ACE6jDTRmgoKjzMVUpqUQ0nB0oM27NouMgbw/RTl2WIGnqTeuwSBvTi0X00SQDy2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908386; c=relaxed/simple;
	bh=IfxLvH/4djtXjG1ZbT1WQD1ylUynPTSQfpsVbSEvNF4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F5eq8hL13Vuogz9b8PTa5bAktlARmTzBUZ+1wHaXTYeEaEQ37qla9LFmxeB8y0j14A17bZIDh7sr+Y6jCKv2JotQ27x6ILFvGSdOsrKLDLAls5msBNjcTSY5T2HX3OJShGqZ9bjlX9TgiNvmAyx15FGH6OM+Sqxxz4+Mm2smw6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx+GLxMQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pmalani.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2445820337cso28505085ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755908385; x=1756513185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dmug+OnOuHHGPSonvBlqyEYHJAEByQWWRbd7ST4yXZc=;
        b=Mx+GLxMQNxeWeztXze+Bs74sDMxrOQBhz6LDssiHvQXtyCQF1PmST7ASZ6kHX94Ixg
         v3o5mGF97c14iyZktXieASn8o7f7OUKlXsTSPj4M/z45lyYZQYk/D/1KSE4ZtDxitDDe
         FALZ69a+NCmoRd9h/LcoAdyrbqVCKGM3FFpTVCPsbbDw6tDb32+vH1vEfIYRc/3BxLfQ
         jNpq+7OCdy7t3p+oR2bC3k/1AcKZnY0jDTqE9U5ksHTeC6YGSsS9bZuAdmQbAIQNZRQ7
         Q4WutMplZXwstqAiC2ByF4P/olxn6mmBlu1go3AE2yctDm8M60UKpVFRjMqpilE3WLbd
         dgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755908385; x=1756513185;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dmug+OnOuHHGPSonvBlqyEYHJAEByQWWRbd7ST4yXZc=;
        b=F3w3ILAwJQCs887bZmBLsMLX2BqiL47qPREsyKS/zD+G7PcpDpBYBal8lWH+LndyyE
         jI2oOIvQ2O92PyjCP7svQnzT8act6k+o0s33e6zSBQjf02GC032M6OcPF7k12Zu95rlx
         VGS2ZoGcFXTF7QohXeOBAAxZ3Z2Ivw2oeUmtApK1f+pCwazF5t1B0gOjAy5ey3Vu6V1d
         xAqt7j1tH3+Yv828nwhm6XRymdaFZoHmL6mMB8irXlNqTBd7yfKtjioMckYpYm29W8hj
         KYNDHni1pWXpNdioln28/WTrE0YBOfHAmCQ6JIcIiKF0zdhJ7SMRTyofvQxRK+BQ7r0I
         aAfQ==
X-Gm-Message-State: AOJu0YxV8BKBxR6bUZPP8I+J2cxorMXpeK+25+11Gx8VF/FNod02ZmXn
	DCDaHF9feDd0ysc5QtdBdMAeXYrOJRFdMNbKSMGqtzoFaIOMaBhsls1qHnvbBbyESnGOw8WG12h
	UmkyfRSLIOkdfIjF/Mc5pNjI3Qq5i74VWPMw1X/8q9pdLSCbT4Js1oA9ygJ77Yc9WhsRpv7xw5X
	LVDkRFScESY+ea/gk32/+EUfcdmh/o0Ijbg77r6WPMXbp++fVZYA==
X-Google-Smtp-Source: AGHT+IHQuEttIAsZ1HbWe4GGbgzVoHgREsFjRqv+pqfupF9cALmrShqhnWckhzXHJOCAVo8bhb7rEnDQQT0B
X-Received: from pjbsx13.prod.google.com ([2002:a17:90b:2ccd:b0:323:2b2a:1de5])
 (user=pmalani job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec4:b0:240:4d19:8797
 with SMTP id d9443c01a7336-2462ee48412mr55759115ad.22.1755908384225; Fri, 22
 Aug 2025 17:19:44 -0700 (PDT)
Date: Sat, 23 Aug 2025 00:17:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823001937.2765316-1-pmalani@google.com>
Subject: [PATCH 0/2] cpufreq: CPPC: Avoid cur frequency modification on
 governor start
From: Prashant Malani <pmalani@google.com>
To: open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Beata Michalska <beata.michalska@arm.com>, Prashant Malani <pmalani@google.com>
Content-Type: text/plain; charset="UTF-8"

This is a short series that handles an issue where, on CPPC-based systems,
the cpu frequency was getting unintentionally set to the wrong value on
governor start ( and overriding the existing policy frequency) because of
unreliable AMU/CPPC counters.

This adds a governor flag that avoids the check against the CPPC AMU-based
frequency when the governor starts. It then modifies the CPPC CPU freq
driver to opt in to using this flag.

Prashant Malani (2):
  cpufreq: Add driver flag to avoid initial frequency verification
  cpufreq: CPPC: Don't verify cur frequency on governor start

 drivers/cpufreq/cppc_cpufreq.c |  3 ++-
 drivers/cpufreq/cpufreq.c      |  3 ++-
 include/linux/cpufreq.h        | 10 ++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.51.0.rc2.233.g662b1ed5c5-goog


