Return-Path: <linux-kernel+bounces-881660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A88C28A78
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 08:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2DDC347340
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 07:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041026E714;
	Sun,  2 Nov 2025 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Soqbrc+U"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F5D26CE2C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762068768; cv=none; b=q1Fs/fHU2eRR+ByROg2TM1sZkDRAN4eMuUikLg/bpATxaD8OUqP1DAd8jiWf2MYjLjxG4kHFaTfe47msGkM4hnCYOahVFgzI8Puq22Qk2wD0llb0B8t+v2P/NixcNchM0FpjYDYVYXWE99nY208wWVCeEAN1QOuxgaS594jT4fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762068768; c=relaxed/simple;
	bh=X5GGfT0Fb6Pdwjs1LDTMtk3l4izdSvji14DLk1KDCeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fU9/JHcMBNCtSdY4mskWoSxpywEaTG+JegWqBN3Y+tQBZJdPrvOxLzbHN8R/tNnaLyZuLPwtAO0VfBMUr7Z9q20ayVTOqPBTfp+3/smTowJUyeM658/ntmXQ9/ihT3b0o3G7JiMU9Miq8XYMRg39ybOdHEHmcmFTuHtI4A4okzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Soqbrc+U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so43976855ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762068764; x=1762673564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=psmfYF2mFpi74h7bmYecR+gj0aBVviR4E8MTUa1Jbhc=;
        b=Soqbrc+U8MX2XlpslhzJIggz0xnkzljMvOlHY9fqjD4DM7VoMpHSEh2kZxOII2eZcZ
         eLfWiTm3nJ7v7Emwk2Y64kfmHpRxvGkghS955ZXuoP5FLuiXomP7rsbAusmcTIIKVB9U
         aGeO3cNrVfrGf7KgfymXJ85aY6mxjEGuKsS4kkC06H5A08biS+Ot4eUITel65RyTIOiP
         h+mxWLCJA8ceLf1nSmBFgCkdONot6OvL3F9uoEIaZomr3QEJrvuII4MZHknljavWvBj6
         mDEl2fkFYKUE+gX/6nv9BjBmC2LQj4icDaw15n8aBoX9MkWQqyfQhK0ISitlV79kPG5M
         4SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762068764; x=1762673564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=psmfYF2mFpi74h7bmYecR+gj0aBVviR4E8MTUa1Jbhc=;
        b=NZ7IuS0bP+B4f2VCJviKDP6gcEbRmWUi3baETVL/B9N8/CTC2bF5u4FaU0jxDv7oD9
         JgYQb5XuYwBuK0aGv2oZ/Pp3c1kzo7j91lo95e31qkN8EbT5CG15X9HhbwnUhiLHPdJu
         xPRN1mFM2IZZxKQBnT9VT9IOIlrEtIwAHncr8yV3pLYnbP/E4WbFD6IMlNZ/CZ5Zuw8a
         Rlrk3AxVoNZQ7Gn0rlRfkDbJ8WRrwfd2wD8sGvZKHxnkhAKu9fJ6Il75eL1VxYn+h2S9
         ww0jO7dpxf96pQW4gKuLyo/hN9+N/BcUQx/auXxFhFX9LT55H7zdvKeCQiCIOHtJ1KwY
         n6ig==
X-Forwarded-Encrypted: i=1; AJvYcCWvDzNykzLDXiG+sJSsQlm9lmdnclVL1LlKf/z8w3dy54DN1dcCDPEhf1KhUnPeCNfEPn6h3TnFxUS+Rc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDnRygYsy4C9HXrXhqZa33peokp417DuyISWsx29G3iBfQoT/
	8jSqaJiXsn5U6GGc3Zv95OpWAP3WpCkTFmH1RvTsRb3SOSzEs8WokmTE/sSubEZSpmDRwnLgaWs
	m48de35fNIjpEr7Gl9lsJ06FR67lcZQ1LwUhC7ajI
X-Gm-Gg: ASbGncs0Md89KbwfsKu9cSRJu2tTfX5oJPn3/SyT48E8/7BRajz/xZ/jDvjDrbWIVrO
	m+JVYPMsSufuuraop8aVR9t3A1BiW2u43GYToVm2sMHOjzsqO8keTbrOwfakKdroxVF/DeYCh+1
	jHk9Ysp2cX3Lmcwgne+Wivor2gk12RCjfbY47/bJeUijytB6BWQzLR9tcZYTCVop07dd2aWUeaM
	ngMU/uy7Ot70cD78oq0YHLbbwWJjY0ZbeyRAnuYEAc0fShaGKNKkta9EPC/VMYHx36A4EYtvDdf
	/3tYf5J9ZREuNrIN+jP6LKYf75Av
X-Google-Smtp-Source: AGHT+IFbW7bCQJ0PZWFIhPoBoJbyq4L78a2Dn1ShTaa+crTgaOBXNBIsSdR20e5FJO4cGtyCHIdPcl2p5BJao9hsgSg=
X-Received: by 2002:a17:902:f60c:b0:295:9cb5:ae2a with SMTP id
 d9443c01a7336-2959cb5b3a5mr9776895ad.9.1762068764144; Sun, 02 Nov 2025
 00:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101172230.10179-1-adelodunolaoluwa.ref@yahoo.com> <20251101172230.10179-1-adelodunolaoluwa@yahoo.com>
In-Reply-To: <20251101172230.10179-1-adelodunolaoluwa@yahoo.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 2 Nov 2025 00:32:32 -0700
X-Gm-Features: AWmQ_bl-AuPwDhpPjaIEpKjwp_zIOpPzGuKKuWV51VIxF5js7Nyb6hFeYlKzfqQ
Message-ID: <CAAVpQUDL1FB1nFYOZ6QuO+cGTqnpYNSaFtFD=YN742pyspe9ew@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: af_unix: Add tests for ECONNRESET and EOF semantics
To: Sunday Adelodun <adelodunolaoluwa@yahoo.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 10:23=E2=80=AFAM Sunday Adelodun
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
>  tools/testing/selftests/net/af_unix/Makefile  |   1 +
>  .../selftests/net/af_unix/unix_connreset.c    | 179 ++++++++++++++++++
>  2 files changed, 180 insertions(+)
>  create mode 100644 tools/testing/selftests/net/af_unix/unix_connreset.c
>
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

patchwork caught this test is not added to .gitignore.
https://patchwork.kernel.org/project/netdevbpf/patch/20251101172230.10179-1=
-adelodunolaoluwa@yahoo.com/

Could you add it to this file ?

tools/testing/selftests/net/.gitignore


>  # end of TEST_GEN_PROGS
>
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/af_unix/unix_connreset.c b/tools=
/testing/selftests/net/af_unix/unix_connreset.c
> new file mode 100644
> index 000000000000..6f43435d96e2
> --- /dev/null
> +++ b/tools/testing/selftests/net/af_unix/unix_connreset.c
> @@ -0,0 +1,179 @@
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
> +/* Define variants: stream and datagram */

nit: outdated, maybe simply remove ?

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
> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {

patchwork caught mis-alignment here and other places.

I'm using this for emacs, and other editors will have a similar config.

(setq-default c-default-style "linux")

You can check if lines are aligned properly by

$ git show --format=3Demail | ./scripts/checkpatch.pl


> +               err =3D listen(self->server, 1);
> +               ASSERT_EQ(0, err);
> +
> +               self->client =3D socket(AF_UNIX, variant->socket_type, 0)=
;

Could you add SOCK_NONBLOCK here too ?


> +               ASSERT_LT(-1, self->client);
> +
> +               err =3D connect(self->client, (struct sockaddr *)&addr, s=
izeof(addr));
> +               ASSERT_EQ(0, err);
> +
> +               self->child =3D accept(self->server, NULL, NULL);
> +               ASSERT_LT(-1, self->child);
> +       } else {
> +               /* Datagram: bind and connect only */
> +               self->client =3D socket(AF_UNIX, SOCK_DGRAM | SOCK_NONBLO=
CK, 0);
> +               ASSERT_LT(-1, self->client);
> +
> +               err =3D connect(self->client, (struct sockaddr *)&addr, s=
izeof(addr));
> +               ASSERT_EQ(0, err);
> +       }
> +}
> +
> +FIXTURE_TEARDOWN(unix_sock)
> +{
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET)
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
> +       /* Peer closes normally */
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET)
> +               close(self->child);
> +       else
> +               close(self->server);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));

errno is undefined if not set, and same for strerror(errno).

Also, if ASSERT_XXX() below fails, the same information
(test case, errno) is logged.  So, TH_LOG() seems unnecessary.

Maybe try modifying the condition below and see how the
assertion is logged.

> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(0, n);
> +       } else {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +/* Test 2: peer closes with unread data */
> +TEST_F(unix_sock, reset_unread)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       /* Send data that will remain unread by client */
> +       send(self->client, "hello", 5, 0);
> +       close(self->child);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(ECONNRESET, errno);
> +       } else {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +/* Test 3: SOCK_DGRAM peer close */

Now Test 2 and Test 3 look identical ;)

Thanks!

> +TEST_F(unix_sock, dgram_reset)
> +{
> +       char buf[16] =3D {};
> +       ssize_t n;
> +
> +       send(self->client, "hello", 5, 0);
> +       close(self->server);
> +
> +       n =3D recv(self->client, buf, sizeof(buf), 0);
> +       TH_LOG("%s: recv=3D%zd errno=3D%d (%s)", variant->name, n, errno,=
 strerror(errno));
> +       if (variant->socket_type =3D=3D SOCK_STREAM ||
> +               variant->socket_type =3D=3D SOCK_SEQPACKET) {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(ECONNRESET, errno);
> +       } else {
> +               ASSERT_EQ(-1, n);
> +               ASSERT_EQ(EAGAIN, errno);
> +       }
> +}
> +
> +TEST_HARNESS_MAIN
> +
> --
> 2.43.0
>

