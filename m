Return-Path: <linux-kernel+bounces-806549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C418FB4984F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAA697B3FD6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB2B31B11B;
	Mon,  8 Sep 2025 18:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtBtKmaC"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B2B3164B7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757356232; cv=none; b=bBWDONq4fFCW7n/cRtFNXmV5leAqpAJ6tjcGyuX5VnCjRNZX4bpItUyPVmK2+qKV4l4H7vtndHXpvdafuTBCW93IxE3NL/1Vk5IcLHe6sLKVqeCDygJbAFB40sN4h/Yib7p73Pt5SixhgM+0J0eebioDaU0/QvuqCLkyk1VgHOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757356232; c=relaxed/simple;
	bh=jUG/qTOwcqt3yC9mUtQIEdDFh7q46RZ3EeLs17fAC5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqKtx+DhWkjsNoAWsxrk49ATxUFQsfdE5rUbudir+f6bDuniZTudRKA0im3DdiEp9j/uP9TS6iXV3LfSdhn0Jxt/nvFRc/EaA81mri0MrdyIfwhzO6pekreYNQHwNp2l47S0uGwu7tPyGl4Sx28os3WAMe3QdQspIylSsNNbMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtBtKmaC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-324e2c12f43so397448a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757356230; x=1757961030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUG/qTOwcqt3yC9mUtQIEdDFh7q46RZ3EeLs17fAC5k=;
        b=OtBtKmaCqeWVEvVpgPYnI9n83LiOriysMJ8+FGacHt9BTPkbeWCqtPOGl86Ei24t1U
         LL2evB8CUeU+FKFssj2dHT7f39eEwkVoIyEtXTsTgnxLGCYpeZBww6k2UTNmKqdq8TGZ
         obOYiq3BAeJTT+W6OLCf9Vw2ZgdnXw7jpQG/MGDvkzInwv8mMOX9u5ly1FD/u73oKECj
         3wCpsbxzHndAuq4RIKluL+4I3HQUTvAusHqk1NuN+c4HShxvki3tjDpKioGATkwbRjpE
         gy73lI+7+yFABXXA7p8A679KZJFuPUHP6WX24HGSybIgIRF8LVKgoa74yP4c+uQd0Ayt
         sOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757356230; x=1757961030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUG/qTOwcqt3yC9mUtQIEdDFh7q46RZ3EeLs17fAC5k=;
        b=G6OFKoT/mkOWI3RPJ3RVC93o4SAL6aPSby4tEvrZyuoZbeFg1yGRanGPYrWtJ6cl0c
         KUCt2QrjD48D1dMLt198iLDTRILzWJQSNqMCWBESZekMTNF3NV4qOOiUEKFGnE2i4QXt
         0HRF5hdKzK3Ejtu8j6+bgWjDcqYUoB84D3rf5L0DFqBozBxFif5+X9vFzvHoOEatj4OB
         HfR03ozFGg1sYbrm0C0bnWONH1hZ1eJ9LM6y4fnKm/ysvapMYkawsqO04FCUTk9zifEb
         mczFC41badZYg8okCqytVLtScxrbNu/ckyPP4UXzDZqHfTTgOc8QrU0eOwFYMOI/qGb2
         klmA==
X-Forwarded-Encrypted: i=1; AJvYcCXH2PW8n+dNCMiIKhQpPjX0nTz5oz7xN/x6QZTxUt3qZ2dIGIN2YtfJ7MxHSptd2ZNjvQYTwvF1YoE5z+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvov7p9SGa7EJgjMhOIjXa1EX5HFGWMufSGsqvrycTGon9Nxt1
	U2mHL5kE3Kwfa+peetNjnk6U0OnCBguftx589ZdjIUS6xdBmrLZ7BJ7JSBImGWM97m9i2mJeE8B
	gpwhpQFGS6C/J9sPISlQrBXIYnC1LclA=
X-Gm-Gg: ASbGnctAI9dC98yPMbAkMW9DgXHb53BgX99KC9N9JsKIPm5Ax6nW+0hS20Z5d+ocq3M
	REUmj7xV+//ytu5b9qNWjeZOfdC/4X+F5jL/IFXyhgPJZAU2Hv+z2r1pLdeVVZLlEObXHNQXcAA
	gGakN4rTZj5RU2dOIHCAvsF1K+/yOk0rZR+aY2+kA5wEPm+Eswwb4aPpLVvW0neV2tiDQE7mIhQ
	XcEqFAd+DfpnSRqfvkjSOB/lUVQJo3UAS3Z5ZSEAErDK05rYnvsX0uI3cuFXJKQ9z6rgJiTWqF0
	G95kSHwk6TVPBzbeJ2z+nk986A==
X-Google-Smtp-Source: AGHT+IFYFAtkKVHfkI4g4kFkE1d40Em0cg1+x+GlQODl/28udoQL+FMvsGsvmxW5ZnvLdbzyKFAliPqQrsvAqRpvrZQ=
X-Received: by 2002:a17:90b:38cb:b0:32c:e048:35a6 with SMTP id
 98e67ed59e1d1-32d43f126f8mr6361297a91.1.1757356230052; Mon, 08 Sep 2025
 11:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908125339.3313777-1-vitaly.wool@konsulko.se>
 <CANiq72mekzqaNak+KYxqzxOeKpmNDYPO2bvATw6FkOjHWO1w0w@mail.gmail.com> <99eff662-417c-4adb-b7dc-7f3053a4d616@konsulko.se>
In-Reply-To: <99eff662-417c-4adb-b7dc-7f3053a4d616@konsulko.se>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 20:30:17 +0200
X-Gm-Features: AS18NWBUf3xKIGqgJxhuSkY88RUo_0-BQw4wkowd6tsSsYMjrpMlu-w9nDmqDfc
Message-ID: <CANiq72m480giNVxfsvjGRt1y8RLuPpO-52Z-6xEHrrF-9amGiA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: rbtree: add immutable cursor
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:41=E2=80=AFPM Vitaly Wool <vitaly.wool@konsulko.se=
> wrote:
>
> Absolutely, I wonder though if I'm supposed to do that only for the code
> I'm adding, or for the whole file, and if the latter is the preferred
> way, if that should be arranged as a 1st patch in a 2 patch series. What
> would you recommend?

Only for the added ones is fine, so no worries. For the older ones,
please feel free to leave a review in the old patch (and/or check if
it needs a rebase or similar).

Thanks a lot!

Cheers,
Miguel

