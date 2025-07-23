Return-Path: <linux-kernel+bounces-743208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EBCB0FBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 22:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D43F87A4AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E82C23370F;
	Wed, 23 Jul 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV0XoaOe"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B72E36ED;
	Wed, 23 Jul 2025 20:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753304319; cv=none; b=jcT7UzCFkRTOCXzsMyt8KWHjuyqsIoup80fFfkgk0KSByWfcsx9/wLZ4AM631nGBa00E+p5u4nuyqJRvaG6rccsS2NioFd5L3I/vQRVJ8ds2TX5p5HgxFVEuOX1O0/7OncM/FJYWJ11XEcuuhQ5hHtTs+azIQEbhtTYGUyLBMbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753304319; c=relaxed/simple;
	bh=YrwcwN8RmSHPCuHGxuvZCjQPYeiFUUH4tNyzIkJ7NQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhtE6IOvVLGMdSLp8VePRikafZRI6OwjHHeAWSvtzYO0gx2hxMGLwjOXFjE1ChOOnvcPiQpni2G4yPQArCC0FPEsZGqNh+j+vt+zdQPWhyCH6q6Wq+X5+FstTd5Xy1/x2g26TTGsKFi/RfbLTLnINtvG/hDYrXIq6Ie+s+pEFWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV0XoaOe; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e2c1dc6567so25881085a.1;
        Wed, 23 Jul 2025 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753304317; x=1753909117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxRAJAfM4BZyfv+lLP/dsJV18qgerwifEQ7A9m48XEE=;
        b=WV0XoaOeqlPKfLDln9mLse1nwLQ3moUOipXA6IE3ljnc9aBAShd7Ol6gf39GGY9CBT
         ipelidXV9gbM9EQIAThNTQWwnMwkahjefIxy49Z57Kg6dV9Akjw6FeXdnLWkk0h6d1/g
         XK1ALxQQp5zQM3BMO0+vkcXnuDYy+EcGB8R4n/D8e95NA15MEDuPyczXoGN2y2tuQ1DD
         K9QRpOyWpQKKCa0b30+/LANJupDYJPxXwlD611o6RspnWQm9qQSxLN4OLmiEAGgMALLR
         c8Vy/1WFGD+8VSwsUtWUVmiYYzP4ULFHQQzwLMA1WehRqejz+5MI9sAgg5/WRhdOCzeB
         KmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753304317; x=1753909117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxRAJAfM4BZyfv+lLP/dsJV18qgerwifEQ7A9m48XEE=;
        b=FLRikpO7jJdXd5Xxt7x05LxkcLjb2kfwGKAqGNI/RbBRaOFRl6i+UJbd73q7IrzSps
         QHYYtVT/9ni7Vrwb4H4UzDAlGyhXhqpTEaN3M0M5HZsBuQe44EBKpaTy13hk6JKB3Tdm
         KMs+CO89yfrA5x6CEtajhakSfesgIC/l7pl0TEoI04cPTISD8OKzmVGC69uzIxU1iaz/
         ty6SiyeretzX2tXIzc1Zh1ephFC6zVa3302w7ur6TEUTYct7tuksf8mzgaGIZCCEzHt3
         wu6775LnbKcmkqNgE9wrF3E4NHKpGUXWDE321bbOtb9l2N9/DTseAhX+jPzfsQ/HKZLZ
         w4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV+rhLaWCXVVGHqFwENQVyN+0Nu7PNoTWD2RwT0Hb1tIpfzcMI2l6i3izfAZ0fUr6n0EjefBWWpzRUhVGi5A44=@vger.kernel.org, AJvYcCXgqFWVxkCIK4LOBvlvo1cmQjFIw0NPl93zgu45TTaU5cJTWP5XQYLF+UjW8hiKGcEMVx2zwBlY1l1d/Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCwLAfuk10Q0sWPVa7NYhvF383yud9hm896r49hjRijPnXp8Jx
	hHk5uB3dPZcOWObRoO7CdQupHUgJj+PiZbPCMQx9IOdZzNfIH3F/Oe+j
X-Gm-Gg: ASbGnctjOhrDy7wpRlsD0NqR930MXbctmYRMNsqOAnnhEkxlKptxTGW4hlPDkj+ausA
	C8wptkVYf9CacpOofb77NOWTg0u9w+z0fB6pMD4Gx5Rv01f2fQMCkN98aqUonHylbf5GZbWR59t
	DhmDpGab5IzC+vlBONB0ByBG0drcE6CXQ0yoizRMWDZReCyoA7ih0F7D6sBh7Wt0Snqov12BfsP
	VhzuTexh63+KLlTc3UN9VTetHJ0qaKnKUrQishXQc9KY7qFE/whkEdpEz0RF7y1IXoypin+7A2T
	2z6EISZlGBDb39G71KzD2UglMN0HUR/gWf8fJAJi6cNnKDLKO/kg/FHcU44SynDPN5nxtKagxxq
	NXuFL7oMNytHjSJHRpalMMzUESXd7NECXiCMEZaU4W0nLDy7koaxsmn7FqsY/Gxi15ZZgvKQpC/
	XrhUjL62rbeizIRrYwDMr2bSpx5aUUk7gvFQ==
X-Google-Smtp-Source: AGHT+IECZ+kVV+YERMudG6qv7a58jaPpSOK1P4Bas7MQ11QvKqQof/hYNJTJI0ouAQ+G9oScqS0l9g==
X-Received: by 2002:a05:620a:2eb:b0:7e3:3f89:c027 with SMTP id af79cd13be357-7e62a15a35cmr606846685a.36.1753304316967;
        Wed, 23 Jul 2025 13:58:36 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e623c9adb9sm229322285a.75.2025.07.23.13.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:58:36 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 16134F40068;
	Wed, 23 Jul 2025 16:58:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 23 Jul 2025 16:58:36 -0400
X-ME-Sender: <xms:-0yBaKQNa-KyoHVd1vCd-lg7e7cTGqLyXYelp27F4ruN6X-nZKvRUg>
    <xme:-0yBaIZqVFgQ17TQQWekaFXKpitUcOV32nIAXjUen8EIb9E5dKu_oPnHLqLZKWfFS
    EpJzkJD8esvPnEF-w>
X-ME-Received: <xmr:-0yBaPSREtIJg7so1aR0ZmNSfrZkFU11iZeUIgESZk4fq8VFsF6NYa6TNXs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrh
    ihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhh
    ihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuh
    hmihgthhdrvgguuhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_EyBaP93xBWxfu7ADh5u5EPLMOFDcpiPOkAZyGRSesaG1u3TdoXHFQ>
    <xmx:_EyBaHicu0bB7KkT5fW3i94MD0YTPxpTCZTFaq6vyXiVGED_1pbK3A>
    <xmx:_EyBaIaoZsNsezecY51XW62Vt4sjM_IHXwf2AQ1VkdnC3VMbhnvdxA>
    <xmx:_EyBaE9iVDB2xXnXlwKysDb1dw0C1kUbbYgLw_2hLwgF6vW5jzRV1g>
    <xmx:_EyBaCNsn81NMKlEiJgeko-2odNjwqtadS7XNPOUKqxZLznXBwUiCCFE>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 16:58:35 -0400 (EDT)
Date: Wed, 23 Jul 2025 13:58:34 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
Message-ID: <aIFM-qEnD4pzdtMs@tardis-2.local>
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>
 <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org>
 <CAH5fLgjWFa8TjTL+rfv7Zd+OQqhkKqWvyTkGf60pMUyQ=c4sXg@mail.gmail.com>
 <aIELxq_iVMfjszkh@tardis-2.local>
 <DBJOYRYFZJ5I.26IFPSP138T23@kernel.org>
 <aIFBEUdGU0r05wC6@tardis-2.local>
 <DBJQ52JWDGY0.37W393KWBWX6G@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBJQ52JWDGY0.37W393KWBWX6G@kernel.org>

On Wed, Jul 23, 2025 at 10:41:18PM +0200, Benno Lossin wrote:
[...]
> >> >> > is in a static segment it uses different behavior?
> >> >> >
> >> >> > Because from the safety requirements on this function, I could just do
> >> >> > this:
> >> >> >
> >> >> >     // SAFETY: we leak the box below, so the destructor never runs.
> >> >> >     let class = KBox::new(unsafe { LockClassKey::new_static() });
> >> >> >     let class = Pin::static_ref(KBox::leak(class));
> >> >> >     let lock = SpinLock::new(42, c_str!("test"), class);
> >> >
> >> > This will trigger a runtime error because `class` is not static, but
> >> > technically, it won't trigger UB, at least lockdep should be able to
> >> > handle this case.
> >> 
> >> Could you go into more details? What is the "technically it won't
> >> trigger UB" part about?
> >> 
> >
> > If a dynamic key is not registered, lockdep will simply just skip the
> > initialization of locks, report an error and disable itself entirely. So
> > it won't cause UB.
> 
> So the code above would trigger lockdep to disable itself?
> 

Yes.

> And how does it detect that the class isn't registered? By checking for
> the address in the hash list?

Right, in is_dynamice_key(), the hash list is scanned to see the key has
been registered.

> Otherwise it would be UB, right? Could there be a hash collision that
> induces UB?
> 

I don't think a hash collision will cause an UB, because the checking
only uses the address of the key, so even the key is uninitialized, it's
fine.

Regards,
Boqun

> ---
> Cheers,
> Benno

