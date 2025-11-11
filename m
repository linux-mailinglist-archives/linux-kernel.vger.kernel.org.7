Return-Path: <linux-kernel+bounces-894737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C26CC4BB96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F4573A1FF1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 06:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7AA329E73;
	Tue, 11 Nov 2025 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="N/h4ahcN"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20628329E6A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 06:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843550; cv=none; b=HLP2NDYpGBH/tCfWOgvfeq8b36VERU/+fE7XvWKwm5L7H5Lt0mwswewFJ+9TiKdXEB/f1bBfFRjMhgcwF8bUja+dME5oBnEgwVsS3oqPGRtVCB0PR9+YfOCdvlrajexWrVwK42WBkbqxoQWQhkToa8SeGwhUevAjWT+/o/zJJx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843550; c=relaxed/simple;
	bh=WkPIBxcEOHQ4ilXDCjPP5RJCUvaILWDuUwT419tOHBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8i4FkD3s+LgIBzon7q6xLc4e7xyyLMf3G+QtZ/9vviVIWQxezDA9fSV63/HleEGroiqgAbbK6uooKpFMTLs5/w5jx5FoR8QmYyP7nimCr3cnTQjkCsHUQoKP8KnYnQ0yXR5Wlvt3e5ZdyxsqDtDtnsYCh8NLoUNqHdD+HuVrdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=N/h4ahcN; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f67ba775aso4585635b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762843547; x=1763448347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl+GLucGBzlTLWjtZq9oz0wfi6xtPX0PrTL9GqsnyOc=;
        b=N/h4ahcNfF3R32arEM1F6gK6BKI61NUrq+t2EjyJbu609ImOvcQ00jNeGjjFIt9k7C
         trWk1hM5sFB/bmvIkCMROgjK4tc2zNe6bEmlssdSp8C914tmfItN7q/FDqzyYTllMKnY
         JShRnaWBIhG3yigb/oVcchHiucCzwArWrc/tBqcYEpMWhqiV5HJgIKxaNys+OjDihhFy
         x6JoBY4jR9y1bDIGSMIkCYVlqveQexUdM6B+kVHeJBwjmgjxz6thtrGXDhGhnyTDzCYt
         n586VZ0pA0Y0DdQXWmEH4q8kZ725vFOwLp3Nnajc2sxuGrXlaL+rCIEVryYjlEmlOIX/
         BBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843547; x=1763448347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cl+GLucGBzlTLWjtZq9oz0wfi6xtPX0PrTL9GqsnyOc=;
        b=m11kF5zV3rbcm/Bqj6+nPWIER9bIjuMamDbhJBXOZu+V/jKKrIMY0QfRNd+JlENckK
         ZFtg+Irx4c/si8o5PIaLRAI93oXg0eSNDwfQV8DjAQJo8kRzrfdOoVfKUfHoiqUtClmH
         atqgfnwRzMEg5U5zxtQQZnzlpMckQxGmAJ/wZCZ5EZYrdj5w769p/+63OwAn4cLvWKeV
         alq2T16fDtEP8LBoOzJDnwXQBiUEqZEBvJA2aGZQhsVXsV/SZJoDqCKjAowf5E4KXE+0
         4kF5EBLAHMXVTVXpQGCwvt+41bGDB6YT0oA5XOQYF4VNlB6vcBnAZgiWR6UXOyWX0S75
         2Z0A==
X-Forwarded-Encrypted: i=1; AJvYcCXD7i0XwmairEEGFovX35o6Zq3+GBWuVF183mUjMeU6iFrDiNh6aBaJNKltw2fg10uQkS1X5rNwkDSmfKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YythRPL9H2mFevvTgPcx1Iiw7nyJ1gpMWfGEqQD0AaiM1mFcYnk
	QrLblqr1s6OB92Xlweltt6p5TRcqn4kbHBs2VNIV8SSXwEK/3G4dBOs4XzQ7NwG2IrE=
X-Gm-Gg: ASbGncv3AKzHBfXckZJBFIGHYiadH8F10PGCO84Sg8MthDHbZmo4Go4tZTUXgMbllJy
	uQWVr4qahPHjUSTS9TiHQnOCH2kCy1lhxJwhR5Hx6PUhnhnuZXwv7FLg3rjZcDRveMkWBKor7OO
	eaNNZ84/DrUTVksWZg2r85cPLZkdYgmC2r0Nhc6kAfLBnegiIskWJAi7dvKyFrxMkEXvD4n4oHa
	hjSIk1k0YXnVz28ad1ZV5vFv4/vfuRk6VLudUuoqTah4tLkvKGBvurvfDUBZQ3vRG2y7J/Dyf/D
	W+SvFbi5aq3NRlFnsdX9ZJGmwI1SN617CtHHqoGKOompQsuXqDIM16o42apSSKWJUrWDBh2y+Uk
	nirUFnfVGN0z+cJawInUg8e2zHl+pkL25zpeJehX5oV/2RSmskkKIoVYNc/dWBUN825ohrYfKT8
	+OOMpn/FbPbaQ01Q==
X-Google-Smtp-Source: AGHT+IEicHLSYzdwynj4I4nc/MYN4IYvIV6/LmFIMqRyJaOIQeaa5JTA6robs499AmJpzGJRfdsVew==
X-Received: by 2002:a05:6a20:3d86:b0:343:3d3c:4685 with SMTP id adf61e73a8af0-353a1de1402mr13983796637.18.1762843547462;
        Mon, 10 Nov 2025 22:45:47 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953e791sm14370759b3a.7.2025.11.10.22.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 22:45:47 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: chenridong@huaweicloud.com
Cc: akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	jack@suse.cz,
	joel.granados@kernel.org,
	kyle.meyer@hpe.com,
	lance.yang@linux.dev,
	laoar.shao@gmail.com,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mclapinski@google.com,
	mhocko@kernel.org,
	mkoutny@suse.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	tj@kernel.org
Subject: Re: [PATCH mm-new v3] mm/memcontrol: Add memory.stat_refresh for on-demand stats flushing
Date: Tue, 11 Nov 2025 14:44:13 +0800
Message-ID: <20251111064415.75290-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <7d46ef17-684b-4603-be7a-a9428149da05@huaweicloud.com>
References: <7d46ef17-684b-4603-be7a-a9428149da05@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 11, 2025 at 9:00 AM Chen Ridong <chenridong@huaweicloud.com> wrote:
>
>
>
> On 2025/11/10 21:50, Michal Koutný wrote:
>> Hello Leon.

Hi Ridong,

>>
>> On Mon, Nov 10, 2025 at 06:19:48PM +0800, Leon Huang Fu <leon.huangfu@shopee.com> wrote:
>>> Memory cgroup statistics are updated asynchronously with periodic
>>> flushing to reduce overhead. The current implementation uses a flush
>>> threshold calculated as MEMCG_CHARGE_BATCH * num_online_cpus() for
>>> determining when to aggregate per-CPU memory cgroup statistics. On
>>> systems with high core counts, this threshold can become very large
>>> (e.g., 64 * 256 = 16,384 on a 256-core system), leading to stale
>>> statistics when userspace reads memory.stat files.
>>>
>
> We have encountered this problem multiple times when running LTP tests. It can easily occur when
> using a 64K page size.
>
> error:
>         memcg_stat_rss 10 TFAIL: rss is 0, 266240 expected
>

Have you encountered this problem in real world?

>>> This is particularly problematic for monitoring and management tools
>>> that rely on reasonably fresh statistics, as they may observe data
>>> that is thousands of updates out of date.
>>>
>>> Introduce a new write-only file, memory.stat_refresh, that allows
>>> userspace to explicitly trigger an immediate flush of memory statistics.
>>
[...]
>>
>> Next, v1 and v2 haven't been consistent since introduction of v2 (unlike
>> some other controllers that share code or even cftypes between v1 and
>> v2). So I'd avoid introducing a new file to V1 API.
>>
>
> We encountered this problem in v1, I think this is a common problem should be fixed.

Thanks for pointing that out.

Thanks,
Leon

[...]

