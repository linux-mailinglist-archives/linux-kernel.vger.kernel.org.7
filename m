Return-Path: <linux-kernel+bounces-614922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D223A973E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 19:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903B716DB94
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 17:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D922135BB;
	Tue, 22 Apr 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="a+DbMgbC"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6A293B67
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745344022; cv=none; b=PuYVXtMDzq6N7PEY/sM/azg4c1bvs3DAvO1gUOkS6tvEoAQz982mVjTdteh0bwCgzv8145ZdUydjNlhnlkyzHIoz8LGTWfZCHP5PNdEArRqUwNRuIUKqs1URj0zBLi+eXKBEQqBWv1r2iiVRZa6NzIBUoapRZfNA/4TM1xSywsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745344022; c=relaxed/simple;
	bh=wbD5RZ5SZDo3XaLXUPNWQ8D+urq+eTsm3HGrZa3mm8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDBFTBf+jWMMeMA4x2mj+nKutGlgEcOdlsJMu4eyH3sY2QhvZTPCyPVLxSebhUf9LNO58CzzClXYhPzRN4CUncg2Iu2Q/VvITqvhgbSVU8cHVKiqH0B7K3djwgs6ESeSliVcRQXUnhnbyZQlHY2/L9LRTu8qZgyABmdbEWMPmvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=a+DbMgbC; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-476ae781d21so57694001cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 10:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745344019; x=1745948819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpSUt/W7rzxG5ba1nOA8p416bP5hsdNLtoV24xeN0Vc=;
        b=a+DbMgbCdjAASwE8rxE5jgtXkxTOXHutxrUP9+AoZPTxFS0ZzN48U13TDLHNeJEQ0A
         FtY6JsQoeLK1WaMxE94VxrtSWUNhxXMcao6s4tP+hmbG+JqB2/XaORMl5PeCBIj/2TSW
         i2rPKBcmOGCreIR3ZTtuDLaHuqXjS2IublcjzcxmenMLjUZuJIKdeYWNPKNWUNWgSE6y
         cfEInbAhsA1Vg43MVWpWnCECRNxMdqb11zHCVqtcQlklMoOrUhfmEWzrRsIDvg9WtSiJ
         Vm+LS6rByMYb8sVHLm1V36VZQX4CjVrKdsKmvZaQtggc7bhlwrQnSn3iGum4htEQvF4r
         sUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745344019; x=1745948819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpSUt/W7rzxG5ba1nOA8p416bP5hsdNLtoV24xeN0Vc=;
        b=rObC+sl8s6TdcLoxzUp/vBYRriLgr7FfkbpVneNy9VmnSSaQfX66ViCrmGkw32lHL3
         VDR0a0kXL1BlBYSLwCVPMJqEiPSg7UcD0XXYscjCfD3NrLigf30Acuc9CzJjE0tQzKBw
         XOVR5NVJ62BbetB0ulQpHj2OezH6f0zXf6Jt5Vj+YlBmew1IrFciRRgLSsTzeD8Rq2EC
         Hh0ZCeWNHjNi5MLDQiKe1gOTgVaY1CGbLF2w725Mh8vEay3I+EyoT7dpqkk/gEyYVW30
         SKuHgylQJZA7sMDDTSHW6VfsolPqoqd6BLZRaGPaOwDkh45FXeqqGPxEJ6tFPLXlwYbN
         MwRg==
X-Forwarded-Encrypted: i=1; AJvYcCVdIn0/cBNjzES7yRaRdYjxB+LhQiCv64ttHFAV+Lz463Wg9eG9GgfmXqKW0fn045V+z+dYVIlybdrZKw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3Qe8LBPaOAymlvthKzIex58SoJAat/V5c7/LmwoCQqyBcUe5
	OmmmrE5YhL4fncSY6iapGVnQmFtkUr/60lufnTLoPhRJWX6c87flAmRLWoCQbU3wCbxKI682AE/
	h7tc=
X-Gm-Gg: ASbGncsIt2LEkz8cBVeHg2eSWo7cysWv9sb6+lplzo/TXm+V8BGkvSa1WCoBV0vZWxh
	wOdpoRxyHhy3rzbATxyjclTPOYlcrgf0rjQx1xzZQ3DY5WMS02uVwXd3Bc/orSefqV4Sn18KR2E
	fEZr/1IaiPakpvVAahrpynSWpTMIZVBA0bG8CDWf3hBejAYJ/H7PECNZSJlkITZe40FeB1/R5Eo
	5lN0YgnxXFhZ9etsre3n+fmeFfxIbdYeqx0O2QPCvQxTJkPe0hwiKAkezHRTFA1JsvWUxGbcgYx
	R0uS05JhTOdq38Kr/TRcp63mYZJiVuy8KuPZa5MkKwpOy26v5Q==
X-Google-Smtp-Source: AGHT+IFDMianZxQRcH0bw5Lmh7bTgr34wYKo3F4wCNpAKa7ksVo4bSSqVBtt2MR3jcNS2ouH63sd8g==
X-Received: by 2002:ac8:57ce:0:b0:476:6625:eed4 with SMTP id d75a77b69052e-47aec4c5881mr295092471cf.38.1745344019069;
        Tue, 22 Apr 2025 10:46:59 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9c16ba0sm57824681cf.4.2025.04.22.10.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 10:46:58 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:46:57 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
	mkoutny@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH] cpuset: relax locking on cpuset_node_allowed
Message-ID: <20250422174657.GD1853@cmpxchg.org>
References: <20250422012616.1883287-3-gourry@gourry.net>
 <20250422043055.1932434-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422043055.1932434-1-gourry@gourry.net>

On Tue, Apr 22, 2025 at 12:30:55AM -0400, Gregory Price wrote:
> The cgroup_get_e_css reference protects the css->effective_mems, and
> calls of this interface would be subject to the same race conditions
> associated with a non-atomic access to cs->effective_mems.
> 
> So while this interface cannot make strong guarantees of correctness,
> it can therefore avoid taking a global or rcu_read_lock for performance.
> 
> Drop the rcu_read_lock from cpuset_node_allowed.
> 
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  kernel/cgroup/cpuset.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c52348bfd5db..1dc41758c62c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4181,10 +4181,20 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>  	if (!css)
>  		return true;
>  
> +	/*
> +	 * Normally, accessing effective_mems would require the cpuset_mutex
> +	 * or RCU read lock - but node_isset is atomic and the reference

              ^^^^^^^^^^^^^

This should be callback_lock. rcu_read_lock() was intended for css
lifetime - which is ensured by css_get_e_css() - not a stable mask.

Otherwise looks good, makes sense to lampshade the lockless access.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

