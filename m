Return-Path: <linux-kernel+bounces-733736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C82AB07866
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278F81897C56
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57741263F40;
	Wed, 16 Jul 2025 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8Px7YYs"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6242E36EE;
	Wed, 16 Jul 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677057; cv=none; b=o3/zEnFjMSNWgM2noZ9Orb3+OKbphrh3yLpoxGn1m8RkA1WQyyRGbdgpRv6lDcHyB7xD+ITFgyu4q2vZMeJuFnQGz3VolL2pDVtvRYvmk1dHjTD7CxK1D8Tyy4AM+khsMqO7GCDkguq8PzOUGloHG/qDp13LRxrLTMB7pfr/pxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677057; c=relaxed/simple;
	bh=Y5vSEjm7SMmJCnf6dR5LSRhBKVMYneaTKn/foro26Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JpLzsblP1Rhkf02MRPlTia5H3gYALedIhGccthbtQBoWiU4oE31UXQ463h1Rdh7/a6nzou5epVwE+M/H7H6QVA42XhFzNWNHtL58rDVSDwwjf01YoVOqZdZXvjPb1nn89j004PWQ5yMhbV/ot79YcM/FbToEFHkjsreT3ChNACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8Px7YYs; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748e81d37a7so733b3a.1;
        Wed, 16 Jul 2025 07:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677056; x=1753281856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiEdLCD4Zyuop8q0M15N+PDuMQsWGz3VjZu/cP0SibM=;
        b=W8Px7YYsEW26I0Ykzpky2Rd5BhryrlYW6393GrN7qIGLE6CviFyD9r1s1Y2aE08gAZ
         EO6cXGkWJt4qG3RsYFGk/wngzNtmCB9C7+iNo2qCupD9dHt1diuZ46awpPXZpqwT7Rt3
         KuqofIgB/QfSB/razPnTjLl1n13ylNXisgLbYb6F1GZJp+P2/ClXZQEHhgaZN7t8Wxkf
         Kp5fywUMk1Yn6LzHy5jw3HigyeEP4Ild9agOKiTuv7wgWCktf5uC1B0GtZUyhDBBvN3R
         HOn/k7TaQFRoHNxn2hsknuzDE5575klieLnMHvotTkfp1ASKKdZkZKBaQTJWwojfxDn+
         IdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677056; x=1753281856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fiEdLCD4Zyuop8q0M15N+PDuMQsWGz3VjZu/cP0SibM=;
        b=Dzt40B4lT91cq3CFBY9VTLGO+9Zaf/cZCaLD8T0KLMsRI8yxkDtgINoccs/wXpygv0
         XkPlHki59aAurWLbFDDwHkga4EcfBm5jmJlx0i+/KbSYlwIbOM+iSmPHkMAaOVcn9WGI
         uScL3/n7Nft90mwGKzwPtbdLX8nyJqxZcWY14SHB77GQdf4+HOqMbX5IRmF9Ys5R3eM/
         oiUNd2Y5UZcemr+TA+oD+Y+Rk+ZFTdCZXuO3brN1jkelciSX9nh9OVPIXFvSTvIxbQaP
         f2LZPuGfMQbZGjeMLEGNpMx1vRuRfGs8biH2b4K8wgriPsj9wdkl4mOXRRe7RovSYBdK
         gOSg==
X-Forwarded-Encrypted: i=1; AJvYcCUhvLHMAmfAKQGNerjlE/DNV07Qd7Z6SXfm3kIS9qfmBouE6fsFHNSnXzvFxfhqflGTHVpk88/Wa7pO@vger.kernel.org, AJvYcCVD2WC3cPdWY672/TTnaCFLYybpiDD4qAL1qNYJRmiDTHpsosyW7yu78t49GVzE71XHdUG6ifMsi2qrIC7A@vger.kernel.org, AJvYcCWzLGYuM3+IIiSCr7AgbR9b/3BbxPw+Of+iUoWlDe73bQE2UhNx+81RbwZRJlFBoZwRARw4KrGx5dAzSFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvHNINwm7fHMPGOmAOJXfVHmuuzdx/CEG+UXpT9EkbELnoFeEL
	VZtDIJ4w39tk/FQjrbXePsQhl+CiGHegDu7uMCh3BqOr8sUkVy1Elvxh
X-Gm-Gg: ASbGncu9KpRokwBHnLmnSj+J/B0ZFeXdf3xWMHgrxISLwr88eo/2Kv/Vmbgm22YVwA6
	V1dKgdcFF3aF/KsiKhlxFZYgm+2Y/lSaTX2UIDN4gtfB0qGYglexBzRbSXQ7YDtzqmlIr+WUAbs
	jEvOQ+sVhSgVLb1+3AlFDKyAI/ao7npdqDouYQqQrgBAQosvbr3RD0n4A034PI5hFUeRkKVt6pD
	fciEHLLjTvfqssJvwBDnXXKMlEwZOt5uDdyGDSutzLZnHkNzTAC6Mwpo0PkpIl7qktlWqtd8RS5
	uom9CJ8ueThbpupsjghpAPcf87T/1IizlYIl/TWgqIB53MiJM32s6OZzxsItx/ybfO9blYatswA
	RQkFT+Ych60jOJVnTUgc09cAK+vZB9mwERsU=
X-Google-Smtp-Source: AGHT+IH9ns5K9rE+AIxXHGk6VQ1X7/4WEcx5HgEB/HmJpjAookZhwnHYb0h4oA9Pww0/KyTHmyWAkg==
X-Received: by 2002:a05:6a20:a127:b0:22c:fc43:c9f3 with SMTP id adf61e73a8af0-237d702a853mr5815864637.21.1752677055559;
        Wed, 16 Jul 2025 07:44:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd7134sm14948070b3a.19.2025.07.16.07.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:44:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 07:44:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jim Wright <wrightj@linux.vnet.ibm.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: hwmon: pmbus: ti,ucd90320: Add missing
 compatibles
Message-ID: <de1281ef-26ba-49d9-b832-967f4298806d@roeck-us.net>
References: <20250701-dt-hwmon-compatibles-v1-0-ad99e65cf11b@kernel.org>
 <20250701-dt-hwmon-compatibles-v1-5-ad99e65cf11b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-dt-hwmon-compatibles-v1-5-ad99e65cf11b@kernel.org>

On Tue, Jul 01, 2025 at 04:00:44PM -0500, Rob Herring (Arm) wrote:
> Add several compatibles already in use to the ti,ucd90320 binding.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter

