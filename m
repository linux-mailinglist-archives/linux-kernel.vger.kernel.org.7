Return-Path: <linux-kernel+bounces-788514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59710B3858E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC42B7C785B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE22C22E3E9;
	Wed, 27 Aug 2025 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MF8cBMVG"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C71D9A5F;
	Wed, 27 Aug 2025 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306601; cv=none; b=Cb0DR4NERkuhx3thzmF40FwYTKAF+ubrpIg/uNHFgFfGa9qKQYJVgQbVKBkm0LaxScOwKwjpdNWyazdBfHnD7fCsVs6PZ2UrPMqnOOnWr0/RXKz8pk5PDW7bmsnGhG8S3AjMAGnqFJ3sFXXpxZM7JrTL6JW1JDB5W83skPmx3Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306601; c=relaxed/simple;
	bh=vfso4WcCIk8Beps0mOTLMJkq24KmXe39djx1ppMuTsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V85P2UTB8vmCVZFJ1VT3CVJs98w4Pe50LJvy1DG89pecqTFiBEDhfBhbRf6gOy2sHNk9QAKFAImBUjGvVYaCEU8+wdRGH4KUFu/g+KAZ3Il1Ys13sV17h4MdJ1U1+jPuR73waLoWribMkFPALiwvUMUgGR9IdxIFMbGisbVct0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MF8cBMVG; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-70a9f5625b7so61699806d6.2;
        Wed, 27 Aug 2025 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756306599; x=1756911399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyLxxj4J4mb5KUxNOj7u4hyb87qKLpz2ug6sAWw+ib0=;
        b=MF8cBMVGUciiCWwqcskbDy0YVUL5CIZA5/WLBbT26+Zlvo0/bwUF7tTnLjCgljO1rI
         yJbaWhiAaZKQb2Nssb9NZ6EJ45GdbF5mkE9LIE4hl+ELW84Xmy72yt1P80sCjnKBWYOs
         YSsxnGpIVhAnc3GtTs1Fi4EkgLCKWNKPtWDeRh1svyMdNyJiDqMXrwc6XdxcPUtwTaNH
         zaeU19vxwpPW3hIcEAPVQYtVKCagwq91gSsfeYVdnvmrDAtBBmqCFI0HzvjUc6yNrUiF
         tKY6rGbdnPJIsUNGrOXEjSmbn0wHbRkh7F+tnevx6Z//T4CrDFsaGYTD9ar5r+q6PFd+
         IU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756306599; x=1756911399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TyLxxj4J4mb5KUxNOj7u4hyb87qKLpz2ug6sAWw+ib0=;
        b=mDX65NM0pPaNF9tcm1HCjQKRkkVQ8LZqlTUOc3O7TYnpIIm4Ovkfagz2A9hXrvsikD
         hzuxZyT3IbKkrY6RKFDu/R/t8NP/tPgAScRP3b3sdyXotMpkjnV+Cxkg+O7ZmH0cke5u
         1DCS7tbX5sN4KecPtQCKe9dHfDTppGKRiEeiiJISOXH1dQATgc5ZB4dFWNgqL97mG+qa
         oMXKoS9jUbaEDD1214aRGC4aXcoWn1f97TjQVxElEcSV6ZHEzZp1+P5JQ4kXFzh1QJn7
         gf118nVJ0m7mpQ5eIyi54EERXf34YfhdzqHXGbXiQOH3ywiuO+vdIf0AQa8tlHo90dcU
         4gTg==
X-Forwarded-Encrypted: i=1; AJvYcCXFLZYdi1aYE0pQ+PbUf3lA7bSrBsOH4KJlo+WIIbLEYdETqX4idz5sIxSY3ByiukjKofK0TN5fQEhbFCJlxbI=@vger.kernel.org, AJvYcCXkjg+YqkjMh7ZD4/aJPkZl/YgfV/MPND/9OBVh4bvA7F8gGInsiBBYx3CIe3daLaj1USNPYbkku3I+dmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDXe6v84Uyf5XKegb1mOiJivev+zxF0ZPY1rP9IHu7SjBWI+On
	DUiYInM8/hNVAlR7zmW3MOa7HtJL7tX/lxelRAQOaOWBkuYL+d4cS2dkU8KR9w==
X-Gm-Gg: ASbGncuF2C+VqYHY4Z/ILlciiXADqUl90llOyZZQMX2mE2cHVpWZc79TaohCZ1PFLN/
	fabWd+m3nlWR1N5nVUyPEmO+UxrwrVjs9nvGr+ktiKl86CFT+B3IL8dO2q2Ix1v/y/N/2qcjGU/
	yp4SlF7VzYuqsARNJWIXrI+DTfd9RmnEx7LFDvRn3NptAj98DvIfnq+ZtAnXJQuWA3Fj3wzwBFI
	DSCBnU83f14QESzLhj4shJefxBRw9vnyBb0HEC4Afj5S28QOcTMA5htUjKugYjzDZtcpBVCkJF8
	78++ClRsiM8lUuwp74ZQ6BdZh5Ao9bn86Ni9Zw3BYH3vXvmglc8UAAGIog3wN2M3EkDi2gekWgF
	H1ePkBSo+X/LMU3FJolZZ4HxM8cVIacp1VfevBQPkMFmrNiBVxAOmreCYN33sHethZbisZ6InxL
	2qbKEZ9xBsGczasZfik54zp7I=
X-Google-Smtp-Source: AGHT+IGEHAnwTXrZhkDzD4+epp2DzzgWL4hmmXbMpxgLBkTFMydZ40IiWdKVIknM3pVKFixGWMn+Dg==
X-Received: by 2002:a05:6214:dc7:b0:70d:b124:7a91 with SMTP id 6a1803df08f44-70db1247b53mr155767886d6.61.1756306598668;
        Wed, 27 Aug 2025 07:56:38 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ddb4bcdefsm22033676d6.65.2025.08.27.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:56:38 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B05CF40066;
	Wed, 27 Aug 2025 10:56:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 27 Aug 2025 10:56:37 -0400
X-ME-Sender: <xms:pRyvaKUegihOoDRLwugxZXQIIq33zTdVbklbgo377qktfZOXgNrj0w>
    <xme:pRyvaFxl1kya4oOAaHI-G02GF_84M588Ah_I2nIPrWXTbDUdc8oq2NW0Wq7psrIm5
    mlSZ7u9OaogxgHC7w>
X-ME-Received: <xmr:pRyvaBE7W0y24Y3Dr4idx_Ntu1CJCR33PhUNWeu82pZ-myumvKRf-6t8GICnPInQL1aAc3C5g7pJLa-O0b2K8V91U-2l2NBK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeekgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdeigeeh
    vdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnh
    efpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuhdprhgtphhtthho
    pegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pRyvaKul5nMHslttmTr39VaWQ9A2_W_df5kPXFJqMlcZMFs1we9Dug>
    <xmx:pRyvaBBpXsg3Rbr883R4kQizn2Q0XDsowQPdMBaK39x02fJdO63PWg>
    <xmx:pRyvaFCy4SNrvLBJclBipo8EpXmucAryFOUwcWgd86rl1ZJ3enFZpw>
    <xmx:pRyvaLqdC_qBNSObKO2kiMNxTX085x8v8fjVw2U8Z8xtSdrqFnNEoA>
    <xmx:pRyvaAFSuGOMpx3EFsfHFvpq6Rr7i83Abzr3Oe-pFIxL8A4-DXZUIwzr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Aug 2025 10:56:36 -0400 (EDT)
Date: Wed, 27 Aug 2025 07:56:35 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: use the new name Location::file_as_c_str() in
 rustc 1.91.0+
Message-ID: <aK8co_CHsqr4gBhe@tardis-2.local>
References: <20250827-file_as_c_str-v1-1-d3f5a3916a9c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827-file_as_c_str-v1-1-d3f5a3916a9c@google.com>

On Wed, Aug 27, 2025 at 01:12:16PM +0000, Alice Ryhl wrote:
> As part of the stabilization of Location::file_with_nul(), it was
> brought up that the with_nul() suffix usually means something else in
> Rust APIs, so the API is being renamed prior to stabilization. Thus,
> adjust Linux to use the new name on new rustc versions.
> 
> Link: https://www.github.com/rust-lang/rust/pull/145928 [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Thanks for doing this!

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

> ---
> This hasn't been merged upstream yet. It shouldn't be merged until that
> happens.

Let me know when it gets upstreamed, I'm happy to do a test then.

Regards,
Boqun

> ---
>  init/Kconfig       |  3 +++
>  rust/kernel/lib.rs | 15 +++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
[...]

