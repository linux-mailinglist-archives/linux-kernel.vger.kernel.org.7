Return-Path: <linux-kernel+bounces-693696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290DAE026A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F92E167934
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE83221F16;
	Thu, 19 Jun 2025 10:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kW/KnEOW"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598CD221F28
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327850; cv=none; b=loySW9AGc9He24QU2tu6AU6N0C+XWdc4rle8vlVCvyHnAUo3kweiTVdEBl4H8jDsJue0vNlzq9F0AqvfQ0udjWNEAr2B2IYXpfhjAf6Zz54Ok1Tmp9Jt60d9YiA+nS9ZTkTNwfZfeLalh9z3OKZlTj4u7QWj7vmgsirWI4RLgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327850; c=relaxed/simple;
	bh=hHqKAmuilssQpAIAOYxJlpJjZqO5f+LEmYaAgwzbgWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayalv7hWaBY9mzPmtG/NFfk19uvXUc1sJx3RhpDcpYnKquf1kC4E/jrnRT+1iI+pQ8csNAmthcm+xHTFGfT3FeNdx99/8r4BS/1fGQQOOntzxVX7GAWaILrxIiDgcLdJ8lz3F7gWR01m3cO5N3XJ0vcxTOcJct/IRGLcdsQuwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kW/KnEOW; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so554682276.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 03:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750327847; x=1750932647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VkMa7zCOwJFBXp4u830hcQ72uAnUwDe4mfF5t4wTHIU=;
        b=kW/KnEOWrfhXevVCYQzA51wI/gGzm+w3Dtije48nRcKnjuew6pqcUVxFKDC+yfL/w4
         9nv+rtPpxJ+FO/ob+op9h6905mWJMKu2t+H/ifkbvNgQjRn3tgf3shlEXzJ6+qf/nsr4
         HLiOjahK0hUELeDxO2CGbr/Q/NXSGOGfUBMdCrx8c8ROV+ykgrCQ24QFA0cmUAtsUOZe
         JjDQWcNlGTDeKpaRKiCgtdOtIT9y1YDI23KcJMyHJguA3u5fWISBghsovEsJOdR+gxJF
         5ERgrgAbmaTy0ea6kuvSYBmyBXBTECoq9kXma1g2s7S2df4uzjp3jB9OfwPVTn6Lp+hJ
         48yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750327847; x=1750932647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkMa7zCOwJFBXp4u830hcQ72uAnUwDe4mfF5t4wTHIU=;
        b=Sgl09LZEabUnRJ0zhATqhR5qHI0Jsp8osWdVJbmPxBYAEcFjZsr+N2zBCDmf1FO81t
         BDp5wtEenDWVH45YgQ2yw7Mu9xHxZsVdRSIffpEj7KiMVL/JLFhxGt9T5pbgcO6MO4cM
         l5wc3zwP9lYcXEXJt+bsv4QDNtgZPnXlMLFiZ/D4pdyW+m86hly9qaaR1PxNVGqZSLhd
         Pz1lk5Fm77TTWDNZ69aX77cq6P5hewHmXof6vVctS4vNPYyNxG9DZ4p0fOXHmt5cclBv
         DEOc+Hf01jqZxAnzty7CBDI+Dz/qv86xpIOApQlld5/ekzk82XnWjmRDCLQnDhwRcySu
         97eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj/Kri/OrhVtidz1B2c4CMIKKTASNMCyY07nRNX9qkowvcEHaGVRi0qsqqYsq1W+5qp2lTfLvW5T2oSQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeRM9x+ZXS8TFtHDQrQllq+nYI6yOGjrAFGpFfBJfs3tlSV+f/
	54TzoxPCnFStlwoDfBCCOxJgNGF/pLa6/P2/904LxSVY2xG20mTsAbb8ihBVwJHJx9MB9eeHoKc
	oHqDev6XY5YYoK6i2P8Aq/wiKV2/j7/YPyKsVJ5IDQA==
X-Gm-Gg: ASbGncv/ZfJoI63n5vWXzEzLe8Zlis6QZgn2szp5jK1CyuwOPGguXRBcdXy5f+y1+lU
	umZApFOgmYAb5SEeSgZF2Xt6g1tpTBnG7Ln/mR7Kl/WtLRx7ENPEOMAYQOqe1UR6c13g01nk3mD
	5IJOEChOy377FTc03Q/Wwg004LykAhmX7DYbDGhuUda9Gc
X-Google-Smtp-Source: AGHT+IH5AnJNTeaOpQfhCSIOt0GGrB4zzpiy2QbI+yGdJHsyyZt9Nll5fYWwGlsxCE+duvtf5q0NiWwdDhOmdVRkycw=
X-Received: by 2002:a05:6902:1a4a:b0:e81:5197:3dd5 with SMTP id
 3f1490d57ef6-e822acab8d5mr26603182276.1.1750327847290; Thu, 19 Jun 2025
 03:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com>
 <20250613-pmdomain-hierarchy-onecell-v3-2-5c770676fce7@baylibre.com>
 <CAPDyKFrO9rb0eDb2qO+EGaVjOFG=7emgca8511XACDhWY=dt5g@mail.gmail.com>
 <7hsejzp4xg.fsf@baylibre.com> <CAPDyKFo-iPBPgkM43q+5cGR2sptkLk4E6TAERCQbCu24o1RfFQ@mail.gmail.com>
 <7hcyb1os9y.fsf@baylibre.com> <CAPDyKFpTgAmLBq2ZExPoxWM0wL756zH96vW7M6wHSA1MTTG1wA@mail.gmail.com>
In-Reply-To: <CAPDyKFpTgAmLBq2ZExPoxWM0wL756zH96vW7M6wHSA1MTTG1wA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 12:10:10 +0200
X-Gm-Features: Ac12FXzaqfxrAphuKw6VXAdZX7cnfQhXcwTzb-TGim72mKFJI9xJDvfwXzajzx4
Message-ID: <CAPDyKFo0Cu0OkD9BgcLTAhme4k1FWKJ=yPiP6o7ofEN6AKVrZA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 2/2] pmdomain: core: add support for subdomains
 using power-domain-map
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org, arm-scmi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Jun 2025 at 12:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> [...]
>
> > I've done an implementation with struct device_node *.  This works
> > better (IMO) than struct of_phandle_args * because the caller (in my
> > case scmi_pm_domain.c) already has device nodes, but not phandle args.
> >
> > The result will be that the pmdomain helper will call
> > pm_genpd_add_subdomain() instead of of_genpd_add_subdomain().
> >
> > Below[1] is the current working version, which includes adding the
> > helper to the PM domain core and showing the usage by the SCMI provider.
> >
> > How does this look?
>
> It's a lot better in my opinion. Although, I have a few comments below.
>
> >
> > Note that doing this at provider creation time instead of
> > <genpd>->attach_dev() time will require some changes to
> > of_parse_phandle_with_args_map() because that function expects to be
> > called for a device that has a `power-domains = <provider>` property,
> > not for the provider itself.  But I have it working with some local
> > changes to make that helper work if called for the provider directly.
> > If you're OK with the PM domains approach, I'll post another rev of this
> > series which includes the OF changes for review by DT maintainers.
> >
> > Kevin
> >
> > [1]
> > ---
> >  drivers/pmdomain/arm/scmi_pm_domain.c | 12 ++++++++--
> >  drivers/pmdomain/core.c               | 34 +++++++++++++++++++++++++++
> >  include/linux/pm_domain.h             | 11 ++++++++-
> >  3 files changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
> > index a7784a8bb5db..8197447e9d17 100644
> > --- a/drivers/pmdomain/arm/scmi_pm_domain.c
> > +++ b/drivers/pmdomain/arm/scmi_pm_domain.c
> > @@ -54,7 +54,7 @@ static int scmi_pd_power_off(struct generic_pm_domain *domain)
> >
> >  static int scmi_pm_domain_probe(struct scmi_device *sdev)
> >  {
> > -       int num_domains, i;
> > +       int num_domains, i, ret;
> >         struct device *dev = &sdev->dev;
> >         struct device_node *np = dev->of_node;
> >         struct scmi_pm_domain *scmi_pd;
> > @@ -115,7 +115,15 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
> >
> >         dev_set_drvdata(dev, scmi_pd_data);
> >
> > -       return of_genpd_add_provider_onecell(np, scmi_pd_data);
> > +       ret = of_genpd_add_provider_onecell(np, scmi_pd_data);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* check for (optional) subdomain mapping with power-domain-map */
> > +       for (i = 0; i < num_domains; i++, scmi_pd++)
> > +               of_genpd_add_subdomain_map(np, domains[i], i);
> > +
> > +       return ret;
> >  }
> >
> >  static void scmi_pm_domain_remove(struct scmi_device *sdev)
> > diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
> > index 88819659df83..3ede4baa4bee 100644
> > --- a/drivers/pmdomain/core.c
> > +++ b/drivers/pmdomain/core.c
> > @@ -3220,6 +3220,40 @@ int of_genpd_parse_idle_states(struct device_node *dn,
> >  }
> >  EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
> >
> > +int of_genpd_add_subdomain_map(struct device_node *np,
> > +                              struct generic_pm_domain *domain,
> > +                              int index)
>
> Providing the struct generic_pm_domain *domain as an in-parameter for
> the child-domain seems unnecessary and limiting to me.
>
> Instead I think we should parse the power-domain-map DT property at
> 'index', to find the corresponding child-domain's specifier/index and
> its corresponding parent-domain.
>
> In other words, we don't need the struct generic_pm_domain *domain as
> an in-parameter, right?

Having said that, why not skip the index as the in-parameter too and
just walk the list of the power-domain-map DT property.

In this way, there is no pre-parsing needed for the genpd provider
driver - or need to try all child-domain indexes (not all may have a
parent-domain associated with it).

[...]

Kind regards
Uffe

