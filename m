Return-Path: <linux-kernel+bounces-775729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A17B2C419
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3AB17A532
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F6832BF55;
	Tue, 19 Aug 2025 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VANTE5aE"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01D52522A8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607643; cv=none; b=s+jyHZcxZZuV4KiT/0W4G+jMEpMsGhBD69rWmyKmOqKWmi+qsui+zOwOR+SwfdHnxaEewvE1r0ZuNieNaMiXykoxdbLGl3iRo2z3Owh4oNuV0zoYMaBISp5+sZ0ZND9LdUChpYdIWu1YXFP0pmORy1r/ZAVBUyN+81xd4mHTU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607643; c=relaxed/simple;
	bh=lv+PvbSVe4dMYfPNa9LNq+MhRH/3j6fE6o5NPKGBAcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CKS2J+0IeEVxzJMqm5iHovtB7imw6iUmxRpTg6E3kCiwkw99plF4YGIsksPe6TirI/sDoKffXphq3W+UV7xV0mIbE2cv1fWhoGk2gJNyQaJ6fsD8pTUMgBDx4st294FR4g+n5blNCrzYhnmgXY7ekF+TpiiwjdC02cJSlQWksC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VANTE5aE; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-61a2c95124cso2096257a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755607640; x=1756212440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yCP3mARRCmGSyA8SjIJ4WFibLoFzgkIzQLXkcV/592w=;
        b=VANTE5aERJ1Zhp6480pn7SAjsDN2BoWOhitGsag9GF+/JRWRc9qzrfBdGZ/Ro9krfN
         AyhckEhZ6LwmgsV2w2UKfDmzXL07LoaERPFVKCTRNBWbd4QavxHxSWsszzUZW9xVfRFE
         +5L5BBEQqjq7ZXV7mhYEzQBIaPp5J3IRDN1tNZNZqh4XiJin1L7MhDHPN6X9w0C6JMGw
         p5HLTf5mO2wqygC3V9/F1SPjJZnll/YTicd/CS4JGomoEVgiyEhtHaCxNMjFF1Atfhlw
         Ix/+zz0h8HP/y9nOIwvFzv3Bzy7IonyCEgUf5IRgf7M+esLpXNJ3HoxoipE/KZyGsZQh
         7C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755607640; x=1756212440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCP3mARRCmGSyA8SjIJ4WFibLoFzgkIzQLXkcV/592w=;
        b=vBSe4CFqTJTFcenkP9UgEYxo4Z/NvQnNRvGX06DawVJlftoMZzpImPRMt1zesCqOXF
         jzsL9QO41/3IKP/few21m7mwCq6b1ILEUKc5vkqdfnU62HpNGSCazypwx+npqQ5exhCi
         NGEWmGPGzrnO7BJRcTkX8CFQYdpMiY8uOauhxJyylL6jJmVibJEoCJjXTAH/LxdXwpXP
         GLTkVhSs16KHZ2bz8JLqul9LJKaag0G9cfVO5XA1vEf1gMSj3ilYEhwtPIOp4qz1V+56
         BZUvgr3ennLmyah9bBlMKzZboce10XWzsem7DE1o8mxYr9qEK1oetdzwBJZtN5mabrBL
         0C3A==
X-Forwarded-Encrypted: i=1; AJvYcCWp5rMGLZIU2xsF/sjoKaTCaOLLxT1ixFyIvKeBY3BksMyt5+Re8OXB//093afePq4hgyRWIL5iTv0/6UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9rmJcIt6SNbp5QmYwQ7cMqfgOBT4wF7Zh3lB6NU+enhX7EGDU
	HOoD3SF5gr0HkZKPEuoleDzMuSo4kAKRFtwQO1qOagtIaFnHYecE5ICe0hQrTuVTYtyn7XVJUHd
	uB0ICvZ+iUw+wcKXg8A==
X-Google-Smtp-Source: AGHT+IEm3E+YxF6ba6FVTvvJ2UxOIsdLdFxvx7w0w2FiBNMNteR5h1lV12gqN201Yr/4E2dtrSkazbFRx81rp1Y=
X-Received: from edah9.prod.google.com ([2002:a05:6402:e89:b0:615:3b67:8aaa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2351:b0:606:ebd9:c58b with SMTP id 4fb4d7f45d1cf-61a7e6dd3femr1764482a12.1.1755607639860;
 Tue, 19 Aug 2025 05:47:19 -0700 (PDT)
Date: Tue, 19 Aug 2025 12:47:19 +0000
In-Reply-To: <DC6DQKE6LVNQ.3BBD8WF8XGROO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-5-229b48657bab@google.com> <DC6DQKE6LVNQ.3BBD8WF8XGROO@kernel.org>
Message-ID: <aKRyVwfwnn5_MuB4@google.com>
Subject: Re: [PATCH v2 5/5] rust: maple_tree: add MAINTAINERS entry
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="utf-8"

On Tue, Aug 19, 2025 at 01:49:27PM +0200, Danilo Krummrich wrote:
> On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
> > Similar to and just below the existing MAPLE TREE entry.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> > Liam: I'm not sure what you prefer for the MAINTAINERS entry, so let me
> > know if you want anything changed. There are also a few other options,
> > for example, I could just add the files under the existing MAPLE TREE
> > entry? The get_maintainers script should still send any relevant patches
> > my way because they also match the RUST entry that has a wildcard on the
> > rust/ directory.
> 
> From v1 [1]:
> 
> 	>> We should have another section for the maple tree, since it's not just
> 	>> used for mm.  Your stated plan is to use it for GPU allocations and the
> 	>> code doesn't live in mm/, wdyt?
> 	
> 	> Sure, I can add a new section if you prefer that.
> 
> Maple tree is already used outside of mm, e.g. for regmap stuff and I also use
> it in nouveau. Hence, I read this as moving maple tree to e.g. lib/ adjusting
> the existing entry.

It's already in lib/ ?

> I personally think that - of course unless the affected people prefer otherwise
> - it is usually best to keep a single maintainers entry for the C and the Rust
> code. Maybe Alice can simply be added to the existing maintainers entry?
> 
> What do you think?

That works for me too.

Alice

