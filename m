Return-Path: <linux-kernel+bounces-887226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0C9C379C3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37C834E8CD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C68126C02;
	Wed,  5 Nov 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ed0sAcZa"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6E72FB97F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372912; cv=none; b=fGkZyuaFOuX1A6fx4d07tHvIApZ9AvPmtwl21d4yGvXROIHojJ97wuZZNMdBFd909aUOlaCAv372giqGr6I6AFisMRLHTYQoG+7FWMLLKpbkKPLx079hukxrb8OEaBx1ZOJrExhO1ON96KYAXj4lFP6q5BE7tLAt2+/KmWm4yMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372912; c=relaxed/simple;
	bh=7eexqkAR3aTk5kcNM9FozDvWuf2bX42Tll3Mr6lavRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb09rGeMdI0knG21Ekud06PaE5yscO6yWxxnr4slgTnzZLdNcZbYwlmudceQm6JlUSxt+Ad1ZNfBz+iCKZBWhMFLXbkI34In4dtssmol+32xvaFdeoaikyNDN5oAkG401OVzp11ov+GpgARKujdvVrrq2/UvnHdVHyl7wFkS0Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ed0sAcZa; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-78f30dac856so2871286d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372910; x=1762977710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xg7BvAvTvVVY99yfjG2FmHNYxW6OAUeHF0c7b0G9U9Q=;
        b=Ed0sAcZaVg6f/uEsrY9BymkG+RFJFkv7EXdoUlSh++orMmfgBCkivcLMoYpKYmWXgy
         QXinii7H0c1w95tpBfTJrHq3ZkgICmbw0VqtByyjVJ0CIALegTDJFwU1FY/ekbqwnw2V
         C1iXpTCQ8uCx16bqX6rUP3NqlswYDyYB1hqZ8JUnuj2GfFNlGRiVgYsTDYvdEda050lV
         PziXj22CrZ0m1QoCbDfa+fpFOUdBmJhjeqMAZoaWiSco8FSuiRonjjAhIdH9eSQc/Zxe
         Bl97nSlwkDbEwZgOMhdj1abDbbhG5uYVTRvKGuA8yMOPjqb+6flXxdYx85ROSjBtu++4
         94VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372910; x=1762977710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg7BvAvTvVVY99yfjG2FmHNYxW6OAUeHF0c7b0G9U9Q=;
        b=SICrDHykqmr8fFZSiRsFF8WbLn8TEbX1D178qfvFPHY7Wqa3Po8FNxhjgOFo7L3zQ4
         je0s8wIpWD/Q6QtycLkWlui6Sefgc0E5yTchIRUEDbkRD3HtT0V4ZEnClsosLmfjE+I1
         onb2thnGCQzUHGzc0RqtVhmKhW4QLDianOtQllhnrVP6EKrDj84zl8LjUARyEpSIkz9f
         zs9u07ZHlvOMKK2RH+SjEh4mvQ8OvY3KdIH3z82iczakW7H/4dDDXz6/a5JdLBQXmm3X
         NGiQ/pO6O+7KfrfJYZY3M/pvHFgLPiOKZe3wRGXZtHq0uVeHkJGjjm/w6thhLUALqd5l
         tT2g==
X-Forwarded-Encrypted: i=1; AJvYcCUlzqb6cVdX6KEJ3xGhTI5ZDyOrenmbugYrTC/cwnT54KY3DJeIauLViuKclreqi5iPqVkszXUxjxYlItw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBIyX0DadNlKM8wyz8KVbfETPiQEg2VIPZDarDhoXWLTGJO8JY
	E30QP623vkqK/UNdgVU7mbyYjBTTuWTgt0z4ZF9OfT/SohdNzG0pWBZY
X-Gm-Gg: ASbGncsbix0H0mPLLCvC0bIGOOw2SQrNpD9bd51IDeuYINMF1s74bfTZV2jaCuqv0bb
	LDPnI6UH9vMmmdZG/CJUBXYH/ATehpgRsMTU7iNCiUeudJ7wxdj06ODur+bQRNNh0gLldo+AR3l
	iCaS01As6DpuFX0Aq18WpeINkAOrjzfbiHIKwvWNWQPK8e1QhcFn/1jAyY0QrZDR6UZqHdCssm0
	ejV/c0XIM2m1OKDYpCVWb5IJHbaCrYtJk0t87N5HuM/ZisMxQxbmAilaEdwkJ1XHwiC265b69de
	FPljWaSu3UZdVS4iXJSGh0iHogvM+KMAp8nqRZzJGDO3pnSwa2D0nGrk4Sylt+eKEBjFeDc3rAd
	5d5dbutiYGt5A4zV9UsvHWPUexwkw5T7mQ1j2te60d7WdMsYYLPO9pqKB2LoR3tgZuaXjq/V+KB
	ELTRrJCq9cMnUlwbuMhImLCSEhG1zTPjS1PmxpsI6uBL/3He9l/er5SQGEIJjlzLxhhXEnucBzn
	2lMcQtwQEpeDCg=
X-Google-Smtp-Source: AGHT+IFSoM3lWfHi4jlIEW8WgXyrC0aA9EtAy/JvzGSk/v4RxXZ+0lsltA0H7C1qgeneNoZD0FnnuA==
X-Received: by 2002:ad4:5dcf:0:b0:880:4ed1:ce5f with SMTP id 6a1803df08f44-8807120b843mr60063076d6.51.1762372909868;
        Wed, 05 Nov 2025 12:01:49 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880829f4dd5sm3478246d6.45.2025.11.05.12.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:01:48 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 32DE1F40078;
	Wed,  5 Nov 2025 15:01:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 05 Nov 2025 15:01:47 -0500
X-ME-Sender: <xms:K60Laajk_IHxR8oDDZbPPh-Ix6uw7DmOiQhZWMy9E91KVA3VqNs9sg>
    <xme:K60LaW8KQVLotCd3IRCxKb5RVV68ilfwna43BeY7eG06bsl9H2qEk0dhG8YEAar53
    rQ5iugyDvH32qrVpCSiw30Qia6UhO1MuHZLClZOvPJxOM8YxXWgTw>
X-ME-Received: <xmr:K60LaYPHRhgG3NhQrp5hSMswJQlny_h7MDj73xOVIhu6DRKT-66rX2psgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueevieduffei
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfoh
    hrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvg
    hgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgr
    vghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpg
    hghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:K60LaZp9zJYqsBrK2Aq9gcuOoKG0SAaC0FRXhDhJz_CBb8ZVnSnX-Q>
    <xmx:K60LaV6JoVADaMy5aaW3WhBg-lA-pBjPNlT2IJBwi7Q-q9RYklCJkw>
    <xmx:K60LabqMAjqCtnSBVwMxSI7w_OtBDWe2T93bQjeaxvVsLzhipvqlmw>
    <xmx:K60LabImnE-Q4U5xP0UDTY9Rh7n5hGJtxO9SY0IRpbDqr7ar7oi_bA>
    <xmx:K60LaQj9cpqbCYNGODzOYgmDp1XOW53uFvmgZFSo2N0n0b0UmdbxLm7W>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 15:01:46 -0500 (EST)
Date: Wed, 5 Nov 2025 12:01:40 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Maurer <mmaurer@google.com>
Subject: Re: [PATCH 0/3] Remove the usage of Rust native atomics in debugfs
Message-ID: <aQutJAgXt4u3BOmq@tardis-2.local>
References: <20251022035324.70785-1-boqun.feng@gmail.com>
 <ad655011-d695-4dca-bc60-902aeffe73a9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad655011-d695-4dca-bc60-902aeffe73a9@kernel.org>

On Fri, Oct 24, 2025 at 04:57:22PM +0200, Danilo Krummrich wrote:
> On 10/22/25 5:53 AM, Boqun Feng wrote:
> > Boqun Feng (3):
> >   rust: sync: atomic: Make Atomic*Ops pub(crate)
> >   rust: sync: atomic: Implement Debug for Atomic<Debug>
> >   rust: debugfs: Replace the usage of Rust native atomics
> 
> I ack'd patch three for you to pick it up, but I now wonder if you want me to

Thanks!

> pick it up through the driver-core tree?

Given there are some atomic library changes, I will send it as a PR to
tip. Thanks for the offering!

Regards,
Boqun

