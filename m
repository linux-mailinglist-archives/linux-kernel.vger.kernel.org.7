Return-Path: <linux-kernel+bounces-781304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF272B310B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6716043ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BAE2E9EA9;
	Fri, 22 Aug 2025 07:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CacS4nRL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C02E6115;
	Fri, 22 Aug 2025 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848737; cv=none; b=pOLUVdJi0mVIkWcHZuPFJdTZZCM8FP5r7QfiDe9xxHqeFA/AF43jnxDfwwQw+QzKg0rXYwn6BuZWVgtW47Po3epjeguF96gE4Osq1gE2ceoTxAZ3Do8gOzKJJOEyyNUEO0FJOpkYyG5FETd3vmBsHcQ1vjeX/NnaSFnzyfJON/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848737; c=relaxed/simple;
	bh=o1oCYNAE5S3d3+cWMnU9MkrLgM16Mf5zN/vKcGN7oXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qI5FZiPf0U5nwUtGrqY9UzSgFHx5HRqxTmH9ZjPjx9/kc4upYXID9Ilz3k9K4uywz0WS56Hjfyad/4vAeoJ2N49K69fHTZNsr2x0Q4FIXZFagkNu3s3G7VTutknwByk76AkF4BBAAP9WxvXW+EovOgciBCbhRRFEJ1E8Qahc9Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CacS4nRL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C41C4CEF1;
	Fri, 22 Aug 2025 07:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755848737;
	bh=o1oCYNAE5S3d3+cWMnU9MkrLgM16Mf5zN/vKcGN7oXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CacS4nRLoOK8++Ox+Fskby9oVc/kdJx0j0WArtxfj8kZ/MVyXD98TSI5VDu6Fko2I
	 X1OiwokdwHLY8FrITjKkXM765CKeK7DOeW8uaWydf8C/bW0JqZ2EUWsEv0+bPXca9N
	 ZNQdufsP/yWAPWgQTNoWRb8gGVIQVVYnBK/KGjgKQWjdPZaZTYp/mXHOjjUhNu++wz
	 pMdQXCQbm1k/N/wPqc9nvy6QZ2T5ds9XJui3jPo8cyzojTy8Et3KZS2hzt6oCec3Rr
	 20ntJ36rh5VizlrsX0WpmZRrXJoC1jPEm3unj0AIe+oSbV5o6vnc8HmeIP+kO61QEm
	 LSbervCQuyNYw==
Date: Fri, 22 Aug 2025 09:45:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: robh@kernel.org, gregkh@linuxfoundation.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, peter.ujfalusi@gmail.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v5 2/2] usb: dt-bindings: ti,twl6030-usb: convert to DT
 schema
Message-ID: <20250822-elegant-olive-rhino-3bf988@kuoka>
References: <20250821212824.70569-1-jihed.chaibi.dev@gmail.com>
 <20250821212824.70569-3-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821212824.70569-3-jihed.chaibi.dev@gmail.com>

On Thu, Aug 21, 2025 at 11:28:24PM +0200, Jihed Chaibi wrote:
> +  interrupts:
> +    description:
> +      Interrupts for ID and VBUS events, two interrupts must be specified,
> +      the first is the OTG interrupt for ID events (host mode), the second
> +      is the USB interrupt for VBUS events (device mode).
> +    minItems: 2
> +    maxItems: 2

Redundant constraints and description.

interrupts:
  items:
    - description: OTG for ID events in host mode
    - description: USB device mode for VBUS events

    Best regards,
    Krzysztof


