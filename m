Return-Path: <linux-kernel+bounces-734848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16630B08724
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD5D3A6FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFA2252906;
	Thu, 17 Jul 2025 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="McGtCGU7"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355B24678F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737984; cv=none; b=s2vjOb4n7xnGVygmS1HOfT6d8h/4AURVGkkcbhBQvPaJXPGNbPTn2BtSSPJTysWfi+UZTwC+/DBnDpLywSY6VgQL7c2XODP8G13b/bBIMvdqcfyTV2rWePkcNSC0T6zq3ie+03ghcTkGEypLbYL8Zml68eZP6NA3RvlJkVHsSng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737984; c=relaxed/simple;
	bh=c1SDrxfLLPZRWNeLIrVQyUTtngjOpUdLlP1bIsTbheM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAZQWmjxsVsa74QDZ3xx83KKg7nbvU5GuBfOO5xRABVCIkybZzNZULaLodIgItVkNCz8S1S7U5KjZ58buNPJzhsH7V1vSFz1U4rSej2H4fNRSvtXUkRMX/uyxzCrf6NPz+dq48MVvjlS0VoRTzmydoSi77tjxX5fTzXm3tZvMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=McGtCGU7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561a4a8bf2so6460815e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752737981; x=1753342781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZrEPyAzZYbXLW4hzHIwK6WyS3z7Lh+pQWOnhcrXs9U=;
        b=McGtCGU7Ct1HFX/FZE+agQrvazf8sqcQ9PSesOVQ/lbpIqwM7e8RZsDJ9ceAyBy806
         /MG2QGNJAeWxyHtjbmMk0Cmk0xfmwH7jFMqxh72Sz+jIendvhfm5ykUr+YzmDfSxqO71
         UXuUc4zB+c54uQJ/apwH0wwgd2ZpBCLjX8FAqr6/KPzcIE3pBQp4Fy9fST4WdclLgi9x
         5jp9bfZvfCAqg45egbEhbnIeAozW3UndcZ42JqFFpfxWpMj4qXrNfM7VNiTGH6YQ2GJs
         Qv2My1yAJANdflSko6SGAQBdMbnmZn1YTcQk+OqU1owgW6irkN0TYDqH0/KJHrImaErf
         P+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752737981; x=1753342781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZrEPyAzZYbXLW4hzHIwK6WyS3z7Lh+pQWOnhcrXs9U=;
        b=sXwOyyeX0J/BEZbJdW7oK3vDj/o/q4H+PFLlhvSsiei6GY1gaax6mQmmwpolY7DhUV
         V0uUE4Kcz8+JeCTvHN1/vVUq7fgPHI2cbW25hnYBvWs+yXB1eUtEfxtR38/Mm1to8XWL
         yzRIoow19Pc5zdRPhnQubpT9DLkKGskWVDIq5d9cX7dv3v/WZF+ToUKIp7IJp+uRmFyp
         reWuvTfR9gu3d7UIWlrc+d2gpBxiJno4VdpOr4NsZmRDJNP5j8gtaIxoY3ch8atYY0jk
         6Ehbwv023jQXPHJ3kWVQ5bflX878jGrrIwzpbC3AZ9LvBFtk5qOuagn8hemJDIWvD15d
         aKyA==
X-Forwarded-Encrypted: i=1; AJvYcCUu6b1xq8K0q2RwUw5iUAsN/uFb9gGwi27wobz3V2gxrqu+TqaJ2mEiSmiqIFsbw8PbP0c4G7qI7h/Bpus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhLcHGyiv9oSE4VXTtR9aKnu1HGS3tYbVGrhMeewHnKXNczHQ
	4GUTAhgyiRJ6Eva85mNIbZ5lIzzWYlLIgU2qe8psF42n9oN+mERFpHhAGCT1cLnD5rN2dU0bk7v
	dSu7LpJY=
X-Gm-Gg: ASbGncvgBiuAlPWFaxNYJbzTgJJqIS6zaAVXUdHpOYdIBRJj/suBGWLK2i9VhcGDdMc
	OUF04Lbcoa1H7SL7XE90wKXMrbF56FnCuuxHi7ZtTRj55cYWdaDuNfG4VrZCGW74q3J89W/o+yM
	Y7avi5cnzwgtnNvxXYsfg7UGWbR8lzAjfesxvGRpjA8rY822LIk/cghxYPQIQBDeOLKrXMZ8JRM
	NvretEw9KW5dNWAFpmxnJaJoV2yR6nDwzLt8korIxi5k55ndmYFXm9YMQFcN4RXK2s5RPB2Q+f+
	wRmtyP7TaiKh2rSUA5F2P7aRAmuV5MGDV5FaS8UDDEqbiSbKrhC2wiGVA+gW6SYhOMvmA844qJk
	Oj4qAJkhDEISob/ar3E1U+cQR3tqOz7XH
X-Google-Smtp-Source: AGHT+IFbX1qXFEm12UZgCtjQ6Ap8m0iXk0vzkenICIjnER7OgxzIO1RlyefnNXjs4zMt4Zi9EGbdFA==
X-Received: by 2002:a5d:64e9:0:b0:3b5:e084:283b with SMTP id ffacd0b85a97d-3b60e4c1e2fmr4324167f8f.17.1752737980787;
        Thu, 17 Jul 2025 00:39:40 -0700 (PDT)
Received: from localhost (109-81-27-43.rct.o2.cz. [109.81.27.43])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4562e89c751sm41728305e9.31.2025.07.17.00.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:39:40 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:39:39 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org,
	hannes@cmpxchg.org, Roman Gushchin <roman.gushchin@linux.dev>,
	shakeel.butt@linux.dev, yosryahmed@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: introduce per-node proactive reclaim interface
Message-ID: <aHiouwRh_Z7MPfV-@tiehlicka>
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250623185851.830632-5-dave@stgolabs.net>
 <20250717064925.2304-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717064925.2304-1-hdanton@sina.com>

On Thu 17-07-25 14:49:24, Hillf Danton wrote:
> Davidlohr Bueso <dave@stgolabs.net> writes:
> 
> > This adds support for allowing proactive reclaim in general on a
> > NUMA system. A per-node interface extends support for beyond a
> > memcg-specific interface, respecting the current semantics of
> > memory.reclaim: respecting aging LRU and not supporting
> > artificially triggering eviction on nodes belonging to non-bottom
> > tiers.
> >
> > This patch allows userspace to do:
> >
> >      echo "512M swappiness=10" > /sys/devices/system/node/nodeX/reclaim
> >
> When kswapd is active, this is not needed.
> When kswapd is idle, why is this needed?

Usecases are described in the section of the email you haven't quoted in your reply.
-- 
Michal Hocko
SUSE Labs

