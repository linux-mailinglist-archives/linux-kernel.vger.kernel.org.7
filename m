Return-Path: <linux-kernel+bounces-816360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C569B572D2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D7117DE7C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5462EBBB9;
	Mon, 15 Sep 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbV99TcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9892D542F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924710; cv=none; b=oDk/6jmnmHYdpdZyxWPl/v2RiS/BslJeVpp5Ro5cabvYA9zN/xf79p6tu0k8Z8uejBHF7QRv9ZGWX9324vFzP4ZRWe80O6hUecvJbZ8Qm4H7DhyaHhXfvdMP7e3b8wOSOOQLdUR8awEPwewALVr2sCnlktjyuo8ghThOgojkbD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924710; c=relaxed/simple;
	bh=J7tpPuV+eu02Wd4vHkG+u41CnXzWALqKvv+0+85N7jg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MmAqo9AH4YIMmvIcZDPIyCM3gFvlUdhjxZsgk4vtGBITz5rCkaQ4foqR0OmL2dB+sMKMAISQWfFjBXpj0AEyGfM0hF10+dbATo99vpj80jNC1botLuU3Do7FVg6puc00CChFfNkvMmO/MavflPYxWBPkMEr3VFL3yJLSvzpl18I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbV99TcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC15C4CEF1;
	Mon, 15 Sep 2025 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757924710;
	bh=J7tpPuV+eu02Wd4vHkG+u41CnXzWALqKvv+0+85N7jg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=LbV99TcNDiJOWtXsPZdWdsnLmEkMFqtKJ4FyvOIP5yMT08pGCpAjOTiXYDNGg7dTo
	 e+L/z8Yq1mueYryYJPYWdhE3K+Toej22KGENrcNjOwT/Tz7eGUDdJqYxjn+K4rASv0
	 O2T1LDZWoTuyYfGRfj8+URZiWrdE2jLF//1Tf3zQ3ffCgPnNvGj6QtKXRbCj3oqFmA
	 l6EgmYTB8sCIgwTZCmGHf2gxt83qmnwKcvS1rXQGgbf1F33h6i6ARW40gX91/dxz++
	 OZoym5Rxzr7/7h4yGnbbz/5BhFyU1TAMv5WomcWEQBPia2JEx+Uk9aH5yTz+SyR1J2
	 mRyjooT/Mb74w==
Message-ID: <759bf645-6460-4d0c-a7c8-4cf40eb80a3a@kernel.org>
Date: Mon, 15 Sep 2025 16:25:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [PATCH 1/2] f2fs: Optimize excessive write operations caused by
 continuous background garbage collection in Zoned UFS
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 open list <linux-kernel@vger.kernel.org>
References: <20250909134418.502922-1-liaoyuanhong@vivo.com>
 <20250909134418.502922-2-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250909134418.502922-2-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/9/25 21:44, Liao Yuanhong wrote:
> Incorporate a check using has_enough_dirty_blocks() to prevent redundant
> background GC in Zoned UFS. When there are insufficient dirty segments,
> continuous execution of background GC should be avoided, as it results in
> unnecessary write operations and impacts device lifespan. The initial
> threshold is set to 3 * section size (since f2fs data uses three write
> pointers).
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

