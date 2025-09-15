Return-Path: <linux-kernel+bounces-816474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5F7B57435
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78800189CA10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056592EFDB6;
	Mon, 15 Sep 2025 09:13:05 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070331F0E29
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927584; cv=none; b=MLNedsM9UOwQWuR/Tb/cq53Lu0ECKylXDlWoHVa3eDytojIMLrrOuMBRl6+K6AtzXTHk0ijCQIdd0YSGq3nny27umIFfmMLJ2DimxrJvdQ4et+sMzKh45ATlWfPVNRJR9NJE9ggtPyl7XJDrbkydEocuxHH6tlj+sUH0u0/SEWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927584; c=relaxed/simple;
	bh=7+kB8ZMerG7yaoGrdsJ+/bImc0MjKYSjj9HksU+tMr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAhib8c0vmBQ2+Yo6pWN+ntLAMnhfbSh3llFSHJvlrE+mj8RjOPPA9lAmvDHrIsT91XxJUzbLfmt2ordLVTXialvDXW912B9mrNG51bBF0G4hIcfTU/LExPjfHMgWs82khiEvQ3yDXCxu19rL6TSRDiavX5AgV6Nu3hVISHYMYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f2b27a751so341291a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 02:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757927581; x=1758532381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtNRcJRwwCKEIJqf9/whpSBRpMqLegKM6RuT3nM+mBg=;
        b=VZNV6WbIkPFmBmRtesYm1/RQU/iG/D6/cpBoT/kSy3boz8j/dLXB6sEWP6ksogUGlM
         KbPHizOxWra2NPkbD//iYVQFSLqNSCuPt0xuGy+YKNfTSCLmx1eUGAbT9QOKz0pZfvl8
         QiamEamHO25pwphfStCiFf61I9Ypd9iKMiEIhprQvLhUm+FQXmKlIURv+/Q+Hz14dO1a
         wQErQPT5IwZRYAabbsDeb8AAneCdLJquKRjqbQ5ETHu6+n5Bph0co5ySP11bA1409Lgi
         lkTEGz45K7RowP9fUYVpmmOSxp/meDeW4w2B44w+RLE5INwyWtveJBBTSTVzT/9Wo8wK
         voNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD1IxWi+h1+NRMWo4kpL9bX6WXWNVeiuIl26aRW8HyzaOSbF/5EKnuhYZHZdS5ffjKblVFK4AXsticC4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Dlm3T/75t2pRT2NqxgrJ1qrZk9c23x11L+FMb2G3iTgFzcHF
	PWKXKYREwrac3+4lekMBGF7CDgl1figrvRmkctHKD3rDySFl/5AW0nBK
X-Gm-Gg: ASbGncuk1JfiT9v6vaJ0zwgXRStl7wu53YikKuFRNBvEgl2lmwJKFlI2cybh/gMQlNw
	aZwXfHytgWcn6eUjUK/W9cVrsV5gHbVM5bOBBlABQ1IdKiwl+ySM2F5omdFpLeIa8JhklGx48HZ
	IeJDRvJaw/dVOXZPbAGRaYYdoS3/oVL89lzMjkWZbKXvHZSCd3/IOkwAmgD/eeZScLEOa8ep0OO
	/aG6wj0A6xN57yIA+LflI7+yPE3Ct2bfs5OBXJi+m0zaGN3bDBOEibxbBC3BsG3CZfd+JNRPtdQ
	cvi4uJ4nAG8bQZ3Hlk+iJ8ARERRwemhKAh8YYFqPTePAgOmGClhM3tK+GZLTlv7OdTv04bYRdPP
	UJwtrt08SjDb4BqZkduGH/aAQ
X-Google-Smtp-Source: AGHT+IEAqk1Bgc7JcF+1aQKWXD0BySjNrACtXO/rAEWZU4UuzJsWjT8CX+gGJiPIKhaccM3UW22mlQ==
X-Received: by 2002:a05:6402:2742:b0:61e:c750:1ef2 with SMTP id 4fb4d7f45d1cf-62ed82c6d29mr11320958a12.36.1757927581094;
        Mon, 15 Sep 2025 02:13:01 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:41::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f0dae0140sm4601341a12.48.2025.09.15.02.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 02:13:00 -0700 (PDT)
Date: Mon, 15 Sep 2025 02:12:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/7] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Message-ID: <zskbmdjunfamn3x3kmxcjeamnckfh4icb7emwkkwhqwstlzt2e@nqjcg5h6hgsv>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <20250912-gxrings-v2-4-3c7a60bbeebf@debian.org>
 <20250914125949.17ea0ade@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250914125949.17ea0ade@kernel.org>

On Sun, Sep 14, 2025 at 12:59:49PM -0700, Jakub Kicinski wrote:
> On Fri, 12 Sep 2025 08:59:13 -0700 Breno Leitao wrote:
> > @@ -1225,9 +1242,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = ops->get_rxnfc(dev, &info, NULL);
> > -	if (ret < 0)
> > -		return ret;
> > +	info.data = ethtool_get_rx_ring_count(dev);
> 
> Is there a reason we're no longer checking for negative errno here?
> It's possible that none of the drivers actually return an error, but
> we should still check. For consistency with the other patches / paths
> if nothing else.

Agree, we need to check the result of ethtool_get_rx_ring_count, and
return it if negative. I will update the patchset.

