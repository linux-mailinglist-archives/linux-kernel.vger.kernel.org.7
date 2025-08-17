Return-Path: <linux-kernel+bounces-772657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CCBB295AE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4663B1893DC2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77110223DC0;
	Sun, 17 Aug 2025 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="42P7GHLn"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5563A1E1C02;
	Sun, 17 Aug 2025 23:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755473049; cv=none; b=R62PCoV+TUrNNPmws+e4acll/JcYIsPB2wIQ4Oos7eCfHgwgLBkENj+spyJe8YHh4aJ9zSEHK/ypV5zKyJvRwpF1mOQCkNHMos42DOpymneWMH+eMd20GZ2RPdPheh6TVzFUPu3/upzGM7+g9owketJh7kr31RGuAyn1W6mwpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755473049; c=relaxed/simple;
	bh=bqbRlWUPBMMKKs3NAccvZ+zkKOuvX/DCi9VzeQQ4hQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXxuupkoVH4CQGBWfl+MVL8UBj3mFqUtixRJx42ro/eStpNCbhsM8yaF7742JtlMpRda/8aztH7gIUPusnEQ4dvtwNuEpdMI8+JKbWNMStZWLR+hUMLCZNes9odBNVQbPAWhKCz9XcziZ889I4Rg/3RTFiJiVLEkayjmDBOLZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=42P7GHLn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tQ6JTLQMp2lR9NVHV9PDYYFAuOFYRhhA8Cv5cdwQMG8=; b=42P7GHLnb1HcEdW46TQscblVdb
	8TQOeoh+DtnGTrfD8r0eaSLOB5rIwdFUGplFEmbyyVueFQ9/1giVKuCjw2ErxPOSg/cXJtFRZxnce
	02b0/kVzvcrke/Y2rF7BGTJxnQ+vAM9Q9t1jybAFa+p09FMJ0U7bV4iUyv5Wn/cH1zIsAs7vL+qmS
	qsGr2stCUIzcqUwG4x1mKK+p1j/ydcu2vMEytq5ZBMGpCKLh3SRt0ECu3d9D0zjCQIH8tZki5MCfz
	yhSDZbr3ea3Rqhh5vQiQu7lGcfdYWFUfgUKGAR4l0568zPokrPMypaBqXkN0MiR8DJJkSPw0bToy9
	m/K/AJkw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unmjL-00000006A6h-1wVw;
	Sun, 17 Aug 2025 23:24:03 +0000
Message-ID: <fefba786-57d4-4138-9454-7cd3d924239d@infradead.org>
Date: Sun, 17 Aug 2025 16:24:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gpuvm: Wrap drm_gpuvm_sm_map_exec_lock() expected
 usage in literal code block
To: Danilo Krummrich <dakr@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Antonino Maniscalco <antomani103@gmail.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Raag Jadav <raag.jadav@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250709024501.9105-1-bagasdotme@gmail.com>
 <aade485e-0880-4c68-9b37-d8a27dc122e3@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aade485e-0880-4c68-9b37-d8a27dc122e3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/25 12:37 AM, Danilo Krummrich wrote:
> On 7/9/25 4:45 AM, Bagas Sanjaya wrote:
>> Stephen Rothwell reports multiple indentation warnings when merging
>> drm-msm tree:
>>
>> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2445: ERROR: Unexpected indentation. [docutils]
>> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2447: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
>> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2451: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
>> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2452: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
>> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2456: ERROR: Unexpected indentation. [docutils]
>> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2457: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
>> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2458: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
>> Documentation/gpu/drm-mm:506: ./drivers/gpu/drm/drm_gpuvm.c:2459: WARNING: Definition list ends without a blank line; unexpected unindent. [docutils]
>>
>> Fix these by wrapping drm_gpuvm_sm_map_exec_lock() expected usage
>> example in literal code block.
>>
>> Fixes: 471920ce25d5 ("drm/gpuvm: Add locking helpers")
>> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> Closes: https://lore.kernel.org/linux-next/20250708192038.6b0fd31d@canb.auug.org.au/
>> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
> I assume this has to go through the MSM tree?
> 
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> 

Hi,
What's happening with this patch?
It was posted about 6 weeks ago and the build warnings
are still in mainline (6.17-rc2).

thanks.

