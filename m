Return-Path: <linux-kernel+bounces-838457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D1CBAF368
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 08:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84291896658
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 06:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249652D7DFC;
	Wed,  1 Oct 2025 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BlqlWdUp"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC7239E67
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299381; cv=none; b=hCFjKBasluf83sEf59ZHBBWl9H316GtdIDaVNZuaZ7uBGLKIKJzLkwomJjywVxcG1eD9DycYOLHCGx4M3OLh8/NbDPueZHD2cOiV2ml16lOJhGo/Zg5Y4Pm9L28OoEr1G1Nz/7r+UInbTzMbqelQOLnCddDokjMYnpghQeS0XnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299381; c=relaxed/simple;
	bh=EsZHnwMiJYPfidoSqF4cLJPZLMaFXC7b5B5xbjHh7PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=babI1KmOjWPOC7Rd0EwdZzBuHrM6oSNVQIl36v1qDcZ0QAAYV6y5Y/Ee8zErToqnHTl/iYXwLznRPDausvuiYcXhcOrLEJXtl6GUc2OBrBQtV0oG8mtM4vfzgFQDyCH8I5kyY1SdWmKVuOM8o7EPtSuIjL4sB0CNS+Wid5r5zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BlqlWdUp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6317d75ccc9so892536a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759299377; x=1759904177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2mgRUvHIwDUBa1m0CHFDPXrUsPClCypgfwL+/TQDD4=;
        b=BlqlWdUpTt1i0e9rEdsqx42INF5MhP5s32JHeZBPn6O2TJQTkHG1QQwSpKNP8ZBzbM
         XvA5dOAmKjlx+nHD7PEGcimFsFDZOxMeYd8aXo3QT+yDtkIJGzY9TXlyji5fk6pGvN2q
         ZZ00vkxuVnJj/T62MYTED9aONJZ2cwLJa+jrmqxE4BNWbuDAVXErOQ29JklFE+3l47/4
         pkGKVHqEDEMo+dNC4MWkp2nqD07mq1+jB1av7ypGYAF6qUNwvF4RiHgzpoHSANOduaPx
         1CF8TlkZ8HRke9SfL2zw+Yobr/YHl1X5eq5GlPsqegdTNNF6/MLgqKY8kwYEeH9SwLLw
         FzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299377; x=1759904177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2mgRUvHIwDUBa1m0CHFDPXrUsPClCypgfwL+/TQDD4=;
        b=a6VmFOsn8/aTxn1/Pzt3eQPaFCZ+61ro5fgccOsszfcZfsMZYKiRbDn32c5mPFKsJD
         PjIVVWnmI0g3UC4DFXrxkJMqEiNPVI/aGT2Ici2HspVmZrVBCy1UTt5kqrX2JYq/27N5
         Te4h0LrzmYAyIohVlpELkGkS/myitpU0lHzPlV2oXdIZ7BLZLQs89tDIsQ8Chew9RXju
         M039s/8M1pw4EKGc5SMOX6qLJ02UKsJelfpXKoHtfQ0ErLkigCWo0tO9OBgxHvJ0ZQaP
         I3xs5rQmg81pTFcwd45qOB0IXRskoUgRZvQjhbWJXgINZHqhc5Og5JCDupaeFwqFgTAO
         GlvA==
X-Forwarded-Encrypted: i=1; AJvYcCUFvh7KSf2p9v3o9g6J70DwZQhUMfB9WlUYH8yn6jzpKbGZoZD3IvR0C/JvL/iQb/KFJOxutwN1HhOqpUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGxHxQkxRauUTi+guLQSYXtEQ2IclT6l6AqMQBZ1ilE2fcFvTQ
	H4KeBJbFiMu2NzrE8VCTcKm6CmzJUX+WFl9+iCDaeqCCxZjrhi+nh9a/uFaC3kl9vgVrW6eEQ3M
	+iisT
X-Gm-Gg: ASbGnct/xIjcMT39wGxhls7yprSaRrSPsbBIIL+HgHt59SpAYLqW+nOhL0kvkOYaeWZ
	060dbWGSD46kcqnStyxcdhUCPjWQnsZh6gr2vGt7bYJ7wpZMWuvRBQ2lHY1/vu3nOQ/vfaVEw9K
	jqw4hhWgInLqupxtWzj054TQJbsEzeYYjAKqhN7SsBTk0Rn2o1KBcNVd1l33wXgYNcjXmh7QnIz
	qQ/6Rste21Jd1D+dPzSzTFZQlW2FWkoMZR3PmdbyOW71Spyl9nu6AFDgxy7DvciMqtBqFfLOn6N
	V+U/eiSO97x35JZtMBbTiQYBLpkUjyxVVoajRnoPQ9L6IUCF/c2+Of2u68JhwKGAm9JAvYLtSue
	4haRnuiXmAZt5PoHlKyKG8bHyDXIWe+V6KUlTSs29AoruF8nKghC3vB5tFrp/3etgYrgF3BZwt+
	KeI0NcrMhitbWqfypNDaagU2lg8O3eRJugwrpQe/e/oVkuTdRmicPK
X-Google-Smtp-Source: AGHT+IFQWcwToJXtlmVcxmZdWqb+p7usl4TzaktlGgv885VDmhxQ95bwd+azkuh9E8Say4Z2rE5kaw==
X-Received: by 2002:a05:6402:348a:b0:634:cc8a:5428 with SMTP id 4fb4d7f45d1cf-63678c4357dmr1386965a12.2.1759299376749;
        Tue, 30 Sep 2025 23:16:16 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634c4b96ff6sm8623357a12.46.2025.09.30.23.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:16:16 -0700 (PDT)
Date: Wed, 1 Oct 2025 08:16:05 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sean Anderson <sean.anderson@linux.dev>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: fix direction in dma_alloc direction
 traces
Message-ID: <20251001081605.4f86a6cf@mordecai.tesarici.cz>
In-Reply-To: <20251001061028.412258-1-ptesarik@suse.com>
References: <20251001061028.412258-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Cc: stable@vger.kernel.org

(One day, I'll finally remember, I promise.)

Petr T

On Wed,  1 Oct 2025 08:10:28 +0200
Petr Tesarik <ptesarik@suse.com> wrote:

> Set __entry->dir to the actual "dir" parameter of all trace events
> in dma_alloc_class. This struct member was left uninitialized by
> mistake.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")
> ---
>  include/trace/events/dma.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index d8ddc27b6a7c8..945fcbaae77e9 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
>  		__entry->dma_addr = dma_addr;
>  		__entry->size = size;
>  		__entry->flags = flags;
> +		__entry->dir = dir;
>  		__entry->attrs = attrs;
>  	),
>  


