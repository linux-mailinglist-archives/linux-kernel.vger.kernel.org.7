Return-Path: <linux-kernel+bounces-871922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1EDC0ECF5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3679719C1F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EEF2EC096;
	Mon, 27 Oct 2025 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HosMZAWT"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882F023D7DF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577430; cv=none; b=Cfm9Vg1nHD31K/2LrA+5bUKKTdclWmfZy7zmHvBcKFegBA4bSlwZ3Z3fK7V6yXffQgM/XscAyJffmnVe1OVKr2NXl/t4C3bTlxnZNCrDkH+9U89/vVN3b4Vvo0W3h7GYR9lblknTf3I2gSzQV57sq6HZRHvzPrmKwyFCdM99BWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577430; c=relaxed/simple;
	bh=FR8f0o9ghG0deDpmoGKVQY2Rna2kf/qaf+nd7kZylfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoHC06d80BXtK1MBU7wvgkbe/PXByyEi7UXk1szJqJTl9UPxZKxZXJOiABCgfKuXgGnOJAxu2Mr2lD3Uk7/eyCkhoUuOD+ezxyy3rCEY2n3hn6GnEvLeMP0RKwzrvQZuxZTD8eLQICqLzdhHgn8H5vrmOiyyWGgYHUCK5T7v96U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HosMZAWT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso16665045e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761577426; x=1762182226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UKpkOIXxwDv4N6ETMPC6x38UtxY2L9u2nMKcGEac270=;
        b=HosMZAWTnBI5fHKAvY7Zzfa/ysWPhbKKwFzKnL8A76vumBaTbIM9wc4glGVaDuYuRF
         7aTqQeZea9vtgJ+T6nTuENckZg8hlj6HayU/xA3D+/PZSXVYzdakiaHq4kMf0ajobAN1
         NHJuddPTdwdMz0Yu3+HUpigjGKYhNfbq3PtqweXETPIKxAIFWjxrVAB8BE4JFC0iMne3
         XouzqXEqsBKSHEehL0GSx8RAQKR+Kxqzb/XqnwE6KJvRgj/Rihk3dO223rHs+/0cIw80
         AShFXr2HvQKiMeDVoDDWraj2IBBx2gnBBLBmq9avHEkuEfp5j4x/cUGWrh0sbRNb3mvj
         JAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577426; x=1762182226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKpkOIXxwDv4N6ETMPC6x38UtxY2L9u2nMKcGEac270=;
        b=cd2RXztWGB9TsqiQqB/8Xx8X6WPKJ2zFNoh6dRkifm8ul81OctPNb7jYD4ygFw2eV4
         CgE2113WCC8DkYqd5llmVGADZ1QWor8SiZmPPjyidRe4UWtTZw7p8DFyjACpUmzrPeeD
         PSOtKHNa2o6Xb9zb4qurl99yrQTb713frRoMGUXfnyTi58536GGAWSAUZY0XdaI3S/f9
         0zSrk2MQAX6swNSC1QXO/uhPe0D2bevNSrwzZKfodaUZ1yXS15WLN7E+R4M1MW+8v7Nv
         2FM2D+qV7HQN3OPCzPqseYSdgqFwUkssW4n5X3JkRzq2S0KLd86QdB6qO7dJMkMZEWZa
         M42g==
X-Forwarded-Encrypted: i=1; AJvYcCWxFP7X5SLav5E4eATRhe/zGSgDe9lyvIoRrrPLkRYJicenYN5pqdSd0PS5DlDTG4IeboTp01stgRX5+Bs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FasNvffrUaY+sxFrG7HPhqII51PxzNZ5BU5+8NBED4+EwPxV
	5kZw6QjlybEEg6zk5zAX6zhu1Wpu4Ma6jdAKdsinb6+ocl0HZKYOP1dk9qTz+dKr9/4=
X-Gm-Gg: ASbGncvHL18geIOJiRwZnsIe3X5s/n8tO3jeLPUKxcqIPaVMQDaV6tbwVujK55v5cQ8
	ADgKqy0vtvHSeZ3uUb28+A00lQrmUEXvW/ZadUoAaoo/PjYGyt92C2kfq5gzNScpQkTET/Q4E41
	suxuPR9Wn4qTrllJ2npPAbtF4TKHdikYVDlk70jJknGwNziQ1SXUmwhR4dgHZTTdF9phB68SM6Z
	WCgwWS3iDrxSfW8IqIBla6Y3RXOctGwzL786HoYWGcrTE8B1/qJd62jJZ//7khxK6JA6k2zo1zB
	9mjLm41sYAX/VsWWMD9wspaaQAc3g4lIztzOXadRILLqlADsppjBIMGOS0pl2XKpo4l/SGeJhGQ
	z/RkNo4DfTbgYprTkYpK9F+Lfwal5BZynr9EmAzdSeN+R8ZpboaMjQ19rT3H8FwE6uz0ioQpQ
X-Google-Smtp-Source: AGHT+IGdgZKKc8tkom/y4GwEbztmjQrk8NHF1ywqGi+zVO4NSb3Xu2bsylUy9DS3LDmgv6YYp+masg==
X-Received: by 2002:a05:600c:1da7:b0:46e:4be1:a423 with SMTP id 5b1f17b1804b1-4711786d630mr260978135e9.1.1761577425808;
        Mon, 27 Oct 2025 08:03:45 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddccaaf5sm68399545e9.3.2025.10.27.08.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:03:45 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:03:43 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] soc: qcom: ubwc: Add configuration Glymur platform
Message-ID: <vngf7cnsj36ddg4pdm72airm2nketxk3m34qw6f65ompimpcfl@r3lbv73tmutj>
References: <20251014-glymur-display-v2-0-ff935e2f88c5@linaro.org>
 <20251014-glymur-display-v2-7-ff935e2f88c5@linaro.org>
 <7dxq62ltoeerb4g2fgchb2hd7eomvlexfgyvamxsuuirblavtn@4bg3dy2bukdq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dxq62ltoeerb4g2fgchb2hd7eomvlexfgyvamxsuuirblavtn@4bg3dy2bukdq>

On 25-10-27 14:29:01, Dmitry Baryshkov wrote:
> On Tue, Oct 14, 2025 at 03:38:32PM +0300, Abel Vesa wrote:
> > Describe the Universal Bandwidth Compression (UBWC) configuration
> > for the new Glymur platform.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/soc/qcom/ubwc_config.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> 
> Bjorn, do you indent to pick up this patch on your own or would you ack
> merging it through the drm/msm tree?
> 

Please note that v3 is out:
https://lore.kernel.org/r/20251027-glymur-display-v3-0-aa13055818ac@linaro.org

