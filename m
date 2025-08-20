Return-Path: <linux-kernel+bounces-777099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F3B2D52A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227C4721DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B9D2BE621;
	Wed, 20 Aug 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdoUNVYf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B9227563;
	Wed, 20 Aug 2025 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755675984; cv=none; b=cT0NlNUJFyvihIzHqfxdpgmQity8uoqOv7RObPu25KoFImxScL8UjsCIOmdA4kSIr0MqSQjdr0w7xAC5emboTf9Ob1E5vZoEq4gET4w42kcbeMe7EKF72P9F3kfGX5SCFOBxMLjQapDsWK+jqYXzuILcZb0FsmW7nxEMfwxGKw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755675984; c=relaxed/simple;
	bh=nEGzvYYrNHjBD+BsPHTYKJ//lWK16bNqWvxHypFf4xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLQR82yWumr7KtT4Vi3EtpyyJvEretnQWO7yX4/nzObf3SeeS8x0eJNrGeCfs03kBUW4sIgVQD/tCk6WiyNRVSf6UlZy1YgUBJHGqjGO0nigLXwcxmLwkV66/xbpYSf0JP4vUYudx9O75f6CNKtKrqLy1M+qjEtMhzxkkL2Kwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdoUNVYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88C6C4CEEB;
	Wed, 20 Aug 2025 07:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755675984;
	bh=nEGzvYYrNHjBD+BsPHTYKJ//lWK16bNqWvxHypFf4xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZdoUNVYfWppzQsbJFbLvj37skiHTu/Ow5EoHq0IpyfGCpoAYFJpA6rmUzogEnEVJ5
	 nzOjWsMH4W2PBwEgIQ/l/CPLDy4C3I17yxo4QVr1ojlGvU3or7N0T/x9JlndIinSQG
	 a/MYiUgfpwetaEQfsO8lqpuNXZpR629++TRjR3RIm+QBOcz3EMCZjh2pOnOSbCP+Q6
	 cj9cyc+ralb9+NIi21l+5ChXq+VvcFdg4L9160IMUFuGKywNdR1XWB7MN5swnJiUYK
	 qr/GBhtDDzJcM60v32dApW1zlP1PkNPrV/8zbH93yBgKwEtFa6ySl6XwODFm7WQqY9
	 XGqjsAJk6/msQ==
Date: Wed, 20 Aug 2025 09:46:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel: document Synaptics
 TDDI panel
Message-ID: <20250820-heretic-ivory-vole-4f3d63@kuoka>
References: <20250819-panel-synaptics-tddi-v4-0-448f466d16a6@disroot.org>
 <20250819-panel-synaptics-tddi-v4-1-448f466d16a6@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819-panel-synaptics-tddi-v4-1-448f466d16a6@disroot.org>

On Tue, Aug 19, 2025 at 08:26:44PM +0530, Kaustabh Chakraborty wrote:
> Document the Synaptics TDDI (Touch/Display Integration) panel hardware.
> Along with the MIPI-DSI panel, these devices also have an in-built LED
> backlight device and a touchscreen, all packed together in a single chip.
> 
> Also, add compatibles for supported panels - TD4101 and TD4300. Both
> have the '-panel' suffix so as to remove any ambiguity between the panel
> and touchscreen chips.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../display/panel/synaptics,td4300-panel.yaml      | 89 ++++++++++++++++++++++

I am not going to do the work twice... you need to clearly document
reasons of dropping people's review.

Best regards,
Krzysztof


