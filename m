Return-Path: <linux-kernel+bounces-868945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 003C2C068F0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF5C34ED2BE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857B31C57B;
	Fri, 24 Oct 2025 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAIJsQw9"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE4219D8AC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313541; cv=none; b=b2D0d+Za6NKufjJOtEGq1jtk025ct83FkI1Db9oC+7Wh43ys+odNAuc8TIvYbmv8AMZNvDmAZxfy3HMFSjCQpB16rWCjqYCmfx9xjj6qnGNTqNPf2M3C4tKWu5eQHu1NXPIWQVhW5tf7rQQTEpMyAiS7Gs8EyxLuiZkDf3UJj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313541; c=relaxed/simple;
	bh=R9mC9AqAfbLHak1gVQ+cGB4Ty+4JswFwQ13vc3fhUsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GymSuy+WNQ6vSZ/GQKQdDNA3UdhFkQimaqD3INDzaZ/dNYdv1ZCz9m8fcc3Jn6r4kKIBG31uLiU4MSUXSXOd4fsgKNGjC5Qs6VtH1bg0+4RzCyHrD40Zva964zlUByDDI2iIQ4u1Fb82rwABSCEH9ln//2Y8yW48k9BET71s2Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAIJsQw9; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63e0c6f0adfso2086020d50.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761313538; x=1761918338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jJ9flg7M+cKCZuZxpG7+6bazSm6e3HeyscPxk98oumo=;
        b=AAIJsQw9901jmex2B4RD/Kht/hdM0bApsNGd8sU7xdlrBYCTKaGKrpd9j+Q+936jH0
         +LngL6D/z8REyzR3rsuVSkDbCIfPYeb7gDleiWZicU7BR9o38S/745SJ2Zk/RWSNMFPD
         JmUtxQSevnmJlX+1peC/Imlbjggf4lCzuMAH0LNUxTJR1hxHRVQaNHwiaimnLHi/ZY9t
         wERQGG4EQ2rlSZOBiMHkOeT2YCejmO6rEa7yE0kGIR012Cs0yPUJsps2f3XERjWZsQ7O
         lRQSCzmQ+PPFJ6jjtMzDZ4CTyw2D0ae/FyIOR6ipTvqxA2NOzJb3tYlx+a1X2UudIvmz
         wvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313538; x=1761918338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJ9flg7M+cKCZuZxpG7+6bazSm6e3HeyscPxk98oumo=;
        b=sDZ9f34FcNYlxiupkrLHBp3JbdnyCipMi7Pchz6KbiNfER4Y7g52ywm+DsGcYRfedc
         WcWyaO8grZh07z7/tkA9VNWprjDDbtyCP4Q7OGKqNTfGPhRRwD2EQNb1YIV3UOhNejy9
         syck9dYO/VTdwQA4D8rlK4BSqkGTzh3z4bDajZIKJ5bqlU2Mepqy/tkjZMEfYdxzxqg+
         NMu6kTAuuWzCZQwKX47/VYudM4lfRA7iFw0fJmrd3sFPCeonmyadJ5kEnqUOno4ZPgxW
         TT2VTYNB7GEA+FOo9NhJIEj3cVSsNZHPRQsAp74kwz0XYQnqnDh/TmNr7R132VM53vZj
         2/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWktgsUvk+WiS2mFIc7L35ISsRklecgWLZ6ZdShdHgoqjEk905uY1Lx7KSi+Uh8y0XEHOv4k87eI1Mcy0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJylvnKJ6mTBoWim7AOGMUfTC6JiFAYs7JrkHtSCm1k2jV350i
	XDVnY0EZkAhRj5LfuLaPii9fJtnQjFjs6b2UKWF76uRZOWnsbnErP/+V
X-Gm-Gg: ASbGnctRahiCVahAEIm620mZeZzDSoNeJI4ovdUZm0sViom7vA6nKOzSFOw8Onq33Jn
	uBNEuJVEb2cFWkF1tm4EB49rITDhJSk5dKbgM20OvLSkeJ0pEvloOgzturNzTesJN28QrOd2S/F
	5QfttV+gWbuIlL9mOT7v+HYfWXXesT64BlJeolCL1OY59fi3qN/VZVBxmXQx2n7/3dS+ZFeZTsh
	zqT7/9NGU3HT4Ik0dnjdr3TIF/9Gx+QCMBs3E4YJ7O3ehjWZdUC4rcqIfOb0nFk7QpOW3chNnDh
	6lJ/+bJU/52a15D4zTiLKoFDml6Ap00SubpPH2LkaL0uEslQPI9Aceo5U2C+hhKLg8zP/gPdM0t
	p9XYjcgvqTb6jdPgesvywQwnnVkrcVPpYLwIdwp0+pni/p9nyLxQC9nS5hJBqiGypXu0AV0AZJO
	J6kBd4jBQvVz3Kz1RMA5vj3xye5J1I3StR8MBrutr+HjJEFBmLTQcOtg==
X-Google-Smtp-Source: AGHT+IFE68Htsnc4siZxVCxI/NKRrCYbxxjzUI941ERUrQu0KUkdETGfNwFaCjQcge9iZ90zrqGuxg==
X-Received: by 2002:a05:690e:dc1:b0:63b:822c:4494 with SMTP id 956f58d0204a3-63f43500492mr1757658d50.30.1761313538444;
        Fri, 24 Oct 2025 06:45:38 -0700 (PDT)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f378f087asm1612450d50.12.2025.10.24.06.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:45:37 -0700 (PDT)
Date: Fri, 24 Oct 2025 09:45:36 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] uaccess: decouple INLINE_COPY_FROM_USER and CONFIG_RUST
Message-ID: <aPuDAHzirb3Arl6h@yury>
References: <20251023171607.1171534-1-yury.norov@gmail.com>
 <aPtDGA0JjmfDvxXd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPtDGA0JjmfDvxXd@google.com>

On Fri, Oct 24, 2025 at 09:12:56AM +0000, Alice Ryhl wrote:
> On Thu, Oct 23, 2025 at 01:16:06PM -0400, Yury Norov (NVIDIA) wrote:
> > Commit 1f9a8286bc0c ("uaccess: always export _copy_[from|to]_user with
> > CONFIG_RUST") exports _copy_{from,to}_user() unconditionally, if RUST
> > is enabled. This pollutes exported symbols namespace, and spreads RUST
> > ifdefery in core files.
> > 
> > It's better to declare a corresponding helper under the rust/helpers,
> > similarly to how non-underscored copy_{from,to}_user() is handled.
> > 
> > Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> Overall LGTM:
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> 
> 
> In include/linux/uaccess.h there is the comment:
> 
> 	Rust code always uses the extern definition.
> 
> I think we should reword this comment as part of this change. You can
> say that Rust accesses _inline_copy_from_user() through a helper, or
> similar.
> 
> After all, when using LTO or other mechanism to inline helpers, it is no
> longer the case that Rust always uses the a function call.

It is actually worth to just drop the rust part of the comment - with
this patch there's nothing special in managing the _copy_from_user().

I'll send v2. Thanks for review!

Thanks,
Yury

