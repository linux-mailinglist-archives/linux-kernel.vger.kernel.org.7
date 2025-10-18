Return-Path: <linux-kernel+bounces-859422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3B6BEDA17
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 21:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A133B7FE4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5A4313E1A;
	Sat, 18 Oct 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbBovDuB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321102E6CA8;
	Sat, 18 Oct 2025 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760815073; cv=none; b=B3hXHxrDgOEivNsbGquSp4C6/gw5kO2IF1yiSv1TFXsZqqvfSRsVBpaH+rHHkWH+AqlvxfcOoPrb38D2NebGitZdaDaQU/wNXjV/WSbsCkkogp4S10uZYaB1OZfpp4u8nRsPoL2rDf3vJTGfehhlSzbo8YbtUktba3BYQcV77r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760815073; c=relaxed/simple;
	bh=sv8yWCj5BUbkyc6t783Zp1N7rvNjPAR9Xx6VfPJjVs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9YjdJEGo8WsAb08VvWdc03tosCVxnJVywXln9TI5g6CcEOllgpnd1qJFZBFuqiRHjLHLFaGNYNVTTFw1s3ZnQlCT9Wy9JofgyG2tw5NkgNBTTGuIOpHwX08LL/5CWHOo3oStKkQ7k+S6HVYyJQlciH8rly8UYq06KNopefHXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbBovDuB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED911C4CEF8;
	Sat, 18 Oct 2025 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760815072;
	bh=sv8yWCj5BUbkyc6t783Zp1N7rvNjPAR9Xx6VfPJjVs0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UbBovDuBpwmgUxmIW94gA6tKYenxIKnm99DEL0+7IFkVt/PxDzFoVuhDB59zod0F4
	 kkW7hgzb/NW69GDOwz/Afhuu2aQIvgXXsLgPG3kkYcbxjdEOM805tnVyRaXvT6+k2u
	 yHCwD5uTz4TXrTiTfn8E2OKG5rN+mUnFnd8VEbmmXKG73ouS2JlaSd8YI/D3Z9Lx2x
	 WR5TkuIYmecxUrFDHTZKtnAKXXe2DBkTv5qP3d5FEGGT5EZUruDRSpvueqigsfq0CM
	 3RSB1qzdQP9WsOepIh0kefBpaoGE4upIQhnt0UQo1bGnIkrPUylUYsUFsp8xr3TeUj
	 JAc0vPnHe1OEA==
Date: Sat, 18 Oct 2025 20:17:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: fix array size for
 st_lsm6dsx_settings fields
Message-ID: <20251018201747.3493415e@jic23-huawei>
In-Reply-To: <aPNe89G5mNxhMEbo@lore-desk>
References: <20251017173208.1261990-1-flavra@baylibre.com>
	<aPNe89G5mNxhMEbo@lore-desk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 11:33:39 +0200
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> > The `decimator` and `batch` fields of struct st_lsm6dsx_settings
> > are arrays indexed by sensor type, not by sensor hardware
> > identifier; moreover, the `batch` field is only used for the
> > accelerometer and gyroscope.
> > Change the array size for `decimator` from ST_LSM6DSX_MAX_ID to
> > ST_LSM6DSX_ID_MAX, and change the array size for `batch` from
> > ST_LSM6DSX_MAX_ID to 2; move the enum st_lsm6dsx_sensor_id
> > definition so that the ST_LSM6DSX_ID_MAX value is usable within
> > the struct st_lsm6dsx_settings definition.
> > 
> > Fixes: 801a6e0af0c6c ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>  
> 
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.

thanks,

Jonathan

