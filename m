Return-Path: <linux-kernel+bounces-740230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C58B0D19D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8633B2561
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077328C85B;
	Tue, 22 Jul 2025 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQo6mWbD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81628B7ED
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164268; cv=none; b=Hf85+P+fSavxWMWI6fynnVXSJEnUyG/3WaoCQ1r3F+tXfYxUrrJ7mQYreaBIj4wbXB/AoJy9SGKWqAWf3UdInu4pLcVNh9Wzd7YTUUHHLkmVoyNx9Umutzjg1hQ2xV73itpEXujVukpqNQY1lOoxf3Qvf/AZHjlTOgOlnOvztWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164268; c=relaxed/simple;
	bh=/StEH3qJQKjWrvlSu2USI+wee4tETEn4s5xe3LCqlgc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GWjh/QPx2QzxfneEuEW+zF4JkkpcEwFZcG+jR2G+G9JuUSc8YtkW9dl6qVAwDTlIfZrEd0xQR1SCNbw3k+7zZi2FfWL72SC3hXpJphgZMNz7f49QF6g4p1p5pn1HDwaDrqZinKC/Lh+66PuWsWKFTNIB1fkKhvi16oF9sIA2xlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQo6mWbD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F734C4CEEB;
	Tue, 22 Jul 2025 06:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753164267;
	bh=/StEH3qJQKjWrvlSu2USI+wee4tETEn4s5xe3LCqlgc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cQo6mWbDqXztLtf5kEsj9TIMNpiA2CIbm5wCZaNXZv2nf420imCoMm+O93cOWiD6b
	 Y21zpk7fSQ1uz5LULF0DbuGimKPVxpqsFx+0X9Z/pGK3UFOzUAJht1YgC3VNLEkADK
	 xKv1kWzqE7Qk0AtazpZm4laptwrbkpOmKLMRAmoevAUnKoh8I/w+DL1L6jGu1YDQbB
	 T36movLGHpnkoFEr0IPGv3wiBxJ6axqfksd9Vlh8zkH8/u3qhpNjIk338HKBF8EfmZ
	 iRU4/3P9K5RRFs3Sws7r1zT7Mby3W4SMY4/7op0u/1PM7GLMpWGdUB3t9jDb0DSoCO
	 mvz0MBMyO2Xjg==
Message-ID: <0efcc474-4b44-4c38-a4ed-1ead3837c8b6@kernel.org>
Date: Tue, 22 Jul 2025 14:04:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, pilhyun.kim@sk.com
Subject: Re: [PATCH v3] f2fs: zone: wait for inflight dio completion,
 excluding pinned files read using dio
To: "yohan.joung" <yohan.joung@sk.com>, jaegeuk@kernel.org
References: <20250722060240.1469-1-yohan.joung@sk.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250722060240.1469-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 14:02, yohan.joung wrote:
> read for the pinfile using Direct I/O do not wait for dio write.
> 
> Signed-off-by: yohan.joung <yohan.joung@sk.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

