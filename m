Return-Path: <linux-kernel+bounces-822455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CAEB83ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30D3480D68
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C30280A5A;
	Thu, 18 Sep 2025 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSIodTy7"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFC28F1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 09:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189281; cv=none; b=tSjvoMG+xDYaLDH6/0VAA4GTY3bwjrs9iwrNlVmykkEd/wD1s12na213HYmcWQ/bpdMRObttLDfHMB6CdAfg2QaPF2fN+4US5YOZ13miXybXGfuss5jvldkZ9Qv/TWlwJyD9/9oyFmpfka0uWoWbe7nVUCQitOwRCZMkWCvyRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189281; c=relaxed/simple;
	bh=HvpH/we1i8j6YDiaciJy38Drhc0hF4JJPv6YA9NqLZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDPffwhP7pvzasbaV6XF7MtQgZebCkeqLCae8JDFEDWiLT0dm3ngx2emwuUmQVPXaPWj9S36kDciXXwvWU2A2nBv9YUDFrKrlhTV1zIY1N/t4qJntXbXhpW/Cx2AN/Lv96hXVCcZNRWTeOYMHznT62cmHGf6FZ+op4QYTRZ86kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSIodTy7; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso1370192a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758189279; x=1758794079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3uhf87DrC/GqYd1AzAwWRkEB5wkIeXkNvqHSQcwwy4Q=;
        b=WSIodTy7iljYjesgsd6VPAkcROQzsgZ21/VGGHsoiRHyTWb5zCr1Iyfj+hfhTF8jZU
         8YIyVi8SXNvVO9xjIzBkfaOCiOAe600uuckRekGwOAiOtM/RqjWimK5929zZmDek7lfc
         iRn3vg5RsqZj3XPT2D9oQ8oZ0saHPhxL+LKdJ1EmdDOvRztrynueKcLBkec/9kAUVflY
         5Ns1DtCvxmK2PiVD/7oyDuo3gd+4bmJqQCcnouqYoekAvQ6/1nWJAXSru6KXgrLbLIEC
         FrFu9FyHwpqGrM2XEOvfNCTEQqLL6TOd6aep1pKJVOw1L0UG2UyRjg2I8ZP4MI0fjQWT
         ly6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758189279; x=1758794079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uhf87DrC/GqYd1AzAwWRkEB5wkIeXkNvqHSQcwwy4Q=;
        b=sN+CFfCPTLNkcAa26Stq8TDLTInZ2aHqVFjMlhL7ds+RCVBAmcv/DTQ6sb+cOMUzhp
         XbjBBpif1QO3bocL7qWHObYnsekYUdSDbaDn8oGsZ8sclIhNYgaPIz56hp6ROSe5cDzx
         D3P6iENuNr0A5tZB+YL1tqoR+Y3HfzFpcagLRFYSfbPZIy1ZTkTtKjouu1YtKF3GnSTy
         Zp9PN3Q5ZvY2y8Getuvf5VAm76uZw37+3IimQrK4DpMLXYQ30f7xez7PwBxAE7aAP8qt
         H+jCyHDKeF/uZWIF5GBjl6+/GbsNZOR/pelVfabqUPTDq8nLSm2jEju3zm48UluYGY55
         8lrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUaZ+fBG/wI5MJow6kTwetW7TDBKUtKusTa9mySOq0oyZSIeZAAxRBOyzzIdOj5NeFs+LBoYiy9vEAD6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylOigyaDSdAQXarQHKhViHMEc1aGWxaNFDRzzxYvAUpwTGB2Qs
	CR46EdG3Y2lBD9zNKdtp3Irk+tph6Se6AosU35k3Z7WKpyv3W8mCkv5j3j9Qn3uDm4yPgtkjr4b
	QXVgGEalw3mvOqUoE2J94gKB4XiiFpJNWeAX4lJkjxA==
X-Gm-Gg: ASbGncs+xpm+s1UW8xQ/NjCKUsJZVly3pPF5KJBQXfSXJvnd7yl5Q/fhFBtkNlrK+xg
	WwQvSRSfoaIBDm72jVqG8Xe5sFLV1FZTOwpggxe2rlKH+aMwE80TRDiQNozjKDnfQ66t9df6b9/
	UgOoj30ian77sK9twx3gnvBKCthmZc5S5LlXukYcbHCiqLYH+joqmNKt+2AbxNVyIWHtml/q4aR
	rGKQxFtm/P9HVfjPatVBdIOuvyOKBJ0NIKe6fGZOMFzpnDOP91Z
X-Google-Smtp-Source: AGHT+IE1zmv9oHlYf6BUBNOW+SUyz6ajjYN0b3+2pAlc66/NC3KjbbHlv5KbLza2QpbO9MoNOwx3daqo5CZgA0JV3IY=
X-Received: by 2002:a05:6402:2115:b0:62f:7968:e1ca with SMTP id
 4fb4d7f45d1cf-62f84798527mr4551388a12.38.1758189278612; Thu, 18 Sep 2025
 02:54:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e236uncj7qradf34elkmd2c4wjogc6pfkobuu7muyoyb2hrrai@tta36jq5fzsr> <20250917212833.GA1873293@bhelgaas>
In-Reply-To: <20250917212833.GA1873293@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 18 Sep 2025 11:54:26 +0200
X-Gm-Features: AS18NWDHkrQ8kASDtWOuxujVdqn0GrRUTOJ77F2So0WyDmX2EIKvc-v29xTUv-g
Message-ID: <CAKfTPtCizQ7nk3P4Dzi6uFewH5GcAnMakMt5=bK-Ykayp3t7XQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, chester62515@gmail.com, 
	mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com, 
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 23:28, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Sep 17, 2025 at 10:41:08PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Sep 16, 2025 at 09:23:13AM GMT, Bjorn Helgaas wrote:
> > > On Tue, Sep 16, 2025 at 10:10:31AM +0200, Vincent Guittot wrote:
> > > > On Sun, 14 Sept 2025 at 14:35, Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > > On Sat, 13 Sept 2025 at 00:50, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > > > > > > Describe the PCIe controller available on the S32G platforms.
> > >
> > > > > > > +                  num-lanes = <2>;
> > > > > > > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > > > > >
> > > > > > num-lanes and phys are properties of a Root Port, not the host bridge.
> > > > > > Please put them in a separate stanza.  See this for details and
> > > > > > examples:
> > > > > >
> > > > > >   https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
> > > > >
> > > > > Ok, I'm going to have a look
> > > >
> > > > This driver relies on dw_pcie_host_init() to get common resources like
> > > > num-lane which doesn't look at childs to get num-lane.
> > > >
> > > > I have to keep num-lane in the pcie node. Having this in mind should I
> > > > keep phys as well as they are both linked ?
>
> > > Huh, that sounds like an issue in the DWC core.  Jingoo, Mani?
> > >
> > > dw_pcie_host_init() includes several things that assume a single Root
> > > Port: num_lanes, of_pci_get_equalization_presets(),
> > > dw_pcie_start_link() are all per-Root Port things.
> >
> > Yeah, it is a gap right now. We only recently started moving the DWC
> > platforms to per Root Port binding (like Qcom).
>
> Do you need num-lanes in the devicetree?
> dw_pcie_link_get_max_link_width() will read it from PCI_EXP_LNKCAP, so
> if that works maybe you can omit it from the binding?

num-lane is not mandatory but we can have 1 or 2 lanes so should be
able to restrict to only 1 lane for some platform
the "num-lanes = <2>;" in the example is wrong as we don't need it in
case of 2 lanes but only if we want to restrict to 1 lane

>
> If you do need num-lanes in the binding, maybe you could make a Root
> Port parser similar to mvebu_pcie_parse_port() or
> qcom_pcie_parse_port() that would get num-lanes, the PHY, and
> nxp,phy-mode from a Root Port node?
>
> Then all this would be in one place, and if you set ->num_lanes there
> it looks like the DWC core wouldn't do anything with it.

