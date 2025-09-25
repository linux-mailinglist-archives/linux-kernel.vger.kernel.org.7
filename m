Return-Path: <linux-kernel+bounces-832742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C343FBA03C7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85A05E72C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622C2FC02B;
	Thu, 25 Sep 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="kDBjylKB"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813AA2E2EEF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812946; cv=none; b=H0BghSay1Ov+j9MbUn2hFRolrTZvizd2GfanYfeZsav/hb0iuRhlPA9GuXLYxdXct2p8JSkszwlW+hZA/frj2tiAPKi3jriVE8mm/FCXwjXsbdKWIZ4P3+/oK8Le4C+mlFzJippTeLIXZ38eNX3QFhwdcAIX7SOhosE+BDVWdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812946; c=relaxed/simple;
	bh=tBuMl0JL0XljNmjIHt9b311mx+KtGMbg3qOUZStmOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQCwjxHcH6raYgGtx1076cfovfH0giQsT6xq1HHnmu7KQ53vG6hjnm0mEFukPJ/HjMvJ5ks21I5LTS0Co1T6RTj0pVRoYOacMSBm5wxfE8mtjLgsKk92Vp7tw3csDjeSB7wKm9Zu6V+ECXYy196mY5oguNxYv21ick2ZMYQoU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=kDBjylKB; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-424b20f8b7eso5885735ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758812942; x=1759417742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mYDLI5mwI4uh21VH+pwIKDtJ5bbVvmfXzJZa+QgeupM=;
        b=kDBjylKB95mENxVrLvDvwXPv+CpFH6Qm4NWrKWiGNvA3r9PxmiYJnW/MLNPvRBQ6ZK
         BMslkO/j9NK3dPfkwNaJ5lUEaTutfJS5KxbfPnFwI8i1EgYWyMqDp3OmRXr6EXQTeiQ3
         0E+xPDSy7DzK/2CgTSoypjY8bi7S7t1Q4Uie0kWOJgGL+SPpXt9A9pGB4/kyYideXh9/
         E1ieE1AYkNb8PqZdEmK68GQRHI781VL8iALRw9OWUCqnyMv8vCLjDGiw9uuADoefr24G
         9yYaY0mwX8nROSrlG0c9uo0NyXRdmLW6/bDs3Yf8Dd4aMtDMZvEUHTGUBpGqUrNFEhDq
         KZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758812942; x=1759417742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYDLI5mwI4uh21VH+pwIKDtJ5bbVvmfXzJZa+QgeupM=;
        b=FcRLeJvWFnj9f/8FFgQK45PjjvvO5pJ1LWJYQCcCsByPTXr5cPp3U/u4ehTboDCny7
         KIERkR0jy+kDoYCRtM24u9tDty6fuc2z0PD2mXYZPHQe+dTFBZim8tTLuT+Tp3O011XM
         WCKMnihsYQuC67jnGU881FI68ilC+8aTGxxZLzU3pC0papRikXCEiNWuWlMEXERjt6TB
         zYjZ4VW6N2HiMWKF2t6BTrFUDjSeDEgYSbU5YvpqRDKa5Kij6Z7vwA19rmYngWgyy1ln
         nEyRXFXOUSEU9MyaLxHfs9YUFnttaptUTJ3TqF/ZJIz61UXNrK8xqPV1T2FuodIwyhYN
         IJSA==
X-Forwarded-Encrypted: i=1; AJvYcCXRrXr2aSy8VdBBu4PZs1hG2JqofRIT8awE9ykQS+YzKp2qc+aR4jHEnz0CBFzxSp4wlmDw53H5IkSK3A0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhNXEaEpKmiziIZiTQvm304ReQ+oDtdyTCa28UuCQcfzLhgyz
	QjLZzFNAUY3kCfuyoEvR9sAS/m8BoWk9bncwMjEcKuERoL4nEK+iEPiOlpr3OYnjbxw=
X-Gm-Gg: ASbGncvGDcyoEVLTKz4U89UBLqRA9xwvST5Iqb4Tg1btMkjTF8qQnbkGrAnxfkGm+Z4
	nJRQd1G9pq275JW3VToxHyl6d5nNBWo5W0UBmr+dKIxshgLry7wfEXyVjOQS3bPAL6GQSC0ydJF
	jg7d8gUO1v33KqM6T+ZWC8aQDOc91dJ8z2kOrSj4a4MpjzUwRBr+B/z7lvMW0tXJdubFO2aZEto
	PpeiFsM/iHOWRnIe555jJws9CGSDnaOyBFIvA0DV86CruJwUHo/Ox4NVzHF2vLt4vcjTmxLtHyw
	fqKJrUJGbKeHWZztH+AoW7USS3/IcQAkcvRL8yyS1HeFnTn5Si/9dTMLaPo6nz69G/3TYwjS8ZN
	8g26TvddEe9YZF/gahtL5uGucjoBviTc5TxCR5f6npSBYCiFsirbadhgvj1g4Tnm4KRM953ZjEP
	4=
X-Google-Smtp-Source: AGHT+IFJCD646Ie93Dsteh+N9Tg3N9mTKfy3p3JlRRzccID89obtfshwZ2kYW8ICweprqMFS2clcTA==
X-Received: by 2002:a92:cd8c:0:b0:425:720f:deec with SMTP id e9e14a558f8ab-4259566e447mr49602485ab.31.1758812942274;
        Thu, 25 Sep 2025 08:09:02 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6546198fsm878831173.21.2025.09.25.08.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:09:01 -0700 (PDT)
Date: Thu, 25 Sep 2025 11:08:59 -0400
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
Message-ID: <aNVbC2o8WlYKjEfL@gourry-fedora-PF4VCD3F>
References: <20250910144653.212066-1-bharata@amd.com>
 <aMGbpDJhOx7wHqpo@casper.infradead.org>
 <aMGg9AOaCWfxDfqX@gourry-fedora-PF4VCD3F>
 <7e3e7327-9402-bb04-982e-0fb9419d1146@google.com>
 <CAAPL-u-d6taxKZuhTe=T-0i2gdoDYSSqOeSVi3JmFt_dDbU4cQ@mail.gmail.com>
 <20250917174941.000061d3@huawei.com>
 <5A7E0646-0324-4463-8D93-A1105C715EB3@gmail.com>
 <20250925160058.00002645@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925160058.00002645@huawei.com>

On Thu, Sep 25, 2025 at 04:00:58PM +0100, Jonathan Cameron wrote:
> Now, if we can put this into a special pool where it is acceptable to drop the writes
> and return poison (so the application crashes) then that may be fine.
> 
> Or block writes.   Running compressed memory as read only CoW is one way to
> avoid this problem.
>

This is an interesting thought.  If you drop a write and return poison,
can you instead handle the poison message as a fault and promote on
fault?  Then you might just be able to turn this whole thing into a
zswap backend that promotes on write.

Then you don't particular care about stronger isolation controls
(except maybe keeping kernel memory out of those regions).

~Gregory

