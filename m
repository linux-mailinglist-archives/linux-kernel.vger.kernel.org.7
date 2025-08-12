Return-Path: <linux-kernel+bounces-765392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12856B231C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7583A457B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348232F90C8;
	Tue, 12 Aug 2025 18:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="nNLh4Lmn"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7362F5487
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021993; cv=none; b=rxfX1Py+goitbZJluhMfIjDJcK3mqsTSTPpOFqs9R18lhcdjvdXjAlJ3V1TS1sYFhzwkfa2gXhTDVQnwdx5WHITeLDjM4ZdJxOT6/5wBX2krSYzZmRMwBQW4UCE1J+TvvwWadzf9HTN9WFRSimVeBk2J8dpfXqoOZTGa2KOB5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021993; c=relaxed/simple;
	bh=cDL75IpEVawW/Zf30zLrgXp4ChzUKPLdjONNxz6UI7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThGPmoeBknxFgMNl/Dr9c26ibiLDwIi8P2wYcYQbi8GOykY6ftCU7HGRiyD3oOVztngPAVjV+Hrdfz3JLIxOQt9wwGEP0ONZoQPS/6r07ljJOv+DZ2IvZ9jQPqmwvICOEJ6rMybjSAdgmVUzOmRNanVGing7WEJqtehE+v5/wsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=nNLh4Lmn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b422863dda0so4087599a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755021991; x=1755626791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+qm0OVUwsPChSiO7EtY0l6gyVmRnTTf6kZu001Qmxk=;
        b=nNLh4LmnVCbhhnOAiEppvjNdhqK9UwwDMtMyu9NJYDDJvvzp7jaITDRGGKeYF4fXKr
         xkX0KuvLEo/XLwYEKWWdcW7atS1RaUj8YDYCYaGgOj7yRjRNyRETWgVlpVxjBnVUsNzb
         qiOQ7A59UGYkGFcbhPnSFVMS+H+4uZOivNdAPsYsXRlhuniq9YWNKpYwDZLkdox1dCGd
         5we7TLdbEWaL3ztoyfuaSffXxIKoMCFlxQdIepRnqrWvFXoc78v1ON89kxVaftDUoWHs
         0vF2Ue2N/Himv3N9G9CXFgVik4kk7gBn7BCfcDi8QZipD8hgPnUepF+RiSF7U8eJXXB7
         olGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021991; x=1755626791;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+qm0OVUwsPChSiO7EtY0l6gyVmRnTTf6kZu001Qmxk=;
        b=tIvSeBp9LyaLJmExC4qWKjFkbPx3Lx03W77XUFfo+EwnVMeRuXEamEIC8FEZXMk6LO
         ic+aDl/prjbt6AqL6FLf/5HGX76Ict6pmH6IiKAFelY4YChIFhTfwK5JzUzmLpoVqsMv
         2RNy+JFpUtSzo06b0MX2aqffYPq/Gb8ZoIZ4jL4iBEUi4I2MrFE3fQeFY6ZiN3IqE8kp
         O1FVXaGS4fm9kA0/n2lqTIr1pyQ6LvPu1yqNZVdhBl+ZU0095XYiAu9ipjvxhA0LpMuo
         8gFlX9vUqB0S3Xp4ORzkoQf7KfSGy24QUIxipzNOkBgxUFh+wpxNftOSb4/RlF44r+Rh
         qWjw==
X-Forwarded-Encrypted: i=1; AJvYcCWowUTRbX7PA6QTnY+zI3LRY2dracWf6GZUcfHFQJBECRAYhXestzIDkL2fFLHo1XvcDE/cx16dCnNRZVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS5YoaaRy7zJBZQTefPqIPd3bxr1xwrbuZrKoyC3weKjxfNUa4
	H/Ifdzuav9saOtHuvj4nXMVgWwRi4pGGwUJJmJieqyUw99wNPzEOjT8sGe546xxY3VA=
X-Gm-Gg: ASbGncv2r1MpNw9emTU7XxUUCPhbLaHNyVxY2GpdHPOcyh6QiLo3gkZNm8Uu3CseqTF
	wMomUq3i5V4eTfoOV5NT+pVh9O6RGt39Hb7ONJEF7Lun6Zu9y20vtl3AgxSNXFzupTrNq5Ikzov
	DcorP0lTpaHmbL1iCHMS8q+MFzsxy+sEi+dEq+BRrtD92D+lcLvRVCamnU6NiQGDpoE687c3mav
	A4l8hdCz4OxaJ44PeMopSt3/XCGSiX2jYjk2fSAqktxhl/dQPvIg/UnCsOi3i8NIPiQNKA4Ay8Z
	PX9ah4Eh9YlQBDhVydboLz0UIq7YHMmWMifvtmB786OuVaKnzCy/l6hsNebAIc784hP+wXGLhs7
	kmx4pvkCfU0PaAiZW/Q70T9rF5VzXy6KIVDHH3upj1dNhZlsxgzTFPgKLBXKPvASjNo09fAW6
X-Google-Smtp-Source: AGHT+IEiZ+6cRgnpz7p2OFbfNkvWieaTaOrL4lJbiLs9XtxBwQXEItOrPqX9mADnKtClseZZXtmNYg==
X-Received: by 2002:a17:90b:3c49:b0:320:fda8:fabe with SMTP id 98e67ed59e1d1-321cf9682a3mr744231a91.22.1755021991451;
        Tue, 12 Aug 2025 11:06:31 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32160ae5eb5sm17892521a91.0.2025.08.12.11.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 11:06:31 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:06:28 -0700
From: Joe Damato <joe@dama.to>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sfc: replace min/max nesting with clamp()
Message-ID: <aJuCpLbCbYJg_MPF@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Xichao Zhao <zhao.xichao@vivo.com>, ecree.xilinx@gmail.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-net-drivers@amd.com, linux-kernel@vger.kernel.org
References: <20250812065026.620115-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812065026.620115-1-zhao.xichao@vivo.com>

On Tue, Aug 12, 2025 at 02:50:26PM +0800, Xichao Zhao wrote:
> The clamp() macro explicitly expresses the intent of constraining
> a value within bounds.Therefore, replacing min(max(a, b), c) with
> clamp(val, lo, hi) can improve code readability.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/net/ethernet/sfc/efx_channels.c       | 4 ++--
>  drivers/net/ethernet/sfc/falcon/efx.c         | 5 ++---
>  drivers/net/ethernet/sfc/siena/efx_channels.c | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>

