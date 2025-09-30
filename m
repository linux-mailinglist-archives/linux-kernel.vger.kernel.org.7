Return-Path: <linux-kernel+bounces-837828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A55BAD560
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1711176B99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFFE1F1302;
	Tue, 30 Sep 2025 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VrsUI5u2"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7A260569
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244070; cv=none; b=ToWbxFazHvwhkOYeGm+uwZ0WkO6NvQ7cbj7U0TXXegxSH+yi3Bb7bCQrYtbktroryrdKp6PAFutSVylETvaQ7MQcgWD9UYG+WAoiooJPmB0q9WQDRekJofELR6wPf09oXrV2l9WibJiajSh2YSyQOcUzImPdMrcgNib5qh7T9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244070; c=relaxed/simple;
	bh=ZaEVr4or5cOiiWh76vrIwiPcXn98KNEC6FATw2gVXH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TjakmjDedU4rq+MTi/e8wAHSRHcekGOaehv3wbc1yTsTpLiSAomZvwv/gUPugnKFfExMzbbvWCwyk3GDqVlY+InBAcpK87GPJfl4i8t+ihez60qAe8f85X8bU7q8LHI0jA2uwK0oFADD7RZ3q4bwPaV4I6AbPP6IVRO997v/nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VrsUI5u2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4dfb1f481ecso38969721cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759244067; x=1759848867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEOBhod7RhHWqheYyAco364m8Vr3uElZmbg1DaQiATM=;
        b=VrsUI5u2aLDo8TiJlCvgmiP1oRPX5zQ1Rd/VgP2tVuuHFQO8Wgr9yAIlI6lPPe6Slp
         MM/AQixaX4DWa/YUyCbQZrGuBkeo6JwffJhcgMgEi4pbLU89NlGr7Kzsxq8NJBB1qzq9
         kR0Sm9oQpP0n/O2OJ+LuEZqy3cX2Md+PrufBcTNOtwMFBEKb4Ga1XgdbmvwVZzPNTtok
         jMJ9hcazzzs6/Ih21A9hq8OUchkTF6w0D4QZ5GwKl+FBnOeye/edSk1xT3/1ryERYDJX
         1ZpL1kmKxojsfcRlw/KuEvRRxyX4wO/bZZdMcbR33xYihrOjrQW76x5omqbnDhQy6UYf
         k7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759244067; x=1759848867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEOBhod7RhHWqheYyAco364m8Vr3uElZmbg1DaQiATM=;
        b=TjgH7EV4XOrUhC33IWhssACRBtGNkJa+aFSfRpE1rpC+7Mxc8XQFKa5bc2kQedV8+/
         6+xVh7CLfyfSODiomG4iRrG2/JH7JSQn3E8QwMY3HnK2+GSfdbROSAbJvdOwv9DXL9aI
         Lqc7pXFvBdXv810snWxhUB4+7VfHg8ESDr/N0tMy9uAiB5E2EfRy18JEd2/03YU6vkN0
         n/AjO78SArC4AfrMCg3/bvLBnw9sBTajKwUJsdQ3qgzxGdjzpr4//IO9qF1nKmJ7wHvC
         CDV8kfTHjIrNGW+lVBGQ/7XUVC1QiDVnosDAV/k2t7WvHygfI+AXO9yxWeqc35fnK/tV
         yBxA==
X-Forwarded-Encrypted: i=1; AJvYcCVzdsZnuqowHNsQdGI02wv8HL9b8JjiVE1LMIP2/u9Ugc29uCsqjYJkCJaRUeVS23tCESTJMDmOH2WpoZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTdkJcVlMEpd4SQB3M7dw+NTL3dgCrhBFCNl6SRZYRaEng3MI0
	KQHmNsIBfzDBY662VL/9chYPgI3ZlPREznbuJJiaAR6w9bp1T2USprxTpAzhNX+4chSs9N5UCP0
	zy8DPgj/RFny9sju/QrLTaL47VK9K4S/owLI+RSo5sQ==
X-Gm-Gg: ASbGncvx/43D+6rxfXsTJObNRta24nbwwjyDHeStOrfk6b1fEgTVara/qAO7YQjka59
	hEnK1wpkbZINugaeVZRZlJQwUN1xzlmb6La6oMc9dD3fo24C/GBl9s8qm1XYVPPe+nWJK88lr0O
	lWBJG7jpBgQYD/I9YGyw5HHRFtupu53Vv4ybVVefauX3MwiIhritkGPdiXe/dGwdcSHuj+g41N+
	vrK3XnXYw3WPQwuCh47xDRmna0lWejfs+1vljM=
X-Google-Smtp-Source: AGHT+IFOfelJUk0OlrUf28WQ82S2leR2E6nLxLlUD+/+zPuAH+3piu1oethsTrwzU7V8ASeo0taITg+SlRBUebjqnyU=
X-Received: by 2002:a05:622a:2598:b0:4b3:65e:76ff with SMTP id
 d75a77b69052e-4da4782da69mr239644941cf.15.1759244067321; Tue, 30 Sep 2025
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com> <2025093030-shrewdly-defiant-1f3e@gregkh>
In-Reply-To: <2025093030-shrewdly-defiant-1f3e@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 10:53:50 -0400
X-Gm-Features: AS18NWDw8pvmBCS0-6-XLE_nnPEk2xIPcwJH7fRLekDAunX6m_kspIDqEfOyowQ
Message-ID: <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] PCI/LUO: Save and restore driver name
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Li <chrisl@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:41=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 30, 2025 at 09:02:44AM -0400, Pasha Tatashin wrote:
> > On Mon, Sep 29, 2025 at 10:10=E2=80=AFPM Chris Li <chrisl@kernel.org> w=
rote:
> > >
> > > On Mon, Sep 29, 2025 at 10:57=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.c=
a> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 12:45:14AM -0700, Chris Li wrote:
> > > > > Save the PCI driver name into "struct pci_dev_ser" during the PCI
> > > > > prepare callback.
> > > > >
> > > > > After kexec, use driver_set_override() to ensure the device is
> > > > > bound only to the saved driver.
> > > >
> > > > This doesn't seem like a great idea, driver name should not be made
> > > > ABI.
> > >
> > > Let's break it down with baby steps.
> > >
> > > 1) Do you agree the liveupdated PCI device needs to bind to the exact
> > > same driver after kexec?
> > > To me that is a firm yes. If the driver binds to another driver, we
> > > can't expect the other driver will understand the original driver's
> > > saved state.
> >
> > Hi Chris,
> >
> > Driver name does not have to be an ABI.
>
> A driver name can NEVER be an abi, please don't do that.
>
> > Drivers that support live
> > updates should provide a live update-specific ABI to detect
> > compatibility with the preserved data. We can use a preservation
> > schema GUID for this.
> >
> > > 2) Assume the 1) is yes from you. Are you just not happy that the
> > > kernel saves the driver name? You want user space to save it, is that
> > > it?
> > > How does it reference the driver after kexec otherwise?
> >
> > If we use GUID, drivers would advertise the GUIDs they support and we
> > would modify the core device-driver matching process to use this
> > information.
> >
> > Each driver that supports this mechanism would need to declare an
> > array of GUIDs it is compatible with. This would be a new field in its
> > struct pci_driver.
> >
> > static const guid_t my_driver_guids[] =3D {
> >     GUID_INIT(0x123e4567, ...), // Schema V1
> >     GUID_INIT(0x987a6543, ...), // Schema V2
> >     {},
> > };
>
> That's crazy, who is going to be adding all of that to all drivers?  And

Only to the drivers that support live updates, that would be just a few dri=
vers.

> knowing to bump this if the internal data representaion changes?  And it
> will change underneath it without the driver even knowing?  This feels
> really really wrong, unless I'm missing something.

A driver that preserves state across a reboot already has an implicit
contract with its future self about that data's format. The GUID
simply makes that contract explicit and machine-checkable. It does not
have to be GUID, but nevertheless there has to be a specific contract.

Pasha

