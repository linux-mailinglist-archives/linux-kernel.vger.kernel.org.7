Return-Path: <linux-kernel+bounces-723846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC912AFEBAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1050174264
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB9C283FE1;
	Wed,  9 Jul 2025 14:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkbtTGg3"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CEC2E8DFE;
	Wed,  9 Jul 2025 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070051; cv=none; b=RYBrtlQD21WoK3ID2qX0V2CG2swexpn1npqEJWy7pHCZhxUglT2cSVZLan6eQ5H+cdvk1pRtrALhkenZ80SoTAtqPav9upKLyD2h30+Gr/bBbk2UMmqtkgn9Ijee7M3CcD5Y64yzC0W/s0DP8NGRD6umABw5EEraGe/cSXNKoFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070051; c=relaxed/simple;
	bh=0vIhpx+0YQQm1MaG38coKriz3Hl7RX4m9tfVDq7x9mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt9WtKiyDtkq6CGBC5DDkwIr05n9xRuYvuszp+4PTc3/FkfRH0+oXTCKvUpWh/h7TDWAtSeqqdJw/KTwz8JT9rbli9lodunOvZn2qJA8vMYWYskwUPd0pbiSiKna9RW5gsVrmHSVHWFsj+HtPWApCPLYrzRfSQNGErzDyvOeUbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkbtTGg3; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ade5a0442dfso957047066b.1;
        Wed, 09 Jul 2025 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752070048; x=1752674848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkAhtJII7qepeyVa2+QSjE/0dSe9MXuvFykrrDGX/LE=;
        b=YkbtTGg33RaiBrt/8n+OJGcKn1547+fj2+josnpQeEOpnGAWz/T1owlBe6fu1QO7i/
         /UP96eQrqqpwH070YXXw0BpGTI1C89DUsV9DSI2OIjsTFIxvCQC78Ugj0EAI3sobQLOx
         svyKmYIexhbM10DqFjiSGmSD3YgVzJ6gjmqZvZWrX60jouioiBRCNm4jAyVfSXBB/4El
         3gBzoXQyYgkYjGYYRRh1Uxwhe6rSiLTLZj3Nl+Vj3doFqe4QkqBFimkk2vx0DM2kJeLi
         2O8Vn+ddLlcBEosB6qvHFxj3WHGhsR/oteDIsnBFNTYBMKU0xrSzwBgfSTjHWv4XHhNO
         QiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070048; x=1752674848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkAhtJII7qepeyVa2+QSjE/0dSe9MXuvFykrrDGX/LE=;
        b=hXgkH6F9YAtmOB/LOYr4OKrgzu4izNMdlwL2DOCzQvAac4WuyGZ52ApgbkubhqjiPa
         7tRYb2O+mnwZ+ZOG4+fs40zB/c2yUHwHL7OKZCY+ZlQlCrwTW2ID0Bg09letLIN+yf9S
         MiS2jH8hLJ5hp4gS4K+fC9LDGQ1dWIiTu4d+jkA4t5mT/4B1oKXuWUS/4nVh+JeVkjNm
         lclHvF23ZEkawj+wtqJZ9aKjvTGmQ6sEA6fi5MUYQ88wJi0NTEOcdBgALpK9N8YXOFH6
         +uZ0Eqs4hTjt41Nt+sf5rXu2e3H6nK6nshYbFVMRgL4Sg3CRoLjyuNe3y8MtDQK5B7UC
         YJug==
X-Forwarded-Encrypted: i=1; AJvYcCU/y2VNNWm2s4O4l012Z+3nbbVkAMbNlspU1XycQW3YpfcL7tm/+5V23fN2LLE2TKT40pLhVVhpcdA=@vger.kernel.org, AJvYcCXML9L+gbPTWlBGQh48bdXuuJEKokrsiKwnDt+1eHXhI5d7KdUanjTl7JoV4DP3azGmPj3EmIVwOZOEZrHa@vger.kernel.org
X-Gm-Message-State: AOJu0YzGfUKQIzhRiQ4IDO4VIEUT7uHpH7OFnn3xX5l5YpZ2/x1UJMbc
	AoJdNan6RnI3xchXQBiwfKNdIMoNqS52zgcNzDw1j/SM/MNu1k4bCLVTIgHh4skFTCi/K3Ya6fL
	RnbeWKL9n0pGLQiKU8MeWuLIIrGsu/NY=
X-Gm-Gg: ASbGnctxDwyAU1UFoLvFRsYRrJ4Lgu0wygHESIkgsgXdATF1LqcdGrwCkktOcrSnvOK
	zV5HVpWr0cHiHgtlguU1rnfs7Om4uf5WelUCJpzDOdG0dToO24oOfOnNPD1+hGm3NOhscZ4cooH
	bIu2rGfLnWSV0oEfDl6MFSzz2Lp6RhUAowUWZyyPI326OWKhH8+yc4R1becg73JtNGkm4NZ4Ulk
	4cNp3HgVKvmO+dL
X-Google-Smtp-Source: AGHT+IGIfSNs28NtfUwdB7/Q+GAf+1HaldJgehEtx6rpKFjG5kyBclCrpaomz4JmoRY5EzJIVVBaqimr1SPayzymfUk=
X-Received: by 2002:a17:907:7f8f:b0:ae1:5db8:b78f with SMTP id
 a640c23a62f3a-ae6cf7354a1mr263493666b.34.1752070047664; Wed, 09 Jul 2025
 07:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709005952.17776-1-bijan311@gmail.com> <20250709110648.52688-1-sj@kernel.org>
In-Reply-To: <20250709110648.52688-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Wed, 9 Jul 2025 09:07:14 -0500
X-Gm-Features: Ac12FXyKir0QkPAHnX3REi635GLE0DBv9wAGdZTw6dhXQX_ellDr1zjsx8QPpQI
Message-ID: <CAMvvPS7avR+xEk7e+n5X-rwDFnFCf3e7ubJPHAQfRQVmyZJMjg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] mm/damon/vaddr: Allow interleaving in
 migrate_{hot,cold} actions
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, akpm@linux-foundation.org, corbet@lwn.net, 
	bijantabatab@micron.com, venkataravis@micron.com, emirakhur@micron.com, 
	vtavarespetr@micron.com, ajayjoshi@micron.com, 
	bijan <bijan@node0.bijan-262664.superpages-pg0.wisc.cloudlab.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:06=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote:
>
> On Tue,  8 Jul 2025 19:59:30 -0500 Bijan Tabatabai <bijan311@gmail.com> w=
rote:
>
> > From: bijan <bijan@node0.bijan-262664.superpages-pg0.wisc.cloudlab.us>
>
> Maybe this is not an intended part but something from misconfiguration?  =
I show
> Andrew merged this series into mm-new after removing this, but headsup fo=
r a
> case that we might do rebase.

Sorry about that. I had to switch the machine I was generating patches
on and forgot to setup the git config. I'll make sure it doesn't
happen if I need to resend.

[...]
> > Revision History
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Changes from v3 [10]:
> > - Fix bug where huge pages would be split
>
> Maybe "walk->action =3D ACTION_CONTINUE;" of ninth patch?  Nice finding!

Yes, that was the change.

> Nontheless, since this was found by you and didn't discussed in public be=
fore,
> it would be nice to add a short additional clarifications like above, if =
we
> (unlikely) do rebase.

I will do this if a rebase if necessary.

[...]
>
> For the entire series,
>
> Reviewed-by: SeongJae Park <sj@kernel.org>
>
>
> Thanks,
> SJ

Thank you for all of your feedback and time spent on reviews!

Bijan

