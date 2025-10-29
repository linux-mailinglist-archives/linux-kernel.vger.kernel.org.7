Return-Path: <linux-kernel+bounces-874956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B9C17C65
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 02:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BC844EFC13
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 01:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEC92D7DC8;
	Wed, 29 Oct 2025 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SESV8yLS"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F6A2D839F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700175; cv=none; b=QmspC66o9FiRI5blTHKEk0eyn0Rbl7G3uu44Dcq0W9dGDCYbTS6tpVzqnffa9w0DShHKNoSWFNBohfu64kQq9MOT5KrzU3KpZdn21qf/8Cwq5IUlrm0rWJYKB/T97sXYZdWNLuBtD9I0vHhYPFFpfeZs3Lxta2CjqbaE+vMl8aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700175; c=relaxed/simple;
	bh=KG6j54Af+fOUx03yW3EYN6fuy7/9pUuXoX8upU5x6JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5kywF0pPDlqeAcsz6LJjexmMo59Jttw9HoFUbSgm3ZdhuF/L8EORh/vLJi03qcyMbw6qXUdO3ethBR3vQcj/XPx/E1RA1eMmu8GT8vsE/aAKBmtzCAdlm06jXp6wTiXqdJuC70386Y6FJbUHQx/qv3CmiH+XstGmaoR3+Dvsck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SESV8yLS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-340299fe579so1860529a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761700173; x=1762304973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sB90dSKX2phgB5A3VJ7k8j5ArCwOgrNo4j2sqeiq7M0=;
        b=SESV8yLS9upvifE92r4f9mo3/61XC+EDSXTaBPm69w/eE5znbT/z8DHH/rNCmuNcEI
         l8m8bRXHLymiITlsdZSbLXgPv1aLiZ1dqlELp/cX5+5e2LJdAmNjT8pTSL3aiMtp/KHz
         xPvWKgcvyusrynN55JJvTemZO3CC9droD58eIWfGX/eNKnsjct4aaMPCD0PpA2BktfvA
         e3bDW/JEdaK0xSKc/yDcIhYo66njR6Ly1bf28BsKkHPCbhB5WgGgNh3SO1XfDf9YFl9Y
         WPupfoloKohDugkYcjEsozh5ieSq9ThHiS+nmyrO6+QDZlHK67nsCbB/2+5sXJ9JL1IQ
         wgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761700173; x=1762304973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sB90dSKX2phgB5A3VJ7k8j5ArCwOgrNo4j2sqeiq7M0=;
        b=q6UaR/kMCxf/p8k9+LpilNp9oZZoT0qRylFEc2OXZed+sPb4MTda0AOWy1ZIeMbwO8
         2vFeNgRvd8Q32MbJ5akgne4SFzf3ZEqLt/LjlCjoWcQC58f5RLvkY9bt+qBmPIMoZtMo
         uYewaIWHB6P+gyoP6mVy1yMii753q7sg+/5szYObU8ZeYQamrSBq/FSJSlYraUlQYncx
         a1cQ0xZWBA3MyGGboaIptZC2U+XQlBP0+kFUq+u0FsKa9jfxzm/XDnqrPEq8qp+E+RFW
         K+S9WOIHRe5uuQKlezFNqmzSuhmdYUxD0QZKWkgcMhKEQAPxrBfJnGjSn82BmAtaDmNQ
         ez6A==
X-Forwarded-Encrypted: i=1; AJvYcCXjKdIz4vKFuc2Lgj3hR7UpVykP2LUUEf/23aHJpuaq1339hKryUp+pGtTACNcUxh5T2dKhIApwRK9OKjU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8bgdtmHCJy8hLZd5rNXtNHidlfvdJWWsbGn/mWQS+Ou/uiOwT
	t8Zh5c2PkvqdfmP9s9CHfuBVnhkg4mbeblxwaGf0fmOPiooyl3/m6lfthm/Sb7+CzgdGCpbjucd
	Nx+0f6/tu1KYNBUsGsaILHDBMNV8DHHmrLQ4D1Mno
X-Gm-Gg: ASbGncvSWlvDJRdoDCd3AAYc4ourN8vdEO+jr+Bu2FvZfRHdSH06I6Uvw4ew5yap1rd
	HN5cP9DVSs1lHrMMbnUBNmaAj5AXczkbJmpknVgr8LAPJ+BKdYglOeq00y3nfIX5YYDTN7ZYmCK
	TgORdJTjID88tETxaTVQ/0aJn/Gs2/fvQXKeEUzEyDTbVE2rs7+r7/Yx9153B/pY7MS0qzAmWSb
	4fPoVciPOrQwSslzSaCwIGVjKWCnAOGhD68QVbhiYLpKosrlWXZr5146Cob
X-Google-Smtp-Source: AGHT+IG3UH+5oREGcodXi0zy45xRS2naoRS8wH1rpaPJG/KBPEw6R3NX+2bL2DECCTWYToSOfOnz+dVwvq/wY2132Ko=
X-Received: by 2002:a17:90b:5242:b0:33f:ebdd:9961 with SMTP id
 98e67ed59e1d1-3403a2a8d01mr1014438a91.28.1761700172872; Tue, 28 Oct 2025
 18:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029005448.495880-1-isaacmanjarres@google.com>
In-Reply-To: <20251029005448.495880-1-isaacmanjarres@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 28 Oct 2025 21:09:18 -0400
X-Gm-Features: AWmQ_bm5ZHgEwlmM5TfpwFYrr3DksCKslhijR9-fsp-t8LwLGiQyfpJPr1yXQeA
Message-ID: <CAHC9VhRp0QTAZqux8JbL1JUfLxMV9G22Q0rKZ5fQL2C_8mod_Q@mail.gmail.com>
Subject: Re: [PATCH v1] audit: Improve path logging for unlinked files
To: "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc: Eric Paris <eparis@redhat.com>, surenb@google.com, aliceryhl@google.com, 
	tweek@google.com, kernel-team@android.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 8:54=E2=80=AFPM Isaac J. Manjarres
<isaacmanjarres@google.com> wrote:
>
> When logging the path associated with a denial, the path is scanned
> to ensure that it does not contain control characters, unprintable
> characters, double quote marks, or spaces. If it does, the hexadecimal
> representation of the path is emitted.
>
> This can make debugging difficult in scenarios where the file name that
> was given to the file does not contain any of those characters,
> but the hexadecimal representation of the path is still emitted when a
> denial occurs because the file is unlinked.
>
> For example, suppose a memfd is created with the name "MemoryHeapBase".
> Memfds are unlinked, so when a denial related to that memfd is
> encountered, and the the path name for it is obtained via d_path(), the
> name will be: "/memfd:MemoryHeapBase (deleted)". Since the name has a
> space, the audit logic will just print the hexadecimal representation
> instead of the name:
>
> type=3D1400 audit(0.0:319): avc:  denied  { read write } for
> path=3D2F6D656D66643A4D656D6F72794865617042617365202864656C6574656429
> dev=3D"tmpfs" ino=3D75 scontext=3Du:r:audioserver:s0
> tcontext=3Du:object_r:system_server:s0 tclass=3Dmemfd_file permissive=3D0
>
> To improve debuggability of denials related to unlinked files, check
> if the " (deleted)" suffix is detected in a path name and remove it
> if so. This allows the actual filename to be validated and emitted
> if appropriate, making denials easier to read and more actionable:
>
> type=3D1400 audit(0.0:254): avc:  denied  { read write } for
> path=3D"/memfd:MemoryHeapBase" dev=3D"tmpfs" ino=3D67
> scontext=3Du:r:audioserver:s0 tcontext=3Du:object_r:system_server:s0
> tclass=3Dmemfd_file permissive=3D0
>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  kernel/audit.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

I'd prefer not to add any additional string processing to the audit hot pat=
h.

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 26a332ffb1b8..dcfa60e0277d 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2184,7 +2184,7 @@ void audit_log_untrustedstring(struct audit_buffer =
*ab, const char *string)
>  void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
>                       const struct path *path)
>  {
> -       char *p, *pathname;
> +       char *p, *pathname, *suffix;
>
>         if (prefix)
>                 audit_log_format(ab, "%s", prefix);
> @@ -2199,8 +2199,20 @@ void audit_log_d_path(struct audit_buffer *ab, con=
st char *prefix,
>         if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
>                 /* FIXME: can we save some information here? */
>                 audit_log_format(ab, "\"<too_long>\"");
> -       } else
> +       } else {
> +               /*
> +                * Terminate the buffer where the " (deleted)" suffix sta=
rts so
> +                * that audit_log_untrustedstring() emits the pathname,
> +                * assuming it doesn't have other control characters or s=
paces.
> +                */
> +               suffix =3D strstr(p, " (deleted)");
> +               /* Ensure the string ends with the " (deleted)" suffix. *=
/
> +               if (suffix &&
> +                   ((p + strlen(p) - strlen(" (deleted)")) =3D=3D suffix=
))
> +                       *suffix =3D '\0';
> +
>                 audit_log_untrustedstring(ab, p);
> +       }
>         kfree(pathname);
>  }
>
> --
> 2.51.1.851.g4ebd6896fd-goog

--=20
paul-moore.com

