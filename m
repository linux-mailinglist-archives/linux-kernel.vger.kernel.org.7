Return-Path: <linux-kernel+bounces-836550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3406EBA9FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDA63C1DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB8C2EB5AF;
	Mon, 29 Sep 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5pBEmhc"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1F1426C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759162620; cv=none; b=SZKirX4+OJzzABWm1Q/UqHb+8UPS8ZVHDBCdcrUHZXV2zlHMUgIqth5akrPt1D3qH1RopYyXJ+4ck4g7GLX2gIrd/HfwzYAVjCoNdNORfTbgLpe+gx7tNf66jf6/vwjdX+aMcgpaNNIX+njiSsH2hk/6fQgIKcYSdYMUQ6+d9mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759162620; c=relaxed/simple;
	bh=qq5Q8e7Te10C8Wo9eDCpNyBThP8X8+Pc+4FkCD7R3Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsPvYatg5uxq6VCps5ChPvrvXTsT/oGMSJ4RFigdNZ52EMz8RFcJacWFtWQcrNul5OfKeix+MTfhc1JgBjDpD+v4pnvYZaFZD19jQqiC6Vigm19/Lvaa7CxyMyG97fY3O3oEIscQq3/F+3GKVtvDMG0CY4LTmsm7vE1LVor8Vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5pBEmhc; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-749399349ddso60347047b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759162618; x=1759767418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKzIOAQG3VSXuePCJFysarRmV4K2U53AVIYmuNypgnQ=;
        b=B5pBEmhc8+fOBuHJsYK5WF7VA1aFpV8nkreJb72sbErLLiRyC1Qozs9M18OcBIIs23
         5xTFPqSI0pmrcFw+t73xYo3AZPOx1mvA/JhGsuVZy7iglF0Jeiav5WZ4mf7pIU9GFehv
         lG4Yp2OW/OTp+vyM1Sg0C/nLdH/Bc+hEthf5sXslr2XDozWHZe7OtbWHBYu3seNqeYrs
         /28zoNDDN1DsldjTg72F3pVVqsMVZCnhh+B7vCiVCCsL22g7Wy8epghtGjk0rrAnYhpH
         ppjgqQuI/PHJelHCA6VaM5nS9yKnWQLngnpJhHAUtqkbpCyZNsjsRh5hmWDuXGxC6xEx
         yqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759162618; x=1759767418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKzIOAQG3VSXuePCJFysarRmV4K2U53AVIYmuNypgnQ=;
        b=RY1pkDkPBRLmGMzcvmVLCX+LTnOY5UyokazTZOWitIAO2bKvuEKPvl83w5BnswltjY
         WcIvj4d9tImjxGAxOR2+/wUxrHcfoSrys1Po4bCC/tx7IFCsfXFHN8K/cvRsTVEc+Cag
         PCMtSoUy4am5z/UcDjJxAGBVeorzhMvpO9so2Ig0ZFjIM/AouXnJgxKMciX2jGMTtelu
         DdtxoVTy2Omn6er88lI31C5Vgeo8mRugCoCyy2hE6eGrc9LCu5y4ulzvaT0D8PKS1q1y
         B8/Q4Y+iOskZnLdqHxP89OCIwVBwIwf/+oRvmWcMgF4IEmy3LgHI6fo2OS7LROF//4gF
         NBzA==
X-Forwarded-Encrypted: i=1; AJvYcCUFQbKFzOkNOD44T4kyVyixJCa3astjxMXhS0ITkPPrYihbJOAcISJAMiplv3b8n/ZxJWLamCr2A04GNcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0eeo5VHfNzxgdlL6LaAgNychM2kzqumJUqwnFXOVxvSYb5nQ
	/BVDxNOjyVH3FpkceMMtQyar4ttMQe0QkWdb6CbnOO93CTKRYOjYu1x7
X-Gm-Gg: ASbGncsUrI6iDwpyQZEilWzxgk0nMZddvBDmUBUcl1oyvE7aOrXK5jAv37gmnkMMEna
	79Jv81D91y1bQ/tPhvPv5dO6GwA7OU4SDSj1fmQwt/CUPtsqZU9tTZ7h9EoIlPZU0vxuW+TCN4O
	EAh0KATtPaeZ3CjOytcVdgwX6AMpvuv7O67l+xoMuVaAmEApjovaPHYTIGWXyuqUUWbU3RvHkvm
	clIMjQPl+NjOIYqihv+qN0U5SEZGyk7APlfXWQEHAuIOR0N0tMj+or0AJI0eqqSLGYa/0H476yl
	qyhYFQBSy8In9VpJqJgzEVf5z7BuBNeKaZBz5Szg3VEhINEi9HEBTD00IFvdgngzxIC5sxTBesb
	TO8EpmfvWV/teoxrtntcPFGunTtG+X2aTd2BjRSaGplOwJQPEHyRxSvp3PmIyuEVf9w==
X-Google-Smtp-Source: AGHT+IHu+j81jqxT8WdCqypyIMYi8bUERDK1Od/FPtKQre70kkWgVYXAP03ywVWVYKUxZcJ1PFX0Dw==
X-Received: by 2002:a05:690e:23d5:b0:633:adac:db35 with SMTP id 956f58d0204a3-6361a72af2fmr13975034d50.3.1759162611159;
        Mon, 29 Sep 2025 09:16:51 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-636d5b1d847sm2712547d50.9.2025.09.29.09.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 09:16:50 -0700 (PDT)
Date: Mon, 29 Sep 2025 09:16:48 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v4 2/2] net: devmem: use niov array for token
 management
Message-ID: <aNqw8CAVjas0vvGm@devvm11784.nha0.facebook.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com>
 <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-2-39156563c3ea@meta.com>
 <20250926162245.5bc89cfa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926162245.5bc89cfa@kernel.org>

On Fri, Sep 26, 2025 at 04:22:45PM -0700, Jakub Kicinski wrote:
> On Fri, 26 Sep 2025 09:31:34 -0700 Bobby Eshleman wrote:
> > @@ -2530,8 +2466,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> >  		 */
> >  		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> >  			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> > +			struct net_devmem_dmabuf_binding *binding;
> >  			struct net_iov *niov;
> >  			u64 frag_offset;
> > +			size_t size;
> > +			size_t len;
> 
> unused variables here
> 

Got it, will update after window opens.

Best,
Bobby

