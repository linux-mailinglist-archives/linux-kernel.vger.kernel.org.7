Return-Path: <linux-kernel+bounces-752182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965B4B1722E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9463A1C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874F42C375E;
	Thu, 31 Jul 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAqZIuVl"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902D82C3257;
	Thu, 31 Jul 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753969038; cv=none; b=QTEjD4909uk+STT6/cMoeO2iu+/BEqESMmgRIgvxOPiCa/2OuYlt66+/WxIWweB1OOysAw8gS8P1IqFgvwFAmtVBSAsbHLuYyU0kM52FYBzBxSUhIEqtmsVyVg9bKiVZLLGPr7pyPRinWRj/zZ/0l8L50RF6n3g4pTlDZE7jMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753969038; c=relaxed/simple;
	bh=n6X1V3RfFehnZ3cpyIf37dnTJCshuAMAGCakUAU4Mg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrfJbK89tetE94qRqQ4qgWV5xsFThEZXwa2LC40QXXkuD2QJSqSjIbwDyBsge2KmjJ2Z0pzmkJVgDy6RPOv7yOwBh4wrnpDTW0m0EDaVz7pdhuz2oTIk+yKF0Qr7WdMz7x6SojYi8qKVQzoeUUY9a+bpL0lNJXuV9ld7j+Yzd1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAqZIuVl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31f3fe66ebaso1740251a91.0;
        Thu, 31 Jul 2025 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753969036; x=1754573836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuTRUqrpxTzMTLN57qSCknOjn0LQPnLvh3pt1CB9xH8=;
        b=SAqZIuVlm4+0xEVtR916dUv715+iqSVcmqlb35G/AbpHgRhhJ5ku+BsOK+2RbwSxJu
         7gOHWpQDms5oW+PkgQQXU+T80xQntRuK0lih2+7WzGWCNXX1yWfmQAnxGyOGl8xKcKXa
         DvcmdbmvYY0KTmVn76TFfcIEMS4Hi0x5Ir8Wr88KbnIh0zeewFOZlWgpwKLDWRxw3m2g
         dW8v9jH3dyuq2hEGj6Epac41GRb4l1yzbWnJ/A2qnA8A99Hi4EAxnLdb0Wy//GSO/pMI
         RW/E6w/0jH1vtrhYCBHtszgITVuaSuPAi1K5Yl9BkKjb4OAYg7pneEG9dFIuFreDm4oj
         Sr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753969036; x=1754573836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HuTRUqrpxTzMTLN57qSCknOjn0LQPnLvh3pt1CB9xH8=;
        b=nl7/fzMSvFiw9WpgPpPhApB/+QArq0iJZOrygmHpsqVLUvVfi1wGxdAwEEumcXybyF
         ncp7cXZWYU8v7iYX81qmxVzNkLcUeCyJuOWPPjuqZC76j7zfsIJLG5sKBh+eV0GC9yTi
         Kb8D0d0EZDRZLvp0s1/PxPC7ABKSqLMR4UMfYN28o2oiGuqkbFfCxJ4iKtEE12J3dIdk
         cpQ8FiIwVf3rWbVBPHzB2uIqAfaTYr49YWNOrzcGv9JGyhtgBlk5VSRJzmaKIlnJpjUN
         +UuMMETy8UwdTe/SgT70t/OBwKVyLPYOjvMeywjKqoUYVBRkgECliLmh2Z6t9IPdC0Xk
         PXwA==
X-Forwarded-Encrypted: i=1; AJvYcCWPkPzDgKxPQkqg9SVu2kyPqwp9XN02doQTpsPsVtdBE/Tkv4nFhq0hX9VQiepo5OKSoBjIDBBBOYnQWrxMCEM=@vger.kernel.org, AJvYcCWZh/pwXwWdEBiSuAm/U2t3SkN2WQDBmOp1G2pPhpltAtKr//T9ThWma+EBTmi+UZ2j01Zypg5lejJizjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvkA0ATOjuxcOUIZhoXGYsVcsLSAvvudAVUHf29MpuBmId82U3
	aMQ9NZt+VmvKRySCNLpxLvwRWxBGjqwj0TqL3lIIMCgErlS2g9Eb3sVcvPYcZ2rFAz8MKPy1inC
	B7yrL9JagpinCfUZET+hMLAVd2zMk6tk=
X-Gm-Gg: ASbGnctyilL09QTrJ3zRJHUPmhCXeZ2zhEiK7/1YTyiuvgYEd0+QwK+TYH+3d8x8kIZ
	Nko9R9EC8tXv0KCYRNToFZkkind55Kt/p89TNu7SbGGm2mr82L7PQcBsrD6muBfcuIXpqw9E2WG
	/9LNxiR6LtfqbN9fK0Ja7Zl88ZxHf5a67NhiGa7jVsjYv7TYXP+mF39lsThnAIzu+4tsGtMvbpJ
	U5frA==
X-Google-Smtp-Source: AGHT+IGjeqOAMxHGzgkLxNOzx6o55omDB4AEiVQHqDIWpou2G5RlgyyYejHpy0C+OAoAX96aWPzb4//WCJF1aOY0KNo=
X-Received: by 2002:a17:90b:1b47:b0:31f:d0:95c4 with SMTP id
 98e67ed59e1d1-320da5b4016mr2847320a91.5.1753969035615; Thu, 31 Jul 2025
 06:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716090941.811418-1-shankari.ak0208@gmail.com>
In-Reply-To: <20250716090941.811418-1-shankari.ak0208@gmail.com>
From: Shankari Anand <shankari.ak0208@gmail.com>
Date: Thu, 31 Jul 2025 19:07:04 +0530
X-Gm-Features: Ac12FXySrpOvTAI0KFNKcXXAHLBwMx0U1yF9Y66G8wf1Zz-rB2psiLL8Z92yaFc
Message-ID: <CAPRMd3n-1nx6BnL=OtrrJqS1gCxYAw2wSaHUQ19174Y=ShqO6g@mail.gmail.com>
Subject: Re: [PATCH 2/7] rust: gpu: update ARef and AlwaysRefCounted imports
 from sync::aref
To: Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, can this patch be picked up for review?

--
Thanks and Regards,
Shankari

On Wed, Jul 16, 2025 at 2:40=E2=80=AFPM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Update call sites under gpu to import `ARef` and
> `AlwaysRefCounted` from `sync::aref` instead of `types`.
>
> This aligns with the ongoing effort to move `ARef` and
> `AlwaysRefCounted` to sync.
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1173
> Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
> ---
> It part of a subsystem-wise split series, as suggested in:
> https://lore.kernel.org/rust-for-linux/CANiq72=3DNSRMV_6UxXVgkebmWmbgN4i=
=3DsfRszr-G+x3W5A4DYOg@mail.gmail.com/T/#u
> This split series is intended to ease review and subsystem-level maintena=
nce.
>
> The original moving patch is here:
> https://lore.kernel.org/rust-for-linux/20250625111133.698481-1-shankari.a=
k0208@gmail.com/
>
> Gradually the re-export from types.rs will be eliminated in the
> future cycle.
> ---
>  drivers/gpu/drm/nova/driver.rs | 4 +++-
>  drivers/gpu/drm/nova/gem.rs    | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver=
.rs
> index b28b2e05cc15..91b7380f83ab 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use kernel::{auxiliary, c_str, device::Core, drm, drm::gem, drm::ioctl, =
prelude::*, types::ARef};
> +use kernel::{
> +    auxiliary, c_str, device::Core, drm, drm::gem, drm::ioctl, prelude::=
*, sync::aref::ARef,
> +};
>
>  use crate::file::File;
>  use crate::gem::NovaObject;
> diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
> index 33b62d21400c..cd82773dab92 100644
> --- a/drivers/gpu/drm/nova/gem.rs
> +++ b/drivers/gpu/drm/nova/gem.rs
> @@ -4,7 +4,7 @@
>      drm,
>      drm::{gem, gem::BaseObject},
>      prelude::*,
> -    types::ARef,
> +    sync::aref::ARef,
>  };
>
>  use crate::{
> --
> 2.34.1
>

