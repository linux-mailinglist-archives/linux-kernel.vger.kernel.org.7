Return-Path: <linux-kernel+bounces-774175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCAB2AF7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300D2620795
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3CF3570C6;
	Mon, 18 Aug 2025 17:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJDdoE2j"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD75D35084A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538407; cv=none; b=B7UELccmMD6LiVlOuVNz1whnznAOl3XaK0hooSMOJKPw20tQKwp4XP2oR3mlDiKQM69YzbvXJB7WciYz3AdCEW7llT4PGL3rDmaDYc7ek1WWnSCnGPp1cd20oC0VuIN2ZenZu8mJdSDN23LVaKqgnkK+i0OpG1bNe3r+6pjEUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538407; c=relaxed/simple;
	bh=pWcdbiE7PJAUbmDxqIApcP782ckIgnEtxjCQq7HtqsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWJWrSUfpEiaUDlr36VqgTX1AAISyIwRxG4mmbpQagjzdXtVouU5i4RLPncdUCoC9Zdj9y46UUEtIDcPY9fs0rPqh8ZlU6MXfO3c3NI1CVHDm1amPPOpCFq37d+tf+6+a94r9+Tl9O+zAtLESKxaGH0bL6ZUTK9E1kIj3tfWG10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJDdoE2j; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459fbca0c95so6985e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755538404; x=1756143204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AdVOBToYHzahRnmTA/JAhObNxYHPQlv2H8+USn4eZIs=;
        b=bJDdoE2jDBUPzNMXTcY1sf+5+G0G8z5S1673hcV+lEPvn7R+clldoPd7loSwAai0Q5
         tsFEcvRPszB0PDYOY5cG7xf6xt0KUOEA86Y0mv4mFek2TAD+RRzADnfMXhtBediaPdvO
         FTkVN6/PX0YxY4Nx+ONtn3tk9t3a/1IVhs2Mqfaxo2GakllmRfuQGoL1wB8Qs8y/6auu
         L9f6L5//PsHohu4Kb82YGKEnAIDu4hOaKNkDzuRyh2FSggi3r5/d8iLNcLzCTe8MSZhN
         ld83LGis9V1POcFV6k0bf4ehaaMkOJYChLbLWsCx1bXL7IEJNgwr7H09rImwmTXnYxss
         c+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755538404; x=1756143204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdVOBToYHzahRnmTA/JAhObNxYHPQlv2H8+USn4eZIs=;
        b=U89DBuz+ib1Noth2ghZNm4M0C3EcA8OO2x7CvWtYPbfMCsUeaOnxN9PrWWRe445m5E
         AVYnH3LFJFaLKqsvvJRANOR1bcpVv3YFR1Uvgl3EsccLxwN2WCYjDs5FJClvKaMU2I6F
         exV4t0/YCWWnXf1WcKBYBARCoiYJINBlGw7Qr983AHkpoqjSCA6lGAuP6HLUjrYFffpn
         JR8DC5G+acO/SiCRAtOL53QmHfy4BOiDqjIzSusVVDPg6Kdve0NcUELIudIgI26aaVsk
         wKr26EmMRI1G7v/WtYFZLC+tOQ2IOMsJT0gd2cu/JyspjHtrvKPJiChBMvTa1zTvHlVi
         4zeg==
X-Forwarded-Encrypted: i=1; AJvYcCUrAPx7gVE46XZWtxoioW+w9wGesHWHXsIjpr1Efnxq/ZuxLzOXy5RBmM9pXqSymia8lOgiudgE0nm3DnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9kJg8S/ikA9sidV/hChezdlXOrALsrnBU+x/OnXeHgHrLWuZW
	sI9UJkzzbGWnvM7+w+c9rla04J1JccmqNR02XbLJw95fUDQtfeREcVMbm73kYgnZbw==
X-Gm-Gg: ASbGncsyrbcAaP+XSbTK8Zi00m/cbSaXcNawf9otZP3xYMnNjXm4Vm1/EDLUEtifTDl
	ZpxeXiypRoHlQlsTc03la779Rd0WYY4BhZXro+6VIPX/yqSs4QOKr0hcFLVNBh61q6I/DbrD3pb
	1OdaKR81rGSCJ3WBx4eEzdU99Q3A5LBGTOOz9PPn1HzUD1auuGBw3Cwu06OVJu3AT/v0Q9Ck+gw
	hIQmMouydsqNKQ5OSJTCnWYVHZP7l1VOpvChnsg3IO1RnwvHnP6xFcwgHO4W+eI9o/UQYPyqrBs
	dbtes1U4eZZGo5USZvfdJ8+t2q9CvRAi9FDUfrKjs0PppxDO1QuQ6b/ydX3IaBSb8JGS8gribDN
	3hjI7wa2UHcroarBWWrPkYcyZj3CfJm0RKLAaMepP0xYkM6OgKK6cBr6vNy4B3SjdM12Wmiojfi
	Sl
X-Google-Smtp-Source: AGHT+IFAreOcXY29kFfPl2QU6SpvrufrkrJoiRM5yfK0+dU6xDYHptDQUmR9RWBWjJp/b76GSiy0rg==
X-Received: by 2002:a05:600c:c081:b0:453:79c3:91d6 with SMTP id 5b1f17b1804b1-45a26efb748mr3456235e9.1.1755538403849;
        Mon, 18 Aug 2025 10:33:23 -0700 (PDT)
Received: from google.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c5731dsm287345f8f.59.2025.08.18.10.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:33:23 -0700 (PDT)
Date: Mon, 18 Aug 2025 17:33:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	eric.auger@redhat.com, clg@redhat.com
Subject: Re: [PATCH 2/2] vfio/platform: Mark for removal
Message-ID: <aKNj4EUgHYCZ9Q4f@google.com>
References: <20250806170314.3768750-1-alex.williamson@redhat.com>
 <20250806170314.3768750-3-alex.williamson@redhat.com>
 <aJ9neYocl8sSjpOG@google.com>
 <20250818105242.4e6b96ed.alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818105242.4e6b96ed.alex.williamson@redhat.com>

On Mon, Aug 18, 2025 at 10:52:42AM -0600, Alex Williamson wrote:
> On Fri, 15 Aug 2025 16:59:37 +0000
> Mostafa Saleh <smostafa@google.com> wrote:
> 
> > Hi Alex,
> > 
> > On Wed, Aug 06, 2025 at 11:03:12AM -0600, Alex Williamson wrote:
> > > vfio-platform hasn't had a meaningful contribution in years.  In-tree
> > > hardware support is predominantly only for devices which are long since
> > > e-waste.  QEMU support for platform devices is slated for removal in
> > > QEMU-10.2.  Eric Auger presented on the future of the vfio-platform
> > > driver and difficulties supporting new devices at KVM Forum 2024,
> > > gaining some support for removal, some disagreement, but garnering no
> > > new hardware support, leaving the driver in a state where it cannot
> > > be tested.
> > > 
> > > Mark as obsolete and subject to removal.  
> > 
> > Recently(this year) in Android, we enabled VFIO-platform for protected KVM,
> > and it’s supported in our VMM (CrosVM) [1].
> > CrosVM support is different from Qemu, as it doesn't require any device
> > specific logic in the VMM, however, it relies on loading a device tree
> > template in runtime (with “compatiable” string...) and it will just
> > override regs, irqs.. So it doesn’t need device knowledge (at least for now)
> > Similarly, the kernel doesn’t need reset drivers as the hypervisor handles that.
> 
> I think what we attempt to achieve in vfio is repeatability and data
> integrity independent of the hypervisor.  IOW, if we 'kill -9' the
> hypervisor process, the kernel can bring the device back to a default
> state where the device isn't wedged or leaking information through the
> device to the next use case.  If the hypervisor wants to support
> enhanced resets on top of that, that's great, but I think it becomes
> difficult to argue that vfio-platform itself holds up its end of the
> bargain if we're really trusting the hypervisor to handle these aspects.

Sorry I was not clear, we only use that in Android for ARM64 and pKVM,
where the hypervisor in this context means the code running in EL2 which
is more privileged than the kernel, so it should be trusted.
However, as I mentioned that code is not upstream yet, so it's a valid
concern that the kernel still needs a reset driver.

> 
> > Unfortunately, there is no upstream support at the moment, we are making
> > some -slow- progress on that [2][3]
> > 
> > If it helps, I have access to HW that can run that and I can review/test
> > changes, until upstream support lands; if you are open to keeping VFIO-platform.
> > Or I can look into adding support for existing upstream HW(with platforms I am
> > familiar with as Pixel-6)
> 
> Ultimately I'll lean on Eric to make the call.  I know he's concerned
> about testing, but he raised that and various other concerns whether
> platform device really have a future with vfio nearly a year ago and
> nothing has changed.  Currently it requires a module option opt-in to
> enable devices that the kernel doesn't know how to reset.  Is that
> sufficient or should use of such a device taint the kernel?  If any
> device beyond the few e-waste devices that we know how to reset taint
> the kernel, should this support really even be in the kernel?  Thanks,

I think with the way it’s supported at the moment we need the kernel
to ensure that reset happens.

But maybe instead of having that specific reset handler for VFIO, we
can rely on the “shutdown” method already existing in "platform_driver"?
I believe that should put the device in a state where it can be re-probed
safely. Although not all devices implement that but it seems more generic
and scalable.

Thanks,
Mostafa

> 
> Alex
> 

