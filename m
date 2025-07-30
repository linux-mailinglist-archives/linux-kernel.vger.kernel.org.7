Return-Path: <linux-kernel+bounces-750991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901AAB163C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B842416C6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AEA1AA786;
	Wed, 30 Jul 2025 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Sun8qJ61"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D1F433A5
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753889760; cv=none; b=UE2iABeDnl5//NJp4fkQ+LfhYHOJinY0LS8WK07U1uaAnYf/tD6NejnKvSyNDZ5+CB0ct7R9cAcHLzKzbITE1AKA/vleCpE5Sv8dYCGETmnBFUcSHiq+nCPFLGlsDnEZXvzp9XoFDyodvunvxyT4CnK7RATwP/egM2OJ9osc/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753889760; c=relaxed/simple;
	bh=Fn+JoHGu2fmkl2V8wuLwnhatCqJPEW/WjG3PFXvz5Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTct3ffjkwSE59ANolPNJAsXV9rStT8tbm0a1yeH/9tBZzaebFFR5QPtgYKz/sCuOn+0kvc19HOB86jo/jKePU9uomR5IlZin+JOj04NnWYZK3zGW90PtzDXRmOHuhUo68Is2NfoNUSyLGeUqJHhi6lMXKFhkLpuItazuV67XQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Sun8qJ61; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8e21180c55so2580136276.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753889758; x=1754494558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYVwqY2ETDDR+r8F+Lmb7APTZLHZrnbDJy59pL4+VDE=;
        b=Sun8qJ61lPaujzr7yEE7INgIVrK+z/PagX4y1+l/mlZItIflc6xuYwuafCqkBT/8qn
         nEo67zS3vWNHxSU+1twcTOhsku4pXbDt0R+PTUvdvNaerGygAmNlyZj1G1FeyErUX2TX
         rLjKyMRkBiQH/fbsOqttVUBo3/h84VhytWiHD5IFDn1oNyZl9fYrXfSrpirG/hYJt7ob
         kZp5cI8m0pQRoLLoYi81jGM1OWhTTURq3wQ5HWwhuvw1UwwymogexfndI1HkvmyfJUtZ
         K41ILu+2v3psSQWzi1CH/u3TDn6E358r9nTRhFc33+Aj/tXFogYYKpBLpQNdmQAJUH5k
         SWfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753889758; x=1754494558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYVwqY2ETDDR+r8F+Lmb7APTZLHZrnbDJy59pL4+VDE=;
        b=VxEN1ULpMlqQvCEffQoK/wbB9Di8Bve7UT3nb6nh2nD8fb9+Gx+L1ra+0gZqlpKuHc
         lTFRq1tN79hfTuyDtRLDr5G/uIwQNsvrvaY6wnR4iKuOX7rGf2ldfzcVUhqhW3w4xN1N
         nrffmDSv51Y4Pt4Acox5nXzWoaiBuMxsmxAclk1D2e5MlRYpobHJv7ioZmUUbwJbGPYN
         jrjubAPByR/P15Y0yPmUuV8BC3Yx31+Wof1REwbrsehOueP6ERykLVu+Xni7YB+Qoi9K
         1hc+XoHpGPBYHfYlh3TrLPWWQsu5gfeYC1JknKqr24DAfZPWwLskX7b1ahk4RFu2dp7Z
         vlPg==
X-Forwarded-Encrypted: i=1; AJvYcCWau2wZpI4e6YUZbSg5gvc7djPC9geE2l3RLrtFHzmSKmU+GfDsGx+i1fJ/A0qiNn+lB8hw2DLPAthaiRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60mLXi3ResYV0VSjAMi2X+/2Il5nxQsPyO4J3DawyKcaWVqyX
	RFUgokfcQ/YR/G6OPjO5MNCcJcqKeykrLqRTQIvRUMsg6m9P6MNz075wICLPUyXcmBcqhD2a5T1
	3P3G5cHSPIVXbMSc8nckXebKrB6MoHb4DYIX1WmCnKHpGA2Or9YE=
X-Gm-Gg: ASbGnctaX6bzE8l/Ht7zJbD9TY3CgQmV1k4DOlLa1NklZL8iB7RuDMq3Z2SfjIqU+7g
	hpcCkvbY24T91wcJy+JklHgomm4GqwYbTGKokfqV6mhoYmBqBDr/W46Pe+rr0mobmOCBhzRAjX4
	c9jEnSM23hiXK2BHiqEibLWrlDtaXm+SqXlYFB1odA04rOgPlkzUNDHDmKGLcTO+SSsztNl2nJu
	smV/l4=
X-Google-Smtp-Source: AGHT+IGjgexjMCxSTA/9heTLxOWR5U+m0nGq+jGDNorEMw/O+tX1NfjXbc3s1L9+tpttq3ce9sidcKvY8R/vZFsyc48=
X-Received: by 2002:a05:6902:3484:b0:e8e:2e63:80e6 with SMTP id
 3f1490d57ef6-e8e3160271dmr4217022276.49.1753889758046; Wed, 30 Jul 2025
 08:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729090933.94942-1-tianjia.zhang@linux.alibaba.com>
 <e81ba8e7-8938-4b76-ae7b-bfee6021aeac@schaufler-ca.com> <CAHC9VhQAVvvXUoFu7xnh0uBhmvgYinP=AhiC4y17JJ02M9s5Nw@mail.gmail.com>
 <c946ad53-15c8-497d-863b-a237e6c4466c@linux.alibaba.com>
In-Reply-To: <c946ad53-15c8-497d-863b-a237e6c4466c@linux.alibaba.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 30 Jul 2025 11:35:46 -0400
X-Gm-Features: Ac12FXzDSSQrNzkzWz_OdDUhSgYlH9sgCmxX7ixpI8_UP4lioWUnWPq42raBykA
Message-ID: <CAHC9VhQ_f=YyFtxkMf0a8x-bRAi9Nzw-SdgEn8ndkDewydPzuA@mail.gmail.com>
Subject: Re: [PATCH] lsm: simplify security_inode_copy_up_xattr()
To: "tianjia.zhang" <tianjia.zhang@linux.alibaba.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 5:26=E2=80=AFAM tianjia.zhang
<tianjia.zhang@linux.alibaba.com> wrote:
> On 7/29/25 11:09 PM, Paul Moore wrote:
> > On Tue, Jul 29, 2025 at 10:43=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 7/29/2025 2:09 AM, Tianjia Zhang wrote:
> >>> The implementation of function security_inode_copy_up_xattr can be
> >>> simplified to directly call call_int_hook().
> >>>
> >>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> >>> ---
> >>>   security/security.c | 8 +-------
> >>>   1 file changed, 1 insertion(+), 7 deletions(-)
> >>>
> >>> diff --git a/security/security.c b/security/security.c
> >>> index 596d41818577..a5c2e5a8009f 100644
> >>> --- a/security/security.c
> >>> +++ b/security/security.c
> >>> @@ -2774,13 +2774,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
> >>>    */
> >>>   int security_inode_copy_up_xattr(struct dentry *src, const char *na=
me)
> >>>   {
> >>> -     int rc;
> >>> -
> >>> -     rc =3D call_int_hook(inode_copy_up_xattr, src, name);
> >>> -     if (rc !=3D LSM_RET_DEFAULT(inode_copy_up_xattr))
> >>> -             return rc;
> >>> -
> >>> -     return LSM_RET_DEFAULT(inode_copy_up_xattr);
> >>> +     return call_int_hook(inode_copy_up_xattr, src, name);
> >>
> >> Both the existing code and the proposed change are incorrect.
> >> If two LSMs supply the hook, and the first does not recognize
> >> the attribute, the second, which might recognize the attribute,
> >> will not be called. As SELinux and EVM both supply this hook
> >> there may be a real problem here.
> >
> > It appears that Smack also supplies a inode_copy_up_xattr() callback
> > via smack_inode_copy_up_xattr().
> >
> > Someone should double check this logic, but looking at it very
> > quickly, it would appear that LSM framework should run the individual
> > LSM callbacks in order so long as they return -EOPNOTSUPP, if they do
> > not return -EOPNOTSUPP, the return value should be returned to the
> > caller without executing any further callbacks.  As a default return
> > value, or if all of the LSM callbacks succeed with -EOPNOTSUPP, the
> > hook should return -EOPNOTSUPP.
> >
> > Tianjia Zhang, would you be able to develop and test a patch for this?
> >
>
> Yes, I will submit a new patch to try to fix this issue. Thanks for your
> suggestion.

Great, thank you.

--=20
paul-moore.com

