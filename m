Return-Path: <linux-kernel+bounces-799279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCCBB42977
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 786217AB7DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7BE2D6E6D;
	Wed,  3 Sep 2025 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvYi0QR6"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B020EB
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756926451; cv=none; b=NcHztKR/Yn4uzozg74X04cHZguxkAxZB96oN6kmKZO/jy+M9GfO9AHReHrf1si3OwzC6JOHpghDcdqb0la7XKq1ska2ecqTJ/0gnjkG/ABj/j0Yfxjx5D85D97XbRmLyO7effFC16wlfm7v+37MIUxW+OcPXjJp1VlMaUzeXoRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756926451; c=relaxed/simple;
	bh=KYVcIFrGl+Vy7SsxxkHTVBAHnAQ0dqNp/XvJJYRxPvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOjkLqus3xnOZgWkrkfCZMJUEtBkUt0jJT6RFw3sE76Qqf1MmtCwooCslgh0yffW3TOX9SonOIdspHhyh9XBeoIWzAYNI6vyNDB5i43G6mQixIWoCcmjLtacbO8wy3otFxpqIrj8m+C8uYHaDAjwfH1HSRzRCRX5IAiH2JUzJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvYi0QR6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso252950b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756926449; x=1757531249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aM0aeiZIkcT3/JK5wnVRf+4pQ6jjEjQhssy7NYZx4b0=;
        b=NvYi0QR6x66IOJhq96dDAHE75z/ld3mYtp1ZHg8GszGAW7i2p7gnoK9xbWWvwHEGIb
         f/cxvnq0myzfsUa0D1fWEseXQ505shWRN3v06e1sYFSp/ZDNdFktwwcEbjcfEx9x4XUu
         vH3gpumaRUVDZ7mE0vlKefmQrJMUZuF2YgbMGK9WNvoaS+8zTu8c6pO23gXGG0/1o4yB
         3hGJ7IkGgmH1gK2FUUEqexFfum0FLJijjgOpCB8VMPAivUpaP+DziwEk2bh7TAmQa99W
         gjijcgRpEYTeM/FqU+pvfAfFilkbzx2w27aezgKYF+EWK1KetlOhu+vj8puffwV1PlBV
         PXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756926449; x=1757531249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aM0aeiZIkcT3/JK5wnVRf+4pQ6jjEjQhssy7NYZx4b0=;
        b=JNLtCJ8uQI7e6t3dZHYoAJEbjYzdAOEMRHT+RNn66sjsBMeyJiTs/YjhaFbq704W7Z
         6DYrIULgx96bF0k8JwVHXqVgNju8cHU7IsngLlipI+m3Z0zVKGRB/nZbOUnq8A3nrdUo
         LuRwcD2laPieRFL3B9Y2JXmgZ+2BeeHNLQZu/sLrkd6UA9rzwZw1WxA5xEw72yKMnTtE
         sPXSS27wBYxbQCaX4HNrL4jdEqJ5jt1fleJSywWTFrDT0+vcn/GpoQ1X8A5JndEbYDSH
         Mz565LN2GpPelHaX9tY2TpxuIF9osKYXofUrBBAO8msvS0RDNoPsFEZY4UEeoLuFB+3r
         Lb/A==
X-Forwarded-Encrypted: i=1; AJvYcCV/B+fgfv8W5cb4Yt98QhHEx6cDXTFQjcwC+x0kkUc1NS/zyorXHlEHvxDCTxl8Wd1dWhngNDLuJzAtxi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QfMh63DW28htHO/vuqNsj4st5e10WxX+Qpla64bV9TxWHF9m
	R1s54m5nlEvlBzYtSszMLmRasrQN42i3KNjaQFbis8IKUQ8kBkZz/6x+qvNPN+L9
X-Gm-Gg: ASbGncu4NTGfYktsxeERVhr0A3gq2HO5PEmFY0MYb5MgqygZWNQNujTcLPrvjf8UJp1
	2tOIEIQlS9emk976ef+9tf1XatBAfeEV8iiNxFK2QkkdmZqho3kQnQUtF/cNV/+FFDSMX/WYLYp
	9AtMHIC5QbYhZG1SR90FjmGWlkMePER71Ehzd2e3MGu2QYnT+dSVDvSEnYQ1ejhCQEjCx8g/vDg
	oEAVjAR5B7wiUDM0bkUtdpUYYWiUFY2qg65rZoO2U0IsfUcTI7Y0RyAOgchWNwPRzcW378eN+qG
	zXpvwE+xdJYr+YmUmbin9utKKSR6+E6E/+dxquZVl879J/My7g/IOI98gPnEmAzqDlnUbqhqLjz
	IUrnz5YTuYKsoJ6WHv5J4EeRTe4Sir0+Otp7a552HGwQIGL0pIOhRtw==
X-Google-Smtp-Source: AGHT+IF3PZcDzJgM+Qa0itDatQhUE2OrKdM2FUfn+GzDqem/KPFoVlGTPH5AcAzb4I9yuLN4w0QvaA==
X-Received: by 2002:a05:6a00:1397:b0:772:63ba:13b with SMTP id d2e1a72fcca58-77263ba0301mr9960703b3a.30.1756926449152;
        Wed, 03 Sep 2025 12:07:29 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a0b3sm17592340b3a.10.2025.09.03.12.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:07:28 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:07:25 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/show_mem: Dump the status of the mem alloc
 profiling  before printing
Message-ID: <aLiR7Rc24sUeun0i@fedora>
References: <cover.1756897825.git.pyyjason@gmail.com>
 <d7998ea0ddc2ea1a78bb6e89adf530526f76679a.1756897825.git.pyyjason@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7998ea0ddc2ea1a78bb6e89adf530526f76679a.1756897825.git.pyyjason@gmail.com>

On Wed, Sep 03, 2025 at 04:16:13AM -0700, Yueyang Pan wrote:
> This patch prints the status of the memory allocation profiling
> before __show_mem actually prints the detailed allocation info.
> This way will let us know the `0B` we saw in allocation info is
> because the profiling is disabled or the allocation is actually
> 0B.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

