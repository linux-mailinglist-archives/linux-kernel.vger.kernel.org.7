Return-Path: <linux-kernel+bounces-863086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A192BF6F78
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E54319A79BE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3334923E334;
	Tue, 21 Oct 2025 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gXe3rnJ3"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE533A039
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761055521; cv=none; b=J2SxWq1AYc2SaDFYzNXT1F29PthIPzzOcuUYUkYmyUxTBsjeVbiEoI8XYSJZ4wcWAKQy4Py9Vf5QtHRvlub2KKNbxQ1/nhn04sYUUMCrDNPfDq23MX68IpSgFGoJpIgO/ms8g9wD31ow/DrErqCslEG2DWW5uX7eEZ30lbIFRrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761055521; c=relaxed/simple;
	bh=mq8McGPYiW874B2f+zFkcUVzTQ9LMatQN7FZ2wBtMl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=igvRlN4o96N8zly/lCLqLBQySzgKhMJj74peDsf2eZWvJYWjS7y6L2BcbVkm43dTpNJY7dXfJtq90y0v7P1UboUBYOGgbl0Lhlsnk+eFbscsxu+4MKyEDN4tXFwoRMcsUF2V7b1RjMSfKWmqB6ra8srRRzdWAdVcFyCad6R5SB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gXe3rnJ3; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3c94deb7c7cso3026304fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761055516; x=1761660316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mq8McGPYiW874B2f+zFkcUVzTQ9LMatQN7FZ2wBtMl4=;
        b=gXe3rnJ3KHSvITc0SDt4dw0qkK/gFOZVqleHsC2Om5ZU8gyRNKgCYsj77XIZ4aSc6o
         a0+i91UtdyYib2xbNwVrKq4kkSkX2yagfSPUZ9hiinkr9G8J8gw+dBiguYRZ8JsDUYyQ
         nZtZPwY5Ik9CFIYd8AAzEWBVDef2haR6AH/gW9S2AyaxdcEbPd2b9aOdfx9X8OhKp6c2
         8/VHL4f1+uH6UAKAWdchcNqAc2hQhox9CVer7C04OvJjCjKfYVzqS02v0HUY1CY/7DCU
         rjiez0KaaIsYvoOzMySJnxMoxfXFbCJIEAW6V5wRAPoy4NAx5WCakb1RJFbwsTwZuQ6L
         aeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761055516; x=1761660316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mq8McGPYiW874B2f+zFkcUVzTQ9LMatQN7FZ2wBtMl4=;
        b=wQWAuIfnuoLac0EDuGybcr/s18FrsshCUWdEYF0pplm+68AhPM7zDtiL+iOnMib0uz
         mjTEvNcJc8JgzwXQOS/djfm2VbM4KuCQ248+jDnTfLs/1f8qaN8H4rK5Xg2hfZgnSHLD
         EJH2SFWeADFYLj3MtmR3yWg11WIdeE3zHeiIHPd5iiqLdYF6F5WrVVVQRumpoN9milpz
         eSBD/tBQwhxtVvZN3NN+aGpqmQWZTl0T5Wr0lCzExGEIlMFnfE7gycL7/b/owR4ec6yu
         0F3cLLPBcknb8k3JCjUtjcKF1P7X8nnksxoShYKq4XxfDMH9yo7vAWVW6vHJAz55HccJ
         OluQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw0RLkJ+MVi6RT9h7EhuqdZHPKNGSblFT1Qxv7I6xL8RlWJYy0vLmsouFH86tNCSvMsM+w4QOBdRNy7LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx88Bwt4tNaIBsYVR3IqLgcdTIcijlx9QcG2gp5tX3OaXlmRZH
	c0UfB1z9+d9V+dHISqkQrTCk3l3+4Onkoes93Jnb/q1VN9FbH+I2LIoODjgMtKwa+tEHJY+c0YB
	3LgwltIhH+mQHoSLksUzMIlV2lgepDNm300/ESBJK
X-Gm-Gg: ASbGncut/P9i9d5sShpg19lnFxo5cwAH9hQqZZrVrPzp2w8IIsI2FyVv1M+OYe/MSoU
	5ZsYdqknCa8rfgaTAu4nqENwfjx5IxZTXK56PLcF0nW7U9npSq+u4qZ/QtllThR931UHC5cOdek
	BhB2HK/yPSaUc2x2jJoY+XBt+Erj+/qFWwkQC9q+ggiL3OkotaHnKteMnnC7UIlWi+J0zv+1eHt
	v7L1B0zycKhCWebe8q1jvuSfL7H2y0Kmf98s6LfamhEhjWP8+jU++MaCogDHH/1AVzmDKREfTPu
	xdV4Wvda4wapFP+6LNKaKI/8YEoVBZq1dkku
X-Google-Smtp-Source: AGHT+IGxyEfZPwFVSruG8W1/xOtQIYhUrG26ocIcVhqCBqGSQIVZHtMYXA9EgHmYTpDrY7g9PaD8hiES7sQkipj302w=
X-Received: by 2002:a05:6870:7022:b0:2d5:ba2d:80e4 with SMTP id
 586e51a60fabf-3c98d0af208mr7622302fac.24.1761055516155; Tue, 21 Oct 2025
 07:05:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com> <20251021-binder-bitmap-v2-2-e652d172c62b@google.com>
In-Reply-To: <20251021-binder-bitmap-v2-2-e652d172c62b@google.com>
From: Burak Emir <bqe@google.com>
Date: Tue, 21 Oct 2025 16:05:04 +0200
X-Gm-Features: AS18NWDQtrxzrHOACCR6JG2HeIVeQkNyxhpo8UqCQDFYz8WpeBgJR0vYtvZDDGM
Message-ID: <CACQBu=X9NmVdOPU-Uckj6oFkwNFq8FnrUFYwnx3y=WX6tDPuFw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: bitmap: add BitmapVec::new_small()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 3:33=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This constructor is useful when you just want to create a BitmapVec
> without allocating but don't care how large it is.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Burak Emir <bqe@google.com>

