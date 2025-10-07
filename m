Return-Path: <linux-kernel+bounces-844638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DE160BC264C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C8414E3017
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCC72E92C3;
	Tue,  7 Oct 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZMpilQSV"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE70204F93
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862148; cv=none; b=EJIdFQsCDRysTAFqGDAKHr44YqF5Ah9wxo2tmf9JNRlNH6Nzwf4V5CtgSL+8H59XPQy9HexODwchwywYwqKoSvM/ldjNlgEVy+vr+JVBgwaefWL6Dqd4lVt+EiQ282PTW2WXQl9ZpG3jbNBYBB+QUtha7EO5e3OYkn918CpbjiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862148; c=relaxed/simple;
	bh=bGIzEWkLqI2mRHt5PpZ0UuClJrjLZ2FwsBMrswRdGWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2xv1a2WJuHRxZxsIE3cvXV/esxDDPWhyTkkCHJUWGMxnJ4folk9usSwehAYw3kNJSrwN0HIYRq1jEf9mw8LuS7jIih8bTNwPp/cfmIufaEpR3+9yxN7cjOrmA+bmDKooaszZii+9Az5eOsdfErssQ/rK360imrdswsNtK8M+cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZMpilQSV; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b472842981fso867068966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759862144; x=1760466944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpJtd1jW6/1i7crN8sSSQKSLeCc/A80YMIDTIdTXw+o=;
        b=ZMpilQSV9SeM5iZ6SV3LIuhJWlD5ir7GREGpjmmX6NmGMILBkGHjwVKp4AXfuhEVwe
         rrzRBSuZ0EFxP/vuNDSWv2liOV/9yJdjiXse8X9O5Vfl8t7dJ33cLyow5owOcPYZY+A3
         JFzWR3OQnAK/gwtmOaigtEgGYlvXOcVSbmdgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759862144; x=1760466944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpJtd1jW6/1i7crN8sSSQKSLeCc/A80YMIDTIdTXw+o=;
        b=eYRuEnBO9/uUdVax91Duq18tA3QE4D5IWp63SKIUDxOLy6jDsgYFtkknUX6uIdZ2ce
         Fb0EHR89OhBWeVBzzm0Du01uKJoNDH4HrzY5Gv9NEmaOFgzeHY1GLGJnOnDI/a4R0oKQ
         AigovcntzSCWE9N96Tbx+sSZBAueTN8aADTeUQtw6+21B0Vjue1cb4bGz1wNXb3qdTKT
         iYmlljE0AyR0UvVQJQ7HgwTUJMoNuc4QhnkCC+Z1XkZrv1mXrykFDPrPhilysfHrHngg
         12juRhR+OpMVsyTdHA+e/mQtdjvMt3tHRjwdW8YBeY5Nwmb9I6Lq7m1/R1MvQE3zJx38
         7gww==
X-Forwarded-Encrypted: i=1; AJvYcCXIJHMoQn01q8mepMEGXYBbEnP2YB2fbsruFE0PlrO/Szyhhj/V3tMfAPvX2xXDRwUgouCLdyu9KXJzLF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJYYVAJQ7k6SEeWO+EBUGkSOH3LzfsXTkpDHe8K6T+aL+fpij
	Kqob5Edr8aZO/axRnigwUEdbnSAbt/fuAxdOUnDaT4trJyLK1+7VpMnfbV2R06pMMQXOUHzcSIp
	V7VdTItk=
X-Gm-Gg: ASbGncueosA5Iy8K7UkYp2ONmiWnq3v11qvIakf4Ex9nZyaSmlcHwKQg5/o/IcFKOov
	/NyqMKGFPVVkm9RowG8E/NWpMq/F13Q3ws8gUwCgFtCEDqerpgckIzPT29+j2ZBom+N9AyjWZGR
	1OAKRm2dcDmtgUCUtUC9amjyvYd+cc1nBxpLG8silmgerOo/+qhc+MgK2ImoGieFOOqTegySOP6
	bwfSRHZdqxvnge/rNU9sFOrELTDLX0nK9fjLfl8UFs4ppY5VtdWeRALQi7kX1equRQflLZg9pxE
	Eg1UBpN+ORYAipb6/NcVk0R9xI7ETPL918yfRtebw0Wry2KzCQEf/rPjjiJwMl67yX7MG3YLOmy
	5nSIY9hieq2NNp5h2ZKrRFKjkh8uQsYI5YAXyQ7pXZiSteNhhOmKy1cha1on4te3G0iMHT8Huom
	vBtHrTAvjfYwyQa6MAjfPW
X-Google-Smtp-Source: AGHT+IFeaIXGoI3+DHITRbeAPV0kUrEg3LwmKYxbhwpZxOzdFrS2vtiSD0DmZsZ/9REvuKSr4y4b3w==
X-Received: by 2002:a17:907:9702:b0:b49:96e4:1845 with SMTP id a640c23a62f3a-b50ac2cf386mr73697766b.41.1759862144510;
        Tue, 07 Oct 2025 11:35:44 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486606dc84sm1430215266b.45.2025.10.07.11.35.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 11:35:43 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so12166974a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:35:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNhGDfzBWOd/k5uOeKwTFCrQKnF8BtmyWxMfjN4G5Qqbncyj2ykjrOVPu8p73B+OXCPpiKYy71B0Te+yw=@vger.kernel.org
X-Received: by 2002:a05:6402:848:b0:639:720d:72d with SMTP id
 4fb4d7f45d1cf-639d5c5942amr376403a12.29.1759862142459; Tue, 07 Oct 2025
 11:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzYUBfz+YmifRDgdBsuTL=FpBxQVfxu23it48kGRzJNPQ@mail.gmail.com>
 <CANiq72kq5YHovH=_a9c0JQgfrAx9gRsQvVo1VfHd-FaupOp7rQ@mail.gmail.com>
 <bd004ac5-9e51-4e90-a3a4-025d74941a38@nvidia.com> <3771775.lGaqSPkdTl@hyperion>
 <CAHk-=wj4_zaYJ9ieazt9dnL69R+SL1PEfJtquGVOqsNCVt_rDA@mail.gmail.com> <CANiq72kDB1cX1XXX7sc3yQvnaUUYB8q1wVKNxykv8=OV-=rWuQ@mail.gmail.com>
In-Reply-To: <CANiq72kDB1cX1XXX7sc3yQvnaUUYB8q1wVKNxykv8=OV-=rWuQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Oct 2025 11:35:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whe8NLsT-TnBxzzW8sCL_X3BN7zv5ELVufy6=sZ_k=uGw@mail.gmail.com>
X-Gm-Features: AS18NWATnozGm7Su-mFLcwXGFGAOFpvtF286zK8E9C7vCjhWFJcx0N9ni2DQ11g
Message-ID: <CAHk-=whe8NLsT-TnBxzzW8sCL_X3BN7zv5ELVufy6=sZ_k=uGw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.18-rc1
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Maarten ter Huurne <maarten@treewalker.org>, John Hubbard <jhubbard@nvidia.com>, 
	Dave Airlie <airlied@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Sima Vetter <sima@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 10:21, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> We can use a trick today to approximate that, which is adding a
> comment after one of the commas, e.g.
>
>     use crate::{
>         fmt,
>         page::AsPageIter, //
>     };

Ok, I think that's pretty ugly, but as a "waiting for official support
for the magic comma", it's probably about the best we can do.

> By the way, I also took a very quick look at the "trailing comma" idea
> to see how complex it could be upstream (it could be either a "just
> accept the multiline formatting if there is a trailing comma" approach
> or the "take the comma as a hint to reformat accordingly" one
> mentioned), and it seems doable. But we will see what they think about
> it -- they don't have much bandwidth, I think.

I wonder how common the magic comma is in the python world - maybe
some Rust people are already familiar with the notion and it might be
an easy thing to convince them of.

Those python formatting tools may be _written_ in rust (well, at least
Ruff seems to be), but I don't know if there's much cross-pollination
of ideas.

> I ran a quick test for the reformatting approach on the kernel, and
> the diff isn't terribly big (e.g. +183 -45). One gets things like [1]
> -- notice how the nested one (`property::`) is kept as a one liner
> because there is no comma there, but the others are reformatted as
> vertical on purpose. And if one adds a comma after `NArgs`, then it
> will make it multiline.

That example change looks sensible to me.

Although that example actually made me go "WTF?" regardless of the
changes involved.

I clearly do not understand the sorting rules either. Why are the
"device::" entries not sorted?

             Linus

