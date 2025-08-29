Return-Path: <linux-kernel+bounces-791411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD37B3B67E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E476981AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67AE29E115;
	Fri, 29 Aug 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lKu9gpPJ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD987082F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457806; cv=none; b=PPxlM4NkeybqpXjwRBFKyE6IZnIXyNiZHtC8jkV0frn3txgxERvzgHwsyp16C/gXboWZm+qfKMdQqozWSiEOcJlmAQ9GmUaLjN22u1vwNpOGxXc1g2eecDCkYOe4///q+YMT+IlruUdzberf80IWEWqUOmxKYwCBpdB3Zz8FuyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457806; c=relaxed/simple;
	bh=E8HcF+1i5VLhjoQ21QNuV6YeA8OYWosCS5Vz0RG5FTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liNauiPY90KdszcZ2mK7rWiZ5ArpuM4dIi/EgOGOGzHY6ZKhSPoAWLbgNhBshA6Dy/i9aINwL9irQIpa/HQhlrDaLGcSXpz74wBWRDbvZ9Ov36wYkEKoBWiVLo2y9CBbuZVpQVtqwSx0Bd+BPaPt2nwJA3cTyMAc1T4Aw6G3DIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lKu9gpPJ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1784997b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756457804; x=1757062604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T3oJFsmmS2ZGu6eiSOuhkdlqFpqNjNFn9XhNWqVm6U0=;
        b=lKu9gpPJsc3tWm96r6BQHbaZG1k2nVcqZYTyKA+d7M4J1QYR/lGGIxyfwU9uJE+/q/
         +ZPmTiYGWOjLopU9RIOJINvAy+to9zQ1SxrBCIFN6GKYh5Re6DX7Jruyw1d7pT6R2bFT
         nj95MbseCqatJLUVe07ziljuUgd6QxYP/qpsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457804; x=1757062604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3oJFsmmS2ZGu6eiSOuhkdlqFpqNjNFn9XhNWqVm6U0=;
        b=F+Ev85nfZ7ILkXr0+mL/UUwiBZ3R3WkSxZO+rNBNPU5nRFVenHiNSLje0w/RPLzvtT
         7XC8ykSdybZhb9K0nS0kghuDqpha3ce3sLPEOiLtb29Z+BiVVP18n12ELmmPkZFarvsa
         a6zR421UE/eiXnAEIpU8xDgYaaN+8jdANPPmPMsw8qnAmLpamp94f5Da9FBBkPLu1a4M
         XPU+vp8NkpQqRvj40qQZm31XSTjhpChLFS95a/yKE9FRt/NFRPRJhXtLytE0kCC4fPZW
         3prVf7dIrnZGCghee7uiScpU0SqNX+TauEZ+k2RR0ZrLkpZ8qcukkT6drlTfSDnhiYx9
         gfdA==
X-Gm-Message-State: AOJu0YytQJ/UJvZsI0Xvq/jLCS/bhGYj2hK7lBcQGipRiHrN7ESsm4/2
	tsCWAvVEEzmp1pxMiII4JXgxgdOsZ9C7P2m8vYve+3QjM4QummMIO78mNr9cN+s/V2Xsd5Gc4UM
	wFbk=
X-Gm-Gg: ASbGncu8yHg/yM8gSdygR2HiS8ebnQwK3VwsAH4ZWti7AGa9OkX/op8CI9q/cnSomQY
	/hT7uCqN/ck0i/sHDWawskly5PA0ROm/uyl6H1EEY8wyZdLJQJ++V1xCUEreK0+adXGc2bpEohC
	Pmtf23aKm9XlA1oIsFRLrciQfoRyFFWRfICLPMqhNHQypeHf2yw///XpkD6v9Uq27+NyMzaZC94
	B6NB8UcNVR3ttwsuoIhEKoeRDqQfLFhf6KLoQTJ1nyvm73FbUnYBrRTRPwcJGgTn6bD2eiRSskr
	DE9hmxhygwyoH/wUVX6v6k7FTQGsoMa7dN1kdU4PzF8EnDPQ4MiOVffcBv0kG1kMpDk47q2Z+KM
	cZ5CTXzum2xsOHs2hlOD1vYxF/0NZ/O0UlRD6
X-Google-Smtp-Source: AGHT+IE77behwFNSbRmH3pk8zfkxHLh0n20scBchwb33vR4SG2CIgdoHEVISGNZBOKMJtizOBeKA1w==
X-Received: by 2002:a05:6a00:4098:b0:771:f34c:2d36 with SMTP id d2e1a72fcca58-771f34c350dmr22224461b3a.32.1756457803984;
        Fri, 29 Aug 2025 01:56:43 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:b838:d833:3d57:68da])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm1692519b3a.73.2025.08.29.01.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:56:43 -0700 (PDT)
Date: Fri, 29 Aug 2025 17:56:37 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mel Gorman <mgorman@techsingularity.net>, kernel-dev@igalia.com, Helen Koike <koike@igalia.com>, 
	Matthew Wilcox <willy@infradead.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, neil@brown.name
Subject: Re: [PATCH] mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH
 allocations
Message-ID: <filznxw2rq5ylpawl3auho7luiyaqxkmitf76bbpxyihkbkw43@pos7qfwb3i56>
References: <20250814172245.1259625-1-cascardo@igalia.com>
 <10cdada2-f28f-4868-b821-4a13ed627e76@suse.cz>
 <77058118-b481-4c45-8f86-d9a67ea6a187@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77058118-b481-4c45-8f86-d9a67ea6a187@suse.cz>

On (25/08/29 10:38), Vlastimil Babka wrote:
> On 8/29/25 10:36, Vlastimil Babka wrote:
> > On 8/14/25 19:22, Thadeu Lima de Souza Cascardo wrote:
[..]
> > Agreed with others that this change matches the original intention and it
> > must have been an oversight. Also found nothing to the contrary in the
> > original threads.
> 
> Oops, forgot to add
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thank you!

FWIW
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>

This needs Cc: stable@vger.kernel.org  all the way down to 5.15,
as far as I can tell.

