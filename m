Return-Path: <linux-kernel+bounces-805189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24655B48512
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D453F175414
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C735E2E6CC3;
	Mon,  8 Sep 2025 07:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r9xwjT7z"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69C312CD96
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316322; cv=none; b=cc7auKiMa48OMEYAppSbxA7l9aFALuGU9YRM3ZnloSdfqvXTQTYYowSM8mDHnFbwbbxNTkUbsFN+gH5Gb9/H1T/Oz+qNV9NLnz9/D4f/LlMlXUcYeB4VgqINA7yZuyhqkoVUi8hy/WjvFXwOKzru0an3TaExM2HVlwwNP7uxuKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316322; c=relaxed/simple;
	bh=1IVGATHi8ejldjgYw5qdJGCDNzuEtKraxGHEpMm/5Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crXXF+cPHd9TokC3dpD7Esyw01emcbsj9mG+iNKHDCEALQ09tI8Ol9icASW8Il/9DJV87ULUj9GkRRjnzwQWD0VtsivmFqCnk3vyywz/iCbkVvAHoUMBGfoTgyRn8LkPhQ1gwOOAfzGR2e/tO0LDrpO9yQp62oDKps7DmTzvrxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r9xwjT7z; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-30ccea8a199so4208380fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757316320; x=1757921120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IVGATHi8ejldjgYw5qdJGCDNzuEtKraxGHEpMm/5Fo=;
        b=r9xwjT7zPmPsA1epiQSMnfKT5B77cTOz7WICEqu5H2NhQPtYG5q/aqLr761oeoKnPx
         JaYpEHTNgKMdCb/0rPGRGZCVh7glhuifYIadW1ipQ5ypccDhIxveeyFpGvZSc/tevg8I
         8/pmo/5EZQlNGve36ITQuJB8TwZiLm5MSsb1JejubeCT95x9tf6JeLVErrmAdVeFcKE+
         2WfcrCnAzbKFP5QKxwDigMuKLa7WJXeDI9SKfWV2kCRUcPAGLh2fE2f+6WjBPOED4ELu
         cVOpzOuykVRZy38MRbUuKiAsOuEa2KDCDbqMM2HAKq5RMrY53CTa69YAENuImaJOE8EY
         zg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757316320; x=1757921120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IVGATHi8ejldjgYw5qdJGCDNzuEtKraxGHEpMm/5Fo=;
        b=px8NuHqPbYqaRFreTlHjsuL5cahuP6T1eGOLCsbrXoBs/m1IMyG9vLRE9NQwMEO52L
         cyvQiA3byCobsNHcoCHuSFawBgl+JdEG3EyPWJPN4eI+dccZVh27LOm/SY21G9gPFVBN
         toehjaumgI1C1iRPt+6woZoHaQ/wzamjTYI+b0bT7oOmEaU/vnUz36JOECaWu8gSQveK
         PTq6FBtTh+Qdi9jsHc5vW5u5h+UUdEb9Xnx9To5ic+GiLgYH/hZOEIEJQRBSiB+XiiW9
         Vya5Nf+oybqSnRl0Cl72X8nd0rgliDB8VLUi1FjbevT3aq7UQlGFbOepOHzHeh5fB3El
         gizg==
X-Forwarded-Encrypted: i=1; AJvYcCUvYu/UcLdRqmiKq/M5I2lGzEuq4gYzPMDCqHENRSLaSLttdD+cCk+b6UTWz/P3yHZ33cifRbG5jZzIyWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz76VEE9n8FldvGBK5Sjj3uuJaIwMTGje68oBsxQ6gv64WTCBT7
	yraMCEaZsU6HvdvImVssxgjnvCP9x/YrR0Jwtk0U1fv7ACISaNXqMGlwScQiTzyD0gNS+oSnwu8
	4S+nzADCWjIJwdBgjqeOxScgbzKK+oC4RLRceaUoh
X-Gm-Gg: ASbGnctoJl3YlzaPyfsNI8EGEgjfj0g2QU574fawU1SZ3fpYRYwECkYh+LRb+1NpG5Z
	0md/NxBzGY2Ott9SHxa9yDcuZcPmhHkmiWaVaRuN0JFXiz3xM862s3dRgXd/QMykmlYRzh3nAKx
	4e8WuRZOqwD+kLogQEzbhFVlxSHcpGbdl/Jc+h3KAXKL6gffPKeVto2mlFWNoNwP4dDzU9RSlo3
	Mba35qkOnPBLjCLoyyMmiFT1yUGECSHrWmb+PBVgWap
X-Google-Smtp-Source: AGHT+IHQpBdJMEJ+JmOHbkWS+aib+qC1cfVixn71usVQJ5vQxFwQ+dWroGQHGkw6oU4SVtASUcAttDOK91o157dvalI=
X-Received: by 2002:a05:6870:f612:b0:31d:8ceb:20f2 with SMTP id
 586e51a60fabf-32265a151bdmr3669162fac.41.1757316319669; Mon, 08 Sep 2025
 00:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904165015.3791895-1-bqe@google.com> <aLnURXW_ZiX2iJd_@yury>
 <CANiq72==48=69hYiDo1321pCzgn_n1_jg=ez5UYXX91c+g5JVQ@mail.gmail.com>
 <aLv8buzrro0E5CCQ@stanley.mountain> <aLxE0AvP63nXxciG@yury>
In-Reply-To: <aLxE0AvP63nXxciG@yury>
From: Burak Emir <bqe@google.com>
Date: Mon, 8 Sep 2025 09:25:07 +0200
X-Gm-Features: Ac12FXzvzKoHSUS7LGxzAY_Gw-DtFhqrCtBPbDteMCWDf9T5ULK3dmuoUrk6gOQ
Message-ID: <CACQBu=WUYo-mYLRJDg1zQgihK06kAQAbaEoWXyd87UQy37awog@mail.gmail.com>
Subject: Re: [PATCH v15 0/5] rust: adds Bitmap API, ID pool and bindings
To: Yury Norov <yury.norov@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 4:27=E2=80=AFPM Yury Norov <yury.norov@gmail.com> wr=
ote:
>
> Alright, the testing is definitely failed. I'll drop the series and
> let Burak to send v16 with all fixes merged.

Sorry about this. Please find v16 here:
https://lore.kernel.org/rust-for-linux/20250908072158.1041611-1-bqe@google.=
com/T/#t

- Burak

