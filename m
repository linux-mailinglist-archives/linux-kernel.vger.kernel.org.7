Return-Path: <linux-kernel+bounces-786752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C71DB367FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520738E1951
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3BD2F0671;
	Tue, 26 Aug 2025 13:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGCQsClm"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54446350D54
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216697; cv=none; b=ZBdnzQTP1IFvWFqfwJKmqDbsGH1cYML6LO1J3Mm79smuIjiYOj15eY+RlRYuAEYq52mhp4jCXikWGn9IYvDaKd/sWV3E1G5cM1OFHU5yRhXzAvQs2M4Rg2oaIsSVoXUv3FaF8c+TaUf6XFe4SFaINWUssRvqr/A+zfhBdKFwrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216697; c=relaxed/simple;
	bh=F/fAPnfHxUemRrZHN9zWvSIFmtxgD0s1aIaOJ66WCvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLoVMTUEMToU2q63UVs1IMplsQX0B9SaRElu59t40yNZMwjpQKLrSfip/h2gEBI+sR5K/AtWmpJ847CC8vh8QPEGl/MQJgD5GMIdXd4Kb5N7iRYNrcS7JR6fVnPGg+tEh6N3x4oPqOm4SGATG0ZNyP21OtEd4iztR9Ga/GIdsZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGCQsClm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3cbb0df3981so339215f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756216693; x=1756821493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/fAPnfHxUemRrZHN9zWvSIFmtxgD0s1aIaOJ66WCvQ=;
        b=RGCQsClmP4mM9OBBB9U3mt19EDLwls+80WqGnM/+Qv7ZiKe1Lq1+k4yIXNvMs8QTIx
         lO2h4hpiUhkIbhihjizj1YJshZTei2xQoysWMtAsJPyXZP0vF5kCXQULc+BLbeFjikeM
         a1YGGJy3kKrMJC5DzzerJEcqMAIY+QXItMkYdla35XfVpt587pbewhj6iasRAFPJt5KP
         353bac/ZRNiwEXaCX3aIUHV0nZgFGHSCZwYM1pXqH7dYNzCGKihNEhAgZHlgSe69Xvm+
         fj9cg+rD6AQFyqX8TWgORZIj40EB0Vq++FoE9FvrQKadbicvs0V9CI8p0QGV1CaIuQIp
         1DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216693; x=1756821493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/fAPnfHxUemRrZHN9zWvSIFmtxgD0s1aIaOJ66WCvQ=;
        b=chpDN6KZli5K1EP5isnskV7yBEe3x891vFhBFeazxTwzQ2cYo0xvI5t7jWCTzdvYK/
         5bsmc7qR1gT/6PWz89kUqOGWZE2tj0HBOsrgby1tSc7GyVQB5fen5MtTGw4to7CaTUHo
         NMtBq3mmUl9Pvy6TwGx8P2RyaNlPTuuhYh4wKeUxpa0ZXROcXIvSgDxZA+63TTnT0MD3
         4Ay8TN4F3K6r6/T1L6HHHFtxmnr7c7QXnYLr6I1vP3G2KE3Q9+7MAM6vpp/LtK2lSZxC
         FQk8lW/BQneJDu7oT4bkjszXWYC7cMiUJXUvmR3H/7M3ahaLat5pNkveMqaqNLWiIbXm
         u4iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNvuyzh79MEufhH2FX8DqsMrc3GLheTKVMVOrdap1lk+eWZ4Tnnrq0v8gbzu3hm1Qgbd6SNEQUYVNnLoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX818lU3zKfozzXsATlrY5uJiQy0D02Z2DwPgo7oJpZ/ZL9imE
	3mHbbGfGXWkpVP7Yf36EYEf+iwXwFLNp6b9e7KetL0Bsva30w/X0CQ5fO6T/V0AX6mCix8xAyj4
	O2w/FpqO+Jbuq1k8WFuLIUm7GLY2wSJNOcdqVRvTu
X-Gm-Gg: ASbGncuJ7kRxnJ3fyBfv9gK5AeDmjs6Ygztp48JnJlxSCzMpCiM0Iusj2oNcbvlgt/c
	vxayR9f0+BOe5eLNY0HciOa4cG3EHobtAXVcOJI9G0Pp91MUj+b+56SruDtOW7LBXSzbDBV2Vxc
	ZBVvhEomwgKhYvES6t2ThrgVLC1aDZfDqhHNqbiu3BSBeiq5/JrxFGYm3lJC8o5oNrJjFIG6zvB
	s8copJay3eUjmpsfo5zihauf2ZivQGhsEvRxhNZozSh/vhUbr3Mmy5EdSnGgY7+CTz2w/2k+DE=
X-Google-Smtp-Source: AGHT+IHRgvzTO5clOrALiSfYSq6INd4bC5T/yqjf+veSVOxDpuDbA4FBiVt0kYdgDa/qqkni21+SFeOOi9dYSd3GzS8=
X-Received: by 2002:a5d:64ec:0:b0:3a6:d95e:f38c with SMTP id
 ffacd0b85a97d-3c5dd8aa9e5mr11922498f8f.33.1756216693355; Tue, 26 Aug 2025
 06:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813153548.1650533-1-bqe@google.com> <aJ2Y21Yjs3a0CnAo@google.com>
 <aJ4Y_DAZe__0EWEm@yury>
In-Reply-To: <aJ4Y_DAZe__0EWEm@yury>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 26 Aug 2025 15:58:01 +0200
X-Gm-Features: Ac12FXxekRc_zLGFS3Qk-92ThB02sZE2hj5xq7cHAtlXq8wdo0Ut_NCfgzEs07k
Message-ID: <CAH5fLgid9fF2fb06No9zmeQfru_nQicaM_9bb+DWe3zsOwm_cA@mail.gmail.com>
Subject: Re: [PATCH v14 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>
Cc: Burak Emir <bqe@google.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Carlos LLama <cmllamas@google.com>, Pekka Ristola <pekkarr@protonmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 7:12=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> > Thanks a lot for doing this, Burak! I gave it a spin locally on
> > v6.17-rc1, and it seems to work.
>
> Does this mean Tested-by?

Just to confirm, is the plan that you will pick this up through your tree?

Alice

