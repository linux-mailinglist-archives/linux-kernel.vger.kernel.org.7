Return-Path: <linux-kernel+bounces-765374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DD2B23017
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544E51AA12C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C4A2FE57E;
	Tue, 12 Aug 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="vURs3HD2"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B9221FAC
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020762; cv=none; b=YbH4+i6EQ6nf45oWU9Et8her9ztYZCUj7P+q8BzVBzP0YVqp2IsDSKib4vALqQy6U3G6cWERiwgAHt41s4OYG9Q3zAAhlxGlFds9bgn7EMgr1SD9kAWaIP0ddt68yFwHpR0+H9GPL+U3HWpjLIAzWKFLzuFplLhTd51K8fmdSNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020762; c=relaxed/simple;
	bh=sLBrvqqsZtV1FCVTCMrMgsMw93cY6+eaaOKrjSt2vBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBuSu72nrCZSwBgMFWRvCENF2vYEprYG9kO6kbBSDDmr91Mv57lIzlMTjk0vKcs34bzMc0oMVtX9x3LfTR7lmXI7unEjHTOGOnrZE3yrR1YioUNsAasZvbMZNFHI4j0QVWChNJY7m/2PrQzFwUW28JFixWfL1SF9j7gxseqF1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=vURs3HD2; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so7248258b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 10:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755020759; x=1755625559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+evhD+loaePWkAdN54jiK6XfwBYZ051YhjuuP6S/D8=;
        b=vURs3HD2b/w3D5YTLmIJm33a9nM+AfVR3qJA1SBZM1Os4tmxY7mXTgVImWKAIvkEpd
         /3iIRwTnpG16K1lvibI20YJA1bVFOGsCUuTTkBUVE6SQwj8VO3tG2FBtvlr9Az2ufb23
         VmHIDTeJKfy+q2zhD4oc3tF9+AzfKJAYKd7Bkt7Ocf+TEEtl/UKWUCQemzdpWIjbXbHd
         2lqYxJ0zd0UWekzeUcPzjJVPjGaCUCSKzndBHyDjeSGYR9CHkrnCjPc4kuSCBoQgHMiF
         GKcXNxMqYATdAcrWmy23Hj/qFrp+bcd/sld5+WrRtkvbZHN7Ore/LtYsKcqAaFOS8e1m
         AtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755020759; x=1755625559;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+evhD+loaePWkAdN54jiK6XfwBYZ051YhjuuP6S/D8=;
        b=SVKEbIX+DWbefuBEzPL64P2gEynepS1NcaumdlKlCucIcTELfQjkgNP1EkNC2Jq4oP
         WKz0T9NkYnnFDh8Eulpt16XlprlNM4dZJ22gg8Qx5bTaeNcqo2i9OPkXrL2aczTr4Fax
         sCuP0duHko9EbCz/IMGj1iT8IY2cHyQ3UIiTqpzhllCGlj6nLXf7oj+lqNjbM/EiefQt
         a1yfr02lMkjTEJTZzp7u7GXGXMyTJeDXd2ionQI4nYizKFK0Dq7U/B6OHuKH5v03zYgG
         T/U9jCdf+f4ti9y1Bq1bvtDqScwNeu9+Bhitfe+uxxRqHCtMhYvqAfKFbIQz0/6tVm7X
         YZJg==
X-Forwarded-Encrypted: i=1; AJvYcCXlV8+/LKTB3Ul5Xj80905VH9I/iX0LyD9Vun0ivYg+FuCxO0MCCV66cpg15HblLsMTW1iScLwC082HkpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlswxumRA0zxF2wRSFyQJl4NncCK3achqboy4D5hVO4wl7WQQ
	UlgcsJP9NHXDmibQ32sIYh80gDabcyIXeNxfcwtf3aDO8D0yZkbMJcpjjWh6Om/ptHHRD5HaHmC
	NIcFhV6c=
X-Gm-Gg: ASbGncsMsRFTLjArPnI9s2WoWwWtNat9K7IC2NGoKLbw/sK4DE2JWnDXvTVBik+8lCW
	Hu2OcK29z3QmElpxK+Ro88h9nPSw5M0HXCDqQg1VXFRN8V1CS//mNMwNqVD1oh37zV169hRkYFM
	v83y1Q3mLNAxIHntln3qdRpkFqCIMoJ7f0gpPZSvYcPitxiBg9E5mFYZk36AxX8Krf4Mu6hM3Su
	Pska2/swR+ehQWw9gGXMmPFlLx6Jsrul3VvHJqA0TgmchAy1bpGGUg0+jWNj344RNr8gsFd1b8A
	x7b7rWqupqjWd5tFevFtKPF4ue6inTEktdirf+mgLeUJSU5l/WQhQd5GskJ7Y6W2Vv3yK1hoqbC
	N0SRNIOF97jeAxoFfa0uXwRUP1WXrTFI407dvdYCmDOWnIgF/SV3ey7tZ4MpeidZCaWzs7HaA
X-Google-Smtp-Source: AGHT+IHgeepKUmWcRSt+K6fwtVExxF9zuRBGrYePdQX+VK6gDgBfVe8guzcU2VXIutR11ypHY64Xyg==
X-Received: by 2002:a05:6a00:8d4:b0:76b:ffd1:7737 with SMTP id d2e1a72fcca58-76e20fb980dmr68959b3a.22.1755020759568;
        Tue, 12 Aug 2025 10:45:59 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c61dd2ce7sm8965276b3a.41.2025.08.12.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:45:59 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:45:57 -0700
From: Joe Damato <joe@dama.to>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>,
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vsock/test: Remove redundant semicolons
Message-ID: <aJt91SSkBO486bg5@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Liao Yuanhong <liaoyuanhong@vivo.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Shkolnyy <kshk@linux.ibm.com>,
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>,
	"open list:VM SOCKETS (AF_VSOCK)" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250812040115.502956-1-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812040115.502956-1-liaoyuanhong@vivo.com>

On Tue, Aug 12, 2025 at 12:01:15PM +0800, Liao Yuanhong wrote:
> Remove unnecessary semicolons.
> 
> Fixes: 86814d8ffd55f ("vsock/test: verify socket options after setting them")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  tools/testing/vsock/util.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
> index 7b861a8e997a..d843643ced6b 100644
> --- a/tools/testing/vsock/util.c
> +++ b/tools/testing/vsock/util.c
> @@ -756,7 +756,6 @@ void setsockopt_ull_check(int fd, int level, int optname,
>  fail:
>  	fprintf(stderr, "%s  val %llu\n", errmsg, val);
>  	exit(EXIT_FAILURE);
> -;
>  }

This isn't a fixes since it doesn't fix a bug; it's cleanup so I'd probably
target net-next and drop the fixes tag.

