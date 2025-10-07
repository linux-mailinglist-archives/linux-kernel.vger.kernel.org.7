Return-Path: <linux-kernel+bounces-844127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E234BC111D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 029654F4902
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4202528FD;
	Tue,  7 Oct 2025 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffGqtqMt"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8191A2398
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759834926; cv=none; b=TVhUcv+C+3IP7ZoKTx3YnfEoTWk/+/NJ5TDjLN3ie33+liEG+bw7LC6VniJPbB3yNNEQVdxxSUMIcTiuepmTxbSX2Yn/AQr3Xr2eNOU28J6prvjI5O4jvS7rNonZwCoTVdZt9ODaMzgMVbGZvUv4C7GK8DqDgno3A2Sw1DKByMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759834926; c=relaxed/simple;
	bh=PGrje0/KPcBzP7FBajz2RGg43sKePjZezJXaVWwAgdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YTyt5dv3fmgJI2TuVmOtbyZH5IbFNH5YWATXNiN7fTknZTbj5xAs3hCvkWsfi0JKalL3uUFd4Tl3x5NasFR+a1YDUUgJGtknXjNoGI41mTC1DVqWVBeV7xfAdZJE1ZJ9V7vhPpqh5R2o0mqPwIxlr1upl6VOMGueVtAS77eDtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ffGqtqMt; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-40fd1b17d2bso2626502f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759834921; x=1760439721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9cBFNjFEfAJOD01Katg1TkGcbRmePh4iGouqwbxQ/M=;
        b=ffGqtqMtkkqTY/mjSBuOyWbJ0K15UdZy2qqdxp8i3pY4SPJlwZqJ//fyHsVbVClUPJ
         lHp/+fZN1ivPlyUYPQ1/r7/Kstudm8mPtkxeyfaeJJ0aSekqCGSwRp7qus4D+W7Qa3EX
         XK2/k8nQ5QBXkKYPWZDbbn4Fn6eoyXVAW2nucZq5kBXFMCZ1/aygEQle/OeU5RWn4CgN
         5dPSoTDxNT3XDfOSDW9pUCSMLX74hGU2klZUd+Spyt5qTqtQmDokgNcW/QceTgirme7K
         bOvjex9kKGujJgbikEGnuIERXEuSg6p6HyY5iXaVfzcE4nEhZ60S8W8vFoIaY/ZsUnre
         SRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759834921; x=1760439721;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y9cBFNjFEfAJOD01Katg1TkGcbRmePh4iGouqwbxQ/M=;
        b=j+ycidhNO7OwShgvJ0Eu+PkDgfj9dIsFIQnZgstqh0EFr/OC8OJCEBAgxusvJy2n51
         ufDKpNVvb3EkH20jfs6KUAxMsp4KpB++xot3Zp5SqoHnmYUTHS7CkxrvdT3mpAppyQmC
         kYlymaljoMs8MxLBhvIwuQ5aaatZ64VP8afqXFocraBlrNIeqEpbKefFrV4cZZQERrE6
         o2PF5SNGvkSI1DptZRGnqVmqL5DzGxcEpxjqCffGTagcvkeV0XUqbdLifJxVVeGmeb0R
         SqR7zSdEu932yyIPNGo1bsYlVb+XEavlSmOJwexRrIS2O3y889S9Sk+65yonVhaaGKlf
         Eixg==
X-Forwarded-Encrypted: i=1; AJvYcCXS4vae4CHa+4s+hIoq2kQArW9jK+h0PMho/uTInbwnAsALRHbudEuBCnaXyDAcmywCf+s+aMZzaTKa+3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqkiMTuzscyoD1pBs1sWFJxgDbiyIG6M3/F73H4WP0dA/nlZ9d
	XB0n6k/dZfrTGQVS5Lin3A0WtK/tQzzJbUi/teaMyfTsa8nH75IcsexCxMCguvFfWFYyQ7/SaZ0
	SQwtbr/Ljo7/FAJOI0w==
X-Google-Smtp-Source: AGHT+IGqz3ZqJgw9/rCFGmf6rNjZBgL7PkKdsRmGaumcB6YPyLXFLZRDLyxgYqnJue7uO1W7N4GVYLSQ3L7x1Ww=
X-Received: from wmna4.prod.google.com ([2002:a05:600c:684:b0:46d:6939:1b46])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37c9:b0:46e:4341:7302 with SMTP id 5b1f17b1804b1-46e71155b8cmr95460085e9.34.1759834920610;
 Tue, 07 Oct 2025 04:02:00 -0700 (PDT)
Date: Tue, 7 Oct 2025 11:01:59 +0000
In-Reply-To: <20251006163024.18473-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251006163024.18473-1-work@onurozkan.dev>
Message-ID: <aOTzJyLA49xdckRr@google.com>
Subject: Re: [PATCH 0/3] rust: xarray: abstract `xa_alloc` and `xa_alloc_cyclic`
From: Alice Ryhl <aliceryhl@google.com>
To: "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, acourbot@nvidia.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, corbet@lwn.net, lyude@redhat.com, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 06, 2025 at 07:30:21PM +0300, Onur =C3=96zkan wrote:
> Initial version of xa_alloc and xa_alloc_cyclic abstraction
> patch series.
>=20
> Onur =C3=96zkan (3):
>   rust: xarray: abstract `xa_alloc`
>   rust: xarray: abstract `xa_alloc_cyclic`
>   remove completed task from nova-core task list
>=20
>  Documentation/gpu/nova/core/todo.rst |  8 ---
>  rust/kernel/xarray.rs                | 82 ++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 8 deletions(-)

We should send xarray patches to the linux-mm@kvack.org too.

Alice

