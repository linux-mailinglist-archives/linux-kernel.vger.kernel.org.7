Return-Path: <linux-kernel+bounces-867633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B59FC0328A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3667A4E6CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7F34C99B;
	Thu, 23 Oct 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X7Xf6P6d"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89634B433
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247221; cv=none; b=UjVQvmbhebQR8I8I4pqNdVBcsHtSjEatpPU5sLQX5GWN+J69epXQil2jooFfjXn8lp0LkdyI1fCRNcQkogyIQN4Xk/go/SedpvOquvYbdarWfnrCLndC045FTuK/WmtNCce5ci3x44z4CIlpq8ooYdhNzZcgZvnKmhPaA3t45xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247221; c=relaxed/simple;
	bh=SpBV0oAtNIOIUcUxfTe6GOHXwqQoTjBsdOw0X372+0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqQDttMeygCanSUItgsdCXTPNfAPPbJjYJGeoUIDT3c7gHHXNvEbBS8v4ZYHUGL/7ciZiPSNcxrtCDxjJzHL8x9DRMNPeZweQrvyh7s69VVoekKsnz69rAXjyZeUExllZhis62PQVzOYU/Eh6rCOKyGLa7R4HHlVmdtdO8ufGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X7Xf6P6d; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78f5d692d09so2105756d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761247219; x=1761852019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7Jc2L0p0jcJ2tGUUd6Ppdki3QU4yD7rPhAK5dStwsA=;
        b=X7Xf6P6dP0Byre5wcouvB+FsXlRFa1pYYuzRZ8DZm2Ixle7Da8KRHFGmsuJQab2MML
         9NCFD61It4E11upuMIFEwxr6eeF9T+VVyOZw8h0twTVgsUd5HNzZWYPfF6Me/wTvv82U
         TpQ9tdKBEiCUoLyqPKRuSLSHr2cAfQIkXzgHDxGLaqGkuVFnYEZKcTm1dfqqv5KQ3uuN
         w/P/C3h18Xo5rJJsmWsogCdMsa1OdLfnLGWRWs4WVfOf2h+rGG6SfNNjIyfIvTwNg4QH
         16BE/HCk/0Oya74IvXr++1JP1vQZo7ujzdDpw7rC5WBZsIhCcCK/HzlzB4wyRnEVwsfe
         gtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761247219; x=1761852019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7Jc2L0p0jcJ2tGUUd6Ppdki3QU4yD7rPhAK5dStwsA=;
        b=TG19J1Yb581IidsmYtCeR+5RzWr6ajftsy+RbvenhRpg+o/5sP90NYo3p2k6ms7Ycq
         qVQbFM+ggV8DXjcXKtRh6qgDryti+aOTvaRO7bvULi+SDBZfVYfm///f16nmd3F7gU9y
         cI6Ahy3eqFScCdsXBvqpkfa4GyXFO4o6rQafWvBzfYZtF+/Q2KRuceyuLlYIDeoPhXfi
         UBwgU2P+f3dPLbpdgpUHgiXiNVhCh29ocSedBviRiJz4yP/bfUMog01Ct4UV2Idm5GWA
         60M5lDGrPFnVQo0aPZZkCD9IdZhLrNIaDIVwvlPGTWcnnAprHOOxbuJYywjvYLdbdJ06
         eDWw==
X-Forwarded-Encrypted: i=1; AJvYcCUx7LwOIIjwALUVutYf8DID+FsnQjjwbbu0WDRfF7ry4O0mZaoyiCFyPH7zwVLld1lHCGfYKqNwi/YGHbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytjCBxE29fBMilBxTesP6jbtmVHUc4kJiy1v1T9YXl5nxlhK3N
	zFb6Y7I5o7mUDo23W30IXvGN+vawtROgioDiOu7WovcXoVys7MQnuYo6pnTZFJ9QUWCmWOyoGal
	PcU1AKVFeNWJJI4WYFGTB6LCN7qOt5YOXH8W3jZ0mUA==
X-Gm-Gg: ASbGnctOg0StcraSpnfrqN4vGpYViaBu5VqX3RwVHk7lRpzH1VafkpHCLX1QGkhpVDL
	4EUBUlbK0SDEx0UJNP1MnpluhTudR73uGt6FJBOBgLaf+q7YT4u6mhV8I3VfK8tmt/eX4y3QsSy
	xG7FMiu6kLSLbpnzj7SQT8soTwZ/iE3iaCTNCgqcaGzAUgzfrW3x4O8ePYCr4yCLuYB/bkc/NQu
	iETVw+Wt+69oYfRR2eh8NZSMiPXs1ykq9/E+b8HapOh5Diypf2hZQp7Fb9HNzvnSSgMLA==
X-Google-Smtp-Source: AGHT+IGkQvnw+P4oceXyA5t5qG3cgWb0laXxzyqv1FiNzsffgaXuAVfp39vbfz48HT80gEehZCMHTKqYfeFUsV9baTU=
X-Received: by 2002:ad4:5b87:0:b0:87c:21db:cbbf with SMTP id
 6a1803df08f44-87de714bf08mr100164216d6.4.1761247219089; Thu, 23 Oct 2025
 12:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023164401.302967-1-naresh.kamboju@linaro.org>
In-Reply-To: <20251023164401.302967-1-naresh.kamboju@linaro.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 23 Oct 2025 21:20:06 +0200
X-Gm-Features: AWmQ_bm15EalXbAnjLs4CmLjdIsxVVIbblnMfG02uQMZQ8ouizbiUwGmA3HVblI
Message-ID: <CADYN=9J1xAgctUqwptD5C3Ss9aJZvZQ2ep=Ck2zP6X+ZrKe81Q@mail.gmail.com>
Subject: Re: [PATCH v2] ioctl_pidfd05: accept both EINVAL and ENOTTY as valid errors
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: ltp@lists.linux.it, lkft@linaro.org, arnd@kernel.org, 
	dan.carpenter@linaro.org, pvorel@suse.cz, jack@suse.cz, brauner@kernel.org, 
	chrubis@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	regressions@lists.linux.dev, aalbersh@kernel.org, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, benjamin.copeland@linaro.org, 
	andrea.cervesato@suse.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 18:44, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Newer kernels (since ~v6.18-rc1) return ENOTTY instead of EINVAL when
> invoking ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid). Update the
> test to accept both EINVAL and ENOTTY as valid errors to ensure
> compatibility across different kernel versions.
>
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Verified this on arm64, and the test passed now.

Tested-by: Anders Roxell <anders.roxell@linaro.org>


Cheers,
Anders

> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> index d20c6f074..744f7def4 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> @@ -4,8 +4,8 @@
>   */
>
>  /*\
> - * Verify that ioctl() raises an EINVAL error when PIDFD_GET_INFO is used. This
> - * happens when:
> + * Verify that ioctl() raises an EINVAL or ENOTTY (since ~v6.18-rc1) error when
> + * PIDFD_GET_INFO is used. This happens when:
>   *
>   * - info parameter is NULL
>   * - info parameter is providing the wrong size
> @@ -14,6 +14,7 @@
>  #include "tst_test.h"
>  #include "lapi/pidfd.h"
>  #include "lapi/sched.h"
> +#include <errno.h>
>  #include "ioctl_pidfd.h"
>
>  struct pidfd_info_invalid {
> @@ -43,7 +44,12 @@ static void run(void)
>                 exit(0);
>
>         TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, NULL), EINVAL);
> -       TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid), EINVAL);
> +
> +       /* Expect ioctl to fail; accept either EINVAL or ENOTTY (~v6.18-rc1) */
> +       int exp_errnos[] = {EINVAL, ENOTTY};
> +
> +       TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid),
> +                       exp_errnos, ARRAY_SIZE(exp_errnos));
>
>         SAFE_CLOSE(pidfd);
>  }
> --
> 2.43.0
>

