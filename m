Return-Path: <linux-kernel+bounces-802277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 749DFB45038
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D83B04DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 07:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A24D270ED9;
	Fri,  5 Sep 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uubodxz2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF483244668;
	Fri,  5 Sep 2025 07:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757058507; cv=none; b=Biwy99eU8gAKRnrQvXUM/sLWNgaVkH4f0fd24Ljby4CaBEs+zAO9szCT5qPEajsQvHVrLTsXY9GUGdfM+jIhDyWlPlfSIBZWTWOftUYy1pmKM464/7i2jON8Qy74dYBY3MmQdORv7klguX8flRvKd2f6emx8Lv/2y/2yFjoIgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757058507; c=relaxed/simple;
	bh=5JNjVycwH4iJovPbCihfHdVK/+rBudC3sSMe1ssTnqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U774o6kyfY8rWmatiG6qrTChpEjHCwJtX8AYS0i/caGvw9/HvKggf/WOPGAkIFxHWw5jZpkHI8FNzgMbHcxchPnL8b9wuTrUQUzAtFAQvhr7dylgnkAPTlWXPfYW2bOfoY67ju9a1D6htd7qPWZ5XwQ7ReDgF2AtV2y7Zf1Efyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uubodxz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F476C4CEF1;
	Fri,  5 Sep 2025 07:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757058506;
	bh=5JNjVycwH4iJovPbCihfHdVK/+rBudC3sSMe1ssTnqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uubodxz2TxBSPtOKTA1Au2IJm/OvQjtygmqYZdI3l2HOJZ5UilJVPGuba3NfRzvEF
	 8hwV+G8Qr95qjd5mxHkuUJF5yJm+0KXykrgJ24fK1Ypd84PaL2UuKYn8AdWo29p/KV
	 wVvglWdzlbPWu0zC5+GKLUCrsc+65n3ezYHqRaiaqG5k4dcsX0yu2fxNZVhXpR6yZp
	 FD3rV2UDV/fIOAf3ONN3vv85m5yHVzPXqmYI23s73eGfHBC7P0jRWXIhoZwclLRPvJ
	 h5VspdHVblWwtUudJzidOFYeEz4bYNfSz8iebjk7CD7RucHvss4KJYZprjWyNWJawG
	 oMwIW6XvlMo1w==
Date: Fri, 5 Sep 2025 09:48:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Woodrow Douglass <wdouglass@carnegierobotics.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] regulator: pf530x: dt-bindings:
 nxp,pf530x-regulator
Message-ID: <20250905-lush-russet-seagull-a7e10d@kuoka>
References: <20250902-pf530x-v6-0-ae5efea2198d@carnegierobotics.com>
 <20250902-pf530x-v6-1-ae5efea2198d@carnegierobotics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250902-pf530x-v6-1-ae5efea2198d@carnegierobotics.com>

On Thu, Sep 04, 2025 at 04:44:35PM -0400, Woodrow Douglass wrote:
> Bindings for the pf530x series of voltage regulators
> 
> Signed-off-by: Woodrow Douglass <wdouglass@carnegierobotics.com>
> ---

If there is going to be a new version:

Please use subject prefixes matching the subsystem. You can get them for
example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

regulator: dt-bindings: nxp,pf530x: Add NXP PF5300/PF5301/PF5302 PMICs

No need to send just for that. Thanks for changes, binding looks very
good!

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


