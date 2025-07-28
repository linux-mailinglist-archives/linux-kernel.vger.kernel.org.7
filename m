Return-Path: <linux-kernel+bounces-748300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037ADB13F39
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3196C3A6E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821127280C;
	Mon, 28 Jul 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hCtQSYc7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E162727EB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717867; cv=none; b=Mi2yKqLr4gTxmG6JkmC8klne/ZfGvKkAcwHRnyIi80XffvzejTxXV+xs1aizdgdzmoKBz5/6IflCFcYwgKU965+v3M33NCvGfm0Ov/+pdvm3AcQReCf77jlIY/9eepyrgrmRerQto7XMX3zA9Krvq1etQ6PWjYlcxLsupjJ48WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717867; c=relaxed/simple;
	bh=WhzE3lidLwRHO+kwMdf/SBR6VxZhhr+E7oc+UD+9YQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4fXvsOuphLIgCXqr98aP3i+DNPIq0BeR1hdmzvoU8zQy6N1CcoPRkb1NQUqQHglnX021DWLet+ciLB6gOUvvakedvygb3X3YQdr/rjtiy3BgRgY7gKQMwvF8sfU3/SrHAi4UTR37O/Oeauq4ub4OjqMLSYbwU8A+pUt/qySd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hCtQSYc7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753717859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvnsZw2GbjFCVwwknnxISvFS3IJGIdRBTX2kuWZgS7A=;
	b=hCtQSYc7gLTqNJUoOIVU+Ss/lzeneJu/Odw6fD/dOz5WfZRZ+cUqiP/MhdN5fruFQf5Brx
	+EsgE4JNPhb8Vbb3fP5gJj/Zrv1JQVcg0uSF+w5C0eL76a9kNHWJmsPXQwUT2lQBxB83yX
	8PdYzUonUnapCW6ZOkXWRae2POc9ZIc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-9Inx-vBGO5m8Y0XqqAHyGA-1; Mon, 28 Jul 2025 11:50:55 -0400
X-MC-Unique: 9Inx-vBGO5m8Y0XqqAHyGA-1
X-Mimecast-MFC-AGG-ID: 9Inx-vBGO5m8Y0XqqAHyGA_1753717854
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4588d178be2so108125e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717854; x=1754322654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZvnsZw2GbjFCVwwknnxISvFS3IJGIdRBTX2kuWZgS7A=;
        b=XaJnTgjWGsTknwLPEv0ZXxobRS2Nf7EPPw8L4K0UZSrVWbAw3aJj9tTXAwTJz0BafO
         CTk7TfhwabHeqKOGz8bLj8pnxR1WLbCak7fsMKYRH6rE1WVxc1LxeWytwwXyIPheCK3W
         MxCMXCvV3ZGB/lGFdwELQ/T49lv+LF2bHlkDAx6Ri40EuFlSx9WCnk4TSeKuls5RinuS
         xvgCHRHuv8bJtz9Np/Zn+zl0yH9QzdTEbvoW/rd7BFuQic01spPsXCxFtvwgVCEVXGxL
         kdTKVaPci5GJErpg3IhEdVpDOYo38grR0NvJn34MU6QgCRVvyAQK5Rwr9ZbNHUoWZ26F
         Bl6w==
X-Forwarded-Encrypted: i=1; AJvYcCXYXKjvfCctvq1hl5SUuRTbgoO6tjgxo5HTECPSEOOdaizGMHOOSUOW7ja7ElTmAIfKrKklwFiYnbhY96I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyEEGDYH/sAIl74Y6t9K1k8Ax4Fv9ja9fIOP4CP1Ma6QYJ4Ui
	2rVtyATmvUsAmp+P/lQ+4NprxF9M5IIeU+vKA/8oF3YPjyxfyHGdEm1eGIA1n1wPHZ19gQjF5r5
	hp/ic56P9H+JuNZvmx4Ao5jfJ/in+6fnTcrMfCDXUkSHsEEFyN/3kGWm226gDJQ6VIS0XPQIzEZ
	FGriTRIIYiyRnRUwrJTXwYA+48FY4KhJ12JB6OYgw9
X-Gm-Gg: ASbGnctGPwwEb+9GLE+P6xBo+oGLhXccxpWcj3WOJMISQf8fv3cBj/Kwian/m6zlZoJ
	RtoVxHjLRca84ft5nNs9COwPJ4v9VUQcxbAWz/1n1AmKEqLw9AHPzcr9ToAtDsEkV/7VoEBkKS+
	ljnGcKDKCnEObp4qx0sGC26Q==
X-Received: by 2002:a05:600c:3588:b0:450:cabd:b4a9 with SMTP id 5b1f17b1804b1-4587654ac7emr85500405e9.29.1753717853769;
        Mon, 28 Jul 2025 08:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfdb+q01BGiMc4TlKJnax9G4goN4qXjdxL6WL3y1Aru6MtzjXxXNH+rKEKqpVFgF1TewF5jIjlDjF9Y0obvMQ=
X-Received: by 2002:a05:600c:3588:b0:450:cabd:b4a9 with SMTP id
 5b1f17b1804b1-4587654ac7emr85500165e9.29.1753717853269; Mon, 28 Jul 2025
 08:50:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com>
In-Reply-To: <20250725220713.264711-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Jul 2025 17:50:42 +0200
X-Gm-Features: Ac12FXxNG48Pb-33Lh-mw4gRuZlRHE4shPMRl8FH35D382PoAxKWtbHSr-LzrfM
Message-ID: <CABgObfYFfOuoh5fcZCfuuZtJ2LqZe+GOASjj8O2O-vUa08pA5g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Changes for 6.17
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 12:07=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> As promised, the storm has arrived :-)
>
> There are a two anomalies this time around, but thankfully only one confl=
ict,
> and a trivial one at that (details on that in the MMIO Stale Data pull re=
quest).
>
> 1. The "no assignment" pull request depends on the IRQs and MMIO Stale Da=
ta
>    pull requests.  I created the topic branch based on the IRQs branch (m=
inus
>    one commit that came in later), and then merged in the MMIO branch to =
create
>    a common base.  All the commits came out as I wanted, but the diff sta=
ts
>    generated by `git request-pull` are funky, so I doctored them up, a lo=
t.
>
> 2. The "SEV cache maintenance" pull request is based on a tag/branch from=
 the
>    tip tree.  I don't think you need to do anything special here?  Except
>    possibly mention it to Linus if the KVM pull request happens to get se=
nt
>    before the associated tip pull request (which seems unlikely given how=
 they
>    send a bunch of small pulls).

Pulled everything except the lone TDX commit, thanks. I'm going to
start testing without it.

Paolo


