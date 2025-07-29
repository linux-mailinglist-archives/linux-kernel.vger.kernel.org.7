Return-Path: <linux-kernel+bounces-748720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B716B1454B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 02:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB5D188D7AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DCFBA33;
	Tue, 29 Jul 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuZCEYh4"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D110E9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753748396; cv=none; b=Rc22WOld/U1h/fXg2pHN0VMO9jZy8aEtruCPmxgUVUwXokRTF3gNXMwdewRBMZf1avI2/wZ/JtCPc6xQKCPUkpmjpfb9qnLoxnVys6o2UW7EaGbW+fB1RXAiWMvbA2PT+QrrWDuWa1jCcpmBq+wOBulwI9pUhRF6Vvoyr+IyAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753748396; c=relaxed/simple;
	bh=Ltl2zX+6d4jn4+SNiecloXuOhL+aAakR77QdlUu2/4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmvvYb7WEhco5fgXMsHR3SswBfsBFgMgyGvuGaKbOyQzpn576KdeY9tDrYo3C7o26kQbXhfv0ZaI7Zr8p++OaVCh6MyF3wv4Vbgyt/7lEB7TwWlBiAwtv5cbeTKjIiAM9QDD9Vw38ImgcnRCCwI+Q3E1UQ++GipW1ZSshhkI6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuZCEYh4; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8e19112e1cso1209111276.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 17:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753748394; x=1754353194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns+jOKj3ePiSkamR9ZiPL6yGBf8VxECwOfrYabjb7vc=;
        b=IuZCEYh4JmSzUhRGmC+gSNIrkVFuH0mlDkGAyRs7zN9XLMzQ5co3C47/IqF+7Z31kn
         maInCrLEz5bVXCkbMrlkMJENXqpsa2UCj0QdWRBLYl8B1/mrVJU2gS4a8ROpAjAAqr80
         fF1x8dxuG/D5eWgdIGveHzoJQRhhiGiFavZZLjfwWLAjjj1+lqobbBkPEO7yawAQFaKk
         RQIcrttW63cJe1GeJJBnov3ko+tfIKxbCaDUqNqilHntth5nmzZY+PwSlEbBuf/P948L
         8irT085cgYSeZ5bkDdibsKznsOJEexlSI0vKPJmAR0GhwdmxDlWOW4IcX4R0LpsHjnrq
         v/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753748394; x=1754353194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns+jOKj3ePiSkamR9ZiPL6yGBf8VxECwOfrYabjb7vc=;
        b=KDlTrAYBsU9EIqxbwehw7BXVfp2O1LlDlgBzjMpBhEZasTqYJgxRlEaRaP7li+9MUD
         CAyhp67Hn/IUrOKqv8K1WIY/IlWRN4xzsUswMyNfnF5UGSCEXFdZa1Cd2n/JMN+xLXPB
         8XoTskBJcZpxI/PsKg/F3tN/whvWoTSSJ4MIQSq8dfZ6KdQgr0gUIwMTmgRBsg/y8whC
         MisFJXC6gjC6ShUFAG7xTz/wzxpXjtfTAg5PO/IiLhiutXalMCFaN3/qWbROqfHVELrI
         65I2Irb514pdqO+YM5jhOz78S31WHJk5E3y44QBuHWabADfk5I1seCld+EYh/fOw62Hf
         9OvA==
X-Forwarded-Encrypted: i=1; AJvYcCUymQod1CFdLpGi150EItS96+sTVrL90ifDQixERi+JPomWQURHKBOKLIUWEaAroSUdERt0gHHjXy4iW+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTxnhQC5y5gjsx7ZtYLC6Ms0sPI8t6FgJTaF6HgCN/WWgaD9Q
	vmq8x+XumvMfonFFd17XeQXD/oeCHYXbptmVG5CsB8hck2XFiQnFBZMp7GmU4WRpLm9mEX4lR3/
	T/al9THvJ3JVzaLtdxQozmR/DB09NWMmUxPEezGl9
X-Gm-Gg: ASbGncuaA5t6M3nloaeUaEF3djwlu8oiJAtEzXL/Zx6GnTCiL3HMw12tX9JLCxDtsUo
	x8/+ZLctXLJh3H6tRdIZLNLlUrKrK7X/funb38hAhUN2YiXGervbwFGONiZgxNhbSy/peNiI6CA
	g5AqVXhfkb0G5dYw1sEqS7pzoqkPVVwdu1dgM3sruWWPdlwO4Qtt+af9+Vu+YFOCOslWNSrvWtB
	JAKPKtv1hOutYksFH2VQ9YPdrLZfgWDbtsnm1H8YY5UXfA=
X-Google-Smtp-Source: AGHT+IHDe49xBiWLPDxPkbcKw2j/I2J1CIgJv9DX7+7Uv+/UcTlFKQNOgZ23ID3H2fDDlmmr5qGtav5j0AieL029dvQ=
X-Received: by 2002:a05:6902:1403:b0:e8d:b7be:b7ea with SMTP id
 3f1490d57ef6-e8df1159084mr13244312276.7.1753748394110; Mon, 28 Jul 2025
 17:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com> <aIFJsLFjyngleQ7S@google.com>
In-Reply-To: <aIFJsLFjyngleQ7S@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 28 Jul 2025 17:19:18 -0700
X-Gm-Features: Ac12FXyd-D-Pmm0BbCyXt9t5LLwdGCSUomWA7gqCsnVCIueVkqUlXtePHYs3SwU
Message-ID: <CADrL8HUB9Nhtqu+b1HhfG33Wt6wkp3LYkxSa7Nv1GbX5+Vj=vQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] KVM: x86/mmu: Run TDP MMU NX huge page recovery
 under MMU read lock
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 1:44=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Jul 07, 2025, James Houghton wrote:
> > David Matlack (1):
> >   KVM: selftests: Introduce a selftest to measure execution performance
> >
> > James Houghton (3):
> >   KVM: x86/mmu: Only grab RCU lock for nx hugepage recovery for TDP MMU
> >   KVM: selftests: Provide extra mmap flags in vm_mem_add()
> >   KVM: selftests: Add an NX huge pages jitter test
> >
> > Vipin Sharma (3):
> >   KVM: x86/mmu: Track TDP MMU NX huge pages separately
> >   KVM: x86/mmu: Rename kvm_tdp_mmu_zap_sp() to better indicate its
> >     purpose
> >   KVM: x86/mmu: Recover TDP MMU NX huge pages using MMU read lock
>
> The KVM changes look good, no need for a v5 on that front (I'll do minor =
fixup
> when applying, which will be a few weeks from now, after 6.17-rc1) .  Sti=
ll
> working through the selftests.

Thanks!

