Return-Path: <linux-kernel+bounces-882453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A0C2A847
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 09:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCBE3A9FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 08:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED523A984;
	Mon,  3 Nov 2025 08:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asBNxSJP"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0D287503
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 08:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762157193; cv=none; b=Gm8jlO0m7U4kEAC1m55U9JUZYrx4OEIp4jj+13t4Rj3q3q3P4adWNpfAD/fSli2ZsGLF8oMFt24ffhkTyOcT3jTgfP07idmw/VY7NsV7g5b8QiPVSR7p95pu2tb6qbr+MtAFv8pUOvvktpsOBPWfs0t0p6xt4m9wLdhwqkUov+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762157193; c=relaxed/simple;
	bh=TJPUJVukbfWR3gfsffRUjF/8PW9lialw9HyxVO/Phco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbfRUczj1kbu2q5Gx8W9DGhFWC+hgxXxonr1AXX2hBAoG2bdXmweXQvh3sd4bnxLNFdLCCL1UuoL9rvpYSW4U76ZGa7KH82qZby3rrz0zsqBxvqKrHwky5WvvsWUmo6o0fFhjQQNpTSdiGYseyRWz4NBme+mq84sZ8b/iEsWW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=asBNxSJP; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78665368a5cso12123547b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 00:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762157190; x=1762761990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NJXJy4cAI4/mrSwSPYVdQe2DZkHcINj3IyYJCGJBc4=;
        b=asBNxSJPMX0bW/hp8od5u6hOX+WUcGdc+pnZQKNZ6gLVlYO1j1eY2sFNWyPWv68Ib2
         CJdmFD5cZcxVQpa5yOgjpdzl0e+zrr85rQRctyi96t3FRKyfJn5xcD4LR/bAxuZhyyki
         TlRQ0qm4y+3s7CeVlcRJ0Tniif/EHIBdITvTXZHXP5RFCfHk+oNOSz64G/oGVlFeL6Bl
         0KqECJrS5zTzjAbE9Uhu9Zy55rOr7pgTZtb+NNtO3mLBg5bfElwUy0yRxPC66+2CWtRj
         1FA3PxbtwcETtBAs1O6A5sUB+AtOsEmIxnlC3AjO2mWXxvhck8n/MUIY8j18LcbupRqu
         q6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762157190; x=1762761990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NJXJy4cAI4/mrSwSPYVdQe2DZkHcINj3IyYJCGJBc4=;
        b=o4xSjWK/v5OpguHQUGRH6oPuVDTes0CoXHZ15sCTAWWDbs6HtcY60EYo93Qf/j8cay
         ax7iEc3ZB0kDw+UBPKKvkehWZwU2FZq2z3DI6ZWF/oVBZuRgdZvymOPOq2NU5IpTZZrc
         /WD9Pc7OFk0R7niocGqbTxnJosu+4DeKdrn9FJgVTf7IiJmyx7zZ1lDv++34B+ZqPAAz
         Yn3HSZQzyAa5JtGoUlG9BcLPC620LeoJmn8ixGRBr1nDEgn4lXzqve7KyvJwNGXpGthj
         QPPCjRiyTM9VEXv0inQJFF73fEiE6GPVMwqfFWEDF7NxuS+qcNeZUugDaTLxQ8V0OqC1
         pPXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX08fIeQQEJSSdfpVu8B2IoNdeiKswg0gn/7r7M4VTzs576Li9i5j9+SRN3zHmUJ7Dmyc50lweoZTN9dwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NSlbtrpRWzHeJnKzMxo56cvfcD9TDha2VmyMSSXTE/n+E4WM
	RjvMPoYB9EIgtQI/zO2YP0ZkBOn+7806Oe+h5fAP5/wAOCNA6V0CKHhwH2KGXeo1fplRgF8y28c
	cSVB9WQg9JtTPctXA7NRroCKZlHplSoVS1pz5iSIR
X-Gm-Gg: ASbGnctY0Sv+Px705fuotB8ygjY2oSy8Cjl+v0N43VDKMrgaHGSKyCDA3jn60ksOkE7
	0/dac0BYEs/hFCvYQmqjw6n08VKzytPrZEg11B9ghDkL85pO7gHShPfJ8PqJJpdMTb6lhpqhINh
	wJeZ9j+ucP3QL89QAnt+xLKjcnZMAwmQz5POCPWBEoh1VxwNsK2zo9xJlx8hGQ0WYy+WkzvZ8x9
	PUC3r6dAwhdoGjT68sWdAw/+Dtxbbb8usZ8/WFwsKnP+DiPILGNBjvKweo=
X-Google-Smtp-Source: AGHT+IEsP1MAEGN+2YqHUmUaqQaVV+TIUE+RtPGUJjC296VRFo5DRFM5ayW9vTRA+F1L+iNilpI+yRUdSzgulPYBC14=
X-Received: by 2002:a05:690c:6d8c:b0:786:4231:5e90 with SMTP id
 00721157ae682-7864856fc26mr99070117b3.56.1762157190044; Mon, 03 Nov 2025
 00:06:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202509291645.fcBIaXMb-lkp@intel.com> <CANn89i+Bt5Coi3YOj2JjX4KWQN4tJJpyYD3EabS274T8bQwjSw@mail.gmail.com>
In-Reply-To: <CANn89i+Bt5Coi3YOj2JjX4KWQN4tJJpyYD3EabS274T8bQwjSw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 3 Nov 2025 00:06:18 -0800
X-Gm-Features: AWmQ_bll77Tupv_60G7NMZkMDfIgtallI03szpNVDD4Eb724Mc_GXOztpPtFWkc
Message-ID: <CANn89iLrM8ZJyJHYJH8Sbuj9F9OAKZn6srtgBXwU2XmMfJ-+BQ@mail.gmail.com>
Subject: Re: include/net/sock.h:2098:16: sparse: sparse: cast to non-scalar
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Will Deacon <will@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 2:49=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 29, 2025 at 1:58=E2=80=AFAM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   e5f0a698b34ed76002dc5cff3804a61c80233a7a
> > commit: c51da3f7a161c6822232be832abdffe47eb55b4c net: remove sock_i_uid=
()
> > date:   3 months ago
> > config: alpha-randconfig-r122-20250929 (https://download.01.org/0day-ci=
/archive/20250929/202509291645.fcBIaXMb-lkp@intel.com/config)
> > compiler: alpha-linux-gcc (GCC) 15.1.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250929/202509291645.fcBIaXMb-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202509291645.fcBIaXMb-l=
kp@intel.com/
> >
> > sparse warnings: (new ones prefixed by >>)
> >    net/packet/diag.c: note: in included file (through include/linux/soc=
k_diag.h):
> > >> include/net/sock.h:2098:16: sparse: sparse: cast to non-scalar
> >    include/net/sock.h:2098:16: sparse: sparse: cast from non-scalar
> > --
> >    net/packet/af_packet.c:1099:13: sparse: sparse: context imbalance in=
 '__packet_lookup_frame_in_block' - different lock contexts for basic block
> >    net/packet/af_packet.c:2541:17: sparse: sparse: context imbalance in=
 'tpacket_rcv' - unexpected unlock
> >    net/packet/af_packet.c: note: in included file (through include/net/=
inet_sock.h, include/net/ip.h):
> > >> include/net/sock.h:2098:16: sparse: sparse: cast to non-scalar
> >    include/net/sock.h:2098:16: sparse: sparse: cast from non-scalar
> >
> > vim +2098 include/net/sock.h
> >
> > ^1da177e4c3f415 Linus Torvalds 2005-04-16  2094
> > e84a4927a404f36 Eric Dumazet   2025-06-20  2095  static inline kuid_t s=
k_uid(const struct sock *sk)
> > e84a4927a404f36 Eric Dumazet   2025-06-20  2096  {
> > e84a4927a404f36 Eric Dumazet   2025-06-20  2097         /* Paired with =
WRITE_ONCE() in sockfs_setattr() */
> > e84a4927a404f36 Eric Dumazet   2025-06-20 @2098         return READ_ONC=
E(sk->sk_uid);
> > e84a4927a404f36 Eric Dumazet   2025-06-20  2099  }
> > e84a4927a404f36 Eric Dumazet   2025-06-20  2100
> >
> > :::::: The code at line 2098 was first introduced by commit
> > :::::: e84a4927a404f369c842c19de93b216627fcc690 net: annotate races aro=
und sk->sk_uid
> >
> > :::::: TO: Eric Dumazet <edumazet@google.com>
> > :::::: CC: Jakub Kicinski <kuba@kernel.org>
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
>
> This seems an Alpha issue to me ?
>
> I can submit the following fix if there is an agreement.
>
> diff --git a/arch/alpha/include/asm/rwonce.h b/arch/alpha/include/asm/rwo=
nce.h
> index 35542bcf92b3a883df353784bcb2d243475ccd91..b6801cd2ace962e11624737ed=
334a5aeb30478b7
> 100644
> --- a/arch/alpha/include/asm/rwonce.h
> +++ b/arch/alpha/include/asm/rwonce.h
> @@ -22,10 +22,10 @@
>   */
>  #define __READ_ONCE(x)                                                 \
>  ({                                                                     \
> -       __unqual_scalar_typeof(x) __x =3D                                =
 \
> -               (*(volatile typeof(__x) *)(&(x)));                      \
> +       __auto_type __x =3D                                              =
 \
> +               (*(const volatile __unqual_scalar_typeof(x) *)&(x));    \
>         mb();                                                           \
> -       (typeof(x))__x;                                                 \
> +       __x;                                                            \
>  })
>
>  #endif /* CONFIG_SMP */

Gentle ping.

Is alpha arch still alive ?

