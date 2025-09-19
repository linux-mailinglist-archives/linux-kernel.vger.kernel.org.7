Return-Path: <linux-kernel+bounces-825341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A807FB8B99F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D3EA05300
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF092221FB1;
	Fri, 19 Sep 2025 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyJSa5Yk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDC22AD24
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 23:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323179; cv=none; b=KF1PPvSgDn7WbmFw/eTa4cglHx9noVzLtGOX7zCihjR8LbiZf9eVOSApgy6ZLoPG6nYZ2aev+gqmvCYo2fRWC56lJi9WfPWJhehaUe+SPyrCcrY6yh4hh+ns4klwY5uUbwJMsBIVMNiRCH3trxEh6QFugseAtKep0ovrcFigiPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323179; c=relaxed/simple;
	bh=SXKQM429Gul4wuugVn+b5LOXdKXoIRDss44wvRTpTno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIDmvxIq2Bame3wM8TLpq8vQ/flrLt/XBbmKdH1BeMImzQfCwh6AqwW55x66iNxejSNtBsGRb9sAQZe7YSHVR2+yKXiOCxaPo/qu4b6boGEX1QdS7PsReffb22xU2kkxqdzP6f5I1hoxVDYfUOzEnQ2FJtQudHAwDA6QCayMKuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyJSa5Yk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A3DC2BC86
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 23:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758323178;
	bh=SXKQM429Gul4wuugVn+b5LOXdKXoIRDss44wvRTpTno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hyJSa5Ykk/esl79UdkOV+hUdnov1Nd8kxete2wH+Vcb7BiyPNHH7OjmxxldTNyXff
	 dmddiZKahwOnfZwe2USbAGA94+qNbv1oJafzYWEOLtI5I0h9g6jMAoOQH3aP1imR1s
	 aDhPCzVBz7CZCtYpfOyu3HkwqwY5r3Co3+8rvNXUERNmtoQlS7Y1ivoiLZ7Bg/EZkk
	 KEZuh1ab9MTv446zzdNFtI/8PAmxikA88+tGSQ3UqIja2LtYWA6YRrD9ZKq1tobMid
	 8QYqDn/Pfh0+91/N1DLsfNoJ0aLQ5EC8U3vnvzHz7efFxr14EEK6Cne3afRRZxuQwE
	 4IXAYDIH/UlHw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so1957779a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 16:06:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqF2TMwGHY+rDQQdVNaOMQAYzBtImYEFtyp8q+Fmxu5HaVnAwVRHL2p2Z+bXQC2z/ZkUQ98rKjaUk9oJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0XQpkiSzVD2BFZNi9Af3YZBCac8Gz8n+nLzOvc4tFUqb3VjlX
	XXHtB96dCFgKW4QamrVkg8D7Gn/zdH7GtY8tKM2yQxQ/Neh6Vhkw8EZhY9l+R4Ob/RY2NmmPpgg
	1Vl1zzYODchSkYgORu2GvcarZAYU9zOQ=
X-Google-Smtp-Source: AGHT+IEPyqD8Z/uIMR4y+FnBrXjdCn1SCouJbFidF3JwRW1s2eKnHCGY/aZJCC2e/Tj8N5brMU8zVowHw3mTY8x0rSk=
X-Received: by 2002:a17:907:c0a:b0:b04:20c0:b1f9 with SMTP id
 a640c23a62f3a-b24f547fdc3mr488417266b.52.1758323176877; Fri, 19 Sep 2025
 16:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827082015.959430-1-apopple@nvidia.com> <20250827082015.959430-9-apopple@nvidia.com>
In-Reply-To: <20250827082015.959430-9-apopple@nvidia.com>
From: Timur Tabi <timur@kernel.org>
Date: Fri, 19 Sep 2025 18:05:39 -0500
X-Gmail-Original-Message-ID: <CAOZdJXU1oxxPxz4kUTtPseYmfE9Sa1U9nmFoqaoK1ekEv_EwFA@mail.gmail.com>
X-Gm-Features: AS18NWCcdeo5PWwM8QfmwAkG8tyE42lft8TtEs06JJT0OA22EkpZij9s3VQ3tXA
Message-ID: <CAOZdJXU1oxxPxz4kUTtPseYmfE9Sa1U9nmFoqaoK1ekEv_EwFA@mail.gmail.com>
Subject: Re: [PATCH 08/10] gpu: nova-core: falcon: Add support to check if
 RISC-V is active
To: Alistair Popple <apopple@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, dakr@kernel.org, acourbot@nvidia.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 3:28=E2=80=AFAM Alistair Popple <apopple@nvidia.com=
> wrote:
>
> +register!(NV_PRISCV_RISCV_CPUCTL @ PFalconBase[0x00001388] {
> +    7:7     active_stat as bool;
> +    0:0     halted as bool;
> +});

Two more things I've noticed:

1) I think the convention is to list the bits in increase position.
That is, 'active_stat' should be on the line below 'halted''

2) I think that this should actually be PFalcon2Base[0x00000388]

