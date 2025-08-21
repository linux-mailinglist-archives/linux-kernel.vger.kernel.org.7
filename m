Return-Path: <linux-kernel+bounces-778815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F96B2EB84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 04:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2401C87505
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B912D4B61;
	Thu, 21 Aug 2025 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jk+B531y"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3E2D3ECE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744997; cv=none; b=ts+2kg9CCujvpTnIwi8YJcQcUOG1mpTO33s257sIYUqIgaKoeB/wAnwpjKBk5gf08ONuIRRhdJgLsd3RcJLctN98ZWR/dm/IRWIDHwoCQqxdsS5lhEDhbtI4rEjuRczKkCT5xvK2RV2DT2S4UdZY8nq8leTe1j4wbdqC99gnXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744997; c=relaxed/simple;
	bh=XHwx3T0vj4Lv+s2Y6qqwZiObkh2r7IivbMwDx2b9V+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcL4RZoImo36EvbhRnQaabbsrG3gMqgbxmagVJ5Iigb+eJz9B8hRLYnHYSBpHlEN89XpbS9GYaFbpzGOByvH0qlfvgYQbyNmNiPiXWHkoCck9xnXChTMPiL5w5XQHRy4O/iE69rHlRbETYQY1c7r/WNmh32W9X2qE4OXjeX7Bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jk+B531y; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2445824dc27so4871115ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 19:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755744995; x=1756349795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H996zq4Ef8LWOErXtNjqGqwGdLBd8tccS6w3vtc0ofM=;
        b=jk+B531yo+tDFD0GgYH9CPrdGm4F0E8ZaMTy3+3IZduxdZqHtIgSghwYVADFBsnF4W
         B6+JxtFkdUV3FSz3FWaYdOPd8dgkSSC8ShNaMYm1RXAFMdgXe7AGtpH0DCvxI64ifNhT
         1SwXI4i5NAZ8pKkOUcKWymv6DhbR2D4txZT0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755744995; x=1756349795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H996zq4Ef8LWOErXtNjqGqwGdLBd8tccS6w3vtc0ofM=;
        b=LGTKQkffOcYoTCK51sQKi5rl8fWEGSX8ih4QOjoe16vxbwu6iHOlQJ9o1H+d2FKImh
         avNSH4qpkU9CpoMovL1r5XKXm8xbQR85v7Gt9XIT08JQt+8cvnkkKSvWdn3IEOZVLc3o
         tyD3avOBDQqqYlJrrjVCYAIiCQEkoNVFcxxrSNjaaK0bY0S9RwVD6abdkG9bhDiFCJzv
         1iRKLUnIWpuLFKrF4lEbTpDjPcFGlW0rdGpVTlhCmTo7leAR/luH3oCYj0l4GEET2BrE
         mjZxg5HmhYjdxZbfDsVHjHlBm7u5olW284B229qRJqJHjzcCTxUnJiPYvX23w8fH213Z
         u0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXUB0rGs8yhc2gykjZj1EpPPKTOiC4mLGwcqfkiQ9KdkyeFMPB+DDRCo+MXqMCV1bFjisnqH2vlG/q18s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/N01zFf9VfGPyXriN1DYkqCCrVDwO0OPVg+oOZppcME/PxXyN
	2IMXKj8Xo4NPqZr8jLRhqjVXQrbfhuS9IZv3uvG/o8vsPEMFjxQC27BH60taABF9rw==
X-Gm-Gg: ASbGncvYowvTfXCdHorhAS9fYSIATPXme8colQtXofpMlYRVJrZ+umfN2Lan02fdbV+
	AAvk7Gebb533xJyiEQrLBqszNfOAH9Yv99sMArmRv9+ax+uESXtxSK/zq91gSeoCNrERa1hvb1Z
	KCXKkG9HJHt2C9Cc1gfg3JnpOPQrmLLgNo3NzZyP+P7sBG8KnZRGWt66bP1TA/hs5tDoLYjh4KF
	icJRxVrrQ0auRbyGrFqWdJK7liPdo3ySSFR8mo4fyOks+Q9P5WfFth6eqbuc3arKuGHYVJiwBC8
	FUcNMzF7KxaPnlBY7B/64FgzYW5cRVxFmfnMsxhWeljNES2YN2zrxEfUgD1rBiIcARn9FzPLogI
	urzo9WNdS53VMQDS7jsXK+ykt7rwwJU54pAM6KFxRDiBo5tBKe1Ngt5ARPNJx
X-Google-Smtp-Source: AGHT+IFfmuP/LFF7jXoz31JRLaGXSHGr8GvB67Fhz5PVKoovm91wDMvqkaL2E7H6MP4gZJtQNndaNg==
X-Received: by 2002:a17:903:3bcc:b0:240:49e8:1d3c with SMTP id d9443c01a7336-245fed7d21amr10502565ad.35.1755744995342;
        Wed, 20 Aug 2025 19:56:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2283:604f:d403:4841])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed4c7588sm40352175ad.101.2025.08.20.19.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 19:56:34 -0700 (PDT)
Date: Wed, 20 Aug 2025 19:56:33 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ethan Zhao <etzhao1900@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Message-ID: <aKaK4WS0pY0Nb2yi@google.com>
References: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
 <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfdc655e-1e06-42df-918f-7d56f26a7473@gmail.com>

On Thu, Aug 21, 2025 at 08:54:52AM +0800, Ethan Zhao wrote:
> On 8/21/2025 1:26 AM, Brian Norris wrote:
> > From: Brian Norris <briannorris@google.com>
> > 
> > max_link_speed, max_link_width, current_link_speed, current_link_width,
> > secondary_bus_number, and subordinate_bus_number all access config
> > registers, but they don't check the runtime PM state. If the device is
> > in D3cold, we may see -EINVAL or even bogus values.
> My understanding, if your device is in D3cold, returning of -EINVAL is
> the right behavior.

That's not the guaranteed result though. Some hosts don't properly
return PCIBIOS_DEVICE_NOT_FOUND, for one. But also, it's racy -- because
we don't even try to hold a pm_runtime reference, the device could
possibly enter D3cold while we're in the middle of reading from it. If
you're lucky, that'll get you a completion timeout and an all-1's
result, and we'll return a garbage result.

So if we want to purposely not resume the device and retain "I can't
give you what you asked for" behavior, we'd at least need a
pm_runtime_get_noresume() or similar.

> > Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
> > rest of the similar sysfs attributes.
> > 
> > Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Brian Norris <briannorris@google.com>
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > 
> >   drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
> >   1 file changed, 29 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 5eea14c1f7f5..160df897dc5e 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
> >   				   struct device_attribute *attr, char *buf)
> >   {
> >   	struct pci_dev *pdev = to_pci_dev(dev);
> > +	ssize_t ret;
> > +
> > +	pci_config_pm_runtime_get(pdev);
> This function would potentially change the power state of device,
> that would be a complex process, beyond the meaning of
> max_link_speed_show(), given the semantics of these functions (
> max_link_speed_show()/max_link_width_show()/current_link_speed_show()/
> ....),
> this cannot be done !

What makes this different than the 'config' attribute (i.e., "read
config register")? Why shouldn't that just return -EINVAL? I don't
really buy your reasoning -- "it's a complex process" is not a reason
not to do something. The user asked for the link speed; why not give it?
If the user wanted to know if the device was powered, they could check
the 'power_state' attribute instead.

(Side note: these attributes don't show up anywhere in Documentation/,
so it's also a bit hard to declare "best" semantics for them.)

To flip this question around a bit: if I have a system that aggressively
suspends devices when there's no recent activity, how am I supposed to
check what the link speed is? Probabilistically hammer the file while
hoping some other activity wakes the device, so I can find the small
windows of time where it's RPM_ACTIVE? Disable runtime_pm for the device
while I check?

Brian

