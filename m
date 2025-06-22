Return-Path: <linux-kernel+bounces-697057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BE0AE2F98
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jun 2025 13:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895F8188D252
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jun 2025 11:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB231DED47;
	Sun, 22 Jun 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+BnOYqP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF9194A6C;
	Sun, 22 Jun 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750592676; cv=none; b=QUgadU0BijB06azTiyfs7s7bpV7t1KiOsAVrGUolyQP61nt/UbHZhAnjZ1Qv1RgwHnyt9SwSjwE13YWMm9UvSmxvYaKcYQ+SHE65KwLg84UZKfNmGx5bpLMD3UeGKBijXOfdTXzyf6LlKExJQtjU10EmSI+JQDqlVEJjlWRdGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750592676; c=relaxed/simple;
	bh=j80wLurdzGwOT6cTP9Ha/itp20ejJ1waN+d0vzusoOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtYArBM2XxjXooi2pxyyaiIcl7sqY2+dKTgYiQlwcZtIrU57hTpxQm6npaEtAWsQfknxZ25osuQqIn6jGFzsMQavNo1C4bzh05T5DeP4tBQJkJk6zNS1zQgkve3SX3yA3O+8UqzZQsOH6/qwsyzEzQARowzf+sFAKfa0/OGoffk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+BnOYqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D48C4CEE3;
	Sun, 22 Jun 2025 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750592675;
	bh=j80wLurdzGwOT6cTP9Ha/itp20ejJ1waN+d0vzusoOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m+BnOYqPUqSizN50yEBuhdIGy8HhXdbkUVG8OSLDRRRCZH+aAne5CmiY1NuA0W5pO
	 hCIvqTS80oM+kqyvHKJUitLwJ7ZKzQObujOQBHGTfIneu3S5uNp4XcuYBiNBpA0V8/
	 wMVr7T8cyM+kb+DceV6YRssbHXMerdMfF7ya9jGrx+77e+aISWy5C5+nlZq8Y+jNEv
	 NW4DLsENgRSIH/BFtG8kEPEiLJWAOxapHof0BUShXHTBw4SFloIief2GColKZtolQ/
	 +XSI9Y3xDhWZQ1yWDE3AyVELEpBV5LENavnKdE9Ksd5RT51IXhGQiB0PJGat6E+XIb
	 TZdX4nDxxZOPg==
Date: Sun, 22 Jun 2025 12:44:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v3 1/3] iio: imu: bmi270: add channel for step counter
Message-ID: <20250622124426.60c71eb1@jic23-huawei>
In-Reply-To: <20250616-bmi270-events-v3-1-16e37588604f@gmail.com>
References: <20250616-bmi270-events-v3-0-16e37588604f@gmail.com>
	<20250616-bmi270-events-v3-1-16e37588604f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 20:53:09 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> Add a channel for enabling/disabling the step counter, reading the
> number of steps and resetting the counter.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>

Hi.

Given this is ready to go and independent of later patches:
Applied to the togreg branch of iio.git and pushed out as testing
for 0-day to take a poke at it and see what we missed.

Thanks,

Jonathan


