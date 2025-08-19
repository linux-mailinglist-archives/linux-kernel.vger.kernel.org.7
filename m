Return-Path: <linux-kernel+bounces-775151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4312BB2BBF5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD40B1BA69DF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64752848B2;
	Tue, 19 Aug 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EI7QC8jQ"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A58A78F36
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592461; cv=none; b=XBs9faL/iffELGNShgPVbvMNitl06XfJ2+gChETzpORU4rXN+BFNAlvsrjrDBIQPFjHTISPp1wRZlJwE04jZ52Kbuz4+pCRmKtY+sfzkbWwwmC3NbN/tc4AusDSHteQlZF/NHhd3u+MOV3SSl9d+ZVhGk1SgJxAX3bFQ6GzFToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592461; c=relaxed/simple;
	bh=TKrhXWA0P/3StKJtEAlozDzVtvqQ35yOKvaTJvBgixI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSL4um7Bw/HKn3ZMsttusH/o+hS04dqDji8WBPY0S10JKmZzB+SGK93Nzp5QVX09W3WzsS8dxhs/CKXdxQObimGL6i9vlGNebuBi3dJYI6syugHuDf2kRi7/SvzbSjXXm0kfz9fMxoMLEAZ6Wg+PbAHJUO20Z6gtTrIRF4cUVRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EI7QC8jQ; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7acfde3so694866766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755592456; x=1756197256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMF4xDn6lkYK1gFMzPaC8P/KY3TRGgk7SGPOwSVmKzs=;
        b=EI7QC8jQQLotaAgOWLhkNuKTcqXlSfW/X6hNdwfrm0NgY5eavgrzGH7grkiAHZ+CIO
         X2x8d49Xos23kkiwO6rrYZekWMbddKJsQI8MdHUld1gOFhhErxUfMz1QThugV+HXMZ3G
         eq6S8j8Xm91Pp3GVIgucQcjhW5O+NsdyJXL7/OxFgt1d3MKxhBP4uyuMHI0cDApiUm+x
         XHtlTDOrCRg+A4PWqXefanpmTc06SDJzXr0BPgD0Kg9PvEAm65GpNKHxYHd4RSN4WdYs
         hhDPfjUrxOUn/z+8vnL4BbAwaCppPNQNoQfdoZV0VN/cZskcc1IQEgm8bulzrx0fEhR0
         5uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592456; x=1756197256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMF4xDn6lkYK1gFMzPaC8P/KY3TRGgk7SGPOwSVmKzs=;
        b=XzKdku+jIDuWoZGaQ7wFonlwUuydImPSkssiZE08E4WJkql4FeNLX55Hs5pG6PgV9h
         GKHGM7NKEijQhoi0YT1gWvp+wRqUg0kK2/JPBGKtqhN9CJWinCBQp2JDD7/fKrJc4Uqu
         AZSI9MbcHIkAlgeQ/P3M7sJnyLQ07LQMBnqZRZcFjIyLX3Rx2eqNMK+1ZKX9AKlJR+DP
         IFuyOyYkllaI4O+pbmrTlpGkZyDMVCke2YZkPYY74PqZmTC1x0kPyY/ECk4PZ6pRYy6X
         9k/UQOUko3ZL5c9t8w8je/D/NvhQoqtDRqbEZBohisf++avHcB4JOtC85ZEv1HuXvRw4
         +3nQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBDoSCV57+SbhPq3tLYQu38rkcQOWj1sqSTLW4QNRkeHfFQnF1Cs7vX8nYhRgjNpvWt1YK6Pwc9Y1jUYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0qbh1R3SoEOUU7k9CAHsZpA/5sczFbIRhqa7VxbOoZSXUs32K
	GjkaQWH/k9qrJIG05jg1k6aJNTkvkSeyFyRdbeeOzY2UQSpbwISOQDqi3hacxGceeiI=
X-Gm-Gg: ASbGncuDzo2fYZJ1GKLwN3Ds4k3475K63Ok/Lb3Z8I4MT0TUMDB6k1YkDuM3XN/4tEN
	JjyH5reTJoVHgFXsrq/tMe4+djsXH0K3mjAXUDZAxQgZg9dW9Xtz+FxvmZCiQm5ZUHD4xCsaf0e
	pOMCHvoFFlFGX9HcZerMHlQZbVg3//3n24exXY4b/SKsn7GjKMnp/x61KyWRMMeYl9OqkVHfFzW
	ZcLFGsyyYzwZ0e3aZuev1bdQ7CK2xJAEwaVCJR+3n1SEE8L7RT9BirHoCO0/JQXrqlcAV4/EWCz
	tL4lk1z2tb019D6XloiQ+SQcAltAJnEoWhZQ1cLI/lMKQqbVvzh8FcTE+UJ2AJotL/lTaGD/wrZ
	Ox6+odfbUM0Sgnfh+pzS9Oe3TUGtWIwatkgxX
X-Google-Smtp-Source: AGHT+IHGisqzawEgiTNZBQw05NUixNi7BsSR1QD+IYl6ukzkTHXAXTSynQOH7X3G2FNQkCkyvP+6mQ==
X-Received: by 2002:a17:906:c113:b0:afc:d5a3:90c1 with SMTP id a640c23a62f3a-afddd21a8c1mr150621066b.55.1755592456434;
        Tue, 19 Aug 2025 01:34:16 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01096csm952997366b.88.2025.08.19.01.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:34:15 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:34:14 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH 1/3] lib/sys_info: handle sys_info_mask==0 case
Message-ID: <aKQ3Bi5q7-in9MgC@pathway.suse.cz>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
 <20250815071428.98041-2-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815071428.98041-2-feng.tang@linux.alibaba.com>

On Fri 2025-08-15 15:14:26, Feng Tang wrote:
> It is a normal case that bitmask parameter is 0, so pre-initialize the
> names[] to null string to cover this case.
> 
> Also remove the superfluous "+1" in names[sizeof(sys_info_avail) + 1],
> which is needed for 'strlen()', but not for 'sizeof()'.
> 
> --- a/lib/sys_info.c
> +++ b/lib/sys_info.c
> @@ -55,7 +55,7 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  					  void *buffer, size_t *lenp,
>  					  loff_t *ppos)
>  {
> -	char names[sizeof(sys_info_avail) + 1];
> +	char names[sizeof(sys_info_avail)];
>  	struct ctl_table table;
>  	unsigned long *si_bits_global;
>  
> @@ -81,6 +81,9 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
>  		char *delim = "";
>  		int i, len = 0;
>  
> +		/* *si_bits_glabl could be 0 */

s/si_bits_glabl/si_bits_global/

But I would personally remove the comment completely. IMHO, the
purpose is quite obvious. But I do not resist on it.

> +		names[0] = '\0';
> +
>  		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
>  			if (*si_bits_global & si_names[i].bit) {
>  				len += scnprintf(names + len, sizeof(names) - len,

Otherwise, it looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

