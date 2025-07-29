Return-Path: <linux-kernel+bounces-749562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8660EB15001
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 17:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F37EC7A4224
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24A2857DE;
	Tue, 29 Jul 2025 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Cs6YWwfl"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BDD158DAC
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801754; cv=none; b=Akm7/IXU0DerYytK/C9eWqSJEEHICKzedFxqeyjk0FzFpcotxctuXos1r13m6HZi6wgvzaUB95t9GvTwBCFakBy788gBUibneXsr315vvxZx3lcNnGi4FIUPqm6jiuovzwPC/aoxGYRsd45xcmi3J/Uekjpjodak881cALSyWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801754; c=relaxed/simple;
	bh=zuJNRAPFeyA6IJVZOGMjCV+D6yJpmh+V51glzUJ4TKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FU4VIBjF7fyvpEtF2Vg+nXmi/7dWXjxyJtMDgqV3Cer0lre0Jko6i7XxN3231aP+Fdfw3/DSRWZo5G0iZFhe3TGJzQIZmx0BKyL62JFQExPOMdb15ODwEk5lrdJFFnZSfACRQEKGUeIuB80gg3vL2UzEiMCFiHt643FvPXA0p3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Cs6YWwfl; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e8e24765e5bso1201625276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753801752; x=1754406552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CLQbmTKfAtMP+r8dxThnkiPOrsvJMHhb7grP3nOtq1c=;
        b=Cs6YWwflM0omrSYakT5gVNVt+FE85wPapuTN5N+IgXU+Hg9x2/nGj0VV7oSNBljndV
         k7lPvhz5Zr0XI/XWgdBXvfvyod2un0VcGMTSK707WNSeWr63bu6Y3u4V1AbaoRAdgFkO
         W4nal22sZafQPaoSehFU5S6qJwdFPE+ZtK/p3mGa7m8SvVD6kX97FFa0mHzi0mSF5Rnx
         vMbccCZIPVRDi6Ls9GhdKL+IgYlj2n9AyR8JCMR9QjrW1DYrVETXw5gbMBwht2BuLLYz
         IoO0fRy6jQc3hIkfLyCZveprKZzq96ZHOp9v5ZNfwwyZHLyu9H17ix12pWC18lIpbsnb
         byeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801752; x=1754406552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLQbmTKfAtMP+r8dxThnkiPOrsvJMHhb7grP3nOtq1c=;
        b=TA4t9oLeCPHZ4f1xCgJYaEXyDZDdVJvsY5B/yw99XHsvt5rfkqZIfHxfZ8FhwzLehm
         wCo9p8K/aDYHRmWl8mY79VAFeG5G7U4Ib+KdxSP8/QxH4e/S6cBOZHbWseVtRFQcMf7B
         BmaRhld9ZrnuU9ejYrXWpD6bgJFq1/RVoNeIJn8tme5Jir1b2F1riqeFM+SoUHNC/eL0
         gggOTCWulG2cMrFzfo5k+ifsjACEme0F+KWzKpOc3/S5OERcj658Z5bvDdrQwgj6Gtxf
         KlEIFo/D6enM+iM3bG8sx9RYFQbTV7x2a0n7zNXlsjAza8nVZkekJRTsr4ZaVbh1f0+9
         LlTA==
X-Forwarded-Encrypted: i=1; AJvYcCVYUNvD7sF2bD271ht82tCX3bAhTmiGDchpOa8nnzeQn1WiMPAVr8+0OLwRg98U5HreUg7+NbxlYVXv2pM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO3ynn6G99I+3pMnOmd6T8c1ClVc+I57nSxn1ztHscOfV8e8hv
	5/w8ZRughmljYKTyNwjd4JTZoPrQ/4+CYCa2YAcapQZGaOiThMRrDIXDkYYzKAfa6CJKJIrbSH1
	bHZG/0h/paxHyw+p0OU3MiOUKfJnjzVLtYWVTKvLf
X-Gm-Gg: ASbGncsqfW/ByCbZharVno1nOyZt0ioyAnRvuhn/I3vPsmab6eAImUOCO6OWAKZzTF0
	6NmZYoGrdY0VJDKB2z3uxifgTEPIeGERqOSbK8mj7AIZW8ukfnraSWpMMAyWSWuKslyOHqYAQQD
	S7cqfOB0Z4umKhTiiPjDUVAL3GSFZPciopM4FRIZbvaq9ZugH7OgbiYq6gceH0Mf+V/cPLjaacu
	yurVoU=
X-Google-Smtp-Source: AGHT+IFxmfEJzdGddKG4BQPd2LIH0BpZp63Qdw1g0WUVb/kFvWaAZRnwZXLkZa6UnWULDrqC8BI1dP/sBW7JbavWfC0=
X-Received: by 2002:a05:6902:4793:b0:e8e:187:c241 with SMTP id
 3f1490d57ef6-e8e314a0160mr74298276.17.1753801751812; Tue, 29 Jul 2025
 08:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com> <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com>
In-Reply-To: <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 29 Jul 2025 11:09:00 -0400
X-Gm-Features: Ac12FXwNBhPktJtJ0PzDLqsmh5A5sTlKa0vey67atCJTRczlsnGdTNEDK66IhgA
Message-ID: <CAHC9VhQAVvvXUoFu7xnh0uBhmvgYinP=AhiC4y17JJ02M9s5Nw@mail.gmail.com>
Subject: Re: [PATCH] lsm: simplify security_inode_copy_up_xattr()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:43=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 7/29/2025 2:09 AM, Tianjia Zhang wrote:
> > The implementation of function security_inode_copy_up_xattr can be
> > simplified to directly call call_int_hook().
> >
> > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > ---
> >  security/security.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 596d41818577..a5c2e5a8009f 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -2774,13 +2774,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
> >   */
> >  int security_inode_copy_up_xattr(struct dentry *src, const char *name)
> >  {
> > -     int rc;
> > -
> > -     rc =3D call_int_hook(inode_copy_up_xattr, src, name);
> > -     if (rc !=3D LSM_RET_DEFAULT(inode_copy_up_xattr))
> > -             return rc;
> > -
> > -     return LSM_RET_DEFAULT(inode_copy_up_xattr);
> > +     return call_int_hook(inode_copy_up_xattr, src, name);
>
> Both the existing code and the proposed change are incorrect.
> If two LSMs supply the hook, and the first does not recognize
> the attribute, the second, which might recognize the attribute,
> will not be called. As SELinux and EVM both supply this hook
> there may be a real problem here.

It appears that Smack also supplies a inode_copy_up_xattr() callback
via smack_inode_copy_up_xattr().

Someone should double check this logic, but looking at it very
quickly, it would appear that LSM framework should run the individual
LSM callbacks in order so long as they return -EOPNOTSUPP, if they do
not return -EOPNOTSUPP, the return value should be returned to the
caller without executing any further callbacks.  As a default return
value, or if all of the LSM callbacks succeed with -EOPNOTSUPP, the
hook should return -EOPNOTSUPP.

Tianjia Zhang, would you be able to develop and test a patch for this?

--=20
paul-moore.com

