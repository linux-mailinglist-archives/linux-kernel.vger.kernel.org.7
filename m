Return-Path: <linux-kernel+bounces-811662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4E9B52C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85071BC3EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 08:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42182E6137;
	Thu, 11 Sep 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JZRFB0Ke"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B92E5B0E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757580739; cv=none; b=MPZzhDKJUQ2hhmooO3kJJiRuYHvlhJ00aHh4YUdAmqsdhdYNREkAf8KmbHR7HbCc3b2oGgCwYvdSwFNz9QLsPmJUMNeOo4/HzkTOBKL5HA04yd0RbD/5wOfWOj9znBNCwLsvygdmiKqzkvlAoivH0okYTUCL+H/1O6fMvjee5/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757580739; c=relaxed/simple;
	bh=kZ5fy3elgau6E9A2kLbn2WoncgvNZoGo+/fR8M35qT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMhB/hRJa/mAbsWmnOJaPPzqizfPgPM3X5foqqZ8qW+ewFIF0gibWHeEyFDGOolgG4kr0jK+w+llDiPFsZ+5AJDoEa+2eV+jsf1Yed17HkmAYGjRoOxh7HWHRrIo4ZDh46qBfHVLYS3kPRgqt6GSXT+rB059cdG6COHydZyu0LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JZRFB0Ke; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e46fac8421so444480f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 01:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757580736; x=1758185536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8qJmsLMZ59bKpzRgTLez2aQP8hw0rBkTZMNNSe6hBQ=;
        b=JZRFB0KeLs8Ij4PmVWP7EmYXSooGPShhxU+UiJRDgsvBIHwZDgdROxL/Wp7q2N4bRg
         h62SQ3YcaRwTXu0JzH1CVWZ+32dm6vfClYIjpOjvuk+csJDo9YbeKlSVmrl3SjZHs6sS
         GP3cgC0uaec2t/6hfMnRa9+Y/cSkhsr+8evdzITUULWyUzvfoXU+K8UhC4NycHScOC1G
         6x8T2mJIIuANu0jJe5XGs4hJJjEybp3L/anh3X8E5L6T/9l+yQpgcL25j+5t/SA1kCyo
         CQ/J1FhyQXMGeFZYQBLmNQkxcC6LL4OKxGLwHgKGCpt4amBDlRLYJOp4lIrzxniwRzIz
         +4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757580736; x=1758185536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8qJmsLMZ59bKpzRgTLez2aQP8hw0rBkTZMNNSe6hBQ=;
        b=ONtdYymBe4G3Y7Oh5u6gA1gUHjDE54YNSCZloMbAxjEk9iC3I5gk2ZBP0IW1h23cl/
         +RrswTbW9baDwCWcsUY5+LIkXpm+8K9QcLCWUA1VbqJ+5iaVu+/wuKlUJ2O6PQRP+vQA
         xIkNJ0UvbP+QrADK/766DX/gUKOPIGX99DojQOE8+rdMKT7I2IAwTrzzYDwapyfQmBsT
         /hzfDWHgzEqRaG1BHVF0hBc0YZubq+3uuvbvT3FHM5EzSC1I4iZEOEZq1haiPEH2inAb
         7T+c54LGdHLC/owILFuavLWLUHNIWLZqAqmWuuO9eLUg5dJTUhiuXg9zojtYne6P5cWy
         kqkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPyop/hMPmUYnTC7umyyIVBLpf8hhKr52Dd6zKuW9SrxqLCSQzF8dOJRBtk/BxoAIYdDxRgOOGFgilZGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmobgiYbHTnCLRL1nHVSyTUuEL2FveFeC+gkADHGNMq+SmVxp
	mBlaxFsyS3BL0EvnPmUcOArTSiSpLJwcB9wToPhGR5hEF6Pq9Dg8T3IDxMNIK1zyYhM=
X-Gm-Gg: ASbGncuTRrxS9xh/loYe9ZoOosSiLLkXduy/r6MvKazQ5B1Jdl63dfyhkk786POr9Ob
	r2NV328pL0k7BzLPANhH05aF55juIBk3fIa+bmF338E5Ggme0KpXfwm2rJL/T89TJfJCxhIgc5u
	y3eqZ/oYwmjRkmjCb+QuHhMwupQGjSvzqrlxFe50iAIdq+a2WKU/1M4BZRt8sqCAgHib+44Yy3y
	Yt9qAFMiTfCQaGrFPOpxOAZXas414vJXLYwYnPpT7CoDRl+cVP82qav3TwvHMr7qvDBzDLxbeBX
	4DB6WGhYByn8EleLWROLZq96tLhXm+QdAUNUTJZyRBeBUAnmhjr5ZOiejSQ58KHK/dZjZHWeTO9
	zBdqhGP94QqgCyd3At8LM8Q==
X-Google-Smtp-Source: AGHT+IHqlhwEH3jYn5iJwUlpidH2lKZr/CFhHYU+IwRD/boV7YUGofPRtjLqATt1fADPaiU6f8KjMQ==
X-Received: by 2002:a5d:588c:0:b0:3e1:6b:bb17 with SMTP id ffacd0b85a97d-3e64c4a8213mr14929470f8f.48.1757580735700;
        Thu, 11 Sep 2025 01:52:15 -0700 (PDT)
Received: from linaro.org ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786cddsm1619682f8f.14.2025.09.11.01.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 01:52:14 -0700 (PDT)
Date: Thu, 11 Sep 2025 11:52:13 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] phy: qcom: edp: Add Glymur platform support
Message-ID: <wetzewmbraeawwintmxqntjhvennq5iu2jeegel3glk7y6rsnf@4vwscm5bwezr>
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
 <20250909-phy-qcom-edp-add-glymur-support-v2-3-02553381e47d@linaro.org>
 <3bo2xr3jb3hrzsetjzd62dmcif2biizvoanxwtyhr2dmkb4g7x@dgrcvzujcwgq>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bo2xr3jb3hrzsetjzd62dmcif2biizvoanxwtyhr2dmkb4g7x@dgrcvzujcwgq>

On 25-09-09 14:12:46, Dmitry Baryshkov wrote:
> On Tue, Sep 09, 2025 at 01:07:28PM +0300, Abel Vesa wrote:
> > The Qualcomm Glymur platform has the new v8 version
> > of the eDP/DP PHY. So rework the driver to support this
> > new version and add the platform specific configuration data.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-edp.c | 242 ++++++++++++++++++++++++++++++++++--
> >  1 file changed, 235 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
> > index ca9bb9d70e29e1a132bd499fb9f74b5837acf45b..b670cda0fa066d3ff45c66b73cc67e165e55b79a 100644
> > --- a/drivers/phy/qualcomm/phy-qcom-edp.c
> > +++ b/drivers/phy/qualcomm/phy-qcom-edp.c
> > @@ -26,13 +26,15 @@
> >  #include "phy-qcom-qmp-qserdes-com-v4.h"
> >  #include "phy-qcom-qmp-qserdes-com-v6.h"
> >  
> > +#include "phy-qcom-qmp-dp-qserdes-com-v8.h"
> > +
> >  /* EDP_PHY registers */
> >  #define DP_PHY_CFG                              0x0010
> >  #define DP_PHY_CFG_1                            0x0014
> >  #define DP_PHY_PD_CTL                           0x001c
> >  #define DP_PHY_MODE                             0x0020
> >  
> > -#define DP_AUX_CFG_SIZE                         10
> > +#define DP_AUX_CFG_SIZE                         13
> 
> If it differs from platform to platform, do we need to continue defining
> it?
> 
> Also, if the AUX CFG size has increased, didn't it cause other registers
> to shift too?

AFAICT, all platforms have AUX_CFG0 through AUX_CFG12, we just didn't
need to write anything to the last two so far.

