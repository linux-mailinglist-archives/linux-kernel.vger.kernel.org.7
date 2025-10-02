Return-Path: <linux-kernel+bounces-840625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7367BBB4D79
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B043AAC83
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8127511F;
	Thu,  2 Oct 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/08InpE"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675577D07D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428510; cv=none; b=UEsuf7lPZee+Bcc8YWBPx7lTmWITo9mr7A4cVQLOsPZbUwkZNeZBBbjCLfbdNh+Xoud+rblk4XVQl2dvO17XvzEmPrxPcBJsDc/lHqSitZD969HpXB6aRAltvCKtq44WvokUYTXHpKTxXV362ktoyvQHGoj/wSbEU4NbKzHhzBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428510; c=relaxed/simple;
	bh=g38T6g1L7joJTmSvGU76LmE7YNEsX6Xc26blEFLSnfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuTAozSr+xWZBYDsctgO/daOlrrADTFXI4cw06hHhopnzVJE+ygq1R/B0qhL77Z0Ipv/xB6lLzNGZ+6BbgvTc97E472H1kfRfVBqdWriog3wrgdx0s3QAhTwzyZiglN3rEDQBZMshsR/pRqICFgaHyg5pbUqbXvPOViAXp+15o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H/08InpE; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4de66881569so59551cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759428507; x=1760033307; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g38T6g1L7joJTmSvGU76LmE7YNEsX6Xc26blEFLSnfA=;
        b=H/08InpEDJyQ9+Sm5bZfDoGNWUOpSNfbCatakounaHWUAPaPPO5xMpcFp8Hlp6Gi+Y
         u6aai1aYbIvX7H38wOzsOf+koTFaCZsGUVjMWyO2/rurBc3Umu9s8snazavcV5KepAgi
         TqR9oiFQYIYnhn05tHQJXLGaIO2RDhKNpQGAdJb6VWbRaJQz94yGNFmZT3NE6PVNknzj
         5mzsIfy9iowNW59CEB43iX1yVPhc19FsOYeY+X+GXaLsKH0z711fkLelMeTcCGGETIyA
         8s5NMl5k3UhEh8w6qJ3QbB4LzzXRKeFKk58mSiF75RqJoP7Ha9KUM/IHOa0aEb1OY0cZ
         grRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759428507; x=1760033307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g38T6g1L7joJTmSvGU76LmE7YNEsX6Xc26blEFLSnfA=;
        b=oCMGsNYy4d1UFlQk9grP4mySqsJAjhF5zj4KdvZ/suXEGCcutTxVLfTxPKkA92+xVG
         GxBXwytjgWc+kd6l7tZJSX28KXF628Q2lu3G/2/z7oytBxIlZnNt7l2+tenRrrXQVJdq
         38w02bpsGg8PCN6YiZKidHDPC40cikFe5baaWIpDzdZFdjyKoNW8YgZ7eC45g+GZ12Mm
         fVoGaoDGpAQGpJZJXj1b9vi7nyK1wckEF095norwt2gxAmPrLFkKnnmZuKownl5gn+bc
         CnGkDNopa2DyDyp/qu79XTCOCgewW0NvU9IozCgAFcOj4GMM92NfVv9N90vpwqqgHfzt
         l52w==
X-Forwarded-Encrypted: i=1; AJvYcCUcnPg1LrysOIcsYLs+t5MGoBs4Vvbh6RZXWOqNm1ETqJWCADa9LqSKaFm800jzvX810BJgV1DYYiTTwSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPU2zAHT6z3FD8VK8wCdqlilA9QQjPc3bMfFVXLE4OK6nOT2Cs
	G+hWIiLylIwtaEWUSgbBsdTW078LTGoY71STlC784ek+0qUZWb7qJiYegEExb++TO0dBuAqRhhy
	TikNIEdLNDGpc0QGhzdx4oKqx2jhjstmm42PQtrRF
X-Gm-Gg: ASbGnctB3eMut/3JfN2N0u35KYACDrr5iJ/i3jEG2/S6dKnae2XOKnpE81fBhsd4CNq
	t+McmMw/76g+hHavY/DYXaquzbkrGigoCKtT7ljo2GhYSIWN3o4eGqU3UMpJgJbrmJr4CtrRxvt
	nIXOw0ZpDDGiZnpi9kA5DVAw0oZUE11osJLAlaeV0ww9Y5GlQMhGiOUlDB3mVwWPxRVP2kaTtTK
	7uRKrf9yOkgXB601phJb/Fl9USAnssIqccXRH01IVHjtWgwJ0q8LdO/pLUDhByv1giJtV8=
X-Google-Smtp-Source: AGHT+IFgcqgS6ij+CGSYq6UnkUeAzdjMDFKaA1fGxKd4PkuuqKYQ/kuguF6nULX/Gyc2qNd4HMMNrn1RGTamPFxAjfM=
X-Received: by 2002:a05:622a:44b:b0:4b7:94d7:8b4c with SMTP id
 d75a77b69052e-4e5769456e8mr540491cf.0.1759428506788; Thu, 02 Oct 2025
 11:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca> <CAAywjhQrAWPjb8YtO=+G+pfJpW7p-rwrj03zB8ZqdhB0wtsO0w@mail.gmail.com>
 <20251002173715.GH3195829@ziepe.ca>
In-Reply-To: <20251002173715.GH3195829@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 2 Oct 2025 11:08:14 -0700
X-Gm-Features: AS18NWB8vFBhNg3zLO-LSZdH2zdVlC9_FLZZQKmUF4ohKaV1RcU7Tg5O2RPHFCY
Message-ID: <CAAywjhQsyU4j4wfOqVuLxaVu0FsxuqCCjhJHuk4vcYAo3Cqh_g@mail.gmail.com>
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

On Thu, Oct 2, 2025 at 10:37=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Thu, Oct 02, 2025 at 10:03:05AM -0700, Samiullah Khawaja wrote:
> > > I think the simplest thing is the domain exists forever until
> > > userspace attaches an iommufd, takes ownership of it and frees it.
> > > Nothing to do with finish.
> >
> > Hmm.. I think this is tricky. There needs to be a way to clean up and
> > discard the old state if the userspace doesn't need it.
>
> Why?
>
> Isn't "userspace doesn't need it" some extermely weird unused corner
> case?
>
> This should not be automatic or divorced from userspace, if the
> operator would like to switch something out of LUO then they should
> have userspace that co-ordinates this. Receive the iommufd, close it,
> install a normal kernel driver.
>
> Why make special code in the kernel to sequence this automatically?
>
> > session manager (VMM or LUOD) decides that the finish needs to happen
> > and the iommufd (or the underlying HWPTs) are not restored, it means
> > that LUOD has decided that the VM is not going to come up and the
> > preserved state and resources (domain, device, memory) need to be
> > freed/released.
>
> I've been assuming if luo fails so catastrophically the whole node
> would reboot to recover.
>
> Is there really a case where you might say a kexec happens and a
> single VM out of many doesn't survive? Seems weird..
>
> So to repeat above, if this is something people want then the
> userspace should complete luo restoring the failed vm and then turn
> around and free up all the resources. Why should the kernel
> automatically do the same operations?
>
> Maybe userspace needs some contingency flow where there is a dedicated
> reaper program for a luo session. The VMM crashes during restore, OK,
> we pass the luo FD to a reaper and it cleans up the objects in the
> session and closes it.

These are all great points. I agree, it makes sense. It keeps the
FINISH lightweight and makes the domain ownership model very clean. I
will further discuss the memfd dependency scenario in the other
thread.
>
> > > Maybe the HWPT has to be auto-created inside the iommufd as soon as i=
t
> > > is attached. The "restore" ioctl would just return back the ID of thi=
s
> > > already created HWPT.
> >
> > Once we return the ID, do we make this HWPT mutable? Or is this
> > re-created HWPT just a handle to keep the domain ownership?
>
> That's a bigger question..
>
> For starting I was imagining that the restored iommu_domain was
> immutable, eg it does not have map and unmap operations. It never
> becomes mutable.
>
> As I outlined this special luo immutable domain is then attached
> during early boot, which sould be a NOP, and gets turned into a HWPT
> during iommufd restoration. The only thing userspace should be able to
> do with that HWPT handle is destroy it after replacing it.

Okay, this is great. An immutable HWPT associated with the restored
iommu_domain confirms my intuition that this is just a handle to the
underlying domain. The user can destroy it when it is replaced, or
when iommufd is closed without HWPT replacement.
>
> Jason

