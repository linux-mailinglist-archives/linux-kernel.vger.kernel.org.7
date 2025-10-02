Return-Path: <linux-kernel+bounces-840881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB3FBB5A51
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 01:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9728019E178B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 23:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BF1287508;
	Thu,  2 Oct 2025 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKv/9rlD"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA71A927
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759449431; cv=none; b=hFF3gZfgejAu0ebWwUQeFOKYgIQ17xl9YUWxq0hQMnRWXzsK0HaAH9dN5bwfz5s6rKnTQCfXwtg28MNuuRtvIL6uOPsIE8Szexqhw+oto9lsCVB4TYQBEIPA8W7tp81MdKSxwDy2uN5A7iZ5N6RFBRZrpRSltXYNH07wv45XnIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759449431; c=relaxed/simple;
	bh=6DYQ3CsM0QwlUcHSns62zmWuEfYU/yp087Nd6+EjwJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDqa8dEHZchutrjq1SBZPwUqdIIO0hQoopeuMqG2H+rtRW92IFv0OWehCnLVu+sHQ6Btt4XpKKLNs4CryyqB6TvBRpX2NFW65cKK43YJDpH4lTCc6MJf9NPYtMIMEXgu9EE8hhaC1OY9ThhYlH0aID11SafS28ZdqvSMNIy3SvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKv/9rlD; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4de66881569so195031cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759449429; x=1760054229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DYQ3CsM0QwlUcHSns62zmWuEfYU/yp087Nd6+EjwJE=;
        b=YKv/9rlDhSiPVdh/vyQlA863K45dr06YJ4YdToQtRFKzM2NAugE83TGPpQc1bzje/5
         oMMf8YvkvpVlWbcCqONxovT9kNklxn2tJavhu0wcoKbBGjSUfs8WsHDI7QoBBMx3rpzq
         xUwGv8x0IP3GdI2fnU+tvQp6n//2BtKIFZMxXLkOAxgo+dON7jozlV0Td5zCOrxXas7D
         iMtFrifaUQRLmCjsJJLtvoCrSrLoJIt6N6I2wEA7ku2p+bY9ZqFCg1jTzswCeoC5wIZK
         KrpMWM84zLCQzdx5yQe1qpqnvYZoIOeJnM6eR3IvxCNYYDFVHbQs5gJRF1IOJIUSwnrd
         qRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759449429; x=1760054229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DYQ3CsM0QwlUcHSns62zmWuEfYU/yp087Nd6+EjwJE=;
        b=mFbo9KuKLXLSKaehWf19eJ3B69yN9Fno9lTe4zO7jAMu4c2uarazzCP0kwyq//qGBK
         aAo9/bomIecDIA9RwcYVHpqaPZLOJWJquj5JQ0kNhL7lSOzZgTSDhNnprct3hzbjVHn2
         BVxGGW9+90FeIxJh7uIQ4PmdJQUNd1mrQKBFTHfITEcwPWjJ2oVy+nlfFcXGZrVxPK4b
         W+TNQyB/Idi0gG6WIwJZYjEqUc2B7XcHu5B35/nSpZb1pIdaXdOj1XOf7NeaoIQjf/xy
         xuvMBxzFsBEZuKoW2mBYB5yvCd2W6NDpCSrx9bwELu7duEIor+EAo3aH06augrq5skCy
         1g1A==
X-Forwarded-Encrypted: i=1; AJvYcCVczox2+dkKnituXLNITc5QOMAFNV+YnPapS7ZmsfmvVdDh+JpoX1JGIMndkvzpC7cZjrCMizp27JDuKw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXT+KTO/i7Vwkc551dmf+gkpaDBV3F+g5mll+hiSaZyMIXGPlR
	gMXAzUYTa3fuEjXNkeDho3kHsPvNHDXdy9HA3tuYd90ITyGfBH4RsEWef/IPdZWOy37BpEOWiBj
	m8CaBDOICSuiMBPkj5DsuNfPMYWTFKsDKqen4Y/ku
X-Gm-Gg: ASbGnctuBZcM68bNETHBV8/8sEZVxOAzR+1yGQdIIZ6isQYaOGmO9G3wno7YplacSMF
	ex8L4brKh4A1gd3+sWOB4XQUxqdXPzytXo8Le1Zp/B+/NQMH+jHKuIyzHFWJo3N5IPUT2dwqQWd
	DAvFwEYo0H8mAn6iqerk+0J0JZDCpP1/5sHugFoYGzl4nvajZKfXMwT0Oq7YtLn/mJOfMt5BZSL
	c+8OxzpJorQVDTL6+5dJmwMRnVGllHgT8FlLx8nfQIjGXahJS6oto1aauX2QvRzmMfy8RXELx32
	NWs=
X-Google-Smtp-Source: AGHT+IGr2ovY2PKoHH1pUShHgVnHK4SNmDcVHy2Pvi/heXQZDU5vNspYDt8i9ng4dAFLZKDUgXguuJTgTwstmdMpOrI=
X-Received: by 2002:a05:622a:9005:b0:4e5:7827:f4b9 with SMTP id
 d75a77b69052e-4e57827f4e7mr757181cf.3.1759449428869; Thu, 02 Oct 2025
 16:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CA+CK2bAvnTTz+vPg7v38_1dajRZQHyPQ8iDmziiW8GFUqy6=Ag@mail.gmail.com>
 <20251002115712.GA3195829@ziepe.ca> <CA+CK2bAudSHq2t5NZPBKDC2wfzsF6SSxTF7aZ2kxueOTzWYcfg@mail.gmail.com>
 <20251002151012.GF3195829@ziepe.ca> <CAAywjhQGQx2_2X8r0rf3AgMDbJj-9C=9_1a3xgiLwuzKLAvXCQ@mail.gmail.com>
 <20251002211217.GI3195829@ziepe.ca> <CA+CK2bBJ_RoRuCxiHuraDH4Gya-ZON3S6PE9PgPfsxObvBRY4w@mail.gmail.com>
 <20251002225834.GJ3195829@ziepe.ca>
In-Reply-To: <20251002225834.GJ3195829@ziepe.ca>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Thu, 2 Oct 2025 16:56:57 -0700
X-Gm-Features: AS18NWCWM0pP6cWdsNU3tiI37HhQqHXT3KVR39h8qAlDJKKejqt4C9jChSJRnCk
Message-ID: <CAAywjhS77-Kw7GVgksimZ8-Oy+kSvCPpL8xQfJt0eQHwf=WH_g@mail.gmail.com>
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

On Thu, Oct 2, 2025 at 3:58=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 05:30:53PM -0400, Pasha Tatashin wrote:
> > > Maybe finish is too broad grained? What if each session had a finish?
> > > All the objects in the session are cleaned up, invoke the session
> > > finish and the memfd's in the session unfreeze?
> >
> > All sessions have their own finish:
> > https://lore.kernel.org/all/20250929010321.3462457-15-pasha.tatashin@so=
leen.com
> > LIVEUPDATE_SESSION_SET_EVENT
> >
> > Each session can go into a "finished" state independently. However, I
> > am still thinking about whether a dependency graph is needed. I feel
> > that if we require FDs to be added to a session in a specific order
> > (i.e., dependencies must be added first), and every subsequent FD
> > checks that all prerequisites are already in the session via the
> > existing can_preserve() callback, we should be okay, as long as we
> > finish() them in reverse order.
>
> I don't think it is quite that simple, like "finishing" an
> iommu_domain cannot reconnect it back to the memfd. The only way to
> finish it in the current sketch is to delete it.

Agreed. But I think we don't need to reconnect the iommu_domain back
to the memfd it depended on. All we need to ensure is that the memfd
remains immutable until the new HWPT replaces the old one that is
pointing to the restored iommu_domain. Until that replacement is done,
iommufd's FINISH callback would keep failing, which would prevent its
dependencies (like memfd) from receiving their FINISH calls and so it
keeps them immutable.
>
> So if you have a notion that finish is disallowed and when it is
> actually finished maybe the order doesn't matter?

I think FINISH for FDs in a SESSION is not atomic. If a dependency
memfd gets its FINISH call first, it might make itself mutable before
the iommufd FINISH callback fails because old HWPT is not replaced
yet. By then, it would be too late; the memfd has already become
mutable. That is why order would be needed.
>
> eg it doesn't matter what order we unfreeze memfds in.
>
> This sort of assumes that something outside luo is still ensuring that
> no disallowed operations are happening to the objects. eg nobody is
> trying to ftruncate a memfd.
>
> But I don't quite know what other objects besides memfd are going to
> have this special frozen state??
>
> > There are two issues:
> > 1. What do we do with LIVEUPDATE_SESSION_UNPRESERVE_FD ?
> > We can simply remove this IOCTL all together. Stuff can be unpreserved
> > by simply closing session FD.
>
> This is for serialize error handling? It does make sense if some sub
> component of a session fails to serialize you'd just give up and close
> the whole session.
>
> > 2. Remembering this order on the way back, and since we are using the
> > token as an iterator, that is not going to work, unless the graph is
> > also preserved. However, now that we have sessions and the token
> > values are independent for each session, I am thinking we can go back
> > to the model where the kernel issues tokens when FDs are preserved, as
> > each session will always start from token=3D0. This way FD preservation
> > order and token order will always match.
>
> You could just encode a preservation order numer in a seperate field?
>
> Jason

