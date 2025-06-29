Return-Path: <linux-kernel+bounces-708328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21280AECEF7
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 19:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A03A170E4B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jun 2025 17:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A7D220F24;
	Sun, 29 Jun 2025 17:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHvBCWvl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3775661;
	Sun, 29 Jun 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217444; cv=none; b=lfYU1oQenuFbawXFTwL46UObQzkpVzTtHEXVykjJqJevQx5MP1mduT/qxUj35fLCJ2EY2Gptc3nvvz/lPQPJypsn0z/+rCICI9xhn/lI6TpBHKTXdJ1c98wC9k5oLpmZJ/qDoU90Dvffarl85ttu9BR1A/8E7VwgljuWZ1R6obs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217444; c=relaxed/simple;
	bh=2KpVKvp15Asz1rfOZ5duGbv+n7ae5E8SZXZ6SCPlp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8LQhd3Jvwju6eu5+1ObhLtHk6tHcUi2Zj/UwGMENZvp/B9hp1iDuD8gBMaWVafO3jBISp4bvcP3KoROCPYbehnYAcqwsP0bHddnmMbzSYTpomo/alMHo6HcS1d/y3gY0naIw6VPXmYaDgGPVOrczMJEbnrQM70kZqTk82OpSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHvBCWvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A2EC4CEEB;
	Sun, 29 Jun 2025 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751217443;
	bh=2KpVKvp15Asz1rfOZ5duGbv+n7ae5E8SZXZ6SCPlp8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHvBCWvlN8kdRCR3RW+mDpsaHvOAeFoU1lDKaiS4zGljjdCHkjUX5ue4Bt1bL6bU9
	 Cofi+8gJkvrdaWx5t4KtTbdHXgdJHK1igcNpQP2ucGNzXIdUpOyu0GlWT6cv06WQPY
	 img+YrkF2up5XJiXF57tXedcaNcwTiKS3vPv70lFAf4BWr08iIR3r8f3Wq6bUOKv29
	 2lELzOubMw3l+fZExBWmkrNnDtToB23NIAawfmO/LZ94AigRMTT46Q/POfJEMMZjJ/
	 8pT+ppb8x1/jnMle7FwWpDQa0fCdmEHkVstCT6i+NtPyaSGs+6VI30BnsjZ6A7R5Nz
	 zxUJBiw+LIHaQ==
Date: Sun, 29 Jun 2025 18:17:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl76682: make isl76682_range_table const
Message-ID: <20250629181719.40b49236@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-21-v1-1-2597d8eda30f@baylibre.com>
References: <20250628-iio-const-data-21-v1-1-2597d8eda30f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:54:37 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct isl76682_range isl76682_range_table[].
> This is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan

