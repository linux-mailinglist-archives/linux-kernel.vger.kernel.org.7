Return-Path: <linux-kernel+bounces-863563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4BBF82C7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B47064EADE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A234B18F;
	Tue, 21 Oct 2025 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gwLAwt2X"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF81A2392
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761073052; cv=none; b=NfjL4o3epjwYT+2EgkN5uVzYflA271vYuNtKIZTzOCwRJSjJJeUQeP+UhtyIfBeXnqCR01RKYcTAMMfGUGIRlI004Ra7TIZgifsCd2/enZ9rqM/asOxX0LeG9g3zBZWrw4NHrJPa84tmgFV3KGZh3PvT2q5jWvTvkGUcQnWfV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761073052; c=relaxed/simple;
	bh=ICHOJfBAiMA3GFWxx6OGyhDRRndASzHR7RV9fm6Nan4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc0k8lMIznxgjo5+XGl88Gum1hWQdUjGz1x45pLM2A72gQ0Zuwi9ZJYT5eEYyloUr1dnscyQQoiqsWUpvV1yh+VLO0sbkr0pXMw1I4Dw4Pb91qrMxvC4umG0Kpw/Fl37Xd9ozPYuU4VojpJbO64MqFpp64SWwuoICgmWCbkz9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gwLAwt2X; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c0ea50881so123921006d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761073049; x=1761677849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICHOJfBAiMA3GFWxx6OGyhDRRndASzHR7RV9fm6Nan4=;
        b=gwLAwt2X9UzSNZOLzLIJPQy8OG+XPfvvDIzacbkWAJ6nNzGx9cjwsiVqCb40kzUsE4
         ZLh9gmTbs0xx8uGF12GTJmh01O3SSv6JsjRzUp5hl67cGNa8pJrFI6BEmYURRV1ijK/B
         n8XHtJUctmfCdkWZdUnTSqPlhcicOKA5SKq8Yma/nLZHf+oPyvUM7Q53YbDvQFefUTXy
         hwJ5QcSmCuecv2u4Hs5ugHlAl9kAnNnr9aeh1VlFtnUejmd3FhAJYtn7+vKrxKZgjQGO
         rXysTGL7BB4dkoayG+SyXFve9iJPEG7y4hqFZjFMl5R2ZyXYtjdRAkIUV19Kdows0/Oo
         ZyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761073049; x=1761677849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICHOJfBAiMA3GFWxx6OGyhDRRndASzHR7RV9fm6Nan4=;
        b=MAS5BMcz/4An7OtNHtPvzTivFUav4yrTqb5al1g76loroGXbUleWyrsCHm0HtYcnuz
         mWo6wRwkps/ZRyBYy3OY7oifhD2H2SneHmzTnmXk9hZigiUZDi1BS5BrHm5fdik2rYrZ
         lzHXAeCuvj9VknOwMkHTR+cdw42NVi8rTHhGGh46iDbHW3F/wtJ/KCiQ9fTPpb196Yb+
         WFFMge6JCw+rIM5jHfnUPSkEekHmn3wzZaExYgBFCIWmm3DwI30X/9CSryvEa0NivkSM
         v2YL9WxO153qi/QPuCM2UkI+rCiuOX/7QyppK3QbCXC/p2aWsPAVjeynQhJ4vAU9NKWQ
         YpFw==
X-Forwarded-Encrypted: i=1; AJvYcCUicDizZHzKohmtTT9A7clowyj7bUls+KZq2Xrw5xtnlLQaTVroxLj05N2Q4UsUyqG+P9qbg1OSNHmgRSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNLFuUwNC3YJnwOUUXwJgtplGmlT4if8GcVyozz8Yd0b8TuTe
	+0lS53yVIXmVnV31zfEo65OT8DVK+oF6S8RoMfwGbnHmuTU30vMZTsYbkrbQJB8ZYzg=
X-Gm-Gg: ASbGncslS/hspFKw/E1NL53GmZLuDKTivpqj/Yzpct5sTY09Cjwr38KDSzzmYmdk/W9
	E7CoQzMiRbeYA+1U4gCwhedyk8uf32LQcUKmxM9S2oTl8An6mSIcg1s1fqh50y/7KKIPJcGh9mo
	GJG2WWi2DvPLSJp6WZUE9AQIKiU/U+BI87SXYTGtWi8kGAQS0WKNacBU3+DpYJdoaMO39WMyDiF
	AginOjPsOVWTWLGVrHlFxP89lluXgyNmIZ/AviCKQYx5G8IqYa25r5aOygwNv5c8Yr9iFZ2vzi6
	QNLHf+mx80pNF3243gD/+une7uIosUTO1nVf35eqSfWOHbSTn9ExXnSCsj8Fk6JDOHcX0FkUTOy
	HzX8SInHqVpAtOiETjd4VTtc3PSNAlb9MgY2UZ44HDPLHQfdCOIXD2SDh5mgYCRtdRfAZ5fucdF
	GM+DxfU1JyRV31ht7BInR+LVlk9cj6XANwG9IllkhhIydFd4wggxSFssNbAiQ=
X-Google-Smtp-Source: AGHT+IFfs2dfEPPNJsfvZRFCqEjEBAjB/pFkbuIYcg+kdR54i+7DW1sSnKYu8l9TMPmKxu8MbgRFWA==
X-Received: by 2002:a05:6214:489:b0:87c:64e:e1a6 with SMTP id 6a1803df08f44-87c2056af1emr184471716d6.3.1761073049484;
        Tue, 21 Oct 2025 11:57:29 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028aef65sm74522236d6.50.2025.10.21.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:57:29 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:57:26 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>,
	Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, dave.hansen@intel.com, hannes@cmpxchg.org,
	mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org,
	raghavendra.kt@amd.com, riel@surriel.com, sj@kernel.org,
	ying.huang@linux.alibaba.com, ziy@nvidia.com, dave@stgolabs.net,
	nifan.cxl@gmail.com, xuezhengchu@huawei.com,
	akpm@linux-foundation.org, david@redhat.com, byungchul@sk.com,
	kinseyho@google.com, joshua.hahnjy@gmail.com, yuanchu@google.com,
	balbirs@nvidia.com, alok.rathore@samsung.com, yiannis@zptcorp.com,
	Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [RFC PATCH v2 0/8] mm: Hot page tracking and promotion
 infrastructure
Message-ID: <aPfXloRQgplusnce@gourry-fedora-PF4VCD3F>
References: <aNVohF0sPNZSuTgI@gourry-fedora-PF4VCD3F>
 <20250925182308.00001be4@huawei.com>
 <aNWRuKGurAntxhxG@gourry-fedora-PF4VCD3F>
 <aNzWwz5OYLOjwjLv@gourry-fedora-PF4VCD3F>
 <CAOi6=wTsY=EWt=yQ_7QJONsJpTM_3HKp0c42FKaJ8iJ2q8-n+w@mail.gmail.com>
 <aPJPnZ01Gzi533v4@gourry-fedora-PF4VCD3F>
 <20251017153613.00004940@huawei.com>
 <aPJZtQS4wJ1fkJq-@gourry-fedora-PF4VCD3F>
 <20251020150526.000078b6@huawei.com>
 <aPfWePBq8d3v979f@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPfWePBq8d3v979f@gourry-fedora-PF4VCD3F>

On Tue, Oct 21, 2025 at 02:52:40PM -0400, Gregory Price wrote:
> I would prefer the former, since this is already what's done for
> hostbridge interleave vs non-interleave setups, where the host may
> expose multiple CFMW for the same devices depending on how the OS.

bah, got distracted

"Depending on how the OS may choose to configure things at some unknown
point in the future"


~Gregory

