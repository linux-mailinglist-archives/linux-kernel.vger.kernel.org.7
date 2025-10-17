Return-Path: <linux-kernel+bounces-857280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD0BE666D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A685621FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EE630C63B;
	Fri, 17 Oct 2025 05:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKFEWJWG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB9821ABDC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760678325; cv=none; b=sfDvFJ6QP6/o3esZlzhh4Mo3e23XoK1T6wYb81UTk22Ht9kNzG7C32wVhWMdeaWoKvxbj/XGot0VEIZ3EpvtgUrUtX0cQFZQi9WOp963DI+0Ey1QjX9dD8YCgFSPyWmxPUq/umqHVej7EgMHbASf1wygu4BW6+j9pv91kjI/Hzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760678325; c=relaxed/simple;
	bh=qG5HMa66bXcs8gT8hnOihrhSdB9Nf9qJM+cXeN/bESE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBn2axnA6Jisvi7tuQD70j/nhX1hC6L/dilFS68pnullnb2Q6qEWX6Q7n01MYFgT57SEQhmZslrVLu6rutnqkWKTbuRHNjK6k9jDrcnWob2YhWBi4X/W2O4CaAfhbJmsunsEzfOq6wwg4TrJSkZNHsA50/cgKk+kOSOB5XFjQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKFEWJWG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f67ba775aso2177304b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760678323; x=1761283123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6S63uReOFquePjk+el+IDhyWrHQTPL8Zy49l1W17no=;
        b=TKFEWJWGDOlIxwdyfqDfy9J03up5ma5IKzn7zDGrD/KpnHIG+HICjR90wcpK3s/OSZ
         wG+vgWJSwlXhmk0RD2JmThXV/eTaiNnxSHw+dyfR/4V8ekLpTD7d8CDzi3+Yn9gS1hh/
         GrRSzUR6AWgK3OLjaKyQ4S83DvuycjpUx/gGl6tQZd7XAPnrls3mjS2EckLgfGQtC1/M
         wrk6YC48wd233iBH5Tu4cdJTm0lqWvvbvoCpGkiAYWjoaGmLoEdLYHHKum5aDMcBsa+g
         1jCtsM/DhBAJW2p/HBpCsCCGp9fWmUxyujojrogaPxTJX6/W631KL75F60OU4xCPU5Ec
         Ec3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760678323; x=1761283123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6S63uReOFquePjk+el+IDhyWrHQTPL8Zy49l1W17no=;
        b=CCqMll1KyA4rgX1DlYeeRDtu49dGjZ67ZlBqIXpepRZnuJfWSEBhxiF7oNkSFwYRML
         QPBlH06uDOtZlZPDaBEhz8yJyCApaIUwRf6XwgnQV2cnAfKIKBuHLuS1K1GtwNVwl9gz
         Yi3LklYPtk9fntd7p6mlcnQ0ZBLXeg3413/4yIWPBFvFb24xn4TX/zReEAEhpIehQJ0J
         566bKpvcArsNOVutnZpTaA8EjXKTxXYbkkr4BkMZqjUjY6H5ozBuDs5Zl287E62dacVW
         3JKRiBTirY0i2z/BWPjWq6DRs+wsGgQHVOwI6iFeWYzQzIHtUMNHS5AMILvQHDZw8o/+
         lufg==
X-Forwarded-Encrypted: i=1; AJvYcCUxpur4qUyzggq3ISXdG6iaY+kUwrzDIbTDB4yfddDMZ2Mnt0cBw3pR8UYv+3ErMwRisdRo9TR4NX5QG08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIBMkJ44DAmcXBxhplUnjOvQDF8CM+nwzCCPdfOm6qpN7WTKDm
	URtGUCJKYt4XC+lpViBnWbgXRN0QfBKvsjq3TGdlNpikDJhNNj7UNDcK
X-Gm-Gg: ASbGncvSkIhzeBWT6x2SrsuKPL/9NePfgmc5UbDsuSMdL21mUFPVg8hcZEaK57VWCUx
	uUdm+0TiBU3N//gi81pbVKLXERuF6tpXaxj4hOI0d1m3xGM1NUnycnaD/IArI7OvPTSRIPlM42v
	oTNSXpPeGZAws1mYARJS/4h/LG+1hSVqscz8rngsrguvl5X9vfbFmyBrZLfqXxVkcgNCMIbWknA
	koY5MLEZLaA1MrnnZF1/be9cWY6gpj8ChXSn/2bag1ZGF6v8xbCDNBm0TZ0sKXKhKkBRR/WzEva
	11SFD4xZstAKBs7SdztS00CD8AvDzaRnH0dFJfaABvxeccT2lL22HJKac/BR1Qqme7LwZYMPCtA
	38hk/YaCyJxNU3Xsa+sHAP2h1hiwfbFRHe5hQp0Vd82gElYE6JFF7j1caRQj/PQwjbdQbz4mdzP
	GDY0VE1vPSvSZUQ2ez9Ru1DcMfpaEw5/kCMjDUI7gFSxbmla7XKsQ=
X-Google-Smtp-Source: AGHT+IEoZYavaM7njBnG3D3Z+hduFKNotyz+5aU6kPX8BleR1uI1Sy5GSDkuztm0nYl05g784spRlg==
X-Received: by 2002:a05:6a20:9185:b0:32d:b946:dd20 with SMTP id adf61e73a8af0-334a8566437mr3249260637.24.1760678322944;
        Thu, 16 Oct 2025 22:18:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:df8a:9eba:d1a8:6b39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d993853sm24177361b3a.74.2025.10.16.22.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 22:18:42 -0700 (PDT)
Date: Thu, 16 Oct 2025 22:18:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Leon Luo <leonl@leopardimaging.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, Jacopo Mondi <jacopo+renesas@jmondi.org>, 
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Julien Massot <julien.massot@collabora.com>, 
	Jacopo Mondi <jacopo@jmondi.org>, Daniel Scally <djrscally@gmail.com>, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>, 
	Tianshu Qiu <tian.shu.qiu@intel.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rui Miguel Silva <rmfrfs@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Martin Kepplinger <martink@posteo.de>, 
	Purism Kernel Team <kernel@puri.sm>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Dafna Hirschfeld <dafna@fastmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Yemike Abhilash Chandra <y-abhilashchandra@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, imx@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 01/32] Input: cyttsp5 - Use %pe format specifier
Message-ID: <xirb6664gow5ldjy7xihkz2wooidbm4bsyl7qrm2uosdybdki7@mqkdqzeznx6h>
References: <20251013-ptr_err-v1-0-2c5efbd82952@chromium.org>
 <20251013-ptr_err-v1-1-2c5efbd82952@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-ptr_err-v1-1-2c5efbd82952@chromium.org>

On Mon, Oct 13, 2025 at 02:14:41PM +0000, Ricardo Ribalda wrote:
> The %pe format specifier is designed to print error pointers. It prints
> a symbolic error name (eg. -EINVAL) and it makes the code simpler by
> omitting PTR_ERR()
> 
> This patch fixes this cocci report:
> ./cyttsp5.c:927:3-10: WARNING: Consider using %pe to print PTR_ERR()
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Applied, thank you.

-- 
Dmitry

