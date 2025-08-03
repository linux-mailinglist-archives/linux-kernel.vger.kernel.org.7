Return-Path: <linux-kernel+bounces-754523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B319B19560
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A03721893456
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5420102B;
	Sun,  3 Aug 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RMCEs8M2"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B935979
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754254405; cv=none; b=ir6UjiVOuFtkSOTQAR0h1NSlo91/0/ku150idDX8R70cNkYEbjzdNQipU+Xtdup+4WANboNJnq0CMkvQHcV4a/PUW8EHdQihdhjbF8f5LFGeKQbhcsp3kjkuWq6XjQiXB2HEEm7whGSxv+d4iK85Egv9RcXqiKgQPYo61mImDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754254405; c=relaxed/simple;
	bh=JY5x3SgVtiep2jP8UPpmtr06GtJ6WbHgPKYdAee2gXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ec6/jF8/FBXHkxK7v70tyo87C4CK4sBA4MWMvMjlflvUbwWAafTePOGOhNHQ+CmxXSJWGxPoiyaLyvkDHlSO5ijMBNGWq+FRoSnEuuB3I/4DvcyaVX4Dlu1iI5FFav+LX0aCxYB0RByHIqD2F55UPLBN3r59eOC22Kq0+svY9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RMCEs8M2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af958127df5so190514266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754254401; x=1754859201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9esa6sfZgyweLh1Ljo1EEi6nMuRSy+goaDjQDKyf7I8=;
        b=RMCEs8M2ik/FjPc1FZdhGmBTbmhSKTpFrV0bTP8NfR1uxl40wReABGXj+39p1yYSYI
         UzFkkqvujspmi8s0TpXkCLQ8QaNchWVbKdaCKeswF20H2Q7+cKN5C/So1PqRmGY4yLsz
         DJZWqxWQcE2sIREyzavtLqQYNrzwbfrOwDqlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754254401; x=1754859201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9esa6sfZgyweLh1Ljo1EEi6nMuRSy+goaDjQDKyf7I8=;
        b=tbVOZ09Rd4z5kK50iHi3czQJK35TFur/xE0J+6BCeR/VMIJTuoRvExjFW0OwZY5XiP
         HGgVUhSfsW051VMU+RoXNy18Sbph8qGd+KogY2+JOPdD88JLeuQ3FSHvfnvTj/95KiBe
         FbS+P6MQ3VyDbIXh9MLEKADtIqQPJRvNtCOCgn9NOr7dN3vDRXPWfbz15WUzGOG5ydpz
         Rm0wGEhZAgRdpryRF1xRElqH1p2pQNeQzQ8fSReA+7KipUbEU4g1/6off+jn86UeoNMC
         oJ67RoM4CPXZt2zjabcwHyBYPmruk0vnjcjCxZCGB7lKL6bhLOCnALmcLkZAFBh0JMKz
         OQZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJMEBs0s0HHmvvm31V5zB1iU/J0eRpuivDEzboBc2qX3eTJWSEedUWtD1fUEPINUUNMb+6CknyLnAe4ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8qUceJ/+U7lht0VHFPsbB5Lob0/pxudHDg2Ays5hLvQgvBhR
	/5k/1iMCJVSk59kWcdnr+JVyWma1drdwiDmopjbzFqnI2ld/xyI5fLHRhTM3mViiprXDNfjykB4
	8jE+7L7M=
X-Gm-Gg: ASbGncvuycy3k+MpczPy+Z8XI7EDAik4bTASs/94K4OQMRIEclzZFFj9uF9qDNGlSAA
	LwJAccZM1Gnt8SXlGheoUwVbbWlOwkCEVh8cOCwL05HpuHtb7gJ9s/ZufT5YMPuFoLjybwNnmYs
	pSQulBRewKKyDH19SCfu2FqXoIG9/6WxPQhssRU+MkmDrjr8bdNHEkd2v3+WUD/hMsGtI0FneJb
	40sJU83Z17ON1IHlGB3tBZdVyU0wwfXgKP/6y20rc7rku5gkZBYPGRFCGkY9Z6p8cCi6Z/kBcxc
	HCzYSlz0OOyCK0FBXOqWGp+UwAOQeQp7+1NMO/mGgJdfm5MHfmfOdb6kVLlyZ2i2O5C1JJ4ZZZw
	qSwlEEnaWxEm/49J/ji4szd0yjLwKS8E2WFio2XPIS4RABy6ulT/vjeLnv4UtuMN6rf2BdnU4
X-Google-Smtp-Source: AGHT+IFs9bdH+68LvmVHWeXe9zSkZTMOcffLwyyWvf9gbfWlG3fAzdqN/T5BDSho1vfKgrobXwZVUA==
X-Received: by 2002:a17:907:97c5:b0:af9:3773:8232 with SMTP id a640c23a62f3a-af94001e6eamr836319866b.18.1754254401294;
        Sun, 03 Aug 2025 13:53:21 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21e44csm623608666b.113.2025.08.03.13.53.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 13:53:20 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6156a162537so5367787a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 13:53:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfLuD8gZrlY8T0JiQDAdeXFxmncZhUVSv//sPMriUMUF9QVjCRsfTh6HuMFX5M1EDwPIVPdMgH33W8B0Y=@vger.kernel.org
X-Received: by 2002:a05:6402:278d:b0:615:59ea:f218 with SMTP id
 4fb4d7f45d1cf-615e6f09ef2mr6692426a12.8.1754254399833; Sun, 03 Aug 2025
 13:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802211316.875761-1-ojeda@kernel.org>
In-Reply-To: <20250802211316.875761-1-ojeda@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Aug 2025 13:53:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4SfHyQAunGwspwO5wngSQTHqeNZ7Fo1Wub5BkDso4yA@mail.gmail.com>
X-Gm-Features: Ac12FXzojhLEsGBw2wB7LU3rM7G257WjVgv2kKvwsEDAfjbTPYGQzu9bOiMxMLw
Message-ID: <CAHk-=wh4SfHyQAunGwspwO5wngSQTHqeNZ7Fo1Wub5BkDso4yA@mail.gmail.com>
Subject: Re: [GIT PULL] Rust for 6.17
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Aug 2025 at 14:16, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> There are a few conflicts, including a semantic one, but are all easy to
> apply. The resolutions in the latest linux-next are fine -- I also did a
> test merge with your state from a few hours ago:

Ok, apart from the semantic one that I entirely missed (until my build
failed and I checked your test merge), I got the same result as your
merge.

Well, apart from rust/helpers/helpers.c, in which the conflict was
from ordering things alphabetically, and then the new 'regulator.c'
file was out of order anyway, so I fixed that one too.

And I have to say, if this had come in one day later, I might not have
merged it at all. I'm about to fly away, and this was the kind of
somewhat complex infrastructure thing that I *really* would want to
see early, and not in the second week.

             Linus

