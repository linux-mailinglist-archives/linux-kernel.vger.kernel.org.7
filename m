Return-Path: <linux-kernel+bounces-853082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C098BDA99A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 18:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A0F580899
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866C301466;
	Tue, 14 Oct 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CA0MFq05"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450E828C5D9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760459019; cv=none; b=PfcO2DIoWl4ik389vSuu3IOQgXm1ltn2rQ+8ifBZJtl9rBZfSy20/1terOQBsXIlyfwKytQdkfwnGzSu/X1mC4nvP+T1jfbcClepK6a4owOiE8NQQOKC9ki3XRap1WNqg3pEoOUrxHMpRuFPK3Mzv5Agvp4N34k+Q+XgqdPLnAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760459019; c=relaxed/simple;
	bh=nLrVSbJF/dsM8EOkqzzEHEEEJ04HBU0HW1wHxoyhlPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtY8XyLhIIWlbtGTYPFkJUihsYXw1cusOlWhGJf4G3mNvmwXJLpUso6OqZ/PmsIFj/j/EmX4urxH4b00vGZt7skQISCNIJlwJLMLQwCXaKXO26/H1rZAGn2u0lME8102uqUHKfDXJkpD5On7trkO9O/53MvXZjHpawF1wCFyPGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CA0MFq05; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7ea50f94045so375346d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760459017; x=1761063817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7CUMJDuqtfI1vdOSW6FkgvPnhx2KWnxWXMO5VApQeZE=;
        b=CA0MFq052hU/qEulaBZIIBo4dMcsOvCk1a+qZxAbMqBKlEU8IOUZAnfOKaqPgo682q
         PjGqFe2ea468ST+dTcCGXUHfDzy+oB+ULRZmYb1lAWBNSDglnvoR3I7PyfYToKJXOnzz
         PRgMOJfALIPiwLUzD2JYpiZ+qePCHHqUEfUjbC1c0lMtjWjyCdsCD+w1zTs3FXlf337T
         d+yq6RNjWLHxShnUsKo9Ytp7A9z2Kc9OyOEYWtbUNegA7uHjbNsQBoyff+M4vHSd3giq
         /vU2y7gMVXjaQ6r62Ffwzscnsz4FYusv/Zmw4b0CW6g2VV/coPIWOX1Da9EP16NGMB7R
         v+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760459017; x=1761063817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CUMJDuqtfI1vdOSW6FkgvPnhx2KWnxWXMO5VApQeZE=;
        b=JqV3Zx8/JmpvoV6jXdzShxe2HMLkgZyDwhr7h3hEAiFE3tDpWMsuWmF5B4ZYJPSHfc
         9chdrkwownnyrpe+XyIio40slLCuPDWu0pQkGkRycNeMHbf6ZNqHY02aDdfuB4JBfodo
         qiE9ZSQWO0+9Uq1aYfTLMMEt2F6sQ4rBP7MswZLBiWd3HoYU4xonV93Vtx4wXBJksrIj
         3ZlRG6UpSVRd7aTZ0zw9bGnSIyVy1iNa3m8LB7785kt8WPyf+cYjW9QIhMMffs69PvdS
         xIcc15KGPmahML4P4kynw2QxBdXOK6vI35DF03Jmf0Qp8GDLwr1DvAW5ziN08gh98apO
         ehJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRBVjded//LTNqf6NTjT15iLlDwxBljDGJh5Dwf+lU/i0qooDubHRK2w/JMe8qgDRk5/tv+kZJIgFzzLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpyQgbU96WVJdKWwRLYkJJtdPKwhp9f7nhFoi3IVC8WayeWWV9
	6769N/rTutcM9Zo8qalKJD1+7GeODhoF66VRYukfIVA1aEu+GaAbloX0
X-Gm-Gg: ASbGnctk+6cW7dfqmkslJm84XpO8TZauF3LiugkCOS4bSOmlxODVPxpOOY7NOA6XpOZ
	nMgo3Eb4KjcWS38/v/bn1nUZkmPoy0rr1MlVSeUXtfHWyr77V07avJYrzdoAmJo2BdYEeZLNwXd
	/63lWnoTP24rUpM4YEdFVL+RYPvzcBlUcK7nHBrFR1wXpcrxHa2A8IE7SaVkqdgpz+1CFUKpnRT
	jTmwcp38HhvRlmm/pAf7N1YB2gqoVjoBQ/LbpG4yawqeGjfdmksF+OqsXPCfYKXF0cwdif4TSns
	UZPkV9u08xOqPKhWnn/pyv9qxKsOUexspBwkgCYfaN2tqglL+Obvgv9GDVfzNIguhqFd/oazxzB
	sTy6Bh+0SlIe6kCyMOd1xUOv3i0qd/qcyEWF+/A==
X-Google-Smtp-Source: AGHT+IGb3LYxLUu0gNLKSrBv3dHhkBztOS9rJ5f0Uu7ubH+luxyqfSH/R31aRzsAnX4WaPCwDZbGSQ==
X-Received: by 2002:a05:622a:109:b0:4c7:a8ed:af3e with SMTP id d75a77b69052e-4e6eb068d26mr360037541cf.40.1760459017010;
        Tue, 14 Oct 2025 09:23:37 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881b10bbesm1938161cf.0.2025.10.14.09.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 09:23:36 -0700 (PDT)
Date: Tue, 14 Oct 2025 12:23:35 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Burak Emir <bqe@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: bitmap: clean Rust 1.92.0 `unused_unsafe` warning
Message-ID: <aO55B_ishdHO2uiW@yury>
References: <20251013001422.1168581-1-ojeda@kernel.org>
 <aOzET46lagm-p8go@google.com>
 <aO51pV5WSmqnT4rL@yury>
 <aO54nxGil6a5hLQN@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO54nxGil6a5hLQN@google.com>

On Tue, Oct 14, 2025 at 04:21:51PM +0000, Alice Ryhl wrote:
> On Tue, Oct 14, 2025 at 12:09:09PM -0400, Yury Norov wrote:
> > On Mon, Oct 13, 2025 at 09:20:15AM +0000, Alice Ryhl wrote:
> > > On Mon, Oct 13, 2025 at 02:14:22AM +0200, Miguel Ojeda wrote:
> > > > Starting with Rust 1.92.0 (expected 2025-12-11), Rust allows to safely
> > > > take the address of a union field [1][2]:
> > > > 
> > > >       CLIPPY L rust/kernel.o
> > > >     error: unnecessary `unsafe` block
> > > >        --> rust/kernel/bitmap.rs:169:13
> > > >         |
> > > >     169 |             unsafe { core::ptr::addr_of!(self.repr.bitmap) }
> > > >         |             ^^^^^^ unnecessary `unsafe` block
> > > >         |
> > > >         = note: `-D unused-unsafe` implied by `-D warnings`
> > > >         = help: to override `-D warnings` add `#[allow(unused_unsafe)]`
> > > > 
> > > >     error: unnecessary `unsafe` block
> > > >        --> rust/kernel/bitmap.rs:185:13
> > > >         |
> > > >     185 |             unsafe { core::ptr::addr_of_mut!(self.repr.bitmap) }
> > > >         |             ^^^^^^ unnecessary `unsafe` block
> > > > 
> > > > Thus allow both instances to clean the warning in newer compilers.
> > > > 
> > > > Link: https://github.com/rust-lang/rust/issues/141264 [1]
> > > > Link: https://github.com/rust-lang/rust/pull/141469 [2]
> > > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > 
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > 
> > Added in bitmap-for-next.
> 
> Is there any possibility of landing this for an -rc of 6.18 instead of
> for 6.19-rc1? That way, the warning won't be present when compiling 6.18
> with rustc 1.92.0 and newer.

OK, will do -rc1

