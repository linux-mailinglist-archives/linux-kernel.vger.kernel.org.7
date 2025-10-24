Return-Path: <linux-kernel+bounces-868034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 335ECC0433A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE4124F5041
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B3724BD04;
	Fri, 24 Oct 2025 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zMcELTIj"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A4B1DFDE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274842; cv=none; b=h7TWj7K+noUcC2TCpozxwHDjregFV57HDWP8nV6eTVtzRsjHbal1Qb8F8l0t35MGknH860y5byIrse8RHf7DpDiBEobVDaeLuc6tZokFnWSRDmrsaCBHHNWE18ziILuZ8ZLuNbgszOnvAWg3Hvj+x1yuIuqgHgVffoXSwrhY7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274842; c=relaxed/simple;
	bh=rx0ws1SUpyQLxCqOpX2cHJCF3GCu07xIjjdT8hkeh/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHoh2l5mU/ltV19XM9xkhb3nXtKyno8PGPh5ZbFUE4XyNwKsceOb3lsAxKhqpIo/ogNvscfgfmbGFoZz4qFPFyuIOBK64Zao4505qg1IoyV3500vJoZEVDeqTIzX2tGC7KgBQyLNx5Zl5FFl5dnIERwPWS/4ApgPV7e7E0gH+cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zMcELTIj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27c369f898fso24061585ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761274840; x=1761879640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytg8t1NA2HbwNdbywfdqRIZcojg/s4LnaoZSEoWgpTU=;
        b=zMcELTIjOm4SuA/gy1VIRQQWvyXnGuNfjb37P2st2NZeW5WiV9uWkp01Jri+OFkBxz
         MpA8/TtqKdMcVSTt/NxjxLgPiLHqxQl+Z+WaBtWa808ds2TZ6LbNUZIdHrv9cKZ299ZJ
         Jb5/QKa8UiiFt6nIg5WRSQqrHI3xtmUGOkNF20FVvhMRfCiN8n01brnCcSacLdqrxHk7
         Z9xEsL26I+/6mGuhPrAIsSrRKp6Evs57AbJJK2PX+denSkPHIGSt8plKDAKPgKNfvwOi
         1sG4n1/MAWJZSCWtLBjQ8oi1+FfDfgip8AisH1gPeO7KDGLAx6/ufMCXp3s7BQ4KciKS
         kn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761274840; x=1761879640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ytg8t1NA2HbwNdbywfdqRIZcojg/s4LnaoZSEoWgpTU=;
        b=AlsktIahOlUYXjgX82KH7j5UiAkCBQwGg0+bhJR4xLbypQNBhtV1y9pMmuWYcphDQz
         stJDFVCxE+5Nr1G7wkdCr7PF6VB1cqzUscJ8dHmNTOHfEdkhhWRztcuzZIidAJmA/xGF
         0Y5H+x54Klt+x8JF9/vSs6hgVxcwdkOkZURVSr/4TLCTnr1OZ30/FTi/lCtiXFHSasat
         +RwiiyTV/Fc1wwQTt9EpC4m+Z6KByHKDrbD3sD5jhMqm4xdKU3VOpEXSb1Oq45RhSqy8
         NrFw1j+6Pz+FVLAAKAcrvnydvTioijeHyLeJCkxj6lrh5okNgb1UNseCqHldfHHOCZ1J
         TpNA==
X-Forwarded-Encrypted: i=1; AJvYcCXpuQn9hUFAr95/IKNs8VU2e7j5D9SgAmyst6Qe7u91DfaBTK+A5DMmdlZKH2OMnxhSJdUQSRjtpUEBgcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDnLASSFkFZYh7AzGpI98Ecl2QqrH8OP8wwBOdm1nhBRJLD9RI
	7/xj3DWeIR8CSqScViV4Pttzk5FlosKsYiVzk9HLUpOJvLNd6D8goIwZ0qM6EbYG5cN9gM5JjiE
	a7LiTEdcYADWkZks9zqhlq+SpPo6SDyPy1h2Tr293
X-Gm-Gg: ASbGnctMg6SoYUMLdgmnwcmbPuIF0U6tkspuQ+K0G2MRf9/vFo8Cc/YgBiRDyhVPTnp
	hzTc5IPbGyzTf6g5sF7Xf/1gMCpL1z9oCv2WCTkvjGtZ1o3/CPgEiIjtOTkgbvo8Yu1xnSgg3UM
	Tg9wqFX06z/6sPkmnNH57nFhFIlGYzAqCV6quQoaK8hdXWyUZUmdOTofNPMiPlGLIjHSIc/XZHh
	LszM109bHEaH2y43IuG5OGVW8WFUYFjqBQ3dhQ9Q3KBTnPxWZxYWsdEN4uh6PV/+6tLYzcKNygQ
	weRLe4eCzKj5vAY=
X-Google-Smtp-Source: AGHT+IEjKz+o4zRszWREaWKQfE3zfa5mKZgELYaGHhFCsdxyYCPygqg7wIJLqcd7MDKvie8LROLAJlYMoFie0y4LpOw=
X-Received: by 2002:a17:903:440c:b0:264:8a8d:92dd with SMTP id
 d9443c01a7336-290c9cb8b95mr348230235ad.20.1761274839948; Thu, 23 Oct 2025
 20:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023165841.8164-1-adelodunolaoluwa.ref@yahoo.com> <20251023165841.8164-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251023165841.8164-1-adelodunolaoluwa@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 23 Oct 2025 20:00:28 -0700
X-Gm-Features: AS18NWCPooRWM5F3yFVrYkOizgWMJPcRipp4qj9tu8QpgOd96rIWKXrebnLJf4o
Message-ID: <CAAVpQUAX-+5cOCaZrA1DbMTLrUEhCsK=6JSHAQgSNhbOyQ06MA@mail.gmail.com>
Subject: Re: [PATCH] selftests/unix: Add test for ECONNRESET and EOF behaviour
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, horms@kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for adding tests.

> [PATCH] selftests/unix: Add test for ECONNRESET and EOF behaviour

nit: The common prefix is "selftest: af_unix:".


On Thu, Oct 23, 2025 at 9:59=E2=80=AFAM Sunday Adelodun
<adelodunolaoluwa@yahoo.com> wrote:
>
> Add selftests verifying the EOF and ECONNRESET behaviour of
> UNIX domain sockets (SOCK_STREAM and SOCK_DGRAM). The tests document
> Linux's semantics and clarify the long-standing differences with BSD.
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
> ---
>  tools/testing/selftests/net/unix/Makefile     |   5 +
>  .../selftests/net/unix/test_unix_connreset.c  | 147 ++++++++++++++++++
>  2 files changed, 152 insertions(+)
>  create mode 100644 tools/testing/selftests/net/unix/Makefile
>  create mode 100644 tools/testing/selftests/net/unix/test_unix_connreset.=
c

The test for af_unix is placed under tools/testing/selftests/net/af_unix.


>
> diff --git a/tools/testing/selftests/net/unix/Makefile b/tools/testing/se=
lftests/net/unix/Makefile
> new file mode 100644
> index 000000000000..a52992ba23d9
> --- /dev/null
> +++ b/tools/testing/selftests/net/unix/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +TEST_GEN_PROGS :=3D test_unix_connreset
> +
> +include ../../lib.mk
> +
> diff --git a/tools/testing/selftests/net/unix/test_unix_connreset.c b/too=
ls/testing/selftests/net/unix/test_unix_connreset.c
> new file mode 100644
> index 000000000000..a8720c7565cb
> --- /dev/null
> +++ b/tools/testing/selftests/net/unix/test_unix_connreset.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Selftest for UNIX socket close and ECONNRESET behaviour.

nit: s/UNIX/AF_UNIX/

> + *
> + * This test verifies that:
> + *  1. SOCK_STREAM sockets return EOF when peer closes normally.
> + *  2. SOCK_STREAM sockets return ECONNRESET if peer closes with unread =
data.
> + *  3. SOCK_DGRAM sockets do not return ECONNRESET when peer closes,
> + *     unlike BSD where this error is observed.
> + *
> + * These tests document the intended Linux behaviour, distinguishing it =
from BSD.

I'd not mention BSD as it could be outdated again.


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
> +#define SOCK_PATH "/tmp/test_unix_connreset.sock"
> +
> +static void remove_socket_file(void)
> +{
> +       unlink(SOCK_PATH);
> +}
> +
> +/* Test 1: peer closes normally */
> +TEST(stream_eof)

I think most of the code can be shared by defining
FIXTURE_VARIANT().

e.g. variant->unread_data can consolidate Test 1&2.


> +{
> +       int server, client, child;
> +       struct sockaddr_un addr =3D {0};
> +       char buf[16] =3D {0};

IIRC, {0} only initialises the first entry and we had a problem
in kernel code, so simply use "=3D {};" everywhere.


> +       ssize_t n;
> +
> +       server =3D socket(AF_UNIX, SOCK_STREAM, 0);

Try using variant->type for SOCK_STREAM,
SOCK_DGRAM, and SOCK_SEQPACKET.

See unix_connect.c, or you could reuse the fixtures
of err =3D=3D 0 there.

> +       ASSERT_GE(server, 0);

nit: The 1st arg is "expected", and the 2nd is "seen",
so ASSERT_NE(-1, server) (or ASSERT_LT(-1, server)).

Same for other places.


> +
> +       addr.sun_family =3D AF_UNIX;
> +       strcpy(addr.sun_path, SOCK_PATH);
> +       remove_socket_file();
> +
> +       ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0=
);

I personally feel easy to read this style:

err =3D bind();
ASSERT_EQ(0, err);

> +       ASSERT_EQ(listen(server, 1), 0);
> +
> +       client =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_GE(client, 0);
> +       ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr))=
, 0);
> +
> +       child =3D accept(server, NULL, NULL);
> +       ASSERT_GE(child, 0);
> +
> +       /* Peer closes normally */
> +       close(child);
> +
> +       n =3D recv(client, buf, sizeof(buf), 0);
> +       EXPECT_EQ(n, 0);
> +       TH_LOG("recv=3D%zd errno=3D%d (%s)", n, errno, strerror(errno));

I printed errno just for visibility, and you can simply use
ASSERT here too like

if (n =3D=3D -1)
    ASSERT_EQ(ECONNRESET, errno)

(I'm assuming Test 1 & 2 will share most code)

> +
> +       close(client);
> +       close(server);
> +       remove_socket_file();

This will not be executed if the program fails at ASSERT_XX(),
so move it to FIXTURE_TEARDOWN().



> +}
> +
> +/* Test 2: peer closes with unread data */
> +TEST(stream_reset_unread)
> +{
> +       int server, client, child;
> +       struct sockaddr_un addr =3D {0};
> +       char buf[16] =3D {0};
> +       ssize_t n;
> +
> +       server =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_GE(server, 0);
> +
> +       addr.sun_family =3D AF_UNIX;
> +       strcpy(addr.sun_path, SOCK_PATH);
> +       remove_socket_file();
> +
> +       ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0=
);
> +       ASSERT_EQ(listen(server, 1), 0);
> +
> +       client =3D socket(AF_UNIX, SOCK_STREAM, 0);
> +       ASSERT_GE(client, 0);
> +       ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr))=
, 0);
> +
> +       child =3D accept(server, NULL, NULL);
> +       ASSERT_GE(child, 0);
> +
> +       /* Send data that will remain unread by client */
> +       send(client, "hello", 5, 0);
> +       close(child);
> +
> +       n =3D recv(client, buf, sizeof(buf), 0);
> +       EXPECT_LT(n, 0);
> +       EXPECT_EQ(errno, ECONNRESET);
> +       TH_LOG("recv=3D%zd errno=3D%d (%s)", n, errno, strerror(errno));
> +
> +       close(client);
> +       close(server);
> +       remove_socket_file();
> +}
> +
> +/* Test 3: SOCK_DGRAM peer close */
> +TEST(dgram_reset)
> +{
> +       int server, client;
> +       int flags;
> +       struct sockaddr_un addr =3D {0};
> +       char buf[16] =3D {0};
> +       ssize_t n;
> +
> +       server =3D socket(AF_UNIX, SOCK_DGRAM, 0);
> +       ASSERT_GE(server, 0);
> +
> +       addr.sun_family =3D AF_UNIX;
> +       strcpy(addr.sun_path, SOCK_PATH);
> +       remove_socket_file();
> +
> +       ASSERT_EQ(bind(server, (struct sockaddr *)&addr, sizeof(addr)), 0=
);
> +
> +       client =3D socket(AF_UNIX, SOCK_DGRAM, 0);
> +       ASSERT_GE(client, 0);
> +       ASSERT_EQ(connect(client, (struct sockaddr *)&addr, sizeof(addr))=
, 0);
> +
> +       send(client, "hello", 5, 0);
> +       close(server);
> +
> +       flags =3D fcntl(client, F_GETFL, 0);
> +       fcntl(client, F_SETFL, flags | O_NONBLOCK);

You can save fcntl() with socket(..., ... | SOCK_NONBLOCK, ...).


> +
> +       n =3D recv(client, buf, sizeof(buf), 0);
> +       TH_LOG("recv=3D%zd errno=3D%d (%s)", n, errno, strerror(errno));
> +       /* Expect EAGAIN or EWOULDBLOCK because there is no datagram and =
peer is closed. */
> +       EXPECT_LT(n, 0);
> +       EXPECT_TRUE(errno =3D=3D EAGAIN);
> +
> +       close(client);
> +       remove_socket_file();
> +}
> +
> +TEST_HARNESS_MAIN
> +
> --
> 2.43.0
>

