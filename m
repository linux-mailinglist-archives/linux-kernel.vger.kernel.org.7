Return-Path: <linux-kernel+bounces-845707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB6BC5DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C04218831C7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077020D4E9;
	Wed,  8 Oct 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPR7mIIi"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056CA2F83BA
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759938598; cv=none; b=Wkd6pLNvGKdQQfTi5mk9JGRb3caLk8JeKFkPih2hO/szTSV9FNgPRgttBh9bClS1+wYccJVIsou17J22Dv+nNZN3lJ2s/VCCKrvtTThYlfAsPoQIWy5BLF3NxH1GCVs+4QiLPPvjqz7AA2H9yvYnCYvF1dJGbiKT/FPjZXxSpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759938598; c=relaxed/simple;
	bh=pWP9f0XK/2HgPCXB+Fct8VLSKVc8reuFuDH13rIx4HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRT25WCYL0PQ3nlQ1FxKUkk2kLSGtUeUPWgQSq/QSsV1d9c1e14rbOwGTxU0C+FrMbJKGrEhGI16EcIjTGtudrgrGfKIDNj+HYJjhCd5pHwtFfoc+hXNjp26bwonVsTfLHczE3rN7fI1eHTxYN1D1tBc75UIQfbbIuNfdocYjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPR7mIIi; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-54bbaca0ee5so1719114e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759938596; x=1760543396; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=posWhcO7uW0YnkFBpk/sI6hl5Osok5DPG0Lk6uuLAiY=;
        b=MPR7mIIic9F/tpNkrRNC3Kh66Ukidn2Tcnsx5EqGBpyduyCOKNOAIZu1rwHdwhbKDy
         aeDrVTLqJ6nBdG6D1imIL5+rj8jdGXFk1H1zI3D7yV8hvDBXOF6sZY3lT7LT9U+/DQfQ
         Svg8njuqwayy6RrjM2YdzvfR+DG0vmTsO4p30jyQm/AJJyHaYnL8Y++7cZwoRrU511Z/
         F1cAEOGINS2YQjOCJDe+L3UMMRgR0WZp6x5Sn8TfIDgRYY7AysWwHj0sC4lulPX9Y/Vk
         G7eCClB5chk7TO6ksFu4kvUPnvJ/WXJVbFs4jft++GB4ysrWrjey6nI3a7e2vfraJfN7
         g+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759938596; x=1760543396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=posWhcO7uW0YnkFBpk/sI6hl5Osok5DPG0Lk6uuLAiY=;
        b=ILB3j7VOuDFbY8eNnKJ2Qe9jZq7TaH+Sl+HOqa5E3TTnWsgofgS/y88++iWHwI0zSq
         a8HjY+jeynMY6y8ihVK/kObWzlmPx/zaGIosIndj1/5FfxBF1me81gnzth5y9NJoNdus
         xUexyojtKL46gUXI6OeRKNpFaJtMCmJaJEEq7rJcTrAISnXpxGIM2gsFZgwgQ/y4ciNJ
         wgOiS9czWO+U6Envo7zu+SAhaF2f/FxrUtEo6KMPZgETwyMU9TlctOLWBPtFfXDJTQGx
         VWroyfYe0HFq9An3oOVJeJsTKtXUOColqngQLb2UMnLOlYUwbqOoQZXwrmNLQRSxWduL
         VNMw==
X-Forwarded-Encrypted: i=1; AJvYcCVxou42rpSEHj1jBsJR9pN6TPLyBhzKJI3/AdJTBMemCRrdjuzcvL0eD/AlSGw5sreoXYk+VOoACD6b5wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAAkS+RF4HVLkjlaM3p6sQOvXKvcNxiGit7OXKn3MzqU2NTjjo
	RzY3VtE1JnCjA+bU/n9L8w5bTLUhFCL52dKRQxfmtj6eRI3jVyRhgPc2YCMpPQ==
X-Gm-Gg: ASbGnctl2MMWxQZ8ey+LkOs7w58h8CLgHFugJbaDxGh92saIs601mncajqJqVIu2Pis
	cg/1CEmOa+9VJPV9ewhymThuiBxupqpcklIGv54IXhar5pqRWLhxr/gjj9prbyCqULXVidfvdj9
	2QSq287SvKPIMxnWDyXrBgLPs6p4SCFsqoMosOEvuaGZDBOrjoGqQNvRKP92Es+DG/5zWPXXlts
	zYN6FsaMW+ADtCdo1fggVvFxpRAYyoMRZNUpMXIlR61ZE27MWo+oyXoIby8t3f8ntuCMK/qYWeW
	3Bp4Qj3tsHTT0skm1PewWZJSLUuEFNN6YcPRa49s/ZL3XGFGoAXbi6ShzJCA2hZzYDTJxT7Ywwn
	MAvqh71iC/7+Ye9pbISlSANTJhBi1XCoJi9SyIpKYoaU=
X-Google-Smtp-Source: AGHT+IEJ9vfvjdDQtiPcrc3cIELW9OyuJZ/EAGgmwTi4uspcOFQieo0RXuDvRCYp8d25pdpbu0sCBg==
X-Received: by 2002:a05:6122:a0a:b0:539:1dbf:3148 with SMTP id 71dfb90a1353d-554b8b3f3f8mr1700186e0c.2.1759938595679;
        Wed, 08 Oct 2025 08:49:55 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55497ee3001sm2300503e0c.6.2025.10.08.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 08:49:55 -0700 (PDT)
Date: Wed, 8 Oct 2025 11:49:53 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org, dakr@kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Andrea Righi <arighi@nvidia.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Message-ID: <aOaIIV8KDA0GjF6E@yury>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <aORCwckUwZspBMfv@yury>
 <DDC0VAHL5OCP.DROT6CPKE5H5@nvidia.com>
 <aOU0joJQZiU61GBB@yury>
 <D421296D-FFF3-4998-B467-8E079AEB7499@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D421296D-FFF3-4998-B467-8E079AEB7499@collabora.com>

On Tue, Oct 07, 2025 at 06:41:58PM -0300, Daniel Almeida wrote:
> Hi,
> 
> First and foremost I’d like to say sorry for not having the bandwidth to
> chime in here earlier. I’ve been pretty consumed by Tyr itself lately.
> 
> > On 7 Oct 2025, at 12:41, Yury Norov <yury.norov@gmail.com> wrote:
> > 
> > On Tue, Oct 07, 2025 at 07:36:21PM +0900, Alexandre Courbot wrote:
> >> Hi Yuri,
> >> 
> >> On Tue Oct 7, 2025 at 7:29 AM JST, Yury Norov wrote:
> >> <snip>
> >>> Regardless, I don't think that this is the right path to move the
> >>> bitfields into the core. The natural path for a feature that has
> >>> been originally developed on driver side is to mature in there and
> >>> get merged to core libraries after a while. Resctrl from Intel is one
> >>> recent example.
> >>> 
> >>> With that said, I'm OK if you move the bitfields as a whole, like you
> >>> do in v5, and I'm also OK if you split out the part essential for nova
> >>> and take it into the driver. In that case the bitfields will stay in 
> >>> drivers and you'll be able to focus on the features that _you_ need,
> >>> not on generic considerations.
> >>> 
> >>> I'm not OK to move bitfields in their current (v6) incomplete form in
> >>> rust/kernel. We still have no solid understanding on the API and
> >>> implementation that we've been all agreed on.
> >> 
> >> Initially the plan was indeed to give this code some more time to mature
> >> in nova-core before moving it out.
> >> 
> >> The reason for the early move is that we have another driver (Tyr) who
> >> wants to start using the register macro. Without it, they would be left
> >> with the option of either reinventing the wheel, or poking at registers
> >> the old-fashioned way, which I think we can agree is not going to be any
> >> safer than the current macro. :)
> >> 
> 
> Tyr could use both register!() and bitfield!() today FYI. If you move it out, I can
> follow with an actual patch to do so.

Not sure I understand this. Does it mean that you have use cases
for bitfields unrelated to I/O registers? Can you please share
details on what you need and sketch some examples? Particularly,
do you have arrays of bitfields in mind?

If my understanding is correct, then I think the strategy that
meets your interests at best would be moving the registers out of
Nova earlier. After that both Tyr and Nova people will get equally
involved in bitfields (and possible BoundedInt) development.

This is what Danilo proposed in the other email, and I agree that it's
the most structured path.

Regarding timeline, I think 2-stage approach will eventually become
faster.

Thanks,
Yury

