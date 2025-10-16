Return-Path: <linux-kernel+bounces-855623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50520BE1CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 08:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5BD3A9EAA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 06:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD902DECBA;
	Thu, 16 Oct 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/U7ysCL"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B62D3EE0
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 06:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597003; cv=none; b=k+oAVkgkpLIBM+NYAWNHNZF6G0ms3SicZswKK2PmHyi5li8vyMqml0MPc5azmajuRjwypdYcJgx6bb12o1aZ/PGRWATj1qODVCoxgEoASunrXXwT/frOzBuP/AsnxcBGgvpDH6oGZn1wvf06DoHKAcbmXQj750wz0vX9NHprDBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597003; c=relaxed/simple;
	bh=KXGiPPPiCRsCRTJJMBKXVC7wo1U395s3TxLne1Z/qUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSrRIDJKk4ju6Ft+Vf5DFr9bvPX3nuY5RQcIMbXBf+bgYUJnVcF/rrykeMZowGdJtFriD29FPFqr5sCtMNldiDbX1BsSeVGvdxwMC3ItkIKPAeLx++K5OFLlNun9ttsP+DxrqJFL9bymSdTWfWFuEmTwSCIaZvV6Gr+00MRKPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/U7ysCL; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6348447d5easo398979d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760597001; x=1761201801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMB4WotgJMB2B9lnpkEFb08bYlsI5GtgT/xlgxrxy7I=;
        b=G/U7ysCLNRQXU4oow07s5nqF2TFn42erL8SMFGnQPBsnTZTIBQTMirqitV2kezS6Uy
         n72KSccQInAb3OPyt9hig2HJWHnAi4hNgwJtsR2pig6/NK65DjBVPVg1N61drkCdu5SN
         3AMYqILVxorhbafYf503NHwaLR3l6NNzNC6QUOzS/A/hSCf1q4AeJHZcXSciiQRdztdz
         WGMm/rKTzCH+ZaKbU+wZPutsGJ5nFtsG4oXLz118DbfU4FMYfK/Q9Ax2ReHHm/9AHy6p
         zP7cSNbBKZwYv+ubyYdIMXeLaDUnlRkVciGpLlEGQPkAMmM8gazsLBjuOJ+5mQpnVOdk
         I+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760597001; x=1761201801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMB4WotgJMB2B9lnpkEFb08bYlsI5GtgT/xlgxrxy7I=;
        b=wVzv20mlqIxr7STcaV9p9eOXELOGgEImVBNaX7fdzIZTWHDPDEvIy5XYd74bG26KU8
         UGLxtWuc7tM8iw96HCSuPzIiZMvPP3UzLD0CQQD+aW5Qj24wikQXeRqRBaw62gm0NhAS
         jT4gkmroF8yGEiW780NxZVCJJCvAZ8sASASbi3QXlyCEvO/9w9OfzXZeY6SUXcAoBrrx
         M6da3fpPXomL4Qsb9Egt8bz887dxhoBrsen/CBsXS4IvOG4NFtuUlTLEJIQ9cs5s073/
         ilzHMsh7UtH6r9wxMtc9BvBWrQ6YTLSeVuiM7tqDE6TskxcSlgXwtE4/me6XE7J6UeII
         WJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVge5qTSlFG2O9OOXCSpoGxUtjztk+yhXH2B+b9mDF5LdHMG4VR8iVOjrxvPcTcrY3PQpVmsYFM5oqWzoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzisolUKpMHiv3bB/Zg2XoGoWtzlrhHJ9AQTm6cLksj4QFpyqLH
	+QJItV3w3SbPUT5uDrvSi23sWiioApVJicWbB1zKvjzIjStiPihii/drWWh+Fx4yWPA79CSbP31
	Yi0AY/P15eet98Y3cFOoJT8ofZe4PktQ=
X-Gm-Gg: ASbGncvR5tzp5552EYPEorErhqIPdQWYrm2IyW13pA4DzuHBuCH91R7LU/8EjXvuJcf
	G/O4e4gCUrk4FWolFBd2mGuvfvgtyiYw7QLqma5GhsBlaPHNrMRGp4otuIxWIEEYkWNbRO+VirI
	CRWfr5JHNX/IOVeFzy9kkDfustdXqIVtqIkbXQ8cpTNA2jOW/Lqu/ALPq8TXgojpkjetjesMEyT
	3w1rRm0DkgIE3qTma57P4EVZPf3qLjeHwsE87U0QfHHA/mwY9Snl6v1VqAGNcf4tmWcLhwO
X-Google-Smtp-Source: AGHT+IHt55ghDR10vYNQX2CPbLTIfDAHnS68w7Y8BthdNCorUSQCnA/OvTwgVVZCE/MUA6kZegO483oB/tunMLgJW3w=
X-Received: by 2002:a05:690e:130e:b0:63e:1138:e0a8 with SMTP id
 956f58d0204a3-63e1138e2a7mr167963d50.14.1760597000939; Wed, 15 Oct 2025
 23:43:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015141716.887-1-laoar.shao@gmail.com> <20251015141716.887-7-laoar.shao@gmail.com>
 <CAEf4BzZYk+LyR0WTQ+TinEqC0Av8MuO-tKxqhEFbOw=Gu+D_gQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZYk+LyR0WTQ+TinEqC0Av8MuO-tKxqhEFbOw=Gu+D_gQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 16 Oct 2025 14:42:43 +0800
X-Gm-Features: AS18NWCmAzqewH7c8lKNSOM6N3YN2rFyfdEP9RCIkzoVhyDUX8WzpaYI1pA7pxE
Message-ID: <CALOAHbBFcn9fDr_OuT=_JU6ojMz-Rac0CPMYpPfUpF87EWy0kg@mail.gmail.com>
Subject: Re: [RFC PATCH v10 mm-new 6/9] bpf: mark mm->owner as __safe_rcu_or_null
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com, 
	rientjes@google.com, corbet@lwn.net, 21cnbao@gmail.com, 
	shakeel.butt@linux.dev, tj@kernel.org, lance.yang@linux.dev, 
	rdunlap@infradead.org, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 12:36=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Oct 15, 2025 at 7:18=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
> > owner can be NULL. With this change, BPF helpers can safely access
> > mm->owner to retrieve the associated task from the mm. We can then make
> > policy decision based on the task attribute.
> >
> > The typical use case is as follows,
> >
> >   bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
> >   @owner =3D @mm->owner; // mm_struct::owner is rcu trusted or null
> >   if (!@owner)
> >       goto out;
> >
> >   /* Do something based on the task attribute */
> >
> > out:
> >   bpf_rcu_read_unlock();
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  kernel/bpf/verifier.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
>
> I thought you were going to send this and next patches outside of your
> thp patch set to land them sooner, as they don't have dependency on
> the rest of the patches and are useful on their own?

Thanks for your reminder.
They have been sent separately:

  https://lore.kernel.org/bpf/20251016063929.13830-1-laoar.shao@gmail.com/

--=20
Regards
Yafang

