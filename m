Return-Path: <linux-kernel+bounces-811220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEACB5261E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92D343A87A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 01:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BD5214813;
	Thu, 11 Sep 2025 01:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePEQ+fjt"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7782419DF5F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555588; cv=none; b=jWPD+OXY6Tz1ClHWbl2dk6+gYyql197wBmiaEnEhJDkIwpWQyHN+nC+UBF2SZTgIdChlNJur4N3y8L34SvUGGYGbgrrnROzzn/jSMo2VML/8ZPJv0oKsfUUZgzZewsAdPnpjI0exAah96nnfUiQ9SGwqhtcmZ5uhkvGSArg9KBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555588; c=relaxed/simple;
	bh=mzNusopv/iTpwfsluNGawNqK9ag2xhR9ZZqVU4s6Phw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhhIZeJP5T6ucVzgJ1hXQa0YEavTWKIFLNJHhe8pbjqtVQ9SF1X73a/Octkmb5fXIfJLU5vgB4nFx5enogp+Q/4SoNNkHnXq1BvAWjz89TatFrA44YoxQ5F9d+l0+palkHsBvEg9Kn3qFsuNeDSe74EZuVgpnPUpN2vPpWOdWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePEQ+fjt; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77459bc5d18so156588b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 18:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555587; x=1758160387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ftEC8QkQSW9Yu26ixMKaFncSw8YIxtS0maQQ86n+mo=;
        b=ePEQ+fjtVVeRenTz0HZcxpq1GhwhemIMQPyVtnviC7n3fGtg7tZ9ZM2DbRXkAsWGnw
         UK5diq1CWzh6mmILdTR45FwcuQ3HOmQimgOff3PgJ0nbssKiSX7mAeJ8+S3vn54yMfNU
         E/sYy1x3hWngNtOyBn+F8do9lpPckfqBot7CKmDIzkeq5zo0KkBXn5RNkPB1aaXstGbq
         v1W0MWL2Nk61zzXuhiBfhmbrUEk9PpCE86XJRyeffIWBlLPno9Bcoz3XUK0Jaou7+F40
         ouD2FrmcjN25eqS9Row8m68lBc8UBb1CuwY4th60k8pdFXrQH+SsAJPA592jCzN0O7TO
         BOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555587; x=1758160387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ftEC8QkQSW9Yu26ixMKaFncSw8YIxtS0maQQ86n+mo=;
        b=G7yJ+rJR1YGbEdGurByl155RosqUMCta6H9o4XwlzZShGnwzsZQY9gDTR65ptx431B
         rkLXds5Oazb95sEux2XdDysCtCKaczBQgahF50kxrK87ZU0D52lLuajbl3SHa83oT7l6
         2pwFP2T0eU7o3cwWnX028iozNk4KRkxTIai2Dlju/pyq083X08riPcsBWn3PPYHBy2OH
         3S4Wm/wLtP3wV4L9K15LElm9qlR0FFByrjCFlBIRCjuUSZrYZ+FcnSvj10IsLRdO0R/s
         5MZEEu91IYb0qEikFmmCm9aekUXIEj+AxXHJjpfMsPsl13eJmNFhY9CXv0Bwd7EyRxUc
         Z0ig==
X-Forwarded-Encrypted: i=1; AJvYcCWNvwNEys3zRjs04avJoJ1AkhMv4xNYjtYlEcFaqI+Aa2Xzouxq6AZOnnlZ/ilfTNdCv0SLTNvMUkwkaUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq1WaOHFtQdPYaqNoTWeFYavToOzGAyEw0wgwejTEyTHhJdOGw
	X1Kkz+fwVhBCpSGSBeYkDmzLBzDUKKkk+450O+Lyc0Mp2RB7wVAD+iwr
X-Gm-Gg: ASbGncuWIjtPn/awEypcO7leyfmlYpEV3omreaX2AQS5pWO1tpGtlfxvX5zKJbnB0iq
	YVQdS5E1smrw1Vw0ubUcE6GkAL5gh8KZhiUWY5qszHXQI54gzOe+QjQhufTh+gkAD4jnUvzx7i2
	NZYKurLLsDDbeRw9Hk+7C38VB+mlTjtX/3x9GhD1QUIAxUWivEZglXdnr84eaQrVk1l7AZEIc0N
	Apeo7z/uKiHDqOH+BS2Fb95BKCF+Sq6rxkGmwzt+JUXBxVFc1vsy//96XI1mw/kneJLadcPlgps
	2uKJyt+wUpwboYp2SPOV1Xu+CDU/JOVcsAz++1gFtdRkwuuMX8thCcR3WR31hBGIPYyi40i210k
	o05jaCWJrRVhDjrq8WxnyxCLWlqDN8jpys9+Tae4437c=
X-Google-Smtp-Source: AGHT+IGndbB5UAuz3dgDmvjY2BUvfTTSKWff8fM1hjgOiYID8XfDtIeSMvF+llPYiazanhdjQzxrIQ==
X-Received: by 2002:a05:6a20:4311:b0:24f:5ac4:664a with SMTP id adf61e73a8af0-2534594fbc1mr25666734637.46.1757555586723;
        Wed, 10 Sep 2025 18:53:06 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a35ba7f4sm177683a12.9.2025.09.10.18.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:53:06 -0700 (PDT)
Date: Wed, 10 Sep 2025 21:53:04 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, tglx@linutronix.de, maddy@linux.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	gregkh@linuxfoundation.org, vschneid@redhat.com, iii@linux.ibm.com,
	huschle@linux.ibm.com, rostedt@goodmis.org,
	dietmar.eggemann@arm.com, vineeth@bitbyteword.org, jgross@suse.com,
	pbonzini@redhat.com, seanjc@google.com
Subject: Re: [RFC PATCH v3 03/10] sched: Static key to check paravirt cpu push
Message-ID: <aMIrgI9J4fuXntRz@yury>
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
 <20250910174210.1969750-4-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910174210.1969750-4-sshegde@linux.ibm.com>

On Wed, Sep 10, 2025 at 11:12:03PM +0530, Shrikanth Hegde wrote:
> CPUs are marked paravirt when there is contention for underlying
> physical CPU.
> 
> The push mechanism and check for paravirt CPUs are in sched tick
> and wakeup. It should be close to no-op when there is no need for it.
> Achieve that using static key.
> 
> Architecture needs to enable this key when it decides there are
> paravirt CPUs. Disable it when there are no paravirt CPUs.

Testing a bit is quite close to a no-op, isn't it? Have you measured
the performance impact that would advocate the static key? Please
share some numbers then. I believe I asked you about it on the previous
round.

> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  kernel/sched/core.c  |  1 +
>  kernel/sched/sched.h | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0f1e36bb5779..b8a84e4691c8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10967,4 +10967,5 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
>  #ifdef CONFIG_PARAVIRT
>  struct cpumask __cpu_paravirt_mask __read_mostly;
>  EXPORT_SYMBOL(__cpu_paravirt_mask);
> +DEFINE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
>  #endif
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b5367c514c14..8f9991453d36 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3880,4 +3880,21 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
>  
>  #include "ext.h"
>  
> +#ifdef CONFIG_PARAVIRT
> +DECLARE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
> +
> +static inline bool is_cpu_paravirt(int cpu)
> +{
> +	if (static_branch_unlikely(&cpu_paravirt_push_tasks))
> +		return cpu_paravirt(cpu);
> +
> +	return false;
> +}

So is_cpu_paravirt and cpu_paravirt are exactly the same in terms of
functionality. If you really believe that static branch benefits the
performance, it should go straight to the cpu_paravirt().

> +#else	/* !CONFIG_PARAVIRT */
> +static inline bool is_cpu_paravirt(int cpu)
> +{
> +	return false;
> +}
> +#endif	/* !CONFIG_PARAVIRT */
> +
>  #endif /* _KERNEL_SCHED_SCHED_H */
> -- 
> 2.47.3

