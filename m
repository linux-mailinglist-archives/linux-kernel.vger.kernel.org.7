Return-Path: <linux-kernel+bounces-775382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11082B2BE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7D0166116
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF5B315762;
	Tue, 19 Aug 2025 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LuubKR6z"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794431CA69
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598126; cv=none; b=LS84iUnR3ia6V6QBUyoEszxuU4UCH+tzeiMinfbhLgjLZ/jZlmfjRGq+3sTk/Ejg3GARRkz3D3SwEMeb/IWS+AWMVjVIVZhVABavRy2kDer68tNILG8C06Uz0voAupFrhPOJ2w24DXjpyWlM0O/wI4jN0fozeZ6CLdp2UyvloT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598126; c=relaxed/simple;
	bh=fs4MefNTbsID2g1I7hGNRD2yN0nT/An+4QBFuSPLrsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRHRU5E+w7EsfGu9oJ0J08PnCuiy2QYPeoPYPIKEtGsbZrzsLtb1nPcRqkA/hn6bqsepPFPklP8PWU0DhM2qKHmrFsxIQ1fUY2pCfI6OnaU7Kh+QMO7CRsD7AJL5w6T4g6fDLNb6dJEfW3wmIZ65YQv9xQaCFZRWdYT5kjNKP3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LuubKR6z; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326df0e75so4178545a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755598124; x=1756202924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtwFnGhPjZbaJZhKpnnfvoiBniYG8b/g2aN0jXq3ohM=;
        b=LuubKR6zF60ZGwUhYrSyVWyJDb2IFDSEONfiIpZWNwe3Q4YP+XotpKDWWtxBXUgp89
         lEZqlQoxlTAl8onfknG3h15sdiRu536Rz4T/YJ4DOJSd5iXwUXZnFGvGv1XaFnHoMe1d
         NqdwHZIIRBbAQhtKiCAs1yw02tVf2XGtPYwvgeYUcYdSBZm5B8grClPuJOTcQrKSws6j
         N1Vqtr7xZY/ef6w+ZBu88zVxvyehmp2RB/F2B3fMdKB0JybNcgq4llocyd6UwCf9cRKK
         n1Mv864vKOeetXJu9K2RGY1gcvH9JrMXASabQansbavrsYlpmSt7S+aJR5pcFYiOt2hQ
         c+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598124; x=1756202924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtwFnGhPjZbaJZhKpnnfvoiBniYG8b/g2aN0jXq3ohM=;
        b=DhZdULhEIvDrn5UUU656bjzROMbVDEmVCu+0cclyOwvEwI7OEz/l0gGBO+MHz1bdhk
         VpTLb8qakv3Ep2Eo4P6XyC6op10GKlCunH/fnvgK34mkhwrBJCn3RgkxmvJo6Bu5C3ey
         IuV7JNvf/znTtRXg9aB9gcx3yHPR178VnnIXgbvwZZxabC10plB6Q1rMRrRAGznJ4BSw
         zh5TMFzbZ3J/Cm4+iAty/gDJq28yF6Mtf7wNptIEfx+QWXdlW62cJEBE+7tLr9dNPBXu
         60EQve1dPXcVroSFmWR9Lroyre9xr9TYJssaLpkXlOgid1PC7YkxNQ5rDH3NXdFaI5/Y
         23LA==
X-Forwarded-Encrypted: i=1; AJvYcCV1KYj82UboBnX5/dZQn2fhbciE/0ewnU2jn2VqhxFKcDBj7Pdt1Zx9WB8tuWryUCfa8mZtXPIYB/d5yIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe3eIYVIqiAW78PDqCCU7MQb3AYNPz7nz8O9S6fwss5Qqkhs6h
	9kuQyKO0azk6/q6G//ky2IPs+CVWmL0GZW4kzc8h8IKYfGxJr3zxoOOQSuMF0/dCUsvsnMXxF1F
	BIYw12HvfwEOYfP/acgiu6/jf/e6FeHreH3T1mCSB
X-Gm-Gg: ASbGncsCeQ9DuWCTjfnUw3W3SztpNa+hegOX8KgsagbF9VkwKUFabNV0cDxcduKAJrF
	BsbhEGqdbXEl+WQgG2DUBc1WP87XnUjyEnZ8ks7Y+BJKpBxGBTo5+472Jh/6fg1m2WKOd9pC6p7
	NGwwsEpBFPDhTFeLBNzEJo64EOz+GE8AhETvewhi2vNvW/jitNyBz2LEaZ1c04CYYYbCJ7bm7C3
	p8UCc2rEiSOU7hV+bp7UI0XgQ+lcn4dt5y7LQxdHghO62KDnuaTh5/6
X-Google-Smtp-Source: AGHT+IFfS3hoyBOLwpuKJXoUxE2vzo2ehfwwl1HfDsRL4hlNcLRt9FGWFqIWmbr8FvaOXyY0AViqmicQfnfpexeRIec=
X-Received: by 2002:a17:902:da92:b0:242:eb33:96a0 with SMTP id
 d9443c01a7336-245e0328fc4mr25769245ad.25.1755598124032; Tue, 19 Aug 2025
 03:08:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813133812.926145-1-ethan.w.s.graham@gmail.com>
 <20250813133812.926145-7-ethan.w.s.graham@gmail.com> <CANpmjNMXnXf879XZc-skhbv17sjppwzr0VGYPrrWokCejfOT1A@mail.gmail.com>
 <CALrw=nFKv9ORN=w26UZB1qEi904DP1V5oqDsQv7mt8QGVhPW1A@mail.gmail.com>
 <20250815011744.GB1302@sol> <CALrw=nHcpDNwOV6ROGsXq8TtaPNGC4kGf_5YDTfVs2U1+wjRhg@mail.gmail.com>
In-Reply-To: <CALrw=nHcpDNwOV6ROGsXq8TtaPNGC4kGf_5YDTfVs2U1+wjRhg@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Tue, 19 Aug 2025 12:08:07 +0200
X-Gm-Features: Ac12FXytHPioqIN3_h6-8LrUsWB3kDPFRbJegFs6XnxZaSOjKS1ectEm86g1kAE
Message-ID: <CANpmjNOdq9iwuS9u6NhCrZ+AsM+_pAfZXZsTmpXMPacjRjV80g@mail.gmail.com>
Subject: Re: [PATCH v1 RFC 6/6] crypto: implement KFuzzTest targets for PKCS7
 and RSA parsing
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Ethan Graham <ethan.w.s.graham@gmail.com>, 
	ethangraham@google.com, glider@google.com, andreyknvl@gmail.com, 
	brendan.higgins@linux.dev, davidgow@google.com, dvyukov@google.com, 
	jannh@google.com, rmoar@google.com, shuah@kernel.org, tarasmadan@google.com, 
	kasan-dev@googlegroups.com, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	"open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Aug 2025 at 15:00, Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> On Fri, Aug 15, 2025 at 2:18=E2=80=AFAM Eric Biggers <ebiggers@kernel.org=
> wrote:
> >
> > On Thu, Aug 14, 2025 at 04:28:13PM +0100, Ignat Korchagin wrote:
> > > Not sure if it has been mentioned elsewhere, but one thing I already
> > > don't like about it is that these definitions "pollute" the actual
> > > source files. Might not be such a big deal here, but kernel source
> > > files for core subsystems tend to become quite large and complex
> > > already, so not a great idea to make them even larger and harder to
> > > follow with fuzz definitions.
> > >
> > > As far as I'm aware, for the same reason KUnit [1] is not that popula=
r
> > > (or at least less popular than other approaches, like selftests [2]).
> > > Is it possible to make it that these definitions live in separate
> > > files or even closer to selftests?
> >
> > That's not the impression I get.  KUnit suites are normally defined in
> > separate files, and KUnit seems to be increasing in popularity.
>
> Great! Either I was wrong from the start or it changed and I haven't
> looked there recently.
>
> > KFuzzTest can use separate files too, it looks like?
> >
> > Would it make any sense for fuzz tests to be a special type of KUnit
> > test, instead of a separate framework?
>
> I think so, if possible. There is always some hurdles adopting new
> framework, but if it would be a new feature of an existing one (either
> KUnit or selftests - whatever fits better semantically), the existing
> users of that framework are more likely to pick it up.

The dependency would be in name only (i.e. "branding"). Right now it's
possible to use KFuzzTest without the KUnit dependency. So there is
technical merit to decouple.

Would sufficient documentation, and perhaps suggesting separate files
to be the canonical way of defining KFuzzTests, improve the situation?

For example something like:
For subsystem foo.c, define a KFuzzTest in foo_kfuzz.c, and then in
the Makfile add "obj-$(CONFIG_KFUZZTEST) +=3D foo_kfuzz.o".
Alternatively, to test internal static functions, place the KFuzzTest
harness in a file foo_kfuzz.h, and include at the bottom of foo.c.

Alex, Ethan, and KUnit folks: What's your preference?

