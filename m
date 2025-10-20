Return-Path: <linux-kernel+bounces-860123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C65BEF599
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65E5C4E45E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F006B2BF007;
	Mon, 20 Oct 2025 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxydRCSI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569961C695
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760937793; cv=none; b=ResstFhKJDmHJdi711/McRZGkVwjUuJThdcogDvT6Yp5hFx0w645fxQlMIBx16uWtfXnTaPbcmUryiZqM2Md+Lf6QmtnJpnDuSJI/VBhTNEA1JhvCxYzYRUo21KpAG+23ZcCW4XX3Zw9MsnlStoSnLQztb6K8M5mnNn4yO1832w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760937793; c=relaxed/simple;
	bh=541CBnuU6tAvhUJ2HN/GRWsNtg7O/KTzb7kmanYH/aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEAejq8pR16F2ga+DoJNGfstphW7r9pQFYP93cU/eVyOYkvaRFbD2W6lHv5ksLde3AlPF/7OXkdsJ5i7+0zpS2rievNc6vu6heyevxLx9yXj6KdqcwfoahRFrYYPepKq4DA+fspS3lr69Oo8fxFeEPFvzX8N38TUhuNE6WJQ/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxydRCSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F12C4AF0C
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760937792;
	bh=541CBnuU6tAvhUJ2HN/GRWsNtg7O/KTzb7kmanYH/aQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QxydRCSIEBxFhG6u+LAKxn1jxqgIZGpqkskNfTa+lgSZG1tKj+WuSWKO4eMqoTF/n
	 vE6E/x5mcP4FMY+gaPckKfoDKj6CdvGLmEv84U7+Jx5uGS3Y4hB6gwuD1JFfegLS8P
	 qYTSyQlNSWPImPfR+Y/vKJf4ElhehDt7Ae+vQIrr6eB44oDZDSdUDG4V1X3c3g90BD
	 4GFsgDWYm3fqX7Z2G8dSZ89mbS7pYqQ0sSHWDguQkf6Uov3FNStx5KbM2NIbPbSJhd
	 sZbNTQPqobda9eMqpX+ZB218KEjDjJ+xAyqU8Mg2oK56CeQBdZUmeQsvFdw/0ZCFWD
	 zVjOia7TlK5nw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso3703728a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 22:23:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+YMxYV0XGg/P6pBQAxb1Qq7LloMLG1mFCa2ucoeC8F9vlc1F3BagxNX1+nTrUeLftDjtFh27pMuvfobY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFi/uivGEQCVCTvPgaHvBBND3S7QwgKlC50Q+SMGSNB8ClkwA
	89g1ZWis6WrKX0J2AlpoBXZHbZ4cpGetFXLD5iAQ2bJ7/PdM0jciK6SBNcHXiCMca5DLF7DGh9o
	Z/VJTbAYt+dKbUqtkF4BdHeP/9LARR88=
X-Google-Smtp-Source: AGHT+IHh6jaRs67V16v3i5v5ED2up5JQbzas1VmItlc2AENJKIsVy5aUS2g0XI+6c5YEe/1RlL6HVGjZBAMqLe6Z08g=
X-Received: by 2002:a05:6402:461a:b0:634:ab80:d84b with SMTP id
 4fb4d7f45d1cf-63c1f6c42c3mr11096057a12.32.1760937791404; Sun, 19 Oct 2025
 22:23:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014071917.3004573-1-chenxiaosong.chenxiaosong@linux.dev>
 <20251014072856.3004683-1-chenxiaosong.chenxiaosong@linux.dev> <20251014072856.3004683-2-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20251014072856.3004683-2-chenxiaosong.chenxiaosong@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 20 Oct 2025 14:22:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8j6LjAvzBvKh9N3nvtqacLwLQ24sHKHu2Wh3vT1NtBYg@mail.gmail.com>
X-Gm-Features: AS18NWC4-DM8NQ0BjaBa1bSqV0taN_ksPTRD-i0laebSCAFqSlVTyD0TFBz2YTs
Message-ID: <CAKYAXd8j6LjAvzBvKh9N3nvtqacLwLQ24sHKHu2Wh3vT1NtBYg@mail.gmail.com>
Subject: Re: [PATCH v3 12/22] smb: move some duplicate definitions to common/cifspdu.h
To: chenxiaosong.chenxiaosong@linux.dev
Cc: stfrench@microsoft.com, metze@samba.org, pali@kernel.org, 
	smfrench@gmail.com, sfrench@samba.org, senozhatsky@chromium.org, 
	tom@talpey.com, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, bharathsm@microsoft.com, christophe.jaillet@wanadoo.fr, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:30=E2=80=AFPM <chenxiaosong.chenxiaosong@linux.de=
v> wrote:
>
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> In order to maintain the code more easily, move duplicate definitions to
> new common header file.
>
> Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
> ---
>  fs/smb/client/cifspdu.h    | 153 +---------------------------------
>  fs/smb/common/cifspdu.h    | 165 +++++++++++++++++++++++++++++++++++++
>  fs/smb/server/smb_common.h |  80 +-----------------
>  3 files changed, 167 insertions(+), 231 deletions(-)
>  create mode 100644 fs/smb/common/cifspdu.h
>
> diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
> index c86a329e5822..9f42b0469d1a 100644
> --- a/fs/smb/client/cifspdu.h
> +++ b/fs/smb/client/cifspdu.h
> @@ -12,43 +12,10 @@
>  #include <net/sock.h>
>  #include <linux/unaligned.h>
>  #include "../common/smbfsctl.h"
> +#include "../common/cifspdu.h"
I prefer naming it smb1pdu.h.

>
>  #define CIFS_PROT   0
>  #define POSIX_PROT  (CIFS_PROT+1)
> -#define BAD_PROT 0xFFFF
Moving just this one doesn't look good.
Thanks.

