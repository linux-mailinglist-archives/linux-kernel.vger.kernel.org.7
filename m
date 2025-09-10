Return-Path: <linux-kernel+bounces-810318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931E5B518AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE031615AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5923218DF;
	Wed, 10 Sep 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbwFBoee"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3DF1A9B24;
	Wed, 10 Sep 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512946; cv=none; b=o4pAz+7q85BhK608fRyPpeF9Kaby90LN+7yEHfHuZOoV5tFne+tA1/Z9m2B92rWGVV2YQO5u507CUKUvXydOlEsDSrnceHmZUDj1RIGIgRiYDTqDwK81qcac+0Vj8WFn86e+hYOEtR5w3Y8XumkxRFByUbUdUXvKSUmDoMxqixA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512946; c=relaxed/simple;
	bh=9ARQuYCGB8AhIE7mr4IbEDFHBMw7yatZFPWu9ioVuoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vgt1XBnsDUfKcb8y4x8ldsUERX7/KADydgLV1v3PpQHlM0ZFen7AKGUu3/LKYGP5Pt+TGzMaCkfMBt1fvETrCKbUlxPJV1U2DmAai7RlJnp9lFC+rS9vI30I+KbYX6TcdwQJN9YwRvsCOcUkJFMWw2PH+zC+yMrxsX0zwv1PqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbwFBoee; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74be52f5447so1793931a34.1;
        Wed, 10 Sep 2025 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757512944; x=1758117744; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FrrFNmNMpEkidHHmhCAHvtUJbeCN3pNPTqmHTfyNlr4=;
        b=QbwFBoeeCr6Vsdv/0B6Tx1kgebK6YbnumB/d48AN2xQIco01e/e1CXvHWFitGM18UT
         oXhE8dIkgX3hbO3ugrvmzzpVJj3B6FPoxmso5goPYjK0a6oglo/K4BNpyMxHMRZRRBjb
         xBBDAC3t44gx1fByljyfs5026Sblgbjga7eahsr+o2dXy0zC5/Y0tYGnVhkP+ODWNKeI
         yUhiuaNfl2Myl3e88dzfAgewn2uixRPCaiKwbDOCe/CxzFkzLZcGgsvncDOtPVPl0Ezk
         njK4C3Y4Kycwoedfwpr8UjPi3VtTy9opDKbTM4GtIfBVcvMaFKUwIiKOf4ftFE2w/Slj
         Bkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512944; x=1758117744;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrrFNmNMpEkidHHmhCAHvtUJbeCN3pNPTqmHTfyNlr4=;
        b=Z3MkdthXtqfbcPT6XXCG9RRrXf+8eH5urULHzB5Rn2o0On61N9oe1qnRbdROhD6tdN
         cTbav47sJ5TK/mJqkRua74YotZuOHubF7E2QehJ9JutkV22ZyCqCa+YAwmbTkpaENHVb
         V/pJ1y3Kr2SdStsQjSC27MQckgPzEPJdxtLZLIs1cBHQxaH+EfShwaDwpSMNqV3bYkKC
         gTC+fTqTksWlDY66ulvDnAkcOYrTAO9byxUgsF1iOUwxVebi1WlCxWuMMtnw8lOjH20g
         pD/tLqB2Xp0nID5GfSHsQ+o6/Pg2Bkznk5kKg4IuV7KQrKgQD6gIjF+9LGj/95iQTIgZ
         ROWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqlIUMrSrET0mNGMn709kT6hQUWHbcEI/ENbE3m9FTVJ4YJGr9FeWAWGFeJXyPUOe2BedAlahGFpYX08speM4=@vger.kernel.org, AJvYcCXkL0n7HgvdZu0KWdktURDa5kE9COV/rHFhiG5lA7rqA4VZchZ6vpwEj2GikHU6cTgtqwx99gC54LpLN/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyENuIJH25nACj3w3bi9zJ+XZz4NzrUltN6AgzlnYSBMG0efpPV
	UDRnB4+YfHuHSiTZ0ELEAP2OXZhTfkv/vd9GY9UaviCJOmZqEz+3dpm9
X-Gm-Gg: ASbGncu7XdBcDAurQXmfE+9NgR1ZMv+c4AV97rsKLmersjAjoz4tfpcPjYI38x4IPHg
	UT6r7Jy1vOL/r+o26vUm1Rx1UUsEraB2SsT8b0PhffmyjGxhAFSVwI7DWVTaTOhhYgcJfRzRbZH
	CIwi9dv5cbJ5HYbgEIJUY8joAQ/d9JFa7GiQrYucaPPSbBQqEGjgNiqBPZd3QkPJg2Pw8qYsNcu
	j7oNmyWe5XuDM5Y/bvtzp922R9HjdBGqDbpUp+3jK//eIsTvRos/THf9pSBY6uvK7S1Gu6ifobb
	79UUJoSUOo96GrKEgn4t1Impq8hYSMVis8ulvbAr2DaH9rwjc/nvct/gTbhRfgGAdXSZ+2wVt6A
	UID7MJzI5fpdFe3S3cx0iFf1R8rILUQJpnJ/NNm/jLN+yB0OYEobeQ7TgkhUM1uPlLSkPqEIBd6
	JNuH2IgP/sNoqkw4ihPWw0PVz0u/gwUUxZT4qv6zwSJPGV
X-Google-Smtp-Source: AGHT+IEiVAjBE1i9IzFu6maZdR6Imj4Cx3b1HpLndp9TXO6tGVmKvfk9vFq/I4JBBIKk7/5gx02J9Q==
X-Received: by 2002:a05:6830:2584:b0:744:f0db:a1a6 with SMTP id 46e09a7af769-74c7841473emr9319568a34.34.1757512943597;
        Wed, 10 Sep 2025 07:02:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ed72c49sm289088985a.51.2025.09.10.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 07:02:23 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 43631F40067;
	Wed, 10 Sep 2025 10:02:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 10 Sep 2025 10:02:21 -0400
X-ME-Sender: <xms:7YTBaIYiy20m0o7STYrTP73QaaerIzLJiAT7dRdlmyy4nTHuScLNxA>
    <xme:7YTBaB6fdGfVfx3k69fmeoqDy4RtFtS9uKgp6giNUr1fAm0lUXs0posuggHxhm2rt
    pwuwJkrwmBErqgE7Q>
X-ME-Received: <xmr:7YTBaOfyYiWqfgxqwSHOtoXm7piTwOXsqEUzrpp4ZcrVfmJsR0JRvNU-PaNNaYbFSsyXSmsfAUXsSWCs1BMhjNO4BrcYVHQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeehvdeg
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtth
    hopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegr
    rdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmghhrohhssh
    esuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:7YTBaMyJzPK83Qi1Dv2_Ztau8N1q8xWXTdv6gFQlGbAePMmbWHY0lQ>
    <xmx:7YTBaMpz1FWDvaSucBbyLawP_tzQNkuXohUBRfIk9JmAYh4jFOympQ>
    <xmx:7YTBaCxacJgbu3FUaGYecpjFX69l5c_gEx_hOGcMgrX-YCR-kZvBJQ>
    <xmx:7YTBaIoBn6iR31c7PRQBDWU3tyxBdYP46uGjEXmCI_B3AvnbwarEgg>
    <xmx:7YTBaKdDFGuC6QJGJQV7ngGZBapa6keryo-8p3dC0C_ailsXkALn0scq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Sep 2025 10:02:20 -0400 (EDT)
Date: Wed, 10 Sep 2025 07:02:19 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, Fiona Behrens <me@kloenk.dev>,
	Alban Kurti <kurti@invicto.ai>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
Message-ID: <aMGE64_J5R8U_rk5@tardis-2.local>
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com>
 <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
 <CAH5fLgg+-oz_cP9=ke+ukp9qYZAsD=hKqvvGfkJWRcCKdrTQ-g@mail.gmail.com>
 <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCP456FHT625.1L5BVZ4LPD8VQ@kernel.org>

On Wed, Sep 10, 2025 at 02:19:00PM +0200, Benno Lossin wrote:
> On Wed Sep 10, 2025 at 12:40 PM CEST, Alice Ryhl wrote:
> > On Wed, Sep 10, 2025 at 12:36 PM Benno Lossin <lossin@kernel.org> wrote:
> >>
> >> On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
> >> > On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
> >> >> Assigning a field a value in an initializer macro can be marked with the
> >> >> `#[bind]` attribute. Doing so creates a `let` binding with the same
> >> >> name. This `let` binding has the type `Pin<&mut T>` if the field is
> >> >> structurally pinned or `&mut T` otherwise (where `T` is the type of the
> >> >> field).
> >> >>
> >> >> Signed-off-by: Benno Lossin <lossin@kernel.org>
> >> >
> >> > Is there a reason we can't apply this to all fields and avoid the
> >> > attribute?
> >>
> >> Adding the attribute was due to Boqun's concern on v1 [1]. I think it
> >> might be surprising too, but I'm also happy with no attribute.
> >>
> >> [1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local
> >
> > IMO the ideal is if it works without an attribute. Perhaps trying that
> > in the kernel is a reasonable experiment to find out whether that's
> > reasonable to do for the general language feature?
> 
> @Boqun what is your opinion on this?
> 

If we plan to make the in-place initializer language feature behave
similar, as I asked here [1], then dropping `#[bind]` seems good to me.

[1]: https://lore.kernel.org/rust-for-linux/aLshd0_C-1rh3FAg@tardis-2.local/

Thanks!

Regards,
Boqun

> I'm open to take v2 or v1, whatever you guys prefer.
> 
> ---
> Cheers,
> Benno

