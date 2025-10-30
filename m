Return-Path: <linux-kernel+bounces-879203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270CC2283D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D7A1898431
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95126E16A;
	Thu, 30 Oct 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nuv4oOLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530FE2F5A23
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761862135; cv=none; b=ZByT2N1zcAXbpqr7IFs+4GrzOd2FDshy1XC6hiLiRY726W5ZRuLkCLZmpnNworqAooK/MkrfkxjBi/vctkxzqnfwUXbF4kGRQ2OCNPiaxdimx7BTtz4TL5ggtX0VSLysbQsN4TpAMx5RHUQRBuzS4Fn61QctVR9lrWGHZBaE/Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761862135; c=relaxed/simple;
	bh=QCaxQQp22Ou0uBRcqdmljdY4A1uwLgCFWyFq2Al5hH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhMGLB83hxXBRy99rn+fNN0lFMrq5QVposNuew6urhx2vLMaeM8mEFAqExc0dFU02ZPuzyJXI9fYkQLYn2jzh8kRlTCizqiZt8YxczRnC5MDCfqRmUFVkHsBHa26bo3eC3oZpZdBitva4fH1PQQsdJ6774UckO3oe1tfNPL+/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nuv4oOLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0833BC4CEF8
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761862135;
	bh=QCaxQQp22Ou0uBRcqdmljdY4A1uwLgCFWyFq2Al5hH0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nuv4oOLn1T4nMLdqbCNuzl0x9YUWtMIIav7oZMEPLyzSI9jZSAH3ixOWmH3g655NT
	 OT2H1DzuvDV+vQTh+fN18t5YPY/ZS3bCVI1J9jjAhRKw1tY/dQgt/hip+qTVxCDmHE
	 M8SXwJUbKyLD9SdmybWHOStuEc1s35vR5tDrjZVq/tan4ai5vRZ+A7KwZ9fl83cPE6
	 HknJgXdSH4SMPTV3kcphvEEfBoty8u9u2t0k9FYbDaBwFPv2U2LmgKFqtPPQ9Q3AiH
	 zwQPS4ugvZi2Q93qc8M6MTP0KghAjFdsu/hWJ0N0gghNin2pIw9Q2gttp1yuDsuVf0
	 KKCWbMPGYP2lA==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6cf25c9ad5so1160734a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:08:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIZQAdbHyFu8eOVceNS1hXMcNB3DIzRgPFq44chK4RPjxbEezZWTi8ND/tWD/lS3MTDAGol2DKP9oufV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIFoWnh5tMrWISKyUOQtrX6oH3pfXWRu4JJfJd3qNE4u+Lv5R
	+TCh0p8VC023H56YjmOEDzAcYtwBPtIkJXgE78llZSnpw9/mm9PEJnFtevHCXvi7NjNpnJuxo6q
	RzKRGZ1AOQ9jpS3xpLKN3GFagTryIBDo=
X-Google-Smtp-Source: AGHT+IHEHiUBfUwlW3je89mFpeopWhX58UhG4swXErqOcigIFZnDoujTVPO1LSZCUlt8UHyapOY1EcH0H4JbtJ5zFbU=
X-Received: by 2002:a17:902:d4ce:b0:293:e0f:3e3 with SMTP id
 d9443c01a7336-2951a440d24mr18670675ad.29.1761862134648; Thu, 30 Oct 2025
 15:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023233656.661344-1-yanzhuhuang@linux.microsoft.com> <20251023233656.661344-3-yanzhuhuang@linux.microsoft.com>
In-Reply-To: <20251023233656.661344-3-yanzhuhuang@linux.microsoft.com>
From: Fan Wu <wufan@kernel.org>
Date: Thu, 30 Oct 2025 15:08:42 -0700
X-Gmail-Original-Message-ID: <CAKtyLkHVQuR+5N5qimAb=+GpGFpDt7YRq+jYC07R4wfRE6xUgg@mail.gmail.com>
X-Gm-Features: AWmQ_bm80q11eSbg7G-yU6QtbTi5-vtrJoIqly0ibkMkpjNe7gqJ2xgghoMMvTc
Message-ID: <CAKtyLkHVQuR+5N5qimAb=+GpGFpDt7YRq+jYC07R4wfRE6xUgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ipe: Update documentation for script enforcement
To: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
Cc: wufan@kernel.org, paul@paul-moore.com, mic@digikod.net, jmorris@namei.org, 
	serge@hallyn.com, corbet@lwn.net, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 4:37=E2=80=AFPM Yanzhu Huang
<yanzhuhuang@linux.microsoft.com> wrote:
>
> This patch adds explanation of script enforcement mechanism in admin
> guide documentation. Describes how IPE supports integrity enforcement
> for indirectly executed scripts through the AT_EXECVE_CHECK flag, and
> how this differs from kernel enforcement for compiled executables.
>
> Signed-off-by: Yanzhu Huang <yanzhuhuang@linux.microsoft.com>
> ---
>  Documentation/admin-guide/LSM/ipe.rst | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/LSM/ipe.rst b/Documentation/admin-=
guide/LSM/ipe.rst
> index dc7088451f9d..1063256559a8 100644
> --- a/Documentation/admin-guide/LSM/ipe.rst
> +++ b/Documentation/admin-guide/LSM/ipe.rst
> @@ -95,7 +95,20 @@ languages when these scripts are invoked by passing th=
ese program files
>  to the interpreter. This is because the way interpreters execute these
>  files; the scripts themselves are not evaluated as executable code
>  through one of IPE's hooks, but they are merely text files that are read
> -(as opposed to compiled executables) [#interpreters]_.
> +(as opposed to compiled executables) [#interpreters]_. However, with the

All looks good to me, however, we could also update the
[#interpreters] reference to userspace-api/check_exec.

-Fan

> +introduction of the ``AT_EXECVE_CHECK`` flag, interpreters can use it to
> +signal the kernel that a script file will be executed, and request the
> +kernel to perform LSM security checks on it.
> +
> +IPE's EXECUTE operation enforcement differs between compiled executables=
 and
> +interpreted scripts: For compiled executables, enforcement is triggered
> +automatically by the kernel during ``execve()``, ``execveat()``, ``mmap(=
)``
> +and ``mprotect()`` syscalls when loading executable content. For interpr=
eted
> +scripts, enforcement requires explicit interpreter integration using
> +``execveat()`` with ``AT_EXECVE_CHECK`` flag. Unlike exec syscalls that =
IPE
> +intercepts during the execution process, this mechanism needs the interp=
reter
> +to take the initiative, and existing interpreters won't be automatically
> +supported unless the signal call is added.
>
>  Threat Model
>  ------------
> --
> 2.43.0
>

