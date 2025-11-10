Return-Path: <linux-kernel+bounces-893435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1F4C47637
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070CF18815C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBB23128B4;
	Mon, 10 Nov 2025 15:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiXb/3KW"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1722538F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786895; cv=none; b=q2njkGuUQM3lDUn2vmg+3bshQtL8EBtHfB+Bhryj1x+W8S7P3vKIKpVjSLTP0fvr8PvOWT0qy2mBNsDn6cDrMbl81mfLnB05F1OxpGJDVOPu25t2GZ36gghg+TUsJcfuaiaOaRYi5YcvjAcmcJj7/Nk8bd1lKIE619HjKvoCUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786895; c=relaxed/simple;
	bh=+vijiCULmkjBaCxsLHOToBL0ostUL0SnrDuVj8Nc/rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVxgPqz72ydLrwm1BlfmTLT65slR1MUFNZSaWJDGcNTfn2uePhmF9dHoufA1vi8569xeyM0pwbWmxXYRR4ydONo2Xyt9TVIMO7LKGKh6Jz3UUI3j/vvYkceEqvLLrkeUgX7fTUFiFRBQZhyhODOjDVNq+XWKbGqgp/IZt47sWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiXb/3KW; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63bc1aeb427so2538187d50.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786892; x=1763391692; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3dYsHp8OhHlSis1fUtc8a5OjTeCx9EkZ9TotPIFCDHU=;
        b=XiXb/3KWMGa84CCWj6gTXgHTIESnnADQNhBJwakoI1ZlQ58BFr1EKgulGCHW+VDXiO
         5xqr2ZgL1vdcnUxuNk/HeDnGkdu+k3LplRt+WO9qRtdXKms8cc5tuZuQ0Fn9/xCkTNHs
         EgpgEONuEbgGVzLA/yjvjXPTR7xLPPoXtMX5fiw/1B5UiYVPq4U0RVnPHbWJVwVFQEeI
         HqrLTtDUdki+ZO4AC4Hcr3/BNYV3cTS9zWzC8/yqsOtlseDnOEHimWJGasBdElhrRoKb
         BwTrYF/mgLp8sNkDSbJN7DpJUB3lWwpDWC9Gs1iHX4eq3uHfhXl/HmbTYZkf5fF+efSm
         ZTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786892; x=1763391692;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dYsHp8OhHlSis1fUtc8a5OjTeCx9EkZ9TotPIFCDHU=;
        b=urf3WVhs2aRNDeCDRpXIwgD/UdmN/p0iLUxNkqm/fcU2VJZmpf0FeG69Jia1tpcP/q
         5c/Ib1ehdFCL4QPZYjsNEg5lpOKRUxBuhluhtQnWDUOE3R5cZuHJc6T5qB5OUJzg6UIq
         KNgGdwVxQXMGH4G4KViF9DQvYgc1EABvZbDh3uiqGcCgQbi9TejqknK7A4k8+rYqcCXy
         PIjwiU2cee8xPL1McPSYlhz/TjS3I4nrfqQSGzSOVH/SG3o3/5ncOPonuByfZW1hlb0Z
         /hsAWFJgZY0j6IvnAbLbbdbaIENxKkE0TAWukw0QjN/i+imBF6e80pJmR0vrlQdWWZCP
         03Zw==
X-Forwarded-Encrypted: i=1; AJvYcCWukL2CqOYH/ALcXC54sJWfEZdKZihMfkVQpTKkJG1PH68M9eh1VJ7NWptAk3e/lyin8ybH4pWKhoBqWWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zu0ifSQgBy4S8LZPE/KAX1J70PvHGncoZNnXfsCPeGL7ota8
	G4UF2VQ8BgAbf5aRUT5BPESgwJTNANCZSe6wFzojtoV5NPEjQAHIHxeJ
X-Gm-Gg: ASbGncvPaWj7La+14PQ10CNGla50zQsdBUc5blq4AeanCUA5wU3YurcqxfQce/n3FbH
	O3+ZOekpAcLuw/7Rq2N8p3NkJ1PRhmMPIgW9iq6B5oyHKhogfc7pa4JAKdv+SnWIvENLo/Jd02O
	LDbMMIZNRoEUPt8xL3eSX0Syyy1HrJWwqEsjBBh83cHQpRpaAjcPjxpY0Z9fYy/aW9mJDpbhxlu
	ydCFUBvKxV77x4yL92VAFsrdIgfWNGWPIVgDQxOvIGZDJ4fj6MaDbzRMpr48WjOv6IYF22fVnFU
	rML9BBBv2yprv/Izqd2V+tQLHrwrfwUBqu+2MpYcQaUZMNGUBOYhoQCjba4W6isz3WZE5WhpdTM
	6rmqbEMX8icGBmsGkGs3Oy+4561qRmntz9NXwzwYzql1Eu/i60n1h3a7cPOuvc6TL6wJZ5LfBfn
	XTkl2S3ZwuqTl+I8tVTUc+uMpU1wJWlL/lbMWQsHbUnFQ=
X-Google-Smtp-Source: AGHT+IF5h8yGExJOpDLfor469h4TLiSH6Q4kHZk1Usy0pVIwZQ3k0Xwche+/JbCIgtnaAeVY/rGjyw==
X-Received: by 2002:a05:690e:4191:b0:63f:beb2:952b with SMTP id 956f58d0204a3-640d4522d5fmr6932790d50.9.1762786892212;
        Mon, 10 Nov 2025 07:01:32 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640da6324f5sm2159170d50.27.2025.11.10.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:01:30 -0800 (PST)
Date: Mon, 10 Nov 2025 10:01:29 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN
 constants
Message-ID: <aRH-ScufjvGYPx5W@yury>
References: <20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com>
 <20251110-binder-bitmap-v4-1-5ed8a7fab1b9@google.com>
 <CAJ-ks9kvMQ9tUMZyM07jRr8O+pJ6RRvCZodenB==tzDChhHT=A@mail.gmail.com>
 <aRH0oRU5JXKpAKpB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRH0oRU5JXKpAKpB@google.com>

On Mon, Nov 10, 2025 at 02:20:17PM +0000, Alice Ryhl wrote:
> On Mon, Nov 10, 2025 at 08:59:36AM -0500, Tamir Duberstein wrote:
> > On Mon, Nov 10, 2025 at 8:06 AM Alice Ryhl <aliceryhl@google.com> wrote:
> > >
> > > To avoid hard-coding these values in drivers, define constants for them
> > > that drivers can reference.
> > >
> > > Acked-by: Danilo Krummrich <dakr@kernel.org>
> > > Reviewed-by: Burak Emir <bqe@google.com>
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > >  rust/kernel/bitmap.rs | 16 +++++++++++-----
> > >  1 file changed, 11 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> > > index aa8fc7bf06fc99865ae755d8694e4bec3dc8e7f0..15fa23b45054b9272415fcc000e3e3b52c74d7c1 100644
> > > --- a/rust/kernel/bitmap.rs
> > > +++ b/rust/kernel/bitmap.rs
> > > @@ -149,14 +149,14 @@ macro_rules! bitmap_assert_return {
> > >  ///
> > >  /// # Invariants
> > >  ///
> > > -/// * `nbits` is `<= i32::MAX` and never changes.
> > > +/// * `nbits` is `<= MAX_LEN`.
> > >  /// * if `nbits <= bindings::BITS_PER_LONG`, then `repr` is a `usize`.
> > 
> > Should this and other references to bindings::BITS_PER_LONG be
> > `NO_ALLOC_MAX_LEN` instead?
> 
> Ah yeah it probably makes sense to update this in a bunch of places.

Yes, please. 

NO_ALLOC sounds a bit weird in exported API. Maybe NBITS_INPLACE
or similar?

Also, at this point we're really close to:

   pub const NBITS_INPLACE: usize = CONFIG_NBITS_INPLACE;

   union BitmapRepr {
       bitmap: [usize, BITS_TO_LONGS(NBITS_INPLACE)]
       ptr: NonNull<usize>,
   }

That would be a very useful addition for some particular scenarios,
I believe. Even if you don't want to make it configurable, let's
keep this option in mind?

Thanks,
Yury

