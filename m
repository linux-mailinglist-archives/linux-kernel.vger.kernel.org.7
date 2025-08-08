Return-Path: <linux-kernel+bounces-759788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD8B1E292
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0B418C30A0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924221E082;
	Fri,  8 Aug 2025 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="LiKydgnT"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098A14885D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754636190; cv=none; b=dwAqg9GEOEYusQ3jCg/dveC6xSyFyGdd+f8mCP5eKmIpiaBjBuwcpbg4YwZsol404EwJ+Y2WhfG2QihoAEzDZ/b3Q1Lbeq7+bxdY4l6lKUprSsG6LJE30/LRVtyFz/YC/wTBprTfuM154jnT6DRJ5JsG2Wl7mbMLAmYpjc3e61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754636190; c=relaxed/simple;
	bh=WsMFsX9rI/MR4482dUjWIW9KG1CwbzogAuN1PmMV95U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC7coqhg8D//cHmVfn6sXlrFEe80OY3DNFMC6sRH7hRTJoAgQnhEqPrt6UgCHJjLQThsXg3uiG+yX/WCfn/PxSNYsCCCcFjWWkMRv6vQgi6WsZeiHEEeyIgcEelMArICU0mDLvuOBdyQZ9H5FxT98zkG2jwhHd6SBVcNHpw0sKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=LiKydgnT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1761675b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 23:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1754636189; x=1755240989; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EhfcZbysLPTN6Dd84Mx3cVIHOXMMLtVJ6fpljAwuNzE=;
        b=LiKydgnTx3QDtkx+siqOcq6MTmjCYhVHb7Ke7Y5KffEBajDbgW3VyZD4NnPgaXd19l
         /vcZof/+AdoAvekR7919IjcXVzN50/vtNEoeMVcvH0f3j5TZ6zYWW6P9Bh4SXcq0vFs0
         YvwZeEy9lehSGsQeGfKklUTE3/MS4N7DqsN9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754636189; x=1755240989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhfcZbysLPTN6Dd84Mx3cVIHOXMMLtVJ6fpljAwuNzE=;
        b=ffmHUYWJIGeKcm2GeRFknPn14wrv4Qpn+E9dPlWtlLB2J9bDCQzufVGfSYvI9Fo3wu
         /aUWidJU3FNStTCK+dhn5YJgSN9U0UamvpVzoLXQJ9moPwIsnKewL4Fkz374ejlWqGm+
         tn5mJ5KiP17SrfB46Rir9jP0j0r2A2Y8JfM3txTySgSvWo+IMPFVXzFqMl7ngXoguNwl
         gw6uCPHQDv4LFY0Os5Jlu5/k2/qgPY4bnZY/HFrFTCbtKQjvbonXYWDLMxVAYVqUPPcU
         VR2bhwMIPOGzXgUPnaMLD2iwk9jcgxjBDfgANyDfl34ySX3unUnxvCLhUn6vuJ1+ybiG
         swpA==
X-Forwarded-Encrypted: i=1; AJvYcCWpjbI9VEFOFnQn0wD9nxSneWXMn7K1BMJXG3O4tizywzpO5BVTnG36CTxIL2Tb7f0aXuljGeChxPwSIq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVuYraRPn+y8NAOlxCrI7crshMSxJo1u3pMYGZ9bnqnoxMrz95
	/mVEeno+vSoK50UjbF97x3eyqQqwQQTbNrbCp49jaTUnYnQuutTvGIqN/ZulLKdoz0k=
X-Gm-Gg: ASbGncu8eqAz9Gzhwm03dx09tEFwcZfRfEB0PtD7q7n4hpSt8hFmDqhwzRszhEtny/d
	kIClzkkrLaTQeZBwBdRQ3JPg52CVeIub4SZmeL1tiAknZUbpjvz4lo5T8fjYKpOOuXevOhqeeh8
	aRFaWbISWlFdXuXR9xR1WqYtt37tTUetb/2GqWXYRWnGCUObt08W6mFmwoH0iP3TNsRJy7q33nw
	qa3cxZM/eyt+AjDUdhCcvIIafZCVYG0r60AIA4kxG71y0IeT1Ewq7M9bNratpvXsVn9YiAFI4KV
	5mkEsv9ikLBfdEn6VwRmA0GoB8HeeZ88Qua9ugKBrk7FZHdKIltQpEJHE/5VgnWrfT1Osm9Oqhn
	c5+vD0+RdaDp7rtwOIKAYhtc/WDEu8xU5WFjb0G4+LAVDXJbIRCqTEBuD9GsvVw==
X-Google-Smtp-Source: AGHT+IE3hAqzLrTBhTY5Ya+9CrhJfIsOJHOrILP0ExPfcok2Clc4Gt9jHoPD5aDn4VtBNA+4A8gs8A==
X-Received: by 2002:a05:6a00:230b:b0:740:afda:a742 with SMTP id d2e1a72fcca58-76c45fccf09mr2710386b3a.0.1754636188680;
        Thu, 07 Aug 2025 23:56:28 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c2ea6893csm5448866b3a.104.2025.08.07.23.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 23:56:28 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:56:23 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Benno Lossin <lossin@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] rust: io_uring: introduce rust abstraction
 for io-uring cmd
Message-ID: <aJWfl87T3wehIviV@sidongui-MacBookPro.local>
References: <20250727150329.27433-1-sidong.yang@furiosa.ai>
 <20250727150329.27433-3-sidong.yang@furiosa.ai>
 <D6CDE1A5-879F-49B1-9E10-2998D04B678F@collabora.com>
 <DBRVVTJ5LDV2.2NHTJ4S490N8@kernel.org>
 <949A27C5-1535-48D1-BE7E-F7E366A49A52@collabora.com>
 <DBVDWWHX8UY7.TG5OHXBZM2OX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DBVDWWHX8UY7.TG5OHXBZM2OX@kernel.org>

On Wed, Aug 06, 2025 at 03:38:24PM +0200, Benno Lossin wrote:
> On Wed Aug 6, 2025 at 2:38 PM CEST, Daniel Almeida wrote:
> > Hi Benno,
> >
> >> On 2 Aug 2025, at 07:52, Benno Lossin <lossin@kernel.org> wrote:
> >> 
> >> On Fri Aug 1, 2025 at 3:48 PM CEST, Daniel Almeida wrote:
> >>>> On 27 Jul 2025, at 12:03, Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >>>> +    #[inline]
> >>>> +    pub fn pdu(&mut self) -> &mut MaybeUninit<[u8; 32]> {
> >>> 
> >>> Why MaybeUninit? Also, this is a question for others, but I don´t think
> >>> that `u8`s can ever be uninitialized as all byte values are valid for `u8`.
> >> 
> >> `u8` can be uninitialized. Uninitialized doesn't just mean "can take any
> >> bit pattern", but also "is known to the compiler as being
> >> uninitialized". The docs of `MaybeUninit` explain it like this:
> >> 
> >>    Moreover, uninitialized memory is special in that it does not have a
> >>    fixed value ("fixed" meaning "it won´t change without being written
> >>    to"). Reading the same uninitialized byte multiple times can give
> >>    different results.
> >> 
> >> But the return type probably should be `&mut [MaybeUninit<u8>; 32]`
> >> instead.
> >
> >
> > Right, but I guess the question then is why would we ever need to use
> > MaybeUninit here anyways.
> >
> > It's a reference to a C array. Just treat that as initialized.
> 
> AFAIK C uninitialized memory also is considered uninitialized in Rust.
> So if this array is not properly initialized on the C side, this would
> be the correct type. If it is initialized, then just use `&mut [u8; 32]`.

pdu field is memory chunk for driver can use it freely. The driver usually
saves a private data and read or modify it on the other context. using
just `&mut [u8;32]` would be simple and easy to use.

> 
> ---
> Cheers,
> Benno

