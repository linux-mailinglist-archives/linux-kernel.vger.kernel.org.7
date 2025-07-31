Return-Path: <linux-kernel+bounces-752480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE467B1760C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF218C3A96
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 18:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C623312D;
	Thu, 31 Jul 2025 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="MrlUmbxH"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B6D219ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 18:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985797; cv=none; b=s8q4CdYPrWVSJ00syU5NzYKj0usqCkW2Aw7ntqo2Hi5THlpVk6s/ZVQrkcw3Cdvd49oK6Jpt+iyRzC5PbCgKiMvbcgllqJszYsFqAvwfL/0aR6ShqrslVQ++iBjH2AdrYoUS4O0aOwKTt7Z9UUdB2LwBrmLasRYXDSSVa/JlqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985797; c=relaxed/simple;
	bh=EBQ6Az+qE+LhBl3FX1g/IThTKFf6d6bBQNJQOO+PrKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXZxF2s1mAXQ9bSVlsz43ByLgO1+2S7K9Y5Tw2evMAPqSK+o36x65BSe2XFhpV+T6NwL6BgeLqxGWViBHKt08ej+dD5m/9zQgpOey0WvBSMZPymFpaF2sJoE3LNIxcBWWE1hqdhGlIcazpDk+gFs3QHPy1Rd6lKVWRL/Hk1dR9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=MrlUmbxH; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4fbfbda957fso270714137.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1753985792; x=1754590592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zNycq62jXW8tjjm44f5hhjhcd4tsXOjyfLo6mreDnWc=;
        b=MrlUmbxHJcuSp7MUvsj6AakqGpEHuAVFVfUIsweDrzb2vpnzGK2l0+G+kPU1ssWmu0
         FS8/qItn4Iiyjw7VeWaw62P9ynl7Pz+BgNwRyCQAwbuLUxNHtmLX7Jlush+G9l0DC6hb
         rm2PgZDx+YbNpn+TJ4BmzjD4USOU7wdnznal3v4986BQi+USjuYS4bnMRFPduTG/ls6W
         sjfIkixgA6HAwEXYI9JsbfrLKwQWU9q3dn117sKT7MfE319KBp+gq+gqoDtlg1KEdyB7
         L4449eCYlfTlBJad5l/Wk7xuhr8HWaX7PX7bcI2FUeWtSyt3mdrtRqrftJUzIylstvxi
         1fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985792; x=1754590592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNycq62jXW8tjjm44f5hhjhcd4tsXOjyfLo6mreDnWc=;
        b=CmBhtf/UkodbZWHnpWt+OV9KQwtHHElGzF+SuQ3IRgrYV1+VpQBb3OtfyxxJSpEo6d
         kMD1lVEm25538WOMUUvjvDujVQUXMSSvE50BBak6u3E+MiXAAHSZslgweIDqQ5xRBX82
         USX2KWSt+7ue1H6QsqzUP/c7YtvF8liNup0wtgEcwtkqSJ+b+lNF6MD4BUPfS5iyn8FH
         UDW878beMvjPii0b5O9UgTTCrZzlOSVrCq3j3apS1kYeFlWn6LscQ0IY0AfAONgDXiNT
         0UrE/lqSK2iEZ7ilNhKvCYI4tSK1BDwYRd1gZLmaQLCD6QGoD/F60FPC+6B8yK0yIPk/
         TcmA==
X-Forwarded-Encrypted: i=1; AJvYcCUrrw3KyziXzXPfMG88PtnGNBPIY9QwcaiXozxVShNYMt9RCw1J+/EAsmm9p448NhcZWNKd4ZB26eSKmTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzI9tuwp6NiXC1w8gU7qsycKNKxMtxqtz711HvvouwvIYrySnH
	fHvj8X4oXJ/9+HpmGXfxI4NdT8iAY8wSqmhYB15fT4dstkNi9YtdqAFAWjV6NSZCUC4=
X-Gm-Gg: ASbGncsHzJ49QjmAB/PFf/PaeS6tT2KjWH/MGHLP+FBsmxFzF/HCbKRuq+qoWHcfWAc
	Ipzz5SKosa07W5vVyQv9cfxWDAkRL2HCNYHunotaSmBW4fJ6sGoF6KDGdSBfzsmxG+5H6/ZV/eu
	IO4f2SvIyVbObN/B9oLoGZ2yZgxA8V1kxWdknGzYZKAznfh4KEAwhCp3de8l2A0odHymnDLoX1t
	z0IsxTr54CFi7qVlj5yLb6meCKuhcxVzH3XxS+itiTfRkdjxRk/pkMkr+C1Y0OOf8S/Jyj+4tnZ
	kTLFvD5+42HcifolpvrmiJVWzU/S8N7Wbc0Z+e1sq5xg/OgsLFEhmGcw1rIqd8yin/L9e5tIqPo
	wSrs+Npgki0AP7dLHxAaHQoSBNGopC26Y
X-Google-Smtp-Source: AGHT+IGiF90gF2ac/IfeIfowe0tuCQyzVITlmCw/gArMykn5Hp8a2pCzf2lGGHyC9wsGOMaX2cNeJg==
X-Received: by 2002:a05:6102:3c81:b0:4fb:dd65:b97f with SMTP id ada2fe7eead31-4fbe87dd1aamr6014065137.23.1753985792451;
        Thu, 31 Jul 2025 11:16:32 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7077cd69b86sm10763916d6.42.2025.07.31.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 11:16:31 -0700 (PDT)
Date: Thu, 31 Jul 2025 14:16:30 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, Takero Funaki <flintglass@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/zswap: store compression failed page as-is
Message-ID: <20250731181630.GB1055539@cmpxchg.org>
References: <20250731152701.GA1055539@cmpxchg.org>
 <20250731170922.15509-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731170922.15509-1-sj@kernel.org>

On Thu, Jul 31, 2025 at 10:09:22AM -0700, SeongJae Park wrote:
> On Thu, 31 Jul 2025 11:27:01 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > So if compression fails, still do zpool_malloc(), but for PAGE_SIZE
> > and copy over the uncompressed page contents.
> > 
> > struct zswap_entry has a hole after bool referenced, so you can add a
> > flag to mark those uncompressed entries at no extra cost.
> > 
> > Then you can detect this case in zswap_decompress() and handle the
> > uncompressed copy into @folio accordingly.
> 
> I think we could still use 'zswap_entry->length == PAGE_SIZE' as the indicator,
> As long as we ensure that always means the content is incompressed, following
> Nhat's suggestion[1].
> 
> Please let me know if I'm missing something.

Ah, right. So if compression succeeds but the result is still
PAGE_SIZE you will treat it as failure and store it uncompressed. Then
PAGE_SIZE always means uncompressed for the readers.

Even better.

