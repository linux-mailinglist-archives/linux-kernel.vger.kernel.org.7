Return-Path: <linux-kernel+bounces-747480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19185B1344E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517261710C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B440122126A;
	Mon, 28 Jul 2025 05:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8ni+fwK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4E4C6C;
	Mon, 28 Jul 2025 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753681819; cv=none; b=COshmg6YPSpBQ4Vgw9d9iuZFsHtMuZDnPNsfJmJJm/WCi+dBD/Gwy3SWwZ+QTRvvJ90pqvpZVQyjDZT2PL57EUD0XwvWHPCIcgZzxVU2DhtlW/7jF9pag2mcRhqV/Ck0jcgidtfl31upBJBxgBgKk8826dsc3BckhTB/dpg6r4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753681819; c=relaxed/simple;
	bh=8CHwPyEt/S1za+PezckxZg5kwb5NUOkthcCLJ5YZhuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNFGhaUSz5AmpAJDoZWe0P5RIJc511zgKYFGSBDx+rS21SofDf7DNsve2DuHIgDZysD8sPVFayK67BptxETVnKOI6dbkWMrsfNQQbVyTXk5SCnxFxqQN0WRytgZRgA5iiQaDHUoc6wXLl9YIP/PBnTGkJjXMUCxlHDKEhFbpfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8ni+fwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212E0C4CEF7;
	Mon, 28 Jul 2025 05:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753681818;
	bh=8CHwPyEt/S1za+PezckxZg5kwb5NUOkthcCLJ5YZhuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8ni+fwKypbz/hHH3zuU/6CZN4u9rzX+YbtnJadNc3nnuRh1c75WNOR/Mu1Z/rDsn
	 aDNz4LZIX2X2DyKn+ZxjuamfjJVpK4OeEaPNVSGg8AoytnptKC9yg/uy+7rLPRL2XA
	 noD2w5P/0aIBFbo6w8iMFr1/PwjphF+BBY+AVLJW0IVCKSWHm3P1nVQhHz2b3pJqZK
	 mwrG6RVO76DsYKf/Zf802YNJ1ca122JsMDnp7Utvm451j7hOI+lHbT7wHOidOaRYB7
	 faJ6BNldVQ6iD3NH4wblDoIzVB4RuKjCYNQASKpeGgcfbOqgUCSy+WAD9UwSJ7K7cV
	 el2L0cK8g6Eeg==
Date: Mon, 28 Jul 2025 07:50:16 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jessica.zhang@oss.qualcomm.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: display: panel: samsung,atna40ct06:
 document ATNA40CT06
Message-ID: <20250728-daft-refined-sheep-18ce61@kuoka>
References: <20250727165846.38186-1-alex.vinarskis@gmail.com>
 <20250727165846.38186-3-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250727165846.38186-3-alex.vinarskis@gmail.com>

On Sun, Jul 27, 2025 at 06:50:25PM +0200, Aleksandrs Vinarskis wrote:
> The Samsung ATNA40CT06 panel is a 14" AMOLED eDP panel. It is
> similar to the ATNA33XC20 except that it is larger and has a
> different resolution. It is found in some arm64 laptops, eg.
> Asus Zenbook A14 UX3407QA.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


