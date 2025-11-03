Return-Path: <linux-kernel+bounces-883240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3DC2CD29
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D831B4F4B45
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921CD3164D0;
	Mon,  3 Nov 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SrAu+Te0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4fLG3R8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF33148D5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183781; cv=none; b=uIbNGbShJ3zAl1PMUvcx9Rh88xFmWfrB4OMvpBGdupYtL7JUlPGzNFMkOjJMAYs/vD2eM+8UHDsT9JAk3DghmeJKfgox2HL9t2c0zG+81OraJg22vn0ZHaFLSvq/ma2ZjbQNIW5lDyapUhAN8lFwB1ghMqdJhnxZlo6ewGPxs54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183781; c=relaxed/simple;
	bh=qxXgG1/ZVfoTBQmNPKXK2gfg9Lk7YA9Q/vkKgYC/5i0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKreG8tfGj8cTxxKiS6IQ0tjZlwfjIAtRTRFgIhEhJm9VTRYU+I7t0sTCfOoIWjmWozGBZdbBQU1cd+HSW6rpqLDCPQTYtWiTPn3CfYdJ5PcB/8tUxpW+13XhrbqtOUZKeYSheBz/7VbcWxrci5yZrfh1P+q+lOdvFFVBmsRxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SrAu+Te0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C4fLG3R8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762183778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4KzmL4mSHOG0NRY4Olfh+OhbksQdgkf1/uGRGrjW9s=;
	b=SrAu+Te0vZYWMraBFKkpETtMdDdNjLhyEfSZu0g13jtWrF6yNG/OpcyWX1yaMA02Cec2ca
	gLHKfQNBuvcA2j3ekDmk1K1WyLHrocd5ZHt3x8UIyBoHgQZHqXvWmOKP2Vnvuszq0Ubv2W
	N5TU0SxR6VFzEg9JweFiuruYlkfeCcg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-CbDqoPwLNR6Z-1eu2MNPpQ-1; Mon, 03 Nov 2025 10:29:36 -0500
X-MC-Unique: CbDqoPwLNR6Z-1eu2MNPpQ-1
X-Mimecast-MFC-AGG-ID: CbDqoPwLNR6Z-1eu2MNPpQ_1762183776
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b70b2b1ef82so177026266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762183776; x=1762788576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t4KzmL4mSHOG0NRY4Olfh+OhbksQdgkf1/uGRGrjW9s=;
        b=C4fLG3R8kIVETsIIQfoDR+LTrUoT7XQ9+BQTQcDbYdajSqtFO6rKOIrZIeza87P579
         I9N5cdGwT4fAyJ+ONc3B/68QgU+m5/0xtHlgybUYzxyQ9DBJhyGRLX3rCMHua6m/WPru
         DhsVcfJf4XmB2r2i51kGt0urU5utSkJWegIfOYDjZGQwf+QFFJ1iUw078cyP9LPgjp/D
         6ipnWBebG7c7Pqp4tG/A7dFaq5AyJoNDS2KtPfI/tsDMQOdIwXLqTrgWaQ6OjXSvO0fn
         gEiz7lvWpqpPZ3E9Oh5CgfW8DBFq6RMFaCrTD214AgbGV3RMuKS1tYDZTJnS0wwTV089
         QOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183776; x=1762788576;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t4KzmL4mSHOG0NRY4Olfh+OhbksQdgkf1/uGRGrjW9s=;
        b=NacxhvIIsHs7dK5wBm7xyqsPzFBuzlhkg8FziYua/4ID/xEtOz62wRnH93GmC/glVo
         n+13qLC4oXuRX/HyZSbXDGndf3C0jXfZeBmQTuXHysQSGcZZWCS7GYo/nVf7aLGp2s7b
         JpdQfvX+PPhwwLbDlBiumhZzycC5MH1DlUyp294OJlrh7C6UvFujSE0F8vVhE8O+fU+/
         KzN5poMeJMTSiT2aHH7G0M6/cDTgui6DflXtur0QrmQjVNLl3PbBOSLV63Atvfe7IsZm
         3lkdXlmHJRVLy7wg3XrzMtsXORQNePQ5fXtuXiNahMBGzXR1DIWRX8wPpivZVIZHnuWF
         H0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm9fQs81QLJukMjAw6J88Jt+noz/5JIpDIREdbM9LAjwJrHhg331KMgO4xYema01CJrzP+o3/B9S3JW2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7hz60/HLCrRGKViE385U+42f26h5vzvXZN8Hyy9PAnZb4oLr5
	AjSJGEYsFAJ65o/+AXAcOWQ4HawHhe5DHGhPq7mByUKSGVTwYoDPi6ooUnN4MV7oj/+FwQ7DJbn
	Gja3zwHcdg4YQbQSIBPoGblCEnqTsD0BbQMdOWaIaFxdVXRx1ybQNJDzoaNnbAqTfSy852A36OR
	ds3XOLa7ig0pKD/Li5uLytUrmaiXyD7nIm6bA1FEFF
X-Gm-Gg: ASbGncvDMLO1PN+DNHGfOqY1LW4uGkcUE6nejYNyqZzLyHAmfidLhtrOdQswMXQU/hu
	QLvLQ7UG4XZfnqT+p0eRIj5NAjo1Ns4iirJUgJMSOQYKP4gOHw9RN55t7Iqv5S4nJXK4WhvPGoU
	/Y4k+qg32Bxrk1a8nl36vtUxzLjs9idC7mWNcG2W9xovLuOEyFFpb8xU2mGQ==
X-Received: by 2002:a17:906:fe01:b0:b6d:7f68:7874 with SMTP id a640c23a62f3a-b707061f144mr1297002166b.44.1762183775584;
        Mon, 03 Nov 2025 07:29:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEeyre5gK0cpKI1Q2+DYzhOn6+InSCUe74E0Xci1qbbA4oEB0h8kkJflrWJ9RIbM5vQPgseW5T8lTrnZTRw/4=
X-Received: by 2002:a17:906:fe01:b0:b6d:7f68:7874 with SMTP id
 a640c23a62f3a-b707061f144mr1296998866b.44.1762183775184; Mon, 03 Nov 2025
 07:29:35 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 10:29:34 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 Nov 2025 10:29:34 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20251029080154.3794720-1-amorenoz@redhat.com> <20251030182057.59731b84@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251030182057.59731b84@kernel.org>
Date: Mon, 3 Nov 2025 10:29:34 -0500
X-Gm-Features: AWmQ_bmA0xF3CCQQU1dc0lEnh7ovEiiQIFlXKGri7DAAHjaQidAdLsxH4BmtAE8
Message-ID: <CAG=2xmOfirDS58uwj=eSsn1KDrkX3K936SN=cCU4ARw9WSaogQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com, toke@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 30, 2025 at 06:20:57PM -0700, Jakub Kicinski wrote:
> On Wed, 29 Oct 2025 09:01:52 +0100 Adrian Moreno wrote:
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -1275,8 +1275,9 @@ static noinline size_t if_nlmsg_size(const struct net_device *dev,
> >  	       + nla_total_size(IFALIASZ) /* IFLA_IFALIAS */
> >  	       + nla_total_size(IFNAMSIZ) /* IFLA_QDISC */
> >  	       + nla_total_size_64bit(sizeof(struct rtnl_link_ifmap))
> > -	       + nla_total_size(sizeof(struct rtnl_link_stats))
> > -	       + nla_total_size_64bit(sizeof(struct rtnl_link_stats64))
> > +	       + ((ext_filter_mask & RTEXT_FILTER_SKIP_STATS) ? 0 :
> > +		  (nla_total_size(sizeof(struct rtnl_link_stats)) +
> > +		   nla_total_size_64bit(sizeof(struct rtnl_link_stats64))))
> >  	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_ADDRESS */
> >  	       + nla_total_size(MAX_ADDR_LEN) /* IFLA_BROADCAST */
> >  	       + nla_total_size(4) /* IFLA_TXQLEN */
>
> Forgive me but now I'm gonna nit pick ;)
> Please break this out into a proper if condition.
> It's quite hard to read.
>
> 	size_t size;
>
> 	size = NLMSG_ALIGN(sizeof(struct ifinfomsg))
> 		+ /* .. litany .. */
>
> 	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))
> 		size += nla_total_size(sizeof(struct rtnl_link_stats)) +
> 			nla_total_size_64bit(sizeof(struct rtnl_link_stats64));
>
> 	return size;

Sure, I'll send V3.

> --
> pw-bot: cr
>


