Return-Path: <linux-kernel+bounces-838231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3264BAEBD6
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550B81C3F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE3021ABAA;
	Tue, 30 Sep 2025 23:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ImT/5sB"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB581C4A0A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274158; cv=none; b=W3wlaWffiF1oEWhEbnGZlWEEgQnREtEJP3wPlYM5dodf/8r4YjQIGH+piGYe6qkzjUmO/FhQZhxKt1QDgNSKMK2/54KnDCoNQ3wNFiRCE4MC40cYn8fDstkJH4Tl1Yv/CaQnLUjPNB6UhwHvRvhJRQUwAC6YDOANa/U0mIwW6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274158; c=relaxed/simple;
	bh=avL1rWBunFTgSKQhZqowxnKhVr1RP4S9GV/sye2EIP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5f7aHTcn4XYp+yIhmnA+LbZMnI3dby8Q5pIsnMxAmvME2ytoP3BSt611ixhVDNt8OxKitnsvicUMiHIbS29mk9GGQj0N6cwoS59faiXPQwWzMvtxTiMvA+SR+p7KtmlB3bp6NE35uIWiPf6Owpm3te4QCurhChE/t9e1ErJ+Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ImT/5sB; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4de60f19a57so174791cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759274155; x=1759878955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avL1rWBunFTgSKQhZqowxnKhVr1RP4S9GV/sye2EIP4=;
        b=1ImT/5sB2iHpNy5eVP2E26qRi98JMN5rSppw//43Li++1/BVY6Ai7El3N39WeTChT1
         9v+q9mSK/2Y5hjwS6c/nlExa7qMgwpxCQIJCLQre4c1g6cy65znQ1G7xrTRPLenYokds
         /s8dauIBdOJFmxpudXc+qVH9es/nkMg3KJy7jYqgyNq8iWqCE8/vMrEzMherBDFfBpGj
         Ni6a/mXm0CnUkVG06F7F0ggQIW861324j5aTtsAdiiBjRGdIhTZSQermNYLQRTI7R/3r
         kNHn20KqbdHLdLZE+Cxxt0ohUHW4ca7OQrRUrp+eq5f/rDkEHT3x44gEr0YKk6mpxqfR
         52bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759274155; x=1759878955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avL1rWBunFTgSKQhZqowxnKhVr1RP4S9GV/sye2EIP4=;
        b=eDxHaJcnuystGOed/NzGnYM121CPNDAF7T2qrkQt92jsO+wsBLyT9FQVTaiUxafxJX
         EblC9tsRf2DB/CSBvi1wAtdwwzlyUC4dmNSJuSr7Sakh+itJSgq/b2AXy+Dn+5k9wbEB
         LGIutC03LoW3g8Q+XgXRJ7MrqzUx9xg8owSVVlxjs5VfVIpFFA9KiraI68RgH4U52O1U
         W1TG8iaFzH42oqmxMpfvD7Q/Afzw5eJ3YFIv1tAIvgikBbnylBG0Jw5+ZZlJxcEaQkfU
         8pELFlP64Que+xTXXgOO1Q9cdx350O1pI4D363gdFjPNRGT+Jv+FtEUiR1OBRLIEpgfL
         1TRg==
X-Forwarded-Encrypted: i=1; AJvYcCVMiSErEReLLmbWnp3HWAIetF0PeyBgNuOouxTA4S9TZyWXCnYvB1Kxg9iM1vWVu0Gs8NcKzjHhWdZCZiU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4TyKxvpDax3GWCMdX3POghz8tbPQMp8t6vVryS4Lgdj7/6Y3A
	dYcduWCWuJ7DoXSTcEPgQ7qR7tISvCQ/UjiRLKX2iSu+QoLKfQYsI6Dleiryk7TbAoNWQYUtLax
	GpoqMLu/nDQEAK5rBqux0l+U3SQtEx3oqtcznXw5o
X-Gm-Gg: ASbGncsQzi5ClYuKQWoKWN1hgnYHtuI/5lYbLXJcx1hVrXkiEInHoCYw6MhP6+Xpke1
	zScDqPeDxVZDGf0XmOhdgU8z+s2jM8afSQscDkXh8I2agqqUXXsJ0NOrwTLcrY6JTEHHrqvBWSE
	PaXpB11s0Ccb83HWRdUzeS5gjSxmTsPSTXoRBj/wIerS3o9W5IE/jifK/L+8WEODQDnkKuOqN83
	Z/UOU4VO22F0xZrTIPznS2vpXtTIsS59Bl7HylrxTNkUiDP1Mt4xs9scZuMXyIM3L6s2hcU/R+/
	TDw=
X-Google-Smtp-Source: AGHT+IGPIoxnc9wl9XoB03dKZCaUowW6vVnO/ky57WoBHCiNTAZb+mWCRVcb+zmztZVZ9ReoYArCalm5QPGFPsWdPdY=
X-Received: by 2002:a05:622a:30a:b0:4ca:c49a:549d with SMTP id
 d75a77b69052e-4e45111f774mr1258111cf.9.1759274155027; Tue, 30 Sep 2025
 16:15:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca>
In-Reply-To: <20250930210504.GU2695987@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Tue, 30 Sep 2025 16:15:43 -0700
X-Gm-Features: AS18NWBnk-42w8cdejF4xgnkLcF9Jd68pR7aYC-MmhJCljNRDOOGNN7hUI9RPdo
Message-ID: <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:05=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, Sep 30, 2025 at 01:02:31PM -0700, Samiullah Khawaja wrote:
> > > There are HWPTs outside the IOAS so it is inconsisent.
> >
> > This makes sense. But if I understand correctly a HWPT should be
> > associated one way or another to a preserved device or IOAS. Also the
> > nested ones will have parent HWPT. Can we not look at the dependencies
> > here and find the HWPTs that need to preserved.
>
> Maybe in some capacity, but I would say more of don't allow preserving
> things that depend on things not already preserved somehow.

I agree. I think this makes sense. Users can explicitly indicate that
they want to preserve HWPTs and iommufd can enforce the dependencies.
>
> > > Finally we expect to discard the preserved HWPTs and replace them we
> > > rebuilt ones at least as a first step. Userspace needs to sequence al=
l
> > > of this..
> >
> > But if we discard the old HWPTs and replace them with the new ones, we
> > shouldn't need labeling of the old HWPTs? We would definitely need to
> > sequence the replacement and discard of the old ones, but that can
> > also be inferred through the dependencies between the new HWPTs?
>
> It depends how this ends up being designed and who is responsible to
> free the restored iommu_domain.

Agreed. I think it depends on how much is restored from the previous
kernel. Discussed further below inline.
>
> The iommu core code should be restoring the iommu_domain as soon as
> the attached device is plugged in and attaching the preserved domain
> instead of something else during the device probe sequence
>
> This logic should not be in drivers.
>
> From there you either put the hwpt back into iommufd and have it free
> the iommu_domain when it destroys the hwpt
>
> Or you have the iommu core code free the iommu_domain at some point
> after iommufd has replaced the attachment with a new iommu_domain?

But we cannot do the replacement during domain attachment because
userspace might not have fully prepared the new domain with all the
required DMA mappings. Replace during LUO finish?

This is actually very close to what I had in mind for the "Hotswap"
model. My thought was:

1. During boot, the IOMMU core sets up a default domain but doesn't
program the context entries for the preserved device. The hardware
keeps on using the old preserved tables.
2. Userspace restores the iommufd, creates a new HWPT/domain and
populates mappings.
3. On FINISH, the IOMMU core updates the context entries of preserved
devices to point to the new domain.

I have a sequence diagram for this in the cover letter also.

I understand the desire to have the preserved iommu domain be restored
during boot so the device has a default domain and there is an owner
of the attached restored domain, but that would prevent the iommfud
from cooking a clean new domain.

Maybe we can refine the "Hotswap" model I had in mind. Basically on
boot the core restores the preserved iommu domain, but core lets
iommufd attach a new domain with preserved devices without replacing
the underlying context entries? The core replaces the context entries
when the iommufd indicates that the domain is fully prepared (during
luo finish).
>
> I'm not sure which is a better option..
>
> Also there is an interesting behavior to note that if the iommu driver
> restores a domain then it will also prevent a non-vfio driver from
> binding to that device.

Agreed. I think in the "Hotswap" approach I discussed above, if we
don't restore the domain, the core can just commit the context entries
of the new default domain if a non-vfio driver is bound to the device.
>
> Jason

