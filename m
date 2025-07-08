Return-Path: <linux-kernel+bounces-721787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4FDAFCDE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A857C4A406B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426C2E03E2;
	Tue,  8 Jul 2025 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2dFHSd3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8B42DFA37
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985554; cv=none; b=eHzZiq7h3jmICE+JF39cya2VnG9QX1HVewMdNGuhTy+hsvKZLhVGEJdhibVujHcUlwXhB4BrjoVd4DEhqrY0emmtAr3ydwhXIMnJeqC8rPLrEhS5e3wW+gyvEuSMkGs9tHvHimIW+jMOcwflOZxUvEkvxge9ZgGvoOjGwdcL2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985554; c=relaxed/simple;
	bh=RT2LFTG/i/RD4wN8+3d1ANXBznpTPUnp0qt/I+XLpTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XiOairNAw7gV5Qh4wOppjqyrczfgBkV1HzYZhDDq+Y49qRFsPpUtkVfuL5rQzPfSCiOGLSfl3sB2hohK5CPmeMC6XRq6wjq1+KL7piZnL7TNqtjQOmjrqSnoLP+K5mSlh7RQ54EU5DOyc4slEhCw3ea/bKYftfQ+lijbMRpGQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2dFHSd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0091C4CEED;
	Tue,  8 Jul 2025 14:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985554;
	bh=RT2LFTG/i/RD4wN8+3d1ANXBznpTPUnp0qt/I+XLpTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S2dFHSd35gc9JPBf0Pk+WxxSndBWCVhdKKm/pWsTSYtvJw2kmIP05PiNUsuBPdSk4
	 hALCN9GokuTKh5RCwPmuacZOKCIpkUUEOcJpVr/6TJaTgbbZsJlGmhoI5btRPGdj/N
	 uTjGovxNMn2xGDswsKHbKosEFum0/4jCVlOu+VdIj+MbRHWO38/l1WN4I/pQVA0tFf
	 r7p92x3aF79lj8tcRle+9I6OV6ohazpv2BqHjzgTkvy4InvWKWPv0yX8eUD7fpvHk7
	 yx73IOoSqiVdPZCa2KtXJ7aUH7x8w5Sn0RHItj04AXpw1RUjA63W+OjAbMyzeWUO/v
	 4Lnw22iNbjUhw==
Message-ID: <243cd364-e1c3-4d4d-9ef4-32d5ddb58a03@kernel.org>
Date: Tue, 8 Jul 2025 16:39:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: auxiliary bus: fix OF node leak
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Leon Romanovsky <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org
References: <20250708084654.15145-1-johan@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250708084654.15145-1-johan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:46 AM, Johan Hovold wrote:
> Make sure to drop the OF node reference taken when creating an auxiliary
> device using auxiliary_device_create() when the device is later
> released.
> 
> Fixes: eaa0d30216c1 ("driver core: auxiliary bus: add device creation helpers")
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

