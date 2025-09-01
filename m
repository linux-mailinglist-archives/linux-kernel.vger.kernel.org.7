Return-Path: <linux-kernel+bounces-795356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAE2B3F080
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E914E09A9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B027B4F7;
	Mon,  1 Sep 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmOU+ixj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74DE278154
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756762276; cv=none; b=L0b/uln7hBZs87sBoEDmOwU32KsZlxDD39+uJDC22SrXKw3Fk2PEhDGDJ9xf46h57csQfJX9pB5cB4PE/LQXb72z0BR086QYQzjmP54Fs/DPbtX+u5JJcY4OvZEZxz7ARvMROQTBqS75KS4GHxAgFwQYGuKfitZpASaNKExizlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756762276; c=relaxed/simple;
	bh=Z+ej9pwp2++y8Si2a5LoNWa0dw/LyT1iXFjl51NEyGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctLr5E1vUbAbATdCUbralSZUqNpgDI5pxG2aTpOjqrTp0ZhMXMpHFMCqqCXBZPXUqJNxV1J/7fJHCGiSt7C17yTxsOgIsy4q763hgMGVdCE69+G9aa44dV34YGQwPI/KP/yyYjMrJJ8iIY/arOAe4CONfboWzlH+RGR/8dfV4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LmOU+ixj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b72f7f606so88095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 14:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756762273; x=1757367073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iF6n6sHOgsKd1WpTX20Jc46RPi8oPME1VeuLjiWGbwI=;
        b=LmOU+ixjJ+aKbLpNcUjrLIW3NR25JCR93ZSId7SVjrifZEzJMEL/0L2mhegw5I90SW
         fXWJnHsqGpcsm7TXfv6g5LBuflgQk6fh4YCQ3kzUwOQg6tOxNcOrNElvyBEoSSO6NMvH
         ZZoG+/eoQacG8G0sBGE8gBfEse8xV6yLHdz3l9ApRYtu5LiHZFmRXgIjjJukJt8yYJhC
         qYtA8RjvkZjivx9bMqYu0aOmU8gk5075ITNfIFZO44MYWaxXqsvRkOD4q8odsbkRMnxM
         L3FsssYrp+kVXlHGfMM5uMxeYXhop7g/x2UcLFGRV3bgIUtaLDPh1akBiIqXPB41FuxR
         PjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756762273; x=1757367073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF6n6sHOgsKd1WpTX20Jc46RPi8oPME1VeuLjiWGbwI=;
        b=lpyIVbl1yoqIAGOlES4Rde/j7zfG3LwySYym+n98nZSDOyvy9xjkCA2sZIEM3cuaLG
         l4oUI5DMYcudGEbYZkSjLy9NZaJk/odiI5AvSTkQKTIAKlf+vs8v0CrxsLEPaUU1Zw1I
         Xh6FSCoKsdS0b1zGUD2LQiEFWtFvZJmgOgkw8CY/2Clz729S2/XuyqG7APVTw22+IygS
         Xv8x4KIn6Qgxg7DLVrNCt+OkWAfHZyPRkBD2bf5mjkjRaNwnqf4EO1U/VBhkTQ2ix41i
         YzoSBMGfxkdOfOy7Vu7SMix1BQxgsdt+S802kdQWjk25/GCVk5xON0fO/Dzpxpntr/DW
         rogg==
X-Forwarded-Encrypted: i=1; AJvYcCVxUrJdnPU1oPghYnfwpwaCw+ZcTfwgbGUED5Dc3ec4ofxiMEqu57W/Tk1M9FYldkXTbNFGUuuRP2f5cxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSPZQap+Npn+n56hjxseeA2yK8c2Z+wzezwzXJF75dVvBGNPEp
	MqaOys0s/L8w7OYBrP4Jhx7/zAjm15cS+U9N8itg/q78chaC/PNcVpbGEzOwf52KLw==
X-Gm-Gg: ASbGncttzKtULz1YGoUJnjo4HyzpK83H/D09snIYo+htv6GQAdmE9osNzvrDnr2+n4r
	8fDN4pxf6rMsLhA4PSmnAulgj6gsFQcbBLHBxvH3LcMGEz1JOaI5o9jZQXTITwTnuiAc0+yKOW4
	cvkPVdAh71mRVGFJk75yExa853aeMgsk7CB6nrotMk5DlUYBLU8FYF/5toU3hBVOaOOsvQxwnqA
	YMMRn1k5G95Xro6dXI96SXMsPSjjmN2facmxE6ul41JyKSSVvjEruhtFxSgpMctnoRtTCwE39I3
	PHPdtcuhKMv39pBkFOJx+bZle78g7K+UedIIGk+0XOPpRDmn+beTEgj3JNiRK2sjJ15vhYehonE
	MMJjYYaGqM8MaTl5Fa/S60Up/rsjLGZ9JL9weCvubfz4otUtYyt8+DuAFG+vkC+2ZFElzUaoOf3
	rGeg==
X-Google-Smtp-Source: AGHT+IGLpKHQN9xZlHfjJ7Ii92fk9qbRgWzKQ/hHtlgk+3xGEtbYRWbas4SwWPxJAuhnPExKzRecwQ==
X-Received: by 2002:a05:600c:498a:b0:45b:7ac5:f48f with SMTP id 5b1f17b1804b1-45b84b62748mr2268795e9.5.1756762272856;
        Mon, 01 Sep 2025 14:31:12 -0700 (PDT)
Received: from google.com (26.38.155.104.bc.googleusercontent.com. [104.155.38.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e74b72esm174837265e9.0.2025.09.01.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 14:31:12 -0700 (PDT)
Date: Mon, 1 Sep 2025 21:31:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	eric.auger@redhat.com, praan@google.com
Subject: Re: [PATCH 0/2] vfio/platform: Deprecate vfio-amba and reset drivers
Message-ID: <aLYQnKGsslgoHRZh@google.com>
References: <20250825175807.3264083-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825175807.3264083-1-alex.williamson@redhat.com>

Hi Alex,

On Mon, Aug 25, 2025 at 11:57:59AM -0600, Alex Williamson wrote:
> Based on discussion[1] there's still interest in keeping vfio-platform
> itself, but the use case doesn't involve any of the current reset
> drivers and doesn't include vfio-amba.  To give any users a chance to
> speak up, let's mark these as deprecated and generate logs if they're
> used.
> 
> I intend to pull the vfio/fsl-mc removal from the previous series given
> there were no objections.  Thanks,
> 
> Alex
> 
> [1] https://lore.kernel.org/all/20250806170314.3768750-1-alex.williamson@redhat.com/
> 
> Alex Williamson (2):
>   vfio/amba: Mark for removal
>   vfio/platform: Mark reset drivers for removal
> 
>  drivers/vfio/platform/Kconfig                            | 5 ++++-
>  drivers/vfio/platform/reset/Kconfig                      | 6 +++---
>  drivers/vfio/platform/reset/vfio_platform_amdxgbe.c      | 2 ++
>  drivers/vfio/platform/reset/vfio_platform_bcmflexrm.c    | 2 ++
>  drivers/vfio/platform/reset/vfio_platform_calxedaxgmac.c | 2 ++
>  drivers/vfio/platform/vfio_amba.c                        | 2 ++
>  6 files changed, 15 insertions(+), 4 deletions(-)

For the series:
Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> 
> -- 
> 2.50.1
> 

