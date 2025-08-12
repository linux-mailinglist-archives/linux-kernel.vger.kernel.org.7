Return-Path: <linux-kernel+bounces-764699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F713B22629
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2959E3B3916
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AF22EE5F4;
	Tue, 12 Aug 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G41KKAo1"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9796E248F6A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999584; cv=none; b=jhNLBrovrAloe76CjrZxabzy/tihba1jkLDc3kj7K8e5WB3F4ZRGVtSNa2XnFPPTp8Tz+3Ad8HFbYY39jBp25jwFfnKQX5DEJ1dpmOBNs7pHZKaZHveD5TDdn5PlVLtNei52i4euRzLlIr70w+xHPI+4tuj4H51nSuTLPi4UGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999584; c=relaxed/simple;
	bh=RTYfJMPh+t1vQg/mU0nSTVELG2bD2Xan9cEtIsFKB/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oispeeHEin6QVp3+OVt+5o037aKhqpf9cRm5npoQw9H6iWNeHiGYgl+NFiBqudoWfZFqUU64B9d048e7L7gU58UCBZL+yPV1AN1BN62xt00ss3NGXgR2RwcxV+QEa95QCH/EgXWlaVBiYQcFSd8LMozxE5y06XfM5UlLjuuUenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G41KKAo1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af95d5c0736so836750466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754999581; x=1755604381; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t3c3phlVUTTXn2usyZSOEwXAjpjuYewwi7y9E6CClAI=;
        b=G41KKAo1//W93DeCsfXj5aAAKAzyoZCvEXDaE9Vvagdm8fprXsbHR5xLP193XIkybb
         j9VYhQtww5oTWJoVbGouiZvJToymxHyJ8kV/GiYwfXEBxQGU21yb5ObhynrcBKBxcyIT
         TZ9DgfhG5NTUN+hcuZKSr4mC5vaa9HrIgQCU1Zz433u6KrsxSFPZbBHfXDgniz09CfdS
         1rt4nV1aG2U7SsHTnnSfltm4MOCDWt31k99bW9p38Q+mOBBo5RVJSV/jKiUAnxa2ya9C
         g9UTRG5AoUIh8H+lyGgcCcyhK2htaOnnMB5oNd9jGMexFRLQRpqgGKuvP+7/TV6gcoWk
         y5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754999581; x=1755604381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3c3phlVUTTXn2usyZSOEwXAjpjuYewwi7y9E6CClAI=;
        b=dkQraxXTAlGd2nfoumqAG+Z3OYJpifHjkdQlRKtBY1RMs1m2Au+XHpJ/x5uDKJCt7I
         XjbvqaI7JFytiD6C53XNE3P7dczNKR6jpf/ipZfLzjMNH4UHNshdsoRzaDcKA5SiFrRv
         iNLbypePv4OHZNb24TwfQNtWPMPzqlCb9fo0TkQkNOrwjqzvyOMMJEbt/nBdbEtkk/Vd
         sIcjq++RZYXPUsNnxY2x0nzc/pV6u/ag2xj2OjIBFCghEqkV7BY22CwU0q/Sb1P8N8ga
         K/v2I4lUtz+l9/YhFYFVORUsq9PdUzqX3jBh+dRqYLa9sONU/PCM8Hd0+EdhVIHqyVwH
         YIdw==
X-Forwarded-Encrypted: i=1; AJvYcCXdQNg6AtxVBA1PhRT+YkBASrGiDo6xsyXoZ1I9g/a6NL4Dk5aHtdZOcE69m2q3auAe0Y7TJxz73iEYV24=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGkHlSBFXGYtWWYFtZgl21JFWFY2Ng8p6qiKxaIkKTmhqyv6dP
	ZnqtJdyVIvVfgc74DJhIWv/+3h2w6JT25k4PSwq23I8PMnHTP1Ldoz4JzgA4nqC8sZ4=
X-Gm-Gg: ASbGnctrc30wTHG5yoDkvNK1Dx+g/pe+zvsbAvx0Cp2MCQKBo/d+lijpubZAcuM0bRU
	rJCJUuIxZMrl7E5LCZFYa7SeR3xcy4pPSlcjei2ORJesxudu3/2keZD3lhBNSAZt+ZaOBs6Seoa
	WYJRli6cQX/p6o3wtY4q+NZjmm2v2487kzH4HWa4y3KzqTSeADjLd6huJ2fZppiivSxv/9SHyyF
	vFbTr79k8FWmMLihKVklMpZE6dcgvn1YMbZLsh7O1IQhfNOyxgHXHLSRr8X+AZnNqmBdismyPut
	R5ewHOJfdtIyZkh/dm/8d+ljEqxTwEOZNpFp9UYyMobAcWgnvUXI5FyvrfQhfTq+c/tFD09Se/f
	pby+Rfjr7y/m6yEnO4WDVt5hG
X-Google-Smtp-Source: AGHT+IEaMvCzBAksy8L9owi3KvmTTsx17pGMfVp6Np/7tT3cRaQ374KNXZ2K3mEfFBEYaAD9l8T+RA==
X-Received: by 2002:a17:907:3f18:b0:af9:495b:99e4 with SMTP id a640c23a62f3a-afa1e17fcfbmr254043366b.60.1754999580873;
        Tue, 12 Aug 2025 04:53:00 -0700 (PDT)
Received: from pathway ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21b115sm2170905966b.103.2025.08.12.04.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:53:00 -0700 (PDT)
Date: Tue, 12 Aug 2025 13:52:58 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v3 5/5] panic: add note that panic_print sysctl interface
 is deprecated
Message-ID: <aJsrGgTYxtEhZ7jX@pathway>
References: <20250703021004.42328-1-feng.tang@linux.alibaba.com>
 <20250703021004.42328-6-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703021004.42328-6-feng.tang@linux.alibaba.com>

On Thu 2025-07-03 10:10:04, Feng Tang wrote:
> Add a dedicated core parameter 'panic_console_replay' for controlling
> console replay, and add note that 'panic_print' sysctl interface  will
> be obsoleted by 'panic_sys_info' and 'panic_console_replay'.  When it
> happens, the SYS_INFO_PANIC_CONSOLE_REPLAY can be removed as well.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -77,6 +78,13 @@ ATOMIC_NOTIFIER_HEAD(panic_notifier_list);
>  EXPORT_SYMBOL(panic_notifier_list);
>  
>  #ifdef CONFIG_SYSCTL
> +static int sysctl_panic_print_handler(const struct ctl_table *table, int write,
> +			   void *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	pr_info_once("Kernel: 'panic_print' sysctl interface will be obsoleted by both 'panic_sys_info' and 'panic_console_replay'\n");
> +	return proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
> +}

This warning is printed "only" when the value is accessed via the
procfs. It would be great to print it also when it is set
via the command line parameter.

It would require replacing

core_param(panic_print, panic_print, ulong, 0644);

with

core_param_cb(panic_print, &panic_print_ops, &panic_print, 0644);

Best Regards,
Petr

