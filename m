Return-Path: <linux-kernel+bounces-879292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BCFC22C45
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 01:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4BAA1A6108B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F2B3C465;
	Fri, 31 Oct 2025 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cR1N+OpS"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12452A1CF
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 00:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869241; cv=none; b=bbKyJ5nW6/PKjDYRFk1NxUDIPZBybA5pwkOEHOITeFh55HWWuegqtUUNlat3yqDNd/6eUfwSkVrGj5K4c3TiQikd6lg8r/lIFAG8aKfC200+GpNJdhUd8qvDeb70g2Zz8czJZpEsKXV8XhZTM22rtVgZqm+9apg4MX7PPYmoyZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869241; c=relaxed/simple;
	bh=rGYe5yjMqWmwR+Rx3bwQkg6QzWBsMmU301TBlTItHbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/ML+jvtGyIGgmg4LneBlFeJzQxy2v15eGm3Emi1MH/e/eCrx6F0MOn7R9htnAlBJPKIXlPKKTd9Xdt828iV3KF8afrvIddU8ObE7GsCL4FCyvLZRpJ9cUmRhYNV0uFQdgivC+A0eh2ByYXDWhu6h4s+6YwVKjWMRiaRtMXJCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cR1N+OpS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592f3630b69so1980003e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761869238; x=1762474038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmcJ0gQt/4pCFYZHqsOZ/9fiYMntoegxT4AsogqqgxI=;
        b=cR1N+OpSKhnaUqB0cxyIpRKFqhUcBNeYE1uNDyywppCyPdAiIDfVK+DN/WnZdsDjl6
         tXIfmOqoT636yHm297Tarjqr7NePfDrTkeNDXNFwrg3SuPWKGQL4TTZPRXbVAoAghA/z
         NAqz9GkHVK1c0fHfZzOaqD5E3CC/0Hm5eh3Gqtjql/r1fxZKYltUh9fVhcavgZua8Lpc
         faTNtMW64S9s/Ep9SSWHyWloDyYJP2EWHYxNMrwAq3SuJFXE61H+7f3pNnW0tF3t5s33
         VWlkaMP2LN+VdunYydJPivyGTq19Vv08CHOFejtu+wuJZ8jowGVLqlJMAEW8wWrgt6+P
         L/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761869238; x=1762474038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmcJ0gQt/4pCFYZHqsOZ/9fiYMntoegxT4AsogqqgxI=;
        b=klwuieXMLOKxW8B+Ji3jXNz3gmovlDEhhjzoCDIVeKHkLNUV7aPxMeG9446YprdsZg
         2EafE47FBmqMZzDc5p+6NvTKiidm4kDaOmIG79i2kDOFxX4OuM51lNwstbStSWQYLrE3
         PSwHCIg3eF2ad0cICWIb9XS2g00wx0TNrp5DjCuZW0hwKpMsDmNUq/t8zWKaryibZLeH
         TFaaughbCskJ5I/g3NuIq1zms8vsUqaYhLJJW2DilHnTUtQdXUkelvAWd1r4nFYCxEgX
         UjdJEQtzaCaTOd0CVctwsgNDgCHa81sPUv+ewj1JyvW4Tck45aSWycb8grvf33sU7H8W
         Aw+g==
X-Forwarded-Encrypted: i=1; AJvYcCUanT3LmbAQxRGy6gq6gxBiC020yyKYZPWWwABI/jcz/4jyp5jREwN/4ut+M65jToJ/Zg2ZQJQTXP035+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwscE3qekgIQLwrrlvJakmrhz+ezvW2C/JoehYGteTnreOKvzDV
	50AfncbVvXiFEvm/nR/e3x0jDjNouiiDVYbMhCUm/7TCmsusCEzl94pPjRKWYe7YW+W5Mdb99Qw
	3Kq9SwcBtIadGN6v0yNwCIhR+7r6fqNicwYWfn06X
X-Gm-Gg: ASbGncv19KdxsG9b68fqfbWgQ6U1k9QCin8jd9X5L4suUsevnlzEUbhw0qPWbJm0Sb2
	rKQgtIPni7RskliwbU+eM9hy/qSRNdPejyeqNSyY1Au2sej/d3Ou8H69qSgYYx0pFOEwRpkCrc/
	mhn9deANzgYCoDanPn90G0eoT2bXtGaSP5jZOIpjCD3B/aH3k7Gz7r4WR4E5HmeHrKFNO1joheg
	SvsOyM2EExyer0zEY24YY8N23fVt9OfxrtTw8ssNJorQy7U3ONqBWHSzHJeuQffecM3BpWO65dV
	QtHPSg==
X-Google-Smtp-Source: AGHT+IGpSBRowIBw9czJoVeMZr9H9pjBQVUhqQijMhY/2cscmjLpJGHSTZmm55OV1QXgaD7LcghLgUjQ0e4dM+E9He0=
X-Received: by 2002:a05:6512:401e:b0:593:f29d:786e with SMTP id
 2adb3069b0e04-5941d5335c0mr554266e87.33.1761869237738; Thu, 30 Oct 2025
 17:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-16-vipinsh@google.com>
 <aPM_DUyyH1KaOerU@wunner.de> <20251018223620.GD1034710.vipinsh@google.com>
 <aPSeF_QiUWnhKIma@wunner.de> <aQP6-49_FeB2nNEm@google.com>
In-Reply-To: <aQP6-49_FeB2nNEm@google.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 30 Oct 2025 17:06:49 -0700
X-Gm-Features: AWmQ_bmRHrPwuytRU-oUtcv_mAPxEXlUmanD5v3yODN3rFDHRS7aA8xmVxSdYMk
Message-ID: <CALzav=ci-CrUgH6Kjcm6eTRB0LCYgjds3Wnun7dsG6dWBe7i+w@mail.gmail.com>
Subject: Re: [RFC PATCH 15/21] PCI: Make PCI saved state and capability
 structs public
To: Lukas Wunner <lukas@wunner.de>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com, alex.williamson@redhat.com, 
	pasha.tatashin@soleen.com, jgg@ziepe.ca, graf@amazon.com, pratyush@kernel.org, 
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org, 
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 4:55=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-10-19 10:15 AM, Lukas Wunner wrote:
> > On Sat, Oct 18, 2025 at 03:36:20PM -0700, Vipin Sharma wrote:
> > > On 2025-10-18 09:17:33, Lukas Wunner wrote:
> > > > On Fri, Oct 17, 2025 at 05:07:07PM -0700, Vipin Sharma wrote:
> > > > > Move struct pci_saved_state{} and struct pci_cap_saved_data{} to
> > > > > linux/pci.h so that they are available to code outside of the PCI=
 core.
> > > > >
> > > > > These structs will be used in subsequent commits to serialize and
> > > > > deserialize PCI state across Live Update.
> > > >
> > > > That's not sufficient as a justification to make these public in my=
 view.
> > > >
> > > > There are already pci_store_saved_state() and pci_load_saved_state(=
)
> > > > helpers to serialize PCI state.  Why do you need anything more?
> > > > (Honest question.)
> > >
> > > In LUO ecosystem, currently,  we do not have a solid solution to do
> > > proper serialization/deserialization of structs along with versioning
> > > between different kernel versions. This work is still being discussed=
.
> > >
> > > Here, I created separate structs (exactly same as the original one) t=
o
> > > have little bit control on what gets saved in serialized state and
> > > correctly gets deserialized after kexec.
> > >
> > > For example, if I am using existing structs and not creating my own
> > > structs then I cannot just do a blind memcpy() between whole of the P=
CI state
> > > prior to kexec to PCI state after the kexec. In the new kernel
> > > layout might have changed like addition or removal of a field.
> >
> > The last time we changed those structs was in 2013 by fd0f7f73ca96.
> > So changes are extremely rare.
> >
> > What could change in theory is the layout of the individual
> > capabilities (the data[] in struct pci_cap_saved_data).
> > E.g. maybe we decide that we need to save an additional register.
> > But that's also rare.  Normally we add all the mutable registers
> > when a new capability is supported and have no need to amend that
> > afterwards.
>
> Yeah that has me worried. A totally innocuous commit that adds, removes,
> or reorders a register stashed in data[] could lead a broken device when
> VFIO does pci_restore_state() after a Live Update.
>
> Turing pci_save_state into an actual ABI would require adding the
> registers into the save state probably, rather than assuming their
> order.
>
> But... I wonder if we truly need to preserve the PCI save state
> across Live Update.
>
> Based on this comment in drivers/vfio/pci/vfio_pci_core.c, the PCI
> save/restore stuff in VFIO is for cleaning up devices that do not
> support resets:

Err, no, I misread that comment. But I guess my question still stands
whether we truly need to preserve the pci_save_state across Live
Update. Maybe there is a simpler way for VFIO to clean up the device
in vfio_pci_core_disable() if we make certain restrictions on which
devices we support.

