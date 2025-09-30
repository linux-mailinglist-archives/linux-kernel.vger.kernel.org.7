Return-Path: <linux-kernel+bounces-837890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCF2BADFC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1884C0E08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D445309EEA;
	Tue, 30 Sep 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="V/kvH7od"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456EE3090DB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247857; cv=none; b=KpqI2WfsEXR9sWGA9Psq4lP1K0SN9+tt1ezQjo6X0aZFkSnOY7CsZB9/WcN03OY2Tmm0t3c4A6y88TX8QqBkSAlR3vR73jUGnus+0MoihGohH5fogMppOt4UfXZvJuYQWDn4tJk8k+CdyfrRjMhkvZJH0jmzDQA3fYKXJcmXJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247857; c=relaxed/simple;
	bh=B6IblnG/MuGwdljxYSZ5Hog2wlH0TIZoRDin8Y01b1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEnwKizkLkBVJmZFx8HwSb99VvxyXfzdQWmTgH8HIIud7KG0Z/VO4fly3ong40FbPb9JXW+sPWZ/U4DHn3iaGv83b/sZ0YEDvAzk+JwbtqBaNPsKxHQQJMKTf0E5bkRUdWDHMoZoGUB/83d3cT4A37RfodPaLC9UxtsWDAlcRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=V/kvH7od; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-816ac9f9507so1196785a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759247855; x=1759852655; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHJepidzCbOi7utNTLa4sXRDkqkBu/gMK+/6xNAn25I=;
        b=V/kvH7odyEI/dGqdGP3TFp8AT4QPlPDhz2kaiwZ+gvXh0ZuOaEt5kHCDhp/KBQC+5S
         I+RsIfd9eJGE5SQcFSnkfjdDdrIoCx7kBheLoLvIaQpiZQowDv2HQqM5Tg9QWSDQ9dA4
         PtQZ/XwsjtZIwUOBBH9HvQl2g6flor4BRYK/pGp5/q2SwVZ55/v3pNZ1oAGrvXMniG01
         f0J+vR0NDrb/XKuEY4ZKE7a0mznEy8oNJfshMaw5n8O8VUATeHTDkkZPKy6WMfn8xe83
         1vNxOfjE+2WEG+yqUp8sWh6BYbu+c1Qmu19SeEzRARMxuGnOTf7PjMvgj2AwMcSsKWn6
         fEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247855; x=1759852655;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHJepidzCbOi7utNTLa4sXRDkqkBu/gMK+/6xNAn25I=;
        b=tNDXW5EengP2oVtxUIPYL7jcy5KU7Z3bWNs+OyAwiBlfB4XnKOdDIcijN2bo/NcmXO
         4OdfJ6OJUWKhwsSA0fEKXdsprLjjYJROVuqToUDLwgj56UmwTAU2acnXEzEtd4KV0wh6
         lDTPtOXZLh0s8fl6yW4jhFhCRugd4BPKaz6w0rbYOUlnSJK/Tb6HmDj/YOONDpwHd7dr
         djSeFm0nBy/Tmlo18i1m/nQM7SoLPbXuynFEEtizyJ7046IuwJ/yRZtDqM2BFAm2jNkl
         NVrJ96pX12w3RvYLmT2qffssUKuwzWvmPjRwJGjGPID5iInzKrtlRKa80OsNd5SF+Er5
         hn1g==
X-Forwarded-Encrypted: i=1; AJvYcCUf1GFDzZrm5xLWuGCFwhzW0WorwaguGMDk4KXk52jdjTYDAUIZKbgdGP+13lCvSP8qheES5rB8zXiGIuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6D+orLDXmkKtELV619IcA1Gzo1+s2QB/+ISdUCvGqR2WobSHX
	1/k/IQf1Ef4KW/HgEDgia6oCovRMEMqEo38+/6/S9euEdINrOjeXIcyeA8d7PToSkq+lQg6N/vV
	HS5eKM1WNfQP8Fm+JBi7ImQyPfkbR8qgn4SYMPy5FrQ==
X-Gm-Gg: ASbGncusOw6na+6Y33c76z8iRwNBUfGJ/hivlfgy3KcY/4rzvoEw7UhFr6Q84ltERqC
	rlaX2ow5Mvso06guNd5MZX+kAA3BpwIswkd2ykxVKQxQW6hU3Tuedlxq+R3jofLhBpVIfX17h/S
	amAYTgLWg+aCzZb210PRciI/lcjh4ZshI8+4ubWR/FzkplXhcBGcGc5RVPEeeJSriiBvuLLbT3x
	jseDSKc+Vj9gHz3d24FzQ4rEGLA
X-Google-Smtp-Source: AGHT+IE7WCqMW1fSLIrerjKiAvUKyXXisIfzM7mki8QeLnI8zBm3PcXEhU/qnT9KNwTUSb+prxtGZqv5NgHyFA8q4H4=
X-Received: by 2002:a05:620a:17a7:b0:7e8:8086:cb83 with SMTP id
 af79cd13be357-86ee0f481bdmr792664285a.28.1759247854941; Tue, 30 Sep 2025
 08:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-6-c494053c3c08@kernel.org> <20250929175704.GK2695987@ziepe.ca>
 <CAF8kJuNfCG08FU=BmLtoh6+Z4V5vPHOMew9NMyCWQxJ=2MLfxg@mail.gmail.com>
 <CA+CK2bBFZn7EGOJakvQs3SX3i-b_YiTLf5_RhW_B4pLjm2WBuw@mail.gmail.com>
 <2025093030-shrewdly-defiant-1f3e@gregkh> <CA+CK2bDH=7H58kbwDM1zQ37uN_k61H_Fu8np1TjuG_uEVfT1oA@mail.gmail.com>
 <2025093052-resupply-unmixable-e9bb@gregkh>
In-Reply-To: <2025093052-resupply-unmixable-e9bb@gregkh>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 30 Sep 2025 11:56:58 -0400
X-Gm-Features: AS18NWDk81gPmO8jdYOvQy6qk9PYN6n2gt1XQ1-52Coxf1yRAsL01O0lrYTm39w
Message-ID: <CA+CK2bCBFZDsaEywbfCzDJrH3oXyMmSffV-x7bOs8qC7NT7nAg@mail.gmail.com>
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

> > A driver that preserves state across a reboot already has an implicit
> > contract with its future self about that data's format. The GUID
> > simply makes that contract explicit and machine-checkable. It does not
> > have to be GUID, but nevertheless there has to be a specific contract.
>
> So how are you going to "version" these GUID?  I see you use "schema Vx"

Driver developer who changes a driver to support live-update.

> above, but how is that really going to work in the end?  Lots of data
> structures change underneath the base driver that it knows nothing
> about, not to mention basic things like compiler flags and the like
> (think about how we have changed things for spectre issues over the
> years...)

We are working on versioning protocol, the GUID I am suggesting is not
to protect "struct" coherency, but just to identify which driver to
bind to which device compatability.

>
> And when can you delete an old "schema"?  This feels like you are
> forcing future developers to maintain things "for forever"...

This won't be an issue because of how live update support is planned.
The support model will be phased and limited:

Initially, and for a while there will be no stability guarantees
between different kernel versions.
Eventually, we will support specific, narrow upgrade paths (e.g.,
minor-to-minor, or stable-A to stable-A+1).
Downgrades and arbitrary version jumps ("any-to-any") will not be
supported upstream. Since we only ever need to handle a well-defined
forward path, the code for old, irrelevant schemas can always be
removed. There is no "forever".

Pasha

