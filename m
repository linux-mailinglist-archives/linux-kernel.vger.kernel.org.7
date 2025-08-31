Return-Path: <linux-kernel+bounces-793503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7BB3D464
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 18:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 800E67A6CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8060626E161;
	Sun, 31 Aug 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nWseXR19"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B74EEDE;
	Sun, 31 Aug 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756658118; cv=none; b=V63Fot07CY7mKNf6OTpJm9HBercrR4h00XS/fiqbRkDo8QOmHFV9tK9rrEtEFYHivv1f8/g0tsXxxZzp7Vi5W8ROz75Wz0MMM4Sk/i19fZat4lB11cCewNHUOmwDY08WBCvfd5wpXNmM3sg2iZ14so0kxk22qun8fEVxpHb3o1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756658118; c=relaxed/simple;
	bh=VjK0CxWTl07ojzT/4d0zZb8W4c2zNwbdfidTImXEdDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyK4WO5ZEQIzFEOKwh90/a3BCPuMS7cxeqF/3X1BIp2cw55CZBgogkqpweJiCkj/wNXhhQSH9YhzLXWQ00f6I3kk18G4HJPBWcYohwY2KO726kGKURPHKti0blAG4DKHUk7gseUxikgIOtA33W4wvptFanMKEzc7nmsx4E9R0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nWseXR19; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tIlR0ABRCw5cP9VP0XpZIHyi0kWpklyEXK549O9ruGU=; b=nWseXR19JIjh6MN1ByXrzThvpu
	oSAyjzbDg5V1P/2Y08uF/wPVYcQ2SP7Olgy7A86g5EN6hVbVfdIXgQ0haiDdjNAuXFpmgFWSYrteI
	O+IosjRXQo+1puBkPAM7/TeApoVaPr772Rps2ZkwQBGIEgRfP0/7B4LMSfc896JWdJr8HzjwW15oO
	MtIWwFXeF/R3md6dejYpdOdzvv8Xoj/vKM/EERTblslFNTW//DLEOUhNk/BfQzKq6WUag6Dd3beiC
	ibxCWET5QnQW+jOWtzyWk3QdoDaixkl3SX8qAnDdcst5ZuUjn9V1DozyIkkD/CmBCG/DHUUiPGpjN
	Il4WgJVw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1usl1M-0000000AQBJ-1FQh;
	Sun, 31 Aug 2025 16:35:12 +0000
Message-ID: <72852085-9f20-48b8-b51a-c41df915bff0@infradead.org>
Date: Sun, 31 Aug 2025 09:35:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: gpu: fix spelling error in drm-uapi.rst
To: mohin24khertz@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
References: <20250831141522.7813-1-mohin24khertz@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250831141522.7813-1-mohin24khertz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/31/25 7:15 AM, mohin24khertz@gmail.com wrote:
> From: Mohin Nadaf <mohin24khertz@gmail.com>
> 
> Fix typo 'unpriviledged' -> 'unprivileged' in DRM UAPI
> documentation describing error codes for operations
> requiring elevated privileges.
> 
> Signed-off-by: Mohin Nadaf <mohin24khertz@gmail.com>
> ---
>  Documentation/gpu/drm-uapi.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 843facf01b2d..7435664a1ffe 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -535,7 +535,7 @@ ENOSPC:
>  EPERM/EACCES:
>          Returned for an operation that is valid, but needs more privileges.
>          E.g. root-only or much more common, DRM master-only operations return
> -        this when called by unpriviledged clients. There's no clear
> +        this when called by unprivileged clients. There's no clear
>          difference between EACCES and EPERM.
>  
>  ENODEV:

Hi,

There was a patch for this on Aug. 21, 2025, but I don't know if it has been
applied/merged anywhere yet.  It could be in one of the DRM git trees --
I don't know.

https://gitlab.freedesktop.org/drm/misc/kernel.git
or
https://gitlab.freedesktop.org/drm/kernel.git


https://lore.kernel.org/all/20250821025957.22546-3-rakuram.e96@gmail.com/

thanks.
-- 
~Randy


