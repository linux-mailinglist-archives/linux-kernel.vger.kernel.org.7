Return-Path: <linux-kernel+bounces-853790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ADBBDC9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAFE14E03CD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD437304BC8;
	Wed, 15 Oct 2025 05:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="N3ukWesV"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5CA2494ED
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506288; cv=none; b=MjekgzPY9xJI66yKEI2LlilA5SqztljMztb1skmeEm+U7gh1DkUFZHIqEmF2yAUpVbY2v6EyCofTvG3Rp1RzxifPm1QC906ld2PtwQqJiRJG7BKa8KPvc25pWs/bmPtlhq9UlPBEdZ+HA0EX04O5MY7ls4j/Nu89J0BCFmIesQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506288; c=relaxed/simple;
	bh=FC2x9/tDvjdm6NlGJ48dWxXsYmuCn6FstQTJWM2NJk4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GCZKmS4C4PjAIyabnSoauVe6wvZNxAWa52qNWuINAK7rG2T2GUHOXrNm6oEScHWoIXkkHuRb9LoajsZzChV665J1lFSRrhT1ttNqDl/BNLOhMFkiAc9aEbLl0T0XtlrZnGeXDvVwsx2C/l5WQ/ZF8W5yI7u2c313KtTdAWLM16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=N3ukWesV; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7e3148a8928so78432726d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760506284; x=1761111084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ks0TQAnc2WQfMRFVV4u+78N4hNnTBxLoURgsapwl7yY=;
        b=N3ukWesVTltoMTYiIWCEBoZDLoJDSLAedyquDPHHnK+I+zqa4qMNKEVYcEsrVmqSOV
         THVHeHwnEMk8+FEh5AyjZmF6g3XoTwY5bUkKvFd4NIjjivNVAAH01jzn6SnRI5P5lSYT
         3VjpsmmXjYPjhe6/Ar1OZnIxXmprb/mHIwkDMxII3L6yop0CaF0STgcwAiBsnSd4dxTO
         MnrAqxAMZ9altr+vZqexLvV9lEPnxr6E2qOhAnBcWarDNn47Dd/MFkAVmRtD9U7GG3bJ
         54XUlmQ4RCwyDcjCotZIjRMmOKHh+xceoRfJB3s1Y1tUsKIVFuS+fxJVMjlDQyhpe7hI
         pYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506284; x=1761111084;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ks0TQAnc2WQfMRFVV4u+78N4hNnTBxLoURgsapwl7yY=;
        b=Dkku4oBGlz1+2F6nkicYXnfrcRleK30wgQ+nglJRxIMj5epZbkJmxrvN17zBJY3sEL
         OqCAE+y3F6fe3/7qpV2XEfjWoqSDtECDPmtqlV30HgpbHhC+g59ijUT5LoFgEHLe4a1e
         5AIEcJ51E4vQKaA8kIhVIGovZGsD7pBN62EjbiRr6zPuNFCOK0AjBMNNrfDI08sBdFad
         hXt6GK18E9ChOD9N0b7pHl1umgqWo4bQOaQ30w72kT/HzstRom+vqeyvaKhCWHSpUsxR
         KrluyehXNMaEggR2KbjmlzvfAfNb4LTOAzBnad7PxO+iOX+Ro4bdAFKBmN/YrRbxmSBl
         /Hug==
X-Forwarded-Encrypted: i=1; AJvYcCWI/wAxFqnQG5NHbHZo2tIFTExUqgojuRIQNFfLmWorxSS93i2vyNyGNUN4tBMv7WARwqWh5K/c51X+9zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Ret1fAo9siggNN77GL7xsEI159L3LtLONkiG/3A3YrVPp8RT
	uonKV0W5+W5J6NA0b0IZtjCj3e0PPPdcIHoZjJ7ruvkuOQ+pyqKgHxAdg/cpnEkv4aY=
X-Gm-Gg: ASbGncvmY/ZtF38yZ7kmQlUgbYAsRYO057Vf58oca1yBswd3SYPFnZyEjY9QHUDK3P+
	FskgjyNjYD0LEB2AX/KrCQKsnG1nyR54m7A9EjoOWjSKIVCxfd3pEEfchlQ3P5KKQHu7A+GMb/q
	e1GyAbUAVZAUXmqiixb3fwrP7ZwEv4q1tuzYUckBgm1SDB/Si5mHjRoHVioihQnaJ5bz7AwLPR4
	8D/Ra4KShxiNPAZ8daEH85jPqRVylrYyfeHGLwOJ2bgcdd1DLcKgGsiXPBGLfzciVIDEKy739vm
	zrvvUcpzVJ4vhTeRVzhq3LtVRpyGFkAOGwrVmOxtH1rxepikkYe17MXZdOECPDdrghhgn8kEwLL
	7Rs5w2aVGDI5geOru8TWrFEqLq3lQalq7mE1R+zGAXYwOxqwnAGgrzVuTK7y6Dt7anHODsEILfX
	jWLI7HA/YmjBbY9L4vpyd/MXTmYjH75Du1t3GqVI85fP8jYMVODWQYeu5SFak=
X-Google-Smtp-Source: AGHT+IFFjRfzxETp9modlQvk46r/Xd97DWmwBK2yN4Skk/yXeTLEsqZNHWkGihrbcaSsTXWHRc93BQ==
X-Received: by 2002:a05:622a:1a9d:b0:4e3:25d7:57d4 with SMTP id d75a77b69052e-4e6ead754ebmr314014531cf.80.1760506283865;
        Tue, 14 Oct 2025 22:31:23 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881d01f5asm12572661cf.27.2025.10.14.22.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:31:23 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH 0/2] KHO: Fix metadata allocation in scratch area
Date: Wed, 15 Oct 2025 01:31:19 -0400
Message-ID: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a memory corruption bug in KHO that occurs when KFENCE
is enabled.

The root cause is that KHO metadata, allocated via kzalloc(), can be
randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
early memblock allocator is restricted to a "scratch area". This forces
the KFENCE pool to be allocated within this scratch area, creating a
conflict. If KHO metadata is subsequently placed in this pool, it gets
corrupted during the next kexec operation.

The series is structured in two parts:
Patch 1/2 introduces a debug-only feature (CONFIG_KEXEC_HANDOVER_DEBUG)
that adds checks to detect and fail any operation that attempts to place
KHO metadata or preserved memory within the scratch area. This serves as
a validation and diagnostic tool to confirm the problem without
affecting production builds.

Patch 2/2 provides the fix by modifying KHO to allocate its metadata
directly from the buddy allocator instead of SLUB. This bypasses the
KFENCE interception entirely.

Pasha Tatashin (2):
  liveupdate: kho: warn and fail on metadata or preserved memory in
    scratch area
  liveupdate: kho: allocate metadata directly from the buddy allocator

 kernel/liveupdate/Kconfig                   | 15 ++++++
 kernel/liveupdate/kexec_handover.c          | 51 ++++++++++++++++-----
 kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++
 kernel/liveupdate/kexec_handover_internal.h |  9 ++++
 4 files changed, 81 insertions(+), 12 deletions(-)


base-commit: 0b2f041c47acb45db82b4e847af6e17eb66cd32d
-- 
2.51.0.788.g6d19910ace-goog


