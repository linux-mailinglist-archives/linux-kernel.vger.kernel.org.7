Return-Path: <linux-kernel+bounces-817932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21FCB588F2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FC648778A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AA41CD2C;
	Tue, 16 Sep 2025 00:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ5j6TAy"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21301F95C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757981595; cv=none; b=cHs7YuOpA9Z6pV+Y8gdVLz+V42O6h6JDcQ7Fta8v3BoSVkreT9P0l50Kl67BcejWeMB8QovAEkOL7YUJ4sl20tzpJo/jHYuXSWGs06541/ZOdGnvgCZDq4Y/Tyy/UnnU4u8Qcsc6iFAFQvWaZD1Q/G2k3kRIt31pamfrVabFxRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757981595; c=relaxed/simple;
	bh=zibqQZwr3QxoYQRF0TRmInD5aMK8ZHuiAa9z79hkNqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCKBcwGydl7YUUsp3qUBN1r5O9xs9CoXxvzK42bag2RzkS1hjZFbofl0erXA1UuRQCnyuvdINBJPP0ME6BoSVFJDS0wTS7gi9ux6ilWQ/0YVPeSRVBfoHiWvK1wRpn1bF1BRbgezzqHtctlJDHBgOvepWjJ5X21YiZnuoLQwy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ5j6TAy; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b61161c35cso53256391cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757981593; x=1758586393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSYsYYKKYH9Hg+eGr/P9u+apnCaWPbzhHHRAnteKM/M=;
        b=fZ5j6TAyt7G4zylkDkQZrG6gYX/5StSHa3eYlCPApnMKcpA9V1qt/FBfmniD2UglyJ
         DsH9LtZRgoMNweRLKggL+rR2h26sfDk2Cf0zdCh73n9WXwuBuLKdWmetQIhHJbzly0uw
         JU+l60uUP1Avp6OiAbfXKxZw+DGI+OVxxbz3dEEcpZpLAW1PLQvF3KxSzUQBOYqK14Xl
         qpKjoMHthAoyKSc6GzLZzKfNA+AkLVVVY2dJjpUmLxslWkvIrfvaGII3rwziizPHgr0F
         sv18sB6KICzOvtXPHguvgxXDYNdjd3RYtjBYadB89Jlx6YCkMI5nUOs8O4wpC7PePu9K
         Ezsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757981593; x=1758586393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSYsYYKKYH9Hg+eGr/P9u+apnCaWPbzhHHRAnteKM/M=;
        b=m6LRk5GCNfInLZy//P52GUXBBIzbZjmfw0L+61Ff+PKb1uA1mV/6jELYZfra2re6rN
         F3AVcgcmi3SMH1DjraFbe1CExRjZkUb9TPib1I9T6b+ttG1P1XNx/T+tOvxwhPit4r7I
         Bh2PtVq4TGamoPfRV3/rquuQOlA6Cu9OAYmD0RBYLpdSUdd59XSWChe9+/c3UDfgUgvF
         WpP4s73V3XUTGkm5faQfz/p7adl6N+DpyOHvUnypTiwGGn5KhOECifXPSqOSunOvzWSF
         pUcsFEr1d8lFUHiMZUbQSEHQRklOWbeMZbb8IzIT9kEkiESSG/+2JRFyQIndJ6IWZZzo
         dQlA==
X-Forwarded-Encrypted: i=1; AJvYcCWM7OxdQaGTtzQhPF8Ela54Todew7Kq8x7LIspPp8ytnhjXYmfk7pbViQtPRvkfM/76PuycFJ9bJyzAOwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZuQk7zsXpHIXFsgxL15nAmR1OpLfsIODlB3g5tFYDb38nShZy
	OxmIuy2EO+ljLQyh6g1WSiQfIhDqBfP4ckbKovES6o9ificaV8f5u/3E
X-Gm-Gg: ASbGncsu128VBnwxgt1DmlwDMXTT3eu2cxJRUzU2iJwEEmUvSlt5XbdhEUYqLQOqnbK
	Sz/wAlybq+CBZyFt7wl11RiSiT12M/syPeb7zB9N7kjveCJQVwSCNSXmLtmqEE7wPXQnKXKkUd3
	9DY2YcdQobPzlzB696ImBmYCB5G9xmyF38nupqSHK9qSqsEGw5tXwOe8lmlK1Qnn8YtD6Y2yke8
	785MzTfsAflLVT3+OTP3Tqg9TCbCwi5BODDYCcrw8C1eQxHCiYCXNnk40kypORnhG3OHiB3jskL
	sSxFRiUryUwB1ZK7RzyN2z90iBCukz/DVfayHA4A52IkbaqZoDwVmx1VB4JJ0GEpW1GspUVdYmb
	QPz/77C6ZTR4brybrA7bA81tOVeU67CTtSpZxd9VVQOZfNMMc6tpgTK7xHBRtmMQxza84NaI8nd
	JtyutT9Ql3u7LUSTk7j51gVoYaEBUhxCq6IQ==
X-Google-Smtp-Source: AGHT+IH1If5tReFM+HcO+eSAEzoMaBd512hWMkh3DGEw+t26FV4IqgXegxg+fJcc7U3Bg9kjLo4PrQ==
X-Received: by 2002:a05:622a:494:b0:4b5:e524:4e6f with SMTP id d75a77b69052e-4b77d0aa6d7mr149555031cf.80.1757981592800;
        Mon, 15 Sep 2025 17:13:12 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639b98927sm73574821cf.1.2025.09.15.17.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 17:13:12 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 11977F40066;
	Mon, 15 Sep 2025 20:13:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 15 Sep 2025 20:13:12 -0400
X-ME-Sender: <xms:l6vIaDLPl1qcHt50T4nUfNFM1KP49zC-8AcDxYVpahzDXHacJIfsvw>
    <xme:l6vIaBxUYtYYp4Mn-JVmVd3N8lt59bLdyaN8OspcxuBgpz2kty2P9sre8btAQisXa
    LBI17njMmpDiN--PQ>
X-ME-Received: <xmr:l6vIaBuu4IKm2E6mqm7adk_m_Cw22MT50fN3zrJSXpJzgBXd9DcDsPPpY6l6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeffgeeijedvtdfgkeekhfejgeejveeuudfgheeftdekffejtdelieeuhfdvfeeg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    ledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphhtthho
    pehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvlhhlvgesfigvrghthhgvrhgvugdqshhtvggvlhdruggvvhdprh
    gtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:l6vIaMBfAUqCmTl922DpXe_aHKX8j0G42WzDlOpSpwrhMtBrNTssmA>
    <xmx:l6vIaLEraPuUtBKkyvyDUfq6FcWNsqyV7u_NaxIvyd7jjs5dk7xJjg>
    <xmx:l6vIaEDZbdsXwMq3cfS7in5mu2T3SZUdhGdIcx6DMQjBdAMyyUqEVg>
    <xmx:l6vIaJkBahbjeIfz7xMf82wvo5Qka1ZVkPMzfCKequDqZGjO3fj6SA>
    <xmx:mKvIaCP8u0u9U0ovTCH1HXBK5yAypQpnmfxFk_35LVVnCWuIgUUvQt-h>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 20:13:11 -0400 (EDT)
Date: Mon, 15 Sep 2025 20:13:10 -0400
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: Re: [tip:locking/core 1/13] error[E0425]: cannot find function
 `atomic_add` in crate `bindings`
Message-ID: <aMirlpnVNLqvwdCu@tardis-2.local>
References: <202509131610.IPwv7fy3-lkp@intel.com>
 <aMWMVQiZxE_mv7va@tardis.local>
 <20250915073345.GR3419281@noisy.programming.kicks-ass.net>
 <20250915074133.GF1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915074133.GF1386988@noisy.programming.kicks-ass.net>

On Mon, Sep 15, 2025 at 09:41:33AM +0200, Peter Zijlstra wrote:
> On Mon, Sep 15, 2025 at 09:33:45AM +0200, Peter Zijlstra wrote:
> > On Sat, Sep 13, 2025 at 08:23:01AM -0700, Boqun Feng wrote:
> > > Hi Peter,
> > > 
> > > On Sat, Sep 13, 2025 at 04:00:27PM +0200, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> > > > head:   502ae97746ab6d7b7b48d54b6a85a11815f390d0
> > > > commit: eb57133305f61b612252382d0c1478bba7f57b67 [1/13] rust: sync: Add basic atomic operation mapping framework
> > > 
> > > I think we are missing this patch:
> > > 
> > > 	https://lore.kernel.org/rust-for-linux/20250905044141.77868-2-boqun.feng@gmail.com/
> > > 
> > > in locking/core. It should be applied before all atomic patches.
> > 
> > Ah, let me go fix things.
> 
> I've no idea how that first patch went walk-about. But hopefully I got
> it right now..

Yeah, tip/locking/core has the right version now, thank you! Of course,
tip/master needs an update ;-)

Regards,
Boqun

