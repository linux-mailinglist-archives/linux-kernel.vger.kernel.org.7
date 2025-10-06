Return-Path: <linux-kernel+bounces-843434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED91ABBF2CA
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 22:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85B44189BAEE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519732D5436;
	Mon,  6 Oct 2025 20:19:35 +0000 (UTC)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9002638B2
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 20:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759781974; cv=none; b=T8OMuRgih7UlRq1ONy5JBgwWxsH11coFu+NtFsZAP0UiwYzpfX5NwaMUYW9kSqp514bvDEAkLd7Ymg1flZoXDbR+L+c2c1lI0u6RRPteQeTeB4cX6IE0TlKraTO+kqDl/blxxjqCbl0SVOMFVY2K7zLK4dUlCUoXcBa0mBIta2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759781974; c=relaxed/simple;
	bh=8pUFWkCcsBhJoc8uPEjlLZ3fwdPT2JCj1o8+awA34WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/Gkc4w4Ed5nEp8HYCLPKyoT5F1sWXeyvT5RJj28YBJxjfFkNW2MRiVhTGlCXDG650N3pyLvMzHHqKZVJfxhIjGvuxDLplYIscV6ezwgCNSRd9duF5LpnChQVxiZvdndCQXgwe+qy1QJurDXf5/J5o+o40ClVnUTKhVkKh5sThE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-42e7b22e007so16742785ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 13:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759781971; x=1760386771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMQ7AMWhdctXnD7KUrakUOl3r47iwY0bunSrG+xUVBs=;
        b=V3yfcQejVqpRjchgyrZXjnHuRpoiVpB0Nj6iBNF2cmrvR8UzEkBf7PZXrXPtf8DIRA
         2ck3XpzjrbgXh1smm0WdhjNMYaV/+RfN2aSpCIytdf9l+I2mlUluqb61QZ3UYwdKknXU
         OHPiKvgvzhlQ+H8c231auOys6YFUnU+GiMGUQm+IvA7Sqvbiq4W+ZezzsZUBBTrwbw9Z
         RBWOG5liMMS6VHQTr9Owgw1iLXLe8vpkz6zFo7WW716JYnBzRlN9rafNNAKDICqC3W4r
         DKnFyhIUZiCTbZC1NpF3XtTGVL6VrqePKsqha+tZ+6/IkwGQGldPje35lnnwSuLzNFAQ
         0Jww==
X-Forwarded-Encrypted: i=1; AJvYcCWpwTfjrM1h5kIxg83Q6IlPRqHhCeS9ItxvaAI46vQhFt1IbnKTzN1Hk9e//8vIvy85A4RdbAHdVfDoiPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzluWsXLrCKr5HRgMtg09j3RLXHkM2+5tkqu/Ao4RSEiq4bwhoh
	xEYxUmIB5zHx8d3A1uvOqWV9DAWNYVF7/SaV0jW7y3NAA+1eWvG8cGwPiww+2DWEb+C7xQcMMOY
	M8XW2/yS5/op98ZrUnt82xA4JpXhQ1zDBHrGQWjzN
X-Gm-Gg: ASbGnct/V4wUrYYGMSsJkkz/P9TWovGYVaNS4b7eTzTZ31reeGKgQ9h8Ost7V3cKDJS
	fKTSQNlP4eaE1fNy7rkN6h8ITxNW4GWzvfIlZQrdHJsUN1As9KcYNHpM+dkCEqDRR+LOasJqGjV
	0Tb6zAI5/M7jbHzNBUwA3xA5ngd8KbS2dsloWOmouLhm8nd3sZaRk0rHUSu1gvIm1216J783ztZ
	ljEvRCgPBFPMwi6rDJmUe4t2gMaX5hFvw==
X-Google-Smtp-Source: AGHT+IHRsp5f2Ku6tRb0jzYKixpe8eVlAjBgkS13HoHpwiJO4HW1LYKeuVIAV6O+Y2oX7uDDLHkb1J66/VTyrDNExLc=
X-Received: by 2002:a05:6e02:178b:b0:42d:8a3f:ec8b with SMTP id
 e9e14a558f8ab-42e7ad01f91mr194991055ab.3.1759781971030; Mon, 06 Oct 2025
 13:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>
In-Reply-To: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>
From: Justin Forbes <jforbes@fedoraproject.org>
Date: Mon, 6 Oct 2025 14:19:20 -0600
X-Gm-Features: AS18NWACojPXOJnwcNavqYHbaQyGIFY7GHsRyGCpNIUDTuuHWfnt5-IAZ7A22L4
Message-ID: <CAFxkdApQVEqCjQMAUqy8cuKnMy8GY9j+brgPZBkxCpeGi5xHxA@mail.gmail.com>
Subject: Re: [PATCH RESEND] powerpc/tools: drop `-o pipefail` in gcc check scripts
To: Jan Stancek <jstancek@redhat.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org, 
	joe.lawrence@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 9:31=E2=80=AFAM Jan Stancek <jstancek@redhat.com> w=
rote:
>
> We've been observing rare non-deterministic kconfig failures during
> olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
> disabled and with it number of other config options that depend on it.
>
> The reason is that gcc-check-fpatchable-function-entry.sh can fail
> if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit while
> there is still someone writing on other side of pipe. `pipefail`
> propagates that error up to kconfig.
>
> This can be seen for example with:
>   # (set -e; set -o pipefail; yes | grep -q y); echo $?
>   141
>
> or by running the actual check script in loop extensively:
>   ----------------------------- 8< -------------------------------
>   function kconfig()
>   {
>     for i in `seq 1 100`; do
>       arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh \
>         ./scripts/dummy-tools/gcc -mlittle-endian \
>         || { echo "Oops"; exit 1; }
>     done
>   }
>
>   for ((i=3D0; i<$(nproc); i++)); do kconfig & done
>   wait; echo "Done"
>   ----------------------------- >8 -------------------------------
>
> Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-functio=
n-entry")
> Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
> Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh | 1 -
>  arch/powerpc/tools/gcc-check-mprofile-kernel.sh           | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh b/=
arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> index 06706903503b..baed467a016b 100755
> --- a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> +++ b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  set -e
> -set -o pipefail
>
>  # To debug, uncomment the following line
>  # set -x
> diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/power=
pc/tools/gcc-check-mprofile-kernel.sh
> index 73e331e7660e..6193b0ed0c77 100755
> --- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> +++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
> @@ -2,7 +2,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  set -e
> -set -o pipefail
>
>  # To debug, uncomment the following line
>  # set -x
> --
> 2.47.1

Would love to see this picked up, it fixes a problem we have run into
with our CI.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

