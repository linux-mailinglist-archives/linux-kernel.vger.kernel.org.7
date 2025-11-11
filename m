Return-Path: <linux-kernel+bounces-895336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C7AC4D7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 257D834FD27
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE09133B6FB;
	Tue, 11 Nov 2025 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hgy/cESx"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351562F7444
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861765; cv=none; b=IBAQhPKH4Xk63Fvy39ArB0MTf9ez+iTNblprSMnF3bbcl2j+kUL2OqNXCZoMcrCh501GCGYjD70X1rntupyku/ibTf/SR6vUzd+HDeG66jpechsiNHaa0VYmpDo8TpFnOUkg9lXhMtROiz2v6IWn6t8hopw7rIKc8/d2VQ2gbH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861765; c=relaxed/simple;
	bh=lc2UdYjJR0sjNTBD2oKa4cB+uC349vhWvRxB6lMSxjE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhVHdXb5iWDixgsu/ETwV/eRO8b/Jo2I0fjiXZbQ8xSXR+QI9RZ+wvfotZNiPPedWZ2G5+s9onyrihI6sfsuLfjfIohnoLe6esqUNtw/objUj6iUxnCbDZM3Jthmz0MHUYMQ6TFHOf0wmTYa/p8tIUtjxMAuRuUiReVslyHlQ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hgy/cESx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7277324204so721437066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762861761; x=1763466561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NW0M5blI1g+flfpcZDgej7OD3G98bZF6Q7a2G0Rxs40=;
        b=Hgy/cESxvhIMfJUSZcbzV7sQ4VvfqIKedfzurl+VrnVCJv0QfsS3rER1JFFvmqhLTX
         k8mm0hFnENTVc6QbqbjNDDUSplhro6O7eDQtM9RfyJ2XAf0M9oIIXuVcNh8AEdGzm0Jj
         qFMdZ96Onjb3T3ohZC/nT3VDMyqmpvoklxUvAwWlf532c8lg+OmgMdgpO6+aqMRA5jOU
         r9Es/+79E1KWn1Z/iadfeNCRNoiZUSMLmFmH+LHHqsQo/C88W4uTLpc2oo0DupGRxiED
         f+87qmu+nEznoVJ1NRzfZQLTZ40d+9Evqh92y7D00UT4beKh1smr4hegWU/Rf3jOxkN+
         q4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861761; x=1763466561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW0M5blI1g+flfpcZDgej7OD3G98bZF6Q7a2G0Rxs40=;
        b=GinhvBGXOHOY5go5Q/4M+N81Mz1WbltB4nftFPSzm8C45MRsWuNvLtKtkXS3ucJEaq
         RVZqIzXmHnVbYE2gJTMAnmt0qygZPSVs4YBfOOo6E9A9tNPdeJqwa00Vl8fS9vxDiwQa
         hFTtHletYBJ99eGU7TSBYUMccHSfxN/O3dfZ3ATPvEVB66wQjy92G8lBZD4JM1yZ7L+V
         g8WcSOR+k8YJpauB/ZNSrRp5S5KKItb3dkukm7jy2E/PR+RnYGz5cYUymbKSDeAhiVeJ
         /yQBzRqa7jJfBYE6cg67QvMR1lmqPTanaTl8hqA7Uba1bK4XOJ76SuBBBs9v0QXnddHK
         btGA==
X-Gm-Message-State: AOJu0YybWSvP47zZApM/Pmim4zd10p8J2wfOFnHsP3x8qk3POK5KxNw0
	F3QsuF/lA3xpkjokg0YRZ8n92G6prlUwCoT1IMIeG85l97we6t/w4k/axiKI5KFfDn4=
X-Gm-Gg: ASbGncvRF7ZDl0ehvDr0LSVi9eykk81i4KAju8wpYc+48xKXVghNWgNeFPIfeeJXJYh
	D3SXj7E3Q0OpK1p7O1dUNxf2KORmspOhwZt80w+hMeGE05TtKZ+XHViUQuncH5F9N7EB07XGJf8
	hRbBnizjFWABbwYyRfQMMN+yi+TjKarJOZhtqZDyw4tyqY9mkQtWuj8G/0zKkKwrwX/46sm7k+R
	H5QNkJ1UP+X8iE4UqsyqScTY7ltPdKh0YVNY9ZulGee/+qa6/m4NB+gaWHxcUYY7fFTnV2UZQ8z
	7zrmW90h2hC3EEfq524YbHCAVhpzH9bm3lRcCVMgR5XDIRxZFqXytZFPL60uVRkoulCXL58j5XS
	iOa1yKU0hBaivuk4jtdzXfmqoRS2kp3UymDu3vt07H5q3jd1YlyeoAURWLfPSb+QzPMCEeIT5Ua
	bBzPeEklqcJL4oyOv/XFl7PCNDPuLXjeEAifrVackqeZNKnw==
X-Google-Smtp-Source: AGHT+IEur0fUlJ4dCFXlsi8JzvD/wZ2A9nQhErrr7cgLwLwwk3uLtEzsliARx6fvO2CXD/kozSEzLQ==
X-Received: by 2002:a17:907:9716:b0:b70:f2c4:bdf7 with SMTP id a640c23a62f3a-b72e04154acmr1265627866b.31.1762861761499;
        Tue, 11 Nov 2025 03:49:21 -0800 (PST)
Received: from localhost (host-79-49-235-115.retail.telecomitalia.it. [79.49.235.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcea51sm1319505466b.4.2025.11.11.03.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:49:21 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 11 Nov 2025 12:51:40 +0100
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lee Jones <lee@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Willow Cunningham <willow.e.cunningham@gmail.com>,
	Stefan Wahren <wahrenst@gmx.net>,
	Saenz Julienne <nsaenz@kernel.org>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 1/4] pmdomain: bcm: bcm2835-power: Prepare to support
 BCM2712
Message-ID: <aRMjTHnmsw98G4iX@apocalypse>
References: <20250917063233.1270-1-svarbanov@suse.de>
 <20250917063233.1270-2-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917063233.1270-2-svarbanov@suse.de>

Hi Stan,

On 09:32 Wed 17 Sep     , Stanimir Varbanov wrote:
> BCM2712 has a PM block but lacks asb and rpivid_asb register
> spaces. To avoid unwanted results add a check for asb existence
> during probe and also add a new register offset for bcm2712 to
> control grafx_v3d power domain. The decision to use the new
> register is implicit - if asb register base is null then the
> driver is probed for bcm2712 (the other supported SoCs have
> asb register space).
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  drivers/pmdomain/bcm/bcm2835-power.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c b/drivers/pmdomain/bcm/bcm2835-power.c
> index f5289fd184d0..1d29addfe036 100644
> --- a/drivers/pmdomain/bcm/bcm2835-power.c
> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
> @@ -79,6 +79,7 @@
>  #define PM_IMAGE			0x108
>  #define PM_GRAFX			0x10c
>  #define PM_PROC				0x110
> +#define PM_GRAFX_2712			0x304
>  #define PM_ENAB				BIT(12)
>  #define PM_ISPRSTN			BIT(8)
>  #define PM_H264RSTN			BIT(7)
> @@ -381,6 +382,9 @@ static int bcm2835_power_pd_power_on(struct generic_pm_domain *domain)
>  		return bcm2835_power_power_on(pd, PM_GRAFX);
>  
>  	case BCM2835_POWER_DOMAIN_GRAFX_V3D:
> +		if (!power->asb)
> +			return bcm2835_asb_power_on(pd, PM_GRAFX_2712,
> +						    0, 0, PM_V3DRSTN);
>  		return bcm2835_asb_power_on(pd, PM_GRAFX,
>  					    ASB_V3D_M_CTRL, ASB_V3D_S_CTRL,
>  					    PM_V3DRSTN);
> @@ -447,6 +451,9 @@ static int bcm2835_power_pd_power_off(struct generic_pm_domain *domain)
>  		return bcm2835_power_power_off(pd, PM_GRAFX);
>  
>  	case BCM2835_POWER_DOMAIN_GRAFX_V3D:
> +		if (!power->asb)
> +			return bcm2835_asb_power_off(pd, PM_GRAFX_2712,
> +						     0, 0, PM_V3DRSTN);
>  		return bcm2835_asb_power_off(pd, PM_GRAFX,
>  					     ASB_V3D_M_CTRL, ASB_V3D_S_CTRL,
>  					     PM_V3DRSTN);
> @@ -635,10 +642,12 @@ static int bcm2835_power_probe(struct platform_device *pdev)
>  	power->asb = pm->asb;
>  	power->rpivid_asb = pm->rpivid_asb;
>  
> -	id = readl(power->asb + ASB_AXI_BRDG_ID);
> -	if (id != BCM2835_BRDG_ID /* "BRDG" */) {
> -		dev_err(dev, "ASB register ID returned 0x%08x\n", id);
> -		return -ENODEV;
> +	if (power->asb) {
> +		id = readl(power->asb + ASB_AXI_BRDG_ID);
> +		if (id != BCM2835_BRDG_ID /* "BRDG" */) {
> +			dev_err(dev, "ASB register ID returned 0x%08x\n", id);
> +			return -ENODEV;
> +		}
>  	}
>  
>  	if (power->rpivid_asb) {
> -- 
> 2.47.0
>

Tested-by: Andrea della Porta <andrea.porta@suse.com>

Cheers,
Andrea 

