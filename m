Return-Path: <linux-kernel+bounces-893413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B60C47510
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E69B4EA994
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC603148CD;
	Mon, 10 Nov 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="E29/fQu+"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA530F945
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786019; cv=none; b=bFUcXGfZVEBsZZY04Wl1XpXZCHj9a2a5985kfUJ876CTc4asf4nDly4Xbrd2juEIE3p2rtIGyuXaspZbk/K6Nj5ypgh1gdJ6258gahskH2Zx9Gs7CdjxVmUTd/ZS9OFuc+hAwWGScWzxWdzewxXnmltfPOBS5WJcUX7bE3BtI0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786019; c=relaxed/simple;
	bh=Zgbgz6Xx/nSV21RSqp5s3ioY3dD/63laARY8w4Ccz+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwF1PL3sko3YqquGkRSrFEajZANE+mxYkRQlmAqsDP6oOXW2dP5WhodUsD4hJkzN3KVseqORTGmAXnR8lqcJ82+olCA/JfJD50Sg4c6/g5TJu1y2+6f3jAe72xZwlhTjnql4InqUe2wc9pHyjLMWxvwyJFpQVfkcHq8PDSLiiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=E29/fQu+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ed6882991aso25158691cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1762786017; x=1763390817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZfgovMoQxmHp2PRQokeGmF8rpreis0QhadSzO4SeuQ=;
        b=E29/fQu+OECf16//0Gw2F96hzOEzofYIE+WA973ykgeZPYGpaRQtyw817e+mnvW+va
         2u/358IbW0Y0CAeiq+B0fAuPI4OMsatH0/64lwjunbpt++0YtQAAH2zm+VxwBf84kUOG
         ShoSikFHE0X5ujvmFqOcdW1rOvvuHctm5hEqsxp0OZXLeqj2yNr3vrchgwJFrke1wDJi
         Hg4t+NUP82YASWCyzzyf6+cVG5qMFh/kOY0zerHYwJyEi2/i3jNtU/tii2r3P5g80WV2
         74K7zyS3+N6cqgI8VeF3AL84MAQlDGeLCngoxVA04DtdejWGnOcMfeaFRe7E3zSwM1//
         SJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786017; x=1763390817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZfgovMoQxmHp2PRQokeGmF8rpreis0QhadSzO4SeuQ=;
        b=FFGJGTPi2LUg/sEjzi1ELtNokhxhmrSE7VCkAY7zKMbgi4G257ATUVcaIHlR4fX97d
         FZpyqMSOTaFfvszaenwx99Cu+RR1teNmSLYReTCtaV/c8c7cTXG2/Bv0DJDbaxQA8EHt
         Qi+Q6viVD21xGeGbtIm1acikccrM5VKXPB3ya6PxdliYTBZYZXVmYTttpg23+VXYXTBk
         Mqqx/8oiv+NF9iLmoICdoKkzNoX0uur7dyY4keiMHaiilvWB5DR6IJQoi4jEwX05ten1
         UhkGnBmGsIaQcmsysG9DLjDhcu50ZK6IFwy/oEUUvDzsmYCnREFIFho6Y57IuzrFcLbu
         8yTg==
X-Forwarded-Encrypted: i=1; AJvYcCWJRLgVk9pMd1f5cQ8Vay+9pYFOFwyZPxV0BSEcWie+OSfZB5b5yWE9JBSRyvQbNJ+DYRk+UqC9y2p2qGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz497kObNyjluCg3KMx9AKASABNNaWoRyp+AG7Ua87XM0chGxNb
	DK1Qq1IDtXCnYBKsxFCArju+eTkG0swn3u6qLGnBx7LaBglMZqL/jpbK/CbExoYUUGO2h883xF/
	DO80Myw==
X-Gm-Gg: ASbGncsEAr/K3Kjf817R6wCl8n4U2IlzyTCbKLxM0nFmBTrOP9R21s1U3BM4UAXMSBV
	VWgOeGXdX5U7M4sj8D1hA3vJ2TtL5Lt5vNtIiWKd8/zxoTHZ8RPl0yETYkpfB1M7ah+LILR8Q7q
	gpey9T8Z2WcG798VcPUSzNFi3u9eNZXo0+nYeJ57nmnEBTofOAj/4GG54GGbfHgD/l5Mh+hzmMI
	sDcHYSxDCoRg877nklb6cynvqAvKieUnqibRcVS0c7U2x2d6uBtN+Dh3pHXPgMovIAOBZkIf+6z
	yF6GmoLFD7CyKqpWnHJR1u9ga9WlFSgY/+ZEh55A8XgFh0ufLmtw9NzaqRt/6zZ8IpZoQkVz9IC
	w8y3D/OTyKO5UltQW7hpIrVyKjSoNXb7s1UBDMTX0Ihhr1d4/0sTJUAFwg4YHyZErufqE77yIDO
	IyopAHVSvvDMac858c8L0=
X-Google-Smtp-Source: AGHT+IHrvbbLLIzADaEDwAYPzqYzdSj271EqD3XikN5r8c8oqm2X595zkIdy1ah5lygJoU9kCZZiNg==
X-Received: by 2002:a05:622a:1cc3:b0:4ed:b134:58e5 with SMTP id d75a77b69052e-4edb1345e86mr63104731cf.12.1762786016296;
        Mon, 10 Nov 2025 06:46:56 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda56132c0sm48284811cf.7.2025.11.10.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:46:55 -0800 (PST)
Date: Mon, 10 Nov 2025 09:46:53 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, gregkh@linuxfoundation.org,
	p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com, geert+renesas@glider.be,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 2/4] usb: host: ehci-platform: Call reset assert/deassert
 on suspend/resume
Message-ID: <74790e58-f1d1-4d7c-9b75-4176af44e1ff@rowland.harvard.edu>
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
 <20251106143625.3050119-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWDGpqdhCsA0MJqoL1JAiyVR-TA2YqDe+-S9Xf6c5O-gA@mail.gmail.com>
 <64c74f86-7438-49da-b164-a8a113e47c32@tuxon.dev>
 <CAMuHMdXG8w9jR9gr4av15VT69XNouqys5z4Rxx-nidnvnbN3dA@mail.gmail.com>
 <5edec052-5e65-4d00-a182-6675ce579be1@tuxon.dev>
 <CAMuHMdVqaQ=E43Wrg7GtDD_MGS5ibF9o1DfpDCAq-=F=Exph_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVqaQ=E43Wrg7GtDD_MGS5ibF9o1DfpDCAq-=F=Exph_Q@mail.gmail.com>

On Mon, Nov 10, 2025 at 10:29:22AM +0100, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, 7 Nov 2025 at 19:42, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > On 11/7/25 10:01, Geert Uytterhoeven wrote:
> > > On Thu, 6 Nov 2025 at 19:56, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> > >> On 11/6/25 16:52, Geert Uytterhoeven wrote:
> > >>> On Thu, 6 Nov 2025 at 15:36, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> > >>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>>>
> > >>>> The Renesas RZ/G3S SoC supports a power-saving mode in which power to most
> > >>>> of the SoC components is turned off, including the USB blocks. On the
> > >>>> resume path, the reset signal must be de-asserted before applying any
> > >>>> settings to the USB registers. To handle this properly, call
> > >>>> reset_control_assert() and reset_control_deassert() during suspend and
> > >>>> resume, respectively.
> > >>>>
> > >>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>>
> > >>>> --- a/drivers/usb/host/ehci-platform.c
> > >>>> +++ b/drivers/usb/host/ehci-platform.c
> > >>>> @@ -454,6 +454,17 @@ static int __maybe_unused ehci_platform_suspend(struct device *dev)
> > >>>>         if (pdata->power_suspend)
> > >>>>                 pdata->power_suspend(pdev);
> > >>>>
> > >>>> +       ret = reset_control_assert(priv->rsts);
> > >>>> +       if (ret) {
> > >>>> +               if (pdata->power_on)
> > >>>> +                       pdata->power_on(pdev);
> > >>>> +
> > >>>> +               ehci_resume(hcd, false);
> > >>>> +
> > >>>> +               if (priv->quirk_poll)
> > >>>> +                       quirk_poll_init(priv);
> > >>>
> > >>> I have my doubts about the effectiveness of this "reverse error
> > >>> handling".  If the reset_control_assert() failed, what are the chances
> > >>> that the device will actually work after trying to bring it up again?
> > >>>
> > >>> Same comment for next patch.
> > >>
> > >> I wasn't sure if I should do this revert or not. In my mind, if the reset
> > >> assert fails, the reset signal is still de-asserted.
> > >
> > > Possibly.  Most reset implementations either cannot fail, or can
> > > fail due to a timeout.  What state the device is in in case of the latter is
> > > hard to guess...
> >
> > In theory there are also failures returned by the subsystem code (e.g. if
> > reset is shared and its reference counts don't have the proper values, if
> > not shared and ops->assert is missing).
> >
> > In case of this particular driver and the ochi-platform one, as the resets
> > request is done with devm_reset_control_array_get_optional_shared() the
> > priv->resets is an array and the assert/de-assert is done through
> > reset_control_array_assert()/reset_control_array_deassert() which, in case
> > of failures, reverts the assert/de-assert operations. It is true that the
> > effectiveness of the revert operation is unknown and depends on the HW, but
> > the subsystem ensures it reverts the previous state in case of failure.
> >
> > For the case resets is not an array, it is true, it depends on the reset
> > driver implementation and hardware.
> >
> > Could you please let me know how would you suggest going forward with the
> > implementation for the patches in this series?
> 
> Up to the USB maintainer...

If you don't have any objections, the patches to ehci-platform.c and 
ohci-platform.c are okay with me.

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

