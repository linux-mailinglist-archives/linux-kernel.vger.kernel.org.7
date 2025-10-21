Return-Path: <linux-kernel+bounces-863354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAECBF7A46
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07D614E976D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4EC3491E8;
	Tue, 21 Oct 2025 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b="dOZS0BM0"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD73491D4
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063892; cv=none; b=KU+cL5XAyupAqVF4iprh6yR/EKo+unD1bPAxIhexvmsExlNYvJmuINJM8+1nkkiddr4IXr/sW2xv8T7oO4kyrI+fF6uFk61LxjUZ94ruvGRWVpRsejDZUGWt3ecvfA/6KQ7Y8u517jST9W9wjxenJpDT/+X29N/Jht/6IB7OeZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063892; c=relaxed/simple;
	bh=LPxcUV/uZgRLwv77CFqbAK5ZXM2mug3gCnaHpQGcE94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJo1TJ8Q7vs7KvK42WAiKpNrL7xWLaB7ErTGtbBzV0SdrRDEd2hBEcQXFCehk8Dtwod3hSeVE+j2aNE9fjlaDrDNyxDohhqFCChh4sdTc5XI7g/duf5Z5DDcOSNS5hr1fHEOsedgUFjSYlJmDoLbTF1cx3NI9XPNNLYfcFNboPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io; spf=pass smtp.mailfrom=vyos.io; dkim=pass (2048-bit key) header.d=vyos.io header.i=@vyos.io header.b=dOZS0BM0; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vyos.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vyos.io
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-73b4e3d0756so64728057b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vyos.io; s=google; t=1761063887; x=1761668687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUhkDUpdWJD0ROxc0J5na9HrpWd09vQOwYetoz8/ls0=;
        b=dOZS0BM001wApP4MQUQVYMoA0ZL8aGm3ELyHJ5tDbiNjfFuJDJgxStpnOfqDMbnwdO
         4oA0DhnHXme8S071kCbgGYTuOFUhXbbXthj9CkZQN4f1SFHW5ydI6HW4A7FBjwze8/9O
         kxFL/ALAltq5PjUM1eodmtTnn2UhNOIMYCN1WpvXBcwE6p0b9Ss8+WICd5jnsiTaEpZR
         jujBkyYrCKirvzB/v/SlNdJAJ3bLkavYaGhvuOSPXhhy+qjjtdW4hm7AtOMacx8pF1dM
         QQlL7ADjXWv8vE/e/WvlML3KQe7NQRr08k/vXAf9P11P4b0U2g57S8Nhc5BpVDFuWZGF
         o0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063887; x=1761668687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUhkDUpdWJD0ROxc0J5na9HrpWd09vQOwYetoz8/ls0=;
        b=VV3BxqS37iylqHakMvRaxFKAv7lOipCYQQ9j0m1IXhmlEdnTHPkrfpto9Qnw4FsWGT
         VaP/JUjDTF4efVOEDkOsnGLz+KaGEiiW2Hx9UpEBJyIIJIvrib6TY3gIOfvFvNjpF0pI
         3ojTO/wkYxOGN0jhRPh9T4R+PSkO3Tn7GEd1aIKEL9O4Q4XY+u7gUmKAty830jzvHVmB
         soUE9fgeCMwfQDRe1SCoq242762lNXS8TsSs9Ux/OnfD94LmxG1uaXkc5VGevQ1aU9YV
         sCbKPvwFQXO24R6sw3MSpkJSUSvlq37bXM9E+1z+OCyDidpf2NNoMtyD91bUce0WgFGf
         dgpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQGj4AnGVLljXcZ/O2CHn3mT36qfhRLvLkeeP+BUM+HC01l1wScPTFa1B6PUh7NUQzRYgIuGs/kTE7Hpg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJU42XogGrGQ/4PGbWYrFsskk1c0E/R4d7pvWgl8hPxheTbpaL
	nSWpcxUlaW3k2xX9UykbjZLwqBKW9bshDO2ImeXpc+rIluxR01+YJ1++7vgaNEdkEwyaaD+DvbE
	p+wKcckR3MDu/HHhmEir5huGk6sSMAAX/yBRZXdUadA==
X-Gm-Gg: ASbGncsySNVhLaY2ZAT8HMSyBkXghYXYfl5VMfYqHG5T0WAlUI0CjmWlF4YMUC8agHG
	sU/H8HSzSyOnJHCFMJfdcfqsa0aZWy7H2EskMl4OFUNnATlWE2ww2SM1we7tS3giaMq5sHeUmDM
	4GC0138nl7W2Mpuu8ghE5j0hfGAptStuH7KcXDBSGVkn+3q/cdwX/b4Ev8qHnF7hQ3fY7a9Bk1U
	a3WLQ8Ib2d3oVSUYSqO/6BhnPhnxdtyqYFCi0SMOzSyO7K80tCIkyBmIQQN6L3QNNqpwQ==
X-Google-Smtp-Source: AGHT+IFIzbGahgpm0Eliv/ifkch8/rPof8WlRMgywPs12B4KoNybuHeK0ASzfvhF2LV6uGZNnc6bklwBlg55lommUi0=
X-Received: by 2002:a53:d047:0:10b0:63c:e3dc:c2c with SMTP id
 956f58d0204a3-63e1610ebedmr10995594d50.18.1761063887030; Tue, 21 Oct 2025
 09:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021133918.500380-1-a.melnychenko@vyos.io>
 <20251021133918.500380-2-a.melnychenko@vyos.io> <aPeZ_4bano8JJigk@strlen.de>
In-Reply-To: <aPeZ_4bano8JJigk@strlen.de>
From: Andrii Melnychenko <a.melnychenko@vyos.io>
Date: Tue, 21 Oct 2025 18:24:35 +0200
X-Gm-Features: AS18NWBuMcw-0lPVxcWWOGxdZHPzhJEVza7-n0ngZzaB1sMq4eLnUMOo6bQ7bfY
Message-ID: <CANhDHd8uEkfyHnDSWGrMZyKg8u2LsaMf-YXQtvTGgni7jetdZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nft_ct: Added nfct_seqadj_ext_add() for NAT'ed conntrack.
To: Florian Westphal <fw@strlen.de>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

> I think this needs something like this:
>
>       if (!nfct_seqadj_ext_add(ct))
>            regs->verdict.code =3D NF_DROP;

Okay - I'll update it. I'm planning a proper test.

Apparently, I need to provide a simple test FTP server/client, not
fully functional,
but sufficient to "trigger" nf_conntrack_ftp.


On Tue, Oct 21, 2025 at 4:34=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Andrii Melnychenko <a.melnychenko@vyos.io> wrote:
> >
> >  struct nft_ct_helper_obj  {
> >       struct nf_conntrack_helper *helper4;
> > @@ -1173,6 +1174,9 @@ static void nft_ct_helper_obj_eval(struct nft_obj=
ect *obj,
> >       if (help) {
> >               rcu_assign_pointer(help->helper, to_assign);
> >               set_bit(IPS_HELPER_BIT, &ct->status);
> > +
> > +             if ((ct->status & IPS_NAT_MASK) && !nfct_seqadj(ct))
> > +                     nfct_seqadj_ext_add(ct);
>
> Any reason why you removed the drop logic of earlier versions?
>
> I think this needs something like this:
>
>         if (!nfct_seqadj_ext_add(ct))
>            regs->verdict.code =3D NF_DROP;
>
> so client will eventually retransmit the connection request.
>
> I can also mangle this locally, let me know.



--=20

Andrii Melnychenko

Phone +1 844 980 2188

Email a.melnychenko@vyos.io

Website vyos.io

linkedin.com/company/vyos

vyosofficial

x.com/vyos_dev

reddit.com/r/vyos/

youtube.com/@VyOSPlatform

Subscribe to Our Blog Keep up with VyOS

