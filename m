Return-Path: <linux-kernel+bounces-892658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A39D5C458DC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B70A189037E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352042FE568;
	Mon, 10 Nov 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQoamAS+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB661E492D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766104; cv=none; b=nlixj/axdXZb2Z6l7slLwH1kqIz4PWyYjC2hVCU7Ll6raXus4pUwlRplpgC9BgRR0iY7+Y2HogTQEnHKTA8KYYqTlRzW4xuOyxtn1g6KIpV8RBDGBOrCFiU3RjxC+741dy1k0tE6SB5dZjJ+aju6j8OLcMECpenQe5dD/YcJfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766104; c=relaxed/simple;
	bh=2+PqvTsIgaNTk/7uCk6kfDMTr3xQc57xAYsQHUDudqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2poz10TEZiq0j+FHbBJSBBSATs3W7dt4BygLq6PsSxR6cR2QrE4fxST8mLryT2rjIbf6VDd8ObNm5lBspfBsJnok+tQF5yc1c34JOREZXqcPjGPhpgckCl8xYrVjIXT7XP8x20xIiks4d+OIlNo44K/AE3WJGXFa9QJgYQqykU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vQoamAS+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so5004771a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762766100; x=1763370900; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NXFnmmWcp+T86M4X7Xk/v6jPWKY4nv9UjyUBijcqLEQ=;
        b=vQoamAS+F6pl8KkrO4lJUya+bpcXEx8dhbKTFpTLD+It+F8omkDa8RI+2okKpdY6QB
         VSWW434xasv65TJG9tI/z8ZigUUcm9NM372aCXsb+RnA6OZjZAWe40iQCMGPOLX+1SRF
         /aZuGzH7tqG6ATJsXY7zpeiYSb4tdxthPOyPkuiLesZj/AT+4bD84pp+otQIuChATLTa
         Wbuv0xsGlzBav0wTKFJMkUWlvNlxWqXsBmlyKnc3XC4fAyusM5WlPuf3ZyvT2WWX5Aa0
         J1+fVcTxXOjuFtcDGhCGK7uLw2CSnmKodnUBpuuNZQIT6oreu58No8/Tnh1txiziwCiW
         LQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762766100; x=1763370900;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXFnmmWcp+T86M4X7Xk/v6jPWKY4nv9UjyUBijcqLEQ=;
        b=Gl/vYXF58lg1kZuCNr8xiL5skAHI2PcnoQfBbxnmIqG+T28BHzo4q1PZcmHCVbhKsl
         ZHGIEX/jVuraNoh8dfVqSouRIFapIoshhdTYjcFpLBQ4/hjUEfszJ9EG279QbPpdpXmn
         JtbVm7xuo75WFcZ7Qf04ftcpcM6Ivya7PG4PLyr9hWd5RORdu2Ciedu2D0OTeEYPF6r3
         IjvDlV8hGE3nO9WJfgL6I+U2isy1Pe7Ub26rM0QpV4T4dGrreOSBaGSEwzBTazT3oCGX
         40Uiq/IwnpraSmfEF4tP5l0g6C572KZ+gLSJZ4jd1aM40eqKUAin4bykFRPuddRftuHc
         q79g==
X-Forwarded-Encrypted: i=1; AJvYcCWN/Mrz5m25HQ1/MKKPiqXWZ55PmdOuHcVzf80v48L/WYlOf1iyK8kWuzmNiYSdwARjI8sJvx9Np6fEaUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KkRxm7ArovmbpwuRxIbh5BrXloLaTm5axF8MKAte8QBIMg2c
	IDRNWlJWQFssUkB01L3OZUZHcNLFxZ/GQ2kkaEqkKObin999ynQCsVkPeCw+xD2QMpOdWEaBtbI
	J/2+xQf9aI3aTbZeOcoENV0pc4nER1HtM+2FT5ed+sA==
X-Gm-Gg: ASbGncu+fYHo0Prlpsop4vurR9ADQjTFtuT+WA6C+4bhW/s53QHyaZn3LYWqLcXT0oc
	xQMWMMf0tu1xGulcA6rTwgmh6aocIdGCdbWRp2PXpiWcv+tAWVXXkPZLpgGcpFTWNlOlMGw5a/d
	N+4kTBIV1vWjGOLzxV8lc7l8FukGZcxD/+dXgOys1J4WJLgz1DiKeeCzOxe2lpzHe2UQ0IotXKq
	Lhk5sYD9Jw0omMP0qEgiQ8Ztacf2d7xRqN+7vKvbaG0o0+RiimRY1XBM8VaYjpymcvusSAaubpq
	gGzqDPeE7oJS+UFu/CZgNQojPG3CpFbLvGU=
X-Google-Smtp-Source: AGHT+IG5jsntiKbL9XDoTScxbX6sK0/o8ty8iuXm+qmOqxUowPC2iS+ovEiKsBoSdXQkOeKy6r5NlaZELkfmqB0OJxc=
X-Received: by 2002:a05:6402:26d0:b0:640:cd2a:3cc1 with SMTP id
 4fb4d7f45d1cf-6415db564bbmr5934589a12.0.1762766100006; Mon, 10 Nov 2025
 01:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfTPtC87w7RVSDAXWXRX1sjgo4s=_Z_k62+mfTXrMZwmkEpFg@mail.gmail.com>
 <20251106173853.GA1959661@bhelgaas>
In-Reply-To: <20251106173853.GA1959661@bhelgaas>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 10 Nov 2025 10:14:48 +0100
X-Gm-Features: AWmQ_bmdJnu871GRec3avwkB2KMRGJUSatF4zpeqoF6tG3-YU67MrrGvp-or-eI
Message-ID: <CAKfTPtD3UUXq=PwBJKx2q5VEBbAie-M1XgTbx3hmxZV1yQGBww@mail.gmail.com>
Subject: Re: [PATCH 1/4 v3] dt-bindings: PCI: s32g: Add NXP PCIe controller
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, chester62515@gmail.com, mbrugger@suse.com, 
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, bhelgaas@google.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, Frank.li@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	cassel@kernel.org, Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Nov 2025 at 18:38, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Senchuan]
>
> On Thu, Nov 06, 2025 at 09:09:01AM +0100, Vincent Guittot wrote:
> > On Thu, 6 Nov 2025 at 08:12, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > On Wed, Oct 22, 2025 at 07:43:06PM +0200, Vincent Guittot wrote:
> > > > Describe the PCIe host controller available on the S32G platforms.
>
> > > > +            phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> > >
> > > PHY is a Root Port specific resource, not Root Complex. So it
> > > should be moved to the Root Port node and the controller driver
> > > should parse the Root Port node and control PHY. Most of the
> > > existing platforms still specify PHY and other Root Port
> > > properties in controller node, but they are wrong.
> >
> > Yeah, we had similar discussion on v1 and as designware core code
> > doesn't support it, the goal was to follow other implementations
> > until designware core is able to parse root port nodes.  I can add a
> > root port node for the phy and parse it in s32 probe function but
> > then If I need to restrict the number of lane to 1 instead of the
> > default 2 with num-lanes then I have to put it the controller node
> > otherwise designware core node will not get it.
>
> I think it's better to put the PHY info, including num-lanes, in Root
> Port DT nodes now even thought the DWC core doesn't explicitly support
> that yet because it's much easier to change the DWC core and the
> driver code than it is to change the DT structure.
>
> That will mean a little extra code in the s32g driver now, but we will
> be able to remove that eventually.  If we leave the PHY in the DT
> controller node, we may eventually end up having to support two s32g
> DT structures: the single RP style with PHY in the controller, and a
> multiple RP style with PHY in the RP.
>
> We'll likely have both structures for many existing drivers, but I
> think it will be simpler if new drivers can avoid the old one.

Okay, i will add a RP node

>
> The eic7700 driver is an example of num-lanes support in the driver:
> https://lore.kernel.org/linux-pci/20251030083143.1341-1-zhangsenchuan@eswincomputing.com/
>
> Bjorn

