Return-Path: <linux-kernel+bounces-837988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25940BAE2DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3C393C80B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429AE30E830;
	Tue, 30 Sep 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hDgyVPcJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA16230E0C8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759253310; cv=none; b=Xq3e2RMNh1wzhafclC7VafUB9l2B97phq/leERsGxONC2gn8ynx5k3O90TMGF13bjaEJoa0gWyLmVvXvI0V8YuVXT7RC4ye+4kwfWpquMdOxg4wctXLWKUDCCEI0AWtvzHbx6vp1zcOgGMqJF45teC7X4rmMDT+jd4evBfMbwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759253310; c=relaxed/simple;
	bh=8jRlKeUeTgvCAG6vBd65KFHhND1wW3s5Gpg+/40hbrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyS1nasEAoKNlSj0Ovvy8Egpq/uL0jQyf1qGUTDsamN9b5WmsihTZ4Jgdtbpr/aL58FAkJ3F3hgmaRGLw2QbeuJiW3bnP3LCf/Xhe7p9UCjYM/JoH8Z+HKGzdcb0453/WOKI/rvHVUn+/JS6ab+5DfZVzOLcSlAiNl++ELa2ah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hDgyVPcJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759253307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4NXR1mC7DgJ5rOj2YuD5QZX6IPdu9t+7rJzFPa0CR/Q=;
	b=hDgyVPcJUmkQZ4AxQ64l0XGretuaFJqaZ4Vnu29Yg0hA+fcfwpbeIRbHO6kJbdNsuaCIYG
	hVTDkmoB+d9PHXJNDPzDjUbQaH+00EzydffMd32GlZF2JbBpVpmmqLpKsaT0ZbojguZrLu
	w1mK7BUHDgtl3qn0xn6McZKUOUUgJxc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-F5F5uE26Moag-DTP6Osepg-1; Tue, 30 Sep 2025 13:28:26 -0400
X-MC-Unique: F5F5uE26Moag-DTP6Osepg-1
X-Mimecast-MFC-AGG-ID: F5F5uE26Moag-DTP6Osepg_1759253305
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e4d34ff05so15165225e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 10:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759253304; x=1759858104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NXR1mC7DgJ5rOj2YuD5QZX6IPdu9t+7rJzFPa0CR/Q=;
        b=vdOUPBsKWSaOnx/lXw/deUOcx3eK7rTfcqzgQlRucZJjNOYiFSR5zQLjJ3Z1dx9oAG
         SMkTZby4hkSFd9PDdDXqOQlh16MFVNPjdXLvqkMgseoiv7yPxCNUvLr+2P8V5ubE+tc0
         RjRKS6034LFPHn/7MRNV06xfjzbxld5In8XhL8TXB5daxViEGg5bGmGPkIKXyxigZsLU
         KvXBjCPwd0KGHi+CSsVv1OAjCTUPWHmLsMybay+emxriZs16sSH2mAMp5o27+6GpvfLc
         xrDFmZ60Bdxn22neKD/ARGZ3GtGv80FQ49VbOv78x5bSSVrI5ZJ1AQ0jBpeC88VS7/uS
         d2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBGkvMfGNbFYuzoTl0g1Jieqbhb1kMIU3wds78VSPTm3c6w0PHc8kLx9Ema6NNQmACxZK1L9j015uIMjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkWvr1yOBJWltQVWoMbW2ZvLNS4cLI6/aH+YGYlsbbVX6eVxxL
	PUV5afSpWiI//H2cG1D1DJ5IGlXBgq07XFa7zaGy8XF3pdTsG1F+TEUB+x46xlqmn9GHojPjwir
	KG2baWjn3id3AVwDnfnt/sNHTX2ZPrWi+4ZWMzmPCNrinO8VB8rLFMqux36jMi0dYHitiarEGog
	uJZrq3jEoyPVD8PoloRK9mHkO+AB8H4ZTSpf8KDjvk1RUtldoL
X-Gm-Gg: ASbGnctWnU8F9Jc+QuMivvZGyqK0U1ND6xeuE7M38FmdhKlZ9qQei+9B3MiXk5oKKJc
	MXZo5itl9zok6vJusigcq9lnLA7t1k53+JjQBQVW4uSG71xLVOPOzvNvBOek6eFm5e4GsLz/Bbg
	i6d7BxX1CSb/B8FEd34ml8VcnJ8QOo0WRv5j+k+ixEDcthEz0J4abAZpUSqAPvvGCF4EfCw6YtH
	4lXHriOsya1Z1UM30fbjul7MRgG23Qd
X-Received: by 2002:a05:600c:3507:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-46e612875f5mr5819095e9.29.1759253304120;
        Tue, 30 Sep 2025 10:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ6pJtzlzv4iBRvds7S19SLjIxjS/LhQX/L/cdPjj/fECk6uNJJci/M8sfWS6rimLaQg8fqfWU2rFk0keWEB4=
X-Received: by 2002:a05:600c:3507:b0:458:a7fa:211d with SMTP id
 5b1f17b1804b1-46e612875f5mr5818895e9.29.1759253303703; Tue, 30 Sep 2025
 10:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com> <20250927060910.2933942-3-seanjc@google.com>
In-Reply-To: <20250927060910.2933942-3-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 19:28:12 +0200
X-Gm-Features: AS18NWAjAd0J2HQV6oJt-Vre9Wcakmj7QodFjkMsDMAIdm-NKd4rKP2XywcNkls
Message-ID: <CABgObfZJ21hXnpdR=Q_SkApFRcWfVOQK3fsZP-evRzOZ2yL5Og@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: One lone common change for 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Tag says it all...
>
> The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0=
b9:
>
>   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-generic-6.18
>
> for you to fetch changes up to cf6a8401b6a12c3bdd54c7414af28625ec6450da:
>
>   KVM: remove redundant __GFP_NOWARN (2025-08-19 11:51:13 -0700)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM common changes for 6.18
>
> Remove a redundant __GFP_NOWARN from kvm_setup_async_pf() as __GFP_NOWARN=
 is
> now included in GFP_NOWAIT.
>
> ----------------------------------------------------------------
> Qianfeng Rong (1):
>       KVM: remove redundant __GFP_NOWARN
>
>  virt/kvm/async_pf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>


