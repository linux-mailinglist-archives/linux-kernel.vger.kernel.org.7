Return-Path: <linux-kernel+bounces-850344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3E9BD2945
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A873E3C28E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEFD2FF170;
	Mon, 13 Oct 2025 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIQhb/oU"
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BBC2FF169
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760351386; cv=none; b=g8cmAjZFKDvZDvw0S0UnlnB0F30gIgXDrb2gGiV9Le7OIpqqF0y1OSwIsO2oaJvr/WYh4mGXMv/1xQbKn2CWtpRkGD3B2rG+MCuQxcjCmg4J+wpN/mgRZyZq+Ikkmjd6P0RDUHE4hobpb3Mbd3w8WzzPUWukLGgn8MwjdVA2l2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760351386; c=relaxed/simple;
	bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oMPEr+Ybd5Sb6a3aZjQyD04bXhejibpwnY1WtChMDasoNtKaLJUSvo255r0ehdACMz16x5r04hoZYnYwLH5nh0IEbv/7/T2y8M5IME1FPxrrSOLpen0a2GRa7YGv7SHB/ySKympkBz6zcrN1rnYguF/+A/KraN+ArHn0zHBUNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIQhb/oU; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-635355713d9so3872472d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760351384; x=1760956184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
        b=ZIQhb/oUlO3F9MEPUxurf/mgWI7Y1g8uHfT6SNbxuv/4xY5+m/YraZW/5KqmjRIwzX
         rdTRUXUR5ZYcRqHAcjEXbyqp9QPzrQjcU/+tE2lLY7zsYf9eKvPgMh7Yb+eG+DeMYl1A
         NNkv7u+ELQLfd91UVqU5n/EDVbx6VQywzqTdWGNVo8cwyfdUj0VZFPUXp9En5uePFJsJ
         B8tJ7rKH5YlpW+Pq8nGhj+PB2fjPaXocpEbEosY0ETAXl+QzWKYisCRZclqHs3mpy0wb
         S17h9fT1i/DEuznIcB2PXT67kVi/TGa5zjTd/jM4v9YckG+ajQAB0eFRwEULsu95liHd
         eM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760351384; x=1760956184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVPUlK6sYHZahK5O3+GOTdw6Bx0G0qiDlm5PKLNZXQA=;
        b=EwfBs5b+xL2Q6IIzJ6/8LzNH0IHk5oMoEGbZNeLoQRYGR3uBJV9uJ0YpKlSXaYkU+R
         0dF8QLSMddlMALk+nk0LW9MpOStkxzgL6dCN+AFyAnsXJgrgBjwrr+CIBm1WXIceD/kQ
         ks9r3SZTs7yoEhYrKXEy91SfPjQx0xuKNdnMx5z/zMnJht6YhZ3JX+9/ZXmj/rnZD8ht
         6K0jAvPyABZWMWPPmhPf++PyMDuQ1CG5pTOJQ+Y38GH4asVO+jiexmkJx7ppNm1q9DxP
         237PHN293SMj+g+SKxIhiWi1JfNpxGcLLUUhbg6WJvQhVhVjc8pCpnVvgHVcIXFBvfzi
         rKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWxgCgr09n1KZHiG2In3mrJ7IQgero9TXOpkoJx/6XV9SGumwt4ONEslFg1yz4Y+G5Zxq2GvG6P9Oyjgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKAJJB3D6bm4gtqq7+2Fb+IWELUE2RK1Rz5HMH8Ver7Sh6CYTM
	934Cw9vt8SXAJZ0tuYv9FVtwj64kBsplIc+fD4Sawi5GHjF6LwgVR6qVjJwaT7sPPSr+HtJI1J5
	vP+8zVh79Kt/Nl788cpJ2TW66RVtm8MI=
X-Gm-Gg: ASbGncvjLqg/YoAS/9GcCyMJWubHbF1aWIfST1gbSrBIQ9fugnEWEoNaIzGF+8OIPSp
	QdtkYES2tdnbzeBP/reDEB5slv2FC2NfFc70v+8gd+sgrDq0ottnr8HQ7Ft304wEFHzrKwn5oQS
	3xg/AwD4kSQrwZFL1/Fa89cGVaRlbM8N2scdWJUURHDFgDnpVo5I/1oT0LjeLovZ77RoEfFLZFT
	fe455etfGpvZJL34AoMdPTWnZj4CwmoSM9E
X-Google-Smtp-Source: AGHT+IF7gB/uIYJ4y7t+OLiZ00mCO9lllMt+QoIyqpZ385m2NgZqSy+lqlMIQpqL29tGtjodZ9h+RUr8WRjGSui6l/0=
X-Received: by 2002:a05:690e:4186:b0:63c:f5a6:f2f0 with SMTP id
 956f58d0204a3-63cf5a7080fmr6997775d50.66.1760351383745; Mon, 13 Oct 2025
 03:29:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-3-safinaskar@gmail.com> <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
In-Reply-To: <07ae142e-4266-44a3-9aa1-4b2acbd72c1b@infradead.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 13:29:07 +0300
X-Gm-Features: AS18NWAYGkNu7BjeCT0jHGno_eA5ARoSWF2j7yYdLIuVOnrJP74yF3CsWnjM_B4
Message-ID: <CAPnZJGDe+sDCsCngHyF6+=3=A9pYwQ1+N87jpq-ZdsSvVbQuNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:31=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
> There are more places in Documentation/ that refer to "linuxrc".
> Should those also be removed or fixed?
>
> accounting/delay-accounting.rst
> admin-guide/initrd.rst
> driver-api/early-userspace/early_userspace_support.rst
> power/swsusp-dmcrypt.rst
> translations/zh_CN/accounting/delay-accounting.rst

Yes, they should be removed.
I made this patchset minimal to be sure it is easy to revert.
I will remove these linuxrc mentions in cleanup patchset.

--=20
Askar Safin

