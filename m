Return-Path: <linux-kernel+bounces-746367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F0EB125D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1795A0FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B00A25B1F4;
	Fri, 25 Jul 2025 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="O5Pbwc7F"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E535925178C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476590; cv=none; b=ukrJ0un03Wvb41gymNgMHFlLLmxCfSrSuFw85+845iTOsFbaoi7EUz5cLgSOCQAQOhdojnaCcXeLXUkjeNVi6Q86gkVKKYpGT81s0AcLGeWWusZujLpEt97wLJnecPkgKV/EY7NerpDNmW7aa5Xfc486HVkpkNDOarUXiac1h0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476590; c=relaxed/simple;
	bh=p2GNyAjE7iXApZkamXq7ckrswvmu22VaokMFBYbyKJ0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=sMuVqU+0oM1eNSazfwMhtHH0adk1vRpNSlQDXvCdS+ijD+d8Iz/cIwdDmIF7afErI3oF/OOiu/LmDHgJpx+oAGVCof2GgOYNHzdbU5qrS4EtIpxENXMXwIls83NU9xXhI5lGbh+qG4nJ2ipRActg3lFgosuINrbTNZmwHmRWMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=O5Pbwc7F; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d5d1feca18so243821485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753476588; x=1754081388; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZIIxY6ABSv8z81ahgfn3koGHJXTOfKyAKvLEaDaLS8=;
        b=O5Pbwc7FA7JZ4c40+pDWCcwmx23Rq9srEclzrEOn5POgcnuZnLMKJPEysR9XkqSDzI
         qdH0Z4PMVnDGvnsMMbl0pGhDNpzQoHWM/XUmYEcO+ewrHHZNIcnS1Hdc7lJcdAOfQ53X
         quE3LcTtGL6cvK5sWh3kJaSeCeZbrvRl0MXcPrSfnht4/Nmw3M351lmFjrwvrDfCHoM/
         0XQA7rabXfZuUmJDtnrDOvh04cgcK4TXaZAtBVYyiga5HflFYq9semF3zMMevTwAN7mm
         N5Z5PY/SUs78FuTBnFZe/HWwRr0g34+3DvTLTLdu9M70IghIslZj4yh2CiRaDu+4IZrj
         hM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753476588; x=1754081388;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZIIxY6ABSv8z81ahgfn3koGHJXTOfKyAKvLEaDaLS8=;
        b=bUAPvDggwJSUJkFOCMmyCBqbDU3JDHVVWT8+fyw7lcnsRQLnubuAqUCtwjCkFC3q32
         OyjmgWU97u5m+TTXebptGEdTX+M5ecYyHJnp/cI1qaHBmsDNs/sAsKu12v80cagSOlg6
         uKYzPAi3ghZ8rWN9a1DBeNkjO2N2ak+ycLRushgOxoBrwIi2sVJXelga0E08LX2v/J7F
         Tc80pYUV1iW2RxTO2NarT+2JKNZ8Le2yAwAFRbT9eI8T95aRoRHz67QrCtFpRtokYn2W
         ox3NQ3o3UljM2uC2ltzt3WMw02BFzx7gqRd6HCbbbwDpKQIRS9Jz+j8DBSCN0vx5Sx5w
         vZpg==
X-Forwarded-Encrypted: i=1; AJvYcCW1KZ+rIh7Fi8HoB55y8i8GjJIj1pecS8ECBkTI2KlCXFsiIjCrt+AnWLCJExcdyjrgUbVHJe/IioBxAM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Fi0+iTPIOpVdgEZzi2pKrU1Jt60+rtPk6HVAxxuEiPcNVn20
	ofEFsds4nHBEtJho20FvS8k21NQ+VxFqTO3A4XxfWOg3oJXsJVBFC3YAtNa3mQj91MZEPxSan57
	CD38=
X-Gm-Gg: ASbGncub9bCGBgBi2oBwl3ZJdADiQo75HXBLkrR3CChtyzOESc8REuCZWO6zuYzT9Pv
	ukDC07TC/Eqwzdjt2rBMapTYWd+GhOY/AsF3g/HDYwjD/SBsaVKGNqbb+EmSYTmZT5cqEdW/BJw
	FzTvPsm6HNd00MngR8TEXXBMNf5kK0AYJqGoPoVb61wHcsslzOQrF/aTetyI40/g6eIxvKvUzOQ
	Ou/AZMbe919cC3+FTLqkwcGppoaydzUR+xPR81zlkyYEOPdCCyb48DiWOgfncOCZY9w9t/H4p3D
	MV6+8PoxkVv22SavwFbhVa6HHQu4QbekxbOsLSRq8/Msn73mwpJoDdA8uEPL0yCfy6PPRLabenI
	W3f57vRrX/tI2DUAfZqxgd904bKLnPThQnbzdJRlL0u7uPjG08qQ+nKhkznyo0c36t6k=
X-Google-Smtp-Source: AGHT+IGs1tp0h7Q9zEdF3FGJM/PEgCbtWDjUvz3/6PFOrimy1pC4YXH5BKmWx16MOmz4ZbnQctmj1Q==
X-Received: by 2002:a05:620a:1d95:b0:7df:dea8:6384 with SMTP id af79cd13be357-7e63bfba1dcmr340213685a.47.1753476587890;
        Fri, 25 Jul 2025 13:49:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e64388fa6fsm38402885a.76.2025.07.25.13.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 13:49:47 -0700 (PDT)
Date: Fri, 25 Jul 2025 16:49:46 -0400
Message-ID: <9f09c9e0e1e911b43be267640e89f2a3@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20250725
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

A single audit patch for the upcoming Linux v6.17 merge window that
restores logging of an audit event in the module load failure case.

Paul

--
The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20250725

for you to fetch changes up to ae1ae11fb277f1335d6bcd4935ba0ea985af3c32:

  audit,module: restore audit logging in load failure case
    (2025-06-16 17:00:06 -0400)

----------------------------------------------------------------
audit/stable-6.17 PR 20250725
----------------------------------------------------------------

Richard Guy Briggs (1):
      audit,module: restore audit logging in load failure case

 include/linux/audit.h |    9 ++++-----
 kernel/audit.h        |    2 +-
 kernel/auditsc.c      |    2 +-
 kernel/module/main.c  |    6 ++++--
 4 files changed, 10 insertions(+), 9 deletions(-)

--
paul-moore.com

