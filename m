Return-Path: <linux-kernel+bounces-673917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CACACE780
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 02:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BC36189549D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 00:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E63F50F;
	Thu,  5 Jun 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="angRW34m"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C438DE1
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749082958; cv=none; b=fSY3dP0GQ7ZnUUrZxgjSFU6s9jguqbiZBbji+zWl52NmASYU6uCRj8Wo6MPSxkpVKNdlpgLRsowDi/iB/LDSNlatRuhtUoUqKjxJBN44cHiS5tyHNRzeHkC1h2lV8rod98arltvy6eUImnRTdSPkcJq48kOW8SjTa7kZ6c9EMJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749082958; c=relaxed/simple;
	bh=EHGIjtXSnhVWuj8W3if9/kBeCWZOJPIXUzlkSSJrcv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uNIOWqzkpj/p011N75hjs5GTwVimT9bO94UKKGqL0dOyKuUx69DdC2PwKWLyXLmvrW1voZvKKs8tUimdY4KRK/BPQP7FCV7lSrtymuAnWFxVXIO1NmZKwrNzA8OIyyLJyoRI7Q0hrGVGZR3B2htsdV19BQvnWR4+2Zs2d/4Q7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=angRW34m; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso441722276.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 17:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1749082955; x=1749687755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvU2lNKxDYw6fCnyd5ZPbHAvFewoQW9WJ+3ogFjIWtk=;
        b=angRW34maqZe/QKfbCk3Do7iigii3Ko8VT9ZnKngh3DmBp1RdHjlMrzxNCpYx3btPo
         Us9B1J81+WK6n793fiBskFHl6csFL3B2D+FU6qVCrWDSPmcfTBcIXKTUZtum69yjh+nY
         Of3v7bbpU2xQTRIS2jmtZo5GKMOFhLS3sKkmJkIrn+tk6ug+TJGjKkR2hvNt3jqO2Wxp
         9EI5nJeG6HJ83fRKt9vZWvuttM+6/TOz7fjIuTC+a649gHOXQSLjlSnLRyvoqr7XeCdF
         7QTD5B7zL0/T+8/4ZTjTDMoYH7kScoFDxfMub74VFDkBmW11iox8P8tkCHYsaULR6KFm
         ZgIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749082955; x=1749687755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvU2lNKxDYw6fCnyd5ZPbHAvFewoQW9WJ+3ogFjIWtk=;
        b=JA6IMiEFqyHVulc/9JPL6W9lpf7Hql4x6MNphAaoKmKK0MrknxKzXZ2jPQ4qttIOh6
         2fhvLz6xL9fUbpIu4cQ0VpozA5LjUg7n5flf11U/ZCA8jQsxA3i+BD/VFM3Tudz/I+84
         C4PtcnAQzjvs1uxo03nWvRAOXhbetxDNjXzQ9Xh+1ECGdiTQ2BS8247xdpRn5t4911BE
         5vkqxxyaNQSCqZMA3rAk5cjczZLJwipqxZU/HKQPEXkLdaLVJBrpZg8K7OHK5zsOOfpJ
         9hRZDePjaZrxSCRONA3pPXWa2VWVOS06pfWxVa7mWnfvFo9+auHwvYsGbpp8IpGACKTh
         zfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXn7SruhhkBdGCx1xhoSLhsLBtm+MHOa0ctBp/giyd7sZgLKd8pyg96OBpS1B0V4d6PfvDty3ODZEnmMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yM1G455NXDcFKQ8FPZC02FaMCwtx/8FUQYntj+a+P3U7rxx2
	sSvyFDOTJ56AeztO8VoAuyLDHL0vrlwXzgjlbO0nD9kXxq4qgCi0BgoyTWYhbUThMjiyoLOCrm1
	jCEJe+YuUqTqaLG3O+CmFI/6NcnFoQb5wBnT/138R
X-Gm-Gg: ASbGncuYWSa6zkFv6gn4k1wWYz8+68Qs0+hd+PKISHOkS6/tsxe3hbmAdNaclou3V60
	6XzQ5uMccEz8NnLNag0Zrw3wKwk+J1GlJ96KVF2jFuk0/E6XShMVDs4trdataTm+zgY6sc5Q/mR
	QrYRwV5hq3TDO8/MhP8A3e5gUpdBsZWZH52TaAvvOo+1Q=
X-Google-Smtp-Source: AGHT+IHyeD9vA1nF1N0CsN+xv6bObN3Il3RSVuQijJN0bEgczCU08xaJqqCrRvDKJkd53t1PwCS+M9kMdUmEej7JZRY=
X-Received: by 2002:a05:6902:18d0:b0:e7d:c87a:6249 with SMTP id
 3f1490d57ef6-e8179dbababmr7022769276.36.1749082955136; Wed, 04 Jun 2025
 17:22:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SCYP152MB62612944AD5E282EE26871DDB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
In-Reply-To: <SCYP152MB62612944AD5E282EE26871DDB063A@SCYP152MB6261.LAMP152.PROD.OUTLOOK.COM>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Jun 2025 20:22:24 -0400
X-Gm-Features: AX0GCFvU4j5x9GEYGbLXyBKZlD9q6nwLVRHA0q2PfeW81xhSUMGxDfooZeZ462o
Message-ID: <CAHC9VhTcRP=7b3YAU+16twKX8jktDRAUyuzkn92O4ZVyPaTBxA@mail.gmail.com>
Subject: Re: PATCH 2/3] security: add Lilium - Linux Integrity Lock-In User
 Module - Documentation
To: =?UTF-8?B?4oSw8J2Tg/Cdk4/ihLQg4oSx8J2TivCdk4DihK8=?= <milesonerd@outlook.com>
Cc: "serge@hallyn.com" <serge@hallyn.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 9:07=E2=80=AFPM =E2=84=B0=F0=9D=93=83=F0=9D=93=8F=
=E2=84=B4 =E2=84=B1=F0=9D=93=8A=F0=9D=93=80=E2=84=AF <milesonerd@outlook.co=
m> wrote:
>
> From 23d323f793b888bb2ad0d2a7a1ca095d5d64d0b8 Mon Sep 17 00:00:00 2001
> From: Enzo Fuke <milesonerd@outlook.com>
> Date: Sun, 1 Jun 2025 00:11:36 +0000
> Subject: [PATCH] Lilium Documentation
>
> ---
>  Documentation/security/lilium.rst | 402 ++++++++++++++++++++++++++++++
>  1 file changed, 402 insertions(+)
>  create mode 100644 Documentation/security/lilium.rst
>
> diff --git a/Documentation/security/lilium.rst b/Documentation/security/l=
ilium.rst
> new file mode 100644
> index 0000000..bd25ff6
> --- /dev/null
> +++ b/Documentation/security/lilium.rst
> @@ -0,0 +1,402 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Lilium (Linux Integrity Lock-In User Module)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Enzo Fuke
> +:Date: May 2025
> +:Version: 1.0
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Lilium (Linux Integrity Lock-In User Module) is a Linux Security Module =
(LSM)
> +designed to enhance system security by providing fine-grained control ov=
er
> +critical system operations. It implements a modular approach to security=
,
> +allowing administrators to selectively enable specific security mechanis=
ms
> +based on their requirements.
> +
> +The name "Lilium" is an acronym for "Linux Integrity Lock-In User Module=
",
> +reflecting its purpose of locking down various system operations to main=
tain
> +system integrity and security.
> +
> +Security Philosophy
> +------------------
> +
> +Lilium follows the principle of "secure by default but configurable". Al=
l
> +security mechanisms are disabled by default to ensure compatibility with
> +existing systems, but can be easily enabled individually through the sys=
fs
> +interface. This approach allows administrators to gradually implement se=
curity
> +measures without disrupting system functionality.
> +
> +The module is designed with the following principles in mind:
> +
> +1. **Modularity**: Each security mechanism can be enabled independently.
> +2. **Contextual Logic**: Security decisions consider the context of oper=
ations.
> +3. **Least Privilege**: Restrictions follow the principle of least privi=
lege.
> +4. **Compatibility**: Works alongside other LSMs in the Linux security s=
tack.
> +
> +Features
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Lilium provides the following security mechanisms, each addressing speci=
fic
> +security concerns:
> +
> +1. **ptrace restrictions**
> +
> +   Controls which processes can trace other processes using the ptrace s=
ystem
> +   call. This helps prevent unauthorized debugging and memory inspection=
 of
> +   running processes, which could be used to extract sensitive informati=
on or
> +   modify process behavior.
> +
> +   When enabled, only processes with CAP_SYS_PTRACE capability can attac=
h to
> +   other processes using ptrace, preventing unprivileged users from debu=
gging
> +   or inspecting other users' processes.

I agree with all of the other feedback you've received, but I'm also
concerned that there isn't a common security concept tying all of
these access controls together; they are all standalone controls that
can be toggled on/off either at build or runtime.  While we don't
necessarily require a full, formal security model for new LSMs, if you
have some reasoning as to why this collection of capability-based
access controls belong together in a LSM it would be good to share
that.

Even with a better explanation, and some agreement that it is
reasonable, it seems like these checks might be better suited as Yama
enhancements rather than a new LSM.

--=20
paul-moore.com

