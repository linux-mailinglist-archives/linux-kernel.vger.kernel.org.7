Return-Path: <linux-kernel+bounces-832638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 486B3B9FF8A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0381885CCC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEA29C323;
	Thu, 25 Sep 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKU7gyTm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B60829B229
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810031; cv=none; b=NwcEgxJJqoMZYDmerVEDjzf/XEJ28tuLBkTy3MUzkATJRRWQyHRbrUgCwzBjE7dhz6vRq6JBvtNgNmiFcOvm8pElnojNxibFSroI6FBCGFqbCEINccvYFEqhhYLNh5JDVtbjJ8pQslZF8/EFfsL7/1LcD81Svj0zpaNpXmSpGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810031; c=relaxed/simple;
	bh=9S5P/Bdj720bk805Gz5LUXF0wAlaDIZ4nUN2ksl9Ab0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+3ZYoQFVtBLyUmmFGEgkxQADD4HnjcdC9rwo5RrMXyDDkHvfWfF/X6Xvq6GLRQvcTLbPRqo+mO56Q+FbmPKunD7rbiwfdXDZwdBgp0McECBEy5VZTbIiXD1/pjKJ2U8VsTkniovV6wjUthJIM4lNyb/5NyE9h1gAPg+FKSn7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKU7gyTm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758810029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jOKkbCQdz4s7kFS4NyoQHb7rePtHYRhLO7DwNkxy16c=;
	b=aKU7gyTmsyEz6o5P8GwtqJIQ4YvAc82jlDU5QZ43dcPRnAvvgUC6aZpEE78DL9XiGCwyF3
	GjNTNeNNqf7RfZx1hK9WqQUbYow+n1/FulGifs3nn4tGvQjKpVCJpXXytKbiO2wj0h8x6G
	/9m6vuiDeyjepvfXSQSAkegz6GBs/rs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-OABRcQzMP7-cIFuPG3Ebvg-1; Thu, 25 Sep 2025 10:20:28 -0400
X-MC-Unique: OABRcQzMP7-cIFuPG3Ebvg-1
X-Mimecast-MFC-AGG-ID: OABRcQzMP7-cIFuPG3Ebvg_1758810027
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-81312a26ea3so240367685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810027; x=1759414827;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOKkbCQdz4s7kFS4NyoQHb7rePtHYRhLO7DwNkxy16c=;
        b=F1yv0+ZrWPssnJzMjQX4qq5ZS+9lKfqpYuL0fhlmIfv++DCrkzK2J2NggR+ezABQdV
         V5YsJLvjZwO4rMCwDDm/tiV8mziwOWQswzfXkRRKaIs5Pr5yB8nlm+M1rk+Dg8qau+Wq
         oz56JC9nBheYKs+neQ/QxA0MgcnDGa+X0nb0aU844eH9PBCrpYaYpZuNJl45lKA+0OQN
         bslst8YnBInQkdRZLgJbK2y/SS2iJTN4FcsqBU98RE9IkG/0nyg2vCGwalxIp9igc0WH
         r4h5/6n1dE3pIKwczBVQEbcQuwk+1nOC+EPRII8BvRMCuBxtJjddlx0y6Hg1cYCXIqIs
         fDhw==
X-Forwarded-Encrypted: i=1; AJvYcCV9KqdHw1TkkZK8Bihjg57blysbzuxqP+96cydfN1ElvVCKogXfUnd2A5wmK1KHhBQbeyB/EocR/Au2oAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4j17B/fXaVxi1s9rWmQHgFpt64XZKN0Q7AIK9Yv+DSS+2fFV
	GgmcLNYVOufshsvurADE893lfgDkosnwZxXKo0c8PNsu21L3uyuKFanLrHBQnpYdflrx9gVe/Om
	mu7RH4y7LRuO06UUyodiT12wZ7rcTbqrWMWikE534pcdthb8RGc0O2yfM5JuZyctmeA==
X-Gm-Gg: ASbGncveyOveaR0LlDnsZ/5EFCGcN4wQQW4uakHQm27hAQVkWnGihlxofMQ47C0n8hG
	k88AcTSPpoMv4U31WIGyjj2Yid5OyEl071cE+9ZqiSFW+UZtTOSQZ9urXH0ZFeiogppYtU0sXnj
	iJQlTt+C9kLOHhQHnSu4Y5Rp7HQxOiqCRKgnXd8saYX5Iqf0igOpHQTap8R9ZsEdAYG/L7lAJ39
	LBj5bHtcZiv2nJ1Nx5VVU6hoKq5hxuqHUnREwReZfhUvWX6Wi1t6O80B3sTiUH+22AaShhiqw1b
	gOgPDYfRhnZfnpG+MRGsPzqhX/8f0u924J4E7FeqTgIksxsSQkCTUp7I6tIkkmBNJzuJzJS/vdc
	0ulOMjx3oBYNJosMG3T8ffcHkvcrxSX8=
X-Received: by 2002:a05:622a:5e07:b0:4da:7d53:c01f with SMTP id d75a77b69052e-4da7d53c586mr25949771cf.28.1758810027221;
        Thu, 25 Sep 2025 07:20:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzAMws7Y35IXPj3ULsxxU+kNGPjPFIvTWHEyCz1nsMPS1pfVod6yEtRsWbHOX7yetDXHZs8A==
X-Received: by 2002:a05:622a:5e07:b0:4da:7d53:c01f with SMTP id d75a77b69052e-4da7d53c586mr25949321cf.28.1758810026700;
        Thu, 25 Sep 2025 07:20:26 -0700 (PDT)
Received: from redhat.com (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db1087267csm10756031cf.26.2025.09.25.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 07:20:25 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:20:24 -0400
From: Brian Masney <bmasney@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Russell King <linux@armlinux.org.uk>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v4 00/12] clk: add support for v1 / v2 clock rate
 negotiation and kunit tests
Message-ID: <aNVPqHldkVzbyvix@redhat.com>
References: <20250923-clk-tests-docs-v4-0-9205cb3d3cba@redhat.com>
 <20250925-eager-delectable-frog-fcbb5d@penduick>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250925-eager-delectable-frog-fcbb5d@penduick>
User-Agent: Mutt/2.2.14 (2025-02-20)

On Thu, Sep 25, 2025 at 02:14:14PM +0200, Maxime Ripard wrote:
> On Tue, Sep 23, 2025 at 10:39:19AM -0400, Brian Masney wrote:
> > The Common Clock Framework is expected to keep a clock’s rate stable
> > after setting a new rate with:
> > 
> >     clk_set_rate(clk, NEW_RATE);
> > 
> > Clock consumers do not know about the clock hierarchy, sibling clocks,
> > or the type of clocks involved. However, several longstanding issues
> > affect how rate changes propagate through the clock tree when
> > CLK_SET_RATE_PARENT is involved, and the parent's clock rate is changed:
> > 
> > - A clock in some cases can unknowingly change a sibling clock's rate.
> >   More details about this particular case are documented at:
> >   https://lore.kernel.org/linux-clk/20250528-clk-wip-v2-v2-2-0d2c2f220442@redhat.com/
> > 
> > - No negotiation is done with the sibling clocks, so an inappropriate
> >   or less than ideal parent rate can be selected.
> > 
> > A selection of some real world examples of where this shows up is at
> > [1]. DRM needs to run at precise clock rates, and this issue shows up
> > there, however will also show up in other subsystems that require
> > precise clock rates, such as sound.
> > 
> > An unknown subset of existing boards are unknowingly dependent on the
> > existing behavior, so it's risky to change the way the rate negotiation
> > logic is done in the clk core.
> > 
> > This series adds support for v1 and v2 rate negotiation logic to the clk
> > core. When a child determines that a parent rate change needs to occur
> > when the v2 logic is used, the parent negotiates with all nodes in that
> > part of the clk subtree and picks the first rate that's acceptable to
> > all nodes.
> > 
> > Kunit tests are introduced to illustrate the problem, and are updated
> > later in the series to illustrate that the v2 negotiation logic works
> > as expected, while keeping compatibility with v1.
> > 
> > I marked this as a RFC since Stephen asked me in a video call to not
> > add a new member to struct clk_core, however I don't see how to do this
> > any other way.
> > 
> > - The clk core doesn’t, and shouldn’t, know about the internal state the
> >   various clk providers.
> > - Child clks shouldn’t have to know the internal state of the parent clks.
> > - Currently this information is not exposed in any way to the clk core.
> 
> I recall from that video call that Stephen asked:
> 
> - to indeed not introduce a new op
> - to evaluate the change from top to bottom, but to set it bottom to top
> - to evaluate the rate by letting child clocks expose an array of the
>   parent rates they would like, and to intersect all of them to figure
>   out the best parent rate.
> 
> It looks like you followed none of these suggestions, so explaining why
> you couldn't implement them would be a great first step.
> 
> Also, you sent an RFC, on what would you like a comment exactly?

Stephen asked me to not introduce a new clk op, however I don't see a
clean way to do this any other way. Personally, I think that we need a
new clk op for this use case for the reasons I outlined on the cover
letter. I am open for suggestions about alternative ways, and will
gladly make modifications. This is why I marked this series as RFC.
Patch 10 in this series is the main change of note here.

Additionally, the presence of the new op is a convenient way to also
signal to the clk core that these providers can use the v2 negotiation
logic. Otherwise, we'll need to introduce a flag somewhere else if we
want to support a v1/v2 negotiation logic across the clk tree.

As for 2), I negotiate the rate change from the top down. The new_rate
is propagated in the same manner as what's done today in the clk core
when a parent rate change occurs. I let it reuse the existing rate
change code that's currently in the clk core to minimize the change
that was introduced.

Regarding the clock table in 3), it could be done with what's there,
but there's the issue of the new clk_op. I posted this to get feedback
about that since I think we should settle on the core changes.

Brian


