Return-Path: <linux-kernel+bounces-758962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4EDB1D644
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EBB1AA20D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF666275AE1;
	Thu,  7 Aug 2025 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r+xBzmlb"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1B323507B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 11:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564470; cv=none; b=TtCf8gnioUr4wyWDsQbQlJ5pA4F2G36jvMrVj8ruiagVfTtX5dwolXlcMRVsjTHxW19RZBpx67Xvy/adKYy1/aCzBpXZeGfvXWlmgIFeg7s2v0MzJWzkvB+Sp3WuZ05XG6YI9pJ83fUSsqlIPfK9QRtcjswwXzkEWus63116akQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564470; c=relaxed/simple;
	bh=E8jZeHT0wkxyKIBmLVv0ZDLh/xYOgqEKfNBea1dffls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfrusqechLzLKJqDuBF+c/r3ctrFrkDF0LPq5AcDvYa/WnVItGIirtYJx8t6nmpxuxJL4QkTMcR9UFpFADEucN0F3HA4ElAdZ1sgBLWZiZZiqB6OG+RK3snEQLN0VXh2qJXKJZmeWqocr+VEHS++G2rrJCVtIVm0UE8yXM4GMcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r+xBzmlb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso414056f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754564467; x=1755169267; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z1LA4zLatdYQ3Y3OjAbWN8XrQew8n5n36uGhalyKn/8=;
        b=r+xBzmlbAyQG8aUBZ0VvEeycKoMs/+G3HiDWEl3rOyx3HoTGnfYQiA2RPCjEC9OmFP
         nZpLiBavJqjZuEOMNsF/d3hO8aKSzZKnAUkrUpULrdO8qTZICkkZXjNl4iW+J5VS0cKN
         7Bs/T0tZ49Zxgn0elY1ml1Ji2u1NW2PedwWsR2dIavUhcniIIsktBrP3tYQCru2QisAG
         EsA75pwKiN2yE13PN0p3bTn58ai9S0RY9FmzzZ8ekApm15xx2jM3/Ws/uqYV4rzmsf4d
         0Vj8SOQs30h5fenc1D/iaKpq6dSNohKUKXIHjdaTDxGZX/pYSJJ5zoKIjnc8WMn0mLvV
         IUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754564467; x=1755169267;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1LA4zLatdYQ3Y3OjAbWN8XrQew8n5n36uGhalyKn/8=;
        b=kjSQAPCnGDyaY142Gnfj2+/0dWvuDG2mouewDjxNn4MaQkxUWH8ejQ7znk2kmB/F2T
         fXYBRRrfclssu0qaDkd+aGokRjr5VbcIaCwQtuxNCi19BzGUgq0cVuTg0ufamtxQnyvy
         JLGwsYKNGbi36jn3qjDvNl3HoHYNr+G0TPbBButE/RHGHKdKnrI+8x6OeK5zb4UMOFc1
         0RQoHxzIJkBj8gXl1xyu0Ngiog0xzf6QDtOIXzyDB5rf3q1lhEctte9ZD8Kyn0ychdZy
         n/UEXoEL23j2F0Ey3fGQUTxsndbScooKQvzISBAsgIXEOuKoFIf5szSGrRz+ELbl+xY+
         qKew==
X-Forwarded-Encrypted: i=1; AJvYcCUaRsF0GwKzxDMBck2UNBiU7mQOW5XIWlXMvJjFLFBRcZWird5p4grBiHQIIoGvOEBoTO2GMgZsg1awk1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzx/y5DY9WIKf0jnsWU+nEfYzEPFNaCyONkIFixT6oD4PPMvQ3
	nHXMe3dHDn8xffRVBASFj/LqVJhFTkwnnfmoX10ew/hgIOTTgAYzWlKC0R48HNuVoA==
X-Gm-Gg: ASbGncuawWU+Q/0DXS3JQzNWpDk6PtvRLsspxSXEtvQVVTnijlqJjPVoqdumdQMHXW2
	tZ558qCjR9wDWo21afGLMYnP0sO+5b7z6MVpzTLgfWm+xITh2tpFJmQhewYNQyS6H8DCetjbs6v
	u95DwNmzFE3Db3YL+fmggTL7TypW8YaOfweqn7ajmxbn9TdOSmcWcPyKCTk6pNNILtd5YrgJbi3
	wj9I/lfhjlJLiwbzpR1z6ZJIUmHVMIdQrWvSxnySLY5L7iSoox9LupxV3Bg2vaOr17vET+qdwQI
	t2Ve8/mGIufr86QY270huoqnT3GBX3CTsy7kCjdwolBbG0ka7v48B9p8omLgBAbFgdsuIfTRC6g
	+4w9QZ9o6bpaYp0OTJqQc7f7VRW7VDmUU9/tTBuVSrewu81/YD7/0VfOePEs=
X-Google-Smtp-Source: AGHT+IEwZ2Oq+pTGZgJFxX26wp+82jD3we8xi3/GH3Welww/bjc1k6gfMisY/v82jM9c/h7V+Z4+SA==
X-Received: by 2002:a05:6000:2489:b0:3a4:d6ed:8df8 with SMTP id ffacd0b85a97d-3b8f41b4ed8mr5599905f8f.39.1754564466804;
        Thu, 07 Aug 2025 04:01:06 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:ad48:3e8a:43af:495d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453aeasm27312698f8f.40.2025.08.07.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 04:01:05 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:01:00 +0200
From: Marco Elver <elver@google.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	Baoquan He <bhe@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 0/8] __vmalloc() and no-block support
Message-ID: <aJSHbFviIiB2oN5G@elver.google.com>
References: <20250807075810.358714-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-1-urezki@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Aug 07, 2025 at 09:58AM +0200, Uladzislau Rezki (Sony) wrote:
> Hello.
> 
> This is a second series of making __vmalloc() to support GFP_ATOMIC and
> GFP_NOWAIT flags. It tends to improve the non-blocking behaviour.
> 
> The first one can be found here:
> 
> https://lore.kernel.org/all/20250704152537.55724-1-urezki@gmail.com/
> 
> that was an RFC. Using this series for testing i have not found more
> places which can trigger: scheduling during atomic. Though there is
> one which requires attention. I will explain in [1].
> 
> Please note, non-blocking gets improved in the __vmalloc() call only,
> i.e. vmalloc_huge() still contains in its paths many cond_resched()
> points and can not be used as non-blocking as of now.
> 
> [1] The vmap_pages_range_noflush() contains the kmsan_vmap_pages_range_noflush()
> external implementation for KCSAN specifically which is hard coded to GFP_KERNEL.
> The kernel should be built with CONFIG_KCSAN option. To me it looks like not
> straight forward to run such kernel on my box, therefore i need more time to
> investigate what is wrong with CONFIG_KCSAN and my env.

KMSAN or KCSAN?

[+Cc KMSAN maintainers]

