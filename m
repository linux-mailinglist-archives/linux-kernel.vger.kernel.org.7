Return-Path: <linux-kernel+bounces-780546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC7DB3034E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F76B1BC89A8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66C27E041;
	Thu, 21 Aug 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z3iMPlAt"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3341B21BF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806452; cv=none; b=Nw+d30y6zqeVz0VtvTFjZYZCkgWadmkpKWU0GZOQQAWSHlMoScSomJKuU5CENNEUjT3EwciuNcVt26qFQgcRzADv5vVO5fXvpZHteyk2jZXi5qcTFRu1OZlWkcadKbQFFHuoCDY6fCBFXuYSRrUcJ7vbhSWSrgSkM4g7z8Lssuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806452; c=relaxed/simple;
	bh=h7gJCHVPk1eVDB8ZTXpaMfDlbr0NY9UdnbibKYbMlLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6/aufhy3VymV03bfi9PHH/X1EQ7XTPMtTZWCbPNTIx3vrA2PXNEdyzgErTuzIE5uH4aqpabWReQCBUvTJAa0p95/mu01tqSxkc5RkvBU7R/EDrGL4TW0orsi65M2xIAtOPDEKXHz2lKfsDI5JFbzCd8CKY2DTsGUc66nkXkohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z3iMPlAt; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4b0bd88ab8fso84741cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755806449; x=1756411249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7gJCHVPk1eVDB8ZTXpaMfDlbr0NY9UdnbibKYbMlLY=;
        b=z3iMPlAt2of/fHX8JwvBT+AHj83A/nMXVa6Px9qmIvXXJZHd/EjM7rXwpJwq6MBFwt
         Qez5WxmZN0E2SwlWf+PNd3wjnLY7XJrMhiwhm6pMvPYwqezlWVYBoLM5hk2+9W9R2q4N
         sG7rAlmDJsxIb7/jmnZtWHK4ItJ54f5BrNUBsUP+A4P51xEPDj3QK7hAglFc0/M5HpT2
         KQcWN1MIOGE5AIEuWv5xDYu9QnhQYLOAbsbKv14ahvzca4e0Isampk/3E3+Un6LGhTIJ
         KVLjZ6r2HBiwXnhVVdY8i4HScNqVjSAY6wCEdLT17zUie0517EXpSPOzslJ3gLJFDde0
         kqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806449; x=1756411249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7gJCHVPk1eVDB8ZTXpaMfDlbr0NY9UdnbibKYbMlLY=;
        b=tjA3JzaitBBOF1dtHhhT+p+EgqXP7Ei4m1feZWC2ntxu14EipagGzY5vnpHwWtDhcY
         FQBwYADi9pYRo953tt6gbWBmbHItQ+UXtMO21LrkDj0Z/2Dc9cUsn52DaiEqoV7WFSTc
         gcjF/JfnxgfHkNY902MsG9png0X8F7JsVbTvqx+c4U2xnFgXrEPwQm36wJly644Gc1Xz
         CE+MdX0itTcgRoaq1zEEBiucPV7gQxh+Tgc37GMyF5edJjbaCq0Eq5KVikH+RhLZOzme
         FOGkp0dS7AUTSj6KI//ocdO5PsN39fM1pZSNNcHdwL6w0jt6nX2cbVZD4/mQ0Rv4zRSx
         AQvg==
X-Forwarded-Encrypted: i=1; AJvYcCVYPgVYcf1t8AmEj/57EXku0vZX29Tsasj9Qz8rD8q1FPCbGVdOy3DQzQ24AqDfowkd21XHLHGUOW7TUwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0BJx06kffKUcQ5+Vx1T0wHIj+EtfZDv9Qs2gL+b4Wb8wjZ+f5
	pM6adE6asGJJNJHgSRanpX5hd+qOsDn8yWIWlGA+wIMNo4PHmN7QqyDSOs8BqGwKGwRubd3JzmK
	5Y4I4krpCpkGMSkDhPOlKLZ8sZ66jWFHWWvuoNO/3
X-Gm-Gg: ASbGnctWlHfytySaTtZc1+6gsPlEUvDUoM9MfTOcMKJoIwPvfOpC4+5EvuqhW76vaLi
	6cvtL/WPuLs0g0MZbQiwYKd5TDRO+K+lw5cyZIR6+3S4R/d4uOaeRCI7mC6XOXDc7MlQ1LgLUCJ
	chzqOhmmYTeNGfc5Fj4gM9Hdj8Z9KiMhwZldYhvYbOr5RICjgZjQR7OfGZ+fYx6xJdFfzkbKbOI
	LEqhzBTDSZcfJgSwkWl0NuFW2+DJfyH6N3wIxqq/imn
X-Google-Smtp-Source: AGHT+IEzwI8DU6U71/goi7II6qT6paOqU3wRI481Im9qvHexJ8TSWQvjEUvaTQ3LFEGgVCkz44r9UzcLBG34+vGrxao=
X-Received: by 2002:a05:622a:7690:b0:4ae:d28f:b259 with SMTP id
 d75a77b69052e-4b2aae5802cmr801011cf.1.1755806448915; Thu, 21 Aug 2025
 13:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755190013.git.pyyjason@gmail.com> <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com> <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
In-Reply-To: <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Aug 2025 13:00:36 -0700
X-Gm-Features: Ac12FXxXz1-TZ7MbO-XRQDMLid0u_XKSnOpxwqfbdP9x7yILSDSP16_dnK5pKCc
Message-ID: <CAJuCfpFKNQrjtoctVt0N=r1cABeyPjpwrzP6M=OTpp1Rq_0QaQ@mail.gmail.com>
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yueyang Pan <pyyjason@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:53=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > Right now in the oom_kill_process if the oom is because of the cgro=
up
> > > > limit, we won't get memory allocation infomation. In some cases, we
> > > > can have a large cgroup workload running which dominates the machin=
e.
> > > > The reason using cgroup is to leave some resource for system. When =
this
> > > > cgroup is killed, we would also like to have some memory allocation
> > > > information for the whole server as well. This is reason behind thi=
s
> > > > mini change. Is it an acceptable thing to do? Will it be too much
> > > > information for people? I am happy with any suggestions!
> > >
> > > For a single patch, it is better to have all the context in the patch
> > > and there is no need for cover letter.
> >
> > Thanks for your suggestion Shakeel! I will change this in the next vers=
ion.
> >
> > >
> > > What exact information you want on the memcg oom that will be helpful
> > > for the users in general? You mentioned memory allocation information=
,
> > > can you please elaborate a bit more.
> > >
> >
> > As in my reply to Suren, I was thinking the system-wide memory usage in=
fo
> > provided by show_free_pages and memory allocation profiling info can he=
lp
> > us debug cgoom by comparing them with historical data. What is your tak=
e on
> > this?
> >
>
> I am not really sure about show_free_areas(). More specifically how the
> historical data diff will be useful for a memcg oom. If you have a
> concrete example, please give one. For memory allocation profiling, is
> it possible to filter for the given memcg? Do we save memcg information
> in the memory allocation profiling?

No, memory allocation profiling is not cgroup-aware. It tracks
allocations and their code locations but no other context.

