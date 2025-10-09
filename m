Return-Path: <linux-kernel+bounces-846756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4614CBC8F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6196350C19
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437E22DEA6E;
	Thu,  9 Oct 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJEcOpGF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981CD34BA39;
	Thu,  9 Oct 2025 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760011430; cv=none; b=QLP1I7nZQ9ogNMA62bexjIMcyhlYhYkuZOy0M9a/ba3czEeZTlBdCUV2qJuwbiS65mzzWAar6BgRw+Cmimfcy8ubEwwZZzOOa0BLRr4F9dSoz86IMlAGfDUik+/98blX2w2jUh7ZB+A5Ztqzf48gyePypPDck44qxQFLEIstLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760011430; c=relaxed/simple;
	bh=VfrSNghZOTHmu2Blgv7WaDJVPUKzB0Ze9oQL7/3AuPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrPkukUE24meN1AGI2pcPRwScXHCPdMsheuJKNvr3He1+4IIMZdkl+xp47mRpxOYNVRFlLuZ06Z67gPvbh7VKoLjkuLqYIVc+lcWWpoF2oHCFy1lWoLK/MnRK42XeaTkPyZYcRd6847iCSlvHS8KVshnR1mboaPhKpNGBoPGEjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJEcOpGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71480C4CEE7;
	Thu,  9 Oct 2025 12:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760011430;
	bh=VfrSNghZOTHmu2Blgv7WaDJVPUKzB0Ze9oQL7/3AuPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJEcOpGFM9Hcl+5nQfV8EMA4sicQBJwR9hKGxtDCpSmvtbdRYuRMHBqmylCVYG4rZ
	 iQoIKeztoWCju5NGno+PEx+ADHou6HBH1r1jq8jzmhtZsWt0dceSWcA9nMORuFTB+c
	 ib0pxHK6wV+w4yX/BoMoFmmFRw4NMK3hzTRXjbKg3TkNpL6E+hLnMbXly08K3qNyPf
	 QFOlCtV+e2po1isjU/XOnch3bguIHUrvl1if0LMSP2yEz0w2QghZtyY8dOxruP6oG3
	 Q+5T6FomiL8BHD3u39ffv76YuXg+/R+xQJkPvuaXUKshDZzvNwQGGbvMj4L/cgycp7
	 TqFvd5eApfPzg==
Date: Thu, 9 Oct 2025 14:03:45 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ata: Use ACPI methods to power on ata ports
Message-ID: <aOekoZ9fWmIFNOx3@ryzen>
References: <8c3cb28c57462f9665b08fdaa022e6abc57fcd9e.camel@posteo.de>
 <20251009112433.108643-1-markus.probst@posteo.de>
 <20251009112433.108643-3-markus.probst@posteo.de>
 <aOejov5d_TlVkueH@ryzen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOejov5d_TlVkueH@ryzen>

Also, when sending a new version, please avoid linking using In-Reply-To to
previous versions of the same series, as it creates an "unmanageable forest
of references in email clients", see:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#explicit-in-reply-to-headers


Kind regards,
Niklas

