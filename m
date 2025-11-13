Return-Path: <linux-kernel+bounces-899093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21342C56C24
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92A434E57A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B92DFF19;
	Thu, 13 Nov 2025 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqFEINZ8"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2686E2E173B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763028384; cv=none; b=qHR3xzW2Q1MhZyA2+C+qyt1lobDP7qdoChKYgP/frrFSvWliWYHR/MOU8kXX0jeg4GWFFDeVBjNx0QBJ2X1YBDagfTTu0qHS4ZbIeRTWwTDwcdlFUXZG8DrjFpcMqdjlkdBji+6SSwIoPm5/OyYrM2CdmDGoki2Lbp18X3PTkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763028384; c=relaxed/simple;
	bh=SakcwQpPdAYlIowM8bt4fPJVk64+hwM+gbniVbgurbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jVDWxx/+16nSrIGArsga3n8dHBSLmg3Zv8sZhpeT68r0vq4FhNYjHUt6YKQMRHddvFudIc9d5l1vET0r5qeuzPO5VZrKVWiEUi+4mvh0YogUtGOZ1GJIVWgS9fkfAFnB4dt8lAQbWt5/OH44ykSheKhAvcB66/gWEWBbpWAxEJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqFEINZ8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297ec8a6418so801295ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763028382; x=1763633182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SakcwQpPdAYlIowM8bt4fPJVk64+hwM+gbniVbgurbM=;
        b=fqFEINZ8pxCM/l/qaTIk/W4h9lCrRvtY05eTlARe9n8YeXF76ZDxONsdzB5WUrvvyb
         er7MFDzLtH48ZvjeG7cb0tFVd7lsMQEQ0vlEAUAax7Wxw+r1eazChOw3/MU107fZon1p
         TlaLuGm5JFk5nhrm5BsB/Do2n5jNUsc6UhvybU54Mwuj0HfbAwGvUZnu/V4xVeqH381R
         CKAqbwt5Covb6MrGFOQCTF1klSnLY0n+4V7M8BL/H7lVMmwz99yt88sVSsV4gJSyjsbi
         cX8iaL282gitK83aiZM7aBajCNo4AWMyUk5FuEaMONZ09N/qrk9o2rNfn4s2QK/idJHS
         qfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763028382; x=1763633182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SakcwQpPdAYlIowM8bt4fPJVk64+hwM+gbniVbgurbM=;
        b=kBk2xqJo55KWoo2JKoI9/NtN2Hmo8yu+aUimJAgxiGENWR1FvNnJsM/hUrdqeGgHbm
         o7T3v2ICOeSCuqMLOQdJbwGcULn4yAM2OwtWxhAFVRxTtZVMVCBxV42nTMFjG+A6WK7R
         696Azv7NFNz7zqqL6zSxj+M35Snkjnl3pQHOklk4k6Ia86toeDugJzG9Su3P/TtzrwC2
         GNLbg4HayKtuwKqpanBnLUY//9k/IjxKcR0QHdWc6W+RP1gvHMmSjwnp+ntgHEVhw+p7
         zumWvHrKFLYrJfsuQU5Vh/dWLk418cAqz0khSVfE9tMVXL7IGZjcgBzT1yN1Jmg7hyfo
         pd0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN637Pa5m5G9TLbRK2Sc6YUty9Jh8+eQzYQFLrBxux02YSYKZ2BDb6f+54ua2bDzZGTk4Iqg4hBKpSX04=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoxT5R+ZitAUwBnQ4EWg22/im+C2WiJNX+3ZBpHtEtbkx9jpBS
	UWCH1gLNsYAnGASKC2oGb5uOZ/hdKOvoL6hVXcfAP6PcnSvvaG8gP11Rf7oEzC1wXs7vo0OVwxh
	RvHuowe2PpNMF0MsD8HCr/dAxwDN5Boo=
X-Gm-Gg: ASbGncuJLq8jNcM4Boj05ioedYq+l0Rc+Cns8eTAac4gGWtgEgSJrpumMyvA9HwXr30
	5U3jFONFLkz0UPclJGq4qRAvkH3olXWD4bbK8Zz0v8+UFTkjXnGZtAoDVZShdrgCNGr41a9zE9V
	gd0vb8rPFPqUW7gxen4rayTr74Ut+ZgkfkV5M/M1s84tC0xqFzRgdvzcqls8qPSZw8dFNg6Jgj4
	ulz8ZKTbLh8xRwBuZeRMERqeoltQZ+9Eqg1dSIsBi4BuBPnirlYVuEr/+IG9Lg0O5rjwlRsCEYy
	wIpgvavZumYiJkBZGHmr1qoPbE5hkykcra1aSzp+/Yrtm8LLD3/1K2Ss01bAo5mNe7BhUcjylkg
	zxlM=
X-Google-Smtp-Source: AGHT+IEzNxzznt3OW2Dpm9++FAbosIG2V3ygxc5yhp8W2cG7jBB8uRt3p8Uomy8GlIKZfP3CuP+vGZ5FoH34INnliD4=
X-Received: by 2002:a17:902:da4b:b0:298:529b:85d7 with SMTP id
 d9443c01a7336-298529b87d3mr30505505ad.5.1763028382379; Thu, 13 Nov 2025
 02:06:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-create-workqueue-v2-0-8b45277119bc@google.com> <20251113-create-workqueue-v2-1-8b45277119bc@google.com>
In-Reply-To: <20251113-create-workqueue-v2-1-8b45277119bc@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 13 Nov 2025 11:06:09 +0100
X-Gm-Features: AWmQ_blzoOEHZpUg5855vlqByLe32dk2MkjaHUrqoFKrZBK7qYe0tPspHqrfSKk
Message-ID: <CANiq72k1VqR7P7tY2V_siBQZrNXf_ck5aBkapo6M_6X=1P+nDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: workqueue: restrict delayed work to global wqs
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tejun Heo <tj@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	John Hubbard <jhubbard@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benno Lossin <lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 11:01=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> When a workqueue is shut down, delayed work that is pending but not
> scheduled does not get properly cleaned up, so it's not safe to use
> `enqueue_delayed` on a workqueue that might be destroyed. To fix this,
> restricted `enqueue_delayed` to static queues.

Should this have a Fixes and Cc: stable?

Cheers,
Miguel

