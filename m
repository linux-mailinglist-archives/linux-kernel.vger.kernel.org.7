Return-Path: <linux-kernel+bounces-721863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E7DAFCED8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B8562ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11E2E0B6C;
	Tue,  8 Jul 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dzaxUBXU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018B2E11A6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987860; cv=none; b=ah1Y+7FEev33yjad+lK9lNRyzijg7+VMUXUxI+5aKW+mReL46t/5iTQE6Gpiud/IaatIkaEatBOmRDfV6k+h2c/GPwY5F3h0DE/aNDSG1nOlab/zgRqU302aHXlP9bQSlKgOp8nvbRyBqmt2jMFjuHlU2b6h26vNZ6UpPk5NeXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987860; c=relaxed/simple;
	bh=NtLHW0gBwEERzbGky6wsjOcbN20mhtF54b8jLlBbHjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTW5bBInQ390WgB/3vKcmjDalINNQnmZWEP2846ngozQKos3QbfJKOOm4hAMwn9kxHUb3ILsvfG8afTLUfVhY6quctm6LO+P87cYoR4wgKRtO43wSSqF1oa8RivTI1jP0o0SeQHGYlFiWpIuhvjsbzjvcQ06eNWrPDMvIAVJ4fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dzaxUBXU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so51657665e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 08:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751987856; x=1752592656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CU6TeFNrSMiDTvmFFa/i5WXjWCTVyBBXRGYVVCZBhHM=;
        b=dzaxUBXUIYHkP0QRI/kxKIOoqtFThUTAnKn6eclhZkG5PvPH2+ZFF9JNLzF9ivMMF3
         xHrk/9x2HBZCpaAcKFkUkprWLDxoNZ/0BWqQ5YEWBFFvrIlGS30dIpjXS4UFK4ghVWqp
         iV17eEd0aQA7Tv5dBGLfvDKuGqKxWzDm1PzkkF1diVDN32MuHHNDer+VUXZ+2GYoqKQ/
         7u/09DnMsfyvWjLHenBaf+In02uHFv6d44WCv4HntiVINE3Z7ftS6g6Azkbb9X5fprAz
         WcaikW+LGcOS2kcFQyfwKl8Nj5RW9nLCDI4YjeU7ELAsJ2AN0dgJ4lwU0Sb8y4POMeJ0
         NtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987856; x=1752592656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CU6TeFNrSMiDTvmFFa/i5WXjWCTVyBBXRGYVVCZBhHM=;
        b=EPNv0LSltl5q25bPgpIWUN3JNuUCrHUwThNhbY+gU+QlD3HYIZefqURq9TnXbf/GnY
         7Z9vSOB1tr4BAngc4Io3Pp2LmuatUr/G/gcGxnsY1MZXHotHUZatUjXxCNKseGfi3XKi
         TlhqCFDk1RLbBgrktyR4f2CRSr6PY9KRjJbZa7YP3LOfSHPtDVtgKb4VDGPfEcvUF+KS
         Kg5uekF/E+8ZMi48Zd40ueJwarDNrJSFPFrlqWGzVD417h3N46iujF2wxcJmDQp0f+A2
         eXu6GAevuPSSrcDMMZMQFMgB/Q2DCFhJH51myDKmJgM/ZV13/+C5l+jyuXHwxmFAN/xB
         iG9g==
X-Forwarded-Encrypted: i=1; AJvYcCXS5qeVEi+gPJJRr1Twhd+AI4ixduGTmuuYiLCnd0vH6NrUUwzPvjZa/S4/RWVFGJQEz3ac0tN/U/wG/3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldktXT6BY7MZzOTgG0T3HfnyQ179BvVqp0KJHx5868Enw0cEV
	SaZs0T6BHLSRCr+ciMrIX7FV8YFXRfGVV5Op7vnAc0sAopDh2pqV/kya4yyuJ1v4cTuK6vZ6qB0
	3F4P8ikU=
X-Gm-Gg: ASbGnctiJugbfdYWlkmy+mrG53fpNWFBTjMXZPcbyEDX1/4toJ+PeF73P9AeUK/7X5S
	uX5umyoiJmW4dplDIPVL6lxAFYedcgtEaZKS1oXZaCtUOt1BCeFfhn5QtuvfZcce2NYphU6vkXa
	mDt7EnAPVb7KDZrAbvjNPBaL2CrGuLjrn9oBm+U5gOVdQI9zUHHpiOhS6LJnTVT8802a9lZ2REh
	xIDMjVwmuxqeldfGGqKqvMGetH34X6Ou1foWQ/hgmDhYLeED4OukYq8o3heMmakXInUZNvNmCSm
	A9fpj9mS/Mi3Nfh9vIWHkKtHFLpy/t7Q20ESQki58NR0y0294fBZbY3OSKd893C51slf38o3gBo
	=
X-Google-Smtp-Source: AGHT+IFzfxV2rUTYuCgiPSvs0ZawDdkTY/iPGWYSKkuxAJEvzxu4BGSMwoOjKQHIL+QHoZbuT7zUCw==
X-Received: by 2002:a05:600c:45cf:b0:441:d2d8:bd8b with SMTP id 5b1f17b1804b1-454b4e779camr149636425e9.8.1751987856261;
        Tue, 08 Jul 2025 08:17:36 -0700 (PDT)
Received: from localhost (109-81-17-167.rct.o2.cz. [109.81.17.167])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-454cd38eee8sm25294775e9.6.2025.07.08.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:17:35 -0700 (PDT)
Date: Tue, 8 Jul 2025 17:17:33 +0200
From: Michal Hocko <mhocko@suse.com>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>
Subject: Re: [RFC 2/7] mm/vmalloc: Support non-blocking GFP flags in
 alloc_vmap_area()
Message-ID: <aG02jeuCSPUFBx7C@tiehlicka>
References: <20250704152537.55724-1-urezki@gmail.com>
 <20250704152537.55724-3-urezki@gmail.com>
 <aGtzJyYPKA7Hn6kQ@tiehlicka>
 <aG0QVClTHrP0oPLm@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG0QVClTHrP0oPLm@pc636>

On Tue 08-07-25 14:34:28, Uladzislau Rezki wrote:
> On Mon, Jul 07, 2025 at 09:11:35AM +0200, Michal Hocko wrote:
> > On Fri 04-07-25 17:25:32, Uladzislau Rezki wrote:
> > [...]
> > > @@ -2030,7 +2033,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> > >  	 */
> > >  	va = node_alloc(size, align, vstart, vend, &addr, &vn_id);
> > >  	if (!va) {
> > > -		gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> > > +		if (allow_block)
> > > +			gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> > 
> > I don't follow here and is this even correct?
> > 
> Allow nested flags to follow a user request if there is a request
> to not block. For example if we apply GFP_RECLAIM_MASK to GFP_ATOMIC
> GFP_ATOMIC is converted to zero, thus to GFP_NOWAIT.

I still do not follow. The aim of this code is to filter out all
non-reclaim related flags. Why that should work differently for
non-waiting allocations?
Btw. if you had GPP_ATOMIC the resulting mask will be still GFP_ATOMIC
as both __GFP_HIGH|__GFP_KSWAPD_RECLAIM are part of GFP_RECLAIM_MASK.

-- 
Michal Hocko
SUSE Labs

