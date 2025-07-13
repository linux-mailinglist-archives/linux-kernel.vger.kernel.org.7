Return-Path: <linux-kernel+bounces-728895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 017DBB02E90
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8FB17936C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED28154BE2;
	Sun, 13 Jul 2025 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePREpTZd"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673C2E36EA
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752376376; cv=none; b=djaJmA+JeyDBp5mMn9aLQIEORM3cxFQ22VvyVN0pElX0gGAtYIUoL2NwgYv7/JXmqhiNa7ivtTSo3mIEzpCK/Pj/fe0+cygzSvlYxC7tkQ+mn/9ZSVVsIJGtKTyyxdrgQe7CS2iN74wMIaRXBs17UGKmQDGQLoXGqalvFLYXNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752376376; c=relaxed/simple;
	bh=PYXSckiGcJNn/KAUw9jmYJc1dN7gwZ3GM+cfuiI1tqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EftAvlZGT2ZAXcZdcycgNoF7K+1iKBwXvt+I1B3henDeEcHc5koEzrCuXp4VznPzywqoKiKPcTwDDUQMGWlXsmzmvIO7z2AzZEbnfTZ2OfroFA4eGd5YTcKGsUHm60jejhfqbwZdsyL71DcJB0LQpQvZrOK1W/uwqUokBIrECN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePREpTZd; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-711756ae8c9so25742247b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 20:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752376374; x=1752981174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYXSckiGcJNn/KAUw9jmYJc1dN7gwZ3GM+cfuiI1tqw=;
        b=ePREpTZdOWbZ+xdINoNs3vStvW/WKA+TfxHu1/qMDWnnXmqoA0MAv3FaM9+gHPCB9e
         fOZ/F3u9hjSwfdbTZ/PrTJKB4ulfSB6+52hZ0TlnNAAqynrbQVfmzaGOODhgBkIGCfCE
         jhzpcdfbCvRG4R/lmdX+gcQiMgxW81f13KLRn9wdUJePNd6dxkEPY1BkX4VOOuCXOhnO
         hcktVL2mZSQV2gAwYTbLaDVpf7BXUNJXPu6SQjfnfnPGedtcjPZLpLz85IG7sTJoUr2b
         XoIfQHzMPxhZ2YUfqQs4rAE2HIZRdXsU1HruHRj8+g8nxJomkicooFaNKUO3t/uomtJd
         liNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752376374; x=1752981174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYXSckiGcJNn/KAUw9jmYJc1dN7gwZ3GM+cfuiI1tqw=;
        b=mDAiJkbBymVloMBH2G0dbjUA3BgTDLHpD+qiVLU2Ze03fPD5h9TcGDVg9F5SnZ+IK6
         tqrsAr+OZZbjWlqCLU3c8JER5uf2iHL4Y88O+2LcFulwiMJc4tb7pqfr9ZFVj5QpZz3p
         Znky1tXpBTQP3SbDsIsabRAQNLO6vjwof8wkAAhR6U3CqylY8LvZnL132tc2ARbrWKLy
         qEVZS4zN0YudYB60xlAt1uE9bclinhOgYmCoK7RDNecfDfKU75eXCWh/pXsa6BoNKq6X
         pj8Tv/oETrsD55Cx4vPCMVf+L7YQNNKANoVUAHL/oXb3BYOo/1hzoiqFehuXViEXPu2h
         xTrA==
X-Forwarded-Encrypted: i=1; AJvYcCVc90XULAc9DVILPb0TiH/oNipYvmXm3fNQ8T8OQedc7Ztz3uQGelrdKkGz9IfUlC/cq/KJbfOsQA3tJik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExINizyjFnzmQulmKwVuGIUA1vtcR1Chy3CRf1UigSmD1AEg5
	0e3oF7nOofyvuyCJmBTknAn99B2pHntMTgnipEn63y1GqCPPAwgfxUM/tKp/gUqLhAAHXhCN8MC
	ziV+g3b0MU5i1buLb69IAD5gFKQrFeE4=
X-Gm-Gg: ASbGncuUobUD+vPGiyiwGJLx3K57uPL6uH+6pFhkh3FbppegAQmycrUJ1ceCP+fY4Aw
	TVGRI95F4i5IsJDJ7gm4KE9SGwLpWEXJHoqol4ioZIc7AMVRtGegjl/2mIr8dNqluDSDrPAWir/
	TD4vWbbVSc6QHkdLRq9aS0l7uC19pCT+t1nZ/je/Fo3NV57L4jfvaEV6eh0Uh/o+oz+giobmXwe
	Y0ITkQ8QGnUPVT4BN2BSRw6aU8nUXQP78/D814=
X-Google-Smtp-Source: AGHT+IFlVubhR76J04TenbEV/VWoM26QXR5CBaA1M4O4pbJbbN8eGEb8aJ8CPVW6NE+SUJ0q8OELnntKt6OBSMfQDPg=
X-Received: by 2002:a05:690c:6113:b0:70d:ecdd:9bd1 with SMTP id
 00721157ae682-717d5e9310emr135689227b3.24.1752376373865; Sat, 12 Jul 2025
 20:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620235053.164614-1-olvaffe@gmail.com> <20250620235053.164614-3-olvaffe@gmail.com>
 <20250623082122.62f69579@fedora> <aFkZaoPXkZWaqWID@e110455-lin.cambridge.arm.com>
In-Reply-To: <aFkZaoPXkZWaqWID@e110455-lin.cambridge.arm.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Sat, 12 Jul 2025 20:12:43 -0700
X-Gm-Features: Ac12FXy3WPTrrjYpoDpqZLdmXP9qM0fxFoDRqaumTNKzbc-mSJMltJnSf0MnYdk
Message-ID: <CAPaKu7R57KE+VFNYxaaUBCph__U5kN7xS=FSVsLzh+c=S1cp2Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] panthor: save panthor_file in panthor_group
To: Liviu Dudau <liviu.dudau@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 23, 2025 at 2:07=E2=80=AFAM Liviu Dudau <liviu.dudau@arm.com> w=
rote:
>
> On Mon, Jun 23, 2025 at 08:21:22AM +0200, Boris Brezillon wrote:
> > On Fri, 20 Jun 2025 16:50:51 -0700
> > Chia-I Wu <olvaffe@gmail.com> wrote:
> >
> > > We would like to access panthor_file from panthor_group on gpu errors=
.
> > > Because panthour_group can outlive drm_file, add refcount to
> > > panthor_file to ensure its lifetime.
> >
> > I'm not a huge fan of refcounting panthor_file because people tend to
> > put resource they expect to be released when the last handle goes away,
> > and if we don't refcount these sub-resources they might live longer
> > than they are meant to. Also not a huge fan of the circular referencing
> > that exists between file and groups after this change.
> >
> > How about we move the process info to a sub-object that's refcounted
> > and let both panthor_file and panthor_group take a ref on this object
> > instead?
>
> I agree with Boris on this. One alternative is to put the pid and comm in
> the panthor_group struct as panthor_file makes no use of the fields.
I took this suggestion in v2 because, when the task that opened the
node differs from the task that created the group, we are more
interested in the latter.

