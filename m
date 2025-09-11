Return-Path: <linux-kernel+bounces-812060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7C0B53265
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B041A84218
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33604322A0E;
	Thu, 11 Sep 2025 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p/hfNz8F"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC0322A08
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594018; cv=none; b=sH1a+ZAldGSv5DcuXOneF/p2EwpSDZvFQJlsxO9tt/XQdbPj9lgec9B2OsWAb0dwDYYL1/N6OCgZ22z0dwpevuBQXXyZsx8yDFm7oYRJAuwIso59RQeOzklXe+njFGm70msmBjB5qwjCF9lHiQbL9nBuid1+elBUhQb040k8cGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594018; c=relaxed/simple;
	bh=VE1roVfRus68bBPTerPNOcsbtdx+CTPzLCSXO4Sv5PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu2+cEOle5BBgvJi4LpMzACgzaqxAdmMWroSHBwCWksi2EQA4hCeQW1gl0QuZs+SJyvReN+HPpr5YG6XfFk6FziWM25srbmquPwT4rGcNISXQ/C8OcmH4Fgg+hVM53oK+07kpa6SFOCwCUthAjvTkShAYdH2GW9rxU5hyI9ZjNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p/hfNz8F; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso4501915e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 05:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757594015; x=1758198815; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=77w/BLu3louQ5LAeAyTpxsMARQdOP7fXiEQcpRRVAfE=;
        b=p/hfNz8FyXbfz8wSydDkHFhvFh5pbEd3jnxW8vjsvF8CqiJwvrRoKYDrpP07Sb/wc6
         Z4E5IQwNqJcN7dINKaFHD8gB41HuuxKSdPk3pv0UhcksdM7XNpqOa61z5ZVjmletvrx+
         EYvpaWNvp1NlxoomYo/odLPdDwOxybfUA1HRaGtclHj7eaICViJ0S8SzS/fGkUI1RT7O
         Y4JKxdMazQneyfjFAfIzc8nKCar970Rr0eWaucl5MOYHLnEK1XcIhmXH42CNN1aQcnS3
         BZVNjURcWLEkFDJlhARcVwnDE5s8Drc5HJiRtGgzV/QtFECKm91QpuvTWfWTRp7YpNnO
         58Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757594015; x=1758198815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77w/BLu3louQ5LAeAyTpxsMARQdOP7fXiEQcpRRVAfE=;
        b=myLVX6XlMiIQvqAsiex1Tdf3dHbHx9LW2KWjo9JpPLJ8VuTODlY+758xT3QU1SH0Zm
         3n15f6eevcsdc6ay+kRT1IwIvaUjdqzXeSI8UHozdOAMo4h/5je9MgeOrEwIYvsOCrRZ
         8C3N2SA4e05/33tVRyK9uA0C90THfturPgjbxuDyG7A/okxnY/KOr/D/2rR+m8ScwDg3
         eY8t25sxsGyGPFLiampu7fq8z5JGUmKw347I73g5DONLR2x3LyrlR0mK1zbRc/pVl60E
         zfSx3qkaSwyQc/tPSD3/DbhTvVXLwL8TpkTi0GcqPgTgHTDHiYkh5+iJ3ERSabAG7gMW
         9t9w==
X-Forwarded-Encrypted: i=1; AJvYcCWQNDpjo8TMs4gFRf/jEz4N9lf43lV3nHXpkiyTkymlG6+JLKBD5kQF8y7e5m9YVnCykNdGOT3P5n6THqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3piCLODsC9zCkfWluCX8bnVTOAUpElX0HxUwpCDcMr56/5y3
	bgG45Vj1YEaZ5lLrFXMvJs6d1wWQH20sH5+7zaFMLA8Tjdg3xsl3cnXr85XThsSKVaU=
X-Gm-Gg: ASbGnct3LrfI97Pro2TjXyBrESLvBZj19UoWB6+642fZe2dMNf3vOKwh+fOArEbs7zx
	dWkmYYHbguLHXW7zns980OVrkyhqQNpVRmgWn0MjFcPMIS0PR+36m2Rj3pCQXiR2EMbGy0m6rak
	8jcaehSKPAtfgPYShr4FzwyQBxGQKOLbe31EbN/1iVA8O2kBG+Me152dX18Pa/9iAyTBmkLnqqS
	iOItICM51vtweljmzrHG1KoOdayOg6soSVwbuxw882neoD9tdufMB9ZCsTFi8ZtO2o6TxNb3f6Q
	8Si2ylO1HZmNE7HpXUqYSjbOwDAQiisj95reC6rNkUfIqIejPHRGTF6oSjj2jq+ShFEMlUBNuJk
	kllaYJITf2EhJJlnP5SM5rA==
X-Google-Smtp-Source: AGHT+IERNyAnFxuua9N1uDZtOVhilat+DKTgWSq+/gMo1aCu3TqF6Sb2iqngQDwNMVzvjL69GHQfIQ==
X-Received: by 2002:a05:600c:1993:b0:45b:8b3e:9f66 with SMTP id 5b1f17b1804b1-45dddeb93b3mr157844605e9.13.1757594014898;
        Thu, 11 Sep 2025 05:33:34 -0700 (PDT)
Received: from linaro.org ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0153fbd5sm13210085e9.5.2025.09.11.05.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 05:33:33 -0700 (PDT)
Date: Thu, 11 Sep 2025 15:33:31 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: qcom: edp: Add Glymur platform support
Message-ID: <2mcs5cov44frxyvg3k3nuov3zedaoc6ayd5dpoh7r5kcsxa5eu@qrqxpvnrkgj2>
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
 <20250909-phy-qcom-edp-add-glymur-support-v2-3-02553381e47d@linaro.org>
 <3bo2xr3jb3hrzsetjzd62dmcif2biizvoanxwtyhr2dmkb4g7x@dgrcvzujcwgq>
 <wetzewmbraeawwintmxqntjhvennq5iu2jeegel3glk7y6rsnf@4vwscm5bwezr>
 <fff688c9-af7d-43fd-a3f1-00209842bcc9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff688c9-af7d-43fd-a3f1-00209842bcc9@oss.qualcomm.com>

On 25-09-11 11:18:53, Konrad Dybcio wrote:
> On 9/11/25 10:52 AM, Abel Vesa wrote:
> > On 25-09-09 14:12:46, Dmitry Baryshkov wrote:
> >> On Tue, Sep 09, 2025 at 01:07:28PM +0300, Abel Vesa wrote:
> >>> The Qualcomm Glymur platform has the new v8 version
> >>> of the eDP/DP PHY. So rework the driver to support this
> >>> new version and add the platform specific configuration data.
> >>>
> >>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> >>> ---
> >>>  drivers/phy/qualcomm/phy-qcom-edp.c | 242 ++++++++++++++++++++++++++++++++++--
> >>>  1 file changed, 235 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> >>> index ca9bb9d70e29e1a132bd499fb9f74b5837acf45b..b670cda0fa066d3ff45c66b73cc67e165e55b79a 100644
> >>> --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> >>> +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> >>> @@ -26,13 +26,15 @@
> >>>  #include "phy-qcom-qmp-qserdes-com-v4.h"
> >>>  #include "phy-qcom-qmp-qserdes-com-v6.h"
> >>>  
> >>> +#include "phy-qcom-qmp-dp-qserdes-com-v8.h"
> >>> +
> >>>  /* EDP_PHY registers */
> >>>  #define DP_PHY_CFG                              0x0010
> >>>  #define DP_PHY_CFG_1                            0x0014
> >>>  #define DP_PHY_PD_CTL                           0x001c
> >>>  #define DP_PHY_MODE                             0x0020
> >>>  
> >>> -#define DP_AUX_CFG_SIZE                         10
> >>> +#define DP_AUX_CFG_SIZE                         13
> >>
> >> If it differs from platform to platform, do we need to continue defining
> >> it?
> >>
> >> Also, if the AUX CFG size has increased, didn't it cause other registers
> >> to shift too?
> > 
> > AFAICT, all platforms have AUX_CFG0 through AUX_CFG12, we just didn't
> > need to write anything to the last two so far.
> 
> I checked 7180/7280/8180/8280/x1e/Glymur and they all do
> 
> It would make sense to perhaps spell this out explicitly in a separate
> patch

Makes sense. Will do.

Thanks.

