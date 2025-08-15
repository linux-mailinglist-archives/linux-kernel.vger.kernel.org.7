Return-Path: <linux-kernel+bounces-770905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A870CB2803E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2C6061C4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E293019BF;
	Fri, 15 Aug 2025 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g6T7z1+I"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AE2DDAB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755262849; cv=none; b=BjZEaKUw8gTOBuhUWKGw0fKP0PA5g1j3kZ8klrTPTZmmZxmLRcqB4P6CgVSoBFQD9zl+g5RdkxOdRCisggfQOr8/pkq+8fUZPnmStUgT6gWP/78MFH9d7VvBg6VHG9rG/s6vdyyjug1vpHTPa8jfjm91BWgyOG325JxQV9FomV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755262849; c=relaxed/simple;
	bh=wSis39yIb0n9Nkid2+KmzOkvqKCQAn8rxjFclMh78mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT2mMRMnUXDZkQSI2nIHSS4sD089+fQd9BiDywciIoHOJSkvRFpJPNRnkt4YEfmRJQKyDLXSEpoS4EjmvhW/4haoEsKyOxMbUiWx6rWjAXH83rhjesMzZ/m4kW1YGsBWP9rT1hP5zJmbcnTi6AGf4rFInc2MtFcF5bMwfQp6xKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g6T7z1+I; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b01e47c-ee81-4650-af5d-328544089391@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755262835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6IPjYI6u0832mFiHwUFWLMB7x9Um1SBVr0ChQ/OD3k=;
	b=g6T7z1+IKl8PuWBCEU7j82Ich9w+uBUWtkisN+RXw1lpGeFs5fkD8oQmNPbxSFsF/2ucCX
	idgKMU+YR4w2VMdSesRcY912RSHgG1kggty+phpdGmBJU9bCm1B1pzfCUjz/XIYOh+fPnj
	hGOY9Bz9dXAykvcDxR9NCNXE8L2zc0g=
Date: Fri, 15 Aug 2025 21:00:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] Documentation fixes for dm-pcache
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Device Mapper <dm-devel@lists.linux.dev>
Cc: Zheng Gu <cengku@gmail.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20250815075622.23953-2-bagasdotme@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
In-Reply-To: <20250815075622.23953-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Acked-by: Dongsheng Yang <dongsheng.yang@linux.dev>


在 8/15/2025 3:56 PM, Bagas Sanjaya 写道:
> Hi,
>
> Here are docs fixes for dm-pcache as reported in linux-next ([1], [2]).
>
> Enjoy!
>
> [1]: https://lore.kernel.org/linux-next/20250815130543.3112144e@canb.auug.org.au/
> [2]: https://lore.kernel.org/linux-next/20250815131115.45518c74@canb.auug.org.au/
>
> Bagas Sanjaya (3):
>    dm-pcache: Remove unnecessary line breaks
>    dm-pcache: Use bullet list for data_crc constructor argument
>    Documentation: device-mapper: Add dm-pcache docs to toctree index
>
>   .../admin-guide/device-mapper/dm-pcache.rst       | 15 ++++-----------
>   Documentation/admin-guide/device-mapper/index.rst |  1 +
>   2 files changed, 5 insertions(+), 11 deletions(-)
>
>
> base-commit: 6fb8fbbaf147fe4153177320ee354c457605800a

