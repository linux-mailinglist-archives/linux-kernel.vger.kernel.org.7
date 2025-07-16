Return-Path: <linux-kernel+bounces-733577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 027CDB0768C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40637A344E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6696B2F3C2C;
	Wed, 16 Jul 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gevHEozb"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E9BA3F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671057; cv=none; b=n6nFWPOaOJGaGh0euBgMzoYJK/8+LqWVHmNyCDxQG9n5GrVIZMSIYOggBZDnMpegzMiVAMvxpbj7ixHbRRzmGOU2FVQkeTY63XF9QfbdyGuEaJtTWTmz0H41d1cAFW+3F8Y/T5OXk+fRN4zUG2ZEsUMkY/Gm5e3WvUzKj7efx0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671057; c=relaxed/simple;
	bh=8dZCYt6w2wIjaNRKHHb72EVPPX9qA4w+IQejlPvMmwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGOiLSGNzGTDsZ1oWXOV1zhE3E6ZXUfR4m30ROKG+dc2vTvICSyXg7C+w4en7LLwVqw2z4Tl2CMSOpjHOscwFZSOoZDHsvODKp+4EOdKDTljzNf7loBf+H1WqNxoYV4FnEarb3eOxDrU/VWlrjLmyej2JT0si8AP7SevKelXO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gevHEozb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235e389599fso228345ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752671056; x=1753275856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLAVZJBXA44yj6VwhHi0/bIpO+wiOkRvcyjNUHb7iac=;
        b=gevHEozb2wGZa/PAXLtoH1M7N2mzEsg3+3uuaFTGyh1zwRh6Rylg+Jd96hghPtBuri
         aesbnkNAtlXa2fV9WyotLEEJqkwRUKjO93STm0q796laogzcHUeLe46opzz7hmT6MqB2
         6+zDIHO4u3aCOGahNSZQ3N+lTxNEZ6gkTAmeLBidPxLUgNRYzp4aDGaTRo88Rsrn9Y0v
         4NuOelzM/kFhlGNYdXrJAbVAdwiCjIcZvVTMQ+Gj/F0aFkS0VaVCI+04lJjiueM1w+CN
         FOqMiqvnrTDWVrDwplPgfoQ+ELyb8MoIuz5D+vyQwe8mTxl+EjlqApkN9TkhqjdXruey
         1UsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752671056; x=1753275856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLAVZJBXA44yj6VwhHi0/bIpO+wiOkRvcyjNUHb7iac=;
        b=NxbvFsfy3PyXLL9OLqmH1kQ49CoUmLeZrrnEmarG6cAADOg8uHaahdgwVtGW0hhC6n
         e1RaX/rgxPpw4rNuHo0JN9ctw9jNOTP0w2ZYinZkakRfuoWw72cieLXwoKakItAv7M+n
         N3PQr/mfDjjHh8QNf9tyclzzKQi1p8O/aERIZ//BYJLWVnYYal9xp13Uxvfe6N6Wnh+M
         JO5Hf4GbIsiGnXEKJ5n/SS+d5QsgFR+xNzS4ybT4fb5poEwuDbe49vaE3D6brg34PrtK
         E68VUPeOvnir18JSZQVLfR0xUDKuvDwBBO01TDr/BfnW9Jza5Jq1C4iLafYiaB9kgB78
         Xihg==
X-Forwarded-Encrypted: i=1; AJvYcCUWsU4bM8WZARBg2FtPuMiFe2LCeQ2zeXErCJ8ql0pmlXCV6Ub1aI2llO119zlJ/nmnvlx2DqoJWFXAuJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCkXc46/fTik/tADSvPRlV+R0QHzsyzyfBPNzz/0jEc7rmXrgp
	BXvHgOUy7yaURbuHsrnfFubySKPCooXMvj7x5kMw6REmRPUPyMP5H23mGw4hjR/G+Zj18or/y4P
	wQCFZSuWt30RRZKjplcqzNuVztYi3k2LzQ4SFf3F5
X-Gm-Gg: ASbGncu6BGPwXnODMQsiAR7M2X6qPFPcgt4qEnt8fjmfZtlIpPZps2idG7p31+GMBiK
	l7D7hiblXsCDetdbsEWdZBtBCcCifiGKCzRMDUjOk5Vcw/bbzltTpB5m0+euGcGsLpBL/4p8tXc
	/wPv2eQkgC2K1OjuIc3TLMs9A6Bbq/NofjG7ISsWPBfmUHURr7CbPPqsAxpC8YCMaqmh6AA8URe
	tFiv7iD/DpMuY1cijKmptCyfK2cfNPcitBzTBl/
X-Google-Smtp-Source: AGHT+IFbLmFCf84DLgEZTrPnlX/z0jXT7rSCFSdJKQ9nbT3+zWzNNW5RpYO5vzltezW/SP2qsLvtJkBHsbSo1JZDMwI=
X-Received: by 2002:a17:902:f644:b0:234:a734:4ab9 with SMTP id
 d9443c01a7336-23e2644e3e6mr2258645ad.20.1752671055278; Wed, 16 Jul 2025
 06:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613005400.3694904-1-michael.roth@amd.com>
 <20250613005400.3694904-4-michael.roth@amd.com> <CAGtprH9gtG0s9ZCRJXx_EkRzLnBcZdbjQcOYVP_g9PzKcbkVwA@mail.gmail.com>
 <20250715224825.gfeo5jdqjlvtn66l@amd.com>
In-Reply-To: <20250715224825.gfeo5jdqjlvtn66l@amd.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Wed, 16 Jul 2025 06:04:03 -0700
X-Gm-Features: Ac12FXw7GwQzMGCZjvuciUapFIHKHiW0DMmU5GVoQ0ZpnRjLUR7h_Expq8imx0o
Message-ID: <CAGtprH9Ucr-i_T7pdCFRq63GQY6nWy8668gFoG7NSGdLuzpzRg@mail.gmail.com>
Subject: Re: [PATCH RFC v1 3/5] KVM: guest_memfd: Call arch invalidation hooks
 when converting to shared
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, david@redhat.com, tabba@google.com, 
	ackerleytng@google.com, ira.weiny@intel.com, thomas.lendacky@amd.com, 
	pbonzini@redhat.com, seanjc@google.com, vbabka@suse.cz, joro@8bytes.org, 
	pratikrajesh.sampat@amd.com, liam.merwick@oracle.com, yan.y.zhao@intel.com, 
	aik@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 3:56=E2=80=AFPM Michael Roth <michael.roth@amd.com>=
 wrote:
> > > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> > > index b77cdccd340e..f27e1f3962bb 100644
> > > --- a/virt/kvm/guest_memfd.c
> > > +++ b/virt/kvm/guest_memfd.c
> > > @@ -203,6 +203,28 @@ static int kvm_gmem_shareability_apply(struct in=
ode *inode,
> > >         struct maple_tree *mt;
> > >
> > >         mt =3D &kvm_gmem_private(inode)->shareability;
> > > +
> > > +       /*
> > > +        * If a folio has been allocated then it was possibly in a pr=
ivate
> > > +        * state prior to conversion. Ensure arch invalidations are i=
ssued
> > > +        * to return the folio to a normal/shared state as defined by=
 the
> > > +        * architecture before tracking it as shared in gmem.
> > > +        */
> > > +       if (m =3D=3D SHAREABILITY_ALL) {
> > > +               pgoff_t idx;
> > > +
> > > +               for (idx =3D work->start; idx < work->start + work->n=
r_pages; idx++) {
> >
> > It is redundant to enter this loop for VM variants that don't need
> > this loop e.g. for pKVM/TDX. I think KVM can dictate a set of rules
> > (based on VM type) that guest_memfd will follow for memory management
> > when it's created, e.g. something like:
> > 1) needs pfn invalidation
> > 2) needs zeroing on shared faults
> > 3) needs zeroing on allocation
>
> Makes sense. Maybe internal/reserved GUEST_MEMFD_FLAG_*'s that can be pas=
sed
> to kvm_gmem_create()?

Yeah, a set of internal flags in addition to what is passed by user
space looks good to me. i.e. Something like:

-int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
+int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd
*args, u64 kvm_flags)

>
> -Mike

