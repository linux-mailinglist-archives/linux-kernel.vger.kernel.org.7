Return-Path: <linux-kernel+bounces-818677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD532B59503
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85E453A3806
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4CB2D5C92;
	Tue, 16 Sep 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ggSv8Srp"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558D927702D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758021696; cv=none; b=axz5xe/sqLj2UO6bOlyGk7rtbibp58ob4Z4/Kl0lINnvFMN6GEs9NtfQTRj+9Dkdlty90gYRvhBYZti6tK1tCz8tE+ml8z67qdqB99aJ+MoJbBa7WNyXXKG70xsWmL8QSHK/32nUXKZEBXZt/S5pNZwrAMKSVXAaVXgdQ4K2fRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758021696; c=relaxed/simple;
	bh=PT6RSjPR6nsTnNS42majHjNEe7o+uTu6M+72v8l3iSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYKqWE5LhhAD02h8lk48ZGkAJ5BhJi87EAz4z4nJBO9zYpjk4dsAoP1WoZiimhAQPc7L77PCLuP4IUejb5CrGS49+y5WB//0JMr9vh74ghqSd4MDBo7QRN77Zr5tXr5MgTsQav2HRQ9WaDKbODIZFrWFbufwonWdDZS62yOeS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ggSv8Srp; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so9366234a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758021693; x=1758626493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uea5mfPfz6gsP2PTuhVLwd3VedG7XAMEGNBdCWZOsHw=;
        b=ggSv8SrpUu3/G6YUa1wCB3eOnf6vlEV4WeAX8168zTXT1c5RrkysFb61x/IVrZ2ioB
         ksyyTs+pgvPE4v66yYHmsbhT6Sxfdc1/foredqRYf5rN2sLyqg+cjFpSL3lFP5QwrThR
         sH88ZjERmT9cJp+uPskNrTd5fJhxe5ChuHeJBqmGGytfpCfeHYAoBj2z/d5gMcePUxkl
         OYNAxJO+u3Xe+yz4IuafMXvwLdPaT0FB6HMVuHUcmtY5Vy5V5R7bPexqmPPu9Zmaozrd
         DHWcJ+rZfSxQtX8rvX0pPWk/uLtGYPvyuCp5+OGndrFzBgkWiBbkLSNncnh/la0oseLx
         DuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758021693; x=1758626493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uea5mfPfz6gsP2PTuhVLwd3VedG7XAMEGNBdCWZOsHw=;
        b=CdfGQgYVJMpvtQLUXP3k7mmxvSJRM4duzFYbeUZUfJDjnF3j1Ns1HpL/An0SNupH7v
         lP+02d5r4f9BNXxqbx6HusrkkiaAq7vRznjk6+EJ4qtssWmM6Hvx8sL4ldV75TxTUHSb
         oP8y1g6I+BcruOQXEjsQSjjkKKBeze3uuRkVI1Kdj9jWYXaXMbo+25SOlZXA8BITKKqX
         NjxallluYJfKaQHO20Xz0GjBevu1mVy62cvFC/E2PYUwRDocVYxIu/bES0P7qkdc57P2
         Ro5XnSQ/M73A5KqPurRKXh/sjIfPoEYjyNX9f/DTjFejryk/Hg8HAE51wprM2vXNT7IG
         NR9g==
X-Forwarded-Encrypted: i=1; AJvYcCUAkj9U/evkNtXMDp4yltz4O1Azrh39EWAWEl0yjBg5IZdyhuv7LmwDh3eGz5oMD6Y9IPNnYreNK6eYVQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08Dv4Rdtp3K3OwUGycwaV9vwYoWViRf71i6sOyK1+FnYSVkt8
	yyd5aw67uqbiAv4k6HwfLwOn2YaCUl2+GcbyRxupOS313yQ1y1EDoXpsKmJkun4R5aI=
X-Gm-Gg: ASbGncvOYIGOZdvqCOXmAfzzmNnO/YcSAcvKUl/QSDx2yz7Q91wgFqOvEp33TY75NT+
	5SybzaER+e66+6n4KOL4jCWVQPEu2iq0L38rJYmyu1f+TI7gJUsPVrOLGSQTn+tfbmvVxnwU7oY
	fMSjtXRE6DaR1jSIt878TCOnXX07OAmZG6jRLVCYSxKzYRgs1c4BSAn2b8VwCnOG1XFh+twF6iq
	YVEzsotIeX5+ckM4MZLx8M+9Qfj7X8dXOE3MiQZvW8wT1Tg+PDv67K13R9QvnG2X9HMCgFI2XM1
	6SofjnbuFY8aIgrj0G0awsXeXm6VvngO2CdIlJV1SROdTuCj0rgaWrUbH/W7tCeT38niLf/77fd
	oKGICem0ITbMpSemk9eB0jPwZ/T9J8IkqhdpvhHq0
X-Google-Smtp-Source: AGHT+IGdaApH84qgSh4FpIAmIv68lRlYszt1DGU1HPMtQq+Jg7ayFfDUxA0h2cZACJ5agdILmluAcw==
X-Received: by 2002:a17:907:6d22:b0:b0c:5929:4cff with SMTP id a640c23a62f3a-b0c59295025mr1006070266b.26.1758021692577;
        Tue, 16 Sep 2025 04:21:32 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f21a2sm1156991066b.83.2025.09.16.04.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 04:21:32 -0700 (PDT)
Date: Tue, 16 Sep 2025 13:21:30 +0200
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
Subject: Re: [PATCH v2 6/9] printk/nbcon: use panic_on_this_cpu() helper
Message-ID: <aMlIOt52xnLIvOpK@pathway.suse.cz>
References: <20250825022947.1596226-1-wangjinchao600@gmail.com>
 <20250825022947.1596226-7-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825022947.1596226-7-wangjinchao600@gmail.com>

On Mon 2025-08-25 10:29:34, Jinchao Wang wrote:
> nbcon_context_try_acquire() compared panic_cpu directly with
> smp_processor_id().  This open-coded check is now provided by
> panic_on_this_cpu().
> 
> Switch to panic_on_this_cpu() to simplify the code and improve readability.
> 

> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>

It looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

