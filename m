Return-Path: <linux-kernel+bounces-837693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFA9BACF64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D83D32122E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06403002BD;
	Tue, 30 Sep 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TWiuystH"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952C037160
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759237404; cv=none; b=mtOcnzwz4hviDssFvK7airKJmK55HbT25pok7/t8YktG+itI2zs/zzvsWNkL5h3Sp7kLQFbXweBwHH4dhLQgjlMZYHl1RLphaxWEvOLqMWx0Ihj+lJAq34JgwEcnYeYvSKc2jeP58eQWTAxpXTmzzlpwNYDO23AFNFNB/647JHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759237404; c=relaxed/simple;
	bh=tNy5hIlubLvYXn7jng64XrQQhZOwIs4X532FSAnk+BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PgwgPLFFTCCCwcWM9kxXssvn1kugq5i3/YEusL25VpCMx/UlPhx5qvBdSg9x9xPRkz4Trpy0O4zwx5033mDfBgeC83j9TXw+X+k3QvWAVa/2hJXYSMxWWVBVwvxLZJUaBx4mjNqcONzInpxuJKvAer+axJ0cGyUP0DlOh0KitIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TWiuystH; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8608f72582eso210241485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759237401; x=1759842201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uC1oKAVwY5VttRhmKJUPbe7CpWFm1J+jVh6aRaRkZ4s=;
        b=TWiuystHBuXRlefecO6hfqPhr5LMIcm928h305R2enDO3PMEIhDYpP2qWvHmQMv/NV
         6omRIUYqI/nZWl1PrIHz3dNcDDJCy5kPQQD45bg+gCdD+NVoz/xKufiQqakbmE3vqZub
         sfsEv3xNFHDR7/+nSTrBxNi90O2DKu4Mtb4smrAnPaGUlTywBpMd1Xk2a6E5U86aCRBs
         V1NoUY+0HLLl1h+3HFb+YnG5ruSG3SyVMVHWx0H7MCyKOeT9yT8dgSIIZi79zRD6WmK2
         z9IBv411xGSkgOgGlvof5eBHFAn1XgS8x7cnkwgJtukZb7+vlMuX1kNCMQi4DFq+UUhN
         WRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759237401; x=1759842201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC1oKAVwY5VttRhmKJUPbe7CpWFm1J+jVh6aRaRkZ4s=;
        b=N9ynt/IYSw+qjXRt/8x7lUz45S8zcyeSC/5EN7zYqGk1dacF5yjEANQaa38FQTwjd4
         1L0stcyf1S0kQQSHAG4tRdMj4y4FtPzWY5KgiqFehjVYzhrkQqJidhSmjXoBjlbFyWcK
         gUDDt+RSYZ7tJwjjy8teamnQbO3Nt/pL3w0psqydf3tT0kzAmYYOyow4d+m4sHpLcQLj
         0zcigAbWr6/nTzUVK8FYvZQZRjwxO39HP0s7FP5XAZcc3MS7lNdJlyyNJE6T7A4UQvmN
         1U4E3Etd7R+XMkNv6SRErCNgg8i5ZpKGLqZniFXx11VMFUEi3XRWLD5ZmT8M+2angnsl
         sdbw==
X-Forwarded-Encrypted: i=1; AJvYcCV7NkJB2fwYfZBgYXl6QmugOglFmtjLrjK7DA4XAJVuXSIqkCkBOa8pOmeg19avN/j1LA5jBZR9JQWBh7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkuSHbeP9hDOzGiTryZX+4f661qUE5USwms+Z5+t54f7jlgWfG
	FYfzX0IfcQJRSlDKp9eRB+BcDMlxS4xIacvJxm+WEyAR8gohpRCs0jJqRrpdTSxGYpZF1mxEXr9
	QIsxf3J+F6fo10AaabdLHpaS7VaCMe1dQz+T7s+BJVw==
X-Gm-Gg: ASbGnctOpb0nuHFg00vy476OuPEFUlupYmCRpgMY3JS8J1twOzk1/EIhGBjdVHZ+fGo
	Q6hfRNakIzc3/0OsKI4UaHTYo58uRAYm7kWITJgeYP8zMEh9DSaAfOCD+rvMdlomTmDkAtfVQgl
	h5Yp0UQNcE/7ABeyOUGyMzve6Ytso+RXjeXjXKV5iux+nSNUzOnCy573XQKx7XiZQ2X1BenOaXO
	g83OxUK+byWgjwgfxU9zPEqMPbPWzGtuRhMlNE=
X-Google-Smtp-Source: AGHT+IEXsl0l6CFv2XrbeldBTkph/BWzHMDIl1mPG9fMR2Gop2fULhnOuqxlzYbsJ40ATbeEXf4K4rr4nreQirK4/i4=
X-Received: by 2002:a05:620a:640b:b0:85b:cd94:71ff with SMTP id
 af79cd13be357-85bcd947af3mr1982298785a.48.1759237401174; Tue, 30 Sep 2025
 06:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
In-Reply-To: <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 09:02:44 -0400
X-Gm-Features: AS18NWASRT0LPsx9qEKAelbHRFbMF3MsrgJioJy2jlydT_xCYMVTX_yMZN6zf_g
Message-ID: <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Chris Li <chrisl@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:10=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote=
:
>
> On Mon, Sep 29, 2025 at 10:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> >
> > On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > > prepare callback.
> > >
> > > After kexec, use driver_set_override() to ensure the device is
> > > bound only to the saved driver.
> >
> > This doesn't seem like a great idea, driver name should not be made
> > ABI.
>
> Let's break it down with baby steps.
>
> 1) Do you agree the liveupdated PCI device needs to bind to the exact
> same driver after kexec?
> To me that is a firm yes. If the driver binds to another driver, we
> can't expect the other driver will understand the original driver's
> saved state.

Hi Chris,

Driver name does not have to be an ABI. Drivers that support live
updates should provide a live update-specific ABI to detect
compatibility with the preserved data. We can use a preservation
schema GUID for this.

> 2) Assume the 1) is yes from you. Are you just not happy that the
> kernel saves the driver name? You want user space to save it, is that
> it?
> How does it reference the driver after kexec otherwise?

If we use GUID, drivers would advertise the GUIDs they support and we
would modify the core device-driver matching process to use this
information.

Each driver that supports this mechanism would need to declare an
array of GUIDs it is compatible with. This would be a new field in its
struct pci_driver.

static const guid_t my_driver_guids[] =3D {
    GUID_INIT(0x123e4567, ...), // Schema V1
    GUID_INIT(0x987a6543, ...), // Schema V2
    {},
};

static struct pci_driver my_pci_driver =3D {
    .name       =3D "my_driver",
    .id_table   =3D my_pci_ids,
    .probe      =3D my_probe,
    .live_update_guids =3D my_driver_guids,
};

The kernel's PCI core would perform an extra check before falling back
to the standard PCI ID matching.
1. When a PCI device is discovered, the core first asks the Live
Update framework: "Is there a preserved GUID for this device?"
2. If a GUID is found, the core will only attempt to bind drivers that
both match the device's PCI ID and have that specific GUID in their
live_update_guids list.
3. If no GUID is preserved for the device, the core proceeds with the
normal matching logic
4. If no driver matches the GUID, the device is left unbound. The
state gets removed during finish(), and the device is reset.

Pasha

