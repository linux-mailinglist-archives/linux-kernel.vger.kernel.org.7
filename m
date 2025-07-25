Return-Path: <linux-kernel+bounces-745551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05894B11B83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455DDAA63C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9072D6400;
	Fri, 25 Jul 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xe+mspec"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF622D3212;
	Fri, 25 Jul 2025 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437817; cv=none; b=gz80b0IerTVgJ+QIfsAyxWxDmjRdBzhzYEsXM/gNF+CR5M9rFKMAkIFPYd2GDdlSjIUSu/dJcjzCvSEmiIYMvq8TdrwAhxRlb6Ev3tLlyEb7rkmn1Uv/Wqcv26/mrxgNaY9g3r0tkQvGLp+H/0EhgLOxbvTaNdv6OgTIj4TGCo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437817; c=relaxed/simple;
	bh=2Xcxj6CxXPYmgpdbcm3LifTitY5/vSpgBOKf7k753pM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTBeKsVhsxX/KTu1jkeGES5TLOdvY1C8olxpp76SjInrkWttqFGyy8l0MTLfKlKFZaOD3E0E5/OK8RSrU4cX7J/sNGt5mOYHOSnS4Mb8o517Wj1ZVCTAAjXIoFZCR3ZJGFY6zgMlq2lnbuPyyliqIrLFrDedqPvc2aKw4SD+NdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xe+mspec; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6148e399effso3238237a12.2;
        Fri, 25 Jul 2025 03:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753437814; x=1754042614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYT/ZpaS91W6/xprKrUuzyRTEsm+ufMJV43TIpSv2WI=;
        b=Xe+mspecxG+fnboL2eKrjSUYDIQyhy1L1dIPeODaZMB6prB91QBYD4fRG2+Ox0S+C+
         JwgDj/neGUpRCg0KqxgQDQdG22Yp9ufY7ItkaL5Fj3cpMYHIpEJuXGuuAmG0rzzrqJDh
         u2/ZmiZiwd+Xn+lVLK2xSpae1QNKsVbdTOv9cUOu+XGXYkcWM/zgA5Kh3Dp46F4P0Pbw
         KoHRaRMXDWIL+xS4jz2CHnR+fmLdIrcsQxav5kvjup16ao/JkIJUfseh+dNghW8ayuun
         83F7qhD53ZnSM/JsSKi0m0MmmEeYUHpHYF8Ahti0k8VTcNchiWBQGZ6SLtshVoo8ijUg
         Is1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753437814; x=1754042614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYT/ZpaS91W6/xprKrUuzyRTEsm+ufMJV43TIpSv2WI=;
        b=mDHl4bXSBpK7rKZLn9rUEgUvbc8ZhuZG9rCfXVWclB5V5tXMeqKgG9sBIAwRDTj0CN
         8T/Pz2idcZZR/K07q7Nvm7h0orJB7U7XYi1TwhqHyyRNKoDp4dT0N/abX9UgvKLVoTWf
         9dcQ9SQtyDLNQ38zwJXg4NRlIXYuJE2mMwYyHLvF7epROVIbHAVzRIk6Qa/a9rQQxrxA
         o5M48SS8ywxi5ICFJkF0DBi023DwRwx/zTgqeEPQ7+Vt/7kpPxniqF26pr+siWK0bI6F
         B9CluWCZ5jfz9U6q+ghYS6BSK0mUrNcuxmc+T+YEd8LB0Pt8YgmAgLQaJkAs6cGV2QDV
         UvFw==
X-Forwarded-Encrypted: i=1; AJvYcCUrb029BTisewWVK5CQM4zJjNceJCP0/TgOQRUmSVDb2Etrm3p+F2h8tq+hu5MSU+3d2gOsDmb9uM0UPx4B@vger.kernel.org, AJvYcCWas6auM2OSdlw1djWwWBJdJUP0Iwhv3ZgRol0nCVfcaUezJDKzR6RzsskVVqI5HWyfbwLkKcV/FqJ5@vger.kernel.org, AJvYcCXK/B80A6XEvw1OXu/aEAFYTjgeuS9HoDW82kOjjRfE8Gf4mqcpsKuIYJF62izSNY//cegpKHzLsjpSaPkI/0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjFaIbJD/mt3PLYyQ4PUWqHPPA2kbpI67K5EDwWIg7UE+ZM6oO
	hYl/ITa0zNeZ5nIFD+yXzcU3Nhd9sTCtvgjPf9jAx+LzxxCMJ+tD8wRS
X-Gm-Gg: ASbGnctTh0Hhzjgg0bVE5Ul64GFTHwuvXbhgW92q/Yi1OcV6pF/6fPffNQgA4VE9pm2
	EE3NgK5Yn0Yu7Mu8x8AT3uDob4aZguQ5tSChBSMcUNudgsfRkv84dyGTd1joUoX5Ix2bij6d8C7
	vQ8o208Uxaap/OHDAaFoSEUOmnFQKFg+OgSYAVKlrtjHzVJWCQ0wj516+W4tMm93sflbO6W/4A3
	Pp0NfWc0dsdJG5kjgtQ9gNbuF1jBq+h5AiGPAWOFluGw1WIHTgJQQ0JJDp60FaMwIVYverz8Wnx
	s25a3tbuLCO/x6ul9xJNFf+npMZdec+7k9Gh8iYD6diLhPpkihr0nscKBaVdagHn19X/emWy1Nq
	rlFvvMmMIEjwC5Jv8nWY2wmq8QcTq2UU2
X-Google-Smtp-Source: AGHT+IExEh38x1Y+3W09PhN0T5BYnWYn7f8rUf4Tk84eyi7nh8aRx3DDWyyWpkEVNXBcNcbGNUpRgQ==
X-Received: by 2002:a05:6402:2708:b0:60c:43d9:d077 with SMTP id 4fb4d7f45d1cf-614f1d18919mr1239806a12.12.1753437813986;
        Fri, 25 Jul 2025 03:03:33 -0700 (PDT)
Received: from foxbook (bfh67.neoplus.adsl.tpnet.pl. [83.28.45.67])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-614cd33580asm1797617a12.59.2025.07.25.03.03.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Jul 2025 03:03:33 -0700 (PDT)
Date: Fri, 25 Jul 2025 12:03:29 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Su Hui <suhui@nfschina.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] usb: xhci: print xhci->xhc_state when queue_command
 failed
Message-ID: <20250725120329.2b6e3813@foxbook>
In-Reply-To: <20250725060117.1773770-1-suhui@nfschina.com>
References: <20250725031308.1355371-1-suhui@nfschina.com>
	<20250725060117.1773770-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Fri, 25 Jul 2025 14:01:18 +0800, Su Hui wrote:
> When encounters some errors like these:
> xhci_hcd 0000:4a:00.2: xHCI dying or halted, can't queue_command
> xhci_hcd 0000:4a:00.2: FIXME: allocate a command ring segment
> usb usb5-port6: couldn't allocate usb_device
> 
> It's hard to know whether xhc_state is dying or halted.

Is it truly a problem? This is the only place which sets
XHCI_STATE_DYING that I found in the whole drivers/ tree:

        xhci_err(xhci, "xHCI host controller not responding, assume dead\n");
        xhci->xhc_state |= XHCI_STATE_DYING;

And AFAIK such state can only be exited by unbinding the driver.
Are there really cases when it's unclear if the HC is dying or not?

> So it's better to print xhc_state's value which can help locate the
> resaon of the bug.

Hmm, any chance you came across bugs that upstream should know about?

Regards,
Michal

