Return-Path: <linux-kernel+bounces-892363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91784C44EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E603B0266
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A601A257852;
	Mon, 10 Nov 2025 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="av5QdGqw"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5D8485
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750174; cv=none; b=lvOK5TTp+Ar56d52blh6dy5fMpGVO1/Wkq72XGWaH3OdcTL+CMytuCoFlxDm7VRETTlH6NeE27BYY6+MQ3pq2EN1XVnSoALWcoKsHFnd/zQZYPgIGAE/jQqYQ57MmPuLRfGotzxnu5O53rMdniZTrKDypC2EtjyLF/QG/1BkPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750174; c=relaxed/simple;
	bh=JJrfHDLE5lDw8HoUWCOGU+LDxN6zZNc3/zArvkGfYpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwR51lnbt/3OtLXSwSi5SOIM7TQbNubIhgE5bdZG5Ls1ojtnzy4LC46BU1MFyaZdRclZz44ekwMLKNUG3gh4lltfsWf9cUUsncDV1Mz4ONer42wuFffJjM0yUV6X9umnV5Vb77Rs6Ciy6VY/xvpQ+Oxofk7SgaxZRZXe131wQXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=av5QdGqw; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-340bb1cb9ddso2006342a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 20:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762750172; x=1763354972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJrfHDLE5lDw8HoUWCOGU+LDxN6zZNc3/zArvkGfYpA=;
        b=av5QdGqwPYUO2zSK3VcL92zqYDt0Ngw04kbuF15dA0MagLBPwNPpbSe93rZd8bpay1
         6COOOuhwTXoAvfP8eeN0YBipWsMUud7BwWcgumjPHlSpKkImTRYcj9nAw1w8f8Q0ZB0L
         h48JWkV/2MvCDYdYjz4wxVGqKo5xMafun/ekk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762750172; x=1763354972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJrfHDLE5lDw8HoUWCOGU+LDxN6zZNc3/zArvkGfYpA=;
        b=wpcwbvaowSKfItR/1I3zUuSgymVWLs3bMPnyAV3iWPg5etLI0y7xlvWXA8C5tMAwuP
         WTM5fosTwLnZsv5xEFEWWzYrPjNO3UCbfu/dAtBWw9XFgRsba2PyamP6OUIolGs7BESY
         dYpZTNcHBkLo5hPnL+6WIOlhbt+NJu5eg0GNHV/6eAe0MNcMkDfWQZMIfoo9sL7jF0Dq
         N55G1M9hUGU1UvNfEATL6SnbaiE075gbJZOBfm+5FdXjFSgwE+1nG1sVjxbUia4gywJI
         JsTR5O9DpAWLcqUWnhs55i9R8Aau2h9UBeqKho0lq17Bpt6e5nftHtAl9w5cDFyJhRDW
         wEew==
X-Forwarded-Encrypted: i=1; AJvYcCWxZpUFwxgQq6Nj9j9cv9ItG8cRzCYlKAiNfJcZNu2ypa2MtOgxqteMuU/OnKAcg7q7YC7ecla5UNVetBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYTtyieoO+j0ukmI6bACk3/38udiIas6s4vLsKDpchBBeBgwuV
	K0kuh6P8gkTFQVH2N2AMOiQiq4RN+vHQMJJjefusX2Yw4L1O00f/Vb7DuwPs2yv1iQ==
X-Gm-Gg: ASbGncvHf64EEjx48FuCOKLYxobxxYLzJbFk91IhwxZXbcQvy/6S2BGXtXucAegHLNi
	s5PiNFL+Kztf9lT6tXtEYnyQocwYhrEzS/xzgdYnr5mbnqoVQItq7GB4YJUgGiBtovt45X2sUY6
	/dnpaGI5VpJApBo2VN02EKXaJocNtNEwUmFGqkDGVwby9DntE5husBCilGCuL0HDijDkh49H4Mo
	HtATJGncpqGNcCR8gsxwtxEXJm1MKSYSYly5MIxX7cG+i75MTq81Z/EKwmC8iGvQwgcTZqEFlj/
	roYU/yMxY5rcj74OtAt0bZ347tiCWbE8WEwLRd+jVxZZ8keIvaAiYj0jHvxT/EgqpgkgO2NbsTv
	uYwrBlHJvzLnWJWnMRRfmwFm+MTvHNfNlUCUkCXMEk33873G4ir9bnORY7jockwrRF0JxfI+DkN
	Dpk1k9JQqokriMBPU=
X-Google-Smtp-Source: AGHT+IFU2CaJomS2LyBwnHV14ftccCZxEQuCF/t81lUe+RkW65j+E/MggTuG8Flk2e7EBPHiXfOouw==
X-Received: by 2002:a17:90b:2d81:b0:340:c4dc:4b70 with SMTP id 98e67ed59e1d1-3436cb7d916mr10393716a91.6.1762750172021;
        Sun, 09 Nov 2025 20:49:32 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:f189:dea3:4254:ff1e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17ad4asm10139624b3a.37.2025.11.09.20.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 20:49:31 -0800 (PST)
Date: Mon, 10 Nov 2025 13:49:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <yv2ktkwwu3hadzkw6wb4inqzihndfpwb42svuu25ngmn6eb7c4@hclvcrnsmvvk>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

On (25/11/06 09:49), Yuwen Chen wrote:
> For block devices, sequential write performance is significantly
> better than random write. Currently, zram's write-back function
> only supports single-page operations, which fails to leverage
> the sequential write advantage and leads to suboptimal performance.

As a side note:
You almost never do sequential writes to the backing device. The
thing is, e.g. when zram is used as swap, page faults happen randomly
and free up (slot-free) random page-size chunks (so random bits in
zram->bitmap become clear), which then get overwritten (zram simply
picks the first available bit from zram->bitmap) during next writeback.
There is nothing sequential about that, in systems with sufficiently
large uptime and sufficiently frequent writeback/readback events
writeback bitmap becomes sparse, which results in random IO, so your
test tests an ideal case that almost never happens in practice.

