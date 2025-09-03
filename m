Return-Path: <linux-kernel+bounces-799187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92763B4281F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5471886503
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0F831E0FB;
	Wed,  3 Sep 2025 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hWiAJgH6"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADE2C0264
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756921313; cv=none; b=htn/eKZjPisV/a2gckW8FSy72NTbRDjuWcQau6cFFyHCJt6j6wP3kMi9AFGhU0iOoyzYEQ0bX/UdilubMFgCG69yys7Y8uoopW/90PXbj+Y7VTQyh69yabBnef5kK/zQuWalo8P1nyAelhOXNomAIMmF19d8KfAxPgTTL/IDVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756921313; c=relaxed/simple;
	bh=bpoCJi75TuAw42e6A3dn26O70w/74ptLXE3tM4BcXic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRA0I3hPCljFz+R3I1NsddaEUXFfiNboGKJuD4wh08w51LJxmX77eFRrWEoxEFD5sFsQmlo/1E0NexH9c2Cig1+OL/wHTm+E1yLEPc4x8DtLvmNiZICwSzCgWwm0lfgTV5z0PyNiyt1SitKyJ1UK6mF7QPiNCNdcTYdc6PnjBkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=hWiAJgH6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b47175d02dcso61205a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1756921311; x=1757526111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWtU1bedA+xl7PsW7lcEl49lqWYG3Q0Mxi9lWkpXK0U=;
        b=hWiAJgH6OQ1TE0g6Lx+lGuIoJXXLe+WIdUcSoB7hSx6tQezb4cSz7bbG0Rz1XSWHXI
         fHTP8bclZoxwmVa/84IF6qfd9GdEfg3GEpyURMZa2UCEeDOFF2SQZ1FTcAdlHAS31/+U
         1rSTkHx8L8G+XcVHb1aLWnXHyBFaWfnPXSY4UAlQMjj6j+HfJCwxkTsXJT4MQJWnxHnm
         rDwntMEfPE1zku4SViA5n5o9zYMg7ST32DPu/TyCjeD29TxE6t5jasNJJQ+qmmqr1bYx
         /ahxdvVaUYMpd8NWjed9Sv5p5mwn2Lv9eIp1i61TELO8B1FM8Z0nkxswPOAg7T5rFB5V
         riEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756921311; x=1757526111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWtU1bedA+xl7PsW7lcEl49lqWYG3Q0Mxi9lWkpXK0U=;
        b=L4OSInvtYiR+zXvCx3XUdHLC2B7gdaq3v6r6jZpa3Ev1rieiXJz6wh7xOnTRULwGk1
         Fapxlqd9gccCmwZ3V2FGXP3L746uuQMo92HnNRvs9R5QhXUWUqgRH9cJ2u17y9s3/rgr
         sSQrB6AuIBgsKWWXyCeuLQpjUtdP3FYOAwbRqgNzXvyX+OBMAD0T1V8RNFt75fHdkBgM
         Edcw3L1MCEI8p4xXlBbLQni/fQ/mXajWT65I1xCnkwtH7inkuXWitQrf5lkpceuqioRn
         fFY9xnB0u9dgSErzs5/TCXzIYsG9+TegWitifG6s9jTbkBJFtQQdW+EsrJLGs32lwOuT
         K5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdmW8JXK7tG3aprL6BCJjFcnJ8s6FZdVJdB94a8SRIb50tGXWuUi8YdyzbSWP67M2H8LAFft6QtZZzM08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJisQIkLxZotJrQeFi1Sd0/wEyBvUFWae+988+NtPBdvWJCKDB
	awNxcmzSH6a/iSZEbPuwE4gQ6PzlwD6YR99qvCLCgRnpFSNuRZdQ8v5F1czGPEWSPaoxgK18y8W
	oJitgu895yzTmkJBTTIBca6MYcfBmFzYFzOU6CPX3
X-Gm-Gg: ASbGnctONhpOLSPYNfuQSN7vqDlFcl+fYnm7FVVFrogcWwbdQYxcOvw0QRi0i17Enfh
	Q4UJDWHp7GTKHQezGdgIsO2L+whjzUvj6mONoC6+UyyTB3VTCQcH1IrR7GMc2vbcRnIYhAWO68G
	D+XLoY2DsEdR2/kMe0d6hrt61e+dhSA1+f1QI99U6sZFqdVq4S4aKRs6zr/naGtvPWI0jzvulND
	lRk3H/FPmx/DF3568A/QMM5I27I0h/u1o5qJOBSQrljjVnFy0/G2pmff3QoIMLoweND/LjKXRZt
	OoMUdkMfXojvh61cgxw+9A==
X-Google-Smtp-Source: AGHT+IEdLWK2VV7ZxjQos7fBkP7u8BQWyaln03sqyxsZVqDVAVkrTc5Wpas3Svc4Qfy0iKtmL1jDBmsodTgI4M4eHgo=
X-Received: by 2002:a17:90b:530d:b0:329:ca48:7090 with SMTP id
 98e67ed59e1d1-329ca4873c6mr11775847a91.37.1756921311323; Wed, 03 Sep 2025
 10:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
 <20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com> <20250902160858.0b237301@kernel.org>
In-Reply-To: <20250902160858.0b237301@kernel.org>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 3 Sep 2025 18:41:39 +0100
X-Gm-Features: Ac12FXyUeZzt3ewl6-0Cy_MpfxEF2HbCkiS16_FH_5RnMTn3QtB_EuyigatOeeI
Message-ID: <CAGrbwDRHOaiBcMecGrE=bdRG6m0aHyk_VBtpN6-g-B92NF=hTA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bob Gilligan <gilligan@arista.com>, 
	Salam Noureddine <noureddine@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 12:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 30 Aug 2025 05:31:47 +0100 Dmitry Safonov via B4 Relay wrote:
> > Now that the destruction of info/keys is delayed until the socket
> > destructor, it's safe to use kfree() without an RCU callback.
> > As either socket was yet in TCP_CLOSE state or the socket refcounter is
> > zero and no one can discover it anymore, it's safe to release memory
> > straight away.
> > Similar thing was possible for twsk already.
>
> After this patch the rcu members of struct tcp_ao* seem to no longer
> be used?

Right. I'll remove tcp_ao_info::rcu in v4.
For tcp_ao_key it's needed for the regular key rotation, as well as
for tcp_md5sig_key.

Thanks,
             Dmitry

