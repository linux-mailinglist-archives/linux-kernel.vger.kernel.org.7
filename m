Return-Path: <linux-kernel+bounces-836197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8DABA8F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076FE167119
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858AF2FF664;
	Mon, 29 Sep 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9xmuKZG"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C3018FDAF
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 11:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759144219; cv=none; b=setYmpppmsct9zyMLSvwB3uSJDAdletp5HAc5oR0QpmQL4eWG80qeYA9AYwQxZHAmjOXaxB0Lbm5KPjDSqivALBBxupbpDnsApAX2ZD0ZwzxOH8MxdDTKObD3ci9sRcFtvVW9UYEtxW2fn9m1G4Ys7sMwEeWQKy06h7KSJIFylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759144219; c=relaxed/simple;
	bh=uGU0X4XRvs5GtQI3Ay7FhA1xMjMBv4FbZpT42eARQ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpXs9xK/A/Hl6Rjr5RL7RqR2a0R5mH/yTfwp0xniDoPFY2r7Tt3Vp0Cr98XfGOOggtmdOuTyCZKuxJVSDxmhyG5cx8x0BwBsR+PyhrZOrOZlBhFaudR5MUTvJebIzE7t6Q88nmicPNHat6xK6W/0UNnKwhkxxg+boBMEBA3XnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9xmuKZG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so101925e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 04:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759144216; x=1759749016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KBw4ejj4fmMEafZBPpzx+wYOwZgdJDUmWT9JGV8MXfA=;
        b=K9xmuKZGcDFSgeUAIhLcJ9XFzhiVasKamgIvI6HTj15h8pi6ISe1lrfIsgWmfksDm3
         hDxIILjRYg94aJDuTfAkYQLS3ntU3S9GxPcIl/uM8BZdbgYGa+591nbfoPGlbQuD3nyL
         R9zycivHdJeBJ37GRJechamfz3RJWsmFr/J/R0bhV1mLieM7hPAbmtEVngsrJeVESBsV
         Me79NONzl7MjjDrtLXfftM5SyZzKF6Dj9ito5WdBBpQOxrt3DJPDfaqWdbqRr5/wFNLt
         xhltUBBz3ltIoSv4qt8l8eKMBXZgwrUbndsB8SM2hPs//eDl7Htn4bGgzuFWY5IV5el3
         qqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759144216; x=1759749016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBw4ejj4fmMEafZBPpzx+wYOwZgdJDUmWT9JGV8MXfA=;
        b=NbleA/dCSl05JqVmlJCYT+jDolohmqem+XNvyAT4xqgJKSJJlw+sRRsLXqpGLkBtc+
         tQmXQbgVQWvmnXB4Ef3lhlb7wl7gBLqHL1MJ3EPRDdr31OWaL6qOiUOb/Cq6xDUtPf9O
         YAfmv1jgS29W41dhCvTO0boEon0xoQMkac+ca5Wbo9CCU5gC0cbte029vqSMvXfpIJ3Y
         /vkUT/RiylSSpxXifRpC7KCrYZP7IHG6O64KEjYXP7RNk8q027Q+wzXr7JYEL2EDUE4r
         /PblyzIPtJSpnpwwt0C3zPFCXraUaKpuMjEFKDJ/n41qmMq5l0OnX2fd3xpwwR1CSUzN
         111g==
X-Forwarded-Encrypted: i=1; AJvYcCUuvpq8OKbHcGolNhwn4XORAN9sQ3YQuSoziKJKZLiP+L1DlW4lOxgmDfwsiu5aos/6oPKOEX2hZK2ySYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnHiIQr5RuP/R9E5Cd7N7A4UDNssnE8pl65Z7326h+SsbpvLwG
	ZxzZv66pWmX2DGc8wxYI1SgKN8fANO6GEj/L8g4hWb6p+eQ2D+9KWo8zsiAomo68Ww==
X-Gm-Gg: ASbGncs82ua5Hca15PnJ0BofRqkB5oomGPhJbBxysfidghzTqe5z05fyERVstQ4BXKa
	EPNq3CQU+rCg6lJGyOR4HcIKXr5i7MrLPp9V6B7K6ibJsIQngbmaCg9QxouhjeFsN9pVVdlBSut
	VU5D9oi/ig/o/9+kTqjUAdzkZwls8vbUzQ6ZqwPUrt/QEwppAcPvD7U8fPZWnZ0WAs335og+pn9
	YCiVhMP/lAuJucXeXN/QVWghDHWhXgnfJiCwBOhgrObCRr9Qa5KNenFcN2Qm5M/w9irJr3i3xB8
	L3knq7ZF0AgMshJ9h7yzdynZEWgUMZQJEu/3S1VL3axBF9ZzLFh3u9K8UTWblZ/ZDrtwfZMHltb
	CEEpBaJk6XurQ2CfQ42aK6/rqnvFsz6UDm7k+1vv6siYVtyYH3Sgf5kP2OM0Lx0DpggA=
X-Google-Smtp-Source: AGHT+IFGf4k+JJs/tMEbOwTNQ+j0uedEPD+8WOGLeH7x1gD8a+XVxRfw6dvXWns5XmMqAfUaxJmdrw==
X-Received: by 2002:a05:600c:37c3:b0:45b:9bcb:205 with SMTP id 5b1f17b1804b1-46e575a08e6mr402015e9.5.1759144216266;
        Mon, 29 Sep 2025 04:10:16 -0700 (PDT)
Received: from google.com (140.240.76.34.bc.googleusercontent.com. [34.76.240.140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5603365sm18381901f8f.37.2025.09.29.04.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 04:10:15 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:10:11 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <aNppE9A3PDiDg_1W@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923173806.GF2547959@ziepe.ca>

On Tue, Sep 23, 2025 at 02:38:06PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 02:35:48PM +0000, Mostafa Saleh wrote:
> > If we really want to avoid the current approach, we can keep deferring probe,
> > until a check for a new flag set from “finalize_pkvm” which is called
> > unconditionally of KVM state.
> 
> I still think the pkvm drivers should be bound to some special pkvm
> device_driver and the driver core should handle all this special
> dancing:
>  - Wait for pkvm to decide if it will start or not
>  - Claim a device for pkvm and make it visible in some generic way,eg
>    in sysfs
>  - Fall back to using the normal driver once we conclude pkvm won't
>    run.
> 
> It sounds like a pain to open code all this logic in every pkvm
> driver? How many do you have?

I though more about this, I think involving the driver core will be
useful in the future for init, as it will ensure power domains are
probed before the SMMUs when RPM is supported.

One simple way to do that, is the make the KVM SMMUv3 driver bind to
the SMMUs first until KVM finish init, then it unbinds them so the
main driver can be bind to them, that will not require any changes
or assumptions from the main driver, but in runtime the KVM driver
can't interact with the driver model.

Another possible solution, to keep a device bound to the KVM driver,
is to probe the SMMUs from the KVM driver, then to create child devices;
possibly use something as device_set_of_node_from_dev to bind those to
the main SMMUv3 or find another way to probe the main SMMUv3 without
changes.

Then we have a clear parent/child representation in the kernel, we can
also use sysfs/debugfs. But this might be more challenging, I will
look more into both and will update the logic in v5.

Thanks,
Mostafa

> 
> Jason

