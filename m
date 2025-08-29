Return-Path: <linux-kernel+bounces-792550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576FFB3C576
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 01:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E317B3A2D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 23:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AE335AAA7;
	Fri, 29 Aug 2025 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xg5Xmb1s"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5676F25EFBC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756508600; cv=none; b=KTW2DFBH+1erk8qYUivjY+69vw8+7g6D0IGgW3D/7RTJzFSgwK0VKXv5NIXyu1XwyDnkPcZnjneDV5zcscAEhn4qkyigMqSKA4MUhFuj07vP3MKDRBYCC5tV6Zv4tJSquR+eZ0JjBbO3IkyvwYPjgRIjI2pfo0Hw0EgfGJA1RVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756508600; c=relaxed/simple;
	bh=vkeehhEt10hArZe8IJ4uwMJXl7x+nL9UOqhxnBnDU8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgtPe0KXuN64Xy8Gh6pIHTfiHwSVt/vVCcCnIgnKDAvYdUpqxjqEBVJ5waURgDyTPL4YcyxXu15I2oY4Ykjq1Wc2s+RTAL33RIxKI3nThawqlCULIu5yFU9E9aEMreiPS37mYPhh5X8byCqyyUjUIzeiD0xXsJX54FGJpTOOqZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xg5Xmb1s; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248c676a2eeso18316815ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756508599; x=1757113399; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0oj4QW0mRB1TfcC0bp9PnIUqJfZzQDzEwkawvrwwWBg=;
        b=Xg5Xmb1sPheJxB30ZBNHadI7cRsPQGuJp4f9E4mQOPPv96AWXEUG2JRM5I2xmEJYUi
         OKLdYZOSSXXZGFBjN+IOJPqv+g10Uo709nRsXCXy68aWmHCbKkzdi6eadSUC/IZd7VCf
         ecETl5Syol+HXD8cQNn4OfX1u8o14oIS0RO6l44Z2HcE+snHQaSpr+glJxsMBaethP7o
         d1E/hRE+wEtVFsxLymw0LYCXdqqn2AXU89cfh5fdMHostejjipfKWSjR5r04PIl5O75h
         84slWWJqzhdAq4hFw8Y04Eggm/K7nZ+XDta9rTFZXeVenW4B+Eslmd9QWwVLxeRj8ifq
         kPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756508599; x=1757113399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oj4QW0mRB1TfcC0bp9PnIUqJfZzQDzEwkawvrwwWBg=;
        b=hQJTRQslBc8O5pZvx/iTJrpTwzIi3+R+BE7KR6TKh+a5qrEh2fsIBMwQ5s9MxQ9gQY
         4MCBFfUH4PSMqDXHjJw9OgAIC4i9WR+uAXNc8uur+yOd8seEtQ7nQ9X3npXCmiiv2S/l
         xD5wcq3y+eZppPZhYrM8i6j1P1QmOV9Pe1Md27pV/BDkZkHh2+epamD3POSBK97srZsp
         O1xq8T3Z1CcGHo5WHaQF+x/UELlZJzxnVa6mu5g2EqbwujaMBUwJ2+KFMcjyLFDBtDV+
         I/opx0rBk2FKuCtBWOxolNYTSJ5Be5+I5wc5PMB+PTNcqTDqUkcBrMc/5QWbrzCcghk0
         vH0w==
X-Forwarded-Encrypted: i=1; AJvYcCVxEYtayhwtVSENsBt6rN5hk3NN8zNb+r/GsH+6AeQP8ORoR9GKAJkMofX3pwvu03K8CMmZ0Adbha7SLAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yTDj/wpbF0KLT6Nu9ZriHtTTAZvDzRCw+STn91o2SrtyHQwm
	T9dMmJkj7UwOBgI/IjzGnHGHQPnofTVXYyL9T13+gaBChwgtL+4O4Pkr
X-Gm-Gg: ASbGncsHiFkvw2MdshQygL1fFrrFjXAY8iIHPq+JEFjifiI27WPaGg/H5hZBBDVuLWy
	cVxzT2Dvvb42bKHYMc8wWiYndv3KgZrI6HZty1Iz2ClWkC/CvJFM6d/XIUyWaS+gzSS4h1ESY7S
	RLuklpBa6fZgKkweLbW5qO4Dc5Q0erA2tkeKmF1M4j+2N/9odfCx8aXgQlalFojJAYS/F4jtd9e
	B3LV1cUUScGwZuJCJIs7gv2tKNSSHxgk1XlV/78g5c3PWaln4GyxPEhy4oDzmOkTlz50DNITZkX
	WyDL37AuWhe0izBdSxejFSPN9l+DGvOrGxXRbBNwnlxKSXwQLV42BELYWkstzROQ/AqDXldkHAW
	91PlOyC+Ld2M0t05Eo5Fv3qBWKIOWaCC5YfkY70CKCzM8jHsUfPmBDg==
X-Google-Smtp-Source: AGHT+IFs2LIpMANw8QwM+tdtUSR872Tm5FcSSZAgM+am1WMsvCTQZpL9VlI80fpyk9T7Zoxr4m7TPQ==
X-Received: by 2002:a17:902:e751:b0:246:b467:eea9 with SMTP id d9443c01a7336-249448f7469mr4169525ad.21.1756508598596;
        Fri, 29 Aug 2025 16:03:18 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906589986sm34697255ad.111.2025.08.29.16.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:03:18 -0700 (PDT)
Date: Fri, 29 Aug 2025 16:03:15 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
	yuanchu@google.com, willy@infradead.org, hughd@google.com,
	mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com
Subject: Re: [PATCH 05/12] mm/oom_kill: add `const` to pointer parameter
Message-ID: <aLIxs1cFhneGU5D9@fedora>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
 <20250829183159.2223948-6-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829183159.2223948-6-max.kellermann@ionos.com>

On Fri, Aug 29, 2025 at 08:31:52PM +0200, Max Kellermann wrote:
> For improved const-correctness.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  include/linux/mm.h | 2 +-
>  mm/oom_kill.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a40a3c42c904..a795deef93eb 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3840,7 +3840,7 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
>  }
>  #endif	/* __HAVE_ARCH_GATE_AREA */
>  
> -extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
> +extern bool process_shares_mm(struct task_struct *p, const struct mm_struct *mm);

Nowadays we're dropping the extern keyword.

Also, Is there any reason you didn't also make the task_struct pointer const?

