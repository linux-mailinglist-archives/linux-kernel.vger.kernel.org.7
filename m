Return-Path: <linux-kernel+bounces-756867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9EB1BA8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3214716BF87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A59A29AAEF;
	Tue,  5 Aug 2025 19:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HliLs8Np"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC75274FD5
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420466; cv=none; b=T4S4yxQKmv3pU/x2U/TgCMQyYtT/Wy3wNmeTUn8jWdvLQ+bRuTyHfyxqeCKQgHc9JovNMF6S4rfHgz9vLnN/L+auYYP43X+/orHzr6vkTFwQePGDCfjG72M3TsmjNi6ZsvG2B9FsyPWMUno9EfoIQP/35DQYCxmlJYHtsg2QPBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420466; c=relaxed/simple;
	bh=1Krwh7FobQRcREyaRrEQ/cZSl+wxFYPAAxZAK3zDSnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PheyufRHKBURj37ukTXXGo90LGPELga88DRXeWECBz6/tKv7N2nhgV8QxWnOFGqJukZSQm+gpSI8Wcrdu4IyeiBOCzT7P7w78Hvfh98LRMhxFo9trIaH3coUGpMT9lcapXK2S3PhHBSyeVDu3/dTzY8clFf3nJVJJnPwLV6+4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HliLs8Np; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b423036a317so3300981a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420463; x=1755025263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqbqG+VYQxLPKNsOYQV05DishlUwU606vMY98kUStrY=;
        b=HliLs8NpTBAuorR0X6Sg/pvTVZn78RNMb0iiSSPo/aLovWQdcin0PGlFuLDVXgGMWR
         yZkjJEOehor0GpnNDZvwlpmi+uUOJp/miDZ1+WAwRh3HuP2FsKNM/jjMMlyfvoFSGQ5X
         qUV//b1u6i/xsH3k4tSnBd/wTWff4i+u+0XxwrsNdFWdr9bgczD+JwyvhYFKJZuHobEh
         8YsbzXbQn8ceKsfKuYCrWSh4kHQkQCUMhcUsF7fru9j8m3h67ksNp5S8lTi0bpCKark3
         P7x0qgUgkTP1FYu1b6WRzsyuqAEMCvghiE/OQSanGx/PidOLIZEwUH5xw0uL5mm0vEL+
         yGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420463; x=1755025263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqbqG+VYQxLPKNsOYQV05DishlUwU606vMY98kUStrY=;
        b=JjKt7CMzooCzOvKtN84Lxpxr/i8hDe05yVjvR7TY3hJghoawLlcZoyILUgxw7IEcd4
         ZECMhplIABOe2ojEn+XmBFlSA7ObOCvKwjqBaO9UzEp6O3K0s1AVvfXyNzcD5COyeae1
         Ky0C/tM7JGIvuA3p82UCL6HUUWGvHNwoTSElqid8dSoMy7Q0+QSAacPHnbIwYRcdO+Qs
         oTKKxXlMiFMp3QSdzn5Fkmw08cpqPrGywB2CwywiZbzSScFGfeFkQ3CiP3lEBrX+NwzA
         gEYqD7IQ3D5SokdezlrdtCfSOftq8Mq7COLdO4KyieVe5F8ZrgAqM+mcAYkmEiibDOgM
         PsBg==
X-Forwarded-Encrypted: i=1; AJvYcCXH0hiOyUOT48B9kS4SOGhDPwAXruqS+kgUX87AvrBEJ4pc32XmTSMZpMcpXuVkz7FV1VXRfHECAn/s4zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrOPM2fYLNOgv5Ick1E5vKeqGHe1kOLxZUZkV/lyGMI5pdjZT
	1HU9krkoGRtrBptaFtAHn5dK7iBmeXwy5OF+eLjTUBUfKSvLqa04xkSU9HoOJm3SERgJhyeZ/cS
	X4O3+OXtRYQsSMZyQX+m2h+rtAdj+26Ih9RJMtYwj
X-Gm-Gg: ASbGncswVWE0xBJO8JiZZXrTUObuUkuYDQIKEa7g0lj2zAaK0tQW5vEj22wvyGqw4zF
	c2DlCOG92BnuU6UpTv8drw9UC0ktr6zu/w6jaGCk7W9MY0jpM10okgLXc+H7JOvWxWX3jk60UYU
	X9Di5fY/ECEBToxo5wZuHWVwJ1RsKcFCfiWfRrptyTOpLnky/TaauSk7NQWwT9MnYnUJlgqEI14
	DLkmYE/dFBJkwME5eOvfEJEQox+ag7i+JhDCg==
X-Google-Smtp-Source: AGHT+IHCLnUMZEnBTd9aRh9NH9ZiXKIeQVodIqM9YdjvCELP3pwRah8p6LpocyUTBWFy/TFpXkyzkolaS50sngI+iqg=
X-Received: by 2002:a17:90b:1c10:b0:312:959:dc4f with SMTP id
 98e67ed59e1d1-321161da11emr16503491a91.5.1754420462096; Tue, 05 Aug 2025
 12:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250802092435.288714-1-dongml2@chinatelecom.cn> <20250802092435.288714-3-dongml2@chinatelecom.cn>
In-Reply-To: <20250802092435.288714-3-dongml2@chinatelecom.cn>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 5 Aug 2025 12:00:51 -0700
X-Gm-Features: Ac12FXzTuA4HMKsW7fdVVKpIo_5_0_S7ESYLcz_iQDdsIdyslQiuGk4V2pjHPR4
Message-ID: <CAAVpQUBAk=339yyCnG+hDnHEu-O1+WPnAVqX=X9H22T=POQ3Bg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] selftests/net: test TCP reuseport socket selection
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, kraig@google.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 2, 2025 at 2:24=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> The test script is provided by Kuniyuki in [1], which is used to test the
> selection of the TCP reuseport socket problem.
>
> Link: https://lore.kernel.org/netdev/20250801040757.1599996-1-kuniyu@goog=
le.com/ [1]
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/testing/selftests/net/Makefile         |  1 +
>  tools/testing/selftests/net/tcp_reuseport.py | 36 ++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100755 tools/testing/selftests/net/tcp_reuseport.py
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index b31a71f2b372..0f4c3eea9709 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -117,6 +117,7 @@ TEST_GEN_FILES +=3D tfo
>  TEST_PROGS +=3D tfo_passive.sh
>  TEST_PROGS +=3D broadcast_pmtu.sh
>  TEST_PROGS +=3D ipv6_force_forwarding.sh
> +TEST_PROGS +=3D tcp_reuseport.py
>
>  # YNL files, must be before "include ..lib.mk"
>  YNL_GEN_FILES :=3D busy_poller netlink-dumps
> diff --git a/tools/testing/selftests/net/tcp_reuseport.py b/tools/testing=
/selftests/net/tcp_reuseport.py
> new file mode 100755
> index 000000000000..eaeb7096382e
> --- /dev/null
> +++ b/tools/testing/selftests/net/tcp_reuseport.py
> @@ -0,0 +1,36 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import os
> +
> +from lib.py import ksft_run, ksft_exit
> +from socket import *
> +
> +def test_reuseport_select() -> None:
> +    s1 =3D socket()
> +    s1.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> +    s1.setsockopt(SOL_SOCKET, SO_BINDTODEVICE, b'lo')
> +    s1.listen()
> +    s1.setblocking(False)
> +
> +    s2 =3D socket()
> +    s2.setsockopt(SOL_SOCKET, SO_REUSEPORT, 1)
> +    s2.bind(s1.getsockname())
> +    s2.listen()
> +    s2.setblocking(False)
> +
> +    for i in range(3):
> +        c =3D socket()
> +        c.connect(s1.getsockname())
> +        try:
> +            print("SUCCESS: assigned properly:", s1.accept())
> +        except:
> +            print("FAIL: wrong assignment")
> +            os.sys.exit(1)

It seems you don't need to handle an exception with ksft.
You can see os.sys.exit(1) triggers another exception when
you run it without patch 1.

TAP version 13
1..1
# timeout set to 3600
# selftests: net: tcp_reuseport.py
# TAP version 13
# 1..1
# FAIL: wrong assignment
# # Exception| Traceback (most recent call last):
# # Exception|   File
"/root/linux/tools/testing/selftests/net/./tcp_reuseport.py", line 26,
in test_reuseport_select
# # Exception|     print("SUCCESS: assigned properly:", s1.accept())
# # Exception|                                          ~~~~~~~~~^^
# # Exception|   File "/usr/lib64/python3.13/socket.py", line 295, in accep=
t
# # Exception|     fd, addr =3D self._accept()
# # Exception|                ~~~~~~~~~~~~^^
# # Exception| BlockingIOError: [Errno 11] Resource temporarily unavailable
# # Exception|
# # Exception| During handling of the above exception, another
exception occurred:
# # Exception|
# # Exception| Traceback (most recent call last):
# # Exception|   File
"/root/linux/tools/testing/selftests/net/lib/py/ksft.py", line 244, in
ksft_run
# # Exception|     case(*args)
# # Exception|     ~~~~^^^^^^^
# # Exception|   File
"/root/linux/tools/testing/selftests/net/./tcp_reuseport.py", line 29,
in test_reuseport_select
# # Exception|     os.sys.exit(1)
# # Exception|     ~~~~~~~~~~~^^^
# # Exception| SystemExit: 1
# not ok 1 tcp_reuseport.test_reuseport_select
# # Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: net: tcp_reuseport.py # exit=3D1


btw, I'd write an official uAPI selftest in plain C for socket as
python sometimes does a tricky thing and I don't trust it.

For example, this is...

from socket import *

s =3D socket()
s.listen(-1)

internally translated to:

socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_IP) =3D 3
listen(3, 0)                            =3D 0

