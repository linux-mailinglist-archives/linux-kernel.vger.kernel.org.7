Return-Path: <linux-kernel+bounces-807121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44212B4A05C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0F6189767F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D391527FB18;
	Tue,  9 Sep 2025 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyvSzRhj"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB492264636;
	Tue,  9 Sep 2025 03:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389872; cv=none; b=M1NFhBXbAdx28Ig9CPFGeP4hAXaXWXQIzJ6P/iB68G7NzCnalaoNKdXbNGNDa2MSbiPwJms1qVh9NVCG0c+/fulEM3NqEyIKoAOBKyuB+vxgK6mvg8Ez3MxjePFT2QPRR1nB98We5qwHXGIGZXSQ3Gx4fEU17cpMf0D74RrmcD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389872; c=relaxed/simple;
	bh=E3Nq7+cElEwE8uCdzGx/S14NtqHghZJVXo6WXQcOUtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxV/X7+ewcSeun62tJsrDm9Ix6TinqXevtGzCzXnvTeRiJVtJqEgpO8oI6eu5czdLzXJ5SjIWTZUzoAFDwPlgJToZsOmMSmWQqt0TkVCX4M//6lSVW7EN/wx3cWhpOIByED+BTy0GqhYwGKyKAOTAlcDZ8LnEtPNbsELqFJxdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyvSzRhj; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-811dc3fdc11so205850285a.2;
        Mon, 08 Sep 2025 20:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757389869; x=1757994669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGykBRkJkYobDp8XrDylU0djV3QXn+TetZuMKoF+CSA=;
        b=kyvSzRhjwrAZ+gAObMjTdCWdAKMHtGWar8RCKf+doCaiIcqTLW2Up/hr32kagAucoR
         nY5dIOI9wyaCvtZl3egBrn7h3aW2eiFCQ4/yMYaGB7FmdhWwSEoPDyGVPZeY03CnPAFP
         bsJ0pAmWhCI+Lz/fDQaN+eYdWxHcJZ9VRYlQ19TJ5dma4tZIucnZWD6+COrJ6zJnDQ+K
         pr3UrroUO1gVZp92jILtNstfJQOgX8X0JY5YMJ8HjiDw/31F5jpjkAlh1hDvZbA91A6b
         95TCR2f5Lbu/MpHO+Qj8lfa60beVrZgBnUlWj1nwVoZALXyfrtlugKCa8QBzOgbSPkoM
         CBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757389869; x=1757994669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGykBRkJkYobDp8XrDylU0djV3QXn+TetZuMKoF+CSA=;
        b=xHVNP+7OC6s/Ku7fXmLFas92Mohi/pmRTPU6GQX+kx43paJRHmt6YnlmpJOyYR/8CN
         p/qZ63TIt7yBlAC583Kx0DffwuUHGDO28JJIsyvjg3Y2sem50zKacHuoGYsbtzDhBPxC
         pqqRW17CJ9vQ1gRMukKy0fpdmNM8DIchHboE0fvpDgrN1rP/dlVqAVx0vcTRBxSHfVW6
         ZBk/3ZSCAnUYNnRZKEglWfnMit91e3Q/OtL5wT1a5in68BJNWaXBuZljuJpIKB1XNV/t
         41MrdVGpT+LNiBEer7HvzYhJP1rU/44bbtoyigfMtnXzZBULMLU3BTJH4yvRUIzG8Ms2
         RZKg==
X-Forwarded-Encrypted: i=1; AJvYcCVQxtA0kgpWNbZDmSwDK8TNI335/VmilRW4CDFCUf6BOTQezf6CgdnaS7bKydmqhxeZe9a5gvPrhcSOvJs=@vger.kernel.org, AJvYcCXD5+EfNBN2ZzGpUP7aGTvVG6VrLG+D8UvwP6OSI+iKF4VzQpNpM6srqO6laVBS48uzK5R3baAdGb7j5H1BC/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZtMLm8eVniJHvl2XixCSYGrKl0J1iPHK0mNWqC/abg25pK9o
	coC2hHApvCdUYEpiuJMDXV/qYAoYjz6BVInQLCP8bzkWLGFmQ7PLHR8r
X-Gm-Gg: ASbGncvaCCQZi6jwQM8PQd1v54pcVhi7wexLqgnRx0+gZhuiFaTjRu8F+rfyEUc1lTF
	m654RRpf5Nd2DYjNIAXtVNUGBKfif7407UBNPmatP5EllwYLJnzyXZW8/KVZgqXWMDPKVjipZje
	6lnD6jtKj4TmeJrvggZKeJ0fTrvqf1bJL6iDX7DyJQRT5s/EVSV6l5YzjwlouIdSPF87VMyeKI3
	N+BCkNPzZDYsBU3bHehfCApTQR7F3QztZySrhdHNYQt/zKlzSoBuo2Ncp0JAoWq0uaD/Nbyd6Eg
	AAAFhXNO9rXaW4wjlaES13dBBiubq3qTbnbqhjfNhSpJQXo2WglNDPZtqcOer1DsYnTRsv/Xqvg
	BfyuUsQaQ8tGG4TEejIqNMMKD5G4c56y5ovAaShqVWfZhH3FkZ5phCzF/Af4L3qUX3zfIb+4i8U
	v/2xAO6kttwVrhN0VxUWblRXQ=
X-Google-Smtp-Source: AGHT+IEOhdsMCjgB3JtWmDWWkLH/LAXbv7jCe+u+cwtMRli1g2oWTOkrPyuc6EqENHSVSnXxKLI1vA==
X-Received: by 2002:a05:620a:aa0e:b0:814:fa5c:c5c with SMTP id af79cd13be357-814fa5c0f7bmr951533885a.70.1757389869483;
        Mon, 08 Sep 2025 20:51:09 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b598cf901sm56891185a.23.2025.09.08.20.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:51:09 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B8E2F40066;
	Mon,  8 Sep 2025 23:51:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 23:51:08 -0400
X-ME-Sender: <xms:LKS_aFOZbRPDNsWlNYxlSo4Ppzf3kzhev6OS46idRHsNjXFsRDqqyQ>
    <xme:LKS_aAzoqI5eBrOLSi5jujRWT4FqJqOCce7vnqhGe4x4vjmsknw5v6MTP6y9JT_SN
    f_YhCpGD0gwBgPQtA>
X-ME-Received: <xmr:LKS_aFlGR28orB4D0KSX1kI29YSKgcdOe40ewQuuqRL9fuAsaFA-w1HSw0AwdpjwJYhKJNEEIbbUUNYSOr2uy2g1eY-U7v9R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtoheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepughrihdquggvvh
    gvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruh
    hsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhmpd
    hrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthii
    ihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-ME-Proxy: <xmx:LKS_aG_uxw3CVOc7srjkumEPiG8dKo2rUHJ2LuOqw4omD5BWDbCcwg>
    <xmx:LKS_aBPnZzmi4v5FgoRxZsf91YAtN4mx2FHtzFK4a8mU_mjTkAv5cA>
    <xmx:LKS_aI8SgpDdQkRFJ79ytWCvIY6RIS2czsAu9E6Cr1oDMQXZien9Iw>
    <xmx:LKS_aBIoT50ClmK-k3NqinTmS6o4F3M6ynGCXBvjPiYSirqXCJVyEg>
    <xmx:LKS_aDd_CnpmO_CT6koJpB5vI-aT8s7c0rfFoHQy5aTKUzvKfFCYGBON>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 23:51:07 -0400 (EDT)
Date: Mon, 8 Sep 2025 20:51:06 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Lyude Paul <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Asahi Lina <lina+kernel@asahilina.net>
Subject: Re: [PATCH 1/2] Partially revert "rust: drm: gem: Implement
 AlwaysRefCounted for all gem objects automatically"
Message-ID: <aL-kKkJ14pIqhMJh@tardis-2.local>
References: <20250908220657.165715-1-lyude@redhat.com>
 <20250908220657.165715-2-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908220657.165715-2-lyude@redhat.com>

Hi Lyude,

On Mon, Sep 08, 2025 at 06:04:44PM -0400, Lyude Paul wrote:
> I made a very silly mistake with this commit that managed to slip by
> because I forgot to mzke sure rvkms was rebased before testing my work last
> - we can't do blanket implementations like this due to rust's orphan rule.
> 

In general, I would avoid using "I did something" to describe the issue
of a previous commit in the commit log of a patch, it's less objective
IMO. Could you reword this a bit? Maybe more focus on why a blanket
implementation is problematic.

Thanks!

Regards,
Boqun

> The code -does- build just fine right now, but it doesn't with the ongoing
> bindings for gem shmem. So, just revert this and we'll introduce a macro
> for implementing AlwaysRefCounted individually for each type of gem
> implementation.
> 
> Note that we leave the IntoGEMObject since it is true that all gem objects
> are refcounted, so any implementations that are added should be
> implementing AlwaysRefCounted anyhow.
> 
> This reverts commit 38cb08c3fcd3f3b1d0225dcec8ae50fab5751549.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
[...]

