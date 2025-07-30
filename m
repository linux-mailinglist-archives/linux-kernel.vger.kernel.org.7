Return-Path: <linux-kernel+bounces-750038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804A6B1562D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB2D3BAAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCED5383;
	Wed, 30 Jul 2025 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HGll/GeG"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D443D69
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753834332; cv=none; b=pBNg8BYrIlOkwXEAPsKWAr0sDc8eZWo0ZqjskAbetyImGnS+nKVqJtR12fpLHTiwXKMV467P08udNEvTqHzowItdSSk05r+xCH89Nf+bevbyJgsiYJY/HBQAtrCFtANsAylDtVapkP1hjmOPhsHOQkSXUQ9YvxmerLsFYvCAXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753834332; c=relaxed/simple;
	bh=McVfknRJO2ItiJDLP9bbLxmtf27dEobQ2ayXeG0XqE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8ZBY8JAH8fS4uohEoXL19dW6fj8MrYr2utmr1XBeMsDr9HaySGssAIeEcS+fzMHBi2khTKoGDxQHbAi55TUwPammm/lMOM7F0JQVkqv/9ndZ/y6OOQ3xcr20lmpiv2mphoNooocdDfkfDdFWYag1u4m0ouaRpe+jMB5mhljBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HGll/GeG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=VHtT7vYpAl0lXNyBpc02c8qfqUA/glzlTg9Rb6wRbOM=; b=HGll/GeGKmKJ/heVTz0EYE+QVD
	jaO165xDGFk9l9BI9qk9ESpd9tg+6DdUV/ROANA02aVp/1fx8ta3sFvgEOlBRjwS4Rn8ystIKQgQd
	WtRwnkAj/qh4gnql6G1ec1YbYzzekqJLb0gH4dKfDgVx5doQpiuocKV3oprSXDhhUfwg7DimgBfDx
	XFXQoilZwRIDrd/aPX7vWqM/jgm5p+6zAiACGicMp6Iy/cEN5jHs3wFQ15Tgi8+YEa5e+nGQCjsqW
	N5VI0Dky5hx1E54l9Waixtu3pcHqox3y4JORQ4q90GGjC2KHyn4mp/cE+amWNWMZo4dR9hlQnKh8Q
	IbshnhCA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uguQP-00000000MOZ-1Kjd;
	Wed, 30 Jul 2025 00:12:05 +0000
Message-ID: <06e91cc6-ee85-4a90-b9e1-3d688b69c0e0@infradead.org>
Date: Tue, 29 Jul 2025 17:12:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i3c: fix module_i3c_i2c_driver() with I3C=n
To: Arnd Bergmann <arnd@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Guenter Roeck <linux@roeck-us.net>, Boris Brezillon <bbrezillon@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frank Li <Frank.Li@nxp.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250725090609.2456262-1-arnd@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250725090609.2456262-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/25 2:06 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_I3C is disabled and the i3c_i2c_driver_register() happens
> to not be inlined, any driver calling it still references the i3c_driver
> instance, which then causes a link failure:
> 
> x86_64-linux-ld: drivers/hwmon/lm75.o: in function `lm75_i3c_reg_read':
> lm75.c:(.text+0xc61): undefined reference to `i3cdev_to_dev'
> x86_64-linux-ld: lm75.c:(.text+0xd25): undefined reference to `i3c_device_do_priv_xfers'
> x86_64-linux-ld: lm75.c:(.text+0xdd8): undefined reference to `i3c_device_do_priv_xfers'
> 
> This issue was part of the original i3c code, but only now caused problems
> when i3c support got added to lm75.
> 
> Change the 'inline' annotations in the header to '__always_inline' to
> ensure that the dead-code-elimination pass in the compiler can optimize
> it out as intended.
> 
> Fixes: 6071d10413ff ("hwmon: (lm75) add I3C support for P3T1755")
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/linux/i3c/device.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index b674f64d0822..7f136de4b73e 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -245,7 +245,7 @@ void i3c_driver_unregister(struct i3c_driver *drv);
>   *
>   * Return: 0 if both registrations succeeds, a negative error code otherwise.
>   */
> -static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
> +static __always_inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
>  					  struct i2c_driver *i2cdrv)
>  {
>  	int ret;
> @@ -270,7 +270,7 @@ static inline int i3c_i2c_driver_register(struct i3c_driver *i3cdrv,
>   * Note that when CONFIG_I3C is not enabled, this function only unregisters the
>   * @i2cdrv.
>   */
> -static inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
> +static __always_inline void i3c_i2c_driver_unregister(struct i3c_driver *i3cdrv,
>  					     struct i2c_driver *i2cdrv)
>  {
>  	if (IS_ENABLED(CONFIG_I3C))

