Return-Path: <linux-kernel+bounces-808746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E567B5043B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CF81699A4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D9032A815;
	Tue,  9 Sep 2025 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvyz2t74"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC131D39E;
	Tue,  9 Sep 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438160; cv=none; b=jIo585LB3z5VD1EOOmI/ATrrq+RT+Q4EAC95YQEbDdjlHde+QQ5ZDYdR8mY/fdbl5S/y+ODX3VQ9pDF/aM7rbHgi1RzE9Oyi20yx2i31KbXbOHQwwkgfcyc3hV1GGrsnUrxfQFlMvAZPSaWUSlCX8QHirdrbA8wa/YvvJhDi41w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438160; c=relaxed/simple;
	bh=3RruH5vCDgagV0pTI+Gpq5gWb2LSA/MnDLOwFQmvEFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7hLaVCK3RCNS0V434N923SzKZ/Ah+yqtWoRqp/5OakST/OWIOZjIcwUfUU1HuQGWAJr5oC+lF8kz+YYPNDoivkyiOpwRuErDfg2nWoy6oL6MERK25Jy0yoD+XSCXo75Pps4hEPKjSGNu1r3EQyOJYzDNIdDrROaxe7/9C7G0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zvyz2t74; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-729c10746edso45895196d6.3;
        Tue, 09 Sep 2025 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757438158; x=1758042958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSSyGGgi+oNVYZBHOcjUiXzmb5znP4cfptExhbWJ4cM=;
        b=Zvyz2t749IM0dSPHEpBbupWoqXB6FAUdyD8RE3Ooqi2oZjq/eawLt8iJ3M9gOMNhtg
         mnan9Rx7CdrcYjl0YbzXalLpo2kEOb1li9spYzmPtBvhkM/FIg5rz0PdksPoelxQAShy
         O6+PRpfiTxEpR0QNAi3gociVcCJwY68FGv01rK3nIZfS+cqp56daj5Ej6C7g30OMHREC
         +PO6B7mWFFhFuyqulmwyBTQQ3NTxZzFCB8xKlDxBZjqO5Lee/rNnFjlI9SdDv5O81Vn2
         871Vy79HH99mGJ9Zh8KBZCSMhhDAk/O1dlzp78P85tSH2doMkJ074uKpJy8q9Qd/Vtrb
         v8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757438158; x=1758042958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSSyGGgi+oNVYZBHOcjUiXzmb5znP4cfptExhbWJ4cM=;
        b=b89avBPN8ibwVfEv/P3aYPho3J8nlp5CqAii1xbvWea+8SiqRCIF6EtPz7X6Uf2sg8
         2fq0tDLEufHDwSTSw3YEVDhi/ssQNFTIfrxPP6XYHmc8m1ykMxqGjdgyOCkM6ZFCMt/q
         uIAJQ1yLxVTMNY4m7LwT4BJ+ZIN+BKOPtN8ELs5LrVXLO7iJw637fO3d/XpMYms31vHz
         UQCpY1kA00TeZf4DD+dxS1tKQDhpQ4UDTDvq5ERQUWtGCC0TNkCC2J0PqXzaMQXEBJu0
         CGRHhLwXhuCLdBe2C0uTP2TCMQYkunHK4X9FZAlRf2TuWWCtYxSrrfU6YqYim0T9Va55
         4/KA==
X-Forwarded-Encrypted: i=1; AJvYcCUnkDOa6Du5zcXfOkwuJu0nbgKnYtmgT3pkulCoUxTS9FEim1V/4yyYHftqjl+6rswpsog6HEJcPzJjJ+1M+bY=@vger.kernel.org, AJvYcCVZbSewZKfY37mh8OB9d0gLXwEnNlrhqcbqj8bVro51ScD+6pBO5l6d20R927zBt5atuVLbOuu/2ChS0Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQ320GfOnb+mZMYAEQHF6amL3Wi3TFwKNJM3wYXIoxuKlt/x6
	BDhqCJ/rfEjJDHbIvG6R0iSDUHpcp8p5McQJe7B++ojvfQvVt11D0ltF
X-Gm-Gg: ASbGncuY/oGibNzxhxMlQ11ETC2/XOK4VwjOE8KOc8FKL3vUoyUlGA+EJbfYSNZJjDi
	l2Z9hT0k4T0IE3el0AKfZ9fYpZl8N6mmo7ZM2PEiotjiOZ01VS8N+x4dRiw7SfPkCrcvaa++miC
	aAlMLbTzD9EFtR+8SsCsWwzTbLoWZANfCQfJ9G5QV7PzHSEMPu/yXK/dgP89srm2uf5YR6imGr0
	wGOKJdBF3KEtgXwjlB5JVaPPCNuJd/FoUhpOI/69dqhA4wdL9wBdqMEme8NEIk+ydpmpZoY3mfm
	5kGd7bEbNiE5qhNd6WQcqGQaSkmWqqXlBFlxi2DThH9nr9FbQ0nyTbVsvOPpHHyLKYoiI3XoNDd
	1z9SHy1YaKWrXw+W5KBkAcOIGwWUdUVLAW2b3wvKZfC1M8ty5vVHcHCzEym9eOgdBfCCnmgV4ey
	m4/2rU0omvRqouwFqxR9FM9ao=
X-Google-Smtp-Source: AGHT+IEgFGPM0HtH+msI3bOaLONhcmJcBxqczdSFoTUSoiN8ZmAVNsMoR3gJMFQ/E4OHz/GHwuH9mg==
X-Received: by 2002:ad4:4ee5:0:b0:72d:5cd7:2f81 with SMTP id 6a1803df08f44-739371a7a1fmr126089636d6.41.1757438157722;
        Tue, 09 Sep 2025 10:15:57 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de47sm143522696d6.15.2025.09.09.10.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:15:57 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD1CAF40067;
	Tue,  9 Sep 2025 13:15:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 09 Sep 2025 13:15:56 -0400
X-ME-Sender: <xms:zGDAaGcDJxUw_L7jGPTNjlVpSqOydL9iv4-s3484b63kWH-0hK_3rw>
    <xme:zGDAaIEHSp53K9RH2rapVWfYw46zS_KyV6mfTa9BfG_INrFQYSEk4iysF_Y8K_xad
    JkLEaiIYV5wQ0ZICw>
X-ME-Received: <xmr:zGDAaG534mSPq2wuPuct8R85eoEdMp-xOOgCHmxO4_dVuCG8g-rvu59jOXsDUtLWwnnxKlg5udvMVtccpxAqRnjd7BhyLYgy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhighhuvg
    hlrdhojhgvuggrrdhsrghnughonhhishesghhmrghilhdrtghomhdprhgtphhtthhopegu
    rghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhope
    hlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtg
    homhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegs
    jhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopehlohhssh
    hinheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zGDAaLs1c_3gSvySlF8Xg4SLOsgZkScjSVQmOJsZybf_oyZ4tmb4bQ>
    <xmx:zGDAaK8gPv6XA7-P8bvHaVyP8E7AkQi0TqhF5kgkJalk5nOR0zY_Tg>
    <xmx:zGDAaFlAIWtQnOhb3-x5isd49yvF_g1yh0RzWlDlgvMlMZdM1Kn1NA>
    <xmx:zGDAaKOnas4CsJMUe_2iacC5FHgjomzyO4RZMnuMw_iyai9oRplNBA>
    <xmx:zGDAaEIQSWqOY9Uq9nrUddHl0L9qsCKKpkGk_RrllfyS68O1Rr6TIApn>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 13:15:56 -0400 (EDT)
Date: Tue, 9 Sep 2025 10:15:55 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust: regulator: add devm_enable and
 devm_enable_optional
Message-ID: <aMBgyxREYOM1GZFI@tardis-2.local>
References: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
 <20250908-regulator-remove-dynamic-v2-2-e575ae2cde6a@collabora.com>
 <aL_PwXck1HsLp5wH@tardis-2.local>
 <AA8FC1A7-EE88-44FA-A0A9-A3EA5529B10D@collabora.com>
 <aMBJ805QjQcPdRol@tardis-2.local>
 <CANiq72m18qUTjqjKKYgPfeEUh=vN+Jzz=ACFDcgA-JDLL_N5SA@mail.gmail.com>
 <aMBVgrVqX2w31GhV@tardis-2.local>
 <3bed2164-8f68-42ed-9ab9-6fda05687535@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bed2164-8f68-42ed-9ab9-6fda05687535@sirena.org.uk>

On Tue, Sep 09, 2025 at 06:11:24PM +0100, Mark Brown wrote:
> On Tue, Sep 09, 2025 at 09:27:46AM -0700, Boqun Feng wrote:
> > On Tue, Sep 09, 2025 at 05:58:34PM +0200, Miguel Ojeda wrote:
> 
> > > It depends on what the C API does -- if the C API is supposed to
> > > "always work" (even if it is no-op or if it returns errors) even when
> > > disabled (so that callers are easier), then we likely need to
> > > replicate that on our side.
> 
> > While I don't disagree with the rule in general, but I do want to say
> > the cost is the binary size (at least without inlining helpers), so I
> > think we are allowed to apply this rule case by case, i.e. even if a C
> > API is supposed to "always work" but Rust can avoid exposing the API at
> > some configurations.
> 
> The C stubs are all inlined so should have zero impact on the resulting
> binary (as are all equivalent stubs generally).

Yeah, but for a rust_helper, right now a function and an exported symbol
will be generated so that Rust can do FFI. That's the size impact I'm
talking about. And for regulator, we only have helpers if
CONFIG_REGULATOR=n.

Regards,
Boqun

