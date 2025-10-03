Return-Path: <linux-kernel+bounces-841861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC572BB86BB
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FD594EF132
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAA2737FC;
	Fri,  3 Oct 2025 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DdjeKQuY"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C719DFA2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759534579; cv=none; b=bdps3MkvnlVKPmspCxoJlV6iVpnTQ8t73hfYHvr0ethlivYSa0M64s4/JD9UK6Wrb0w57GB19/zx4nRVAQ2+zZYLibJw0czzX6V+0Jce9syO0sQB55gL0IrNb9a5F/wNrNZvATGYZRTHWYCYhPuIn5oYbhC+sN4wi5rZTMHJEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759534579; c=relaxed/simple;
	bh=Gbof0DN7JF5p105jMZVnBGv2h+BjlLOUNDm0BMgxVr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hKxwV7J2BR3KYly4oDEip/PQmLW4DaHCgVDIHmL7BVmmqPQRhtMV9UmXoKzaJ03GUBhLcqZHRPzP40jk4Zj0xiwzPISr1IsTwMttWA4yhRK3179fOfinHgftHWFRuFowLJKg+V9FNFCmeAZLaGPK8TQi8GDbcdSK21uRitW5oqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DdjeKQuY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so5259a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759534576; x=1760139376; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8xlz79RMNPM4u+3ojQF5w7+rAjiGlNcGaeeLKf0ALHE=;
        b=DdjeKQuYepQYrGP0UxMAk+UPOT1xxEblPxGwHVLWlAZ0elM0tKLdXjopX1e//mZ+vk
         mopsstIwYAvfIfhS6AQcvd7Er5MoQKheKX09/AZf0WS4FfwdoW31qiSL6DyJWtnvJOqh
         VeQId1/x6sTmgYqI8wgLqmEjvbQdisntBHVruNWKRvxKq4VzfmlKblvyOwG6h2qeyG3g
         IO06po2Q+6cL/q4wB5AigOOLrUsvkNlIOmOzCnILhdt4BlJndqVSoMg0O+qsGuPEdyoZ
         86WkrDFsPqaTmlIYJBZolpMM5A53ImPq7HHZVb/C5UkSiiJbdyTm2hEfyqUFYCuSZiVO
         HFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759534576; x=1760139376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xlz79RMNPM4u+3ojQF5w7+rAjiGlNcGaeeLKf0ALHE=;
        b=gFbd5CR2ljP3mp6FOhbqbb8TtPLk5dTeUae6meSy7rflEFgOOko1/dMbNraa94fvu+
         2mSDavXphDZoWdgbCMqTipr3T1Wckon0xFuSqxAzgpQSqccPvtt2EGiyRUL+G9wl/vAb
         4cilEkmINqHZebdkN/7YmvY2v33YG1Qw1/A35XvoDWbSUdVsQbKB5gWm1WWB1/4sQp0l
         L9tcZUkxLMNixcy0ipeeI25CWnQ2vFrUfxijs6Rh0wZ3hbFdo1twWTp/sAY6oC6LfKER
         +M+hIItWmQIsQtTYKZKnGDewEU0ZLkPj7nNB12I+NVj0QWc7Xdsrz3p7ukyf5l8Pp9Gb
         3Bqg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8UZS2ePIrDeteyoiW0myD19FiM/v9Qr6VBrrL/ZpnHX8wB5OuAaoDbk0+xn44S/KYAdny4z9vGA39I0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMX9alIjaUD+Wf0zVoSu7u93JP0nKM2bmldU1UwHLsYUlXWzma
	V5uU/YgsWvXf/1kTn5/vaKoXJJttleZFR800MEiSxamszFryG4qj2aKLgcTwYFpPHq5ITmKDonG
	eOBiiPhoRSZ9d99F6q5B5UX8VwzLvxdRYhtwIHmEL
X-Gm-Gg: ASbGncveBy1CZ28k5ie2rQCyRejrbRwI+slRNr/QCoM2ey29vcmbO8ZttYmAAdev5W6
	5PLoFtW44XOnBw9ZGDhNhByTF6F9pyz6AqBwNWed3E+2pG0oW8mKISRjJoXYX13M4sD47hqJUej
	x6p05XtNgcOC1SPHynf30044nIY1cr9LrrAn/Mbav+OpTWTsjzVRqV3CHX59UEdwaQLbqX12tGj
	skxTA8mn4xEdr4aO95mV3EqxVTxEf7clFwgS859FXGGrfXrB72aTQUQxZIlo6B8nm2Oc2mmqcnw
	Nw==
X-Google-Smtp-Source: AGHT+IG9l/axkIR8NnMwZTrEmZ+43uvm/E3ERF/DwpGH3AQfrbOVJvfA0No74R6/aDWs9Nt5pgQhX7avAJQ3GJg5i3k=
X-Received: by 2002:a50:bb41:0:b0:62f:a20d:5a92 with SMTP id
 4fb4d7f45d1cf-63962ef1d42mr45430a12.4.1759534575811; Fri, 03 Oct 2025
 16:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003222729.322059-1-dakr@kernel.org> <20251003222729.322059-5-dakr@kernel.org>
 <CAGSQo02ASwf3Wn21jgB804LMLi3qivhtZuo7SmmD9O4m5O_Qfw@mail.gmail.com> <DD92QHU14T9S.14AE7Z1UWJ6ZT@kernel.org>
In-Reply-To: <DD92QHU14T9S.14AE7Z1UWJ6ZT@kernel.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Fri, 3 Oct 2025 16:36:04 -0700
X-Gm-Features: AS18NWA9Hl7HhL1dvCIncsYxz81lkFTamM-h0jDFaN4h87Gn9FqfvNmTJly51Wo
Message-ID: <CAGSQo01ssCYA2vxkbDmEnoSegH5ks_V=07LC3yE2Zp4eFDXiFw@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: debugfs: support blobs from smart pointers
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I think this way around is not compatible with scoped API.
>
I thought you'd just be able to deref inside the callback, but perhaps
I'm wrong. I'll try to find a chance to pull down the patch and check.

> >> +// Delegate for `Vec<T, A>`: Support a `Vec<T, A>` with an outer lock.
> >> +impl<T, A> BinaryReaderMut for Vec<T, A>
> >> +where
> >> +    T: AsBytes + FromBytes,
> >> +    A: Allocator,
> >> +{
> >> +    fn read_from_slice_mut(
> >> +        &mut self,
> >> +        reader: &mut UserSliceReader,
> >> +        offset: usize,
> >> +    ) -> Result<usize> {
> >> +        let slice = self.as_mut_slice();
> >> +
> >
> > Nit: This is safe, but it also requires `FromBytes`, and is &mut, &mut
>
> It already requires T: AsBytes + FromBytes above. Or do you mean something else?

I mean the safety comment. Your code is right, the comment needs to be updated.

