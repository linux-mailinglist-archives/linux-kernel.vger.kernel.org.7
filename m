Return-Path: <linux-kernel+bounces-765152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0F8B22C39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219957B32C8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8972F8BD8;
	Tue, 12 Aug 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJlRx9R2"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1A2F8BCB;
	Tue, 12 Aug 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013914; cv=none; b=PN9pv3pFeT1wwBsq/0LiLHtTpX3ZzLWApFspcprC1peTKWruigVWe58CwG2144nhTsFEHGArBvhQLccwpm90wVIhUgTCjh/FOt8T1aP+FIjtxO00rAbpjhYVlp26Kp8sAp5ax8LwxPeSGeykFINQkuYpg1TiiGceMtg9o3qOahg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013914; c=relaxed/simple;
	bh=xMCwuIZXVqr3pYATgAGr2Th9xURbQEyIDdYRcSuW+Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwjcyNMxBFQT0VykIyc2rLetB1HmwTBF1nJkOx6pTFVlqbBGoMvqW9d5ubePfp6z3x9hyd5RQT9cEXPC2fKmW66Md74p/7vK4eDl/vske8PlVrutPxV77KgjoS0Rq9iCGvp26WshI9uGF/OVTVXHnbM9fgIOD8zIp6HSkw97Ovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJlRx9R2; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70767eef931so69539886d6.3;
        Tue, 12 Aug 2025 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755013912; x=1755618712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4ZuKp5BburffZpG4VhtILlaFyYFoR3RrvoPkGvrCS0=;
        b=GJlRx9R2/bP0gsTCXgpOEVQw92p/uFbe/NhgYM6O5/wnYYPeqh5nXGnqi7KaaL5KMR
         k6O+fKo9jb4BLoaIn651FyBR5tg9Ytds7aMk0YpSjtKoTDXefwnyyRklNlNroE3K11as
         pE+m3VyyDrJBfr+pCRFBcrG41T58aN0A67Z7ri+prM3Z2VL9PsvEJLj/zObQitd78tVV
         k+nplQ0I/VCQaJ9qhbYBefDc4+WMq547hxCxAAat/nk66cRM5sXxzJvfCbq2lcOq1NR6
         j8IF7xJlZ1slu9O80xAKhht/XPgk9bTpo6qI8uiD6jLot31O8+O4pApKNT29Kc87RiOW
         pbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755013912; x=1755618712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4ZuKp5BburffZpG4VhtILlaFyYFoR3RrvoPkGvrCS0=;
        b=CUqGvt8SWZJysfi12iwWJDMR82vulCImI1uvZj41RPZ8GTS6kh/l0nm6jaLN3sycY1
         xvPwFxZPp/fxHetzcUjCDc8awmQAPqFcnPjPVIwrziMt9h8fEWfT3Zo4DFNBJTpeuvse
         qvoOHrMNkzHcl8mu5Gls2NYHSdykHbhjIVLBUTDp2FKskPDQdYRUDix4mbpiA7Fnc8ZZ
         izGxm9BkfaaDf8wFJjnJg1RH38GGj11WFmRg7EpMZXgUYTw2UIsVc5CprudH90USasb7
         xtSeimfCsv2ASNkRI1e67uEyK/6TsWZ13dQb+zrs3R2UMuNZS+Luu4QOXXbLGaRO/4sN
         B4pg==
X-Forwarded-Encrypted: i=1; AJvYcCVeIX0jlv3GiuIyhGr30D00dlctxrK6NgngtCjQNB658KZexmj5mTjTTu7eIXi8NkLZm+auR6HmTbPRvwk=@vger.kernel.org, AJvYcCXmqafaMFK7d6h63IMQv+GuG2xYFuNzF/gPZew2gwioyg+gipMKtnVqEHgcDKpghLlZdsdfyCbWNAYv35ggnxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzawVgub7yXp84YMvG+/5ssu9trvfL1ion8RFMKy8EFm8BJF6qp
	Tek9XomavNwKWLnuWwnw84FXEXzHa0ErBIwHvX9AGkL5CxjYlkVSfnlq
X-Gm-Gg: ASbGnct20+iI0J8d8CCPvyStCnP8BDiM8DgdbrVNenXotOhPT62Np0oD7n5NJLupZPp
	ksGBUPl4mWbyZuhxg+YGFwKkRRwXbRvjphUhPugL+NsHeDwqdBqnYx7Gvr2NHl/6Q4XwPzvq/JJ
	N6rNCN0tXMUUYb0HgL0CsBYoNxHX/Cts9YiHbyhxWkGS70Pd4XsWIeKvcZlIZ5cd8r+FSCIeJb4
	EuVG12B58lXTgGsPVEa4WtT+eX+tWc6R+x1spS/1pKh7ciDw0CjAKsRicUzH+baGGz4GelWJLp+
	UBzIC3Y9HxKYKno5zPUxEUdgVLaU+k70fyHMJRsJ74lZ34CFZSty6Gk3NvsaVZy9KGoEUBmx+1w
	13CSw58wwui8aQphA4F9nsKeebeIbNokleRd8coyYYwTDUdjq/odoRTDukbrXsyjrLfQJ7kPm6L
	ad5D25B34h72z9nS5xjyMmzXSoiuZ8J7jx2Q==
X-Google-Smtp-Source: AGHT+IEVx3wh4zZowpo3HwoI+1tx7QAqw485tAw3eCOBWwKBSMBY1fBJnuAlB57+DrUTICVqklgj0A==
X-Received: by 2002:a05:6214:2aa8:b0:709:799e:5bf3 with SMTP id 6a1803df08f44-709e6b89b8bmr2897396d6.23.1755013911548;
        Tue, 12 Aug 2025 08:51:51 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm178464306d6.84.2025.08.12.08.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 08:51:51 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id C809BF40067;
	Tue, 12 Aug 2025 11:51:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 12 Aug 2025 11:51:50 -0400
X-ME-Sender: <xms:FmObaNmN3NjhKHnSq9yioHd9i-8ZcwdlcSjb1u3lWyN8LhRnwcYFxw>
    <xme:FmObaOXx77VRTPdfI1suAiorRdnCvxVZffm8uUXY2Q7MoMsST3doOcpSSjs-nsMHN
    ZZBDgRzejUwsy7m2Q>
X-ME-Received: <xmr:FmObaCuOmMoEYfjsrZnyIfSm94vOxciU9QG7GI7fLFt23kjQCNWyB3Plcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeekteeuvdeuhfdvvedvgfehfffhleefueehlefgleevfeekfedvffeukeejgeff
    ffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddujedqrhgtuddrqdhlihhnkhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvth
    dprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgdrhhhinh
    gusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrhhoshhssehumhhi
    tghhrdgvughupdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomh
X-ME-Proxy: <xmx:FmObaB447HX0DCG3BgZ8ZakFkDRYvFQvLw7xexs1MKQwd63bX7RM5g>
    <xmx:FmObaFRXEYIJWPu7MzwRrfaK1sCKfjQ1g8rAFZbZA3I_4NQGiErA5w>
    <xmx:FmObaEvIN8yKgRXH-C6twtO8tQjshOOEse7rSL7y7Qie99zInkhc3Q>
    <xmx:FmObaH9JRSaya9ZEg1VhED0N3h4znzcWTKVONqH41-KOH22aLoXXSA>
    <xmx:FmObaNxvhgcYHU7E9ctkm1ZWEqP2WbwAPhi795oKD-ZN6c6JCYDOj8KX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 11:51:50 -0400 (EDT)
Date: Tue, 12 Aug 2025 08:51:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Clean up Rust LockClassKey
Message-ID: <aJtjFRn0QKUJT-fX@Mac.home>
References: <20250811-lock-class-key-cleanup-v3-0-b12967ee1ca2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-lock-class-key-cleanup-v3-0-b12967ee1ca2@google.com>

On Mon, Aug 11, 2025 at 12:14:40PM +0000, Alice Ryhl wrote:
> This series applies the suggestion from Benno [1] and various other
> improvements I found when looking over the LockClassKey implementation.
> 
> Based on rust-next.
> 
> [1]: https://lore.kernel.org/all/DBIJLR7XNI6U.21PMPODHE83DZ@kernel.org/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Queued in rust-locking:

    git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git rust-locking

For further testing and reviewing. Thanks!

Regards,
Boqun

> ---
> Changes in v3:
> - Fix duplicated "require" in commit message.
> - Mention pinning in macro safety comment.
> - Rebase on v6.17-rc1.
> - Link to v2: https://lore.kernel.org/r/20250728-lock-class-key-cleanup-v2-0-ad02b80c69e1@google.com
> 
> Changes in v2:
> - Change safety comment to require a static object. Adjust commit
>   message accordingly.
> - Add Reviewed-by.
> - Link to v1: https://lore.kernel.org/r/20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com
> 
> ---
> Alice Ryhl (2):
>       rust: sync: refactor static_lock_class!() macro
>       rust: sync: clean up LockClassKey and its docs
> 
>  rust/kernel/sync.rs | 78 +++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 58 insertions(+), 20 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250723-lock-class-key-cleanup-a3baf53b123a
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

