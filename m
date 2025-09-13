Return-Path: <linux-kernel+bounces-814945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 694CCB55AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 02:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69BD71C81E87
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 00:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D90A3596D;
	Sat, 13 Sep 2025 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yL32FsNx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C245288D6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723571; cv=none; b=JHziR0ZgInAaO6UCFxPyOje2BpOP429uHlqFnDATnqYSJP+thCUG/LRH7yXsUcSkf4Qz9U+x9+IAyM/gkQ5WNJpDeNCPiL9sd8RcxjfjQlodrxb+eQ2Ovw6Id8Ei2SIH7mil2ZkHbHLcf2nU4ZbU/D47jQt64gZALC/0L+qMupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723571; c=relaxed/simple;
	bh=IT6MSLnpFHgFKYjMuFi70CbKYPgsH9aVuiAyxa9oN5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icBMUCfQC1aiJXj/BAIU9aNGw0APe7BNPbeuOWL3Hp2C+SBOCkUq6Ze/F70AQKlIGvtyNeYWqcUiN7+mpJCfDDf0EcFQT70/3uNwoNbR9g6IZUpccdpB7/kFcIWwFNvuraDoqiTREGG29o7PDBVSfOPJcEvgyF8tU7CFb9/q3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yL32FsNx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-25c90c3ba65so69995ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757723569; x=1758328369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPwE7Pme5w6u5U8aFVe8q7Weh+CgFUkRYwar8edwhNk=;
        b=yL32FsNxuFUdMw9k4d3pEDlTXrWRrPS4QdM2S7A9MRS4WqkOQCfJN1PlmT5S5uTsUM
         gJhsiSaCVnHDzfbvG/PThD68ePeRmiu87WfWGchXzLXKFjjC5CMZ4+wMf6Hpjrb7ztw4
         6DK6O5T/GR3Nn9uh+oir3B0cuNJHn0xj2mMX6To/hgKDcVCwa7S59saoOgRKQBGBabkc
         Z/HpyB5q3anRJOVr4p2lXhJbkteSujGA+uzc5xtqdFDCJifd9iPyEPxDJeALM9dPIyhn
         Qr60gTqp7t0f1NeXGTlpkpBIy4KgkkTI4gaKIfBUgJPaWLwcLOTNe++uZKnp3zglrVcD
         QsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757723569; x=1758328369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPwE7Pme5w6u5U8aFVe8q7Weh+CgFUkRYwar8edwhNk=;
        b=j2YnhpzFrvp0RLkHKjjSYBGFOVSlaM3eMBA2yNjTiRNdo36gSzcE51DT7MHn3Gseik
         mj6tByY09b/2Sm0+YeI3n6RRwCHLj8Bd34ACxlWqBTCogSkgHl6f0q4o73498unqy2QX
         uhuMyKY98p9JdlbZisvk9AnUxUG0E4TcC+fWKMU5q0novtLyfalUgTVmswU2JU5BnK1V
         KYkaTyTw/7ibos4zlJjISLYPOSYu0ggR4ksiBm6uWQBgVlt30yYDnr43ZRoSnF0EMaMC
         lm9ZLi7nSiiu06TlfyxoLorQaC9fIdz0GejytwJM6AuViIJZnZixI4OcjuKjJyXyz3uu
         g7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVn44oirffcjsDwriKPiiorx5gu4BZTzJo3WqtrRvGqlrLnZxRCk+m+tgkHB26AZkivKBNIJrZKB3cynzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBJfnQY+P9lLQ1wBhWFMcoc/lMr7HORZXVoaPfQAkgH8mNpd/
	O8nPR448Y4gkz4tf0/mZCVrQJzlnSrmwuKDERwEPlV1rYqmKJ66PblxPvXx+mhBmanufhySkZda
	LMZnaBHy3b3jECDr9OARbhSf4gbrroFXzfsodzeNM
X-Gm-Gg: ASbGncuwvmowXs068bu73eLvcIoS1QtlJKc7DyrbtTcGNSYukFIEZ41In0qqficNUdH
	UJbKuTrzlFzjWQ7LKpSVJ++5g5DGS/kvOvi2DtuqxeoIInXFF9S5Zp4XE+IiWUTUvCcmveggISo
	tgXzMvzCvmkvxmwopVM99GqxeDFtJANfnWhelylTnH4TXb+XhopHLJHMH89Df//s8QPtmScMjga
	q5PKo6Zrn0r17agp/MUjXm05lIH6P1JM5ZmCwVN42vmkAw6deDI2mU=
X-Google-Smtp-Source: AGHT+IGyniyNvC+5dYajzXHs7b1Mzj6QmpCkTIBoREKn+Xp9wM0uMHekuGSQTf8LNSd1b9GQgUor0v1MNkX25vcyoi0=
X-Received: by 2002:a17:903:2343:b0:25b:fba3:afa7 with SMTP id
 d9443c01a7336-260e5f7673cmr1180545ad.10.1757723568813; Fri, 12 Sep 2025
 17:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902111951.58315-1-kalyazin@amazon.com> <20250902111951.58315-2-kalyazin@amazon.com>
 <CADrL8HV8+dh4xPv6Da5CR+CwGJwg5uHyNmiVmHhWFJSwy8ChRw@mail.gmail.com>
 <87d562a1-89fe-42a8-aa53-c052acf4c564@amazon.com> <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
In-Reply-To: <CADrL8HUObfEd80sr783dB3dPWGSX7H5=0HCp9OjiL6D_Sp+2Ww@mail.gmail.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 12 Sep 2025 17:32:36 -0700
X-Gm-Features: Ac12FXwAFGev-hCtU5uGjoLOuij4m50OSdUHMCxeiDSrTcweNfyyj3SZXIqeY0M
Message-ID: <CAGtprH_LF+F9q=wLGCp9bXNWhoVXH36q2o2YM-VbF1OT64Qcpg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] KVM: guest_memfd: add generic population via write
To: James Houghton <jthoughton@google.com>
Cc: kalyazin@amazon.com, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "michael.day@amd.com" <michael.day@amd.com>, 
	"david@redhat.com" <david@redhat.com>, "Roy, Patrick" <roypat@amazon.co.uk>, 
	"Thomson, Jack" <jackabt@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>, 
	"Cali, Marco" <xmarcalx@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 3:35=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> > >> +
> > >> +       if (folio_test_uptodate(folio)) {
> > >> +               folio_unlock(folio);
> > >> +               folio_put(folio);
> > >> +               return -ENOSPC;
> > >
> > > Does it actually matter for the folio not to be uptodate? It seems
> > > unnecessarily restrictive not to be able to overwrite data if we're
> > > saying that this is only usable for unencrypted memory anyway.
> >
> > In the context of direct map removal [1] it does actually because when
> > we mark a folio as prepared, we remove it from the direct map making it
> > inaccessible to the way write() performs the copy.  It does not matter
> > if direct map removal isn't enabled though.  Do you think it should be
> > conditional?
>
> Oh, good point. It's simpler (both to implement and to describe) to
> disallow a second write() call in all cases (no matter if the direct
> map for the page has been removed or if the contents have been
> encrypted), so I'm all for leaving it unconditional like you have now.
> Thanks!

Are we deviating from the way read/write semantics work for the other
filesystems? I don't think other filesystems carry this restriction of
one-time-write only. Do we strictly need the differing semantics?
Maybe it would be simpler to not overload uptodate flag and just not
allow read/write if folio is not mapped in the direct map for non-conf
VMs (assuming there could be other ways to deduce that information).
Can there be users who want to populate the file ranges multiple times
as it seems more performant?

>
> >
> > [1]: https://lore.kernel.org/kvm/20250828093902.2719-1-roypat@amazon.co=
.uk
> >
> > >

