Return-Path: <linux-kernel+bounces-774279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFAB2B0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6495582A12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B08272E43;
	Mon, 18 Aug 2025 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+mVuBAL"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AD26463B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542893; cv=none; b=jORj05r5vqhwCTZfdnyUdjcppcqX8BLmHeNFLXVINl80VpKGJnDgLyAeKvRVZzr1APTD1u/XX6bbkTPv0WqkNzzHjgnGqcxMV0UAkrtNxm/FKzA5mNiGrpsre1yU/SVoDZ21wYpQB07RJURnvtR9mVUzPF+U1BCJPOGPiPkvH0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542893; c=relaxed/simple;
	bh=ogb9XFnZZrZ9wBA7uRqvc61F0r77t5e/ouliHcstXRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rbsq1/HRj2rc8TcwPeom2irTVdBQp2eTSOR5CYK5MXO9D/aBhuxnn9VBijnhxzE/fgfesVogbYzyGNQFCRQiptTFbCBc7Mw9xQj7ZmPu2Qmkw1REzTckb/n2ApjxDUUI1Qy8ni97VVQM7arfnNfq+eopHCIdUAAh6vHKfZW90/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+mVuBAL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9d41baedeso2366929f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755542890; x=1756147690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=64mBXn3B22UXZvYqV32OHTk45f8yf0QzbPT17GFuJeM=;
        b=N+mVuBALYbb3HrmavsD7GlghdIf1xmmxKc1yi+VudGwFxBppAvfdgR0/Q6f8E+H71O
         rSe4TMK/zoyfYbZ0BAuVsXjEBAQtwQwUe9brc0JGfLTaJOUyrqNeZHyp2+A/4QHDBQ9g
         GMLyWHlpRfWufIMkjn/uL01sEI7NuRDiRtpDeOUHekHT2XNQqcd93WXGnhySVCPe4FA+
         k9YkzI7Gdu2No0Y0Oz7KzzG3nHE80gyQ0BoIOVt3Dgqs7vycCX0yo2qpwsRE2cOUW5q4
         08G+AqQK7zEhOAdEUDPbNWAKeXC9XHTFBXrvz2nwM5vd0wvENHpYOKo219g2zfEYtGAA
         L0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755542890; x=1756147690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64mBXn3B22UXZvYqV32OHTk45f8yf0QzbPT17GFuJeM=;
        b=WXM5uNrWs6G0Bb4fpbinLWSeExmE1ewVU9IO9hwkoI6dnnzjtkvZ4wX1TCSyFhQGaU
         Rv24cg8yiE+Bua2VuurFtprhjV3SZ5qsZ7JIjbBMrFO19pBZ/gjUiDbyLOwoiU8zJAsN
         sZ2/KXgdDOtkn//9XRB9S/cCYqUEClLc4+i7RkN2aPs1nfzWtgEehiiOTVcD2XQvvh6u
         COpz63o3Jd3uuWug4FLJl71cLfxPiESRAZYW432dguNvykMrJUGq0p1x1SQX6yVg0Bgc
         lUSsqYQRRR7CmwMrDSYmKW+OBeOnMQPZkdX0vhqwjX8PsIWaL76UbF9/96x/De4bKeTy
         WUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzwQPNNFEtNoG2NqjiAyFXUhJLILyuicQreekq7i20GuFdWBd5DhvJqncA51gmQiNtuGSacw480IE2fgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo4o520apwF+gi/TH1SNHVdtrsM03PR7IyDVwuRZYI6zoJU/j+
	Ths6A0Z9uMuMZUmtFQ/3UnmQD9EBll58HxY7TPs9o6AjclO6WefQGn7eAbQMzzu4xAsUwFu/X+d
	wQ/iSX7R8OqeNEyCyrESUCWED4vG6yVVdTSVQU3MP
X-Gm-Gg: ASbGncvjcMBkTnQArrctP95Y+yunx9sxm9r6t3Xg5wgPVIJr1B8rmoZwu5pRIzGPlPG
	AfQ2xkubGyWxB/NUAnAir1o9EWy032TsCzJCB0Q4JQ7T0DwTgVaK7E45ZZUk9AfYjuNd4iexASo
	DK+JFp1ja/ujXf5mjayvLggz8T0p94owsi6j9L9ufAM6Cc+TAISWjAPSTM1aph1XZmAoNC6PzO7
	A1Nk/DmriD3Ucek64R2hWfxAw==
X-Google-Smtp-Source: AGHT+IF08gJKzbr49wgvjg3YcSSdG6LlpXG1Q5FuaqXPZ59zKJO+qeN1125wGI8F9QrSJYAeqMWWQZ3DsK+4FTG68Do=
X-Received: by 2002:a05:6000:4409:b0:3bb:bd05:735e with SMTP id
 ffacd0b85a97d-3bbbd05751fmr7119775f8f.38.1755542889800; Mon, 18 Aug 2025
 11:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815171058.299270-1-dakr@kernel.org> <20250815171058.299270-2-dakr@kernel.org>
 <aKLzrp0m00J6CCYz@google.com> <DC5INEG2DXU5.DM4JIICEQ2PC@kernel.org>
 <aKMa7YzO-PwEv9AT@google.com> <DC5KK67M752R.N9PX4LUG2F68@kernel.org>
 <CAH5fLgi6OZaqjnDScDrJ3YjN2a8mJuPiO5MLPUqUWo62WkvvrA@mail.gmail.com> <DC5Q80UUHSUV.360VLIC6DYZ78@kernel.org>
In-Reply-To: <DC5Q80UUHSUV.360VLIC6DYZ78@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 18 Aug 2025 20:47:57 +0200
X-Gm-Features: Ac12FXzLDR-HPSc-PG6zg5yNczOIFU3hk5TTuVY7oe_h9UB-CbiVfuuCyolUd58
Message-ID: <CAH5fLgjymw6Mr8qv8NDFA8hz+nfh3-B4XcZ_N-UAmJrc3Ug_QQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: dma: implement DataDirection
To: Danilo Krummrich <dakr@kernel.org>
Cc: akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, 
	abdiel.janulgue@gmail.com, acourbot@nvidia.com, jgg@ziepe.ca, 
	lyude@redhat.com, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 7:23=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Aug 18, 2025 at 4:00 PM CEST, Alice Ryhl wrote:
> > In general, I think we want some sort of helper function to cast
> > between arbitrary integer types in const-evaluation that panics if the
> > cast is out of bounds. Both here and many other places.
>
> What exactly do you have in mind?

        pub enum DataDirection {
            /// The DMA mapping is for bidirectional data transfer.
            ///
            /// This is used when the buffer can be both read from and
written to by the device.
            /// The cache for the corresponding memory region is both
flushed and invalidated.
            Bidirectional =3D
const_cast(bindings::dma_data_direction_DMA_BIDIRECTIONAL),

with no warnings and build-failure if out-of-bounds.

Alice

