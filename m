Return-Path: <linux-kernel+bounces-720066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2ECAFB697
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E23BB0B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC98F5B;
	Mon,  7 Jul 2025 14:57:24 +0000 (UTC)
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA071F09A5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 14:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751900244; cv=none; b=UhFYlJe8NMXC2xS1aabLiTxME4/r4mfow7GO3gUHa5dLng2NSGdssSuUaC2C09UaDXTf+YDkYhaSMS6x5s6/8PIybFL2KQp8tooRYcSG2Gem6k4YAyYIlj1n19iaILo41wgMAf5GgcxXgmS3RTWxVDWyxFtU1B4f3UIyFIdd0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751900244; c=relaxed/simple;
	bh=0UIKw5gmEjwyyA7FfK9Cx6CzQyb9bXPCu2/K/byiSkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHGJSmdS0f106QXqgJzQfFZGR/MyBRrl6hQa3azgNLeOQx+mk2wrHm1UbKPd4JEpHGLuONSvZ8CS0eA8bQ74+teK8zYRt/JyZJOKDya9WBpy4cyZH4PfnVGYl/nSN4Hjwm3o6KMfG6S69oxfjXWTD23KyBGGizIGqLuPeCo0QL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 7 Jul 2025 23:57:14 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Mon, 7 Jul 2025 23:57:14 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, chrisl@kernel.org,
	muchun.song@linux.dev, iamjoonsoo.kim@lge.com, taejoon.song@lge.com,
	gunho.lee@lge.com
Subject: Re: [RFC PATCH 1/2] mm/swap, memcg: basic structure and logic for
 per cgroup swap priority control
Message-ID: <aGvgSjccs7XjM5pf@yjaykim-PowerEdge-T330>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
 <20250612103743.3385842-2-youngjun.park@lge.com>
 <pcji4n5tjsgjwbp7r65gfevkr3wyghlbi2vi4mndafzs4w7zs4@2k4citaugdz2>
 <aFIJDQeHmTPJrK57@yjaykim-PowerEdge-T330>
 <rivwhhhkuqy7p4r6mmuhpheaj3c7vcw4w4kavp42avpz7es5vp@hbnvrmgzb5tr>
 <aFKsF9GaI3tZL7C+@yjaykim-PowerEdge-T330>
 <bhcx37fve7sgyod3bxsky5wb3zixn4o3dwuiknmpy7fsbqgtli@rmrxmvjro4ht>
 <aGPd3hIuEVF2Ykoy@yjaykim-PowerEdge-T330>
 <nyzhn5e5jxk2jscf7rrsrcpgoblppdrbi7odgkwl5elgkln4bq@mdhevtbwp7co>
 <aGvdhXFtVDR60MMn@yjaykim-PowerEdge-T330>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGvdhXFtVDR60MMn@yjaykim-PowerEdge-T330>

On Mon, Jul 07, 2025 at 11:45:25PM +0900, YoungJun Park wrote:
 
> $ cat memory.swap.priority.effective
> Active
> 1 10     // this is /dev/sdb
> 2 5      // this is /dev/sdc
Please disregard the "Active" line. 
I apologize; I mistakenly included incorrect output.

$cat memory.swap.priority.effective
1 10     // this is /dev/sdb
2 5      // this is /dev/sdc
 
Best regards,
Youngjun Park

