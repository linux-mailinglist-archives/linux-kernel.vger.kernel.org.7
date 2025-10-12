Return-Path: <linux-kernel+bounces-849502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5C6BD047E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3469189624B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5761B291C33;
	Sun, 12 Oct 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GihO+3/b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6931624C5;
	Sun, 12 Oct 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760281475; cv=none; b=f2kOzM00ICvu7rp/g+puacMpkyahF/Pb3Xi4VgHD8vq2ZJezTSt5bEdTxmkI181EpaNzzoryCQoIuBGkv8sMT0h2yxRtl0fvYhZNVm18wdHdQ5IJ4ZNLCFoiqaTjbGgYhVECkOogYltGlrzT9jAK9hVn/M1iKk+jfxgkDilP9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760281475; c=relaxed/simple;
	bh=yWi+Av/mtqcCuT0I83pa3hFneRlzj2SERr/oluo7i6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MA4RnkESzfadwYPA2RIiuUEKzoQ3FOUl/DhALuC5bqNdirGBQ0Q/MTeSSbLg0Ya67qCn0ZJGXXvhei7aC6va+KKZz93XCv2LpbtcZQacwcPnc+9IUVcG6pOsk4nAFm3182pQ34+pMKf5eME1XrMfz95hURZ0Fo1HMwtKYJKDPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GihO+3/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB3AC4CEE7;
	Sun, 12 Oct 2025 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760281475;
	bh=yWi+Av/mtqcCuT0I83pa3hFneRlzj2SERr/oluo7i6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GihO+3/bViBIoxC3Ulc6V/swXbFINQ1yQtZRNYYqciosKUZIkRth4b11BFBUIXMRb
	 nmDa6uS9S3bWIbl3XhaRfvYuOEBQE0TmT8P3eDh1S23Q58qsk+crbrj6OlsruoNWZD
	 oAxS+VHU58HCGS+/6OA/59diPFIkiPvEBxt0/wDIZz0bG1mPOY4cwsZcUWZctkoQQa
	 3qjfNV28bfzY088tMBjAGWWVYtz+NQxqYZ4LwfS94GvakIeAwFJVQKOKfea7v6KqHR
	 Bc893u8dl+BpeYuI3dJqVfSY629Us0/OmWXJHwaNe+bDlk5xy0uhY0Dtl/BM33m6jQ
	 hfPuh9fRmWXYw==
Date: Sun, 12 Oct 2025 16:04:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/19] iio: accel: bma220: migrate to regmap API
Message-ID: <20251012160428.4f6b95e7@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-11-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-11-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:20 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Switch to regmap API.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
This took a bit of hand applying due to my messing around
with headers in earlier patches. Please check I didn't mess it up!

Applied.

Thanks,

Jonathan

