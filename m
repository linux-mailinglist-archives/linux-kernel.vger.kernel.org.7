Return-Path: <linux-kernel+bounces-863996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC4DBF9AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D357F4281C4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1811FE47C;
	Wed, 22 Oct 2025 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCNqKUKf"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ACA199FB0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098953; cv=none; b=I05+JxaRtqS0YdcaioqCTkU1Q5GXVHsJ/5S7gO1Vv5DFoL88gSk0+kl0QacHqkh8hTAC+E5uOBDeNNd4N8AoBuRDDiotfwwvOAr906yWQR+5mZGo8LpkeAB3uE0YEjac4M952bn+ZLJoC1MD11s0UOQdGJBIKLaZMCpUiTnMA/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098953; c=relaxed/simple;
	bh=J/kA9zA++ImiS6Iw4lypA+VtjeUDcyGzn0SVCKdDy7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuOCWRWmSyDqDBObIeuI9FabSZljqHpsJ09F6liU7yvM3Zqml+gL2p2l2THvwiCuHkREQDnAnhCWJVOyeOTNH+jlZcQyNYOo8X5lwaU+K2x+lFmZ4vJomqxGp8Dye714MBZ117MjyIC+M9F0ux5a9jHhDSAelkO7oOZSAwrct38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCNqKUKf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27ee41e074dso74501135ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761098951; x=1761703751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=af9vNF4/pOmtn3q/j2U/NQMJF3YjAHP3FBPyaTm2ZTY=;
        b=eCNqKUKfNxJf6WghsQgQEi6jWzJ7xo1PF0jriw7LbMfWlXuxksp4IUYr4F/tMd4mB7
         yG2Lrx0nJKIev5ez0xmHEkfeZCzS7a2ioI875l9ZIxoF3r6VMTAuqOihQDWpblwilPp1
         C+LpRENppq3liiz10oceTQ19rmgNa1xmzK6KthIUxkKEWR6lxzMohUfe/c7QaX2FRH+4
         V8AXH+G2OmBxgyct7P1IL+s2Oi54u2fi4KJfeqnX39u2kXdI2VEPBcG5DMHysmdLbHIF
         6ZbN3eHOmaUko+WPEjMy5CNU+C25RqRM45PWPEoM2YniM8TIgBW2U+/fHnllhUGxYu0F
         0//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098951; x=1761703751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af9vNF4/pOmtn3q/j2U/NQMJF3YjAHP3FBPyaTm2ZTY=;
        b=kqfNdjuUQNc0NjnXdLKWCaDaBVB8NYcqRKoWQwFW1uX+tL0bmj6b7J1dFlFddhJ6gG
         NQIRFIoYOd0vNxXomxFObqc8XzNzFjZUPibktA+W2QblNEF39/D28odE2wbSz4QlVwN/
         NeMLVpzCeoFmwI2lWV+o9IfqrRLeIRpe72DlYVS5kD9p5PFjzXdFyDbfQZQVuubwOthS
         gOoClmunI6rovIMtYTAvISFpDzi/6b5mLKDz2xEHVq3/I1TZQ5bzBqMpBUhJ6fx+Mwgt
         wqtvGLDCfkc8pNcKNK6MANrsP93tSbhWjgIa867Wcx2SRUaO7fSyTJzRhBOL9TlXxzRA
         Bv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6IAGcIDHih4dLE9LzhzKzqn2P97sv9HqBuZLztIwly1uqHTAGOpvpLHlFpV/n/exSg4yyzAsGXhxF5uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJvFluLPADltJ0LzGiA/+x4SJsnyGwI5XodZp882lg1c4tcWHj
	FA7YctABZ++tutbg9AAm/qrbK89TkG2nBjKGo2iLTrElqoB+wM7ewImZ
X-Gm-Gg: ASbGncsRVWW1oFDQLXFPgUtJ7O3MLmJ/7fYJlVTylxmIpToqxTHUd3u72Zj2X/IZ9Bc
	neXS0sQZ57eLeWrZ0rNpdIL4k0vWgxno5UPqwZ0ooH7LnMmW6xGq0Gu/H+TTZLtxRBGvhErrAa3
	fAxTMjJh3UsFQSTxYeVor7uFG9nPhIZ1jrQYd45pE3t7DvMfQIV2uA62Bi0ZbHTuWxu2HBlEAMj
	T04HDHUQk1UGe05nqLMUu88LZSGSflciBSpBf/3EK7MLpZdbO3YgfgayzvM8jIrJ0UXUhIWHvQj
	BN+d9NeS8XNgoM4aEGRj0tNgRpRyvXPxPE9sZQHkAdQowFdVWK2D+lPBsjO7B3iDRZSPo6J6RGZ
	H1V78fd8TkwYvEQe8ULIS9r9QUc9KqYBYsrm52zFse9wJ1iRZCeMs2lrS/zgKFhWP0Ap/v/5Uwh
	7ZhVe7sfT7Zv0W
X-Google-Smtp-Source: AGHT+IGoV41dxt0PTAHkgRAIyZFYB8ISFOdcqUyCiizLarhiL6pLGFIW2lB0KpZYTkg47fD50y0GNw==
X-Received: by 2002:a17:903:b90:b0:276:d3e:6844 with SMTP id d9443c01a7336-290ca1218cbmr205757685ad.33.1761098950545;
        Tue, 21 Oct 2025 19:09:10 -0700 (PDT)
Received: from archie.me ([103.124.138.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471feb99sm123086345ad.87.2025.10.21.19.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 19:09:09 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EB4D34209E4B; Wed, 22 Oct 2025 09:09:06 +0700 (WIB)
Date: Wed, 22 Oct 2025 09:09:06 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
	dakr@kernel.org, acourbot@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH 4/7] docs: gpu: nova-core: Document the PRAMIN aperture
 mechanism
Message-ID: <aPg8wuF5ZodLxOH0@archie.me>
References: <20251020185539.49986-1-joelagnelf@nvidia.com>
 <20251020185539.49986-5-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WWOwYHGjzVps0pxd"
Content-Disposition: inline
In-Reply-To: <20251020185539.49986-5-joelagnelf@nvidia.com>


--WWOwYHGjzVps0pxd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 02:55:36PM -0400, Joel Fernandes wrote:
> +The window position is controlled via the PBUS BAR0_WINDOW register::
> +
> +    NV_PBUS_BAR0_WINDOW Register
> +    +-----+-----+--------------------------------------+
> +    |31-26|25-24|           23-0                       |
> +    |     |TARG |         BASE_ADDR                    |
> +    |     | ET  |        (bits 39:16 of VRAM address)  |
> +    +-----+-----+--------------------------------------+

Shouldn't the TARGET field cell above be fitted (extended)?

> +
> +    TARGET field values:
> +    - 0x0: VID_MEM (Video Memory / VRAM)
> +    - 0x1: SYS_MEM_COHERENT (Coherent system memory)
> +    - 0x2: SYS_MEM_NONCOHERENT (Non-coherent system memory)
> +
> +64KB Alignment Requirement
> +---------------------------
> +
> +The PRAMIN window must be aligned to 64KB boundaries in VRAM. This is en=
forced
> +by the BASE_ADDR field representing bits [39:16] of the target address::
> +
> +    VRAM Address Calculation:
> +    actual_vram_addr =3D (BASE_ADDR << 16) + pramin_offset
> +    Where:
> +    - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
> +    - pramin_offset: 20-bit offset within PRAMIN window [0x00000-0xFFFFF]
> +    Example Window Positioning:

Move the supplementary explanation out of respective literal code blocks,
like::

---- >8 ----
diff --git a/Documentation/gpu/nova/core/pramin.rst b/Documentation/gpu/nov=
a/core/pramin.rst
index 19615e504db9d5..47abe539e32a81 100644
--- a/Documentation/gpu/nova/core/pramin.rst
+++ b/Documentation/gpu/nova/core/pramin.rst
@@ -70,23 +70,28 @@ The window position is controlled via the PBUS BAR0_WIN=
DOW register::
     |     | ET  |        (bits 39:16 of VRAM address)  |
     +-----+-----+--------------------------------------+
=20
-    TARGET field values:
-    - 0x0: VID_MEM (Video Memory / VRAM)
-    - 0x1: SYS_MEM_COHERENT (Coherent system memory)
-    - 0x2: SYS_MEM_NONCOHERENT (Non-coherent system memory)
+where TARGET field values are:
+
+  - 0x0: VID_MEM (Video Memory / VRAM)
+  - 0x1: SYS_MEM_COHERENT (Coherent system memory)
+  - 0x2: SYS_MEM_NONCOHERENT (Non-coherent system memory)
=20
 64KB Alignment Requirement
 ---------------------------
=20
 The PRAMIN window must be aligned to 64KB boundaries in VRAM. This is enfo=
rced
-by the BASE_ADDR field representing bits [39:16] of the target address::
+by the BASE_ADDR field representing bits [39:16] of the target address. The
+VRAM address calculation is determined by::
=20
-    VRAM Address Calculation:
     actual_vram_addr =3D (BASE_ADDR << 16) + pramin_offset
-    Where:
-    - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
-    - pramin_offset: 20-bit offset within PRAMIN window [0x00000-0xFFFFF]
-    Example Window Positioning:
+
+where:
+
+  - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
+  - pramin_offset: 20-bit offset within PRAMIN window [0x00000-0xFFFFF]
+
+Example window positioning::
+
     +---------------------------------------------------------+
     |                    VRAM Space                           |
     |                                                         |

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--WWOwYHGjzVps0pxd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaPg8vgAKCRD2uYlJVVFO
oyuoAP9SK55E2tSNnoxS1S+ANBUsz0CHN3jIoOgeS9ZQB8q9dgD/diBfYDATtQIi
6xSU72ZYmtPwjX3snJKLeHqpNqruDgk=
=zVnz
-----END PGP SIGNATURE-----

--WWOwYHGjzVps0pxd--

