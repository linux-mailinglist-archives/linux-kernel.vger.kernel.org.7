Return-Path: <linux-kernel+bounces-897278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E18BCC52813
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919883BCC56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B0233859C;
	Wed, 12 Nov 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDCnbzK5"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAB337BAE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762953962; cv=none; b=sRkM59gr8nrxgIp3/SxzLIZFSRfanas0ftuAIBa0dHeV8gpJ6+IxxUys280ctGUjC7RtcsiaLTGqEviu5ZCk+onk14Lr9qetBnlEVaHUu+BKC1z/ug8Ue5Sy4ozDjyCDFGKGU02v5qNF870PfBfSbpYI36PiiJTCAmEfINsqyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762953962; c=relaxed/simple;
	bh=T1CGPkh5QxTkBTbF04kkfTJDiDQ1Esip4NrCljeHTKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELSn04m8VkT8xxDUczVpziq5QbAjdauFJyNwvZYuvHbnxIgt2bmvlocsOnyf3gZmH9F8ukrK6Tv5bSUD1OApAmDxQu8+tYDP12JVgMPrrS6W1Gymd5AgrFJFQXS4ekreYWQo9u+lG/h8JmNa0EiwuVmg/L0Iw0r5Ry4pA7/F3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDCnbzK5; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471191ac79dso7747285e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762953959; x=1763558759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67MdzTIe7nfHzCF8gVvcgRb1LTBruURe7nkrUBvNKhc=;
        b=PDCnbzK5vOqB79SOXG7xGjIVcZ0c+m/VUZKVa+sLaOjRCxifUHeRLCNqT3vEi9qDO+
         ZB9wbOooVTN7HlGG9Q7Mr0nA19xZFEqaMH4Z9s6yRMn+2rxFliObimMUdCckdXrXCLOa
         M2ZetXGq5KDqOGn9J/E+xX0eVDimvUYGK1qy519ybSP5rs4ESwwILKtp2kN223dMMwNk
         sAzrBtgfeRXd8Rca0QtlWYTNcRHDBoP14XeH/AVgA/IU3H7lmh2VcHsGS1WroP0a3lso
         wulgksovOwlBfM4bXb4Ym1i7zm2AdePLpmj74/DsifI/8xsYfLRLQiznfPF3c2DwI10R
         CT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762953959; x=1763558759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67MdzTIe7nfHzCF8gVvcgRb1LTBruURe7nkrUBvNKhc=;
        b=KGDfhgk1ksq2ERfnzA7bqAJAo5A/y9WlmngiSfKB4pfTR0jL3TzSR6uLiMEDN+X8mZ
         p1HBMiD9xAy+fir2gE5LSEhCpLpuhYsaPgOSKRxO5Ez2cyrvKrpAXiYR4J2MFZFZiK6i
         7/2RcoE6gNkCB24nNs9M0OkboWNtAOom7ydLmzPjlo7boqEQ/gB2i58DqOtxv7SXfN6x
         CPm3z9dDHUgekw16jfsm7mJN++5/HimvHyKy/nVKd4624ncL4tUc0De2QB7TgamGoPCo
         /fiCFkUxrX39xG5+PFT758cv3Lcw2Dh2nnSsf4LSI6xSXur853hMxhq4nnvmzCvAR+ek
         zqIg==
X-Forwarded-Encrypted: i=1; AJvYcCUuZ2HWAmDuktberX0YS4PmdxAaHfh2XkvPfuxMNKYulcpebSWzbNS11KU4WsXgFSgIgk2boB1GrPtliuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/h43eLYlR6RzjejSYIWD1Lcri7tA08+ungcZUntIkAzCNVgz
	jIhqgSinp7haI5T644FJBSNhoLLCvY0hyRWIdm+jrdCQUayMln98X4ap
X-Gm-Gg: ASbGncs+Hi0Mh7jo5wjPFcIeoWtfVD885XQm+dEBO/HSdZFbf5wKKl9Y61vzBU/vVW5
	g26hzpBHVCN+X4uB6DZJUfFVFERY81312Y5AJWvjWjJRQM4vP5XRMGnw+d0tODl9efSYc7knXET
	KpcwWXGc1o7fWk8xK2qnj3Fm8+lINBxVqIj3QGx53tdQOJU4dv9w5RmBev3KIgX5VUdXA+x4oZs
	FPhfy8uuThXUEXlOaz1bESg1I31lycOZbqQvdB/ifT5XagFz1J8fAMBmtWwbFiJfGlqYj0plJo0
	ij+7wdrxNXk9b8m9keraHEnBxT6ZsemAgWXpJIuuLgHCN0q4lf2hI9vYnJKWXwqfvddKFdzDLBU
	t03TXbtoB0ygt6b3xTp3ppOfz9zIeItQgEMr30eLkiQZjil3YDj3Kcs2qxdiCsmSncFMUrrRRFG
	TgABDQI19ZOY2CDJzXFMM/BLazFDCut4VZDbUkX0r/Pwu6hKAfdbip
X-Google-Smtp-Source: AGHT+IGEnOyZeVcb75zllMCg/tu1yw75i9pj+Pj/BhOqY02ZJ8vy9wTGJH1HbwhlEvGnWNxL1iOypQ==
X-Received: by 2002:a05:600c:458d:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-477870a5e92mr32125845e9.32.1762953958979;
        Wed, 12 Nov 2025 05:25:58 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e3a656sm36447935e9.2.2025.11.12.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:25:58 -0800 (PST)
Date: Wed, 12 Nov 2025 13:25:57 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Mladek
 <pmladek@suse.com>, Miroslav Benes <mbenes@suse.cz>, Joe Lawrence
 <joe.lawrence@redhat.com>, "live-patching@vger.kernel.org"
 <live-patching@vger.kernel.org>, Song Liu <song@kernel.org>, laokz
 <laokz@foxmail.com>, Jiri Kosina <jikos@kernel.org>, Marcos Paulo de Souza
 <mpdesouza@suse.com>, Weinan Liu <wnliu@google.com>, Fazla Mehrab
 <a.mehrab@bytedance.com>, Chen Zhongjin <chenzhongjin@huawei.com>, Puranjay
 Mohan <puranjay@kernel.org>, Dylan Hatch <dylanbhatch@google.com>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 49/63] objtool/klp: Add --checksum option to generate
 per-function checksums
Message-ID: <20251112132557.6928f799@pumpkin>
In-Reply-To: <BN7PR02MB414887B3CA73281177406A5BD4CCA@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <cover.1758067942.git.jpoimboe@kernel.org>
	<1bc263bd69b94314f7377614a76d271e620a4a94.1758067943.git.jpoimboe@kernel.org>
	<SN6PR02MB41579B83CD295C9FEE40EED6D4FCA@SN6PR02MB4157.namprd02.prod.outlook.com>
	<5an6r3jzuifkm2b7scmxv4u3suygr77apgue6zneelowbqyjzr@5g6mbczbyk5e>
	<SN6PR02MB41574AD398AD3DE26DB3D23BD4C5A@SN6PR02MB4157.namprd02.prod.outlook.com>
	<6msqczigbcypeclqlgzgtqew7pddmuu6xxrjli2rna22hul5j4@rc6tyxme34rc>
	<SN6PR02MB4157212C49D6A6E2AFE0CAA9D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
	<SN6PR02MB4157F236604B6780327E6B43D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
	<yk3ku4ud35rsrfwzvuqnrcnwogwngqlmc3otxrnoqefb47ajm7@orl5gcxuwrme>
	<BN7PR02MB414887B3CA73281177406A5BD4CCA@BN7PR02MB4148.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 04:32:02 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Josh Poimboeuf <jpoimboe@kernel.org> Sent: Tuesday, November 11, 20=
25 8:04 PM
> >=20
> > On Wed, Nov 12, 2025 at 02:26:18AM +0000, Michael Kelley wrote: =20
> > > > I've been able to debug this.  Two problems:
> > > >
> > > > 1) On Ubuntu (both 20.04 and 24.04), /bin/sh and /usr/bin/sh are sy=
mlinks
> > > > to "dash" (not "bash"). So the "shell" command in "make" invokes da=
sh. The
> > > > man page for dash shows that the built-in echo command accepts only=
 -n as
> > > > an option. The -e behavior of processing "\n" and similar sequences=
 is always
> > > > enabled. So on my Ubuntu systems, the "-e" is ignored by echo and b=
ecomes
> > > > part of the C source code sent to gcc, and of course it barfs. Drop=
ping the -e
> > > > makes it work for me (and the \n is handled correctly), but that mi=
ght not work
> > > > with other shells. Using "/bin/echo" with the -e solves the problem=
 in a more
> > > > compatible way across different shells. =20
> >=20
> > Ah.  I think we can use "printf" here.

Much better than echo - and a bultin on most shells.

> >  =20
> > > > 2) With make v4.2.1 on my Ubuntu 20.04 system, the "#" character in=
 the
> > > > "#include" added to the echo command is problematic. "make" seems t=
o be
> > > > treating it as a comment character, though I'm not 100% sure of that
> > > > interpretation. Regardless, the "#" causes a syntax error in the "m=
ake" shell
> > > > command. Adding a backslash before the "#" solves that problem. On =
an Ubuntu
> > > > 24.04 system with make v4.3, the "#" does not cause any problems. (=
I tried to put
> > > > make 4.3 on my Ubuntu 20.04 system, but ran into library compatibil=
ity problems
> > > > so I wasn=E2=80=99t able to definitively confirm that it is the mak=
e version that changes the
> > > > handling of the "#"). Unfortunately, adding the backslash before th=
e # does *not*
> > > > work with make v4.3. The backslash becomes part of the C source cod=
e sent to
> > > > gcc, which barfs. I don't immediately have a suggestion on how to r=
esolve this
> > > > in a way that is compatible across make versions. =20
> > >
> > > Using "\043" instead of the "#" is a compatible solution that works i=
n make
> > > v4.2.1 and v4.3 and presumably all other versions as well. =20
> >=20
> > Hm... I've seen similar portability issues with "," for which we had to
> > change it to "$(comma)" which magically worked for some reason that I am
> > forgetting.
> >=20
> > Does "$(pound)" work?  This seems to work here:

Please not 'pound' - that is the uk currency symbol (not what US greengroce=
rs
scrawl for lb).

	David

> >=20
> >         HAVE_XXHASH =3D $(shell printf "$(pound)include <xxhash.h>\nXXH=
3_state_t *state;int main() {}" | \
> >  =20
>=20
> Yes, the above line works in my Ubuntu 20.04 and 24.04 environments.
> It properly detects the presence and absence of xxhash 0.8. Seems like a
> good solution to me.
>=20
> Michael


