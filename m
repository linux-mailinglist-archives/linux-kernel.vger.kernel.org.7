Return-Path: <linux-kernel+bounces-851026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBCFBD551B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E506D545073
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB02272801;
	Mon, 13 Oct 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/UdoII1"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C5424A06A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373159; cv=none; b=otRVct7cVXkDKnCn/Stc/8jU923RzibCR/a1gePFfS6IpX06/8qSH+5U/pZ7tjC6UA+CogDt7+fPQJSQuis5EEn4Fn0/+SvbpD/MBoXBbz+/AOKFwsXIzqMHhZnMX92TN+EWWzOD0epSknblLFKKggUIu3gRIwQKGGuWebzaISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373159; c=relaxed/simple;
	bh=8PEbt7/KiisZENpthYaEwPRP3ny6x+ce9ThxH5LQ09A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQG8pJd9RXQ1OxZ6KB8SLYLKklC/2VRgyLKfZn+7OTQQpb/cen4qoqbQ3ixvlCI+HmGsF6uk58lJk8G7mAUPHYTBjiW28734PKFTR/6tLIPweoaUpk8mkzdAVm1/6Hsbxr7VWCy+NSXJ2smYwK9fYoP6lq+K2MfF+teddkptdkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/UdoII1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28d18e933a9so9148445ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760373157; x=1760977957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhkE2kxttgjbOmTglGY3wFhQ7XB/INVjgyXJP2fCnrU=;
        b=A/UdoII1weJXtH40r0xBqkXt4/ChtPyWccPix7as/CZCDCwH6q6qe7myR5boIWx8f/
         UMuVW5MfBQlIgNjwwmkgd4A7l6F9K+4CGCx7kh4MpHAl4L33mAIzM6FRN3kKBPJ83h++
         m32b1hvVcAlRHlGkJ9IN1UFXfX3+5PIZpZ+m9HPm8RRsQOzqnBBvCIOh0Z/7pCoGh1fP
         1V4Nht43Y1iMN984DFp0bR07m/0F2Ne+l+tkWYnf9x5JTD9GPrl4ZPK+r9d+0bGSQCr9
         7+StuPswGN123ua6pa6UkJdcYXZd5ZplfwO9JnHQyJj84ix4oj3jmIg8AceSuVJ9D9wd
         UISA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760373157; x=1760977957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhkE2kxttgjbOmTglGY3wFhQ7XB/INVjgyXJP2fCnrU=;
        b=aNDgAnQezjdd4nyf0zhPH9O0op3PsD1Rom7X0E3DUhbrZ2SZjXYCEhGSx0uGrjHXb2
         vgut/Ja7FebBIkqW6IHpcoJ74XTx9Jsavwvs8NqfzZbCODfffSuWr6impBOCYwL+ODNG
         J4BQF5ek+74jVbt3HQOhtKUaEkJlJN5DEP887rr4TUDqgEQE7hWPzpDgECbY5b+Fms5S
         IzhLIdu7AYctn6P72zTuC5IZ4XYlO5bes/yBsb3DsJpSVpCj2A2Y56zLnCL28BFLYU8u
         2KjMuIFpvlHMXAyxVkcjPpNf663fBwKZI1fhZmLIIpkhRH+czk1q9E7Tpd0UNd7xznXW
         U5tA==
X-Forwarded-Encrypted: i=1; AJvYcCUoy0WR+G/+7Vuo6dkYL3Z/OBC73oh/gif3VFvZIeXp0x0v1Y7bNVHKVp10Y57xvcNvQBtpi5LaTi/YKmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL4Q4rHBUNSt5BwOdQI4R8nvZM3XbbMDol+SMEMFyRydDPEEvO
	SRv9zcipO8z4Ocj3/1/k4tX3BF5lHBRHhBTNqfCxhfa7oPnvDUt+dSRr08AQaCUs83bm2dI/wag
	mXYlmvQNx0/2XQKuFnGG+IVbPoIJ+YV8=
X-Gm-Gg: ASbGncsJf1xDXkJnMwNXkjFTntnICgGJ/iBPVizB9KskFM3IX/M7VM06mjPbiahJ5UL
	VcZY6L8OOqX34vOr+60exHjxn5sQQgXhm6ki+LL7Mj9L53OThogU1hDK/GNkkfDBxekCY1GCNkK
	+uKTgjGQgh0g9GW9CEtUsugF85eisglOwRb5uH44MZ+mc7Y2yS5STMHKDcI0jnsTMZ1xEGqomn5
	EajAAroX6LQdu0Th64kRtiS2YlGtarX0XjOLZVcG36YqhYHalUIX3AModHB7Ns2O7vSiymHt+np
	MK9/OFBABl8r+NOCVPBKZbf7ILtiPkGWczqnJCEz3WmfsLu27yCb0+8=
X-Google-Smtp-Source: AGHT+IFL/ZfJ4cj1Fo21vdtAWa72Ot3BxKQ8+vXwbOeeF2ANwjBEWGV/ZPwLInyjcxfIhg/pREwZw5L55MhN3eCJYLQ=
X-Received: by 2002:a17:903:110c:b0:272:2bf1:6a1f with SMTP id
 d9443c01a7336-290272667a9mr157087805ad.4.1760373156695; Mon, 13 Oct 2025
 09:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013155205.2004838-1-lyude@redhat.com> <20251013155205.2004838-2-lyude@redhat.com>
 <04dc4834d38932242df86773e47030e8105461c9.camel@redhat.com>
In-Reply-To: <04dc4834d38932242df86773e47030e8105461c9.camel@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 13 Oct 2025 18:32:24 +0200
X-Gm-Features: AS18NWDyh_CiI5BROIDxIAOTwe9IjcgjNOybhNZ0YtVxcSx0Nj5WUlyw0Qb3tYk
Message-ID: <CANiq72kkC+aieH-SqqGwX2iA6wZEJcysLui0JWxAmo75RZ5fiA@mail.gmail.com>
Subject: Re: [PATCH v13 01/17] preempt: Track NMI nesting to separate per-CPU counter
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Ryo Takakura <ryotkkr98@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 6:19=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrote=
:
>
> JFYI - This hunk shouldn't be here, it looks like there was probably a ru=
st
> formatting issue somewhere else in the kernel tree,

Yeah, one is the one that Linus kept in the tree for the merge
conflicts discussion, while the other was probably not intentional
(i.e. simply manually formatted) -- context and fixes in this series:

    https://lore.kernel.org/rust-for-linux/20251010174351.948650-2-ojeda@ke=
rnel.org/

So, no worries, I guess it is to be expected given the tree has always
been `rustfmt` clean.

I hope that helps.

Cheers,
Miguel

