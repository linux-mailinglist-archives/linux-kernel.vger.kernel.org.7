Return-Path: <linux-kernel+bounces-823934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2CEB87C32
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77F887BDC40
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D9258CD8;
	Fri, 19 Sep 2025 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRLSHdFz"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15D226173
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250612; cv=none; b=aqVqu+ylVb1nMDcoLK20ToLc0muqtmRaGYl+5fw3GCq/VTS0bv+iM++Jx733j2Nkqb+GVCdfBd5faQEvQUQhuRzMmxvHtIw4mnZ+TOvRL6KSaLj/+t+bfoJnQvsx/KGLQDm2oiQDGxA0EWRmGDByr8VnAZRwiKmtaXYfUa4DEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250612; c=relaxed/simple;
	bh=tqRDtHS5k1GrIcehlnQMe8j+zbuJ1arRBYLZ5MG6SuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKIiyVTWqhwmVKEQBJITkzHpUEmN1xnJHkfuW82Za3uHSPEXKAZjmLRnnguI7+E+GkzO2a5zjHSXKoFnwx9Atwr2b1POk2bGYcwpQaXUGCLzJP1Ky7Hs/QH4Gs/IOPlKqNXomSPeHsqU+NEYIaDk9jQSlvkseTo1R4hZivcTqoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRLSHdFz; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-62a35c99b9fso685580d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758250610; x=1758855410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qO6eabty1/dSjynDPSJipZBjWDXwhm/a+GVJlPdWL1w=;
        b=hRLSHdFzbG5q1ih2G4YG3BDmOoFQwYezM1uMVxEyAnKOecZ0tK8KJOkbt8lKqrNg5U
         gfs+My3DG7Mab2DxjyH3FjOdaz+BJUWtVKJ9mkB8t05/8hOGT7MrTus07ssWkrPfru8d
         Coe8OOAqEw7ffCDPxFNXmZ5tQs294zHGvOvTFAL/QzsycFcRk4BbunvOEqk4YKnDjuYs
         utNj3Pti3GxvH5Ne2623mvBWvke/oPEwCKKxlEZts8cOsbuElssYVDU1bcZfHOnLISQQ
         HCURYM1H8bf+zaUwvHtkOfIivmU9UrDNNvlVLhhvtv48EFn+jvRMONX7kx1hgved8qaE
         +QvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758250610; x=1758855410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qO6eabty1/dSjynDPSJipZBjWDXwhm/a+GVJlPdWL1w=;
        b=a9vxORlJxGuZ91cAztj3rqpL6ePZ9e3a2PtlBFK9yaQbNPMc3ZQezlC2p5lvEKiZYB
         pMP6XhrlouyNxRgHgZ/2LSwhbcRW0pZnlZy4rY+aijCZD1jFQTQ6up0toXRYQt06EOKx
         13HtDS/TRF3cAaFgxgt50PArE0Gd1CLTI07Hf0gLBFT0BG90jRZ6FtMuG6xZX1i7IxbV
         byRCOBrXhP9nUA9TrKYNTNy+wXvcJI8lR1lAXzFAUjnTYK+Au6xlVY8r4twZkg5XZXGJ
         SW7lFgYIy54MV/rGk+gGTj/CKk8MMVIQy8PuGErxSn8mmYQWwqLX/6xwBWg7XMp7+iIA
         uLyg==
X-Forwarded-Encrypted: i=1; AJvYcCXXXQzhtihtK04J6Do6tbesEzE8n2r3VHxxZZi8sUwlYItGMJqFVr4jCnXUBZj9A1M1Uk4A5DI76WyA9QE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya+5usnmdd/s9D74w0ve7sF501qX5Pq9q1tC7zbigAk9hmLm5X
	sjEV2YvA//muvK6Ginf9G0B0GXpXqvJetjxt0+kMOl0h5UWqSDCYyXWn
X-Gm-Gg: ASbGncueERflyYas5UT9hyxxetlUCAgyaDFR+ndu1j1jDGnwbXiTugpnRrJTIpwlFvC
	6idvsiZrlojWTgrIbQx0tTBuyFNTC1rm5lRWtCFg18ozKZFz0HpRTeBiDGANBysRg77w6vxQh0X
	3S1epqHtSICnCWbdHFx1QRNdzhExCvyIejd/OWvvLaB0pLYQBJpKgRoY7W3zbht5Qe3Xy94aE9W
	6rS3/75e5GX8J5UPQVzOL4ym2VNjLxGlc0QQRvz8rNyKLd01KFZ2OXJ/vWb7U8SjUhF5e+xjeQX
	dRUq0tnOGZSl00UxoUrWLWWjEYbGTwfV+5BI1zKprMhkeyvTjjF3CMb+xGgozzwBXcJJq3RvzvJ
	EYlwfo0VAaDcnFVP5puqX18rIEhRWhESmdrZoRNMuZw==
X-Google-Smtp-Source: AGHT+IFehA3xN/tMh9X208NCg7HmozISU6XaPbnU6X3wnRVZoD3aDuxzFTvKaV5O8c+4T3k3RmCSYQ==
X-Received: by 2002:a53:d88f:0:b0:604:3849:9bd1 with SMTP id 956f58d0204a3-6347f5f33d0mr1122776d50.17.1758250609606;
        Thu, 18 Sep 2025 19:56:49 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7397186acc0sm11546867b3.45.2025.09.18.19.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:56:49 -0700 (PDT)
Date: Thu, 18 Sep 2025 19:56:46 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Yaroslav Kolomiiets <yrk@meta.com>, James Clark <jjc@jclark.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] broadcom: report the supported flags for
 ancillary features
Message-ID: <aMzGbhXk4ae6JeFL@hoboy.vegasvil.org>
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>

On Thu, Sep 18, 2025 at 05:33:15PM -0700, Jacob Keller wrote:
> James Clark reported off list that the broadcom PHY PTP driver was
> incorrectly handling PTP_EXTTS_REQUEST and PTP_PEROUT_REQUEST ioctls since
> the conversion to the .supported_*_flags fields. This series fixes the
> driver to correctly report its flags through the .supported_perout_flags
> and .supported_extts_flags fields. It also contains an update to comment
> the behavior of the PTP_STRICT_FLAGS being always enabled for
> PTP_EXTTS_REQUEST2.
> 
> I plan to follow up this series with some improvements to the PTP
> documentation better explaining each flag and the expectation of the driver
> APIs.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

For series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

