Return-Path: <linux-kernel+bounces-806665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8BFB49A17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316491637DF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898F2BE62B;
	Mon,  8 Sep 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImOx2ESX"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219945945;
	Mon,  8 Sep 2025 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360289; cv=none; b=pxRsgS4ohpxmA6Ry+AlzNtvQxGfXwULFd68wADANHolfYFIGN/gZcimuyd32yfV7q5bakWE4rD8MNrpbjzGENgwWe+qFT/FUskroTzU076cmZ5+FZWC/10XPCZl8SXvHo4mNxx8MAbRHcbt/q0TS6IRYHiQtojxwWx8+d5kTybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360289; c=relaxed/simple;
	bh=9zrTiGY3vGZMxk3+Zve/YTWV4HePUtAgTaI9V41iObU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn4n8Nsnmwwy1VJzj9qtzo6rdmAy/dIn7JUdmJKU0o/lhwSjdim3g+vCe8WAQ0Te6D8WG6NgwM4BkpTRKn6jJDua9gwqFe89mEBwXKv6Qd3v/dAIOFBeU9zBu0mVs0wYUYvAfRcyViHJtcesR2o/mzveX46/Dp/4NYxjzar/Pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImOx2ESX; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-729c1074875so34111866d6.0;
        Mon, 08 Sep 2025 12:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757360287; x=1757965087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz439NWTNaZ4G1pBZKrSBs21o1PeCh6E1eqZGLA8wkg=;
        b=ImOx2ESXpofuSz8GndGaPyw6B13jBfKsIKJVzpYyNrsfx2TrRzwPlgn8puyZQ3r0ht
         MhETpz+Pf8j7FCj3+Qs+kFAg97Z1IiQocFODDlckTqyNaHrDYVx01cblsoP7UWI15rbE
         4ZnPxm0Fm/gnKxlY94Bj186s8sq73NPRTT8TY1dYNC88HQF8bNHLqwYPrV6hGm9SNJ35
         lzmyQ2d9GoAUYp7M6Z2kETozcF/v4npkyKaDFdPJcRRqMhD6y4SzIZNE5AE6SZVKbaNV
         gWzebRC0AOclp4gyTlQjO715VqQ3DM+mKEsTnMFhCmbDcHQ5/k2xgeos2Yg2TGDeL5G8
         jt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757360287; x=1757965087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mz439NWTNaZ4G1pBZKrSBs21o1PeCh6E1eqZGLA8wkg=;
        b=lQgEhFclCOXqYkDORXOYzLZmFA9dGphpu76ty1gqAM2ZDmcJEtXGDox1DGqvzRjCbf
         4xuj9S75dgXtI0Bm4fbkc0efM3ZPx4VVUkqXbWkHXsaNkBh/D6CUpAUTiWR4GXIFUN7Z
         5YdziziY2bgJGivkVj3KZVTOLHQQdXSOexE/ciPBpy0nN/0XuSrwItN7VeofUunHoFyO
         /b2bVBo1V8gxjahGxnsvsAcJwigQV6Oh21IQJOE8v3EQ5eU+htgeUIZspzpzlXpEtfM9
         qPW3GmAZATYun7YWKJZ2yfoquAhddGhMJZ7hg84jVT9/olY6t1XApg98BHQ6U4mGCSqE
         fIbg==
X-Forwarded-Encrypted: i=1; AJvYcCV5rexoikTa7ACPgbwRQ1j5BIUDRe46Xgmimr9wjqXeEWbxYFLRV1UE7RXydnrF1YXSMj1M/hDpl2jXum4=@vger.kernel.org, AJvYcCVglp+jx8u+sSJzM8/eFbKzpGKaGV/ViAePsZfJRM896heHU9LWXWikB5BYOOoHFepE08iK8M5KIdoYnsOyIKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOC+kllCtbS3KejjT4rLdIT80TR8N/pL6/m1YqeLkX26zA+2K9
	0yfJX4EbRWgCbp7/oGh50Gr7OwsBpBE0kN9S2lZmRi66cDrJVS8mpZ5mg/jSqQ==
X-Gm-Gg: ASbGncvTqtZefvnYbN6iITDuDvdEaYj39ziivxjz7+m80ykAeqgLSVlcHYhGNnYvvqY
	EpJy2h+40u/GLY8BxYk66urLqhAb3cyKROmAWlXVV5iSOd41p9/4fTa2B7RKFaYZFD6T5xIonaQ
	ePLJCRtte8htiCxTAFyp78ysxWVzC3xVTpQcViFu0OaTVgsYacPCETd4P1C+jda67nc44vr9wru
	qo1nDCP/ZYfnYJGM8Lfhv2VfVLG0+NhyoJOpzaKmKnpLJJMlVqMyMOrzJdCYhmNQ2SYtQAJt0D+
	mmKn5Pdg0bL8CcJ3cSPxbNv944IcIJ4o7pmA8aFSiEnvsJy50ozqr1RzkPXfW1OsodWrpQW52qm
	eTWUUJj6yNWsZheihJRJ7/BjNOVltcOfr2OPpDjCOyPd7DF2JQ18jSOfRegDWhkPMKPGlh2BCoQ
	j54477K2u2PRDkNHZxWVgSGgqsB4E+yt93aQ==
X-Google-Smtp-Source: AGHT+IEfmwoguzXcsUAse8UFcvcD2HVF/pjPcHVcl0GquUR6WY2BLygLU7VZVb1IDhnPEgtR+spafg==
X-Received: by 2002:ad4:5c8b:0:b0:70d:ff3a:f981 with SMTP id 6a1803df08f44-7393d42bc35mr76447596d6.37.1757360286977;
        Mon, 08 Sep 2025 12:38:06 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72aea5d8d61sm88883306d6.56.2025.09.08.12.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:38:06 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id ED170F4006A;
	Mon,  8 Sep 2025 15:38:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Sep 2025 15:38:05 -0400
X-ME-Sender: <xms:nTC_aNam9pyP3e64g8aLu08bGEsAYf_Ch7kZpj9BL6dXjkYwHYq9aA>
    <xme:nTC_aF7pEpOhXRhbcZrJdzR4p0HuKWC_70tBN99eitLbaIEaC0muqlzAwsL-nfgOV
    zHJzbQ7xPDNC5lsBQ>
X-ME-Received: <xmr:nTC_aNmpBWYrVD_0B9D1V-0YGCuJjGHLEHv_n6otK1k-A20eOOuq6MqWZ0NkLb-u5T57ey9_8pLRtSjtxpIKN_1JOioQ4yJl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlohhsshhinheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:nTC_aDH6zVXEjRgWDVRvlHkvwT92SsHXbAg2pBoCzii0fBIzu1u4_w>
    <xmx:nTC_aJEo0Fc-NfjwCbRTboXCgs4zezpULGxcCBkX51709JwE8KY1Ew>
    <xmx:nTC_aD2rXtYy96aR-gSI9QXyyEd1auS27ZBby4J0zuqKYV4gPdTsJA>
    <xmx:nTC_aDdOfnih61EptiuyWY86vtZrHpqIuO4KvoC2JxSsUtbjSTsysg>
    <xmx:nTC_aNJ2dzCzoyKGk89Sfyua3AMcwGG_BMZzDwaVxIkqA7qTgljWvHyP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 15:38:05 -0400 (EDT)
Date: Mon, 8 Sep 2025 12:38:04 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Fiona Behrens <me@kloenk.dev>, Alban Kurti <kurti@invicto.ai>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: pin-init: add references to previously initialized
 fields
Message-ID: <aL8wnJcro6uXiD74@tardis-2.local>
References: <aLzoyWpOr6eg-3yB@tardis-2.local>
 <DCMFN8UGD7QN.27HTYEXL87Z8@kernel.org>
 <DCMQVH09L1Y5.3A842FC1NGG5H@kernel.org>
 <DCMVHB8P7Z2G.PCOWPQXBSBT6@kernel.org>
 <DCMW6H0VJ9AP.1XWI1RI9YWO9H@kernel.org>
 <DCMXPGXDXHYT.D9VJ5QBMAVPN@kernel.org>
 <DCMYLXICOGM7.2G4JBQAE7805B@kernel.org>
 <aL46nRkYj2SlOhl8@tardis-2.local>
 <DCN9YYV750Q4.3K9X2EAA3RKJ8@kernel.org>
 <DCNALVTE4DIN.1K0U4BGN35CHI@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCNALVTE4DIN.1K0U4BGN35CHI@kernel.org>

On Mon, Sep 08, 2025 at 10:57:36AM +0200, Danilo Krummrich wrote:
> On Mon Sep 8, 2025 at 10:27 AM CEST, Benno Lossin wrote:
> > On Mon Sep 8, 2025 at 4:08 AM CEST, Boqun Feng wrote:
> >> On Mon, Sep 08, 2025 at 01:33:26AM +0200, Danilo Krummrich wrote:
> >>> On Mon Sep 8, 2025 at 12:51 AM CEST, Benno Lossin wrote:
> >>> > I actually came up with a third option that looks best IMO:
> >>> >
> >>> >     init!(MyStruct {
> >>> >         x: 42,
> >>> >         #[with_binding]
> >>> >         y: 24,
> >>> >         z: *y,
> >>> >     })
> >>> >
> >>> > The `#[with_binding]` attribute makes the macro generate a variable `y`.
> >>> > `x` & `z` don't give access to their value. (we of course should come up
> >>> > with a better name).
> >>> >
> >>> > Any thoughts?
> >>> 
> >>> It may be a bit verbose is some cases, but it makes things pretty obvious, so
> >>> LGTM.
> >>> 
> >>> How about just #[bind] or #[access]?
> >
> > I like `#[bind]`.
> >
> >> #[shadow] or #[maybe_rebind] ? Or #[pin_ref], the last one is clear
> >> about the purpose.
> >
> > Hmm in `init!` it's never pinned.
> 
> I thought about #[shadow] as well, but it is not really accurate I think, as we
> might not shadow anything. #[maybe_rebind] sounds a bit like it conditionally
> rebinds, as in "it may not do anything", but it always binds.
> 
> So, I think it should one clear instruction, i.e. #[bind], #[access], #[ref],
> #[use], #[let], etc.

In that sense I think `#[let]` is best? Because it indicates this field
initialization works as a `let`-statement (in term of creating a new
binding), of course I don't have strong ojections against other options.

Regards,
Boqun

