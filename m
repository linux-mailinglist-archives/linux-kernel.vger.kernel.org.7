Return-Path: <linux-kernel+bounces-747479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108E9B1344B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478681768C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8C1220F33;
	Mon, 28 Jul 2025 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOUYjt8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236B04C6C;
	Mon, 28 Jul 2025 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753681808; cv=none; b=YbXvE7E+iPm8S1nkzlxDw5TJhgaaDU8EgNE4YBeN4elA9jHtGwut8r87Maxv7wyGmHLD4HHtDCIHE9JBPjrFtZhhr6+Np3Zo/RBT9hKtDCesDh0zyH0NyToVBgOo4RBv/m59+to06NJgl//DQigA8m0z6556xFvjiviBFVseFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753681808; c=relaxed/simple;
	bh=3oQdTpRQlTah4kbX+B+OQ9gdwk9tbQ+jJV6punq6onA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXqi0Hav/JmQSA7l/42c/lMTF6ahJnsWNEgWB4pAJrL3od8X0nHvD6VY6qOmqDtgJQUuhpQb3J8JqOKkLHtFDvghvU7g+1KP1fyXV585RDYd6H1IEwp58HtL4y3JMyG8EBDwE7CbSCPajk9+klwEIgf7Jf4xo3x5A9nOr/Bkmh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOUYjt8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C827C4CEE7;
	Mon, 28 Jul 2025 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753681807;
	bh=3oQdTpRQlTah4kbX+B+OQ9gdwk9tbQ+jJV6punq6onA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOUYjt8SggU9iPP7HvVYAP7PwW0QrLqXvJwEVhXktAInlw1/my5pGZPjADYeFbEvq
	 8wapevw20DCajENqXLGKaLg/ufnh4C9Lkyb7bKFj9C+4FouxF9MmyMDlIMEb5AUJXC
	 rzglSxa94DTVlikOHwGbptTfPQOP7lNfSda992LY8DQrCyAP1UG+/VtUhaH/8uLI/w
	 I9fVZcTeBXhKATdQcLgbP49G5TxSe4nC6P1aET4tlAciAJg0fqzQPrFUPrymCXnFHc
	 GIVHDaN9V4IOQJuNFrWUcP1gzVpvxc2+0wyPIXph9qhjn0taB2n4sq9U4sXa3tD95V
	 QqMUl7JvUIhGw==
Date: Mon, 28 Jul 2025 07:50:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: display: panel: samsung,atna40cu11:
 document ATNA40CU11
Message-ID: <20250728-perky-bulky-rhino-8d834a@kuoka>
References: <20250727165846.38186-1-alex.vinarskis@gmail.com>
 <20250727165846.38186-2-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250727165846.38186-2-alex.vinarskis@gmail.com>

On Sun, Jul 27, 2025 at 06:50:24PM +0200, Aleksandrs Vinarskis wrote:
> The Samsung ATNA40CU11 panel is a 14" AMOLED eDP panel. It is
> similar to the ATNA33XC20 except that it is larger and has a
> different resolution. It is found in some arm64 laptops, eg.
> Asus Zenbook A14 UX3407RA.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


