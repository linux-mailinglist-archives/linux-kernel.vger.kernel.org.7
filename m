Return-Path: <linux-kernel+bounces-792810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4A5B3C942
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 10:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1289C3B5EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 08:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40780277804;
	Sat, 30 Aug 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4mHU23/v"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0461226A0B9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756542029; cv=none; b=pIlSwVuwHrixXP0h95wKk/R9JUvO6yJT+bin4hgHFR0+NrIxwX0GLb1uyKJEl6oXGlQOQ/IFLeBD5j+XulGp8A6JhKXl+RdH0EbQe7AnHYNa4p4n5alxRBmB3FXXk/u7jXqu2F7gY18Bx4x/149pFbsciMIXDuokFWhtImbkBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756542029; c=relaxed/simple;
	bh=jfwic21iXdfv9f+kWJrc4jhW42b7x/qaoBKAdUcheNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rexnsfw4jprw9l6Ua0X9+Q7bWGlGBJVftv86rHEjtuJv+wgtBspCGEovwOQkbVe6+dJjA5rKsK8n9J4J3kPQGz7R3Cxjile9EC+dXyOWxHFDwRa7ReImxvKS+qCdQDqJi08psHrRH8qxeyRK1a6EsHgGmYMvGgJNXHTNH0OYOs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4mHU23/v; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so1236152f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756542026; x=1757146826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVRZX8gfqHXmXgSMNLafTN3D6+RIn7S8fWN/+084Biw=;
        b=4mHU23/vvJuM+7MG8OundS4ssns8ix7FuKVNLNUPJIumqK0krfQ0YuGVMBCr3Bz/vH
         De+wMcbn7zNHKiy3ySh6g8BpqMxVk8mxshL54DJJaeS73jyq/v1FRH+7+iMKEQd1R/Em
         J1vYKK1t+lZSK2hgFN28mNKLhZP5hJ7PJYCehkWZA2UaNB0nyO481xbkONdJM5+8grjd
         u0YpfjWA7FpWni0h6Jw/3fVpg2OrNCU4Oy6Nm+U1D14rjjDDH4D/FrCFFkQPNZSlzaxr
         lgdPh7GgrKQJP3j+JJZznM1VfSV/8o4Kltd/CCrpDmS0cW+zm9bxAARhZIGmKUKXu/7j
         tRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756542026; x=1757146826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVRZX8gfqHXmXgSMNLafTN3D6+RIn7S8fWN/+084Biw=;
        b=vhk1I/nm2K1awhLxqyjU/x0o5Gyhrx74rIAKGdLgxUJgpAEUWLqSz0fL4bbH7xwy+r
         Om/u4SgzOGhsyb6T4bdE7AlppftU8veVgfpFvYqc5sp7//uk80iSjAbL6x1hn5oMuxAm
         pGWnQs188pX4UcFRBrh7SQ0lxWpTYYqtQ/zPfOJwzlDV4GkymBXINXF8rjVbGfV3t4vU
         41FVXvHDAkFGqNOJe+Vss4ygd/loY+upWj9m7dJSqcgDzNbhhH3yauu0ZScYyYyLxPkc
         wJpC72L6eCSDPxHKS37o9NPz/Kudplijo+M7AVP2HzVTOMVhDgLFNh0Dw1t/ru5WSvyY
         /AVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk9zTvOGYg/7h0P9oBkAjXmJ2i37UnFGJzgfDS7VBECCdYkOKE66iDrjN9P8BLxKrHKMkZ+o8Ve2dI+Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDk63LBtf8KBHNOtb9m8JnpYqTItbKTcl5agEJkSuNmLbaHfyQ
	YLf1mjrDRjeOzHNxooWRqAOAiVto/SWQu/VoqWZah+Kc6F3bp5g6C159HkAaUPLUkvvwhyGVyPy
	+CwcqxgyK/c88+4EuI3ktScbt7Vhlx+zbULFMfDnS
X-Gm-Gg: ASbGncu44UpRuDEfn8wEAmN7a2LhuKBjtT9aeUmzcrvf0lJ6LiMI48EgXplquWTdIlp
	ot3ZMBNLNErmTfCHl6nd/Pb7DwEhXApN0xu15V2ZLS84QgPfkUsCQ+GNwFSrS76FnSUAqSd88Fh
	FekiDaSkkWEUCwYagOQ5SL8vvycusE/yCR1U5Ao9gCK8FjrOdf9Vd3Zqo1v0JuLUUDBhVnFdPYU
	2cwNvUGJ2Oww5txh+/1CyLjtKBykA9Rn5Mnw93Z2AzmUoM=
X-Google-Smtp-Source: AGHT+IFwZmvt15CjtRBMXS3ba4sXrdVLhakTA7ioEZ6mRlIr97gFZDb6PmU3GNINPLWasYRcQklNiQPte0kKQBSw4k8=
X-Received: by 2002:a5d:5f90:0:b0:3b8:d519:3ec7 with SMTP id
 ffacd0b85a97d-3d1dd81d9c5mr874305f8f.13.1756542026104; Sat, 30 Aug 2025
 01:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829195745.31174-1-dakr@kernel.org>
In-Reply-To: <20250829195745.31174-1-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Sat, 30 Aug 2025 10:20:14 +0200
X-Gm-Features: Ac12FXyBpY8t2A18cpyy_OZI4J50wC5f7-Yku2KenAqxmVFbxJgG5M3dy8RDWfY
Message-ID: <CAH5fLgjM9f1k0re72DKht5HXi11acn_fU-bd9WnEEu5eZrpwLw@mail.gmail.com>
Subject: Re: [PATCH] rust: device: fix unresolved link to drm::Device
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:58=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> drm::Device is only available when CONFIG_DRM=3Dy, which we have to
> consider for intra-doc links, otherwise the rustdoc make target produces
> the following warning.
>
> >> warning: unresolved link to `kernel::drm::Device`
>    --> rust/kernel/device.rs:154:22
>    |
>    154 | /// [`drm::Device`]: kernel::drm::Device
>    |                      ^^^^^^^^^^^^^^^^^^^ no item named `drm` in modu=
le `kernel`
>    |
>    =3D note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
>
> Fix this by making the intra-doc link conditional on CONFIG_DRM being ena=
bled.
>
> Fixes: d6e26c1ae4a6 ("device: rust: expand documentation for Device")
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508261644.9LclwUgt-lkp@i=
ntel.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

