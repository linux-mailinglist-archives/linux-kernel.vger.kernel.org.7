Return-Path: <linux-kernel+bounces-745928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAABB1208C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A3341CC89D8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6D1F1909;
	Fri, 25 Jul 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tkh6+ioH"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64E18991C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455960; cv=none; b=g9JEftXkdwTc9dmuXGSYSPYDSQ0BKjolpAMd5sb5p+lSrNqhVJJS8JQ0xSzoBs8LL96+fSKhVLOWQzO9SA9ST1izSiiJR5H6UXr22pUHTijh+Z7czMin5ebt1B625uwUv6VshkAdtWlne5KecV/MlQSf8CmzcyfKOvl8dOEFoHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455960; c=relaxed/simple;
	bh=rErd0vkhsR1XmIOg+rYxKzdEiWml1C8S15zNEY6SQtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRupJEItABV29P2aYJx+Xwt1rSVPjMGlaBYXUVPfCZJ78EzLCVe06Pkb68Ygm1Gdfpygq4CVpvyFb6KmR8lJxs6g7nsN/1HozXtUvN+qjAs/ewy6eWCmlQmjj7NjmkrUApT5EOZQmeVaMsBlWYhM0PaHfEtGOa+nVzW9/sNllXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tkh6+ioH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso11617a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753455957; x=1754060757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rErd0vkhsR1XmIOg+rYxKzdEiWml1C8S15zNEY6SQtA=;
        b=Tkh6+ioHCO0/6iLhzqX11CLikvXKDJQucnMOYfwH0rX7sskqkdTAe+bLgZ4f2PYnil
         LxLRvQCQNAaOBW60sBMVDc2qTiH6fgqE5lfD+lRhhEtqN5Jf3VGMJ9AemBieCRosaucP
         V8v9v2b8xMsueJI5d6axn+kPu1q884sKaQn5tCVlTo4KIvldQoO4dXbIj5YoDtufQD/Q
         GX6TXVxClgFF8GOwc2o91NHzkjU0cfhNCFy/F3yxWB9CyvrzBOkUvvyqtv6JesKla3tM
         fILt+Zd2fJ5Xdk4sR9sY+89LHb5AdoBhlRZpGqZPrhmCYeSEHrwDHQ/3fYFl9D8mWWtJ
         4KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753455957; x=1754060757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rErd0vkhsR1XmIOg+rYxKzdEiWml1C8S15zNEY6SQtA=;
        b=thOYTEPT5OmyQ2iW2tH3+wra8lBaXRETfzXAMq3OzwKxASA8IUjxd2T0tsoLAPO3Eg
         jUqHYygCH4Vi4EhapxOkJn/pg4HM/XuQVBMMVckmqw025ekxw5W8RyeOTlI5E3N6SjKA
         lplsgmhz3bBrX1OqBHkFA4oPuZ2k4r7r7DtRszFWJdk2+4P4DsKvthd3nQC4CR5JLXaV
         SxlO4ZHu2Xj9srlHgutGOzThrJTfiNoY1Y18MD7Z3bYCUiUBKHq5EUGpRHdBrMl3XJGD
         Z2WJdqfmBgsN5OGHDmt/k5wbGJaNVAV6YRvloQcnk73hFc5NOZW/4QuDKFkLAHVHH/3a
         nswA==
X-Forwarded-Encrypted: i=1; AJvYcCWOijRR0oj5rHhYInUPbyuDWiUc9g3vvMeAsLK86lUskCRCwYP33mnjYcnV4NHR1WDMQkJzRhcvuciIGdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznyso3P5ifedpUYwnZ5m8Ab5FtvgcaUvyQWEfLQlHmCBkkbDNu
	NLn1gJhFvlW9M2j5nK3KuVK9MUKUeO20eT2pStVvkAsoRKsxMqtGQVKZ+VBONwtylHECCvj6VMq
	exy/J0fx4yh8rQ93Om+M/sw+cewFyoPYFjBuRW0Q1
X-Gm-Gg: ASbGncsgBbQPdMK/hiYbeo2CIayLrRNl07VOMJTtgu1/zVhzhw0X+59i3USnWyLLNAT
	cEpy9KGi3VwxTo+tNKT2VTEK1Ko8CfeO5V1jh9dyKkmu2soIt+NJKxv6aobPVLTFbNzWoVjX/lH
	uqG5aVo/+4PJyJpjtuQbmQrxBNBb5M6KFvBFjg5odrzQBfH4uSHBc+ZcKQ9R5fTTGNI+DXsbodn
	71fReYvvqhIPtzR2ylI+5iwT59b7WyUTfw=
X-Google-Smtp-Source: AGHT+IHKmTAh6R9iL1rXmus18ijLt7akzUMY8n4NFgDtt7glpVAkbORlhirtQCmpctVgDPefYq2BoJRKLakx8bv1O3Y=
X-Received: by 2002:a05:6402:26d1:b0:601:f23b:a377 with SMTP id
 4fb4d7f45d1cf-614e7ae014dmr107087a12.6.1753455956695; Fri, 25 Jul 2025
 08:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com> <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local>
In-Reply-To: <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 17:05:19 +0200
X-Gm-Features: Ac12FXyGb4LwzMsyTvXuiEhGWpmeWzqjrsFRFJQKk37LuQHffOa-CjtL8QZoktM
Message-ID: <CAG48ez0fG1vG_MHnX_GXJG7qZc9XwMxhTqyu9YJpCeKEUuuZBQ@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 1:32=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Thu, Jul 24, 2025 at 09:13:50PM +0200, Jann Horn wrote:
> > There have been syzkaller reports a few months ago[1][2] of UAF in rmap
>
> Will try to take a look when I get a chance.
>
> > walks that seems to indicate that there can be pages with elevated mapc=
ount
> > whose anon_vma has already been freed, but I think we never figured out
> > what the cause is; and syzkaller only hit these UAFs when memory pressu=
re
> > randomly caused reclaim to rmap-walk the affected pages, so it of cours=
e
> > didn't manage to create a reproducer.
>
> Fun.
>
> Please hook me in (I mean you're going to anyway right :P) on this stuff,
> as I'm looking to rework the anon_vma stuff so am naturally interested in
> any and all rmap anon stuff.
>
> For my sins ;)
>
> Maybe I"ll dig into these syzkallers.

For what it's worth, the point of this change is that hopefully we
won't have to dig more into them manually, because hopefully a few
days after this patch hits linux-next, syzkaller will present us with
a beautiful reproducer that shows exactly what went wrong... or maybe
it won't, I'm being very optimistic here.

