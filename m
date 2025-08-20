Return-Path: <linux-kernel+bounces-777508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B332B2DA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4AE565280
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054902E22A9;
	Wed, 20 Aug 2025 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Co8OJWgA"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62E23312D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686766; cv=none; b=japtQr0rCh3f1SRtmYxFzl71YLX1mM1k5/KBIUGCBujcKju25/kG+v7c2+DJwUzlYxnua0EejkcPdj/iRLe0N6ckTnhfhfbqKYxUOKZdv1rfb4FJtRZ8XkO5HuzT2xNKZXuuP7Ru7DFqFVYPJwTHqgNkIXepiupl1H1DG2KI7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686766; c=relaxed/simple;
	bh=3Me8tP3A/Dq4n2o7fv0IO64KsodsWLaH93wYg8ejh9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS+K6svoTVWIGK05E4LoEdJct+S/30h4uhiaGneWhorEB8ga2YlGQyzarL4iTSb/mdeWtfR0WhP4TjqEtec6h94QSUolfwY8cuaohfmdQlk1DVwh5raOEEGgtOPq5fBwH4kCRMBDBESFl/pWIDzGycKjWCOjyZ4WE+UzpEAaS5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Co8OJWgA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4746fd4793so2667598a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 03:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755686764; x=1756291564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Me8tP3A/Dq4n2o7fv0IO64KsodsWLaH93wYg8ejh9A=;
        b=Co8OJWgAcDrYJ0CyrTpBTa4QFaWJA/UXQ60iKWZvaB+48GWb7YDZkuqYINSGkm0uIh
         ZYXB/1/0Tox4yTgl7PAOB5auKESusYPvX7nPMjjVhmW52s1AVNACCbtT13QaRXH38FhC
         xZYMsIUNP3rnX9lupsBneDOUUij6WTTuNR0vjOk3bTlCFKHfKLLo4Se+Zk0Az2jZPKYZ
         89qwkceSJ63MV0U52UZGugtikzmhBleYxT5X46BJ95PXkC5HrytFkEEuhgi1L6/2wsWk
         8Ax1EW8XLAMY2muWjJvXyU5aW83Oo3g47JQIHVj+U42VncmORoQQi0GFxmFGkSvAvwok
         JpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755686764; x=1756291564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Me8tP3A/Dq4n2o7fv0IO64KsodsWLaH93wYg8ejh9A=;
        b=lV9vjTcSieb+bY8ZyKoEBXP9B7FHOF64/ghknBb6IPiD/gWKklGIunOPeepOMjuf0Z
         zn0+QevhZzx1YWUdUMl/xOhnfwk+ORDZh4mEZ6jj1qweam63hO6rAPkQG0ZRiWYesLmm
         YuIhjIvvkkgl4Ttayfj2I/t4/JYVcLoDktwvvheI0+McUrwGfCU6nyvMdjlzD6wtY2zo
         WNVAyFXzz52K1XdOvs765niaq5SZw2wJccLCiZu2oX4Dw1yWqnSmGAFsMqhjD3xL7jns
         gmi7Qg5K3PCpsrxPgYi6C9qHhXGabomGldtFuDVkspLF9cbo093gTjV+3uDhXXKlVhv6
         YjVA==
X-Forwarded-Encrypted: i=1; AJvYcCWuBlkuYjiS5oZIirSQNFaQ3J2+uS+uqcECQAuYjmfSd6aRS4ANGazWWv/TD+aMzwE/GYRfQrwUjLu6Gzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxszsQURguZg/sZecgqSK9pglR9oFshCVD35jkOUBcKHqmAGxN
	PmrMCo86DBSbyTg6DGfR1oU+kuwrbcwwtjofOLLFE8juURhBjqnRFsA9BWgv8FcyU39svVm9Fkl
	RCtqKXrUJB2MbnkDzCoTxt5O5aZSqgNvAFXtNkWPl
X-Gm-Gg: ASbGnctyUEC6/IVnfXBFTSwe5pMrJHWt6NAdHhjm1gCp/7Yk6KwxJFt66korZScXTyt
	omqvh168LAQrAZD8Biu4U1V3r5E1GMZHOunRJz5w6EF2HlCF7j+x7Fsf3MIlpBhzziMTMeuOxeC
	3M7e6l3t+eLAEtrZL6H8K1UCWNhUeY35rGMLXYUynK7i8TczdPf/4iD09mL/auDHqtTtNTLs16T
	GiT2pMR/d7qUz8kAHFJo6k8cxRR6yhBuRlrka2VWwtTXqiPg/y0W9M=
X-Google-Smtp-Source: AGHT+IEKtl2lrK5/2y4ZHW8BdiMqTimWqMJrLgdgwZdhWnnQOIhxftCfwBi0pC/VAlu+Wj78IDSFaxfyMArkbO0q10c=
X-Received: by 2002:a17:902:cecc:b0:23f:e2e0:f89b with SMTP id
 d9443c01a7336-245ef0bf919mr29929205ad.3.1755686763672; Wed, 20 Aug 2025
 03:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818154032.3173645-1-sdf@fomichev.me> <68a49b30.050a0220.e29e5.00c8.GAE@google.com>
 <20250819175842.7edaf8a5@kernel.org>
In-Reply-To: <20250819175842.7edaf8a5@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 20 Aug 2025 12:45:52 +0200
X-Gm-Features: Ac12FXzOW9XPurRHcsWYD8YIbcfeKfyX5uwi588A3HEp9L6p1uEzyk061ngsuoE
Message-ID: <CANp29Y4g6kzpsjis4=rUjhfg=BPMiR9Jk68z=NT0MeDyJS7CaQ@mail.gmail.com>
Subject: Re: [syzbot ci] Re: net: Convert to skb_dstref_steal and skb_dstref_restore
To: Jakub Kicinski <kuba@kernel.org>
Cc: syzbot ci <syzbot+ci77a5caa9fce14315@syzkaller.appspotmail.com>, 
	abhishektamboli9@gmail.com, andrew@lunn.ch, ayush.sawal@chelsio.com, 
	coreteam@netfilter.org, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, fw@strlen.de, gregkh@linuxfoundation.org, 
	herbert@gondor.apana.org.au, horms@kernel.org, kadlec@netfilter.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, mhal@rbox.co, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, sdf@fomichev.me, steffen.klassert@secunet.com, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Thanks for the heads-up!
I didn't even think that this tag could pose problems for other
automatic tools :)

On Wed, Aug 20, 2025 at 2:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 19 Aug 2025 08:41:36 -0700 syzbot ci wrote:
> > syzbot ci has tested the following series
> >
> > [v2] net: Convert to skb_dstref_steal and skb_dstref_restore
> > https://lore.kernel.org/all/20250818154032.3173645-1-sdf@fomichev.me
> > * [PATCH net-next v2 1/7] net: Add skb_dstref_steal and skb_dstref_rest=
ore
> > * [PATCH net-next v2 2/7] xfrm: Switch to skb_dstref_steal to clear dst=
_entry
> > * [PATCH net-next v2 3/7] netfilter: Switch to skb_dstref_steal to clea=
r dst_entry
> > * [PATCH net-next v2 4/7] net: Switch to skb_dstref_steal/skb_dstref_re=
store for ip_route_input callers
> > * [PATCH net-next v2 5/7] staging: octeon: Convert to skb_dst_drop
> > * [PATCH net-next v2 6/7] chtls: Convert to skb_dst_reset
> > * [PATCH net-next v2 7/7] net: Add skb_dst_check_unset
>
> > ***
> >
> > If these findings have caused you to resend the series or submit a
> > separate fix, please add the following tag to your commit message:
> > Tested-by: syzbot@syzkaller.appspotmail.com
>
> Hi Aleksandr!
>
> Could we do something about this Tested-by: tag?
> Since the syzbot CI reports are sent in reply to a series patchwork and
> other tooling will think that syzbot is sending it's Tested-by tag for
> this series.
>
> In some cases we know that the issues found are unrelated, or rather
> expect them to be fixed separately.

FWIW if you notice the reported issues that are completely unrelated,
please let me know.

>
> Could we perhaps indent the tag with a couple of spaces? Not 100% sure
> but I _think_ most tools will match the tags only from start of line.

Sure, that sounds like a very simple solution.
I've adjusted the email template - now there are several leading
whitespaces on the tag line. I hope it will help (otherwise we'll see
what else can be done).

--=20
Aleksandr

