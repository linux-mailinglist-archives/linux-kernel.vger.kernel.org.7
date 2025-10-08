Return-Path: <linux-kernel+bounces-845721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E2BC5EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAC494ED2A9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995E22BD034;
	Wed,  8 Oct 2025 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO7fbAWC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B317A2E0;
	Wed,  8 Oct 2025 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759939436; cv=none; b=cSfNsxKSdJVio8rlm6izm7zUuGc5SZiXjGrLEuy+q5geux+KEEpWIPD+QOIabvjMy5NX8WEUE2ho0wl1pqfLdxIJu/jIW4gVW7muUAHMqdk4PL3FMlzkO71YW2iesHpko7IeE2mlZlEqi/wxI2rOn2+W7uxsWauu9KQt6cl1Efk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759939436; c=relaxed/simple;
	bh=u7Mi3rwGEpVppaHAvNCXL8SnrR71hiTmmzElC/nSmpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az11gI7cZdty7CdGwS8V5P4q5DAzfUVhBVyYeUozsOSGaQR04FRePGXPsR4S+i7PtcHhfkAgkivZkxU5M9z17ZW9QmKRrOJ0PVsDG8ogVCF1wIHbEzmsFjZEXm/u1avHUB1a1hXNkKKXk8KKU++B0CPNNSowbhpug/MiUv+vsgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO7fbAWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CFFC4CEE7;
	Wed,  8 Oct 2025 16:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759939435;
	bh=u7Mi3rwGEpVppaHAvNCXL8SnrR71hiTmmzElC/nSmpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CO7fbAWC/2eoO/0AoHoh7QLgnryzymPTA/FtTsH0l7aJFtBoshmUTG8SNZoRqlw8g
	 oeKJJTXRU2GUkxm+/UGgercNzde6RnQ2VFqqBjSuQHLFh6B1ULx9kMIE4bBXXxAg0H
	 X0mt0RcF4c0NrV8d7lPj8WalGW3U2b7xWlYld7O8sOBexKekMs1aEw/XfgcB7eMses
	 Cvfb8kjME/JFLtAo6nX0R0mtaZNmqGIHPwjhFdLqyb3R0PgJ0ha0xajEtCr0Sjlh6s
	 FQXAdaqZGc9Q1EqxvinkIo207B/hBacyWKKVfikcJ/f6NfElCbosaFKshOsM5fysmL
	 Om95tfltRqWcQ==
Date: Wed, 8 Oct 2025 11:03:54 -0500
From: Rob Herring <robh@kernel.org>
To: Jameson Thies <jthies@google.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org,
	krzk+dt@kernel.org, bleung@chromium.org,
	heikki.krogerus@linux.intel.com, ukaszb@chromium.org,
	tzungbi@kernel.org, devicetree@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: chrome: Add Cros EC UCSI driver
Message-ID: <20251008160354.GA3764744-robh@kernel.org>
References: <20251001193346.1724998-1-jthies@google.com>
 <20251001193346.1724998-2-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251001193346.1724998-2-jthies@google.com>

On Wed, Oct 01, 2025 at 07:33:41PM +0000, Jameson Thies wrote:
> Chrome OS devices with PDCs allow the host to read port status and
> control port behavior with UCSI commands sent to the embedded controller
> (EC). Add documentation for cros-ec-ucsi node which loads the Chrome OS
> UCSI driver.

What's PDC? What's UCSI?

> 
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
>  .../bindings/chrome/google,cros-ec-ucsi.yaml  | 71 +++++++++++++++++++
>  .../bindings/mfd/google,cros-ec.yaml          |  4 +-
>  2 files changed, 74 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml
> new file mode 100644
> index 000000000000..2121776e3ff0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-ucsi.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/chrome/google,cros-ec-ucsi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google Chrome OS EC(Embedded Controller) UCSI driver.
> +
> +maintainers:
> +  - Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> +  - Andrei Kuchynski <akuchynski@chromium.org>
> +  - Benson Leung <bleung@chromium.org>
> +  - Jameson Thies <jthies@google.com>
> +  - Łukasz Bartosik <ukaszb@chromium.org>
> +
> +description:
> +  Chrome OS devices with PDC-based USB-C ports expose a UCSI interface
> +  from the Embedded Controller (EC) which allows the host to request
> +  port state and control limited port behavior (DR/PR swap). This node
> +  allows the host UCSI driver to send and receive UCSI commands to a
> +  Chrome OS EC. The node for this device should be under a cros-ec node
> +  like google,cros-ec-spi.
> +
> +properties:
> +  compatible:
> +    const: google,cros-ec-ucsi
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^connector@[0-9a-f]+$':
> +    $ref: /schemas/connector/usb-connector.yaml#
> +    required:
> +      - reg

This is the exact same binding as google,cros-ec-typec.yaml. Why are you 
duplicating the whole thing rather than just adding a new compatible 
string?

Rob

