Return-Path: <linux-kernel+bounces-897022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E99C51CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220A91886015
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E03064A7;
	Wed, 12 Nov 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO6dYcU0"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646323054EC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945061; cv=none; b=D1l9PTUOIELeYIcf0fAreCrxtdXgdrNp5AhfSZc7v/oQgolLTTB1AyUM33MaZiAvOMMJjo9sjfdDihW/63vXs+xSv52CyCFIA4i6fGkJ50M07wj/UcsXXkjfaWHGZkVnuehYgDnG1vbDrbXMJ2nZLMptZOTwihd2b8YqP9R8W2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945061; c=relaxed/simple;
	bh=1+1ng9aJ9EJ0nUlXg0Otdm00yBxHt6dChlosv2yBOQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eq/LdJu2YzItkveKIsO8tYPf1oTQ3nKkTHfr9YqJ62OOzZBz+nmCVQ7WR9xnG+JorF7mZiwgUOXfm0ysbliKz8e5x70QWMVfJudK3p62UWJtDFdo/2mJ6/S3RK7FqGOd1TRoOYv9rDm0oZswAc3x+IEHr4bePIwb1WfJb3X8mEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO6dYcU0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso911262a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762945058; x=1763549858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+1ng9aJ9EJ0nUlXg0Otdm00yBxHt6dChlosv2yBOQs=;
        b=IO6dYcU0TzYZ26d6FwY3YLq5o28pQcJ0PdkW0O4qUNOtnkXSXrK9RJlS1urH5Guor0
         jA6JbefoH6Ql04+TmrJ02vUCnSZrXZNb2ldmkIOaW+ALjlVZWgNdJrMjRhw2IiOwoVsL
         e80k4qeLl9CG4Z40qc0ilDg5/z0CQWJvr1nGZqL8E5go/bpvedZjvY/AmwiZRb043W6a
         sETOx8e3MlmHFq2AJwyboShMI6xvPOP0DAVIMA1XWvugiEV3O2StnXVQO/034v6rknoB
         fmqLvDEdPiDmlYgTC1vyeiZFADb/dfULRuNtnxP3Nvb5A1kG/pU4c2dIb7HhA9Mi3f8o
         PItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762945058; x=1763549858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1+1ng9aJ9EJ0nUlXg0Otdm00yBxHt6dChlosv2yBOQs=;
        b=nBy9V2u/KIFezF+YiKvCeCCbAEjDZIEkw1cMLQL8mWQGTTIVNOkrsNx361P4IPmSRW
         V3m83Fc4nJb7OAMzVdfZ1WmXpAdVHfO0+Bi/zWcAHHhk6zdRdYihZzoxmTsITsx0BO33
         wn3RsVtTMmn2ReVI36BR+2o61apLqMbZDjicyg2vv5/VWAOKOgqnntuEv5QZt/UOk+GO
         vBokjVWkzVjKJ//f6ajR2uh7XfT5XHJJ3Klwpe5ueBgU08lTlAqJTXGqqe0yBoYsuIRC
         Aepl1NixoSpVGatW2e54FajV3dh22HXmfMKq0qsdlYbFWHKRlLpz6mTzmC9YZjwlfzKs
         bceA==
X-Forwarded-Encrypted: i=1; AJvYcCXlzp7uKd0aLlcT8MJI23CMZvtooA4Sbjq7FJO8TAg7N2Sn1Qoa4u9juoALn4u9Nqs8EJJS0gX3onS90Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGqMtTY3zlYSDuyZzr+wx7Xi2zMKRy4b5dxg8y1bFx4vNPA11k
	fCtiMC1vdtBQxTky0Kv2hQh5pMehdSE9cCKpU99xVqKexU/O3NAOl8wSKrHUutlbrde8qT6rL/0
	zDjqkUvjWNEnsO7Rbb2l4sId5gHiB80Q=
X-Gm-Gg: ASbGncs/heWwKEMiLzeEjeOqwCbF7V7LRlqmaUS0aa/VDf5QcXKl5CcIC93EVt1awNK
	6B84l6UtbJ5CQaTHJvPoC9QxjKh8sbNHfMgR47lneHXiaw4X7fEAgSj4KKlrdEea41po9uprADa
	78USXqSz/H0UQCrk7JSTsKWdUOFOd1xmL/F4Mo/9GlUD03xOGL901GDbYbSLrpr3IcoAEnHAV40
	QD7uVIBY9Yy8Nv1wzA8Db7EGZ2QJ34Wt+yk2bvXPSpqXERxke+jl2DON6fv2dp3qMGXSAp/4Cjc
	Tn8ASwTtJDALkP0=
X-Google-Smtp-Source: AGHT+IEd0OopFwNqDKITCHZRG3zA6oImuGq0GUgA/NlByAetznsmlAHRh+tUnZYNKmWCBWXTd1sFR762HynSLp6z2Ds=
X-Received: by 2002:a05:6402:50c8:b0:643:130c:eb0 with SMTP id
 4fb4d7f45d1cf-6431a394a25mr2279251a12.8.1762945057712; Wed, 12 Nov 2025
 02:57:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112134242.2608a613@canb.auug.org.au> <CAGudoHEa=4HueuL8Ypfd5VNVyo5fEsfeY2+6c3nA2mvhXNt5Kw@mail.gmail.com>
 <20251112215541.049f3ba8@canb.auug.org.au>
In-Reply-To: <20251112215541.049f3ba8@canb.auug.org.au>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 12 Nov 2025 11:57:25 +0100
X-Gm-Features: AWmQ_bknuHbDIx5VcJNHzglHWhytOudi-By-Y0hGcyWxNQSnMWdaMS6k6dtQGw8
Message-ID: <CAGudoHE-3MNRSCMX0tf-t-Exopvw4n5M8b2SFZcbbiM7is-gkw@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the vfs-brauner tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:55=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi Mateusz,
>
> On Wed, 12 Nov 2025 11:10:59 +0100 Mateusz Guzik <mjguzik@gmail.com> wrot=
e:
> >
> > That func is a little special and I would argue it should not have
> > these documented. Is there a way to exempt it?
>
> Since the function is declared static, it doesn't really need
> kernel-doc, so you should start the comment with "/*" instead of "/**".
>

Perfect, thanks.

It is Christian's call though.

