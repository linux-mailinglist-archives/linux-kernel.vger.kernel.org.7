Return-Path: <linux-kernel+bounces-763538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17604B2165F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AB043BA181
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF7C2DE1E2;
	Mon, 11 Aug 2025 20:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fqyrs6yx"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFDD205E25
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943842; cv=none; b=X8ObWdTnijxSO18NQkGB1roE3l+2rdmR/oUPRKcZSJcDf7B1jq0DrU0mJ23fpFsznQOyHkMBMfl5z9AQh7ySrI4qnXKJRJ3LEaKIRrAjPNW8dD8FKTOq/s4ME3ksedYsQMQzpd5zzH87q6uLP94n3iT//QRV9yctHhwgRAXpqJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943842; c=relaxed/simple;
	bh=ytmCrsJhXKNtynjO5pJOyeHWMfMT+MpehOB3Fr1tnuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5M0yWLNevfJbFfjLeLVP+Fn/00cb0mqE991UP5JfSHg93iZVw062u0rHZ/jXDa07XzV3bxpQBy1FazZq4fUe83r4z22CySXKvK2bKNsQ2O+Rm5Lk5mf9e1/jKdYTYG9s8GCbUqZDsmD1YLV6mfJosqpxeEM0rVRp3DUvTdRMl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fqyrs6yx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4aeb5eb611bso47660341cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754943839; x=1755548639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2WZt1Ib8Kx2Ps+b49KHWgcA82+e7eLatEPJyDKab0y0=;
        b=fqyrs6yxB7fHY/bxcILQmpjyXTqU+nRpGDXSu6/NQyohz/ZtVGa6x463qH7xUq+fSi
         d+x+7kpnebETiRmb+zUlc4RONh6GWjRjtF4fSaMUKhZO6/DlC2olcKkGv3BkPDKIDaQc
         8uQ9haOw2PcvLEabd/Rwg4IBQuv98RJXIoyyMcaeSSIKgsdb45eH1FEIakePrfU5bgbY
         6TQ3Ex11kp7DCYCAbnKf66dFliCkEIQM68je4TwW1ZufdOGjtnSY1gcoIMjarS7WXSpl
         F+4N1RRVQ5EIBvj9XhdjhOKnW6OUcy7ZaX2k2hD9IlOdYWkUng0NiMovVFhronR5hEeT
         84FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943839; x=1755548639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WZt1Ib8Kx2Ps+b49KHWgcA82+e7eLatEPJyDKab0y0=;
        b=fzryTSuL6D5tWOMPu0e75u+4peaDdgLIhX5ljcBXM3t1dtW92+RhRX6WRVQMUZpiSw
         jG49FPBQGlYoJtqocvKDlq2gJeHO2TCdJh7r367qHTxUZ2deS3uPZ2NRCyTw8fm7CY1E
         GhSGIjL+7r/hzE7EM9ry2LZz2688hlxU1/zGMBTTssDUqVPSvqujpHN2Nkvo6yVZ4z0e
         Ypfz4DQwfL/JXrlC8yzrd8HigJ5knM40tZgBWmO3gX3ZQIG1KWpvN3zbmywF9oFHCUUT
         TryWpiXoCsOJNzabyUgFCsQ+T4oW+NtNNkqS4Y7RV3zBa0E986kdVFLVmKiU7AMI3JIf
         G6Ng==
X-Forwarded-Encrypted: i=1; AJvYcCWFASJNf1C497u/vZBJRs6fuZ5CSEcb4HvQ+5uGPrWKJJ/pNQ3+C3KMqvltGN4gTqA09EmOnPAm2G13P1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLun5HSrY3Ol9e1JQCTN9zELnBcaP9w0mxTGKNGXV81woOW0u
	wrtxmRJxYMAe5ZstIVDvXX4/fWrOKmDSeb8jypsVJI3TsDSRy/NfLe6ye8P9wRsHedk=
X-Gm-Gg: ASbGncuzDdVajjDoCsI0A/T89sE2wlgf9ov1TdlFEX7ucJMzdk7z3oQc4dxOc3vjejq
	inI3D1M25/3+c68rFRYcry3Izm1FoLQMFKRmvuL2Pvp96tJ2etcN471exV6ocRfX3t32voFeY02
	SjAfhJL8kwVvFkIcCh7GYz0i+3S1p+8o9NRN6dzMXHq5GxD6ycFqC/d2gUR2RsUP/ttKIxKBb0i
	H7sNH74i7DOZxQJe6ViZqesFcqs9bdZbU2rqtzRAORNIqytyqMsTANyK+uBgv/88bNJp1t8+Y1v
	x7ZcEwJgmNSDOxOQYGKYtDM6WuuWjwbQr8xCiFetsQbFbltiAnVDhyIyIHrpC+N9yU+QfT0mARy
	BEt+ghAD7mBORT4zEMk6rkFWeR9lffnE2l6ab6/lvmdvXWItiph0BC6WP3VP8drGRJoD0
X-Google-Smtp-Source: AGHT+IFuPGev3f+n9vOiPxbLr4Mj6VM7xaWfq7HiavRD7rWzgLrjzvvgwISBWuM53so6JWDV67XlCg==
X-Received: by 2002:ac8:5ad4:0:b0:4b0:8382:cc3e with SMTP id d75a77b69052e-4b0aed3efcfmr219391431cf.43.1754943839101;
        Mon, 11 Aug 2025 13:23:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b07e8ccb6asm93753201cf.24.2025.08.11.13.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 13:23:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ulZ3l-00000002Vsm-3knV;
	Mon, 11 Aug 2025 17:23:57 -0300
Date: Mon, 11 Aug 2025 17:23:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	eric.auger@redhat.com, clg@redhat.com
Subject: Re: [PATCH 0/2] vfio: Deprecate fsl-mc, platform, and amba
Message-ID: <20250811202357.GH377696@ziepe.ca>
References: <20250806170314.3768750-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806170314.3768750-1-alex.williamson@redhat.com>

On Wed, Aug 06, 2025 at 11:03:10AM -0600, Alex Williamson wrote:
> The vfio-fsl-mc driver has been orphaned since April 2024 after the
> maintainer became unresponsive.  More than a year later, the driver
> has only received community maintenance.  Let's take the next step
> towards removal by marking it obsolete/deprecated.
> 
> The vfio-platform and vfio-amba drivers have an active maintainer,
> but even the maintainer has no ability to test these drivers anymore.
> The hardware itself has become obsolete and despite Eric's efforts to
> add support for new devices and presenting on the complexities of
> trying to manage and support shared resources at KVM Forum 2024, the
> state of the driver and ability to test it upstream has not advanced.
> The experiment has been useful, but seems to be reaching a conclusion.
> QEMU intends to remove vfio-platform support in the 10.2 release.
> Mark these drivers as obsolete/deprecated in the kernel as well.

It seems fine, but I'd just remove them entirely right now. It is easy
enough to revert a removal down the road if someone comes with a
compelling reason.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

