Return-Path: <linux-kernel+bounces-807307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D9DB4A2D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578D61893888
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2890305061;
	Tue,  9 Sep 2025 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6NXU3u3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDF4502F;
	Tue,  9 Sep 2025 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757401338; cv=none; b=al5k4sHg5psfPKExQPTzP7jDfJ3+E4QcyLkLSliMum/CdyZRSec70KPrvlm0tQ90/pus/z3hCImqYSN/L2tH2Rrmk8acrxCcCjxBoecv39MZpGgWSJoYG1z1Z5iQTMBs/5wY4xbk6p3CTGnkqMO5O5NOf6RO9d1wzmvKmABxxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757401338; c=relaxed/simple;
	bh=5QP+87wCopFmi0E8qS5WVGvTBLtWeZR97Fut0wLf0VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHAmsGNUgp70ntw2Lj4lDy6MwmgaOaNG+3HlPC75W1tMABUd44uVF/5iU46fPhx5NbBde5pi11RJb/s2pU5ySHYLWDor/E2xu1ZQ5oGjAya0h8/1+9pydqBzOFfumIQOfq9th/MaFHQiRt029FgfnhkuuEb7ti22GebD02RgXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6NXU3u3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F22C4CEF4;
	Tue,  9 Sep 2025 07:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757401335;
	bh=5QP+87wCopFmi0E8qS5WVGvTBLtWeZR97Fut0wLf0VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6NXU3u3bDBoEcCuRhjhzVFkrrFif0wJgPsLshHAPw0LB2HNqMlM35Tk6c6xnJraW
	 JKmUwh6EAMYpXBfFSQIJFil7fbYpU7oFhDUkQ5H6/YSpSybTyH/epUwpHg5T29XoWL
	 x2w+D05QCW5QmcDEZnrjXjd18Scb7gtZ1S8QSDz408SQ310qS+icV9LuqGtfFQlyjs
	 o0zRJNtqri98uOd8cCD2mc+O79cFHeRcHOp8wWTjBTydKJI8aFi4gkoxhjcHjtbRyX
	 4TgelTKJ7H5vn2aosyGDVIE0QPLmJ9BOvW8z22KI2ZVD3IXyjM3951eoIblsTzVOT2
	 31m9JvB6wPkTA==
Date: Tue, 9 Sep 2025 09:02:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
	Jonathan Corbet <corbet@lwn.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: trivial-devices: Add sht2x sensors
Message-ID: <20250909-bulky-mottled-perch-b62334@kuoka>
References: <20250908-sht2x-v4-0-bc15f68af7de@gmail.com>
 <20250908-sht2x-v4-3-bc15f68af7de@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250908-sht2x-v4-3-bc15f68af7de@gmail.com>

On Mon, Sep 08, 2025 at 10:54:51AM -0500, Kurt Borja wrote:
> Add sensirion,sht2x trivial sensors.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


