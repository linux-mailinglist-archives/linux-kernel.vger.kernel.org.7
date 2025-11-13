Return-Path: <linux-kernel+bounces-899429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8D2C57B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2915C4E6B11
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08C01FC0EA;
	Thu, 13 Nov 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pXtHcuqY"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F11DF985
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040872; cv=none; b=rfrSmmhpHZWrfYoN1utAIV3gatZ97fL352I32nFenahBDCEKsHz8/FbfGxr9UwAd42pf87scW2B2Xf1lk5/S88UzZQYSQDeBN0AuJHQyp+VeM5eVMmVEqtOJlzT9Fi+OT4/hP+EuKlbu2wXDYkOAhuLRE/OcfQp4CTvIuMSguj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040872; c=relaxed/simple;
	bh=6l4ONkReUKy81A9GnmL3PU19yH8H6LhTLL06wGe1prM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuXgo6iKiqGKTD+sP9ryMU9wj8qmxct5wC+spqNw38F9BxYExJePxBci80pO3WvpMGI9L8LektDxDy4SzKOAZtDi026a5+l4UJbx+PzqneJYXNLZt1COlDrGu+0cSpI3HySqQ/TPJ4jfw+cfpFVzjvL2+ie+TF5Y7BeBk6m4jpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pXtHcuqY; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed67a143c5so297401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763040869; x=1763645669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdsF6PopYo48gJZ8nB8MKqkVw6ro+5qg6LJt/rrshu0=;
        b=pXtHcuqYsSE1a3SMwH9pJ4ouVS6DW1pScVaUbjVZyxr9i6zzn6ywkB+57goEKZapGf
         qfnrvAMP4bPaKKAp+BptZOfSVU9KKNQsD2SwEIOKeKMRhSKWkfzO/w7RA6ijB1u03y/w
         vU1IJC3LuRbhnbZCkAOBebJt7CP7yEfsGlO5p41m3/FeJipbupYS2AcCXof927ujWYhV
         dGh07S/Ks157VGLYMt8FJIs4kHurbDVT1L97+QXtVOCL7Vi7hY3raMkY2AcLtK3mj2rA
         0MICcn3lCsCxEhc0RooBhv0DJV7krEbvbrCLQnRpgMomjj/vwBhl0GirBKVSCDbRDX4D
         tj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763040869; x=1763645669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdsF6PopYo48gJZ8nB8MKqkVw6ro+5qg6LJt/rrshu0=;
        b=Oja/6vfOFsg5kxpK59IsvErFJyw60Tuy0iJ3lIdcpOSCHD8nMf3bMdoUuX/HcLQnhz
         FfaMuDzRJlfRPlKn4BgpDB9RNI6ExFj3t87n2Nu4kvwF8Zlz17iZUvagUIVAcJWUC6Qa
         Zme59AuQFI1qR53N/VQkcd9fIAtbyLFKYW8g5y8nBIpGAdz/MHB2HhcQa8kx25Zm+ftB
         qiT05I8Y1r6gxRMqt7rgQBLdQL94jD5yJvFVFnczf89nL0HBCwQow/OKZoiJnsjWyqvb
         daLXeIkpiKacqpi9mpFAGfVrDo61lIX9EXPLn4AGI40LpaVIUFdRMIOtv78kT9hSvkTx
         Q2ew==
X-Forwarded-Encrypted: i=1; AJvYcCWWKIude1yep8G6o/lW9hc4oTiIL2kI+O1xuia9Fnsdp92AgI6MvJOQXgLjpfp4wUTshb+5FNrShT8w60o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZmjFHKhxqYVt+7/ctqbBPYdw+eihMxAb5zaw3GmpG78UdSmJ
	Mkj6rpcxNF4tC9BYDuaQVs6/qQw+CCllhlijvvT+Yaa5LAhvWCTZpSlo07/jveSEWylE3eGI8uL
	lIOCfWFcRq55aqxteCl39lx40bDx72jUzCz6W63tO
X-Gm-Gg: ASbGncubwwu5hYgpQELbn1Cep9558NQb+2RtnKHqJqT0AMEWoAUuVG8fKh1VqJM/lhW
	yZNxksIDrLJ7Rg6JH7SK2EJwoJ7xtiNrcXrFGeduZwzMEZqCXrzDIkNfuobM3qZiOX0C18tLf4P
	E2ItIKIcixhWtFZ+nb6bHc9gjOwreOQAnxI8wNlcfgjLsoepxWAXXfSUarN1XXePtIQ4Xbhd2K+
	tmJx0x2bYQt5+aWuh/v85Qm4mLbOo2lpp+XTnHADzqegT+aZbJ6lsVKypLDpxTcH6OIgMQ=
X-Google-Smtp-Source: AGHT+IG0BPTdEw6iovy+vMYENh+zRzF3KveurRWgU3MJfeVoynxJgdYulT5V0eVvFNc9VgWBEGGG3NVW0j0zIrRowR4=
X-Received: by 2002:a05:622a:1984:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ede8b9700cmr5422711cf.5.1763040869200; Thu, 13 Nov 2025
 05:34:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192408.3646835-1-lrizzo@google.com> <20251112192408.3646835-2-lrizzo@google.com>
 <86o6p6t67m.wl-maz@kernel.org>
In-Reply-To: <86o6p6t67m.wl-maz@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Thu, 13 Nov 2025 14:33:51 +0100
X-Gm-Features: AWmQ_blUZhatEQIcApRPEX2RytnJi1en5rbG-leFu7W8EQyuxctXfqwlWs6i7OQ
Message-ID: <CAMOZA0K3hMSE32SnyVBW5NY4V=zuC3S7ueHfZN2sAWZNqRCwvQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] genirq: platform wide interrupt moderation:
 Documentation, Kconfig, irq_desc
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sean Christopherson <seanjc@google.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 2:25=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Wed, 12 Nov 2025 19:24:03 +0000,
> Luigi Rizzo <lrizzo@google.com> wrote:
>
> [...]
>
> > The system does not rely on any special hardware feature except from
> > MSI-X Pending Bit Array (PBA), a mandatory component of MSI-X
>
> Is this stuff PCI specific? if so, Why? What is the actual dependency
> on PBA? It is it just that you are relying on the ability to mask
> interrupts without losing them, something that is pretty much a given
> on any architecture?

You are right, I was overly restrictive. I only need what you say,
will replace the text accordingly.

>
> [...]
> > +To understand the motivation for this feature, we start with some
> > +background on interrupt moderation.
>
> This reads like marketing blurb. This is an API documentation, and it
> shouldn't be a description of your motivations for building it the way
> you did. I'd suggest you stick to the API, and keep the motivations
> for the cover letter.

ok will remove it.
Sorry if it reads like marketing, that is very very far from my intentions.
I just wanted to give background information in a way that is easy
to access from the source tree.

>
> > +
> > +* **Interrupt** is a mechanism to **notify** the CPU of **events**
> > +  that should be handled by software, for example, **completions**
> > +  of I/O requests (network tx/rx, disk read/writes...).
>
> That's only half of the truth, as this description only applies to
> *edge* interrupts. Level interrupts report a change in *state*, not an
> event.
>
> How do you plan to deal with interrupt moderation for level
> interrupts?

I don't. This is restricted to edge interrupts.

cheers
luigi

