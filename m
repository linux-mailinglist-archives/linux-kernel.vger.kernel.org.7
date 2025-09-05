Return-Path: <linux-kernel+bounces-802305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04769B450CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC97CA419BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBD12F9998;
	Fri,  5 Sep 2025 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyLMCqhS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE902FF168;
	Fri,  5 Sep 2025 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757059291; cv=none; b=XTu652/3ATxzswk7p0ZmcCSO0BKUOiPUDK2ZEnWNggx7HFAkZCCOUXTZmChRS7La6RxtZYddNxju6udtOsxAJ5RjDb4tVAvR5ozbC8iBKwojBAWKtJtkeK4Fr++SfujDopbODliZIze4lsOg1NhIrmb6HHUuI7BV/ySAriyA3vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757059291; c=relaxed/simple;
	bh=lYEP2HYn2TrtOnfrEZQ8dxqYp/rnzKoSciptL+BYOs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aX6u4ood4SJnhXEdzdk8H8dWDpiOeMXFtC1sNz8TGO8IBR6eOZ9PKTZ7spzRaTvY/B39JQF6RZMX26AZ2N5i5N7PjDvM9dHDtmoQbcaNy+MT7wlEet29JBVeAWuVhsfXfNrqFiaYJ0jwVgrWEPOrz82I0/ugC3JOhOKjGA/m0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyLMCqhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E3CC4CEF8;
	Fri,  5 Sep 2025 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757059290;
	bh=lYEP2HYn2TrtOnfrEZQ8dxqYp/rnzKoSciptL+BYOs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MyLMCqhSrKxlSWAhYXmcYY8k7Kjxk0H1ADBBteGzSojG/RPkurGLCCqscl1BczM36
	 qOiqYhiqwNh7fkgugX5jOyHXtUHuZbtz9OjiaR7O3jrZ46LemHXXqw9fZm6or878c1
	 TWtNiT4ONbhfHn82dLYzFSoFC3MMaaQWjQXye9JulPy4ymctz+dGq4dO4/q2VZe6UH
	 eIMJvDpSReJQjac6Gg+fEzlfxYFDsTXlWREMIislIZuTkN+yHtR5pL5l62pjTmppWQ
	 6cvcoOfxjso8LN2Ey4/7m86txN/78ry8mqhLAg3Zyq+Wb1q/VcAVItsI5Od8mXcnj0
	 9e5/xYy2EsdDw==
Date: Fri, 5 Sep 2025 10:01:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Gregory Fuchedgi <gfuchedgi@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>, 
	Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>, 
	Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
Message-ID: <20250905-lurking-smilodon-from-vega-eedb6b@kuoka>
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>

On Thu, Sep 04, 2025 at 10:33:43AM -0700, Gregory Fuchedgi wrote:
> This patch series introduces per-port device tree configuration with poe
> class restrictions. Also adds optional reset/shutdown gpios.
> 
> Tested with hw poe tester:
>  - Auto mode tested with no per-port DT settings as well as explicit port
>    DT ti,class=4. Tested that no IRQ is required in this case.
>  - Semi-Auto mode with class restricted to 0, 1, 2 or 3. IRQ required.
>  - Tested current cut-offs in Semi-Auto mode.
>  - On/off by default setting tested for both Auto and Semi-Auto modes.
>  - Tested fully disabling the ports in DT.
>  - Tested with both reset and ti,ports-shutdown gpios defined, as well as
>    with reset only, as well as with neither reset nor shutdown.
> 
> Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
> ---
> Changes in v3:
>  - cleaned up dt bindings in response to v2 review

This is very vague. Everything is a change or clean up. I requested
specific things to be changed and you should list them.

Best regards,
Krzysztof


