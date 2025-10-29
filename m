Return-Path: <linux-kernel+bounces-876143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C395C1AC62
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15151587E99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9643358B0;
	Wed, 29 Oct 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YOgXQA/H"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B99335084
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743737; cv=none; b=Z9GGoMpeGC/bbQxU9+bpjmRBmzwocemcdht/Ch527bM/2sjEZZtWCr8pNy5n7aS/2cMxe7UVz06+OhpBP5QMIlXgnfsfXA/oOw8TsSqCG6iJnk2XDbtiqikKtNvabh5AQnB+BrV4p7XiLgulYeKewHegTWvB+Yka9n+fIl74en8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743737; c=relaxed/simple;
	bh=QSkYrsKGtfQWVlvr23O4MmAbfJgkBiIAbT7qzxIWS5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VsduHRxksy+cGJQtqH54AwoDuMuJ8h2ylLiWaFiwjEpoDgIl3t267gAni//36dM/BmLc0qhrvSP1WqBhTCa+O5GMdM81Q9lkzsOBADP2rZz6V7cT9jSp9K55LDG3Tb0keqy181EB+5T81k6O3XycaLUTuWFiCvGjrGeuQvCi+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YOgXQA/H; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-427091cd4fdso4208369f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761743733; x=1762348533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tFbTde2fDHNouWfBvSlhZDqarLKcRx/QalhPQzPz0lg=;
        b=YOgXQA/H7NiNjvBZ7XWhaFUdfNGBBNBtHg7MhsjMUpgBP5i1b71EDE9UcYONCzoUPx
         VoArM6/HW/C6CDdXN8ZR6L/Q2rYVXMru8n1KVGJ4TOdAcp+Q3NkcO6SP6hmVW1QLG+EX
         J7hWtp3hGAznYCh6zqcBffn66F/gGFk9ZKUI7TbTQNsj+cGpvUE8tmZj48mmdA/x7SaD
         +xTO1oohsSzZ5r16QUIt0fOcumLk808Pvk2kq/zl2ZOjZ1QRgXDKYaaMStZNKp1qGAsd
         Qgo4g2rGctotCuaTX+jvYGkO/95xZUddsbU7TTXdJ0492T7E9BpfGDJjLIkeABTW479D
         b8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761743733; x=1762348533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFbTde2fDHNouWfBvSlhZDqarLKcRx/QalhPQzPz0lg=;
        b=hnf3P6hB+pgL26bDVNIjHGk9qOoqgqoYzHM0DsiQ6sud3HlbUeo5gKEfokkY3hpe64
         +hH7diIaUv+eGkaTGtKzDptsKf6mtLsw0t9/UBnI64jKIeuZe1/AMjWBgAYjs+T89wp9
         xo0MQWTFgVz9sPU2iAkTgid7IQkovyPauO8vY68eaYHq3hcbPs/Nmn3532H9FJAbwnRx
         gwOOIK8vO1OYlow9qHYFArwZCJYTmEl7sCv4zL3gRI0DcPGujquq4glgpuZi+nbfW8MS
         gcrugQvGjAm7h3dj214bIdLlaSI0sye+C7P2oK8oiXButbzWm6HOYr+DWchBZqSYoZNN
         EwJw==
X-Forwarded-Encrypted: i=1; AJvYcCXiWgUUYzSPEruhhwAFTsdkgDOdPfppeF+mUcVecEWRFUNW7kQgGd/jY1wjAmz4zYjo9DrUco082y4sUDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hh6P/FELYyFp0nyGE8aD4Zv+TLGqaoqMktwaSbI+FAAFkCzc
	uRGg55gHhc8/6lfSxcCUVrta6AK6eXUFVmYbdLz2gUWwsl+V4p+6qvwnvESCavjPbpNDesa6RIA
	dFFOx
X-Gm-Gg: ASbGncvBQhs1s1ZoruTskgtl2WACMtFBVxDqFAbG1oPItn+GNLD0wR4lr8QRYTYKJJa
	6i7+klHsv/A9bC3qNHeEqbIlFdvohTIvDnATl6chXlvix90VTRbDDzNHepXM2mLsvlCE8B3EZlG
	LI8D+Pu4RTfas4SpXkd/nm5K0vbFmDWAGFCPXh4xAWYpB+K71nx2N9znK0m/PHO1bMeKEo++IC3
	I47mnLIrMaB0GcATCbmBR4zZ/FZfgVArbAkbB3FSaH3c9U6zaNFKTvUKw3ID2TG38pF2SdmTS5R
	J2jT94/F1z1spHgZuZDCCeJRsiaFp42DiC1qgQz/FKze63mcbFf2vo49wvrWw1xt/CD7bc88UbX
	hjLv+2omR17dOfw8Bvb/ab2EFQClaHe2xL/LW/Hjc+E5NTz0qx4weOh6lNu/tZYRrO0ta5lteds
	dkv0lBxFE+ZPri1Q==
X-Google-Smtp-Source: AGHT+IEtv+shD5qN468+pGeDHwlQ+N3lOPs5PRYdn5kzJfcSYnjwq5e1uphyPzA+uI9UtUPIQ4ilMw==
X-Received: by 2002:a05:6000:4007:b0:427:854:773 with SMTP id ffacd0b85a97d-429aefba9a1mr2219240f8f.37.1761743732725;
        Wed, 29 Oct 2025 06:15:32 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de4a1sm26863611f8f.37.2025.10.29.06.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:15:32 -0700 (PDT)
Date: Wed, 29 Oct 2025 14:15:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
Message-ID: <aQITctViD_iSi6R4@pathway.suse.cz>
References: <20251022154115.GA22400@redhat.com>
 <20251026150726.GA23223@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026150726.GA23223@redhat.com>

On Sun 2025-10-26 16:07:26, Oleg Nesterov wrote:
> printk_legacy_map is used to hide lock nesting violations caused by
> legacy drivers and is using the wrong override type. LD_WAIT_SLEEP is
> for always sleeping lock types such as mutex_t. LD_WAIT_CONFIG is for
> lock type which are sleeping while spinning on PREEMPT_RT such as
> spinlock_t.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

