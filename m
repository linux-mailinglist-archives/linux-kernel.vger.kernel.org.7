Return-Path: <linux-kernel+bounces-819217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11603B59CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3021325555
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB013DAC13;
	Tue, 16 Sep 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qUQJtCFx"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5E393DDE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038562; cv=none; b=kh9ROVHwYQY7TPu0+kBsx/3gJhEVZSfR6X+FKRqABEL5rPUba7oJ0Osh8jFhLOpIX4i9HmNtebMBdTGJrmaCvoJsjTUh77+UV0qcjo/FWPgOy5/NoNUCUdDLbE3LQObcXy/QYOls51aZAA9ChaVrR4zg9NNbxjr2c64hBdUJJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038562; c=relaxed/simple;
	bh=Pm9S+Z/lbTmOGDpkTDgV/dX6CqEliRA23hXOnATAb4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4PGEkkAA1QAgm34/ZxMhALhTDUAotjWLzdGABKQydvIq8EKZ4ogzia+hBWoaNdIx0qHVdBsNSxligCS9pjVC8gk86hglA4BFmVBEtDQCNu8VgcRitRJzRdARjfSJte3xRhXoWkade8tX5tW9j37Mg4R2tGm0sLQQz50tee/2/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qUQJtCFx; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b4bcb9638aso542221cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758038556; x=1758643356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOGfEho2lxDBDt+dfHnFZdb9utqA2RtE2i1pJMhS6N8=;
        b=qUQJtCFx0kkjwCYBYqEnlVtLCctOk2wa4Iby0zStroK/N6BgW+SJkxW5F420iBAm82
         74DQGu5RAzLl6RLvm8b+H8jKqLIFt8NJkdhvnkN1WSBr+Asmhy6xK+c7rqHcSCO16UTZ
         Rre+cdMdLxgur+EndbZAM5dPTzxsd8Voa1/fAN8jm3+lb+HYy951lY11H0252rZhW/IU
         xsvlJzTUEqHdD6fLzfjwJs7wClESkvzAxZvzwgCRJqxssJP1V4tqfaRTP82gWTRHB5jV
         0AEp9abm7/RtotePkb7XcEddYEyed3MuYe0KORJxR2c2UKcz9CCGF5Dm4qXrW9WHPfx1
         SJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038556; x=1758643356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOGfEho2lxDBDt+dfHnFZdb9utqA2RtE2i1pJMhS6N8=;
        b=DK/ExAmuxfuBD7EwFgczHCqRmxU3VE/l8BYqxGaNhVuo4LM6g5YSzltroRnbaojHe3
         kh3VUQpR2gDV6Uqi3cK1SCECNHCcIey3AwgLCzPe7fh2G6Q+WWD2tr5fAJa5zFRz/xYK
         VFpzSS2Kj4C9PjnwIhEb4MNHRZ1sQTdYxnF5bTr9uC3vZYZg+DJciqOnDmjvn4RBfpTi
         rhWhCyXr74mEW2gx+yk173nkHIW4VqOpw/TUbobyYCp2RjHgNIXyJUA3cEj58gjVbpjV
         MuM19Udz4wQOEf5CcWtsb+ZcFxBu/x+raDwauuUiE9rOZkJ2Cw3e7H8hafZReniYlhiE
         st/A==
X-Forwarded-Encrypted: i=1; AJvYcCVI2gLXxHFl48M4kM8Y26DkxaxzDQShEPoIjAUbZw7ii4rzEvm8GLj5++DlXzW/xcpz5WN8vtbJw22v3Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Wi7Wpo21SrkeuzdSGVapfRFVHcMYPoqSu9MwqmBDFHhEBYU3
	hH/qeKtoJa4+oNMG87uOAA1RgjMJIGeFTm03RPb14eFIRruerJBpGEYr5H/Tvep6GHo3wKhS4Ut
	hDR9z7KxkyfV2On+CQrcg36XMkpFlQzCPmd56938K
X-Gm-Gg: ASbGncsdr2G+14SvJfs9LT/MQcGnOUrSo5re0mWANyvhItrlFCF5Itk1nwT/WE8u36A
	VOOI/kDraQWfDSsUe0hvFVbBQeJ+fquMFZszuia8PN+vAADZDltnB4tbE0jlFGUH9a/vh9w4QBl
	H0niA3ZRcLN4hvbv1ALka+SFGmv30mgQ1Ale5tPCEyGN6grfi941pwmweZgqeWb/KXzf8Ls1XHx
	TNF9oDkSLUQGCvwa0SpNoko4D6tUSpWZcNSbqmv0YrF
X-Google-Smtp-Source: AGHT+IFrvIE5klPLjtgAcRRwXahOqbKuS12v1SX41CUBYbkgKcxIRfBt0vMkeQV4TW2WSxuZyLvtourtBQzZChO5rcI=
X-Received: by 2002:ac8:59d5:0:b0:4b7:8de4:52d6 with SMTP id
 d75a77b69052e-4b7b1bdf823mr7027581cf.2.1758038554773; Tue, 16 Sep 2025
 09:02:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915230224.4115531-1-surenb@google.com> <20250915171112.f71a7606a7f9fd3054662bed@linux-foundation.org>
 <CAJuCfpFQCgQLSrzfVjV+J4tkYbOx_W9v-kWmoo-rmh5hs9gEXA@mail.gmail.com>
 <20250915195633.96236cecebd8777243a770bc@linux-foundation.org>
 <CAJuCfpH1JW8vwOFF2H2SOxZqoJHadXsTc6C=LUS_=twcf=k9qQ@mail.gmail.com>
 <20250915212133.de5b8522137a5ed30efe956e@linux-foundation.org> <CAJuCfpFonUPE0FL5XGm0paYp9ZXeAKK6mjHO_8hUkyxfyduL=Q@mail.gmail.com>
In-Reply-To: <CAJuCfpFonUPE0FL5XGm0paYp9ZXeAKK6mjHO_8hUkyxfyduL=Q@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 16 Sep 2025 09:02:22 -0700
X-Gm-Features: AS18NWBBsyvMb_SnYAjyDoVzFBtIKASw_yt6BbU_ooXkYgjsNjIX79eMvqtS-Dw
Message-ID: <CAJuCfpEGpLJMTDS30Z0xpurbxtRS2LKx1G2=u=kPknpBrHK6jA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, 00107082@163.com, 
	pyyjason@gmail.com, pasha.tatashin@soleen.com, souravpanda@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 9:39=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Sep 15, 2025 at 9:21=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Mon, 15 Sep 2025 20:34:33 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > >
> > > > > could you fold it into the existing patch or
> > > > > should I respin?
> > > >
> > > > A little fixlet would be preferred (by me, at least).
> > >
> > > Ok, should I post a fixup patch or you will do that in-place?
> >
> > I think the former, please.  Your intent is preferable to my
> > interpretation of your intent and we get all the nice patch metadata to
> > track everything.
>
> Will do first thing in the morning. Thanks!

Posted at: https://lore.kernel.org/all/20250916160110.266190-1-surenb@googl=
e.com/

>
> >

