Return-Path: <linux-kernel+bounces-756036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1981BB1AEFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 072854E222E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C74225417;
	Tue,  5 Aug 2025 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feGSlOI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AE21D3F1;
	Tue,  5 Aug 2025 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754377112; cv=none; b=QJA064VYajKX/bSZ5v1D49ZARSQjNE3Ngj8YLU/yxWrAkrMsu+zQw+lSCRo64FhHo07oiSI9bupQQG2+D7mUGowhZkYtlerATJW2UhLp7gYzVq/7pArjd1bZfx9Sr/P/Z6HCzO5phao0lg2ym6eoJ9ZsFhK3JW6NL6JA5CN1akA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754377112; c=relaxed/simple;
	bh=qksf0vLPcE49IppNKVtMY5OdGFbAJ0657ZFt7447h3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeFfPFnN285zekCsqzcNzgpqWgaxQF6EBVyLzgGf3VWU5OmeYDlxKjxZ1kS5CvKtM1a4T4oZ3osvJSsE8blRwERSH8spi+b4+r2h9GcTEpEu3Q/6Mwul9eAiahl973ZAWpwpX8dYO/M2m/I5Vx/bJVjGECiRStNWOXSNo9/cLF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feGSlOI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABC6C4CEF6;
	Tue,  5 Aug 2025 06:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754377110;
	bh=qksf0vLPcE49IppNKVtMY5OdGFbAJ0657ZFt7447h3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=feGSlOI/GQMuqpegscRmFmLB5q1QsDZzFTcIrP1W/17yGlrrH+4T/SbNZ3Vb4TXkA
	 LwgCZsKjRX1y0qIP1qeTdxmURgeNBDGyT44FRqSZRg2spMGnmLJUpxcQoOroK4c5lG
	 ls1iodlJ2bGik2D+tYnqAcI/8lNaAhYnaj5swXYqG3/VVDf7EBTV8/ryWd0ZVgRpAR
	 ejedjZuONVyHnG4uKpQaGbJ5AAZ3G/yt79jwCqSxIOc//uaL6RRwYUQE39BlpjFpqD
	 EN8DLfz8ZCgSDvzxsL8dTjBJ16b3vQuk84xaxkRewjaWqsz8Y7RvqU+UgL4X0yxs1D
	 lM6S5Oayq+NEw==
Date: Tue, 5 Aug 2025 08:58:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: ChiShih Tsai <tomtsai764@gmail.com>, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, t630619@gmail.com
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: adm1275: add sq24905c support
Message-ID: <20250805-ruby-earthworm-of-cubism-4d1c8a@kuoka>
References: <20250804124806.540-1-tomtsai764@gmail.com>
 <20250804124806.540-2-tomtsai764@gmail.com>
 <48996ed0-8d5f-4bb0-ab66-8be71c0a59e4@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48996ed0-8d5f-4bb0-ab66-8be71c0a59e4@roeck-us.net>

On Mon, Aug 04, 2025 at 08:59:09AM -0700, Guenter Roeck wrote:
> >   allOf:
> >     - $ref: hwmon-common.yaml#
> >     - if:
> > @@ -96,12 +109,17 @@ allOf:
> >                 - adi,adm1281
> >                 - adi,adm1293
> >                 - adi,adm1294
> > +              - silergy,sq24905c
> >       then:
> >         properties:
> >           adi,volt-curr-sample-average:
> >             default: 128
> >           adi,power-sample-average:
> >             default: 1
> > +        silergy,volt-curr-sample-average:
> > +          default: 128
> > +        silergy,power-sample-average:
> > +          default: 1
> 
> I personally don't think this warrants new properties. However, if warranted,

These are the same properties as adi ones, right? Then I agree, re-use
existing ones.

Best regards,
Krzysztof


