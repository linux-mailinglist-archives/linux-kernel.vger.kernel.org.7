Return-Path: <linux-kernel+bounces-898247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC479C54AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E419347827
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA9635CBA9;
	Wed, 12 Nov 2025 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="znii0/HV"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438892BF017
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985107; cv=none; b=em/v1dsKlp+YpyVJOGa+rd4/WyQPLnmeqEknESpoTFHqNunsjhgmbBa7RGNEgkOg65AOGe63tX3h0DmnJg1foG0TeISz8SXHB1n4ZDCX/DGwTGLqaBdIGYDTDcI/KRHfjUsARQch2yKfazOsikyh/5xec184GACUXKYq4ZHY5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985107; c=relaxed/simple;
	bh=2qhpNkaMfGbH1CfnNdd4Up7M0srBKHHLqbCrBAstSk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWPtNqLWAUe2drzPsrQWKeYpf3OEGqW/EJDECJIqWmiamWEoZ8C9aGoa9DE36vih2shqTw95Y7i/bq8pXKvIaBQGs4+YhBpCevVj+2FYDkxC8q0kjqMPgqK01jphd2OngPxx4luWwNEev4OSJHrCEx/d6sQAU3aS7QR2Sw8PwD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=znii0/HV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297f35be2ffso1684535ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762985105; x=1763589905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKPs42nPgCf3xa7WYhvLEc5azAO7u4S86iHOJTh8d2o=;
        b=znii0/HVT8DWpWLI0cJxCFY2kRCpSH/qHPff9qMq9cYM+YXWP0ntBMJXN/ROnUSdC4
         nVY/nOI9SHGPbiLwm2cewgPc9PZyglF+xR3GbXHdZxmqy3T+WhgTC3yUolKW1rEQLDqE
         mFa2WIdOHwi5gmVSRbIxyRFbC+781VmEr+NYGI8aNAz95zrp8xw03PYUn5xdYPpcwnBV
         sZdBS+mWvWFBUzEs4poRBn0ooQYnVOw45GrsXj21cDVMNKbKkWgQ+ev0CJhpRBCOeCxo
         hDYC1u2CQaY7IOjagOQA+n+8gtkRemsXNc884BWl5AVRr8YCHNwHZSlx4D65oda6p812
         w5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762985105; x=1763589905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKPs42nPgCf3xa7WYhvLEc5azAO7u4S86iHOJTh8d2o=;
        b=Z6ui2+6vUcTg6OueUta4IX4ttRpjm/iMWXb+jUeBwdIwOW9ap5efA5J3oGYoeitV/7
         4RhomzytEL7vEk+opb4YaWGV4la3DqLlq8Jvi7MUEqOU7XCx7+T7A4JRWesGorizcKeb
         ZU15h1QbHxJAMhpfK9tIFEApK7nTO5H038Btlme2vsEXA5xSGl0lIqLRXKBDBmxziwK2
         fnrK520uAQeD8wsGYanFxp38vGfEUAOQnwr6kfow7gACqa+EUixvdGMushljcyd94iNP
         FCDHeEmeX1iahtbCQPEv9Hf294BBiBdJQ38xCsvyfWihpEmO9CqJmIqJ67A7oIeUfReH
         u3mw==
X-Forwarded-Encrypted: i=1; AJvYcCWE+MhRdCnEjYB8MKksWuaLo37CgXEiQDff3Y+I805UFIsJ0B3RTqCI3BAVaAVb5vJ/AVe+zToP0oYJH0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrT2JpkfQbqDFZI7UpSv3EH+xwiYQiAhnrCVX2S6G7DO/wSxf
	QpBcQWWOs6HWrRxmSi938z7MW2oYSEbETau9m69X9TsmX8yta4Fxu4C+hCbQ1Ofm1hhnHB6dgtj
	ffA/oiwKZ79WH4owNsJrycvKnlegdx99hJs0TXB2qngVeEUrZsd7UVzcZ
X-Gm-Gg: ASbGncvHvEALwbQO6No1s3tFjSkIvmIHA12QQ9yB8H9/bzv4VdZx5IqwIUCkaHwZ/lx
	Z926lfBB4SAIr0IIvZKN6Vd42jN4gxdkDfnaWrdJHJXtkS79yXYMg0zWvDEd3LLbX2N16RxCJvv
	NlQXvnW01zDVCSZ4CAL6ob6mUMn4F2qrD6FQQrQiJZpsQOAbQJH2wmJEOeYryIWaHFzwX5I8i31
	F9pzLrGGl9uFLbW1EJgbLIU3AgtAGhAwaPmgls3YnOJZ+vvTAFExzExrQ5QgtyFrlJ4l7bONYSq
	+wyOJbTP+XtLatBkxR3THfPGDA==
X-Google-Smtp-Source: AGHT+IEEm3bNv9rfezM7XwE7yjmnPOy5mZvfwXtXh1qfH7f2eoz0NkAYCYxRGrvQAR1YGl9JYIOmyR46J21A+jr8E+c=
X-Received: by 2002:a17:902:ccd1:b0:258:9d26:1860 with SMTP id
 d9443c01a7336-2984eddd8e8mr59380125ad.40.1762985104264; Wed, 12 Nov 2025
 14:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112212026.31441-1-adelodunolaoluwa.ref@yahoo.com> <20251112212026.31441-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251112212026.31441-1-adelodunolaoluwa@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 12 Nov 2025 14:04:52 -0800
X-Gm-Features: AWmQ_bnIPeclCbtbxPZNlzdNhqCLUG7E5kJ4h6vY_ySub0JtYOJiM91OLaOaSz0
Message-ID: <CAAVpQUB97EBnTbA9pKwdhPM0pHadiM3QhP4_1qLSKGg2LAwzkA@mail.gmail.com>
Subject: Re: [PATCH v4] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 1:20=E2=80=AFPM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> Add selftests to verify and document Linux=E2=80=99s intended behaviour f=
or
> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM) when a peer closes.
> The tests verify that:
>
>  1. SOCK_STREAM returns EOF when the peer closes normally.
>  2. SOCK_STREAM returns ECONNRESET if the peer closes with unread data.
>  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
>  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread data=
.
>  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
>
> This follows up on review feedback suggesting a selftest to clarify
> Linux=E2=80=99s semantics.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> ---
>  tools/testing/selftests/net/.gitignore        |   1 +
>  tools/testing/selftests/net/af_unix/Makefile  |   1 +
>  .../selftests/net/af_unix/unix_connreset.c    | 178 ++++++++++++++++++
>  3 files changed, 180 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>
> diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selft=
ests/net/.gitignore
> index 439101b518ee..e89a60581a13 100644
> --- a/tools/testing/selftests/net/.gitignore
> +++ b/tools/testing/selftests/net/.gitignore
> @@ -65,3 +65,4 @@ udpgso
>  udpgso_bench_rx
>  udpgso_bench_tx
>  unix_connect
> +unix_connreset
> diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing=
/selftests/net/af_unix/Makefile
> index de805cbbdf69..5826a8372451 100644
> --- a/tools/testing/selftests/net/af_unix/Makefile
> +++ b/tools/testing/selftests/net/af_unix/Makefile
> @@ -7,6 +7,7 @@ TEST_GEN_PROGS :=3D \
>         scm_pidfd \
>         scm_rights \
>         unix_connect \
> +       unix_connreset \
>  # end of TEST_GEN_PROGS
>
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools=
/testing/selftests/net/af_unix/unix_connreset.c
> new file mode 100644
> index 000000000000..9413f8a0814f
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Selftest for AF_UNIX socket close and ECONNRESET behaviour.
> + *
> + * This test verifies:
> + *  1. SOCK_STREAM returns EOF when the peer closes normally.
> + *  2. SOCK_STREAM returns ECONNRESET if peer closes with unread data.
> + *  3. SOCK_SEQPACKET returns EOF when the peer closes normally.
> + *  4. SOCK_SEQPACKET returns ECONNRESET if the peer closes with unread =
data.
> + *  5. SOCK_DGRAM does not return ECONNRESET when the peer closes.
> + *
> + * These tests document the intended Linux behaviour.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include "../../kselftest_harness.h"
> +
> +#define SOCK_PATH "/tmp/af_unix_connreset.sock"
> +
> +static void remove_socket_file(void)
> +{
> +       unlink(SOCK_PATH);
> +}
> +
> +FIXTURE(unix_sock)
> +{
> +       int server;
> +       int client;
> +       int child;
> +};
> +
> +FIXTURE_VARIANT(unix_sock)
> +{
> +       int socket_type;
> +       const char *name;
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, stream) {
> +       .socket_type =3D SOCK_STREAM,
> +       .name =3D "SOCK_STREAM",
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, dgram) {
> +       .socket_type =3D SOCK_DGRAM,
> +       .name =3D "SOCK_DGRAM",
> +};
> +
> +FIXTURE_VARIANT_ADD(unix_sock, seqpacket) {
> +       .socket_type =3D SOCK_SEQPACKET,
> +       .name =3D "SOCK_SEQPACKET",
> +};
> +
> +FIXTURE_SETUP(unix_sock)
> +{
> +       struct sockaddr_un addr =3D {};
> +       int err;
> +
> +       addr.sun_family =3D AF_UNIX;
> +       strcpy(addr.sun_path, SOCK_PATH);
> +       remove_socket_file();
> +
> +       self->server =3D socket(AF_UNIX, variant->socket_type, 0);
> +       ASSERT_LT(-1, self->server);
> +
> +       err =3D bind(self->server, (struct sockaddr *)&addr, sizeof(addr)=
);
> +       ASSERT_EQ(0, err);
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               err =3D listen(self->server, 1);
> +               ASSERT_EQ(0, err);
> +       }
> +
> +       self->client =3D socket(AF_UNIX, variant->socket_type | SOCK_NONB=
LOCK, 0);
> +       ASSERT_LT(-1, self->client);
> +
> +       err =3D connect(self->client, (struct sockaddr *)&addr, sizeof(ad=
dr));
> +       ASSERT_EQ(0, err);
> +}
> +
> +FIXTURE_TEARDOWN(unix_sock)
> +{
> +       if ((variant->socket_type =3D=3D SOCK_STREAM ||
> +            variant->socket_type =3D=3D SOCK_SEQPACKET) & self->child > =
0)
> +               close(self->child);
> +
> +       close(self->client);
> +       close(self->server);
> +       remove_socket_file();
> +}
> +
> +/* Test 1: peer closes normally */
> +TEST_F(unix_sock, eof)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               self->child =3D accept(self->server, NULL, NULL);
> +               ASSERT_LT(-1, self->child);
> +
> +               close(self->child);
> +       } else {
> +               close(self->server);
> +       }
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(0, n);
> +       } else {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +/* Test 2: peer closes with unread data */
> +TEST_F(unix_sock, reset_unread_behavior)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       if (variant->socket_type =3D=3D SOCK_DGRAM) {
> +               /* No real connection, just close the server */
> +               close(self->server);
> +       } else {
> +               /* Establish full connection first */
> +               self->child =3D accept(self->server, NULL, NULL);
> +               ASSERT_LT(-1, self->child);
> +
> +               /* Send data that will remain unread */
> +               send(self->client, "hello", 5, 0);

Could you move this send() before "if (...)" because we want
to test unread_data behaviour for SOCK_DGRAM too ?

Otherwise looks good, so with that fixed:

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks!


> +
> +               /* Peer closes before client reads */
> +               close(self->child);
> +       }
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       ASSERT_EQ(-1, n);
> +
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +           variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(ECONNRESET, errno);
> +       } else {
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +/* Test 3: closing unaccepted (embryo) server socket should reset client=
. */
> +TEST_F(unix_sock, reset_closed_embryo)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       if (variant->socket_type =3D=3D SOCK_DGRAM)
> +               SKIP(return, "This test only applies to SOCK_STREAM and S=
OCK_SEQPACKET");
> +
> +       /* Close server without accept()ing */
> +       close(self->server);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +
> +       ASSERT_EQ(-1, n);
> +       ASSERT_EQ(ECONNRESET, errno);
> +}
> +
> +TEST_HARNESS_MAIN
> +
> --
> 2.43.0
>

