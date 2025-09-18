Return-Path: <linux-kernel+bounces-822116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4343B830DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F941896809
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E82D7802;
	Thu, 18 Sep 2025 05:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vM+QcwdY"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861DD2D7391
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174967; cv=none; b=tCRpigpqBYJ2RTTUUE1XQxeml0uxMFBkFv7mzWnSrrmCcnWBybtiA/4zGR25OpkhhULwZknT1k4NAe0WEpIYKTJafSx+7CWRs0cPQ12KatkvPNJmoh2QYJdPc/qyp7V5KYjxzou0WZOXsEjTwNbmm9jr+9L3+TOLWD3t9uM9TbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174967; c=relaxed/simple;
	bh=MtvCNWiMVnsL+fP/NF0hiCxoJi0DUaViJhCKPmRyngw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABWr2xQWOA+pm5KHVkPpxexXr+qylcQCZ+JofCkLZZtzHDmjtcDnC/HRiXEVZHvA4xBJj1ocV4UHf4g5SfPTE1kw61EgyGQTfgu90cUBoA9dLzhYUitfINSi3yWmk1VGOllQCwRy8ZCNzOzbrWBCYLUJm2IQp5s9Xka1ytfbfKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vM+QcwdY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso740161a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758174964; x=1758779764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crkj1xqggaMTh9oPYxb0RXj1qaPHLThFfXIKjj2cn5I=;
        b=vM+QcwdY2P+3Maa1johRsRZg1Txz8wupuAtxuUSLM9/5RmqY6LdGIXaPpDo70JB7LL
         m7LI4TKxYVFrV7/v+vFAQsTAxX3BtBENUFtnkGIMIr/GyLmb1yb2foeK1EW5jN+qemRZ
         xb3LXEpb/aRzmEQZHPL/jZe6rEe263ShoL+Cn1bMgS6aJt3MLRhWYxVYfk+VwqthzZpF
         RUuL2V7yWHTj1a1FMi5mbKPp+mHsIK40cRLsKJmEDxclSMvkCvPauFZtLhY5fzgN51Sa
         jd3zlLDDDHO6/ezMwcJzcK9L/g9IZtNhiLTv0pXFfNvPG27J3whJ4W2MoiNe0Xalhnl2
         /lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174964; x=1758779764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crkj1xqggaMTh9oPYxb0RXj1qaPHLThFfXIKjj2cn5I=;
        b=QEvxhHBdP1Y1PSneByKonpU4CAhSXSCKOBQhPGP6Bc/YjLQJrb4b5qAy5Cs4zEl7G4
         WTVYdgIlOQC5hb7HQuVYwRBc+q9QzTutdf+6R4bpnOyJp68VzLYf8lxAus0LAjylrHri
         yhAO0uXC+qaBPUTrlJIkRbj+/3UsDBD7dxasX4f/jQr5WHGLct59qiBx0KM3K42vf+Nv
         ypr5IwWqEt9OIJP/sPHkB7GqwadwZoZypy+ogNYFP+C+KEtRLZ8hOJc4I7j609eJ9O6S
         +W1pPozZHSylD4zg4Q/1jJ/wxNAOBErCkvDsodPpW53gzOCTuoM1ch4h9FsMJfpvHymh
         sFPg==
X-Forwarded-Encrypted: i=1; AJvYcCUsQxLHtfR8nmL0RlGGZcgpVvB6GdmxMUWE0PfVSs0wJknxsE61aUOPK4E56WVaUNvcUHWrcA9utxYhaW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Ft6MWbGxIZ/nL+XJzGg7HDChySEDQzcAuGEDtZj6g4Elebnc
	a++o4k2Zweh1aKkL9I34neZO309gqQtLp4FguQ3UMhkb0C2oYr1T15uXCdZoVWm1i/ri0oefQZR
	qgSikiZP86vw/m7L+ohguqGrEI0GrWhy4gB9PAe7S6Q==
X-Gm-Gg: ASbGncv559XsgsV6PdpNu9y6c6AowiqMLGkolqGEybEeQgQrfsf1EaTu3aT85SP8Ver
	xLxz4C1FQVgz6AkQR1pS04IXooTzb8WRNYuC6znl6wmhzcGYHy1b92mfUs7h9Ju0FAwg5B4HnV8
	3awz69PuTqMRJ60sLc8JUKPfxBBDYRQyfc+oEP/82SHMVTjiNygAVxeHJdOilxUvgaHjxyqiZ8/
	rfQpAZ0dv4oL/MzXTJr8VowKnyr12pz3KByz86APAnWb3V5oZIQ7HM=
X-Google-Smtp-Source: AGHT+IGR7nTIOBAlrh93nycdh2C4wP1m8EWpmRWv6aiZAFrIZWDDf8XTFM9Ow/5GHA8Zx6KHRGOD1LFlVtecDyn67Xg=
X-Received: by 2002:a05:6402:1d52:b0:62f:4be5:2268 with SMTP id
 4fb4d7f45d1cf-62f84231d4dmr4414232a12.19.1758174963640; Wed, 17 Sep 2025
 22:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-2-vincent.guittot@linaro.org> <20250917211825.GA1874549@bhelgaas>
In-Reply-To: <20250917211825.GA1874549@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 18 Sep 2025 07:55:50 +0200
X-Gm-Features: AS18NWDMnG99kNALQoafVcWPwrQuqGOxmbLVsuUCgARppc3AjZboY6ARustWRK0
Message-ID: <CAKfTPtC6bGYCoUuMZSX=kx0uR1XS1rHKzY99tkTQa-hUigmpPQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 23:18, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> Suggest following convention for subject lines (run "git log --oneline
> Documentation/devicetree/bindings/pci/"), e.g.,
>
>   dt-bindings: PCI: s32g: Add NXP PCIe controller

okay

>
> On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> > Describe the PCIe controller available on the S32G platforms.
>
> > +        pcie0: pcie@40400000 {
> > +            compatible = "nxp,s32g3-pcie",
> > +                         "nxp,s32g2-pcie";
> > +            dma-coherent;
> > +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> > +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> > +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> > +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> > +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> > +                  /* RC configuration space, 4KB each for cfg0 and cfg1
> > +                   * at the end of the outbound memory map
> > +                   */
> > +                  <0x5f 0xffffe000 0x0 0x00002000>,
> > +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> > +                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> > +                              "config", "addr_space";
>
> Looks like an indentation error.  Shouldn't "reg-names" and subsequent
> properties be aligned under "reg"?

yeah, that's a mistake.

>
> > +                  #address-cells = <3>;
> > +                  #size-cells = <2>;
> > +                  device_type = "pci";
> > +                  ranges =
> > +                  /* downstream I/O, 64KB and aligned naturally just
> > +                   * before the config space to minimize fragmentation
> > +                   */
> > +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> > +                  /* non-prefetchable memory, with best case size and
> > +                  * alignment
> > +                   */
> > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> > +
> > +                  nxp,phy-mode = "crns";
>
> If "nxp,phy-mode" goes with "phys", should it be adjacent to it?

yes, this , phys and num-lane should be together

>
> > +                  bus-range = <0x0 0xff>;
> > +                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> > +                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> > +                  interrupt-names = "link_req_stat", "dma", "msi",
> > +                                    "phy_link_down", "phy_link_up", "misc",
> > +                                    "pcs", "tlp_req_no_comp";
> > +                  #interrupt-cells = <1>;
> > +                  interrupt-map-mask = <0 0 0 0x7>;
> > +                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
> > +                                  <0 0 0 2 &gic 0 0 0 129 4>,
> > +                                  <0 0 0 3 &gic 0 0 0 130 4>,
> > +                                  <0 0 0 4 &gic 0 0 0 131 4>;
> > +                  msi-parent = <&gic>;
> > +
> > +                  num-lanes = <2>;
> > +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > +        };
> > +    };

