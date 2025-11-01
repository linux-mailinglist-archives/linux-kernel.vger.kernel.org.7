Return-Path: <linux-kernel+bounces-881139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 373B5C278CB
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 07:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F6189D5D8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 06:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578AA1A9F84;
	Sat,  1 Nov 2025 06:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aUfkeWNe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE0635
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 06:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761977905; cv=none; b=pTCm38TE+KfTNs+Ir7j8A8O9IDVPT0aZPvMrG4xz4UEAMaC3zdOd2vDsLLDifBbw1CiEMCCQHwwKSp8sUKukxNAmlLQqdbKvtG0PyBCJ8Rmkp9lu1gPNkIe7tfHUnGXnXMTnJC1avSVgb3yJ8SAQihBqsFIl3GXKqL2Y36MRtcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761977905; c=relaxed/simple;
	bh=5yAoqEPuE6KKwtbKkjtS2q3wb9YxdWs28FPD+/o6xWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nzukhv9k7qZwxFPcdI3tJPE9EkMq/LFa6KfOl8Yk7JdSHSja9J57g2lMqsGhuhNB3Uv8i4aGWcY9lrbRzOAplr+JsicMgxRdQor0gifpQPHXbbYvCZGU8eQrR4a5cTmwO23BCi7Q7CjIrR5GgfDXOD9C/uIdwPJ91+S7ZYtyuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aUfkeWNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D7BC4CEF1;
	Sat,  1 Nov 2025 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761977905;
	bh=5yAoqEPuE6KKwtbKkjtS2q3wb9YxdWs28FPD+/o6xWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aUfkeWNe2sLL1ZRQMnFK9bOkHBX8zaWweWzQgioulsW0t2rcl8Xvexs9NaSIyh43s
	 YlGePY88YlmlbrpkFgNNwG2cRk6aTcfZrO0+dco0V4OpHBV45pK5itgHfYuQme2sK4
	 CQPiYWKcQL8TfI+Fme9AgDaXyvtz4xDzYebRQa8w=
Date: Sat, 1 Nov 2025 07:18:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Raag Jadav <raag.jadav@intel.com>
Cc: kees@kernel.org, broonie@kernel.org, arnd@arndb.de,
	andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mod_devicetable: Bump auxiliary_device_id name size
Message-ID: <2025110105-upright-dinginess-3b2c@gregkh>
References: <20251031190234.224813-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031190234.224813-1-raag.jadav@intel.com>

On Sat, Nov 01, 2025 at 12:32:34AM +0530, Raag Jadav wrote:
> Since auxiliary device id string is formed using the combination of parent
> and child device names, it may require more than 32 bytes if both the names
> are long enough. Bump the size to 40 bytes to satisfy such cases.

What in-kernel users need such a larger name?  If we allow larger names,
people will try to do crazy things and use memory addresses in them (has
happened already...)

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
> Triggered by [1].
> 
> [1] https://lore.kernel.org/r/aQSwWLVKH_3TthTW@smile.fi.intel.com

How long would this driver submission's name be?  I couldn't figure it
out, and really, any device with a huge name is going to be a pain...

thanks,

greg k-h

