Return-Path: <linux-kernel+bounces-726595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3A9B00F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C8A7B3921
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D192BE7D6;
	Thu, 10 Jul 2025 22:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb0T4GSG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4961D432D;
	Thu, 10 Jul 2025 22:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187919; cv=none; b=LYUmLG9JP1aOcSzks+BVsxgq5r1eP/VYJC8T8cd+CZ4Y6SdI6gCqrqxaUhaZkC1WrkD+j+rxgak6K9a7s6nf3Ps2NBl47ds+dhQGHIC8cQz558ByLWqj593XdlvgclHqlHDJHhJdSjhdSVEPEbVeFULDzwJkH1qWHF+Kz0LBD6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187919; c=relaxed/simple;
	bh=2SoiiN2aedDZElWi2ybg611D5EPVq8dWYtje3WeylSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocNvrxL915Pc7qQEr/uBeRH/qTTS9K7iDbSW6Q9p2aH0xnj20UpfVxZl8ehy3ZCsDSlo9Wv8LxmCDO87ZfdoU4Hm7vhCpj4PRK/82N/pHaw0gsbcmlbWTLxi3coo+b4hBuGmzdqizya5gRjfJlt2dyfPM3rAUhCriYbrnYQUd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb0T4GSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666B2C4CEE3;
	Thu, 10 Jul 2025 22:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752187918;
	bh=2SoiiN2aedDZElWi2ybg611D5EPVq8dWYtje3WeylSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tb0T4GSGSk2PVpFX76AUKoU5AkIXLgUY/8xfWehxCxDO2W3bLd34bWLd2GtzixqJV
	 3ikAfExXXNFJOs/jaZE6nmIM0hdUp483rdBOwxE2FpOgJHinQoFFmVQQZ+9ad9aze3
	 yxCHxMtJxZ/iw+/gRVzLza6U13NX65AlY3g3MF8ykcbT1gQ8bn1/3eUJC1oVZ0F+RK
	 f0YAcLUc7DQafhS2KkFRygS8v1QQy+bZp+uGXg+3KJO+AK5AtN8fBZHe5TUJ5L/TQJ
	 aZ5EPq677D4qsi9nI8JsBaeI1k30J7pt6Qr8+4in+Zq65CSVXmnsrVLaBs65hVXhoC
	 ZM8n8yfmTUUyA==
Date: Thu, 10 Jul 2025 17:51:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	ipedrosa@redhat.com, Marcus Folkesson <marcus.folkesson@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	Conor Dooley <conor+dt@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: display: Add Sitronix ST7567 LCD
 Controller
Message-ID: <175218791703.25569.4586034427262518390.robh@kernel.org>
References: <20250710102453.101078-1-javierm@redhat.com>
 <20250710102453.101078-2-javierm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710102453.101078-2-javierm@redhat.com>


On Thu, 10 Jul 2025 12:24:33 +0200, Javier Martinez Canillas wrote:
> Sitronix ST7567 is a monochrome Dot Matrix LCD Controller.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  .../bindings/display/sitronix,st7567.yaml     | 63 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7567.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


