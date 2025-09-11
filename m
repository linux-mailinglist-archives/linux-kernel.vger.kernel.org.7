Return-Path: <linux-kernel+bounces-811324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F2B5277D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8BF1B27B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCCA235072;
	Thu, 11 Sep 2025 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TP7aENOH"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C933D8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757563989; cv=none; b=N8yNfyNRLXYWVO39RXKJhtn7ELmuh75VR9U2DuKAJqJcqeNmxKyXZzlR4hSHDUVXthrVaZazEBI2k/t9pK3nmQyFSbdj2X1YXqoYlbumu3VhaXRhmoYgvAvXnq7Cm+BgJaFSANM0+E0X6Sfy3ZjA1bABumn2uT0H3OzFvqG6Ll4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757563989; c=relaxed/simple;
	bh=4hPqeARqosqWLxCTuKgajaum+hmQ8OE3/VQMa53ni1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NuyjUZKQ4qd1vFVzMhLH4rglIiXlYPrv/R9/y+6EAK2oPu+d1D7odlxRX6LjFi+eGYMj3HEYmrxFYLw3yGv0Bwl4SMrHDDXfnAQRPMLTQ+88BCt0UYv4FSqmuzty+sVPz5pYSjtR2C5tKBXnJGjncrO5BewiBBZDJcoxh9q1MFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TP7aENOH; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-407a4e744ddso86655ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757563987; x=1758168787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=655H2KsDR2fJVpZxOxrIYfh0mMw4vNi/WkGORS683L0=;
        b=TP7aENOHdNHPU2w9M7uuu/NQ3Eo5VX76pqnDm76uUl6a4/D5j3fCPkbMpQSQ9KoF3E
         N5fV5ckv/xAjHtdSV5CCiFNHb6wl4dJTux/vLLbr1HyRc66UUKJrdkmD7sjoSSoI723E
         LAXSwGw/B5l5K2l3G58TVrPRpdtbqxHE6Zyo7AggU3rlHRHBSZM63+LLOtLStZJNkQ2u
         R825P5KXuna7jKq+Q2dHqDJ2Q4QRkm3IiFJcg/7cJedtgNoz1YizoQvxrZF4zQ5xoEvo
         RsKszRZK5SsXr98SmZOA4yXUOXpDjh2SEuTlaMACZifLbZwVBthZ8f2Wr8GdtOIwv4AY
         77wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757563987; x=1758168787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=655H2KsDR2fJVpZxOxrIYfh0mMw4vNi/WkGORS683L0=;
        b=oiGd+kvasNczWtZIjIn6bb0JDFTILJs5vekSAwI/FUJ9xwUl7Biiuo9Xch+PXJ+Zaa
         RmLyy8cS7mzmxGZVjDVbOshwb5BZzuPq4tJ+X+7Q2tYip8QSmUtMB6ltOQHc6OLrLyL2
         v1cNX7d1MnGWf9Nh6bTWdyTlO9Y33by6QFRa0zH4Q8DDrhBmk9MJaE+Zm2WXfx4cafmY
         ZR/VoeV9vTjO5GJiuSGqCXzCKdkgDKZhBJDTKMmCj+Sj7ZYR//N0A+e9XL9WlpnrbRDU
         MY//qGdow8z/muL8GoPAQYuz6/+9I+U9+ok78D4rSN6sR0uWK1qU4eYMyVX26pH2QIAe
         ioVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7qS4vjSaDato7h4FanoS1ktKnxnTOQ3ws/he1FC3R81czZK7JswcL8v8xQ4C7ESAYK+UmenDZYnbV+gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP7SJaR0fbAwfZihu1LKfYKcwiPD0uLzIFFWDsL0NH5oCM0lUl
	r62NZTE9P/OWJYuyodNsawLktCM5Igt1SMWyzEOM6aeE0BrQdmDPXtnOd9Pzvwm2Cr3AFm6bKwi
	MwuQbeSNcshRoV3g+LOPEhZ4AK0oj3tRaaVuOeWMX
X-Gm-Gg: ASbGncvqXW5Rd8RbtSl7YixvEroChSPCft+BOvLjy2Thz7cdfHbs/1tMki7I09DsjFY
	DpFOlshkCQAeVLAyv0z25qlDgsSM9kQ6+Z19z8zwPiJuP4DlYIYFMyCZiwThS6/52igATsgxMKm
	BhtnJ6PRj3Rw+PxzvaIiwuj3fWnWfSGIm4FZ2+uD+Xu2m9x4VknCL+DNF6NoyMLIdM1xrvXqdp0
	eg/dwiBti/bbb8MyMOHDjtAozSj3cfnoXjlNNoIkC8y1KPuDNJEJ2flqhOolHCMlhIEZ1CbxzYJ
	2Xt42khiYstY
X-Google-Smtp-Source: AGHT+IHv1ItPg0yNbNTAbRbd+dYBW1J+7hh4D9M3hrHAIY9YZPJlVrQTruWC+uuHkhaInaUCnDNzxMkNh4AP1jHfRfA=
X-Received: by 2002:a05:6e02:b2f:b0:405:3b66:9a92 with SMTP id
 e9e14a558f8ab-4170e5ad87dmr9132195ab.7.1757563986398; Wed, 10 Sep 2025
 21:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801034004.3314737-1-guanyulin@google.com>
 <20250801034004.3314737-4-guanyulin@google.com> <2025081313-senate-unhearing-4396@gregkh>
 <CAOuDEK2=UyjYbPQeSxVSmiLu6A36m4Tt9xADHyamJHM61-vhmQ@mail.gmail.com> <2025090646-goal-unranked-8bf8@gregkh>
In-Reply-To: <2025090646-goal-unranked-8bf8@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 11 Sep 2025 12:13:00 +0800
X-Gm-Features: AS18NWBUElxTEKNR08wOLreLTj6AigqMLhYkSvv469cq9sa8UA5hUbv44bWJnKg
Message-ID: <CAOuDEK3Zv0qErDfCaRX_AH3buht4hP3XnuF3+T6-3aLw1_a2Ag@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] xhci: sideband: add api to trace sideband usage
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, hannelotta@gmail.com, zijun.hu@oss.qualcomm.com, 
	xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, ben@decadent.org.uk, 
	quic_wcheng@quicinc.com, krzysztof.kozlowski@linaro.org, 
	dh10.jung@samsung.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 9:11=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Aug 26, 2025 at 12:37:00PM +0800, Guan-Yu Lin wrote:
> > On Wed, Aug 13, 2025 at 10:51=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Fri, Aug 01, 2025 at 03:39:32AM +0000, Guan-Yu Lin wrote:
> > > > +config USB_XHCI_SIDEBAND_SUSPEND
> > >
> > > Again, why is a new config option needed here?  Why can't we just use
> > > the existing one?  Why would you ever want one and not the other?
> > >
> > USB_XHCI_SIDEBAND focuses on the normal use case where the system is
> > active, while USB_XHCI_SIDEBAND_SUSPEND enables the sideband during
> > system sleep (Suspend-to-RAM). The design allows the user to determine
> > the degree of support for the sideband in the system. We could add the
> > "select" keyword to automatically enable USB_XHCI_SIDEBAND once
> > USB_XHCI_SIDEBAND_SUSPEND is enabled.
>
> But why would you want only one of these options and not both?  The
> whole goal of this feature is for power savings, which means that
> suspend is needed by everyone.  Don't increase the config variable
> combinations for no good reason.
>

Thanks for the suggestions. I'll remove USB_XHCI_SIDEBAND_SUSPEND in
the next version.

> > > > +EXPORT_SYMBOL_GPL(xhci_sideband_check);
> > > > +#endif /* IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND_SUSPEND) */
> > >
> > > #ifdef in .c files is generally not a good idea, is it really needed
> > > here?  Maybe it is, it's hard to unwind...
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > Given that CONFIG_USB_XHCI_SIDEBAND_SUSPEND depends on
> > CONFIG_USB_XHCI_SIDEBAND and adds only a single function, I think it
> > is preferable to place the new code in the same file. This approach
> > prevents unnecessary code fragmentation and improves maintainability
> > by keeping related functions together.
>
> We put #ifdefs in .h files.  That's a long-time-rule for decades to
> ensure that we can maintain this codebase for even more decades to come.
> Please do not break that rule just to keep things close if it's not
> required.
>
> thanks,
>
> greg k-h

Thanks for the suggestions. This concern would be addressed once we
use only CONFIG_USB_XHCI_SIDEBAND to control all features.

Regards,
Guan-Yu

