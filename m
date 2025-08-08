Return-Path: <linux-kernel+bounces-760611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9485B1EDCA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 19:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B445F7A3D06
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D61E2606;
	Fri,  8 Aug 2025 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1wNOS2c6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E035948
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754673842; cv=none; b=KAhJz6cX7JwHzh2sUpFWqsECnNZyKhCe9lB9BfGnvASgl0YRTL+arJXl/4mH990W1IQupKDmYz1y+GO8OjQ4QKjDxQMfzHhMTeQfb/EPohkjBigufPlih8wEdDc+mbY4ju12MhLgt8O6b+xqpXnHE/2AGTiLKxGDhw6KYLxdWY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754673842; c=relaxed/simple;
	bh=iqTHpVd2oTejbN5RDuM6RDH05bJWkqJjH51xvxKQFkk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WqTIfDX0QTE0p1WYAQe+Nmn5rFF8Mb+d/dOUgVMkI8fzqAZ/DGWao+qFIIOJ68QsaO1LcqTbXffX6XVyAMa3RPa1tAOGBxjLPlda0mp7zgEgZ6/eZpyQKaKohDp5p6wGLELBe6zXsI8ph8l7r8l9McVt79bloEkDMdd6Wp11Fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1wNOS2c6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f5f70a07bso3646032a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 10:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754673840; x=1755278640; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWp4LU+wr57td3zlCeBR2Ed4JiE6MBpWujRDgBGE9sA=;
        b=1wNOS2c6QZM+lSVD6xgFBMRStq57+Z953EbmxVBSu14565aR8o8BI3ZH8S+3d+9aX4
         FUqDAnkxq6m5r3IhrbdVp0+mIwRVUNwITCTOfcpjAL6ZpwzS5O65Dy/9MURgJQFDu0l+
         yQ0nVrSnN72JhaHSVph9RqI0RxtMQkzKPOrDy7iJuLi0fjot7Ck5/bswG5WHIoK1B0Xb
         8Bi29REMBNifeMDLUqMTae+nbJKz4XHU06/GtRBVxI6CNivz8cUrgGe6OW+AjUj0akNr
         w4lWreba/BlAomd6CcQaxAEkZOlunPbEpb3QwULHLu4rARS24nP7wkiBQFeh4OJB+s6f
         hohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754673840; x=1755278640;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWp4LU+wr57td3zlCeBR2Ed4JiE6MBpWujRDgBGE9sA=;
        b=FZJTe7iIWYX13GSOOYUphQ/2oQHiLxi8xkXFF/B6wSjyezQx7L+LBABWguuZfQ0jsV
         rKoBE2+8jh1VP2jlZn85sHsNzb5wqhaFR5Vm5QyPNyha1z8MXL858AVPhnh0/h1+nNaT
         Ib3JJ+SjyOprqvFJf3+PSqAX99DTlVWF+hDj4hMdbyrPvFdzmdG3W+bUf1Nnfd7SCjde
         /evNDzA5a59SLkSfhws6tCzCydZlKvf97B2KiaeZhnT5FlYfLs6vSeDsVPyDw/qlOGPR
         OmNQm6HfcfTkArzy7x9ndza/6rRHau/2gTSpmYlNdoZg9wa691DLEc51TpF4RvAumUnx
         Kj3Q==
X-Gm-Message-State: AOJu0YwfQkG7Pbu15B93vX7QN/a5Yp5RYidAhgBnpwiJcKyqj/Tji2eX
	a7uTEh8OvBrrwNlp1SZb3gm9DWrDrkWecF05avhWnzwsH7weq7QjgVw2VGMq+TZ2iIDw+U0w1Wk
	OJAccwg==
X-Google-Smtp-Source: AGHT+IGm54XdGwmTSEalblCWq6fy+YAzoGDTzh/Y+yTUi8vGvPgFsPJdc9tP6w/Tz5VBMa/BZiDY1xmwmz8=
X-Received: from pjmm7.prod.google.com ([2002:a17:90b:5807:b0:31f:210e:e35d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c0f:b0:31f:1db2:69b1
 with SMTP id 98e67ed59e1d1-32183b3f161mr7155636a91.18.1754673840563; Fri, 08
 Aug 2025 10:24:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  8 Aug 2025 10:23:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250808172358.1938974-1-seanjc@google.com>
Subject: [PATCH 0/3] x86/umip: Fix UMIP insn decoder false positives
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Dan Snyder <dansnyder@google.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix two false positives scenarios where the UMIP #GP logic will incorrectly
trigger emulation, e.g. due to a partially decoded instruction, or on
instructions like VMLAUNCH that usurp the register form of '0f 01'.

Tested with the hack-a-test patch at the end, but I haven't done any testing
using a real userspace (neither positive nor negative testing).

Sean Christopherson (3):
  x86/umip: Check that the instruction opcode is at least two bytes
  x86/umip: Fix decoding of register forms of 0F 01 (SGDT and SIDT
    aliases)
  *** DO NOT MERGE *** x86/umip: Lazy person's KUnit test for UMIP
    emulation

 arch/x86/kernel/umip.c | 71 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)


base-commit: ce0b5eedcb753697d43f61dd2e27d68eb5d3150f
-- 
2.50.1.703.g449372360f-goog


