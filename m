Return-Path: <linux-kernel+bounces-809644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A48B51063
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76A2482AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6050630E839;
	Wed, 10 Sep 2025 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMUjGtan"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288830DEA5;
	Wed, 10 Sep 2025 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491186; cv=none; b=VL26YClQCfTbrR3l5FPvIT4ncPrgkmjzHkU8zpXkNq+DGfO95DM/m8GffRd93igN/xIe/NbM9canguGuXbrOldF9eGoFkJYSHu96VV4WDhdDfMay2bKqjFbHhVh3YnxaR3c1fHxhx/J/DaSlGPi0jdfaAmQgPZ9H/ypJ595kTEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491186; c=relaxed/simple;
	bh=gHRPiMfD/P1RXxFuG3WCUYCOP8iCBS2qErNi8xfZIf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DP1M0AWrz3HqWdau6omrZwgUdZTnp50dl8MCghHQzLO/NaJikpH4ycn01PJQaUeem3o2Fk6mJyEQRequzkwdZTStBWzR/g/ORsPWgMQN1S31IdR/4pXKBK2vBYiWyHKGdoh5/+id7/EEz4fZTvKB/pI9zbhuhO4b4PvRamweVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMUjGtan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883C1C4CEF0;
	Wed, 10 Sep 2025 07:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757491186;
	bh=gHRPiMfD/P1RXxFuG3WCUYCOP8iCBS2qErNi8xfZIf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMUjGtanNgDMLjWGcM2/wQ7wr07ehIVgPSceSZXUquehEf2KqvAIPSO5EMggjg9uk
	 hbpXJZWWWCpfXhw0LenaPqfUCAS87Z3EvN/xPv8k+3yYcQU4j3Z7h3Zo8tyl7gFITt
	 YOEt7bCNeIMzh2tZlDk8yyi4Goavwxwwq5IN2Wm6RKClqOE2qx5FtDmI0i9AjCpYN7
	 TH/M217lOlA7/J15RXpfhX/y68bWsTBAkZDbNW79f6J6ohVLsvl98Q+Z0Hxiq0crTk
	 dwXDoMWNyvbZmtn1Q2xKQsU7qwjZZ01olNg1c9QRs3GCQIqOt+Q7MeN381lzNxDRhr
	 PxiQO6WlSSp5A==
Date: Wed, 10 Sep 2025 09:59:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Harikrishna Shenoy <h-shenoy@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com, 
	simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	sjakhade@cadence.com, yamonkar@cadence.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, devarsht@ti.com, u-kumar1@ti.com, 
	s-jain1@ti.com
Subject: Re: [PATCH v4] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for DSC
Message-ID: <20250910-silent-classic-vicugna-fdc1ab@kuoka>
References: <20250909054622.1439487-1-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909054622.1439487-1-h-shenoy@ti.com>

On Tue, Sep 09, 2025 at 11:16:22AM +0530, Harikrishna Shenoy wrote:
> From: Swapnil Jakhade <sjakhade@cadence.com>
> 
> Add binding changes for DSC(Display Stream Compression) in the MHDP8546
> DPI/DP bridge.

Also, where is any user of this change (DSC)? Why are you adding changes
to the bindings which no one uses?

Best regards,
Krzysztof


