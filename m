Return-Path: <linux-kernel+bounces-853605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2DBDC15B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B28B400E26
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E226C2FBE1A;
	Wed, 15 Oct 2025 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hwKjdpaH"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AA521CC49
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493415; cv=none; b=OuKSIvRIxhxwFowg6X+ZtGbluZoxVetgx1zoh8f8i8P2C7yNl+z0K55im1gIsBSxp67I4Ej3UAiBdQTOcgpdyvBS18OgC9ukQ238PfnzC+jMWtIE1Ugx6esT9yAdIYgFbYQBcPF07QOAFdUgdGuvk/PmwMPjYiWilSdUq5+cLps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493415; c=relaxed/simple;
	bh=FThhOQrJbCtjj1TTK9njlcMwLVBiVt0cR2pa63pzOII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El+n/oLX8v4JeO6gXCI1pBm7CuIUxMVgiyP5VHskmQSbAB1D6NmWACiWZP/N1i6AiHPFlM2E8Onsb7KUuOH3aChERm2XT7Ie/u4LpvDM2wI5t9M8fJVkwdFY3RLp/8FHN2gVozo+nw11iAoUBGOknYAjoT/B2phNE9U/RA9wjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hwKjdpaH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781001e3846so5802536b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760493413; x=1761098213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=822jt5nEXo/RsUhaWbDrvompK6uhrTRlKH06xCVQnfc=;
        b=hwKjdpaHSXxKvsPPMwfl+aZeGlRt5f6brIREm0hv2AYjlDTn00wv0cMXOV1kp/FxSx
         F5u8W2NH0bDk4wYF5inc5AWiiXUSdfhI5zTPScSMlQYFpCOYJ0tcQ8wP+8x5IWB4518r
         HBbNPthfPnLh0UljjBNVyz9HBInyqNJtip0F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493413; x=1761098213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=822jt5nEXo/RsUhaWbDrvompK6uhrTRlKH06xCVQnfc=;
        b=Ux2bGMjaykeUuKaNF+pYqZkcnH+4xzVOhFXFz3L7RkT2g/ehKR/VFAVbbjuoKzKPVN
         vP5UnL6qKUtFbJLGqcKYRsrr33O2BbzcriWK7crLIznwX1O+h+AGkP+4vjNR5Rpd7BEf
         EBvu3MgIkrvToh4bo7bJ0eCYE+O6636MFXZbAUVjPe9uGkYn+U+uPUWL89WxmNNKHRyF
         Ld8RNNnxytztU4zfse2MSXVMswsgzQynFKbShFTsMWXj6ZCOmkFO36msH4qHUGRmQZcd
         ld1S15XXmqA2jU3bg3UXBE/1xhHEjX1p5OOhtoL2wGpd7b5rPsJkg4DnoUHXUbUePixE
         lkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxmL09337LGiV+Ql78F0QvfrKlVYXm+CWUXpkzQgN2Kaz43DJpxCzBmWPpQ55GARpGOwUQIGDPLuOoavQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8IfnuA7nKvT6zfAKNzsdc1whrfSvs++PBojAP98NCLoQJ3jdK
	QvxYMVLO0h0AfuHVmpyZzGsOK/HnBPC/9jnAijZ5pVkWfRnMw1+ft8dyLU8/L433Sw==
X-Gm-Gg: ASbGncueH/G6I+Nu7WYqr0WeV7b+zhvLkXwpoAW8hYbuOIv8BqnftXMvT4blmmafalK
	WOfFUeFRBfTgoZanwHiymVFHt/rm+PH7t27Tm+2WjYZx6WZsJ7lPNZODVg7jRHOK4hkfMzw89gD
	SEZkWbF9L+fprOJ8Xh13IphAnveISwrQG6Z9eaD2K1mH558Pwfv8emloIXnVmN4LsUxCUbJpUs6
	iwRq4Bwdrunu9KOF4ua/x9Yy4SvHxVyVUWAuoqRTlhJ+c2CAm0zNhZcwoDTREyujdSoIclYL8e/
	42wmFOSJMJSaLyjC0KlFR/3EVDzME7Ed6+xFKr96IisfPMkhUkc4OXnDBrqKyb7SMqNd8rVcyNe
	t8GDILuQUQVL7btcf7ph5bG31dleGhMZEgCyxmE1AgsCvKauAWpAo1w==
X-Google-Smtp-Source: AGHT+IFSmlSytCc9zkvG/SRHsjlMMQoRxAEYdYK4gnYvww//dSwAhUqG1pTtzJHUpugUyz5xS6ETKg==
X-Received: by 2002:a05:6a21:33a4:b0:2cb:5f15:ebf8 with SMTP id adf61e73a8af0-32da81724d5mr33293736637.27.1760493413122;
        Tue, 14 Oct 2025 18:56:53 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df48a83sm13978466a12.31.2025.10.14.18.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:56:52 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:56:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <wd3rjb7lfwmi2cnx3up3wkfiv4tamoz66vgtv756rfaqmwaiwf@7wapktjpctsj>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
 <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
 <a9857ceb-bf3e-4229-9c2f-ecab6eb2e1b0@arm.com>
 <CAJZ5v0iF0NE07KcK4J2_Pko-1p2wuQXjLSD7iOTBr4QcDCX4vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iF0NE07KcK4J2_Pko-1p2wuQXjLSD7iOTBr4QcDCX4vA@mail.gmail.com>

On (25/10/14 16:02), Rafael J. Wysocki wrote:
> > >> Would it be possible to check if the mainline has this issue?  That
> > >> is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
> > >> with commit 85975daeaa4 reverted?
> > >
> > > I don't think mainline kernel can run on those devices (due to
> > > a bunch of downstream patches).  Best bet is 6.12, I guess.
> >
> > Depending on what Rafael is expecting here you might just get
> > away with copying menu.c from mainline, the interactions to other
> > subsystems are limited fortunately.
> 
> Yeah, that'd be sufficiently close.

Test results for menu.c from linux-next are within regressed range: 78.5

