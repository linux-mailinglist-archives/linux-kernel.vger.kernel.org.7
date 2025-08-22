Return-Path: <linux-kernel+bounces-781785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABAAB316BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AAB6211F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3E02EFDB2;
	Fri, 22 Aug 2025 11:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4i4J8bT3"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9C52DCF47
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863550; cv=none; b=CBi0XPO8H08dl8+btEAlGUaU6dm5UoslG0XhVIeJwoBmBVKP8A2PqIIW3Jxq1BGqG66uUeG7sFc3xKqo6ipqd/tDR7kLExruS/hAk+hDoIAbSVCiTajWKN4JY+Bv7mngeCHKFhN9Sl4IAdwPrRQG+nfHH79ykf0MGCNma48i4Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863550; c=relaxed/simple;
	bh=NYWk5SfWOfQAb6AMBv49qjcUp+Ysp7H89dXQyPpUYtc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDZVLJVZjsiFNOc7MbNGAiYKidgC9r06qpdShxkqYTd7M21Y1mK+9lQx6NT3ymnjZoTW2brRKp1eDf12qLFkxfkICec1IAtRIf13cTioWC8KHZ9IPHxPzylueW6O6CpfF1sSrG+Z5IqYVji7ePtKOC0JFyakn49GkFRHO+ZQodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4i4J8bT3; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-618b3c750baso1588480a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755863547; x=1756468347; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWE2u+V4DHsHDV1hUcE542M/RK8uRUyoG7ZrTnqEVZc=;
        b=4i4J8bT3LyYed0QZrOy3se26pRxmJrSFWKXFPe4azHw0pYYL3TINOsqtRWsGmN/ZtY
         KB0ryO/GbxJnHVbwAQdBu+VpYc0SrJnqMZr5IEktHsBrHOUTzee6iKZUYLFeRLxGur1h
         3MndcGXXt/13JPXuW+OsmNr7LPcl33LQmQEMWZbkDUyz3emtSfovJyGHgxC1r53omlWO
         umYeFZBt2LpOKrkv6pAjQo1RdhgNu2jU+OcsSk7mzMeUebjZv/ajt2nIBz92QwRrP1jq
         i5Qt/KXxkWNNFy3N3wXNh+LQS48FmEnWBgQqfro+L+ojiloXk3IJL6z8Ihp0jLxwcpP/
         iT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755863547; x=1756468347;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWE2u+V4DHsHDV1hUcE542M/RK8uRUyoG7ZrTnqEVZc=;
        b=Et/UT2jqGQeSfNI8D4suCLvCQaxmn9fioVWcKHER61dqLh1rj/WVhBF7bxtgojpqGB
         bfs6oLu3ed88bcBNiUVZpgjiMfv/I7eV0ihGJhsEXp+Sfj9z2al74aV95S7q6nyMv8fQ
         6R8y72N/ym2vUvHVEtw/wQj/T1mhXIYdDzkAoQ7ov1kFDOsEXVg6EPzE0D2r8phP2GvX
         IabRG5odCbTV44ppcVlGyKWHlT8+L7Pb8DoJMFlHTelmlEy9QDcRc57SAUiWpxgXtst8
         qy/GMxxUEcl45ImkuzGXEpLOWuoS/E1u6MPXnDsYrQmltnOEdPkvIXaOK0cuil4wEToK
         EgjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwgfWjK7A2hhWSzCsln+Kw0DqUyCm1Zu0gKyyZjeV3QDFHNuJaIHD9cwheKHsT3TP/+L4MUX6+foYvToI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+ePvdlTYOc3r/h+Al/0da1PYyz+PDtE2dpX01M9Xi/nu1hjU
	oVmDNEO4Q2kUO0EG57f1bKRCHNqEHof82Tvu6JRvT9pxP6FmrD9VBg0duBuJJ68u0IWWzarDAw9
	OGHi8LWVJuQXXz88gZw==
X-Google-Smtp-Source: AGHT+IGDJ6gPmpwLZbTPQqbylfkKv8yf9Kn7ERiTzNBo46ivNRLyyUa3U5N3GV6j0VP102lLjPtn7S3NennpbNg=
X-Received: from ede27.prod.google.com ([2002:a05:6402:20db:b0:61c:467:142d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1d4b:b0:618:1250:ac5e with SMTP id 4fb4d7f45d1cf-61c1b6f982amr2086418a12.19.1755863543632;
 Fri, 22 Aug 2025 04:52:23 -0700 (PDT)
Date: Fri, 22 Aug 2025 11:52:22 +0000
In-Reply-To: <DC8XLP6C3E5I.10QJQVI4LORSF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250820165431.170195-1-dakr@kernel.org> <20250820165431.170195-4-dakr@kernel.org>
 <aKhYCf6wgSztcdXU@google.com> <DC8XLP6C3E5I.10QJQVI4LORSF@kernel.org>
Message-ID: <aKhZ9jdiNS2SAZv2@google.com>
Subject: Re: [PATCH v2 3/5] rust: scatterlist: Add type-state abstraction for sg_table
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Aug 22, 2025 at 01:48:47PM +0200, Danilo Krummrich wrote:
> On Fri Aug 22, 2025 at 1:44 PM CEST, Alice Ryhl wrote:
> >> +impl<P> Owned<P>
> >> +where
> >> +    for<'a> P: page::AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
> >> +{
> >> +    fn new(
> >> +        dev: &Device<Bound>,
> >> +        mut pages: P,
> >> +        dir: dma::DataDirection,
> >> +        flags: alloc::Flags,
> >> +    ) -> Result<impl PinInit<Self, Error> + '_> {
> >> +        let page_iter = pages.page_iter();
> >> +        let size = page_iter.size();
> >
> > Variable naming here is confusing. There's another variable called size
> > in an inner scope, and then afterwards in RawSGTable you use *this* size
> > variable again.
> 
> I can change the size in the assignment block of max_segment to max_size, or do
> you have other suggestions?

How about just this?

let max_segment = {
    // SAFETY: `dev.as_raw()` is a valid pointer to a `struct device`.
    let max_segment = unsafe { bindings::dma_max_mapping_size(dev.as_raw()) };
    if max_segment == 0 {
        u32::MAX
    } else {
        u32::try_from(max_segment).unwrap_or(u32::MAX)
    }
};

Alice

