Return-Path: <linux-kernel+bounces-817940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2204B58942
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA3D3B3671
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7BD1D7E26;
	Tue, 16 Sep 2025 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hO1Do+cq"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E61A9B58
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982406; cv=none; b=EhP9njKgbKQF+x5ZyxCDuC+d9HSw3LdRbdER06z309RDYwXhnQG1HjkvkJSxCbls+Tdf8nicg++paQxS2BTmW8Od04QkCA17Py09JNgQzOietJEp2RbOEdNiQ4O2MBNmNbiqKABnJDui0kKS/34vIWm4we/05yswxw2GxfwHrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982406; c=relaxed/simple;
	bh=cnvhbFmTcyALwq0L6KJioIroByTdgWEgWbFNzgvWNfQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ljhkcbd0pNMaoFNrg6cGCS9nPSJxsYE/u1F/r4x3ApnEBlJs3ozwJBlgvJ7R41Fo6zjpySny3PkNn+Z5Q3l7loYLlRQ69taZA2G89v2iHWAUCS+b+aNqmCOmbAFgVJEnPTuMZ8X0mSG5zh6i1HLDFgGHZd1/UY+44Y4msCGU5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hO1Do+cq; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f59889so49124645ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982404; x=1758587204; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5HErJT+zZxpaz3D/5r9TYIS9HH59s5D9HZXheG5gZRM=;
        b=hO1Do+cqajGpmDSBn0olUrkMBMH4NCy9veFMxrK9ew4Fu/3BwGIkiVPCMHvbjUJcV3
         vrsbZ4ctBbWNS28fY2SDA1oQRaV8x3esOnGYbY4TxW3Q7oIDSkA0RnaKXmboIjClI0nT
         RjA+qdxLuQeRouGLf3U1w8Qmpu8eE0HGQtGyHp8WKC2gvOfXqTRtI68JobzKHLVLK35M
         CvR6ALwqFWoK4J+MWgsiBGUDtSgMuJ0m1KfsQ8ZaICMYiw0Gls2D+ZABkBKuezbnHMFJ
         wzm5zIAdBveEh92sGVxWO0nfV8FYRHCwwvm3qoLTQ4BKGGmCZECfVAjmQjTq86RbrEd0
         uyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982404; x=1758587204;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5HErJT+zZxpaz3D/5r9TYIS9HH59s5D9HZXheG5gZRM=;
        b=cA24FASPOD6O2gg6KUNn18S3ftYvDOr4uBWsNKlNgWjq3wooTsoNpDrjjyKRlJ9H3V
         FiDR7JEjNPEORDKOyqvaZyiV4JoMjI/nQyTRpzFNAlmYYbckyFwjGb6mww1d7y1Vopmo
         wWRqZBfvrp6UAesD3AdAogEljnX1CdAxqUJdZ7oeq9JRHVaeFZywHebeu3hi8YdGhE6e
         6cfTHzF9BspaBnovsb2oZFHNYrD73UGTn5jrGQ3oafRb7nrtIHtQ5QFVu5SPoScNg/Lz
         guhv9ZcP2vhYY4OL39jL97YFXQTPIgpN2HpHZ/I5jlICD1rF0CukX7/fKXve5FXmByaS
         5G5w==
X-Forwarded-Encrypted: i=1; AJvYcCVaJ6xjCm6e4tPu+3eeUgvmWlhoxVLiKLwfw21KNEotv7GzW6DzK2KMS+Qt3L1Sl0LfpL4uxmdYPSSY3qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH0poqUei4DyP3gFltIh/Go6QwTRztbhGq2zn+CUrvXRVrOEYn
	XvF8k2myc8WJrYGpaJkrj7z0XYEkaM2ivpJG83YojjEm9Ob8amxz9QKuwlI4Nnu9XnoMcR/kniR
	8SxAMig==
X-Google-Smtp-Source: AGHT+IEXcOlqEynPdUtfk1M9vVESGR/13AAj4MidAL8m/pOelS2mXMYUIsm19xBmBwuCgDsJXDfsGCPjiLQ=
X-Received: from plbkl13.prod.google.com ([2002:a17:903:74d:b0:264:1805:b649])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1acf:b0:25f:9682:74ae
 with SMTP id d9443c01a7336-25f9682760bmr131062305ad.29.1757982404046; Mon, 15
 Sep 2025 17:26:44 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:35 -0700
In-Reply-To: <20250828005249.39339-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828005249.39339-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798202141.623675.2546293939402072087.b4-ty@google.com>
Subject: Re: [PATCH v2] x86/kvm: Force legacy PCI hole to UC when overriding
 MTRRs for TDX/SNP
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Gonda <pgonda@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, 
	"=?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?=" <jgross@suse.com>, Korakit Seemakhupt <korakit@google.com>, Jianxiong Gao <jxgao@google.com>, 
	Nikolay Borisov <nik.borisov@suse.com>, Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="utf-8"

On Wed, 27 Aug 2025 17:52:49 -0700, Sean Christopherson wrote:
> When running as an SNP or TDX guest under KVM, force the legacy PCI hole,
> i.e. memory between Top of Lower Usable DRAM and 4GiB, to be mapped as UC
> via a forced variable MTRR range.
> 
> In most KVM-based setups, legacy devices such as the HPET and TPM are
> enumerated via ACPI.  ACPI enumeration includes a Memory32Fixed entry, and
> optionally a SystemMemory descriptor for an OperationRegion, e.g. if the
> device needs to be accessed via a Control Method.
> 
> [...]

Applied to kvm-x86 guest, thanks!

[1/1] x86/kvm: Force legacy PCI hole to UC when overriding MTRRs for TDX/SNP
      https://github.com/kvm-x86/linux/commit/0dccbc75e18d

--
https://github.com/kvm-x86/linux/tree/next

