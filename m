Return-Path: <linux-kernel+bounces-896382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F1C503B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562901895D33
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6628A3F8;
	Wed, 12 Nov 2025 01:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3JSQKT9"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58D15E5C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912043; cv=none; b=eU1fZd7KxG0jP8L7m5uyC2DCX5KIM2LelXowt55pq5xCTlzZLvBWUeDOfQHCo3QXCsNOBrPtkDKllTsRDY6JEWlWV8IfpTPhoPqGEEJ2lm6KQUv4f9LkyBql3ykeUtcAxvtP4pp4yBcuOORYjP7CTjrhEZ5M36VkPub1H4y2fa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912043; c=relaxed/simple;
	bh=PeleRCI1tFNNxaPIuI0GF858veDooX/xdZs9lZH6SL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f00WpVGET/cVS1/S8UMySwzCMOq7oN/0M77WYbnZT6BFY4F5cybzhvlW1lzpG5SqbEwO7Mr0NtVrAFOov8QrLKHwqMR9sCrrrR8uWfgS045UdKpLgUCE2+JXHv7v7m0cSuanpGLJmubV71RQuvNwHAePBk2vaSn+xc3JrsrVJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3JSQKT9; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b72134a5125so56401666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 17:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762912040; x=1763516840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEHtgraZ/fUKbUQZ9mWiNPDz97IMk8fjQF9QtcfzT2E=;
        b=Y3JSQKT9abdGAxImroDAwFpogGiJAkJhtLtKZzBUwJsdY/w5pTK6v4jg+gfdgfDdF1
         IypTA68PE4ZvpGnOHzQ0LJcmStDL2cvuov6XD7O54+lRS5/uBcIO5WLPm6Z/xopXJO6T
         CpJGuvPFvrfEShNMNFVUjxq5oOhWQGRcuAwVa8rV6XOky3WwJJzAb+ZmzGBAoHeA2iy9
         pDfBG+cS3Ue9YB0ejA83NWHrqomEpThb3N51aF7jfg8QILua2hSSye5gAnRcISJBvPQS
         aSBe+1oTwsx89gzLK4najtHsmPpy4xJ4hVZC2JBcgLnd+g3rqZG/ZKEN7TVAl27jhbE8
         bcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762912040; x=1763516840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VEHtgraZ/fUKbUQZ9mWiNPDz97IMk8fjQF9QtcfzT2E=;
        b=VLupBWtGDOapjFWl176UpzhlBxBLR8Ywk5Tjsb6lLdRHp8WPeRZpsgpWP0W6ddHjM7
         lmQ4D8dKxj9c6vbAwepKKdFKuIW0exFcSJNzKU2Cp06LsIekoL/JesbElUkVfhWrdevM
         yawiCn7y23VUEaukQXMfYuFM6jggebUwMoNBnjXPnbqiPF1PHjs9JzJBZCCtZid7ZDN/
         irtNXEkOGWAfZUkoyBWeL7vIi2aqGwQIdyBY/sV9l5rNKPXuJBCEXio1y5UL0levvjhK
         +NLMvjv63E1tdKKiAEGUf6OE7KjGMne/A/uV9oXRh0jnFH4eJcQt4dZOJkSvoyu8taZz
         6uLw==
X-Forwarded-Encrypted: i=1; AJvYcCWuS5CFxZH1azGXs0NQq06vVL2589gjN3nIY3T3YaQnTROuxmD6zwARRxWgmnvXL6gzk7AxP2Jb3Rf3/94=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt/262sYUl0lCv6FYVQPFCRftft+RL0snQNU97EkgOdnFgkN+p
	P42AwkoGPW5+I9OiIRqeEt4CnqPj6yU3kTQip9sxqQ6/POr0jWWFJD6uDvDSEmtZmYN2Z7+mig9
	dGB/PDjk03VW2H+HX5cub2bX/1lgPvpU=
X-Gm-Gg: ASbGnctmd4RmC2n0zvMVUKqoatGUchLA4J/eYsXvm9qExKJ4JxJWlwDBzTUfbGqrgTJ
	r8GzXm5frIZF/FxyjtSHPLz9I2Lz3n0HRWEHTwKKwGh0Ixt/Y421VLSPnv9oBr5NerWs7C0bFB8
	szedPuxxcOwTG8P4TkmFXhz2qyhBLcNLJb33Qw2wG0u3814rH7qdJESc7wGSaTkbzVdH/kPz/6D
	RyT/Q0iH8AIxqNX5GM0mICBUQy9sEnCrfrJebXvyLiS0N7bxV889Gpet/59gg==
X-Google-Smtp-Source: AGHT+IEbQYPQDxMuWZR/m6mBn2rA3S8EO24KpUvcKbJi7yEkJIuo7KqOEOFCzz3oidVBkuth9XGIBkvwDMcWa6zpj0c=
X-Received: by 2002:a17:907:2d06:b0:b72:a40e:d10 with SMTP id
 a640c23a62f3a-b7331a6b9e5mr122140566b.40.1762912039696; Tue, 11 Nov 2025
 17:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111135432.2143993-1-dolinux.peng@gmail.com> <20251111183703.0045ca23@gandalf.local.home>
In-Reply-To: <20251111183703.0045ca23@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 12 Nov 2025 09:47:08 +0800
X-Gm-Features: AWmQ_bltpbEdw1Y8807ORXe8b9Zx-V5004sVJJmbh_N3pO_4_8oZMUaVYo7n1cw
Message-ID: <CAErzpmtdJP8MK9kmoi5BSzpUuJzsZ3+AxWV-jKGC8gPxbMTd4w@mail.gmail.com>
Subject: Re: [PATCH v2] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Donglin Peng <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 7:36=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 11 Nov 2025 21:54:32 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > +     /* Store the retaddr in args[0] */
> > +     if (type =3D=3D TRACE_GRAPH_RETADDR_ENT)
> > +             entry->args[i++] =3D retaddr;
> > +
> >  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
> > -     if (fregs) {
> > -             for (int i =3D 0; i < FTRACE_REGS_MAX_ARGS; i++)
> > -                     entry->args[i] =3D ftrace_regs_get_argument(fregs=
, i);
> > +     if (store_args) {
> > +             while (i < nr_args) {
>
> Nit, this could stay as a for loop. You just don't initialize the 'i':

Thanks, I will fix it in v3.

>
>                 for (; i < nr_args; i++) {
>
> > +                     entry->args[i] =3D ftrace_regs_get_argument(fregs=
,
> > +                                             i - (type =3D=3D TRACE_GR=
APH_RETADDR_ENT ? 1 : 0));
> > +                     i++;
>
> Then you don't need the "i++" here.
>
> -- Steve
>
> > +             }
> >       }

