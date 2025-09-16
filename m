Return-Path: <linux-kernel+bounces-819200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9182BB59CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A697C324D0C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A3E283124;
	Tue, 16 Sep 2025 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UiZaIJeM"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D707233D9C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038476; cv=none; b=XAuzCHGGgmJtNXVDGTuyyYv4LvnFKXE07lbFmSDZAQW4OsNyJR1Zi93/SGWmlBSSOqqvPs5WMA0EiPAenU0czpzye6OyHqUrtG5RDiZo4M/ScvkIlBnZrMZnuU6BvhoxV2rBlJ7L0O9qOsP+iYI/oq7/5KXF0v42lVrK6BN/40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038476; c=relaxed/simple;
	bh=Yvu4+I+mmPd9KLgsD/Xp7B197nOWNAf2C7L4OonWZ1Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nPjOzUKN2/V65FZ+sdmBCleVi/UKccCP+NopHryDoIcvaJhueBqUr4+iZLji2qnLFF9ycXrrYqixXOdj85a9nbPCHgDImS9I4iB0DDtfgTOeVJ7LqudxeUmUo5o79XQN8huziB1Ud/tvEf1+fLeNswfzsv8u1CJzpI5LXMJAoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UiZaIJeM; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-25177b75e38so66834595ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758038474; x=1758643274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=16noxQnX0KIlK98rjBFjGAUY+DX3PGXWiRxf/Pcl2t8=;
        b=UiZaIJeMmhIOusKhgJ35qLYeimcnIqWZaBGz6ZVsvYpe4+F45CnS7GQeRj8WephmBx
         EmEVtADa0PTjTywD5/EO/jcBwG52UICvWriz6JdbdePahKlpB1qAETfbdAiVrFoAxWFc
         a87vsweeVtc2bRdOaudMuuTJy3FbQiLXosjpy4ps8Gyec0MXGGDUpO+dHeFyoacY6iFJ
         nEE9MfrkmwQ4F13cX51GFm3qSWKk2LFyAkTT4ZyzHo/6UEIHXRz8RxeYqMINmMCRurkK
         QR9mpO3uXSWpDnv8re7u0wvYs9Tol7vML/7o8Pt3qEVbYMF6lR5+tFMEuGH4o0ZDCFJ2
         1sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038474; x=1758643274;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=16noxQnX0KIlK98rjBFjGAUY+DX3PGXWiRxf/Pcl2t8=;
        b=QTIIK0k8XkxGZ8Two5D1I0Ho5XxYnL0HRmp3riEl2BJ9UNVv2dItwrzZEKZYNOvmr1
         XNcCGvuq5cpfPgkQQmEh41YPm+6q31kA9w2JRAhu6T9kT63+OxGju360pk7+gHPr8A9c
         0nUvm4jkVaSHd9awe99eEjqF/a/EEKzpaGjzcdtcioReTKPkh60/38RU8QPuCA9Uo8+8
         Vb1EjOnoZ2CkzxjyDRxD+91K17vzSBC0NRigCYKUHeYO5OI0VKX4YjJxcww/GwhnLU8e
         OO9nzp2/07FFoPfYTets7R43aNU/XS2Y+kWl3MAD/ymLCSD/sc3Uyq1I5CFXpQfJ20/b
         uqRw==
X-Forwarded-Encrypted: i=1; AJvYcCVRJ8c6DvM93rKCLLaezI5UXmVybCdw8Glz2/swwrn4fHghqiIZbd3tmCXtYUYLiBbCg0KIRaJ4RbtzgT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMToFm/WocUyEneew2bgXCuvdFxwCdmLLgZMCELp64xLiu0Rhu
	ub3JcvO4sSE5IGaP4ZlC8L+yxaIAoSHIYgrDpTLWkptKcShSi72QBrnaJ2GIu1mLBIIlj22KuQy
	VnV7+XA==
X-Google-Smtp-Source: AGHT+IFd7myaxOXphUd/MVgrf6Fz4tV4x05UEurwdAPSr2crZiMufGY/rfW5WckYFeXemaVy5X/Dfq/hQv4=
X-Received: from plkv16.prod.google.com ([2002:a17:903:1a30:b0:267:ea8a:35da])
 (user=surenb job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ef11:b0:235:e8da:8d1
 with SMTP id d9443c01a7336-25d24caa073mr179675535ad.8.1758038473731; Tue, 16
 Sep 2025 09:01:13 -0700 (PDT)
Date: Tue, 16 Sep 2025 09:01:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250916160110.266190-1-surenb@google.com>
Subject: [PATCH 1/1] fixup: alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	surenb@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Document new "accurate:no" marker.

Fixes: 39d117e04d15 ("alloc_tag: mark inaccurate allocation counters in /proc/allocinfo output")
Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
Based on mm-new

 Documentation/filesystems/proc.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1776a06571c2..17668f82ff1c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1014,6 +1014,14 @@ If file version is 2.0 or higher then each line may contain additional
 For example if the counters are not accurate, the line will be appended with
 "accurate:no" pair.
 
+Supported markers in v2:
+accurate:no
+              Absolute values of the counters in this line are not
+              accurate because of the failure to allocate storage required
+              to track some of the allocations made at this location.
+              Deltas in these counters are accurate, therefore counters
+              can be used to track allocation size and count changes.
+
 Example output.
 
 ::

base-commit: 199236646ffd82b5a5bcf2bca1579ea06cb0ae74
-- 
2.51.0.384.g4c02a37b29-goog


