Return-Path: <linux-kernel+bounces-740124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D9B0D03C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962B07AD9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37B51E0E00;
	Tue, 22 Jul 2025 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvHfKaRF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB512E3701
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753154594; cv=none; b=W/BSG71N9Ev5tVYKhQuJnhkiigmjDJjZS6kwfvXrpBWYHb0nAWIe9fcfjuBp6BAKy/rz0eJxFqHmMskx871LC5McAVkjUzR95fLiXmdF+mOJOmsvc/I2fsEIFUeaD6QfyCKnt7DmL+XjElZWfwcydC+vy2LoZsx4xcnbrISG05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753154594; c=relaxed/simple;
	bh=rasbSCtf3ZnDTfKVaTPFITyxJrXdlKaNEMhjk6bM/Bo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dV5wfb06jQ0+xb4qQjI/5VfbaQPaAtZA7QEPhX/aniR/l2qew1O0AZ8C/DZ4fqYl98L+VehVXA63Lbavi0jOFnEjOsmJVD4EiGzgOk5fkHXzUl23FGahZQ35vC60PXLHE0cDCqWkmecQ78f98yNT3vFz2NVVqEDSZaAX8A32c1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvHfKaRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB8BC4CEF5;
	Tue, 22 Jul 2025 03:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753154593;
	bh=rasbSCtf3ZnDTfKVaTPFITyxJrXdlKaNEMhjk6bM/Bo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZvHfKaRF327jY+GY+8E8JrQIm4ANh6EA4Ke3TDOEpfXJ1p9WJvODo02AxdQBfugr2
	 reCND3Z/PLkuqh4t4rkwV4P+42fb2/bCwLutvjrsLrX5eXBkcPI3kG/52HZJo4ALaL
	 yaVtW59xs2ClckU4Jg44O2Riy0nIdqfT8g79sr0CMvntk9ACJJ6/JlA+frzPCHkVHJ
	 JtYmaYRGoPgjtnAZUm4wPl0/cQc2eQIWD5xtYCbejZWq0oWciKoK48VkrRY6jYbBYA
	 m6PUdbvv/gKklVWDQGz3VXFiNXScoNJgGYwzrS4tytDYja3kQgpp+8Vd+nka2TvwlA
	 ugHlv6Fsz6trQ==
Message-ID: <0aef4840-702c-40ba-a6ac-c3a745501323@kernel.org>
Date: Tue, 22 Jul 2025 11:23:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add gc_boost_gc_multiple sysfs node
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250718214014.2277307-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250718214014.2277307-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/19/25 05:40, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Add a sysfs knob to set a multiplier for the background GC migration
> window when F2FS Garbage Collection is boosted.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

