Return-Path: <linux-kernel+bounces-848900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58700BCEC77
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5B73AB032
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00032EA46C;
	Fri, 10 Oct 2025 23:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VRS+Wh16"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC52EA159
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760140198; cv=none; b=q3f/nGaL77OLgCa3CIwgzwxhwkRBrLP0BALUp00L4AWs/56qqOIjuhFnawCOADKTmt0GtUAx2/NyPWhmgQ+IB6DK+z1GJrnKmf2vQt0rnvTCTFyiicX9Jd75yVVg0m+XN2jtPHHxDFzxGU3qQbmsBU9ko3Gx4jtAk2qJI0mPTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760140198; c=relaxed/simple;
	bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLMHIILlVE82C/ab415luQQaY/J7ar39BymI328Y5IkOrQuKRPMyyWP1XvqtlG4WCqb1zl4Zx1oi7QVcGzmnchGlzRfTMYfzQPHQOKHFjwgisEoOVHsIiarFI4ur4sj1Hw93n3O3dvo/MOhm0dM0ny/kBxZs5sqib0L+z+lFxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VRS+Wh16; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee12332f3dso1091276f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760140195; x=1760744995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
        b=VRS+Wh16Y7YcSvOJ8peC+LHCIvI/tMJrv3vWti9qnAMz+LR209kEAI3urwmJNJGW+E
         e7BB+kKDZlHw/JwIYlvPzl+MyAoksWn4g9LFWhzWHYgg6+/G+Db2NjzNVDkowXQxHhK8
         g0cBbbAJdjLH0fXMA5Xki4LCIsd/MPdhMwDWthkV8GLRBm1wSZVXrGS7/ItBPZx75Mmj
         +wRA+9qy4WdbTPmtUnt6i4McGSY35VFL4sdujxHjZOCHhBA5yYPFeSwS2YBFnSO7/pSx
         bTWBmgRe5nfMADtukkENU2JWlPwrd01ayRpRuwvH//MvrxqEpIjKtE2oJXVzhVCJUeTs
         8QLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760140195; x=1760744995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWteJCdTRmV6+9s9peexAHreadwYn0foAUOzTTldCew=;
        b=SPhZMKnGQLSlPoK4XSZQkEFXMwOnNME9689ZO17RisW+csQOHVWkYs/ano4fMh9u1p
         2FNWWyc5QCQF+UJZyBFr5saWI5vYP6pk6LfZ6orublbMCdLd8EY9yhIbjM/tJta7UYQW
         cH72NCv/zlxo1T+8m0SPcv0P71D/72r23Z1PIL1HXEskIl1RHMV/D5Og0B6SZE0MrQyA
         GB5sGZhzMc3Xcf4zHzqRJ7X9l2z+t4iFTvX/45dvVZYafRluZGahUfm3QVAM2Lt4uxbL
         W5rN3BmP1CvXOsRN08ZlzEzOdTaYYOXIxAbQzuYj8/vRH9Kx7J+oUoi85kGK3UbS9mNZ
         t2+w==
X-Forwarded-Encrypted: i=1; AJvYcCWEqVlA4HxivHgbuWcAHAMBGXXaicodj0GygrfV4fdf5ys09KbniNTCRdxmK+RdRlhgNLhoD+1Ezyw9Qag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2A6Gvi1IgFiJK7gRPbQg20nKmp+m1rKLwJULbZ5F/A44vpJri
	LKHXLMMpKnvNZfd811XqqC5yxm5U4RtPwF5iwvLfT0AFtxbU2h7kMvR5dLidie/TuE7lPGJkjfc
	bAOjtDc6Rb9Pv+iQBcO3ZV1Bz6p4KlwME1Dd7BdRw
X-Gm-Gg: ASbGncsMdYLTRmV5Z9bDvQYLUq92hWoQbzYA+dGRdJtOWAvA5ymI+nN7TFO5uLtuJSB
	cnk1buwIFts+OBWfN9Ru29ySwb5qSmNeIEmwL9NR6R1F+y21LgQ0TP5fB2gIrFGuRgp2f+m/snT
	/Y9y/ny/IS8sD08qox+x9bYSbZ5hJw2etss6HWmZ1d78mPcKIkIDU7sAXdhhVLEUFyd5gr+2avw
	H2Oyuwx9nvDHOtT/w/hze76L3xfqX3QPKVJUKkCvov1fwPRrSnCyamTgj49Gj945QM/hmkA7A==
X-Google-Smtp-Source: AGHT+IGS7tHdk0+ETIMQ93W4HeQKhAfSX1r/IP5abeF7P47AIA+uA/W8V68hokpCSKCF75Q0Jydg46lHFEFDPVRzp1M=
X-Received: by 2002:a5d:5c8a:0:b0:3e9:d54:19a0 with SMTP id
 ffacd0b85a97d-4267b3396eemr8310605f8f.57.1760140193870; Fri, 10 Oct 2025
 16:49:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+CK2bAbB8YsheCwLi0ztY5LLWMyQ6He3sbYru697Ogq5+hR+Q@mail.gmail.com>
 <20250929150425.GA111624@bhelgaas> <CACePvbV+D6nu=gqjavv+hve4tcD+6WxQjC0O9TbNxLCeBhi5nQ@mail.gmail.com>
 <CACePvbUJ6mxgCNVy_0PdMP+-98D0Un8peRhsR45mbr9czfMkEA@mail.gmail.com>
 <mafs0a51zmzjp.fsf@kernel.org> <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
In-Reply-To: <CACePvbW9eSBY7qRz4o6Wqh0Ji0qECrFP+RDxa+nn4aHRTt1zkQ@mail.gmail.com>
From: Jason Miu <jasonmiu@google.com>
Date: Fri, 10 Oct 2025 16:49:42 -0700
X-Gm-Features: AS18NWAkIO8EZmSKJ-cwcP3nrGVdmHJFmF8q10W7Jv6EeQBfqtNvpvxC46iB9-0
Message-ID: <CAHN2nPK34YfrysN+sraiFVjU_9Lw7E-yFVF-9x+nt1OUppZX8Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] LUO: PCI subsystem (phase I)
To: Chris Li <chrisl@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 9:19=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Oct 9, 2025 at 4:21=E2=80=AFPM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
> >
> > On Tue, Oct 07 2025, Chris Li wrote:
> >
> > [...]
> > > That will keep me busy for a while waiting for the VFIO series.
> >
> > I recall we talked in one of the biweekly meetings about some sanity
> > checking of folios right before reboot (make sure they are right order,
> > etc.) under a KEXEC_HANDOVER_DEBUG option. If you have some spare time
> > on your hands, would be cool to see some patches for that as well :-)
>
> Sure, I will add that to my "nice to have" list. No promised I got
> time to get to it with the PCI. It belong to the KHO series not PCI
> though.
>
> Chris

Hi Pratyush, Chris,

For the folio sanity check with KEXEC_HANDOVER_DEBUG, I can follow
that up. Would you tell me what we like to check before reboot, I may
have missed some context. Thanks!

--
Jason Miu

