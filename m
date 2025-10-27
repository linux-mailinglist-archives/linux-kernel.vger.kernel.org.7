Return-Path: <linux-kernel+bounces-872307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C126C0FDFC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4422A3BA07D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3A2D7387;
	Mon, 27 Oct 2025 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3fs/Xy4"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34D17996
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588939; cv=none; b=f0Z7nv+FU6uDb0S/zPUUSFKiqXYI78zia4Ttkg+57oye9EwMPNc/OSu/tvc620Kz57GooyNh3MGN0u1rfEkeIEeSAOl2cledHmj9Py5zKJdKi32GAiqPcFE5QdVWAaNDJA5vlORHDTt7037tCctNY2TCPEJu1BcDn5zKPBryZ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588939; c=relaxed/simple;
	bh=Ndav6bSyVLF8rqPtP+/b+NUrC+mkmsfI3kyI5ZSK5iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEMm0ZrpmN5CDYPAHB1vVeMcK0yWAD/W65hF1vVOGp5qApJvx/8yQgqYLuZVnORpTym4FOof/RBIGA0gHrMUHhmKo/69LWUSbleYKlZJ7lHJRhitofpLxtt4sjHP37vmAvKxxbe6my5BZcb7dKIL1WJ7Mz5fmrLRFeFASoQvNsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3fs/Xy4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-290dc630a07so35344055ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761588937; x=1762193737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYH7nghhEg0YUGLySFkQDlQG2+RdT/Q4uVWeEm/p3DE=;
        b=s3fs/Xy4ToeifPMfm4EQj1ORi6ScrFBn5u//8fu7jiLF272RM/AP7rNssR7k+i6u1U
         /hBmnzHguv6slQmLDZNlJq3j1QY39X+wAV96sK5muq2NugkzcebTCRqupNtrfjsuBURA
         2eYh+FIc1YPBzmVRkiHx5nTbroevVfGwhH+Z17f93zKFFncU6rEK4KtLGYcdLa9r0ux3
         EKIl/RC7Ch2P2A8oLzqzhjQw8qpng5I0v+VrNJy6RH2ZdwUdl+WM5declfm7667PxsFw
         6tUMEgswBGHNu4a6BanHK8F0hTFnm5EkVCdcp6//ZRV3NUSCzIwCOwvJ+2tZbYDnQIyi
         YYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588937; x=1762193737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYH7nghhEg0YUGLySFkQDlQG2+RdT/Q4uVWeEm/p3DE=;
        b=A/jy+7eHHiILvoEybFPKLzIGqncDwYjnEdTD5TjAIhvfBr9v9NyFmdYCLyG2y0VxZn
         VBQEa3mk1HKY559NI3PdfQ919MRb8UwAB8k9Lk6vx32nvJyqmdhVtfbGaPKDUk6x0L5x
         dh55mII6u1EB5IZXxNDaWsvyKU0vFwehl7Vgfq56l3Ekv9oKyW7+WStSgIWoJO3JAFyt
         e9271YG8S/XFAp/3H9l9GjdfkgzDgbbi6BcN35saANV4wtuC8qah23qpI5IuKS5O9cbk
         TMiw4rH1Ms69cgx7xiO/3XuNxewwbNzPP/x79UGfs1C5gviBGRM6k6ZMoZxYDrlDVOGl
         8pDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTn2X62PlJizLNDXYrlpBDz+/N+b6IbaiBgNHcRcfnDduEkIzkkqp/rSy6fV1dXNL0PbVLU6xsea6z5BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9nrq1YOU+gnZQukCAbZys0E47j6KctFydi06/V7E9HnJ8WA4C
	sgmNy7hRlxCI4cpdpuIVKVu9KaA6Hr/ICkBdrj8aZmx/633B3RkFJuRMbrkKLeX/9IWMMPTQ1pj
	eFXnlyd1R2eL8OZSQYMcvXyd8jRrcx//PLN7Yq2CM
X-Gm-Gg: ASbGncvmqzAb6Fa10lQUs6GLwifTiT+K0DUinX/OeGkWkpGuufXokYJfFdOWf4f9Pr4
	caWwdMp6zC+hpbKh+xKbRibmt6UMesrcnCKUg1v+t1iLlD4e+8Hbjc3PQVYorTDpdn/hEP6yPwF
	dFQByHwMiLO8HmoAUgPjAYoDfEslXumSEo37O3MhHKrHW51N3Pbu5GdBbZxo3/6eJjIWCbuqmRe
	1Wf2Pet4q4wFh/rpFjbpLCb81F81qOodNx1QDnA8HAEUl//fx6Cjt9Pvzh2nmOVkTbi3Hcqc5M8
	wSIyJ7ygciO4AX0=
X-Google-Smtp-Source: AGHT+IH0/yPR9pI5EUDlinIHhD4QEnlY4GqIjrMC8XS2wpNTSZd6gJP06Ts90zAf8xELmICWxAA/xOpY3opR0ncGc3o=
X-Received: by 2002:a17:902:f542:b0:27e:f018:d2fb with SMTP id
 d9443c01a7336-294cb395888mr10157835ad.6.1761588936668; Mon, 27 Oct 2025
 11:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAVpQUC7qk_1Dj+fuC-wfesHkUMQhNoVdUY9GXo=vYzmJJ1WdA@mail.gmail.com>
 <20251027141542.3746029-1-wokezhong@tencent.com> <20251027141542.3746029-3-wokezhong@tencent.com>
 <CADVnQynj=5GQbwhiFXFe2gWzodH802ijvFk55xgzxLa6ipRoow@mail.gmail.com>
In-Reply-To: <CADVnQynj=5GQbwhiFXFe2gWzodH802ijvFk55xgzxLa6ipRoow@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Oct 2025 11:15:25 -0700
X-Gm-Features: AWmQ_bljej8UTn1AIJNmxrwPawpAV-lYyoto6yOvLfPMEjhrVyxBQdS8dFAPwU4
Message-ID: <CAAVpQUBAKZvSpcrOiGXPXwzEZL5soXBMGZca6qcsAahyWLXRKQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net/tcp: add packetdrill test for FIN-WAIT-1
 zero-window fix
To: Neal Cardwell <ncardwell@google.com>
Cc: HaiYang Zhong <wokezhong@gmail.com>, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	wokezhong@tencent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 8:08=E2=80=AFAM Neal Cardwell <ncardwell@google.com=
> wrote:
>
> On Mon, Oct 27, 2025 at 10:15=E2=80=AFAM HaiYang Zhong <wokezhong@gmail.c=
om> wrote:
> >
> > Move the packetdrill test to the packetdrill directory and shorten
> > the test duration.
> >
> > In the previous packetdrill test script, the long duration was due to
> > presenting the entire zero-window probe backoff process. The test has
> > been modified to only observe the first few packets to shorten the test
> > time while still effectively verifying the fix.
> >
> > - Moved test to tools/testing/selftests/net/packetdrill/
> > - Reduced test duration from 360+ seconds to under 4 seconds
> >
> > Signed-off-by: HaiYang Zhong <wokezhong@tencent.com>
> > ---
> >  .../packetdrill/tcp_fin_wait1_zero_window.pkt | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 tools/testing/selftests/net/packetdrill/tcp_fin_wai=
t1_zero_window.pkt
> >
> > diff --git a/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero=
_window.pkt b/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_wi=
ndow.pkt
> > new file mode 100644
> > index 000000000000..854ede56e7dd
> > --- /dev/null
> > +++ b/tools/testing/selftests/net/packetdrill/tcp_fin_wait1_zero_window=
.pkt
> > @@ -0,0 +1,34 @@
> > +// Test for permanent FIN-WAIT-1 state with continuous zero-window adv=
ertisements
> > +// Author: HaiYang Zhong <wokezhong@tencent.com>
> > +
> > +
> > +0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
> > +0.000 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
> > +0.000 bind(3, ..., ...) =3D 0
> > +0.000 listen(3, 1) =3D 0
> > +
> > +0.100 < S 0:0(0) win 65535 <mss 1460>
> > +0.100 > S. 0:0(0) ack 1 <mss 1460>
> > +0.100 < . 1:1(0) ack 1 win 65535
> > +0.100 accept(3, ..., ...) =3D 4
> > +
> > +// Send data to fill receive window
> > +0.200 write(4, ..., 5) =3D 5
> > +0.200 > P. 1:6(5) ack 1
> > +
> > +// Advertise zero-window
> > +0.200 < . 1:1(0) ack 6 win 0
> > +
> > +// Application closes connection, sends FIN (but blocked by zero windo=
w)
> > +0.200 close(4) =3D 0
> > +
> > +//Send zero-window probe packet
> > ++0.200 > . 5:5(0) ack 1
> > ++0.400 > . 5:5(0) ack 1
> > ++0.800 > . 5:5(0) ack 1
> > +
> > ++1.000 < . 1:1(0) ack 6 win 0
> > +
> > +// Without fix: This probe won't match - timer was reset, probe will b=
e sent 2.600s after the previous probe
> > +// With fix: This probe matches - exponential backoff continues (1.600=
s after previous probe)
> > ++0.600~+0.700 > . 5:5(0) ack 1
> > --
>
> Thanks for this test!
>
> Kuniyuki rightly raised a concern about the test execution time.
>
> But IMHO it was very nice that the original version of the test
> verified that the connection would eventually be timed out. With this
> shorter version of the test, AFAICT the test does not verify that the
> connection actually times out eventually.
>
> Perhaps if we tune the timeout settings we can achieve both (a) fast
> execution (say, less than 10 secs?), and (b) verify that the
> connection does time out?

+1 for the original test with shorter timeout settings.

If the test still takes longer than 45s with the Neal's
recommendation applied, we can adjust the kselftest timeout like :

diff --git a/tools/testing/selftests/net/packetdrill/Makefile
b/tools/testing/selftests/net/packetdrill/Makefile
index ff54641493e9..33e3311e3ef5 100644
--- a/tools/testing/selftests/net/packetdrill/Makefile
+++ b/tools/testing/selftests/net/packetdrill/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0

+export kselftest_override_timeout=3D360
+
 TEST_INCLUDES :=3D \
  defaults.sh \
  ksft_runner.sh \


Also, please post the next version as a separate thread so that
patchwork will not be confused.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#resen=
ding-after-review
---8<---
The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a
link to the previous posting
---8<---

Thanks!

>
> Perhaps you can try:
>
> + setting net.ipv4.tcp_orphan_retries to something small, like 3 or 4
> (instead of the default of 0, which dynamically sets the retry count
> to 8 in tcp_orphan_retries())
>
> + setting net.ipv4.tcp_rto_max_ms to something small, like 5000
> (instead of the default of 120000, aka 120 secs)
>
> Another thought: the original test injected a lot of extra rwin=3D0 ACKs
> that AFAICT a real remote peer would not have sent. IMHO it's better
> to keep the test simpler and more realistic by not having the test
> inject those extra rwin=3D0 ACKs.

