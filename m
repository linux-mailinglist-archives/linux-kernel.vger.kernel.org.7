Return-Path: <linux-kernel+bounces-831055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFC0B9B5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7451BC1DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEE131D399;
	Wed, 24 Sep 2025 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9Qzs41f"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578732ED29
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737289; cv=none; b=RAgiZbMvNXkQqvl7XxS1N25l9ge/XxBt0rHZ29ayDyQQtdYI8zlGencozIv7fJQm6IY72qpzjLFxdB41xw/DqlnF77BAp020ZHyG4F3fQfsGxBQsuoQ+KUFWcU+XQ/Bq25VbZcEhXkhXbpxtJKUlbf5PmyrLa+dAtaAfJvDJgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737289; c=relaxed/simple;
	bh=WbrpXw7uGEedja6sryJIlijHjH7y3h6T6Btd6J3NpBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GqBUJYjLn/FXj7s5UW1cVDQYbCqwnSVCjZep6cd5nI7lZ4YgaCwZQqN0+492BewGca5lmRjTXXjirk9JXXatYh2YDp6q/uCb7+oyDLBJZhzHsgP/39MfM0kAvvVM9N6lX3fVv7oJhK5JqyENbuGcMv/HzDlZxE6tfq39x/kG/UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9Qzs41f; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-272b7bdf41fso987505ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758737287; x=1759342087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E114FBK/ER4h0NxFE7k/vJ0RM740rgem63GVoGqlxQY=;
        b=P9Qzs41f4GlAS7183jz4uMCIJvODeIMvmUOmndRh6UUmC1XtwsvY3yKiHdFwpVclQN
         aNAfs0850cw1CZolYC1NMLwj3TBgWakDt9Z0QBA6H0dPLR8k7sPYk3OVZaCfAulQojfi
         AZo+Kgoul7689SieZwLjrBAus3emb3sSjCAk192K+IJppNxQaVcCwSG5Rf6k2eH4VJkx
         2Tg8oZzao7V4pE75TheHddNI/2lbwF0Jxy8nzAFQV0j3tZo+elsAwigV+S5bSVKOD7TS
         Nk7WKkt1e0ILdYeNOSYmGhQMwaagBZ70RNot6SrnjjBfNamHkZr4ChyKgWfXbY/mNVeV
         KhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758737287; x=1759342087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E114FBK/ER4h0NxFE7k/vJ0RM740rgem63GVoGqlxQY=;
        b=O+4uKD/usUVYI6ZCq/R1Ou6UfBVe8QXmciwRfg5ZUCd++5ZV+1BqftJ0AaftiZTLdK
         CRi3OWpTpQv5V6k9pv3fwC7Am4abIzV8L7Db44dtxaCq454viuHTvakySvJJHdl278IH
         MOcKznWbb1/TM1HHBkrECp2VcUDgt63m85bXUDOiMBC5/hGQ5MJ/NcGVb4JyT2oKfrTb
         ZsO5k4TE3mMsYZy0hDwfCIg+FgOqr9TR+leptn1ug6egSD7QTongGN/x5R78X/jBjBzd
         sja5MMo/vGy2s/H/KqSO/8Lqe9xMXEHBDo4xpo/0/l7AoFhzwx1/9E0Adft5sLdM/no7
         iE1A==
X-Forwarded-Encrypted: i=1; AJvYcCXuCgc7UT6ELtOIkVV3JuNWQEDVQraRoihqgUUDZhKkIXHp24DixAwWOt/2AgSepKDbMsJRQfAtkpch5eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitWyY29v7XwBT1IDA0o5U7zVQF03IivvQZAbJSoLAlbJz/JXB
	l/M46vDTJC70nkfB8eeoogPZg/UogqCwCBE+qBeu6AXKkSh9PnRFpQXaIioNOU4Ae/8LlzVibPq
	bu3IneQ==
X-Google-Smtp-Source: AGHT+IEQILa7qWwOhEOCXJrBhALpzVM3hyQ7cpSMcpqaqrRIUDlUUT4XRCks8JQbnx6Az52uCL5tJS7hm04=
X-Received: from plxe12.prod.google.com ([2002:a17:902:ef4c:b0:267:dbc3:f98d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e548:b0:272:1320:121f
 with SMTP id d9443c01a7336-27ed49ed435mr6197535ad.27.1758737287040; Wed, 24
 Sep 2025 11:08:07 -0700 (PDT)
Date: Wed, 24 Sep 2025 11:07:30 -0700
In-Reply-To: <20250909003952.10314-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909003952.10314-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <175873635915.2146060.11822371958338127087.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Fix hypercalls docs section number order
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux KVM <kvm@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 09 Sep 2025 07:39:52 +0700, Bagas Sanjaya wrote:
> Commit 4180bf1b655a79 ("KVM: X86: Implement "send IPI" hypercall")
> documents KVM_HC_SEND_IPI hypercall, yet its section number duplicates
> KVM_HC_CLOCK_PAIRING one (which both are 6th). Fix the numbering order
> so that the former should be 7th.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Fix hypercalls docs section number order
      https://github.com/kvm-x86/linux/commit/86bcd23df9ce

--
https://github.com/kvm-x86/linux/tree/next

