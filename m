Return-Path: <linux-kernel+bounces-876460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D846FC1BD4E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65E525A450E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419672D4807;
	Wed, 29 Oct 2025 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWrzeflg"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EFF2C08AD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750028; cv=none; b=S36s8AWBH9eCuIW/FjqqyzFAVGqDbJvd0MbUnfqzV6N9dKwvvDIF3F6vmZC7X1sac6W490tFKo2F6f5sG/xRfajpwWkdUAZemSuCEyiROLBm/oulW2WuuBG6hFu7ZOEAVfnzC+FohrpPmlF8ET2RrisSXbI++6N8Wd7uykIeOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750028; c=relaxed/simple;
	bh=kDmf77tedE88aPpyfJr7LDLMgEGahb6mvhghT+unsfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlSO2OQ91Dz9Kj6Bx3RYu+C4Tg07c2soe0ulpJ+ibeXNm5HdRIm1elUdIUURHlEhZtsOsAn0rRCRlSn7F249VW9by50DAa2+npFFfl6xNZ5WLd8qWT8bW2/WKFK5xb0dwQBoJcDxrHtXrfWPMHrwzkzlDeVb/MjtWcY1T9trWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWrzeflg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-781014f4e12so96043627b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750025; x=1762354825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Ql3kbMwxhnndJ3lbzZIORatm4L5GmMvBgTbUDswXes=;
        b=IWrzeflgq6ZHT/wxLIr+4fEBpjETAJUJVtsmHELbhDPpUcxsGmKD+FI86zC8sKdLQZ
         9jhc5eKRz+m9XZBeJ1GUvnOwi0hk+mkxG96ECAPYlETNAsx4J6DC+c+uqCPZ5NJQ9l9n
         bN4Ke/3xZctGvre6aklfK3SVUXsJzCWkXd+sqRtpd1BQUSWe+3D8h7CoPbMmN68im+Mv
         t5jG7eSaeX79OAOjXkNGbGH/JA6qth4kvxICu1Jyj/oAqmNnzsXiTtB3+yJ4yHxZtKXJ
         ew4LtUsL0FPqRfxDm3sCa0DlDZn5d+B+N90kZE7atkqy1jLqbo8wNE/4dMlcwDD1xnM9
         q2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750025; x=1762354825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ql3kbMwxhnndJ3lbzZIORatm4L5GmMvBgTbUDswXes=;
        b=xVetJqqx8b6df3VQGyk+NG6cw9wQXOnhNygUA6GqqeaG95IE1fF6a1aNMM9u8dLETJ
         D6pkf/AcmvixhpdXJ7GqAZicYaoVmV4I0aWtntvmFitEIp3DC+cD69MDaKBFUvc4bkJI
         6Q4vdchlyma4k/EVnffa0X0GjyI+zYpMOj95HIVJKFAuY9CcXDv/YwKFgSg+bHIgtUGz
         qTdnVSepY7eRfsIK0S6Gjda3TPr9w4YTasjLUb37g9k5Yk7FpomdrULdJ2zWNvHnLHFf
         FUwu9/e9DxvPBk53xsaVjKNf9VSvRsEMP7AVaVPP1nns4EwIxMeyuF4Vte9s1FCC9oSh
         8d2g==
X-Forwarded-Encrypted: i=1; AJvYcCX02ERWRfoHZm/a7qJK+h789R88B7am36H6AlDVgyBdv7nuBaAmUdQUvzlHV5kkLLPNqzf4X81I5wkFE24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzws5BTeU2o4ZhXHgCo8pyPCS23xq27LJxvIIjEDklfa/uYrF8k
	SGf9bUv5YwK4N/JS0JpAIEqMw7tMHEeC0+dYmMPG2LB5TFH+bf4QV4D3
X-Gm-Gg: ASbGncsvY3/1kjUrb7gOVOK3bRE+DeBDiGH1s5rYyhcfk0jUidkJ2NcuqRwI7unoIpn
	Iz+Jc05EKR48XcJ7+FfLcGTPT8/Lw2+FzKQL2DkltiFiqDEhRZouPYkMZW2mKohlo485yreFjed
	gtEm9EGIL8cXp4P2FmYJorG7n8FAuI91kb/khT9fUbaQd6gUuTl3288D64riVyXVU1bD/Nr1bjZ
	aiwa1nrCB9MV7Mp0r3galEzvxXMq5GNCmEfXNqcbxLToV05ycye5ScxOvRQQ3+TYhE52a4I3Cx8
	YzZXHSrStl9vjoKuckNZOjp7B8Q8xHKH6Cr+meX/AD/2pcUGrlzcgqKrWrpgsPO49IDGHyflWed
	FQ0Z3CtWt5l8QN09k0rX+oVNV/i/EEMSctsTvctHaKycddbXswLKumIYo3sdD7hm7XbloTopFQZ
	PbHm7Uu3I7BBsTmf/6EpneKkGL6ZfSXmUXiFFz
X-Google-Smtp-Source: AGHT+IFvEwZzVVStxJAjLYAeH/0cv5R0d8RA0ZIolpAcU/vC/ccLMmOqB8ZJKQUFbO9HNadpf3N1Dw==
X-Received: by 2002:a05:690c:6d8a:b0:774:cc25:7f51 with SMTP id 00721157ae682-7862932fa5bmr29953597b3.36.1761750025100;
        Wed, 29 Oct 2025 08:00:25 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed140812sm36577547b3.9.2025.10.29.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:00:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:00:22 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem
 autorelease
Message-ID: <aQIsBlf4O7cyrXq8@devvm11784.nha0.facebook.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
 <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com>
 <aQEyQVyRIchjkfFd@devvm11784.nha0.facebook.com>
 <CAHS8izPB6Fn+_Kn-6PWU19rNYOn_0=EngvXyg9Qu48s32Zs9gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPB6Fn+_Kn-6PWU19rNYOn_0=EngvXyg9Qu48s32Zs9gQ@mail.gmail.com>

On Tue, Oct 28, 2025 at 07:09:58PM -0700, Mina Almasry wrote:
> On Tue, Oct 28, 2025 at 2:14 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Mon, Oct 27, 2025 at 06:22:16PM -0700, Mina Almasry wrote:
> > > On Thu, Oct 23, 2025 at 2:00 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > [...]
> >
> > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > index 8f3199fe0f7b..9cd6d93676f9 100644
> > > > --- a/net/core/devmem.c
> > > > +++ b/net/core/devmem.c
> > > > @@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > > >                 goto err_free_chunks;
> > > >
> > > >         list_add(&binding->list, &priv->bindings);
> > > > -       binding->autorelease = true;
> > > > +       binding->autorelease = dev_net(dev)->core.sysctl_devmem_autorelease;
> > > >
> > >
> > > Do you need to READ_ONCE this and WRITE_ONCE the write site? Or is
> > > that silly for a u8? Maybe better be safe.
> >
> > Probably worth it to be safe.
> > >
> > > Could we not make this an optional netlink argument? I thought that
> > > was a bit nicer than a sysctl.
> > >
> > > Needs a doc update.
> > >
> > >
> > > -- Thanks, Mina
> >
> > Sounds good, I'll change to nl for the next rev. Thanks for the review!
> >
> 
> Sorry to pile the requests, but any chance we can have the kselftest
> improved to cover the default case and the autorelease=on case?
> 
No problem, I had the same thought.

> I'm thinking out loud here: if we make autorelease a property of the
> socket like I say in the other thread, does changing the value at
> runtime blow everything up. My thinking is that no, what's important
> is that the sk->devmem_info.autorelease **never** gets toggled for any
> active sockets, but as long as the value is constant, everything
> should work fine, yes?

I agree, autorelease can be toggled so long as the xarray is empty
and there are no outstanding urefs (to avoid sock_devmem_dontneed from
doing the wrong thing with the tokens).

Best,
Bobby

