Return-Path: <linux-kernel+bounces-817942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE66B58950
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3FC521EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6D1AA7BF;
	Tue, 16 Sep 2025 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LWMtOmsm"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB31A5B92
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982478; cv=none; b=ugbXSqzZb3a05iC6ItuBE9+3j0xFT3QZAzNydsyMfK+/lnHvH7Dt1XKz01uzHP3IOxQ95AnqRhpbvayvwCf/YdBY4hKT9aLagcDv152QgpvocszeVR3dc5XdWhJw9VU52GSnWCqukOSH+pqknVAAOlJ3afjHv3vC75bFDLAPkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982478; c=relaxed/simple;
	bh=PzUM3Cfsli7E9k7NP7Lepm6+OszCbs2678LuFeoy1AE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mXNh72FIfns5FCidjlewzRJZWSjLWvcQoeBlmHnYmIc4TFwPoyNw1j/hazjK8JZ/5EOLPrguMd69KhkMXNJ8bcH0WGafCWcwQWodGny7jhAJBdvbKdKOUxO3y5xKsW0iwlDPlpJpRJPXXtQ2UdoOCWOfKd/7PsRvJycTXmPmdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LWMtOmsm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b54df707c1cso90612a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982476; x=1758587276; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=baDObaahxYUAyV7C9udP7HlsTUog1DJ+CNfR158Eu7k=;
        b=LWMtOmsm0W1XqTiTYbK5snJ0wy1zhAjgPww41YxQvEj2waZKWDDmYdOl4w9LghCw6j
         9PUXSVwFXH5I7KYjIFJmqh4kEs2lFdP15iiqwPmkMp7d/E2ALhsPqL5Lp7Fjc7OQlG+A
         7rBTvH9zW5olaN3hi5/1MW/8TyWJw7XQX1vAlqfZ0qzNCDgDL1Bgxh6HoH9QCRR4LZPN
         qYMpkyFv8q1Rm9vjHc1UshaiNfpTgmhnxXfb3VGpwNYLUrlT3nJfH01cfYgOUga9vPqe
         5Cdk38qELjbBjz/N5BEG0UF/Wf+DtOPpymEGHXjaZEgB5rTRlxp973QwKgPlUp2zhIA9
         MH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982476; x=1758587276;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baDObaahxYUAyV7C9udP7HlsTUog1DJ+CNfR158Eu7k=;
        b=RaZNlt9HEkzA2gQhTmZoImtdVWvLQHgC+dXU31zvrKE1lj6kJtWI8SJB0v/TD3VhB4
         lgrJ7srN+MJpV1AG6AqQsqx1yDLX8kjpFFnYiM8yK2lv9B0il8wMwBrvmAiQ4NL8r2qD
         fGCYqVWCAs4yqtDpThSMWoR4z1YrHs+EsXJvErRMxD3+6R8dl9vbhUBgndOTMI9QSiaq
         tI72XP6noe+YFJ3NaOY/eaH95T7VuxaNtPbqaUuOapF0O9BK3qYI7GjKAJ5W7m7MshTS
         7gA83mfShJyitEZZ76bUPq3v9CLAUZikCNxQi7t5XEMfGEDkTPsn/wMb36v+mJzkuHa7
         V6yg==
X-Forwarded-Encrypted: i=1; AJvYcCWRFi0g3S6uzFraLJkCR+zRjwHvKszXB95HBiRC9yKIgNX1uNNorpEZ+HBJFme+53WeXxfZ0hgyU0u8TWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwK6Nwk3Dylvg6BZLLaoCMxOcW1b4OPUv2pjmXipvb6Sza2xpB
	mmZhjmhr9KcpfjJwS9G5SUFKJpDU3vDzeVXaP2DS33bk5jjeXOceQa2cxldJOeJFkfNWiO6cnuo
	DmefSBg==
X-Google-Smtp-Source: AGHT+IGB7LEdNHh9ns9vVvTdWH2C6Q76XFb2XcrJauMeliLMD0z0q/tWVuKSzCyaknAjl1QtXFxCe/nWT/Q=
X-Received: from pjg16.prod.google.com ([2002:a17:90b:3f50:b0:32e:5d96:8a6f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9187:b0:262:23dd:2ed0
 with SMTP id adf61e73a8af0-26223dd328amr12071862637.31.1757982475753; Mon, 15
 Sep 2025 17:27:55 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:39 -0700
In-Reply-To: <20250901131604.646415-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250901131604.646415-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798207153.624508.1085968130364515751.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: hyper-v: Use guard() instead of mutex_lock() to
 simplify code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Liao Yuanhong <liaoyuanhong@vivo.com>
Content-Type: text/plain; charset="utf-8"

On Mon, 01 Sep 2025 21:16:04 +0800, Liao Yuanhong wrote:
> Using guard(mutex) instead of mutex_lock/mutex_unlock pair. Simplifies the
> error handling to just return in case of error. No need for the
> 'out_unlock' label anymore so remove it.

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: hyper-v: Use guard() instead of mutex_lock() to simplify code
      https://github.com/kvm-x86/linux/commit/864384e97981

--
https://github.com/kvm-x86/linux/tree/next

