Return-Path: <linux-kernel+bounces-818675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87D4B594FB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6923A4682
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF42D5C7A;
	Tue, 16 Sep 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dyx8krGl"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4612C158F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021606; cv=none; b=T0BhOOYxFxE0IFGPu6LRJUccQua/o1eaCtkr9XJ/h1Q2BYGiuAml0ShRlyItxQIQGtsLj0xYF/VgwkuthPnoZlDAnu5CDvVV6Gi9CAUWz+zmdHhsHaL5In4Az+O8ORrLbt5OqjAKR+2e/a4/uYe3JY1zO+ymR6NmG5cPkLUJ8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021606; c=relaxed/simple;
	bh=6Z9HRjTpL6Nieh/l8DUnXky6k1yn+f7s/1vHrl9qB4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXCki5DkJ5oQnysM392gVoia0gDW1AtJYFftcIfcYjY7JNP4a8BBbU8w/chtUODu3EFSm7f7Pk580PO2KoPVutP8fO1p45d52nSZC0ARCmnTxOgR9NVr5DJoRreu6t5xYfoPQfPuSMDjgMieWEATX72luULVFlL6yTyB0t+EFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dyx8krGl; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b04ba3de760so672946466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021603; x=1758626403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZkAhMwtG05Nwx51W4BF/MbpYhaSp+19IYTVLsAUUIs=;
        b=dyx8krGlkJ+bN6N/1EC2gdPehKi6Wv+V9WBXYWTQeGMozo1NA0WsqPDwfRESHZlwCL
         BYph7tYGEJXF8GCj0gchAlOxgbzjOWlzKg5p2klpZ0mugRQKMlzmHWmfXQpqaJxJ0Cm7
         9gNR9ljMCcj+OXFiMxiE7C0aRrZCHZTjTDFWY9DPN6BNlBp9k982I3GE8/L4YVUu1sl2
         1O89EwJe92An9EsGkORsSeJ+nod7KKY8cA/mW0BThidUzldTpRZsMZw1RP4nDXli+MeJ
         ens76EITeYSKVmqb8rXvjDjD+fZqdIh0m8lJPgKFjE+5G93TApLLNH4tVOp/8H4ui3ea
         t54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021603; x=1758626403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZkAhMwtG05Nwx51W4BF/MbpYhaSp+19IYTVLsAUUIs=;
        b=O6okMGPjISFx42LSGVfCKi0Pmx4dSpF2TkVoEbJdbrXgvI+bB8fwvrbDZR2LX9+SaI
         b5EUmw2axxtM947timcbt5qAxT+U5FLjdlRpg5X9Cr8i3EpyGsSctSidIaKM9g2l6Vj0
         WIEcbkY6SY5946yBNV//2dNO2P31KXRdXsRQ/u5PDhRr3Qlz4Di44brj7oPVTWKjgIm4
         bKgfKWvbBDiFqa+ljv+uIqqDxnnX4xM4B3+9IyIwHWy+fwzyJNy1w9xO0oyvQuTnrrxW
         v95OI8p8zQ6SfxaFMK1aUofbZeH7+XGJSd1Nn+3gxFk28it5mvG3fhNSSo8PaU2FmyUp
         rdTg==
X-Forwarded-Encrypted: i=1; AJvYcCWbu27Pt7aYsb52KLRIEy0a0v2CDuKtG6hrKGDKd6EPoVSdbBdKE7WtoRAQvIC5WGATnAolpvZdvS7ZIls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGX3lnBUnfFKspU9NdoI565Ek7Zj8z4RB9eQEIq3ZDURel7R5m
	ppA+knnNrZeDmKh+fim7deoYNmsHzlXhGeDD38TcK9DRDMYxjBszDPBvNhjLVQNg9ig=
X-Gm-Gg: ASbGnctys7Zwtyq15sFyexSNNiZ2OykA+3Kjfu2xNXV0ki3c6Cltn7R4Yy2hM9kgyy6
	fK2LWlTeeDMxusXgUxlfYsbYADJNTdsE/kuPPxHDoixYmGaI31ZcHuS4ye4db5Sbo+g5XXm1hbD
	2J6KDVsDU2YhV14V78zPu4+w3iMNnG0E6g+LKJ4yp+3ozdrQOTjigqOpmLL+lhwrQTwqdBruF8n
	Tq8LS1FU+yk49sqRkOuxqdpqTDquaSpzF+0HaMdNSslH1qBYRAXc2CAtGNzfCKN6hyRYT3gwvqZ
	gpIBtIsrnfW8+XI3CGhrpPByaNqdwUSx+9kTNGu0FKpZnx6934ZY+3CMnFWzjknwoJ2JLcxvRHx
	DBnNCXYPUq+82sLfK5kDxqySBMWh6psObgVFTkwDU
X-Google-Smtp-Source: AGHT+IGYOku1dWOd7XgyZFqiTBP3WC2b/azuNq9E2ePki1CNpOxLiy1c6JRukGNdqA80ZoAb+KYahA==
X-Received: by 2002:a17:906:c153:b0:b04:8c45:4bdb with SMTP id a640c23a62f3a-b07c37fb543mr1468835066b.34.1758021602813;
        Tue, 16 Sep 2025 04:20:02 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62f3919e168sm4212344a12.34.2025.09.16.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:20:02 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:20:00 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Qianqiang Liu <qianqiang.liu@163.com>,
	Simona Vetter <simona@ffwll.ch>, Helge Deller <deller@gmx.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Shixiong Ou <oushixiong@kylinos.cn>,
	Zsolt Kajtar <soci@c64.rulez.org>, Ingo Molnar <mingo@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Sohil Mehta <sohil.mehta@intel.com>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, Tejun Heo <tj@kernel.org>,
	Luo Gengkun <luogengkun@huaweicloud.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, kexec@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] panic: use panic_try_start() in vpanic()
Message-ID: <aMlH4CcK_n1I1gY2@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-6-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-6-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:33, Jinchao Wang wrote:
> vpanic() had open-coded logic to claim panic_cpu with atomic_try_cmpxchg.
> This is already handled by panic_try_start().
> 
> Switch to panic_try_start() and use panic_on_other_cpu() for the fallback
> path.
> 
> This removes duplicate code and makes panic handling consistent across
> functions.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -415,7 +415,6 @@ void vpanic(const char *fmt, va_list args)
>  	static char buf[1024];
>  	long i, i_next = 0, len;
>  	int state = 0;
> -	int old_cpu, this_cpu;
>  	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
>  
>  	if (panic_on_warn) {
> @@ -452,13 +451,10 @@ void vpanic(const char *fmt, va_list args)
>  	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
>  	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
>  	 */

The above comment does not fit any longer. I think that it can
be removed, maybe except for the 1st paragraph.

> -	old_cpu = PANIC_CPU_INVALID;
> -	this_cpu = raw_smp_processor_id();
> -
>  	/* atomic_try_cmpxchg updates old_cpu on failure */

Also this comment should be removed.

> -	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
> +	if (panic_try_start()) {
>  		/* go ahead */
> -	} else if (old_cpu != this_cpu)
> +	} else if (panic_on_other_cpu())
>  		panic_smp_self_stop();
>  
>  	console_verbose();

Otherwise, it looks good. And the comments might be removed
by a followup patch.

Best Regards,
Petr

