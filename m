Return-Path: <linux-kernel+bounces-820438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5356BB7E0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694D3481113
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FB72F9DA7;
	Wed, 17 Sep 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUhpTyNX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7AD343202
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103881; cv=none; b=h/OouVgbC2hb2iheCex1uqz/mjrlP4R/8th7052ql+hrfMKOiREnnBnfnt0b7fkzq/XBAUTmO1eqAVRcnUNI5+1KCiC5sopljOwmiGD9lMCc2oJS9fongFXTQk61aQBpCbTj7/WYL8lNRYiMb5ffgxGAxKvJaffpE/tUzr9XDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103881; c=relaxed/simple;
	bh=4ga+azf3in2hBznJTvkA4X779mL4ML+24lGMfj0nOIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHyHU+PDq0lX6sCct8qAkEWH0SSP6YrVJWNg9L1Qhvqw/5by43gHVCYb3BdTnRvPS5Bw66bNZXE4m5zGD7u+LUPclJLCGS83bcE4NqulLtLZ6dCoQtko1Br+bcbALIf68p7PjmTbE8Q5p8Bcqy2XhGg6rHfOEz1F2Xso6kiEW2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUhpTyNX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dec4289f0so3481825e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103878; x=1758708678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFlgCXptLNgS0oUFv7P/jnH+n8Ia5ZxafQyZ/H5sxnA=;
        b=MUhpTyNX/GINaDZeI389tgHDDW8Iot5T8E8vryV5EYWiBHdMXKiKz4ErdSibSbOtv0
         b5nTyXNQfKyGEXzqNiQhyE81tnq+Bf6uoScQZ4si8+8wGtqi5Um9Oji8OlnjqeoBQT/l
         k0HV1W88o8UHmcbXHyEfkyNwD8dS5eucgA2UPWtC1VxxM5r/ezoin+p4NN+KbMQkwt0m
         +H3asFVkENIYAM/fQikTZ8ughU2pumIMXMfA98ROCJvNQNisnhsxa7luxfKcHuZN8p/I
         ItnHtdeRqdbFYAY6dqkZSeHoMsdgKT1APsgH2umX3P2r8ym9wMjZ8dkxKd7pyhIQyPnb
         l9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103878; x=1758708678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFlgCXptLNgS0oUFv7P/jnH+n8Ia5ZxafQyZ/H5sxnA=;
        b=raeQ4WHB/wDR5YWGwplje47Z4Vu3eF4UmlP+YKgPEiB1n3DnFmZWeBFDdPlro/RTps
         A4M+WHkUG2HFKVP9P77n0VRc7zTA1E1TWtY0CLHG5g5o9SvLVLweVmS/FIBbaQPqqSfo
         1nFi2gudoXhBrFixUwKBCaDMKgQyg/0FdMiOjVlB50O+CqKzFrGkD7z7i/PqqBnb9o3S
         6hObq24gqGEfb8Uv2o5UwnlloUtUWoKi9Ctf487xOFy70iXBLQ/LrQUs0dDqFIpI6Gs2
         0NUC3q39d7kp8tOd/m7/zy+/jw8VZJZki+3lBdIhV0lKVnhO4CIRQkBUR0seYsghTRAc
         9K8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvWoEMWAxQwhSakiwbFd+khjYMhsrEmBMjFvO08Yz8Sdgym5lBAOp3f0BBH9EOZAxz4esOEY93E9lR7Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovNgrHg8BkH6AK+Me0xyNMadY6SHtYk1VfOv1p84DY6Dufnjt
	kyl00RhOLWsSeFyXVY4JlnsGZ0ncx8AWdILFLhF0joakRNh/MyvN8sRa
X-Gm-Gg: ASbGncs1taa/Qrkw+Bo1O+vR67otqPxmbDBR6rG9nPTos9sgBBYeEmxvDM9gqNZ2PO2
	rET5Tz/BTR4QklH/fep3QePu+IV1LEn9mQuzdQBMbZGxVXJ1RCgFqYm7kY465BaAwelVHGpVbm1
	jBQsqdilxcYrbXpkfK/8J2AalCqg14bIKzhxWOc5nkTVXPwZej4sBT3xkM/u/KGkhKNtH0+goQq
	qRILT2mPEuBoCM5eWBB/AMVyztvfi3526uXBgMlBQ/kBFDGIJmPDsDv9Zbl9C9q2EvVpITCa7eh
	pC3jn5VGDCx6LTqkpyrG5VuJ/icTEQF6TILHHpa74VJ03DI9EqgwgFxFyOZk7Q0Arkcu23Y2wsi
	LhC3oTr3YniziI4o=
X-Google-Smtp-Source: AGHT+IEGAWHbOGCVA8E1ghCrTfok0wf8HrSSu83uqpK5rtG+yvptJ+uZiWuJFaorxUfrNpWZkT3p1g==
X-Received: by 2002:a05:6000:400e:b0:3e9:e2cf:cda2 with SMTP id ffacd0b85a97d-3ecdfa5ad4fmr599670f8f.8.1758103878166;
        Wed, 17 Sep 2025 03:11:18 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ece0fba34dsm1092120f8f.9.2025.09.17.03.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:11:15 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:11:12 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v18 6/8] mfd: an8855: Add support for Airoha
 AN8855 Switch MFD
Message-ID: <20250917101112.555jzhzlmpkhgmh5@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-7-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915104545.1742-7-ansuelsmth@gmail.com>

On Mon, Sep 15, 2025 at 12:45:42PM +0200, Christian Marangi wrote:
> +static int an855_regmap_phy_reset_page(struct an8855_core_priv *priv,
> +				       int phy) __must_hold(&priv->bus->mdio_lock)

s/an855/an8855/ throughout this file.

