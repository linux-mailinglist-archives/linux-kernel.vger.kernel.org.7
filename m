Return-Path: <linux-kernel+bounces-875906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB161C1A165
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25D51AA4468
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE5A330337;
	Wed, 29 Oct 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b="RIWF8YjL"
Received: from mail.dwurp.de (mail.dwurp.de [185.183.156.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF2113FEE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.183.156.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761738030; cv=none; b=JVefaqRhFIYAnt8lUI02D9VP/B551mFRWZPgqFueuOJw5Ow6UkJ7LWKgKVLAVy8uyP+6xUnr85N0Zqm8wU2RsvGgyWPH1BUqSg4XAtDJOld7WEtj0Peo4obIuasjtzLgeo7TK84I0hv1nqvXK6nIY4fdg/kKzckfUk+uBdhTgks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761738030; c=relaxed/simple;
	bh=NADL9O7QZYjikNdqd/tNL7aiqcRd5E7uXw6TJiuHnDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4D37w/qfNWKMMQDv9oSz0bWjh4sEelXdqfZkEOp1ogMBKppkXkxj/C7UNGwrxYD8JzrBKEbV/t7gYa8ryJqTWb65YsjMobys3wVlJUlySw849EnpWHeAfWoV06Kj0iRQOla9yLe6P19Y7d9R/B25qeT5Sb9ebBAVsgbImbwo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de; spf=pass smtp.mailfrom=dwurp.de; dkim=pass (1024-bit key) header.d=dwurp.de header.i=@dwurp.de header.b=RIWF8YjL; arc=none smtp.client-ip=185.183.156.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dwurp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dwurp.de
Message-ID: <ffd5081c-2193-4ae2-9b2c-c32b276fe1d9@dwurp.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dwurp.de; s=mail;
	t=1761738025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TTyQI4Tts9+775CKf5cVmQAALYTRwiiX2bdCP1i30PM=;
	b=RIWF8YjLxwcXkhBKw+7pNZycLwm/ZZayfmE7J38UjnIz3a7T4yurK+pjTF3cy3whhqmnxp
	TI4VjKPAKk/CS+1NbZETT3NUZDcFk3MM7CRIcVPinbfJZD5fvLRCccFszWc1Zd+zCV23D5
	2IHO3pC2zWqUGvQ0qlkUoOZGeYGmkw4=
Date: Wed, 29 Oct 2025 12:40:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm/panel: kingdisplay-kd097d04: Disable EoTp
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251028214045.1944956-1-dev@dwurp.de>
 <aeee5f47ef2842fde66bc66fc598ee4f007fc1c2.camel@googlemail.com>
 <33e255dc-64f9-4e4f-82eb-6f5e9c1d63d4@dwurp.de>
 <5465f445fe9e230f1f37cbb22a97ff2b7c9c3d2e.camel@googlemail.com>
Content-Language: en-US, de-DE
From: Sebastian Fleer <dev@dwurp.de>
In-Reply-To: <5465f445fe9e230f1f37cbb22a97ff2b7c9c3d2e.camel@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 09:15, Christoph Fritz wrote:
> It's not a workaround, it's the actual fix.
> 
>> However, I'm in favor of keeping the "Fixes:" line since using bisect,
>> commit d97e71e44937 ("drm/bridge: synopsys: dw-mipi-dsi: enable EoTp by
>> default") is found as the first commit that shows distorted output for
>> that panel.
> Documentation states:
> 
>   || A Fixes: tag indicates that the patch fixes a bug in a previous
>   || commit
> 
> You are quoting the wrong commit in your Fixes: tag.

OK, now I got it. I'll send v2 with Fixes: 2a994cbed6b2 ("drm/panel: Add 
Kingdisplay KD097D04 panel driver").

Thank you for your guidance.

Best regards
Sebastian

