Return-Path: <linux-kernel+bounces-898229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C863C54A41
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D50C3B007D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385D22E1C6B;
	Wed, 12 Nov 2025 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db9rt1qF"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A42C21D8
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983578; cv=none; b=FZ1Sd7gHOgPg1/USUJrkiWHT/u1wgyS5e5gwoCJKM1JHL2l0RWwxHaDAZ4n/+TRi6vsQ8/crxo7U7Qo1QyEbeK5nvyOS2c9JPv7oSvCfeZ0cYRh2mmAYEZFgWakC66t3d6bo1b5/ASnCvCrX9D3KFW4tcuqBclBwCILjYpLMp5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983578; c=relaxed/simple;
	bh=wntAcgzyDrtiqse/RUz5AXoDK0FgHwu+ULhBxcDFZn0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYkdU8BrpvN9bAMyqwdVKutSGXOmnGJvZuZ8W5QYYRkjbIMicdENbJySDrqOTIxwFn3ERoTqd9HGfLuYFL7v5fb1pghB+3LoeUXMU4SS3dEoEFJBUsHHxdd0kFFQT6wGNsgCsOGBYjMKA/JsV6Plr0G3aOYjOvKXsADKd8LLXi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Db9rt1qF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4775638d819so897695e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762983575; x=1763588375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGZxehFBUyH3uRklLTF4LfK7Gkk9FQHMs1jsZdMbm9U=;
        b=Db9rt1qFVz7Yfq1gVeWaPAZNqIGk1H0QwIOFyyTnvpNI/96gYr4JN5NveDJxclazkg
         dKjwIhmDyK84mvcXUccYEdrjasVaP3NLt2Jf6CmgldhtPZWwAPpNt6tPBVXMrtd+ZEXJ
         81XhXv2JM6Em0eSpwmMnKST2CP6JysriQ3Anmrett4GU47ZX5bmoXnkj6uHM5WRM8qdu
         4UVe9T7dbusFv+0Hl4fnC5ljVoWvBOlwBQbY4UDFWf4KzQseirnlmRJn4NgsfieJ/2ai
         izf1KrJ8s9LoNL6BrtF9I7SHlWTrukLt9QB80t81NkFGYepfcvLKlPoqcZcMedVGGu/A
         Ty+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762983575; x=1763588375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGZxehFBUyH3uRklLTF4LfK7Gkk9FQHMs1jsZdMbm9U=;
        b=gCn+jrOW3CrE+gu+q2pXkOpC2oaxW9ZaxeNqDFBMUga2QpQHUKAEyQjUv4qZ9yCsQ1
         Bj+xJb8lJ/SBOl+2hd2OrdP1m6eb4c64jjCcYIkS1ygW12S/Xl8+TAurSXfZ2X+b+zaT
         7/zlq2BvAN5mCqvhWGA8ZN1/Uf1EXbPtWhY1+FwtDWQJskC5Dg9xAMcQXCheio0ey7HI
         2RgBopAfTomm455qlCn59CMa+vbYbvzHDbgXOMy+SjMJEWmOIZxgXKMZowe9turGU72V
         /DPm2U9Jz9hljycJQ44b0OmNAGkQDKpt499B7279L7f6qghihxTVoO+XCNyozZ4C5+v9
         7CQw==
X-Forwarded-Encrypted: i=1; AJvYcCXiKZSOcJlx2ioLW7Nt7DnC8apxGzlEZbxgG15QUeRkD78SbTz6bGBTkK7K4qzgtduTqTiGzcp+rC80fC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgvSoI589SecdH+AJHGWtW85amDlEYwIOIa0VQzQksfqO/X1S
	OlJHMXgFaMGCx+cJowRdLEhwg05XKwENOXvfGTzXsQhTqz3odfLhtpog
X-Gm-Gg: ASbGnctPKnwowOzcsJPyo3GoE5WTebK5rLDXbxDAO5UtaQXWiyVF1ewBarV85+9pbk0
	1ziq1WkMCs0DovKa7gCBH/3cfgIvO/Ovote1YJRE0mfPDJ67iTG2hlw1RVLoFunQSTiMZbgHPKN
	G6b370on5qeiunTwHsKoGLiWOlgXKQVeSZKHkni9B0kql4Dqx50I1pRn479xCFLcE6a4b3oquFI
	voy0SQLRsG2sGQ2ATu5ObQgERy7Wvn/UAtENVg1sSD/WSjcxTIyzGvgmRENnNWWTCWxxp5eFn4D
	HuTSi07l3nDcd57JNxtM3Ai08AREyf//vJd2UCJ3uFdqWDeqBdmxPHqIVJYiQmdQO7DxujQ1MIK
	/3fMRJhU7L3N1HKIZJTMXVmQ26koKhG00UYGQyz7clkMnUdrHz2jfReKHPIV3o11x7wSYvFfyoo
	xJNKY7OgUY823SdUEdfm4rQSI41oYsJ2bG/7oYNM8i/H9Ag48H5iM9
X-Google-Smtp-Source: AGHT+IF+PXULQaEGJZ+cq+ddTyZ8MaiZsGG+WaQWCmX7nBuDQO/G79xCT621oYLasi7kW4ILjHlg7A==
X-Received: by 2002:a05:600c:450d:b0:475:dbb5:2397 with SMTP id 5b1f17b1804b1-47786ff9065mr38233535e9.0.1762983572019;
        Wed, 12 Nov 2025 13:39:32 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e43c2fsm52087835e9.6.2025.11.12.13.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:39:31 -0800 (PST)
Date: Wed, 12 Nov 2025 21:39:30 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>, "x86@kernel.org"
 <x86@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Petr Mladek <pmladek@suse.com>, Miroslav
 Benes <mbenes@suse.cz>, Joe Lawrence <joe.lawrence@redhat.com>,
 "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Song Liu
 <song@kernel.org>, laokz <laokz@foxmail.com>, Jiri Kosina
 <jikos@kernel.org>, Marcos Paulo de Souza <mpdesouza@suse.com>, Weinan Liu
 <wnliu@google.com>, Fazla Mehrab <a.mehrab@bytedance.com>, Chen Zhongjin
 <chenzhongjin@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, Dylan
 Hatch <dylanbhatch@google.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 49/63] objtool/klp: Add --checksum option to generate
 per-function checksums
Message-ID: <20251112213930.11915727@pumpkin>
In-Reply-To: <tujcypul6y3kmgwbrljozyce7lromotvgaoql26c6tdjnqk4r6@yycdxcvj2knz>
References: <1bc263bd69b94314f7377614a76d271e620a4a94.1758067943.git.jpoimboe@kernel.org>
	<SN6PR02MB41579B83CD295C9FEE40EED6D4FCA@SN6PR02MB4157.namprd02.prod.outlook.com>
	<5an6r3jzuifkm2b7scmxv4u3suygr77apgue6zneelowbqyjzr@5g6mbczbyk5e>
	<SN6PR02MB41574AD398AD3DE26DB3D23BD4C5A@SN6PR02MB4157.namprd02.prod.outlook.com>
	<6msqczigbcypeclqlgzgtqew7pddmuu6xxrjli2rna22hul5j4@rc6tyxme34rc>
	<SN6PR02MB4157212C49D6A6E2AFE0CAA9D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
	<SN6PR02MB4157F236604B6780327E6B43D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
	<yk3ku4ud35rsrfwzvuqnrcnwogwngqlmc3otxrnoqefb47ajm7@orl5gcxuwrme>
	<BN7PR02MB414887B3CA73281177406A5BD4CCA@BN7PR02MB4148.namprd02.prod.outlook.com>
	<20251112132557.6928f799@pumpkin>
	<tujcypul6y3kmgwbrljozyce7lromotvgaoql26c6tdjnqk4r6@yycdxcvj2knz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 08:16:59 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> On Wed, Nov 12, 2025 at 01:25:57PM +0000, David Laight wrote:
> > On Wed, 12 Nov 2025 04:32:02 +0000 Michael Kelley <mhklinux@outlook.com=
> wrote: =20
> > > From: Josh Poimboeuf <jpoimboe@kernel.org> Sent: Tuesday, November 11=
, 2025 8:04 PM =20
> > > > On Wed, Nov 12, 2025 at 02:26:18AM +0000, Michael Kelley wrote:   =
=20
..
> > > > Does "$(pound)" work?  This seems to work here: =20
> >=20
> > Please not 'pound' - that is the uk currency symbol (not what US greeng=
rocers
> > scrawl for lb). =20
>=20
> While I do call it the "pound sign", I can't take the credit/blame for
> that name it as the variable already exists.
>=20
> It's better than "hashtag" which is what my kids call it :-/

'=C2=A3' is a "pound sign", '#' is a "hash".

	David



