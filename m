Return-Path: <linux-kernel+bounces-803491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7019B46082
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A697B7A7DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C736CDE5;
	Fri,  5 Sep 2025 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ7xzK8v"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDA352FC1;
	Fri,  5 Sep 2025 17:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094268; cv=none; b=QNG4ArVxjUeF4kCQ0p1OvlR1xho9N4qy826m7F1/VkedOSKG5BvA44ev6oZqFHjcoO2HTlCwWlhJtV4dMJTMezL4+ElfJrdIL/qI6Gf+/yjFeUQwpkc7A02O1L1CLCI6Jt2LLzYbquXwUZTakZMu7Yc5KicEsXAJZJC6CqeR/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094268; c=relaxed/simple;
	bh=LO4KiE6jpQ41am0D/szy6V46uqgfkA0SAqGzswi/1yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9wR4RDYGCS+vjoMnbYId+K6PwdtN+3cr644KJzzV7HxcFU3zbw6+8J6GNI35kylEJ3KWN6/rnTjsfoMBduvEeS2ovg1+5k9Wp/AXTLVhYnVZu3FC6wv3SZchyDJCj+pnvQ/XE5mYn3IohYrh7evuAGjwUUt1noRLK+YZMfNKRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ7xzK8v; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-726549f81bdso22591406d6.3;
        Fri, 05 Sep 2025 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757094266; x=1757699066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MMivriApdvV+J9nTlsMLl7BHebvMmERCWEMObfeZeI=;
        b=WJ7xzK8vKcDlS9KixzuZZcjua0hbZ+v9dwvqi5FI8Y886eklTzAXMepcGisA+oPUJ+
         9eVG1CtMfriLGH8Ch8tUu9qB+2AD+RPJTI/Hq/zuwWVMaNaRG4wuQA/RGJtR9pEIE7vQ
         GjPfn7KSfsy0lxClxNHRf5K1necxE4yG4RfWfYpsSXooKp9JaEIMGMAwa7a5O8gbMOcS
         IorzmivD6FFatd7V0FHviLZZjkj67AkzaO9/ssPEFtDpD53earuiSDZAN8nDdQ6vNtDs
         kSCW46MPnMUJ4diEpgl5dU/Wn9aT+bDqqISCweihrzXvaCWxL6AIRLY86Ho5dNcN3l2F
         9clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757094266; x=1757699066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MMivriApdvV+J9nTlsMLl7BHebvMmERCWEMObfeZeI=;
        b=BHoY9BgwY1X3fuXSdC+s+K0gndQJP5i+rVX9o6Dkuco50O5a6X47Pv/G+Xtjd0IRTC
         EPR1zANaUZZ/TCsQ/9MOXwfupzp5wjQmGqmJQ0wS4rHKSnk2b8aljiYeB0jfmSd+cL6O
         Y5BEDieb6HknbwdSKKv3Fa/3lZozsxnS3u1qyMqRN4Gw5VQHSLPY1jWYe9oNXr/j94pv
         3yrPT8T5knegpyLldLbPUGe9C4P4CRvGmERnnOlr0JTspAOCA9Dtkpu1xAOKrKs9XVit
         vdOUgWCMMmq8pNoJlEesEkinW7PHcaYRmJ8Hi0j3b1mp+8lM/KPixlBhavxVZyRQCXzp
         SedA==
X-Forwarded-Encrypted: i=1; AJvYcCVg/dLh2IDtvKlWUyCdRUPgc9zhQz7uZgoBkSb9vw2mDWb3VILuqhHHocTSfIfEnyS0rvccrt5EHVXgkuU+rOk=@vger.kernel.org, AJvYcCWK1InkV+BbqGwHT/gEuVWOzW+VgOY+vEc+JJlVzYsjTcpgjVxjDP17QxY7sVBZYDKYt9E2pAqjJlTnWoo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Jf4gW0yGmYJedvSXtZZNQt/eXS3PoOXQOtYy9Yp2kVwNvkwh
	Hm+XQbIxXQO7BSgtnMq9zF4AdM9IxBV+zlQiVmf3g3gg+1Ik0AzCudhc
X-Gm-Gg: ASbGncvVc7cOOVoEwYajuhoHiu5v9IpbZrxKntDX0XX2SrAdywWkJ3Vp/R72jwlJqRq
	z7q93JOEJYGcEXJbL+sS0aplYZ40uSGQ78O21YlnSnagvRoupqq7cDNRdjFccMjszpNCNrK8Jb9
	y+w4URCzsAGoN0iL6Mrh35nNPEDQtzt4MOsikY1rArXFRy2IjXFjK7kDiaRauuIMIrhCr6HWdU7
	ab1fkIPGBfNeB+l9v4S/s8SE32kwqBDND5pOWkOb1g6mB4RIb/lkpPGZAwxRHwTs3ws30eRSQNe
	FBypNLz0NZ+IphibsMhIssBuzKGxws2J20FchuOI7brtyBSHTj7VYmE+/r52M+gkMADw5Ijxj4/
	ONVXQub0ysMYNyinixoj18jJZACMtTVjlGOw4Jecr9jjG+JnIQbB/BWLOLybLspU5AMb5LhTXTo
	EiqgzVeqxgXSNaCqqs5UDSJHU=
X-Google-Smtp-Source: AGHT+IF1L+URg8U4WwEJK3U9L8xlVjJwUAqGmeZJKAKWvFMcsKy3K6HHiQnl0D0H2clT6ss5q74CfA==
X-Received: by 2002:a05:6214:2249:b0:71b:6414:fd06 with SMTP id 6a1803df08f44-71b6414fe25mr217741486d6.27.1757094266007;
        Fri, 05 Sep 2025 10:44:26 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72708307ba3sm42881716d6.42.2025.09.05.10.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:44:25 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id F15E7F40066;
	Fri,  5 Sep 2025 13:44:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 05 Sep 2025 13:44:24 -0400
X-ME-Sender: <xms:eCG7aOBpqh2-YuqnMGF62OmhNcTAi-hhGMVHrJN9z5lBuTspHyA1Ew>
    <xme:eCG7aDMt1LluMLCqGb2gGaSMOAHarcEOK5jWGr8YtLPDx7zNJJfDz7XuQYUSygxnB
    zXEQtFg_SGJKVchcw>
X-ME-Received: <xmr:eCG7aIPDtrFWHHG8_w3igFUYPAa8KhBonIqypWSzBdYfrfQXjFtheXeBAE6753DmvE8xaxN_fhyD6X5-XfEvMKvcj1wO_kJX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelhedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffeivden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhh
    ihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlh
    esghhoohhglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvggu
    uhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:eCG7aHuMZVLkncjrMRhp5xBwUc2Lr5BLrCZZ9Qq-ze3fa8URIKZYSw>
    <xmx:eCG7aN9xdseulAesFhyIIvBoeJCD7T3xfDQgY3k4TOAwtFkt2EPnFQ>
    <xmx:eCG7aDFtaxXoJTWbL17b0ULAdw3Qdzf9XpvY8Qnzu_qhkRtw3TNGUg>
    <xmx:eCG7aERDumWmO30M27ZBIX4T1B6Oebb2ADigBTeAhhpQhvDitq708g>
    <xmx:eCG7aJtyZKcll_gAzmiOX6PHyrcbgG19Ux0WljGObCguioMJNTbk_u1d>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 13:44:24 -0400 (EDT)
Date: Fri, 5 Sep 2025 10:44:23 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>,
	Alban Kurti <kurti@invicto.ai>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: pin-init: add references to previously initialized
 fields
Message-ID: <aLshd0_C-1rh3FAg@tardis-2.local>
References: <20250905140047.3325945-1-lossin@kernel.org>
 <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCL1DPN708H0.3JTL93J2GD2DR@kernel.org>

On Fri, Sep 05, 2025 at 07:18:25PM +0200, Benno Lossin wrote:
[...]
> index 606946ff4d7f..1ac0b06fa3b3 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -78,8 +78,8 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::IdInfo) -> Result<Pin<KBox<Self>
>  
>          let drvdata = KBox::pin_init(
>              try_pin_init!(Self {
> -                pdev: pdev.into(),
>                  bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, c_str!("rust_driver_pci")),
> +                pdev: pdev.into(),

Ok, this example is good enough for me to express the concern here: the
variable shadowing behavior seems not straightforward (maybe because in
normal Rust initalization expression, no binding is created for
previous variables, neither do we have a `let` here).

Would the future inplace initialization have the similar behavior? I
asked because a natural resolution is adding a special syntax like:

    let a = ..;

    try_pin_init!(Self {
        b: a,
	let a = a.into(); // create the new binding here.
	c: a, // <- use the previous initalized `a`.
    }

(Since I lost tracking of the discussion a bit, maybe there is a
previous discussion I've missed here?)

Regards,
Boqun

>                  index: *info,
>              }),
>              GFP_KERNEL,

