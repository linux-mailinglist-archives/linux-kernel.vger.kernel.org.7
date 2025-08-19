Return-Path: <linux-kernel+bounces-776643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB563B2CFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB49580A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A3254864;
	Tue, 19 Aug 2025 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKwdUhZv"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18F212F98
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755645486; cv=none; b=sgDaLP4Ln/xqJtabAq7bRUUHJZY7gWUi5jPZ5g6kxkx6fxfb15jYarggpXArf9sV7XBYs4/QpzqGi9osGbG9KWuseYbrJj0AtTR7v2kNbn6AwZRoGdIoCh+JtkWaMyzKmQ+PjS/1LuoZRM7+FPt7vSyiTx2lJoZ+YyJ0KEdGeXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755645486; c=relaxed/simple;
	bh=iQpC1dmPhTOAg1r0GZTbuO+umdDTALhHHffAOhsYA8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OJdPNubDQHplI/ShOTJ2M9/8jylHV+uG5yKKVpivBBKrQkICK3PgRDNKLMirgF2vFhTvHQv6DhUvScgpldzRbUiaMpclJgwUirVZYXWBmV0FSfwy2L86ZWxxqm5GwR2cWhN1b1PiPdzh2fpI2dG9qJMIl2UNSWQjS17ZTU7Fq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKwdUhZv; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e1f439so5571397a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 16:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755645484; x=1756250284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+V991O/AuXpO0gXNfjqfpn+pvMgCmUt0NMp5HsGA9w=;
        b=RKwdUhZvslsMh2TElkrvlvdtdORbQw7dUrdie63bskUmapDXFJQSVRKyWGJqfGDspB
         WgthT9l23YCPbofbWdqARgYmA1uU+dShIbPs3hFHT14XA/Wk7tQIyZiGbMim064RgdOf
         ePAlmDfmGRDRfIO8B7c8+BZEMtTaaIz99wdjUX0cw0CcgLJNfM1dUcDn3vEr+PKBL8Ic
         /pv9FeeAIz+iehu3t7hMknB90hx077yM5+wXBmbNjKSH5/Lc8KgqnGKThj98MEyYhDkD
         vH6EAPiThim+UZyMX1Nf6502NMrHOqgBhi3Up+CrA3NSNz4wEsLxKQRKuZfaDCMLB6uR
         MfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755645484; x=1756250284;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+V991O/AuXpO0gXNfjqfpn+pvMgCmUt0NMp5HsGA9w=;
        b=m3DOKiDru9rHp/8wUnIIFAhkdGqqK8jh3wRslcx5X19PAtzJCvxAEedxWYo/vGWRF9
         GYsOyoetkdL4AKYBOeH/Pn5rgJZqHoix7wyhUh6IubZPDC9/70zehd8Wlbd8FYEku/7X
         NXsDuXxdZey5GZDpYtjOLWzuTz3FYd/8yDBS3uO+5d8YwrUFr5uumg5lSVVCX2zlknUl
         4wSsW+A0fz9HZfZWd1TSfX5jBszaRNXiNnTKTQWkfyNICerKDSbUFCWPiKU3JCXPsrnZ
         WU+taER62tlcqkNiBK7GpxgHgHBm4QQV1RWtsOHIpykJM19uxLAQfgCDPc/b8AfMcYNg
         2OWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbWsEIQru8FXRcJRhD0NvbErUqRLnQ2fcZnAxpzmyrTpaj+nlLZSVXu0Hmz0KnzP6/FQ/HJHNqH7fydFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSN62VQVW1EBws3co/DnCC/TtZ5GK/wgU7PqE8XpdOi/Hi0KjU
	KLyLOY5z5op7BLL2uRbg825/QjRL3ii6b1pku+tGmEHWCmxqdU1mC899jB65W6+GDW1Rqrxa94B
	f+n4jSw==
X-Google-Smtp-Source: AGHT+IEmqhWm+Rgp/lPlIxJDqGsLB2fjNqO8MG9Owq8liURqmpXeLdJm0a1eGITJhg85sYLWrdIRlLj9egw=
X-Received: from pjbpt16.prod.google.com ([2002:a17:90b:3d10:b0:31f:2a78:943])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d86:b0:31f:22f:a23e
 with SMTP id 98e67ed59e1d1-324e1400f2amr893027a91.27.1755645484200; Tue, 19
 Aug 2025 16:18:04 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:12:17 -0700
In-Reply-To: <20250806225159.1687326-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806225159.1687326-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
Message-ID: <175564464954.3065741.7104560070190898929.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Move Intel and AMD module param helpers
 to x86/processor.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 06 Aug 2025 15:51:59 -0700, Sean Christopherson wrote:
> Move the x86 specific helpers for getting kvm_{amd,intel} module params to
> x86 where they belong.  Expose the module-agnostic helpers globally, there
> is nothing secret about the logic.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Move Intel and AMD module param helpers to x86/processor.h
      https://github.com/kvm-x86/linux/commit/e2bcf62a2e78

--
https://github.com/kvm-x86/linux/tree/next

