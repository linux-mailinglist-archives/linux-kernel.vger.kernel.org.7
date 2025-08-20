Return-Path: <linux-kernel+bounces-777485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F8B2DA04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21751C4622A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCE32E22B0;
	Wed, 20 Aug 2025 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mek/xkFR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1B81D5170;
	Wed, 20 Aug 2025 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755685819; cv=none; b=itmME0eOZECrHLsTEinIgNfPaqgLd1BibNA2Domxh/k7dTxh93utAClokTbANl3mJKuFOgUV8nf1TvrT+0TxNoMsImXyCf4s7EVeK67XQYA3lcUoNoJDo3e/5/4rzmspdoM6hdO/uZ3CUi1PlcigqDGHwcF7tsU9ttUasyDuhmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755685819; c=relaxed/simple;
	bh=P/oQpoiWxChiJCM1oIYIzsoGt24WyUjDZ+cuYN5z6pQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=BqbrEAQogl/gGm6snemvRR7bUcqoF5KDVyApkSwLgCI53UJj2OsmuO8Zyee0iCjlpq8FOx/1EZCxMu6xhzZorPZPg3XPJ1hyrZj0GLrTZTmhIqdC8DMNxNy7twHHZbWjAWgF6QVk4xDZfnPcN2onbnMbA3HGjIQWpwrBQfgusmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mek/xkFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F143EC4CEEB;
	Wed, 20 Aug 2025 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755685817;
	bh=P/oQpoiWxChiJCM1oIYIzsoGt24WyUjDZ+cuYN5z6pQ=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=mek/xkFRir8nUYuV8F1j/oqDG1hgTdyrxPmeVdti2LpLwZlLCLmps8ZfTGdeBJacW
	 C11ZNiZGRh0uV4rvkOKwRgUwCVhNEr6M+jiqHhJ23E+4JqvpPGo0heqw0kovLgc9Wg
	 FB81vfneu0FRe+UaDiuywgLJ1sqh7S7db58E1Uv6aXIoTMtFaDLJdTHc9xN+Go7w0o
	 MRvrGPm/LqbmgzlIO0TVyugmmfEXUXo21xyy7aEb54oGvV5OsQgrC61JF8fN/+KYIb
	 dsbJ1EUGNHIQFM5vQsbcIOM7TEXlaxMXZeiNT3urYcbmLFELs4CkYjQAY0QKFAeiVK
	 DtuZeYy1aosKg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 12:30:14 +0200
Message-Id: <DC76OGHHB0NH.2150TC0DHRN8A@kernel.org>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with the
 drm-misc-fixes tree
Cc: "Dave Airlie" <airlied@redhat.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Beata Michalska" <beata.michalska@arm.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "DRI" <dri-devel@lists.freedesktop.org>,
 "Intel Graphics" <intel-gfx@lists.freedesktop.org>, "Linux Kernel Mailing
 List" <linux-kernel@vger.kernel.org>, "Linux Next Mailing List"
 <linux-next@vger.kernel.org>
References: <20250820112144.43714c90@canb.auug.org.au>
In-Reply-To: <20250820112144.43714c90@canb.auug.org.au>

On Wed Aug 20, 2025 at 3:21 AM CEST, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/gpu/drm/nova/file.rs
>
> between commit:
>
>   db2e7bcee11c ("drm: nova-drm: fix 32-bit arm build")
>
> from the drm-misc-fixes tree and commit:
>
>   94febfb5bcfb ("rust: drm: Drop the use of Opaque for ioctl arguments")
>
> from the drm tree.
>
> I fixed it up (I think - see below) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>
> --=20
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/gpu/drm/nova/file.rs
> index 4fe62cf98a23,7e7d4e2de2fb..000000000000
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
> @@@ -39,8 -36,7 +36,8 @@@ impl File=20
>               _ =3D> return Err(EINVAL),
>           };
>  =20
>  -        getparam.value =3D value;
>  +        #[allow(clippy::useless_conversion)]
> -         getparam.set_value(value.into());
> ++        getparam.value =3D value.into();
>  =20
>           Ok(0)
>       }

I think this resolution doesn't compile, since attributes on expressions ar=
e
behind an unstable feature flag.

I assume your config does not have CONFIG_DRM_NOVA=3D{y,m}.

The resolution in [1] is the one I came up with in the drm-tip tree.

I should probably have given you a head-up on this conflict, sorry for that=
.

[1]

diff --cc drivers/gpu/drm/nova/file.rs
index 4fe62cf98a23,7e7d4e2de2fb..90b9d2d0ec4a
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@@ -39,8 -36,7 +36,7 @@@ impl File
              _ =3D> return Err(EINVAL),
          };

-         #[allow(clippy::useless_conversion)]
-         getparam.set_value(value.into());
 -        getparam.value =3D value;
++        getparam.value =3D Into::<u64>::into(value);

          Ok(0)
      }


