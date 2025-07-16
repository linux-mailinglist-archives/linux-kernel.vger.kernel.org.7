Return-Path: <linux-kernel+bounces-734047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E152B07C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7373BB02C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D96286D49;
	Wed, 16 Jul 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UatdogtQ"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6F286897;
	Wed, 16 Jul 2025 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752688348; cv=none; b=SqNyNUltrLmqw0J3cnTydxYIhoIrTNOqk8Uryzk5g1pvhg3YIDFSW72qmiYpiHlAX4R3jRvM+clZEdbDUWX9H+hg5OBsny5G1ajolYrsRp+d4UUpkIbfw1qLX2srLcMKnTKWMub3Ockc34w9NMwQb6KK0VG9msZ8oY3fDuUR6Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752688348; c=relaxed/simple;
	bh=R8orBIimh/Lv8kV3Kkad+b1RV8+sDl0p4jXuZ8qFDYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNVLkWne3gBJCEDHXOI1plV0+TeGiVXfLslReTlhVtw6yobs3CCwBf0hFFSAV7fDKaHWc/Mq8WcywGApuBcArV3HE9HLqIjB8jK0cwIGVb+46TU6ALu9oA9wKhiiWWzez54y7zOfnF6GS3Gjcm88TtqSpWy258Wb+kH2TNdnQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UatdogtQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6faf66905adso1664756d6.2;
        Wed, 16 Jul 2025 10:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752688345; x=1753293145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhZYBS1TYlYTN8bgdtKESmbKm8B642FoPKPSdfLXodE=;
        b=UatdogtQI25Z1z5VUsmXIE1BS441gaEI1OK1CYXGgdnLTlT1VicTjy+HgtLQh0BdkF
         ooGpFqX41UBCRk2K/G+Si1A77NyyV1PmG0J/RjulaiGJt/J+Qok9TThkqrf0Hf5VavZU
         YEwuhYl7AKY9ZH2igFXjQO/tsjkHwOPt1+I/dEuVzyy8Yen+EgGxNJ4A9Po7rSv7UOm0
         LuJhhmz2di4u14gr14Sz3H8KjFyRb1LCl4Uph4JuxZX/Y74j68VsYBd42cB3Dvya1kJt
         dm6iMgmdnfBAcc6X1G8sc4XfbuTY7dVRKJkOEC7z4Rb8v6BHOg5ds0/dejTK5d4Ywhfm
         5/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752688345; x=1753293145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhZYBS1TYlYTN8bgdtKESmbKm8B642FoPKPSdfLXodE=;
        b=mGBgYHheipYELwHzRFRhqoiuVadETSn1WWA/HXQ9DLgPlxVBrhErpDaQ/KoW61ndMq
         ky8zyR9wFDi+1yH4raZpqL8VJao+Q8b68rlDxPFgBpGXSSozjIUkMKRcRf6k/3ADey6q
         7UdZzX/KlM26VohzWmQQbjwtIL5D0OpQsJD8UfmkLVdrnnURtmHmtuWgLh72nd6h7Nm1
         zX/ZLPSH+Ec1fbbztCyKz7b7hgN12ri6EPbEZclXeC6+0g8xEILcuI9ypUaD+9xhx6Nt
         nOpkIIIu+7GH+baYphIfW2M4REBV9MMapBsfbFbip7yXeuRjtMI2gG5fdylBanjbGJCI
         iX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHS9kaO0TVQwg2I+YlTRh1YUXUdFOm4LwxfVsuL4TumesO2Qg+TCPUX7FCgonSivTU0mE5Da98F5Vm5zqwrhU=@vger.kernel.org, AJvYcCVp/hTh/ev6ye+ZaXugQoVUGRMYse/3N/Eb/R58HyJtz4T2gl1YE0t1COl8w28Gp7ekTUPSrPva4bc4RbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNluyuesXRydyycPP2XsoGR79IwOBGO3lynVJZz658ZeMel1nS
	3OwTrNwDUCjFQk25V7UW9iwmhHqAkiD7J3lKoy22GpPtR7CuSYjpK/5r
X-Gm-Gg: ASbGnctYCeS8c1rGOy+RKiMzmAGoIl/QjqDtypRQzauwryT7lVA7ZkD7ZAgeRnw3q09
	tfYYHu8YOrqx6JfcwmY7T4zhDA5dgvIWGIm7QiTF3tME0SErFv1iBGgrAGLKHgwn93SghhmNi8K
	OgbWgEslb7dJ0tLpxAu+ZoEiu6BVNi2H3QcsxJpwPduxVkPhWzKmJCHM3STYCe89FUxMA448qr6
	LbWmZJQguVGd/lYfzRBbPuBbkDEfn0AvDtk4606ZJHVOj+kbZ3w9eCfG1wHQplc/hzKdOLf4jSv
	uKtMoZsG51rEd58sBucYrt77aVPE76rUGI0kRkfhn6J0TpqqbqaxyGhrpKjtMAiHt6G1AIjsiKm
	/zKZ9M8AMgYw5/ayNeHiEhlrMdMvEdOKer7znXd8PrWKR6bFAKlO9sQUDswNskLjE9pZV1LOwo8
	sv/xIPkPkVgGsz
X-Google-Smtp-Source: AGHT+IHS5VRv6VkyUc17Gj+CedIfSsDAPemumVPyvM5IQ2aSLIbA2ACUNS1G1fJCAa9iWMY5tvez7g==
X-Received: by 2002:a05:6214:5bc6:b0:704:a6dc:525d with SMTP id 6a1803df08f44-704f6aa03d3mr49677336d6.25.1752688345220;
        Wed, 16 Jul 2025 10:52:25 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979f498esm73114646d6.53.2025.07.16.10.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:52:24 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 420BDF40066;
	Wed, 16 Jul 2025 13:52:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 16 Jul 2025 13:52:24 -0400
X-ME-Sender: <xms:2OZ3aMvBhqVWpfRoy3gNvJJZAahkdc_2LZ6CL3s5XKnmYryeMLf8Wg>
    <xme:2OZ3aK-BggDjKvfb1jllvvf1IpgTS5Do5ixQ6K49tKhMCrXjF0X-FHrdm43204j7c
    pU0nbHDdCzEYdiClQ>
X-ME-Received: <xmr:2OZ3aFZKDuqyQft6Yo_6ZEAMBuH31A4KqSJ1Rn4HLaVOseYsg733vrI93w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfegtdefveeljeeuueeltdevleehfeeludegteekhfehveeuleegkeelkedtjedt
    necuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgpdgsohhothhlihhnrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedukedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghvhihmihht
    tghhvghllhdtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorh
    hnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegrrdhhihhnuggs
    ohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:2OZ3aGqd5qYG74NR-eLj8vyto9zMOhlr6-tclfia6txxx4KqH2asMg>
    <xmx:2OZ3aNbdfugv2k1aAfZ-eFcTYANqbkOEPxnQRElZpWHJMFmIir_s2g>
    <xmx:2OZ3aJ7XOVmbdL77h46GLV1gx75BqGPec_dR1oE0DGhFPQcPeBdClw>
    <xmx:2OZ3aIRZGyH3g1Kg9MDJZT98KFNdmoj4-xQWeZuVLipnE6zQA44acQ>
    <xmx:2OZ3aJt0eERFgg8Hs2ezGp7C0NlK8XcO_FShe_OAB1xl-R5b5Y7ae4WV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 13:52:23 -0400 (EDT)
Date: Wed, 16 Jul 2025 10:52:22 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Mitchell Levy <levymitchell0@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/5] rust: percpu: add a rust per-CPU variable test
Message-ID: <aHfm1gcdRZbVnwE9@Mac.home>
References: <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org>
 <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org>
 <aHaCUFNUd_mErL7S@Mac.home>
 <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org>
 <aHbJUfcsjHA92OlE@tardis-2.local>
 <DBDESSQOH6MB.2I4GNLPBP5ORJ@kernel.org>
 <aHfGV3l4NCmYSRuv@Mac.home>
 <DBDNIAW09Z7W.EXO6C61HCNVP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBDNIAW09Z7W.EXO6C61HCNVP@kernel.org>

On Wed, Jul 16, 2025 at 07:21:32PM +0200, Benno Lossin wrote:
> On Wed Jul 16, 2025 at 5:33 PM CEST, Boqun Feng wrote:
> > On Wed, Jul 16, 2025 at 12:32:04PM +0200, Benno Lossin wrote:
> >> On Tue Jul 15, 2025 at 11:34 PM CEST, Boqun Feng wrote:
> >> > On Tue, Jul 15, 2025 at 07:44:01PM +0200, Benno Lossin wrote:
> >> > [...]
> >> >> >> >
> >> >> >> > First of all, `thread_local!` has to be implemented by some sys-specific
> >> >> >> > unsafe mechanism, right? For example on unix, I think it's using
> >> >> >> > pthread_key_t:
> >> >> >> >
> >> >> >> > 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_key_create.html
> >> >> >> >
> >> >> >> > what we are implementing (or wrapping) is the very basic unsafe
> >> >> >> > mechanism for percpu here. Surely we can explore the design for a safe
> >> >> >> > API, but the unsafe mechanism is probably necessary to look into at
> >> >> >> > first.
> >> >> >> 
> >> >> >> But this is intended to be used by drivers, right? If so, then we should
> >> >> >
> >> >> > Not necessarily only for drivers, we can also use it for implementing
> >> >> > other safe abstraction (e.g. hazard pointers, percpu counters etc)
> >> >> 
> >> >> That's fair, but then it should be `pub(crate)`.
> >> >> 
> >> >
> >> > Fine by me, but please see below.
> >> >
> >> >> >> do our usual due diligence and work out a safe abstraction. Only fall
> >> >> >> back to unsafe if it isn't possible.
> >> >> >> 
> >> >> >
> >> >> > All I'm saying is instead of figuring out a safe abstraction at first,
> >> >> > we should probably focus on identifying how to implement it and which
> >> >> > part is really unsafe and the safety requirement for that.
> >> >> 
> >> >> Yeah. But then we should do that before merging :)
> >> >> 
> >> >
> >> > Well, who's talknig about merging? ;-) I thought we just began reviewing
> >> > here ;-)
> >> 
> >> I understand [PATCH] emails as "I want to merge this" and [RFC PATCH] as
> >
> > But it doesn't mean "merge as it is", right? I don't think either I or
> > Mitchell implied that, I'm surprised that you had to mention that,
> 
> Yeah that is true, but it at least shows the intention :)
> 
> > also based on "I often mute those" below, making it "[PATCH]" seems to
> > be a practical way to get more attention if one wants to get some
> > reviews.
> 
> That is true, I do usually read the titles of RFC patches though and
> sometimes take a look eg your atomics series.
> 
> >> "I want to talk about merging this". It might be that I haven't seen the
> >> RFC patch series, because I often mute those.
> >> 
> >
> > Well, then you cannot blame people to move from "RFC PATCH" to "PATCH"
> > stage for more reviews, right? And you cannot make rules about what the
> > difference between [PATCH] and [RFC PATCH] if you ignore one of them ;-)
> 
> I'm not trying to blame anyone. I saw a lot of unsafe in the example and
> thought "we can do better" and since I haven't heard any sufficient
> arguments showing that it's impossible to improve, we should do some
> design work.
> 

I agree with you, and I like what you're proposing, but I think design
work can be done at "PATCH" stage, right? And sometimes, it's also OK to
do some design work even at some version like "v12" ;-)

Also I want to see more forward-progress actions about the design work
improvement. For example, we can examine every case that makes
unsafe_get_per_cpu!() unsafe, and see if we can improve that by typing
or something else. We always can "do better", but the important part is
how to get there ;-)

> >> >> >> I'm not familiar with percpu, but from the name I assumed that it's
> >> >> >> "just a variable for each cpu" so similar to `thread_local!`, but it's
> >> >> >> bound to the specific cpu instead of the thread.
> >> >> >> 
> >> >> >> That in my mind should be rather easy to support in Rust at least with
> >> >> >> the thread_local-style API. You just need to ensure that no reference
> >> >> >> can escape the cpu, so we can make it `!Send` & `!Sync` + rely on klint
> >> >> >
> >> >> > Not really, in kernel, we have plenty of use cases that we read the
> >> >> > other CPU's percpu variables. For example, each CPU keeps it's own
> >> >> > counter and we sum them other in another CPU.
> >> >> 
> >> >> But then you need some sort of synchronization?
> >> >> 
> >> >
> >> > Right, but the synchronization can exist either in the percpu operations
> >> > themselves or outside the percpu operations. Some cases, the data types
> >> > are small enough to fit in atomic data types, and operations are just
> >> > load/store/cmpxchg etc, then operations on the current cpu and remote
> >> > read will be naturally synchronized. Sometimes extra synchronization is
> >> > needed.
> >> 
> >> Sure, so we probably want direct atomics support. What about "extra
> >> synchronization"? Is that using locks or RCU or what else?
> >> 
> >
> > It's up to the users obviously, It could be some sort of locking or RCU,
> > it's case by case.
> 
> Makes sense, what do you need in the VMS driver?
> 

In VMBus driver, it's actually isolate, i.e. each CPU only access it's
own work_struct, so synchronization between CPUs is not needed.

Regards,
Boqun

> >> > Keyword find all these cases are `per_cpu_ptr()`:
> >> >
> >> > 	https://elixir.bootlin.com/linux/v6.15.6/A/ident/per_cpu_ptr
> >> 
> >> Could you explain to me how to find them? I can either click on one of
> >> the files with horrible C preprocessor macros or the auto-completion in
> >> the search bar. But that one only shows 3 suggestions `_hyp_sym`,
> >> `_nvhe_sym` and `_to_phys` which doesn't really mean much to me.
> >> 
> >
> > You need to find the usage of `per_cpu_ptr()`, which is a function that
> > gives you a pointer to a percpu variable on the other CPU, and then
> > that's usually the case where a "remote" read of percpu variable
> > happens.
> 
> Ahh gotcha, I thought you pointed me to some definitions of operations
> on percpu pointers.
> 
> ---
> Cheers,
> Benno

