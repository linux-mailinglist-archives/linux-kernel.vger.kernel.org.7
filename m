Return-Path: <linux-kernel+bounces-768992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE02B26904
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D599603921
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361B302765;
	Thu, 14 Aug 2025 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="HqNTK5ll"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC323019CE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755179981; cv=none; b=gRfh0Tgn9/plCFg4DfJ1Y8shQ5kxkXZ/aXaCOg1KJ1mNIlRnaLMj3BkK7bo5hjm5rxi7cLMdDh3HmQphhiyWozPknHOYaosrQIfNQ+yAEOE3LgYkjPasRi54PxQC1DONvHhtgpxs//NcEvBUGvur0/ZJTiFIKcaD4HNoDjPN088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755179981; c=relaxed/simple;
	bh=9KWEVeZjJNSN74aHWXDtP5EgYDEloLv5b0CS/iNdd84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zxn41Y33U0BmqF1bw2ad23BJoj3hkS6gXr37crnUObQKsyRhs9kGHjmBFjYCUw8Z4DcTfPbfwDfpa20xQ+I6fbf5ArJ9a1Y7WOWzVkkzC4DIV2GGZyjBodlNJ+zXJDCMABGPwxxlcqOwIMyU5paOpeMaSnhAQOd+4dbPYeZZz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=HqNTK5ll; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e864a60b26so227965685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1755179977; x=1755784777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbHoxH73V7s6W9eMph78SaxPK1+Tv1/NM1bGPx7Srdc=;
        b=HqNTK5llvm3guD4ufiiVw1VSe3v/KT7D/+l2Ery0fTniP645q/odpLp96C171cKQ9w
         M8Z8WsCXt4c+yap/y2HqJk6tfLMZPEOiFMSK58eWCkQbkOFdIy+HUXhW9DGFQpknsJjZ
         yWzEVNAHRBaHaZntex86vDMmfzm0mjnQ8klGysn0f55xu6qnvF+Bb8RnaQQy0PJL7kxF
         S2GQIy2QDiOGQPd5s+7Xo7emo6VZY9vDNnNt2ZikPDAu/C095xw1u2JlhmSCWHK2UE3X
         Zm6bqCiROYXFLxK/bTCgrmvQsqFTYrKLGkOMPWNCoj7Sjm0T9ooRndcZLipyvn3JVklW
         yayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755179977; x=1755784777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbHoxH73V7s6W9eMph78SaxPK1+Tv1/NM1bGPx7Srdc=;
        b=Qks400itKqee2y16PASjDVvpKipMG4a7LkO0zHGWA6gBsD10W0LMct2bcLLkD3xz4e
         Kar/fQ2lqmJz0uqU/IdlzFilVK/qFENtwohyrRyCrOesUVyDaYHnoZcXp5TGYv4eMSJw
         NqBcDLpsntWjD2LQS+YOp5CRJVXXgwTm29YFM3LRapbnuGahcUMC01FrI681jelXq1FF
         yqAdPG4XzFtWqAb4j0W3gYw157UmbwtoIZaXc9IMsTMNQi375tWSqKyIXLAjcEMtya7x
         o4mnfr4qcoyfPfT1aUE/ICG1JbrmcsRrvDP8rMaq+Exy60zBMDHV3ahj3Yf7UoedC+UF
         AEsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9f1YyMW/RON6zBNdtEk/ihqXm5UDobgaaM7nl8wMEcxsHE7Dv5y4GiH20Sr9gvHrC1SBdf+LC2Qv275E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+RdB8b1MXLaAXNNtGYs4UGbqHOqzopSMWr0x0ailhNXusPMd
	hA3++VIxlCXGJUE90GIn5ytpgsJt9jn7yw21LxGdGhhfSj/PrNDTLQ/AdDku4aIqpqU=
X-Gm-Gg: ASbGncsswstEL52fTVa+0RDkuzs4/C22jA/1YBjAjCrnxgWk/UjECQm3K5s9PROtECB
	7tgSsVGqjBSc1RzpXEFILkQGyra3uIAEPPvMAfpgyDE1Zl1BZlRRwETYOMYE1ucu88WSHZ8ybpu
	ATlBapsx+0v/E7StNDQMV5gbq72fzUzuurJVlzbS27/19qDom5HIScTEWA9B52qyvx9sgda77h5
	3hqGz6UWdY2OgZwuo4VH7tNi/UUW4ONg2vY9eDdj/LwbspIUgxQXsVlbqybwb85869dv6DwDjwX
	jKX+typvZeFjuXZFIoqgXF/UqGQbecayMwJ/UCy2SUveSRtCTZ3T1Nc5Bm8ZWTO9Gsn/SHz1bMo
	lCCcAHghFg6qstcYtBK8yZg==
X-Google-Smtp-Source: AGHT+IGgT0lxT+d+8p0uf2Z41Idd/2JXPEfNrQxu89hzCFLHD2rzpfmxmJQ2s6A4zRqiOiv+t/nSPA==
X-Received: by 2002:a05:620a:410e:b0:7e6:9bc2:6cb8 with SMTP id af79cd13be357-7e8716b2ac7mr381795385a.2.1755179977385;
        Thu, 14 Aug 2025 06:59:37 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:929a:4aff:fe16:c778])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e69716fa4asm1895103385a.58.2025.08.14.06.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:59:36 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:59:35 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Ye Liu <liuye@kylinos.cn>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Remove redundant pcp->free_count
 initialization in per_cpu_pages_init()
Message-ID: <20250814135935.GE115258@cmpxchg.org>
References: <20250814071828.12036-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814071828.12036-1-ye.liu@linux.dev>

On Thu, Aug 14, 2025 at 03:18:28PM +0800, Ye Liu wrote:
> From: Ye Liu <liuye@kylinos.cn>
> 
> In per_cpu_pages_init(), pcp->free_count is explicitly initialized to 0,
> but this is redundant because the entire struct is already zeroed by
> memset(pcp, 0, sizeof(*pcp)).
> 
> Signed-off-by: Ye Liu <liuye@kylinos.cn>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

