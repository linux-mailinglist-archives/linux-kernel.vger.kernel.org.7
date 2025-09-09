Return-Path: <linux-kernel+bounces-806994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 108F9B49EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFE563ADAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAD51FDE22;
	Tue,  9 Sep 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QqUJ3SFb"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE716DC28
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 01:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381011; cv=none; b=S/7vYISOnH/+tWMFsB9ZO02tDJuDFiY1lIMvDK1JS5Y3TxesotgazUadB6s7gojGiFu6ZicL2eg7v3Pk44e5SteF/0/M2DP7T94WDdBVAjnZ3tEgo3FX9Cu9pyWXUrAMHR04y/AcyRed6VyyAxhTOaF7wl9Q3NtvzzcFhyuwcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381011; c=relaxed/simple;
	bh=dxQnt+7CBxyl97xYuwXpB50RBcR4Snd1Uk8o2E824vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kz1053AG9fL/cUiDth4d0mQ6TaRcDu0UCCEiMKydUzRH/LaaSv6V3eHtaXePJlxfBoOtlx/9XL3gRC9Ik0H0PYcvWIhzGn/8si/+v0LtJlw+WWfQuYl6LR05/JhN7NoBqm9E3F9cdx8mKQunsVLmo2bGMuz5NtwaYUGj7C1OTPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QqUJ3SFb; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757381006; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GHgu7bGU8VfXyd+HzV6SLHKhlj7OaCkFpfBUrWEKbn8=;
	b=QqUJ3SFbCg/EkSmLFuhOt/Brcne9mM2JzVa3vcYxyDpKmcff7RBGvYEBIQcCx9adKx8XDQD5DYvdIHkMErtYwaL3/omc4WOas8vMp4Vpks6qWJA3pkcPecnAKAQDZOl02RPuH9jBMQcbe4tkAYnk6gQhcnyz1yCSmWISfJ/FvSs=
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WnbnEyB_1757381005 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 09:23:26 +0800
Message-ID: <5c31c9cf-c616-4f05-a27b-68d09f533973@linux.alibaba.com>
Date: Tue, 9 Sep 2025 09:23:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: add Lance Yang as a THP reviewer
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
 Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>
References: <20250908104857.35397-1-lance.yang@linux.dev>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250908104857.35397-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/9/8 18:48, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> I've been actively digging into the MM/THP subsystem for over a year now,
> and there's a real interest in contributing more and getting further
> involved.
> 
> Well, missing out on any more cool THP things is really a pain ;)
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Cc: Nico Pache <npache@redhat.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---

Acked-by: Baolin Wang <baolin.wang@linux.alibaba.com>


