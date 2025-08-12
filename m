Return-Path: <linux-kernel+bounces-765463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E1DB2375F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CCC3189F8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03526FA77;
	Tue, 12 Aug 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="jOGQWu8E"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECA29BDB7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025815; cv=none; b=d4JDzvW2GXnqNseagE/HMTGDXWlvCALwlANlh5jNW2K8tKYzV1eCcrLUMjbZOuV6NBBVonOx1zpLceVJI1mXGE5XE/A80opFd+/0//YIEBErotn/gMAnkX/7w2av1+2VWGtDoXCHwOAy41TZxREeN7frfl5U//slzDExQDAJrBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025815; c=relaxed/simple;
	bh=bu64oC04OFNyI6udWxYJQC3csVF6k/C6VpNlIgqgsFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MyPDBYNydAsqYFIE2e+F7WtLfvPgDaJbdxjMzdrhKDTAxUTgaGmq/73KO7F9fd6CRo5g032hgGc7lMJVzkoKgTuLhJZKD+OU1GZPH1oaKABeo145oxfcepiCQHfy7DSMWwYsBsi6V6nF/IxJiDKv07X/CuOO8y5WkTeWlXkUCrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=jOGQWu8E; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b9141866dcso535449f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1755025811; x=1755630611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=liYN9p+w76I5yk0XmtckGD/YtX7vKJXADbbeud4KcVk=;
        b=jOGQWu8E0tiMEdyRjW3kvDxuFJ2mwTrMgNNKoDTtMsyx9Qg+tnxNKj8h+ywwSBrfII
         DETndfURroRLQ1W4jcj5kIX27FurPKHsiZXo1rbierexNUQCg2HIwwygy1/RpdkHpBaq
         kXieDu+QJ+zLao19p8KsjxX9+Rdx0jh/Cbg2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755025811; x=1755630611;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liYN9p+w76I5yk0XmtckGD/YtX7vKJXADbbeud4KcVk=;
        b=NsmdnJMPIpBkaW/A+MM0x2y3lg3PD8do25h5IIzjIkCYhp6mbMWEBap2GtTYj4Rd2k
         XwWMRUjbY/XuUj7IcZmviIxP0gy32VbJVecvslWbJn8SzrSKHzBE9CmcTyVeHfQWVsK+
         U0DyWuResdBzhN6LbdsUz3TVcLl5eCxFYTlpnHbszoQaACmG2rY1F5tWqoUpvlrOPs87
         yNH41OmGj5/6AtwE/Ag8fWYwbFx2tJPFG5h2RUFmTbnBxPdkFSnhlZv3ugNhj4Yix06b
         RXOK0oiUearxjZhIFg67a+WiaU3WdR4I9UZbeRchkYOMoBRNUvqBU7Dj51BV9JxRuQq5
         3Ahw==
X-Forwarded-Encrypted: i=1; AJvYcCVJBKtvpfdVKIv8ub8NDE5bTWIOqbPexSfuF9OzOetU+bmHTItGkaIwtMqHbpJjbKoGI1x7aZwdiZbuKck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3DSrmhSQPye32eJ7GI22R+gfi9eLJiAm0jth0KkEFTl1MQfCx
	UCvplDttGT04//9XyBpp5lOqG/1YOdmRS0A6kzwUVjBbQ19L71ZFC5hPSj5PivjtH3w=
X-Gm-Gg: ASbGncvH6bY1lRfhAUujZmhz2gcEmPCoiam5lRfyMFYkkHmzzL2XbO0Ebj1PJeUrqu5
	UrbDSgPXcElBhD0F+NzA6YHDRjf3DWXz+T12rSWVmbbbY6eaH9B5MPWrZoBgg4U6sp88psoCUq/
	bawVqC7lJQog9xvWw+CmRm9xnAd+IvMy6s89G4UL3J4r1GU836NMTwVyCnMv4kunL14GX99J9nJ
	OEEMFOnSCVCF3lq1GZDqt9ELpuzNjU2DFq2iNjtq75vihs4LYX2a3/kJhAoGKR8WwZjOi5/oL+t
	bZhryuonxYKJ1AmyQRq7uAUsf6ERx+MrkJxiEpBGU5vSVU1wjay2zz8h45IieZNPNoKukT3VJIl
	Au71WZmMExQfmU2aCU/a36g2/rwdFY6TFbH9OIgtgz+LbgDJFPMO9/ruob+g0sXIIWjKW
X-Google-Smtp-Source: AGHT+IGfmjf8JsGQUca7vkYCPtAmZK9nxXpEiIAbePK3VMkH+hfJD9ojk3aIkYnpPKD9PoVOzbAcZQ==
X-Received: by 2002:a05:6000:2c0c:b0:3b8:893f:a17d with SMTP id ffacd0b85a97d-3b917eb5b74mr88711f8f.49.1755025811336;
        Tue, 12 Aug 2025 12:10:11 -0700 (PDT)
Received: from [192.168.1.183] (host-195-149-20-212.as13285.net. [195.149.20.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abec8sm47083546f8f.8.2025.08.12.12.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 12:10:10 -0700 (PDT)
Message-ID: <5407877d-4c7c-494f-8fc1-d44eea4762b9@citrix.com>
Date: Tue, 12 Aug 2025 20:10:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/events: Fix Global and Domain VIRQ tracking
To: Jason Andryuk <jason.andryuk@amd.com>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Chris Wright <chrisw@sous-sol.org>,
 Jeremy Fitzhardinge <jeremy@xensource.com>,
 Christopher Clark <christopher.w.clark@gmail.com>,
 Daniel Smith <dpsmith@apertussolutions.com>
Cc: stable@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
References: <20250812190041.23276-1-jason.andryuk@amd.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20250812190041.23276-1-jason.andryuk@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/08/2025 8:00 pm, Jason Andryuk wrote:
> VIRQs come in 3 flavors, per-VPU, per-domain, and global.  The existing
> tracking of VIRQs is handled by per-cpu variables virq_to_irq.
>
> The issue is that bind_virq_to_irq() sets the per_cpu virq_to_irq at
> registration time - typically CPU 0.  Later, the interrupt can migrate,
> and info->cpu is updated.  When calling unbind_from_irq(), the per-cpu
> virq_to_irq is cleared for a different cpu.  If bind_virq_to_irq() is
> called again with CPU 0, the stale irq is returned.
>
> Change the virq_to_irq tracking to use CPU 0 for per-domain and global
> VIRQs.  As there can be at most one of each, there is no need for
> per-vcpu tracking.  Also, per-domain and global VIRQs need to be
> registered on CPU 0 and can later move, so this matches the expectation.
>
> Fixes: e46cdb66c8fc ("xen: event channels")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> Fixes is the introduction of the virq_to_irq per-cpu array.
>
> This was found with the out-of-tree argo driver during suspend/resume.
> On suspend, the per-domain VIRQ_ARGO is unbound.  On resume, the driver
> attempts to bind VIRQ_ARGO.  The stale irq is returned, but the
> WARN_ON(info == NULL || info->type != IRQT_VIRQ) in bind_virq_to_irq()
> triggers for NULL info.  The bind fails and execution continues with the
> driver trying to clean up by unbinding.  This eventually faults over the
> NULL info.

I don't think the Fixes: tag is entirely appropriate.

per-domain VIRQs were created (unexpectedly) by the merge of ARGO into
Xen.  It was during some unrelated cleanup that this was noticed and
bugfixed into working.  i.e. the ARGO VIRQ is the singular weird one here.

In Xen we did accept that per-domain VIRQs now exist; they had for
several releases before we realised.

~Andrew

> ---
>  drivers/xen/events/events_base.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 41309d38f78c..a27e4d7f061e 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -159,7 +159,19 @@ static DEFINE_MUTEX(irq_mapping_update_lock);
>  
>  static LIST_HEAD(xen_irq_list_head);
>  
> -/* IRQ <-> VIRQ mapping. */
> +static bool is_per_vcpu_virq(int virq) {
> +	switch (virq) {
> +	case VIRQ_TIMER:
> +	case VIRQ_DEBUG:
> +	case VIRQ_XENOPROF:
> +	case VIRQ_XENPMU:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/* IRQ <-> VIRQ mapping.  Global/Domain virqs are tracked in cpu 0.  */
>  static DEFINE_PER_CPU(int [NR_VIRQS], virq_to_irq) = {[0 ... NR_VIRQS-1] = -1};
>  
>  /* IRQ <-> IPI mapping */
> @@ -974,6 +986,9 @@ static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
>  
>  		switch (info->type) {
>  		case IRQT_VIRQ:
> +			if (!is_per_vcpu_virq(virq_from_irq(info)))
> +				cpu = 0;
> +
>  			per_cpu(virq_to_irq, cpu)[virq_from_irq(info)] = -1;
>  			break;
>  		case IRQT_IPI:


