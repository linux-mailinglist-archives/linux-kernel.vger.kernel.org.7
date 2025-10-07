Return-Path: <linux-kernel+bounces-844086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE680BC0F78
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39CC434C1F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8A02D7DF6;
	Tue,  7 Oct 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFkf4gje"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510002D3727
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831690; cv=none; b=dNPMExdkatG/NGvxZ2vpskQQeOxSvDmloWUw3DzkIB8D7ReTlLmKzhvboL4X2X6hhdGq6+7BdCq+scJIh6k1nzRtQFqcA2tI8x/IvSYbY/pP0mv7ovDCNp+o2MkkjhIszlAZyyh6I+RDuGTkrpFg0023aUkpVNb+whd8Y3rVuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831690; c=relaxed/simple;
	bh=X1iciAMY8PqRMVBzYSqFJyHJLL4pQ951fQtXxmSzeas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6MWpMTfYonznR/pzbdVQwzkSs6Tb/YKCL9WuMOblhNsS0a86ukAma7ipgjXUnPMhvJVmT92J/fSVV/gWdXAYttnJuI2P9/q0q3GGFE3AcQLy2j15j6EhpbTba5xOHikCaUjSa8ZZRdu72vDg62VtGjYwOc8fDUEUvzwzi9vL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFkf4gje; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759831688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+mtcU9rV2NIG8/Fsnv3bz5W3lOoU/FoKHUxf6Q1GCxg=;
	b=bFkf4gjeBOdM8bIIO3o1zI93ozAqQNcNPfoXklkK579WKrAHdsvSGJqpvtf5VIzL2FaSt8
	guRtzxkkXKYkGX0QGw0xbFfdmocmA0hdE4kJnvVcJRH8Gse4fymYnic0UOJBVRDZ0TnZ9D
	nvMEjJqbe4q/XWb58VN48lJdQMvkiKk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-qnFI_cveOV6PXneEVUjuyA-1; Tue, 07 Oct 2025 06:08:07 -0400
X-MC-Unique: qnFI_cveOV6PXneEVUjuyA-1
X-Mimecast-MFC-AGG-ID: qnFI_cveOV6PXneEVUjuyA_1759831686
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3ecdb10a612so3983039f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831686; x=1760436486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mtcU9rV2NIG8/Fsnv3bz5W3lOoU/FoKHUxf6Q1GCxg=;
        b=aNvnXF6YZOnie7OdaipDTAEP4f0QGDBjA+MsxQ31k3UcrHxnNbFHtB99iGW/ofbf+i
         hf1eTWi9foHyzni1f+5zdE6swx4m/MM/x7YxBKwCe0k7zA9idLN0xm1Zt4iP7IccOIgA
         VH5Lpx5sj82Qn1+kZ2rB5h9y2uTiQ4vyDyhXacMqXsZW4m/Tf966oPAYFk4Q5K/kFNgb
         Z3apgODlUN8anDy/9cEr4qzwnWG9PZ073CL2MBn0TtRwzxRDr7GrYXOsj9wPvv04Red2
         2wnO0GxUMm4TKctlEtAsnxRrgfzseMUkRP0mg+7rs6dYOhRJmV88vvPivq9A0oJ0DMA5
         D81A==
X-Forwarded-Encrypted: i=1; AJvYcCVx5tzzrZtdBkWv5XmtxYafVFi/9oIvM4fNmYsPuVzERiApcyrp5gh1X3Y8/Boe2mprS2ThKLjwwoqwlG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk29aygPrm76zpYygt1p8alZT+J6qFeo0U9qTbqKrer5ECddsF
	3PPFCbiMTiPAAmIOdulH/ddo0himemUKgK+q54vF8ofSVMKhARN5u4IEF3tEZt3s7RQM4OH1PNU
	i6hq3sLh8T3nCUOS/fwTSSVti21YxC2z4AGL0BVCj2wv8Ai/AvEscgptI8A46RI43LQ==
X-Gm-Gg: ASbGncuLBVTKIwTAwnuwiyl/ATrtoxrtehgtzySggFRmmPP4UOS1k3+DrHuqr/7x7Ko
	bVTXH3E2/vMJUlS/S0B3yg893L5omBIWFsmpze5l/9Qv1MxlFhEJtZIrB6NfRIiCVuEA72iAQdg
	UeVS502XFdjOWRjnyJLTHmLf7QwHBcgxYk8+j7k7SIgf6rl0YIYjjo/b/1AkuttH4XTwDF0/NTz
	tCg62MTxq+98sxDlp0ue0gqlT26MoL9YQJUh47RLTGEbMP4jxP5JDMWs2fSag90WLAacoHpD8Mu
	F3eIWH8AmawCy9Egs7CFnV3C9zKGzCmO24FnX8Qs+KUz/cVf9V5fJXWAN39FsPyyhsb6khdGOfo
	+Lg==
X-Received: by 2002:a05:6000:2484:b0:3fa:87ad:8309 with SMTP id ffacd0b85a97d-425671c5e22mr12150992f8f.56.1759831685975;
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoOnbt3zl/Z0zIFMaawiwiieruc6RIjDSa5Y4OtsLc9P/dDQ+rp/oPqBnApnJV75iKliXKtA==
X-Received: by 2002:a05:6000:2484:b0:3fa:87ad:8309 with SMTP id ffacd0b85a97d-425671c5e22mr12150970f8f.56.1759831685538;
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.135.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8b0068sm24882138f8f.26.2025.10.07.03.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 03:08:05 -0700 (PDT)
Date: Tue, 7 Oct 2025 12:08:03 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [RFC][PATCH 1/3] sched: Detect per-class runqueue changes
Message-ID: <aOTmg90J1Tdggm5z@jlelli-thinkpadt14gen4.remote.csb>
References: <20251006104652.630431579@infradead.org>
 <20251006105453.522934521@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006105453.522934521@infradead.org>

Hi Peter,

On 06/10/25 12:46, Peter Zijlstra wrote:
> Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
> enables easy tracking of which runqueues are modified over a
> lock-break.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Nice.

> @@ -12887,8 +12888,8 @@ static int sched_balance_newidle(struct
>  	if (this_rq->cfs.h_nr_queued && !pulled_task)
>  		pulled_task = 1;
>  
> -	/* Is there a task of a high priority class? */
> -	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
> +	/* If a higher prio class was modified, restart the pick */
> +	if (this_rq->queue_mask & ~((fair_sched_class.queue_mask << 1)-1))
>  		pulled_task = -1;

Does this however want a self-documenting inline helper or macro to make
it even more clear? If this is always going to be the only caller maybe
not so much.

Thanks,
Juri


