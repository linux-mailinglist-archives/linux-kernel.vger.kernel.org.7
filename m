Return-Path: <linux-kernel+bounces-861481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E813BF2D70
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59F342342D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73640332ED0;
	Mon, 20 Oct 2025 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckMa2meL"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8E03321D7
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983175; cv=none; b=h5Cgjc5Jv95xneIjvsI+3ebVXjpC/V2fz5kRMc1UgiGlc0W3pK+b83m9MGSoMGD2jIVciopKMju4Tl4qnQhiPj+deaqgcDtC/fzXzCZZFS8Tsy07c7kpjgk7R2gbxqhsq0ZoEY88jnesGV/knXExsIRRU5lJPLDhPw2spgGVE8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983175; c=relaxed/simple;
	bh=KSaItg7owfwMA4E/6gJC21JmHwkSPxOVuYXpwaVH8eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AzPjUZsU+G1J90iqVPSpHzjMdQmZpX4agUV8gSdpfUXNcRAxD3Vd/WO59CPAg/YOEIClIZMWWJp0PeqNuKaEOlkA2Yb176VnaxlvqS+KgMAwnKQPi4dZMDv3u8TacL/oEA9E/J9m4PJpCpUwnxQH8ZVuaf2GYD6axJ+W+R8xAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ckMa2meL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-427091cd4fdso2086335f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760983169; x=1761587969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBIpzP5plYQbXfXPYKWyaixauHg0jqN/NWqmZVZnNC0=;
        b=ckMa2meL3YPvWDcGwBK+YxZErpGCddB46OFWhK2kz//Y7OXWaoplOQkNAUnmuUlwhT
         UwUO6qTztXkgLnBUOXTeLpklIcjZRjsDO3IEU+AFS+JJqIA+a7HDyMCYG9HvBLEydabR
         /4o4ZqrEgoLWcIok+8h01A1f9lIWHwlSzU3eTBwV+uSlRlLscuKyMxK5QJ0ybL50ZE1+
         +gOWFTSqXucUWRMvQP8qZKVsNowus5gAKTCoJlW/pXj56ZH3kR4aqo9AaAS6HdWjr3DJ
         TOwLL3ppprrSfziX5fJ85idP8N87tMXbhB9xh/CYvHlmiLKf7uFZ8bD4plCSecztaNnJ
         zCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983169; x=1761587969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBIpzP5plYQbXfXPYKWyaixauHg0jqN/NWqmZVZnNC0=;
        b=wwgsXTSRD9jVmdAqjkoa1x8C2kUPg2d9n7v/oJsSKIKcvETTOcpcCTzahusjsQR7e+
         W2/ReE25Tax267HzFkbqMZ7Vav0AwCBrpR2EqPw5WGy5UxoLax+iHx5gVjPL+vOUVHF9
         5MpCWT9t1/3SoG3nDlS3supCTAxFaNb0Yb8FxLtuTKUkCiCLW0Wku8lC2kqDpu731dm6
         kCCJAxXVLjkiKhdwNzpVjo0GsNgMIG+ZxqvyEVjB4KlnqOqKHKXs9k4PYXPbkXE5GeJB
         IwR0E7GyDtVxRBfkMdDs9JFyLQPpFx2kmaTp8USNo+UHzjXs+hbKWRg/deX4PWnXVQv2
         Oyyw==
X-Forwarded-Encrypted: i=1; AJvYcCVKMoKZE0hjXka74/CpdfgWZZAYpkZwxMq7dROYJ/lV+CGo0rDJsb8RuBA8zXQx94YkWHJ06rf6ZgjhSp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmd9pxGClQqDLgzzt9bGAcLXOLq0gtEw6fCkji+5X24gfRhVv
	byvi6HJjHkuQ12qRdS4ayJstrTFXvfdLZlIFeMPVVfhslMOdz/mAKW5zVnzE0yoQFKI=
X-Gm-Gg: ASbGncvZQGddwMKngBET2qhrBlcer2aiMI3UwvSJuzywHdoEtU8CRatKmsyU5j066/1
	RVeaXcyV0jAU5v7xmBxbNPX5XllRcnaY74ZqwscvhYf8FczrypnsnQIyU/lPSejJaAL7AWQReK8
	Gin107X8OIsljUM4FtcJIksbDat2k+XPA4ePk2/63rUiSbT64JHkRFYrOvGUrncUtudhJQj5T9N
	2At/OQ/1BaGRIFOnR9SBPDOpoIdAReofh1dttC21/x0eJzPha5ZUdXTYZw/ZHzf8QYDKsWECp9y
	BTAxqmGkwHDm/jDvKvMQ6vEMZ7go5WgsT8lM5tq6ISW0Sf23GvoED9Z7/Vlg6F49GZVB6TJPIwc
	7GLQCMMgERu185la2PTR9vgNrY/TXsr+SG/i9EF/5QblfmYXHQAE5/n958bCjR9cfT2eWTgK9z6
	UfSNQ5cn9yIx3sKGQ=
X-Google-Smtp-Source: AGHT+IEve3rptaTxAGdVVvZ3C2zYTFALcxP2rlbTlJDOAnuR0ODFvI8Ya+F1oDNmVuli022ySOULYw==
X-Received: by 2002:a05:6000:2881:b0:427:1ba4:de9e with SMTP id ffacd0b85a97d-4271ba4dfdemr7326245f8f.63.1760983168883;
        Mon, 20 Oct 2025 10:59:28 -0700 (PDT)
Received: from localhost ([41.210.143.179])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f00ce06bsm16113493f8f.45.2025.10.20.10.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:59:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 20:59:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+2860e75836a08b172755@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH V2] netrom: Prevent race conditions between multiple add
 route
Message-ID: <aPZ4fLKBiCCIGr9e@stanley.mountain>
References: <20251020133456.3564833-1-lizhi.xu@windriver.com>
 <20251020134912.3593047-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020134912.3593047-1-lizhi.xu@windriver.com>

On Mon, Oct 20, 2025 at 09:49:12PM +0800, Lizhi Xu wrote:
> On Mon, 20 Oct 2025 21:34:56 +0800, Lizhi Xu wrote:
> > > Task0					Task1						Task2
> > > =====					=====						=====
> > > [97] nr_add_node()
> > > [113] nr_neigh_get_dev()		[97] nr_add_node()
> > > 					[214] nr_node_lock()
> > > 					[245] nr_node->routes[2].neighbour->count--
> > > 					[246] nr_neigh_put(nr_node->routes[2].neighbour);
> > > 					[248] nr_remove_neigh(nr_node->routes[2].neighbour)
> > > 					[283] nr_node_unlock()
> > > [214] nr_node_lock()
> > > [253] nr_node->routes[2].neighbour = nr_neigh
> > > [254] nr_neigh_hold(nr_neigh);							[97] nr_add_node()
> > > 											[XXX] nr_neigh_put()
> > >                                                                                         ^^^^^^^^^^^^^^^^^^^^
> > > 
> > > These charts are supposed to be chronological so [XXX] is wrong because the
> > > use after free happens on line [248].  Do we really need three threads to
> > > make this race work?
> > The UAF problem occurs in Task2. Task1 sets the refcount of nr_neigh to 1,
> > then Task0 adds it to routes[2]. Task2 releases routes[2].neighbour after
> > executing [XXX]nr_neigh_put().
> Execution Order:
> 1 -> Task0
> [113] nr_neigh_get_dev() // After execution, the refcount value is 3
> 
> 2 -> Task1
> [246] nr_neigh_put(nr_node->routes[2].neighbour);   // After execution, the refcount value is 2
> [248] nr_remove_neigh(nr_node->routes[2].neighbour) // After execution, the refcount value is 1
> 
> 3 -> Task0
> [253] nr_node->routes[2].neighbour = nr_neigh       // nr_neigh's refcount value is 1 and add it to routes[2]
> 
> 4 -> Task2
> [XXX] nr_neigh_put(nr_node->routes[2].neighbour)    // After execution, neighhour is freed
> if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)  // Uaf occurs this line when accessing neighbour->count

Let's step back a bit and look at the bigger picture design.  (Which is
completely undocumented so we're just guessing).

When we put nr_neigh into nr_node->routes[] we bump the nr_neigh_hold()
reference count and nr_neigh->count++, then when we remove it from
->routes[] we drop the reference and do nr_neigh->count--.

If it's the last reference (and we are not holding ->locked) then we
remove it from the &nr_neigh_list and drop the reference count again and
free it.  So we drop the reference count twice.  This is a complicated
design with three variables: nr_neigh_hold(), nr_neigh->count and
->locked.  Why can it not just be one counter nr_neigh_hold().  So
instead of setting locked = true we would just take an extra reference?
The nr_neigh->count++ would be replaced with nr_neigh_hold() as well.

Because that's fundamentally the problem, right?  We call
nr_neigh_get_dev() so we think we're holding a reference and we're
safe, but we don't realize that calling neighbour->count-- can
result in dropping two references.

regards,
dan carpenter


