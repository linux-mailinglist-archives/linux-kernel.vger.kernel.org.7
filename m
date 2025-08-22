Return-Path: <linux-kernel+bounces-781497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820EB31324
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C07189D6CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE52F3615;
	Fri, 22 Aug 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+y63BuS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838462F291B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854888; cv=none; b=e9rimPjX5ghkffZJBaelqezpICbS8kmUoXjw1/Bf1NvF4Wh+gv5JWG4k97KQIpounkBHU+e3TSh19yGrt5KkYVuDGzUkergJtTGCGa3mISmoxOwMoYtVCslz8QpEKh/HGJw2AzdTPQEFWnYA97cMTShbGX1CuaD/n5tWeD7zm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854888; c=relaxed/simple;
	bh=bISrXedBRm1542hk6g7KVXrJFTF811Z2NiT0bOZwz4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/I1k5lxtsS2T/nh66ItE7fAK8RMSvMFxyp6wc6wQNYdG4LhIkWhYkDLhG2WjBzzKcrhw2fjkHSxLUEahKjsGpFsZLmbPIa+uDeLPIfJt5Xw7Tpat33TkWRuPso5i/2c+4cru54EFZw20Uhsr786PibQ3WNuBXNyPP+EHQgA/1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+y63BuS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459fc779bc3so44195e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755854885; x=1756459685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcdOq3/AhZc4gzL/OcA3gLcMXE9NwnaXeS3V/wGL+YM=;
        b=m+y63BuSmWlFVo/kYAHykNLHBpMWPxI19O0xYO/7FYmJRBmAei3Fkq4iKMJR8mE3yr
         V3r//ZoO84puYgxC5RubD/6Gi/fNDcAPNn2l9rLLq9XEzUopJLcK51ikGhZxV+dUTVzD
         155m53bCinqaCMaB6pMw/U+9DPppl/PE8FE9rFzBtacwpLHsu3P4Qh3MJNF+LirdUYSW
         BY19CqrQTSVuMpNhBqB2E515znvDuzUv52TTezWpsKcf4UxNylIs0nm6iWx4pfiN71vP
         NUWQoJJzSNxsAbdyoJlgW7KuOhub8lyqLf2lgIhgXZjrwX7upt8rx2r27SAROaCDbgo+
         Oq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854885; x=1756459685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcdOq3/AhZc4gzL/OcA3gLcMXE9NwnaXeS3V/wGL+YM=;
        b=SiuU/AziDrBwqO0k9+evEi8Z3PKv34r96zLjgD3UhGIV257NhjO7MTdVuZzbnz6OSN
         lDDT/3s2xtJ2Ul2lnwJO/fVdGYi1cGWGxdkObRdU3kKZl47wCCspSrYVfvjD1+I6bQNZ
         QBGvDAXdvVkhGJwSKJjJ+JymC94fnBtPcRFmzAuYfIaDhbYhweIw7piuhLUTjr2/qVdz
         SBA1iTA5NsSims9SXvWqy7y8GnWIdPGLKwHO8ULN8WZyQQxDpp8YZa+06fyAq2j+L787
         +NxDe4ZgHdvnNXCNgA88WjCf9RAMogXCC+kWaBXKu/HDWRsYygGtrlUrYBplZVMYY0wU
         jR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXULQaoabquVWD/eCh3BewJ4AQN5Hina0JZ63UfCxfaf3USzYnXiZ0BRSOMugFtHJzBTn9y0hXqkUCrx2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPvJfCf1nne35kI7N/57c8C2bBkPlzH4FiwvP6EEHMKk2+OVz4
	+Z7fuDUs8g5qK+ef/T0gozWLZVQt3hcxOGTvlmNRdE3rx2XZKN/MQX1TGUEyLA3DX76wcC8j4gg
	9Xf4XSc61Zk7y87LjOgBjpTvt6iHLCWb0Z7nIlFqS
X-Gm-Gg: ASbGncvXL8sb+l4vG7kofOvmHnZ0Gj9lNd1btfzVA6yxkPON9IZO+600TE5VrLeI1dK
	iYXUlpSDBblXawrwhO/uMHpnjqhekpbbZvXEsii9kUF6hXfoBfv1cr+4gwIAdGLAZK+y885ZxlN
	odqzRBQX/m4p3M0jJwZugVrrNd+42N6w9Mk63cDOksozsxm3IQ36JljTG+9bzPoP4v6iwPrE+/J
	pnfm+PJcFSWy/yQxWfL21M4vcdlxSIp7zoA1fLIUOY=
X-Google-Smtp-Source: AGHT+IECdN7Gh5fqjQyNp7ltDXL7VtmhAF9xVecCo7XiPFvuWtgfwPRPVcIIo4icw0CZIP8dQjiU5C5FrDl+Krj73Ks=
X-Received: by 2002:a05:600c:2d47:b0:45b:4acd:836d with SMTP id
 5b1f17b1804b1-45b52128850mr881855e9.5.1755854884609; Fri, 22 Aug 2025
 02:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818060757.2519126-1-khtsai@google.com> <20250821233035.e2yl3yvoq5i4jpdz@synopsys.com>
In-Reply-To: <20250821233035.e2yl3yvoq5i4jpdz@synopsys.com>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Fri, 22 Aug 2025 17:27:38 +0800
X-Gm-Features: Ac12FXzruHBanMhLpp_WNWc69jWB0ds2jW9yuoEE6XI5pqlE8vzK2YCyhFb7asg
Message-ID: <CAKzKK0rrCojqGKh9N8vSHOZkzu27wM88Fj8HQoX38QLD5FVr1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: dwc3: Add trace event for dwc3_set_prtcap
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thinh,

On Fri, Aug 22, 2025 at 7:30=E2=80=AFAM Thinh Nguyen <Thinh.Nguyen@synopsys=
.com> wrote:
>
> On Mon, Aug 18, 2025, Kuen-Han Tsai wrote:
> > Changes to the port capability can be indirectly observed by tracing
> > register writes to DWC3_GCTL. However, this requires interpreting the
> > raw value, which is neither intuitive nor precise for debugging.
> > Monitoring these mode changes is essential for resolving issues related
> > to USB role switching and enumeration.
> >
> > Introduce a dedicated trace event to provide a human-readable log when
> > the port capability is configured.
> >
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > ---
> >  drivers/usb/dwc3/core.c  |  1 +
> >  drivers/usb/dwc3/debug.h | 18 ++++++++++++++++++
> >  drivers/usb/dwc3/trace.h | 17 +++++++++++++++++
> >  3 files changed, 36 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 8002c23a5a02..370fc524a468 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -156,6 +156,7 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode, bo=
ol ignore_susphy)
> >       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> >
> >       dwc->current_dr_role =3D mode;
> > +     trace_dwc3_set_prtcap(mode);
> >  }
> >
> >  static void __dwc3_set_mode(struct work_struct *work)
> > diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
> > index 09d703852a92..70d90790f872 100644
> > --- a/drivers/usb/dwc3/debug.h
> > +++ b/drivers/usb/dwc3/debug.h
> > @@ -13,6 +13,24 @@
> >
> >  #include "core.h"
> >
> > +/**
> > + * dwc3_mode_string - returns mode name
> > + * @mode: mode code
>
> Minor nit: would be better to document as GCTL.PrtCapDir value, but it's
> obvious looking at this small function. So it's fine.

Thanks for the review. I've updated the description for @mode in the
second patch as you suggested.

Regards,
Kuen-Han

