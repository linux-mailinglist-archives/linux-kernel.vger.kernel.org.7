Return-Path: <linux-kernel+bounces-686452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38701AD976D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 23:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1960F189DFE2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 21:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D5A1E8338;
	Fri, 13 Jun 2025 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LcRNuALu"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9F1E7660
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 21:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749850854; cv=none; b=NEcK0BUGzQy+msc52LyrEDQulXxvZOTIuyfzF9031Gw/4y5en5QqSvGXsvKncIRdIFmMw37xwZxYlIZFXG3PHZCN/JflMueSlpznJBIxsknGEGHEGlI9ozXR320EChuM91xyY/YiHraeZmC1TOFMcXonALpOoFQqnbSMhNQ7SYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749850854; c=relaxed/simple;
	bh=ZcoeBl1oYujZAp6bxXAb2ArnZ8wEspzdPox2tOMOAVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PhDR3whfD+8BCHTjce8TKl5Sk+pnPBEEg9CXcLTvzEDXR10ApuTax1pKrCtSwgk47vRbePDNyI0NyioTSfV5r9udKn0K4aVXkmez20XsV+Q4Gd7STewoPDQQ6ajbLbfwOSA6p2K2mhjueVvF9fpdHNnqusX1X9LES/ifUHb//7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LcRNuALu; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-47e9fea29easo46221cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 14:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749850852; x=1750455652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM2Ts82lf5QQvFrV+s/2evWQljauh/bsNUGeUyNRzHU=;
        b=LcRNuALugPaCbh5j7w1f5jaLJeU25rtU58LC28ZkS68MrBNrpdkwZMn6jCDgdVEma9
         7xBZgrK8OjSDbbOaUt0NuRs4iF7mQ6HpcmMQMzvd+qbqfzHo6/GxChuaGLiF82JJIvN1
         LlN4gnXqaKz2gSiXCogpy+tV+pXHWA/DE7P7YjbQEKVka7+/IKDHWclqk5+zmz1LkDsw
         VT+8i6b1q6LZJTN2uAU2gJby0Ign9CDiJdaXarsnkIi+g7H44DD4PnOQIojs6Q8lOQi2
         qCNKvCvJDT0IyOx5uiFo6zalU92UWe/I2QJCaQt/QZq542MFaJyErB91Jv3KKBOELP9+
         vGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749850852; x=1750455652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM2Ts82lf5QQvFrV+s/2evWQljauh/bsNUGeUyNRzHU=;
        b=JrxChYdPhKCO2gvD/grV6j1VSToVPqUT7CQjGbVz+tjDM/CAOpTnxHcO/ZbQAw/rlB
         mce3rRRE8j5XMM7K7EeLJANNr8DWNTeLQxikhHIKAloT2l4ynILOQQ1PILyWe7lFs07C
         0h3RrBVeD9WQM+HFJ38ZDu6vaoStqy5KmUgbA0rO9iIW16ijzabPFrq6h2jsx9ahhtLt
         P+s92tfGySypZyDBIEALEwRUBvxfUZ9m6e4cTXtSga9BtTvl7qYXUeJDchSjY1GlA10Z
         QuTN9IckMnQhEx58RgAro5HtaYW6MaTVhtRnUs8fYPfmG7b7LANzTVAEXArN/eoRRG7t
         7QXg==
X-Forwarded-Encrypted: i=1; AJvYcCWcTq0HfYksdKJMexy5cxVTUPYdfxRVV8GYBkztP8khBYvPtoSshIicvKigb1eIg82fVxlZA3Ltkh2A0eE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa24PnadQJGjNpXISdWazRm7jAoCAO4asX4J5yESB3k58q0hCF
	dWDTS2FJecugUHKrgDNOksxMUvU7Yq5OHxQ7LxQx27aeOMztLQCpja3VcyQcURXIqOiagPNGTfX
	MDd74R78dgE3O23edXZtMzv6ojuWebLgXMzwAH9GzH/hzmZuFPwPCsNX+oo0=
X-Gm-Gg: ASbGncu3wM0BtPAoJfsPsleJboOU4ZiDrUDCBFdexJBI7CM8Js+PbG2kPl67dyS2d37
	xr8sFpcvLOPkpA5FQlZ08z60c0xJM8g2GfBHGoBBXLKjHSaGg0IqDSf+Z5JHkIYxMT3/JF2NdNw
	M+8+57/8fkNwpP+t6nIFnzmWArP2n2nAzFYNrTLm2kbCYdPllXXjVYkBkJVuHkYY/iq233iIBnz
	YvD
X-Google-Smtp-Source: AGHT+IG1idNpNGEh1fsqXcIdT6pKKaSZNTI8gzltM9eiWquOgOiErFBOQySl4sbq198P8GJJ+W4YyiKJNaw+aMDYCFo=
X-Received: by 2002:ac8:5707:0:b0:480:dde:aa4c with SMTP id
 d75a77b69052e-4a73d613ef7mr570401cf.4.1749850851523; Fri, 13 Jun 2025
 14:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507232919.801801-1-ammarq@google.com> <56cc4h6daxofmooafh2ifquwtf37jajuaed7otdmkhozfnawz4@5zon6ttwegqf>
In-Reply-To: <56cc4h6daxofmooafh2ifquwtf37jajuaed7otdmkhozfnawz4@5zon6ttwegqf>
From: Ammar Qadri <ammarq@google.com>
Date: Fri, 13 Jun 2025 14:40:40 -0700
X-Gm-Features: AX0GCFs5j8js_AAU9D3E_39hMGItksLQLbdYIFR-SkVPVUr1wCAoLUTCmNHTdbA
Message-ID: <CAFbbpayW+y8s3i4qxzHcoY0Yz5qeAhb7ziey=FayDiZbC_mm7w@mail.gmail.com>
Subject: Re: [PATCH] PCI: Reduce verbosity of device enable messages
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani,

The issue we are experiencing is not caused from removing/reattaching
the device driver, so the other messages have not been problematic.

The vfio-pci driver is attached to each VF once. Clients in our system call
open and close on the vfio-pci driver, respectively, at the start and
end of their use,
with fairly short-term tenancy, which ends up triggering these enable messa=
ges.
This message is proving challenging not only because they are not particula=
rly
useful,  but because they are causing log files to rotate once every 30 min=
utes
or so, and we lose a lot of other more valuable logging as a consequence.
I'm open to other solutions, but in my opinion this preserves the message,
without over-engineering and introducing throttling or other behaviour.


On Thu, Jun 12, 2025 at 11:12=E2=80=AFPM Manivannan Sadhasivam <mani@kernel=
.org> wrote:
>
> On Wed, May 07, 2025 at 11:29:19PM +0000, Ammar Qadri wrote:
> > Excessive logging of PCIe device enable operations can create significa=
nt
> > noise in system logs, especially in environments with a high number of
> > such devices, especially VFs.
> >
> > High-rate logging can cause log files to rotate too quickly, losing
> > valuable information from other system components.This commit addresses
> > this issue by downgrading the logging level of "enabling device" messag=
es
> > from `info` to `dbg`.
> >
>
> While I generally prefer reduced verbosity of the device drivers, demotin=
g an
> existing log to debug might surprise users. Especially in this case, the =
message
> is widely used to identify the enablement of a PCI device. So I don't thi=
nk it
> is a good idea to demote it to a debug log.
>
> But I'm surprised that this single message is creating much overhead in t=
he
> logging. I understand that you might have 100s of VFs in cloud environmen=
ts, but
> when a VF is added, a bunch of other messages would also get printed (res=
ource,
> IRQ, device driver etc...). Or you considered that this message is not th=
at
> important compared to the rest?
>
> - Mani
>
> > Signed-off-by: Ammar Qadri <ammarq@google.com>
> > ---
> >  drivers/pci/setup-res.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > index c6657cdd06f67..be669ff6ca240 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> > @@ -516,7 +516,7 @@ int pci_enable_resources(struct pci_dev *dev, int m=
ask)
> >       }
> >
> >       if (cmd !=3D old_cmd) {
> > -             pci_info(dev, "enabling device (%04x -> %04x)\n", old_cmd=
, cmd);
> > +             pci_dbg(dev, "enabling device (%04x -> %04x)\n", old_cmd,=
 cmd);
> >               pci_write_config_word(dev, PCI_COMMAND, cmd);
> >       }
> >       return 0;
> > --
> > 2.49.0.987.g0cc8ee98dc-goog
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

