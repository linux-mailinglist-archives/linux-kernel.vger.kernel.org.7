Return-Path: <linux-kernel+bounces-855038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D4CBE001C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C351882FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8C30103F;
	Wed, 15 Oct 2025 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zhjw+6l1"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD486342
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760551793; cv=none; b=IXcCZLVi7RVIu78b+x0tm73UMhRuLHT2t32AZWp2fCXDISWpO/jY4FeUlW6A8GbcxC340r5C+tDVdflomNSgNi1+ExtD+bdIEZ5cT2P4PbF7zNdvd0Gp6ff+e0LL4G1IwFsou3jyh2ThVrmVmCyIRRk/vzauLsfofvTIMgXJEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760551793; c=relaxed/simple;
	bh=5G6xDAhFH1AxSP7lDNMOG9A1FxSEBhHl8BnZzEQDZEM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9XLu90LaoA/wkvYMRj9OMbv4KP3hfWWBdnBNPrbUP/EhNGfjJVD0b/Bbo23OBSrE8Q0XegtmWQcoovlSLfbbSbMlOuk+AuHyxemN5+8uIgKBaF8G1s50+9iHtCN4YLJeftXiZt76k1X6imQYl4dXTt9WvAn2syjqbG8QXLx0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zhjw+6l1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so9279498b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760551791; x=1761156591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BBZAV7j+GFJDsPwRiVv1D95p+t7S8aVLW4yZ4s5Ojg=;
        b=Zhjw+6l1CtWKV630hmmKg/UIty8EvHHv2tc5HsaMcSlf6ah2CXnkGa9wsn/H+wK4Id
         JMdtRwOnf0KJGHUlo/QEB6XA7u633yMHhMOj2AZaiw76v6SUghiUIap376PIZ+imgHJf
         1ciPOn1eAPkTeJSUcN85jcEblfNVBAZiNhe0hH0ERtkd6mYyax/GVhWOBxImepkg68Jm
         sCgFmdTLBWLHXFpZgnXzR6Fz9kzmSWS9L0X/GjUWeUg3hKlizVaArK3X86k9mLTAxS0H
         1TegSeoAyc5qFQSXF0xAv/Z9YZ/LFtXTMkpQeRGEy8BP0fp54ZSElMCWcuuNgQ75Nh78
         XQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760551791; x=1761156591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BBZAV7j+GFJDsPwRiVv1D95p+t7S8aVLW4yZ4s5Ojg=;
        b=h13mNzKxeQRMUN8N3Ui8yfWWXnoiovawRuDcOAqst6/zWj6rOkYCa5qYt+C3i8EB4x
         KF6yobcZQwQEFJe5SUKAVW1hTyfh64TusUci0XB+RIiMYMMn3rDX/38bQvNTdo1E3qKS
         mlKoSwjUOnf2xt/1wVlru0KBLfQxBnRx+qlrRikdWIzYAMqJqEjpvRuLB8z7rv5kShAH
         f8LY005HJ44sZrFSmD2z9HunTJ2ZM0hTwVAtAA7AYtXA79E89i1Vtx9b1TSh+dMrRVbP
         GLdvZbAiL6GaF+csydE78aHUXWljth8pZYgdeczc6TxqDD41xwx7cT+MI6+dVb1ixbgb
         dZhA==
X-Forwarded-Encrypted: i=1; AJvYcCV1eM34OX+VawtNPFWWnVZrevnJZaTNnFAkjnogwMBX2jAxGtMZFpGw25n0DbZKd7cSmi/KWs8Sb2qUXDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUcYI53ADg6+uVgw5TQDqi1e1tGZUOfVh5ZnD/Wfm5z8TUkwU
	fYRiXt4fWtxlIF88ytfj0FBlMowh0pgAK6Q6MmyBx7FaUR+fCADS7edRs3UKesF/Vi1tPOP7erT
	3T0Sbxw==
X-Google-Smtp-Source: AGHT+IEVBqMd8BR36sPa9T+x8P6NqfIxNzMog2AuHoV3bAHdWnsbVuEcYRmkXJ9aUZJpynYhCzcjtMqxO3k=
X-Received: from pjbbr8.prod.google.com ([2002:a17:90b:f08:b0:33b:51fe:1a92])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a29:b0:304:4f7c:df90
 with SMTP id adf61e73a8af0-32da845fb34mr38836942637.50.1760551791139; Wed, 15
 Oct 2025 11:09:51 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:02:56 -0700
In-Reply-To: <20250916213129.2535597-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250916213129.2535597-2-thorsten.blum@linux.dev>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <176055123341.1529540.17733052766097672792.b4-ty@google.com>
Subject: Re: [PATCH] KVM: TDX: Replace kmalloc + copy_from_user with
 memdup_user in tdx_td_init
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On Tue, 16 Sep 2025 23:31:29 +0200, Thorsten Blum wrote:
> Use get_user() to retrieve the number of entries instead of allocating
> memory for 'init_vm' with the maximum size, copying 'cmd->data' to it,
> only to then read the actual entry count 'cpuid.nent' from the copy.
> 
> Return -E2BIG early if 'nr_user_entries' exceeds KVM_MAX_CPUID_ENTRIES.
> 
> Use memdup_user() to allocate just enough memory to fit all entries and
> to copy 'cmd->data' from userspace. Use struct_size() instead of
> manually calculating the number of bytes to allocate and copy.
> 
> [...]

Applied to kvm-x86 vmx, with the aforementioned tweaks.  Thanks!

[1/1] KVM: TDX: Replace kmalloc + copy_from_user with memdup_user in tdx_td_init
      https://github.com/kvm-x86/linux/commit/0bd0a4a1428b

--
https://github.com/kvm-x86/linux/tree/next

