Return-Path: <linux-kernel+bounces-889027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2ACC3C88C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD133503529
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E3D34E767;
	Thu,  6 Nov 2025 16:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgfXQ2Ep"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8A3328F5
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446814; cv=none; b=QbSZy2YbwMXhshLbLaCIqtCd7rler9QVpm2Ue3jv0EIiK8cAnONha9CroC5q9JcLzFDZhT3Xg29Qsim4WmAK3mqek4+DzAHa+rFbko+g9TptlhachOXfBhchjqDMZcFUoRVsm+QcORN6SY5q9hOFMr6K5ukCDK9xT6N1LslX4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446814; c=relaxed/simple;
	bh=5ihuDeqsYQ0psikMxLSzF19AqAAShlKz6wsIdUFp4WU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJ/osCy5mMRSNMlXSk1x8U84YT9ZpZHqnCGjgq9Wpz3vqG+0UcQeZRn5UnZyZtHTNzu/llPuXalRaxqqjaUQgWB8MAPLkywoazkhtFnXCc73UhL6JhVBB+MsxiRWTQjqXWDcFRWLJbm03l1MuLcBDrdJHFq0ROShJy5l+34NHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FgfXQ2Ep; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed67a143c5so392081cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762446811; x=1763051611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnZy7OiPe/kS2Rv9Wy12Swhc5j0bx/uxDP7H3ZzWM20=;
        b=FgfXQ2EpMNBcci4CetxscIG0V4Mueb5shGFITySLZIDUOMsdvqtJYJeuI5X9cF7MAq
         wHTcxIfnENX63Wa192zliRtYQmYTJ4mj+wltbT3IzEUCq0BiXIFESuXWRId9y5nZojar
         ICrRMNI259tYOi7krTRtN9u/ijN9ICe4G7y4uCe759kw7qDuXnt7HKcsmBJX6BiqmPzw
         Xzqckd6WDV4tm3GdfBKY0w2xowNPYkbhxxdHfZr1UTCIq1AgMkvLJBvZTjYNbFRScF0J
         CIqGyl3+tzpUi8hhP6SASjyqklTrt9Kv8HxIziE2NUVaKxGXZ/XaXQAfPn6m0QUCqWxL
         1tKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446811; x=1763051611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lnZy7OiPe/kS2Rv9Wy12Swhc5j0bx/uxDP7H3ZzWM20=;
        b=jNHoq2ST/bqCNIDnk5+T2JapZAO2PvKyF9s5qVHSDRfUS0nJVZZorSMXllun+5tt5+
         kWTVMdIb3pnuXR7SsNHM8XGTuTSu6ZLwlvrRNkhqu1sXAvqa+IprcidNW6qBPLH8li2x
         EGlcKyHgP2Ujxtvk2FzWNke2jYHjOR1Tqcb3h9v2e7aovzTJJs4Dhi8icFWFRBfUv1pC
         xcjD3S1pMWGwOFErGXRr7LNWzrfHk/ow5r+yWu9L+ahgko8/7ajBIlbb6ivx2cF1NLp5
         mTFLlar6aWJ1ZO2Pm2ie0ZNTE+jmyQgYgL2zyzCldDLNzrhdAwFv3lSwEHfHpf/CXO+2
         xBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwN4juzigvL+NNya0IyI41dxvd/wPoXtJ8BtXASy7reBEz9fmHhVWbbC5BIzZ3SL9nrOqVaunlKFHCI0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKPoAL7X3izCVTJM0+Hi+kTHcRVuOZVenMy4M3mSPd66CnUpNi
	056To7jwVIUoNxheFLud6LCP+2wwPBoEJX1BQVROXCgKiM68QDS/q0b4Qt6qDW7pGLsEYRC5VBz
	kze70oVVFxm4IcctE4afzfDj0lihPIEndIMNYbDQ6
X-Gm-Gg: ASbGncszK/o6M9mnw3r7VdRRQHBCDRuR16I/SNS9dB8lXsWBKbIp5HL7WwfZPU1CNLu
	LomSiRxF2CclsnsVyoME/pyquS7k08MOhRyqW4EB1e3T2By68YBC+be/LqK4enb/diZfP2Hge2A
	jHBr75r2B47u284qMIUH2VpqtDzaCRCOHFRPwirBHO1SzOVemLewm0vBkZv9akWKOSjZ04LEISq
	DdUQjNLVneMfF03LaUXk2NpgwZuG9Di6epQKQF6Ej3WGc5wBNoUGQU8lVqX
X-Google-Smtp-Source: AGHT+IHkFFTqQuW3CEPcoZzja9ixONknh7QDVB4aPSigXJPx2frRev2iHo0yg8eQxo4ySjq4nFKmcGplZ7r9pitYqzM=
X-Received: by 2002:a05:622a:60a:b0:4ed:341a:5499 with SMTP id
 d75a77b69052e-4ed82bc69e1mr6700211cf.11.1762446811408; Thu, 06 Nov 2025
 08:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104003536.3601931-1-rananta@google.com> <20251104003536.3601931-2-rananta@google.com>
 <aQvjQDwU3f0crccT@google.com> <aQvn1b9sspmbYQVo@google.com>
In-Reply-To: <aQvn1b9sspmbYQVo@google.com>
From: Raghavendra Rao Ananta <rananta@google.com>
Date: Thu, 6 Nov 2025 22:03:19 +0530
X-Gm-Features: AWmQ_bkGLaUZfEme6FxbIW7ZkiI0Va_bGW9y5wLoRjtgBHqe9dY7AfVYeS3floE
Message-ID: <CAJHc60z5wX7My+2TYGjV4DYYWow=v9XQH8EQNP+WVQdq2LoxXg@mail.gmail.com>
Subject: Re: [PATCH 1/4] vfio: selftests: Add support for passing vf_token in
 device init
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 5:42=E2=80=AFAM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2025-11-05 11:52 PM, David Matlack wrote:
> > On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
> >
> > > -struct vfio_pci_device *vfio_pci_device_init(const char *bdf, const =
char *iommu_mode);
> > > +struct vfio_pci_device *vfio_pci_device_init(const char *bdf,
> > > +                                         const char *iommu_mode,
> > > +                                         const char *vf_token);
> >
> > Vipin is also looking at adding an optional parameter to
> > vfio_pci_device_init():
> > https://lore.kernel.org/kvm/20251018000713.677779-20-vipinsh@google.com=
/
> >
> > I am wondering if we should support an options struct for such
> > parameters. e.g. something like this
>
> Wait, patch 4 doesn't even use vfio_pci_device_init(). Do we need this
> commit? It seems like we just need some of the inner functions to have
> support for vf_token.

Gah, that's my bad. I changed the approach later but forgot to revert
the API. I'll fix it in v2.

