Return-Path: <linux-kernel+bounces-869187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1133C07400
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8530D5805C1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DCE272805;
	Fri, 24 Oct 2025 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYF0a2j3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE20E222590
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322518; cv=none; b=VvTnBItr/DlxOFHV7DkhoVFhP7mWvcVDo8PAFxWlx7Sq1mbyZ4Bp5xL3zMbUb7oPsnwj3pNbqgkDmVXAQo2zcGLXCMlr7+M1O28jqJUmF5YcPIn3yaaMW5hxukLTVWWKyUlRIH9ppa0RM8bC02CTpyFFf0n2csQfI7WEVwGIb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322518; c=relaxed/simple;
	bh=t2xB5w2D/C9kbb7Bzl1tMo0JOvGXNQKckLTMhZRtTuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jz+hhGXgJSgWdgMmRGAyoMzL8YyvFaw2yfzmxdH5YEifTxHL4qOpDrk+TkfM6KnQmZDbysPg5DqUP2IQef+VOnFX/HH9wcGS8QPttO+LwdKvkVM5uCupFeHzdfSPCWBU4PRNETwOaI3CMs4GK+a/mNDoZ/RI+B+SZa7RqT+x4iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYF0a2j3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47109187c32so11372905e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761322515; x=1761927315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SX2wgXyhOFI2HLBtCIVzdgo/PaSKpitLRDyKKLcKuCo=;
        b=cYF0a2j3+66lD8a9BZLpc03nLS8aOpIBqYGLHawJBswQzU875AvKVqifFqJo52QnBB
         bj+aJMyjWhwIwGZ1HjsdecgUePoRwpp+H8SMqv8tgQBewNcTKZqFkX+67XLN0qv/elvB
         fETsS9EJEHpfJEuLATxaT082lpkTS3bVZZsxqBa6jXboajU9xkSbSobgIDs17DwWAr0P
         lORGwN9T0kp3LhQ+50prP7eRnC1IEtQwJzSz32tTpa6ezlDuqIwqvOZrDCheFsSsF24B
         9G6t+VdLCAgDMFf+EnkWoic0TWJovp77Md8ke50V72nmtAOywCz4Is2Zphu0E9FDrxt5
         acCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322515; x=1761927315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SX2wgXyhOFI2HLBtCIVzdgo/PaSKpitLRDyKKLcKuCo=;
        b=S4tftmbEMdKHhRwh8hGEvYYIstsvnI5sGA8G1W8zXpTt+c79aLfuMXrCz/226mpkIG
         6wSm58cvYTn4tPFouL4L/Cq5GDFWgqPOsLp8hpaPiNocigVAQfG5RIjxyUA8SrzpeJ5z
         40wFdjia/J5wFg0N7eetWgOpRF4SUbAVPx1Ri+vn0qf1tRzxH/twbWpx1VomNrn8N1JG
         IiqypIyRDq9kFekzq4bECBwVXJVnNamuWW2ARhoghZQ64x7aNXJ8vhuOA1ULxZHt094e
         whrCOrPOFT4QSTR01yQMbP7CtuWt/DHwWFR+WhqIsQwQajhQMXmXbQ2BELmIIKSreJNf
         rLmA==
X-Forwarded-Encrypted: i=1; AJvYcCVBdpxv4RLY3socuJl7ortgjIqa6fact+ATNWNFqKA9CEg2kS+MCB4ZZm8vYS+dfECjy1mnaD8FwVXjFq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5B7BExxRiI0VDJj2kFkGcclg8eWMtzZEwbXW0hC3Ae1mQbWA3
	LIBpBqPBhlq45sJmJKBswBzL3per7owrRd713EuMuipCc6yHV0z53QkQ9+Bm1n004AgI+mi/zbx
	bwBdKD0tQ/1/SjKz9Gy4eLsYX1mcv3FQ=
X-Gm-Gg: ASbGncu9potpGYxbF47nok8n1VPVLt3arWgeCNBgLDW+SsaUh9vKt6fvxGtaZl6cZoM
	BMwz9c5sucPosoMJbiYBU35KFVTPSjSyPIJUA2EX1A8r1OduJJU+BbiiqE6TPwGUAJeJtZ4UAY6
	UA7SAatZiHQ7Z1HHFm8gciv54CCWDSxGXKq2Vve4fKXnSx7w83Wq/fxUvxGorfdIT0/49kxzsvg
	BQrvAe0KQ/bVhSYrJhvJTAiGq5iD1h8YBjvWVJfUsE2/3WmUTYZinRKEgyuMidWepDg6UvA9dYq
	AxH3aJZWEul2oeg3XQ==
X-Google-Smtp-Source: AGHT+IHYhQieymijbR97ThEWtTUuWIeWwcW7dASpktkOfhyJVrh56p292orZ26GtXJFfL041HGk3fWOBdTQaTUxeamY=
X-Received: by 2002:a05:6000:2008:b0:3df:c5e3:55fe with SMTP id
 ffacd0b85a97d-42704d9895amr20799373f8f.29.1761322514888; Fri, 24 Oct 2025
 09:15:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-tc_tunnel-v2-0-a44a0bd52902@bootlin.com>
 <20251022-tc_tunnel-v2-3-a44a0bd52902@bootlin.com> <DDOOS5LR0GZH.ITEM5495FPOX@bootlin.com>
 <CAADnVQJ6zKbThz8B5bqBpwz=gyqeindZb1kwCmM90PsR4-7iQQ@mail.gmail.com> <DDQCVG55KXN7.3P6MCQTNID8K9@bootlin.com>
In-Reply-To: <DDQCVG55KXN7.3P6MCQTNID8K9@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 09:15:02 -0700
X-Gm-Features: AWmQ_bmLtVyHMC53pSRSYOJH_a_wCczVDxu-UPW_QXlFnFx1oBh0bRcOV9rTc7Q
Message-ID: <CAADnVQKQRCC8KJZewRsakDYsFmGZBYuEVYV6xEL2X1Kg06+AYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: integrate
 test_tc_tunnel.sh tests into test_progs
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:58=E2=80=AFPM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi Alexei,
>
> On Wed Oct 22, 2025 at 6:44 PM CEST, Alexei Starovoitov wrote:
> > On Wed, Oct 22, 2025 at 12:52=E2=80=AFAM Alexis Lothor=C3=A9
> > <alexis.lothore@bootlin.com> wrote:
>
> [...]
>
> >> A note about test duration:
> >> the overall test duration, in my setup (x86 qemu-based setup, running =
on
> >> x86), is around 13s. Reviews on similar series ([1]) shows that such a
> >> duration is not really desirable for CI integration. I checked how to
> >> reduce it, and it appears that most of it is due to the fact that for =
each
> >> subtest, we verify that if we insert bpf encapsulation (egress) progra=
m,
> >> and nothing on server side, we properly fail to connect client to serv=
er.
> >> This test then relies on timeout connection,  and I already reduced it=
 as
> >> much as possible, but I guess going below the current value (500ms) wi=
ll
> >> just start to make the whole test flaky.
> >>
> >> I took this "check connection failure" from the original script, and k=
ind
> >> of like it for its capacity to detect false negatives, but should I
> >> eventually get rid of it ?
> >
> > I vote to get rid of it.
> > I'd rather have test_progs that are quick enough to execute for CI and
> > for all developers then more in depth coverage for the corner case.
>
> ACK. I' ll get rid of it. For the record, I drop down to ~3s in my testin=
g
> setup instead of ~13s when removing this "ensure connection failure test"=
.

Good. 3s is fine.

> > Note that for the verifier range test we randomize the test coverage,
> > since the whole permutation takes hours to run. Instead we randomly
> > pick a couple tests and run only those. Since CI runs for every patch
> > the overall coverage is good enough.
> > Would something like that possible here ? and in the other xsk test?
>
> I see that test_verifier takes some "to" and "from" indexes, selecting th=
e
> range of tests that we are able to run. Is this the mechanism you are
> referring to ? (and if so, I guess the rand part is handled by the CI
> runner ?)

I'm talking about SLOW_TESTS=3D1 in reg_bounds.c

