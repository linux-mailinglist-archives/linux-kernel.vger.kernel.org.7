Return-Path: <linux-kernel+bounces-817922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC381B588A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD19177C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F92DCBF7;
	Mon, 15 Sep 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7y3POZQ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F32AE7F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980417; cv=none; b=FsDohXcP2E41jzjQyIvirMOItzkHeTIT86UxYPOm1Tg0bzk/oNTRh+uTLtrlJoTPBU523cDJpbVgLR3JoKNg8UR6IyxF8mQfqKjpnyvqhVnUzRFnPSv1nqymtfFEXJxphkpBBvEQDnWuxcjv2GD2UFhDZhD0znbHs9cgqtr+IEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980417; c=relaxed/simple;
	bh=Xk1ngxkS5zRj3gU0t0gxFp8yUi5KZTETEFQeV3IwLsM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mo12a55c0cnA19zPyXLAB3a7OJc1zPNE+ANuOjvrdfVKSLzOtelD4z8qZh3Uhg8xyAmZeo0KG4WMT+QL5oWE04uPCqMhshNMlF0y139+yqV5Ax5M0jC9bHN7T0wldi5oGxcHc8qSZHMKQlwd/eVyRs+m9v/L8P1tonmEY9OCReY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7y3POZQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so19496895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757980414; x=1758585214; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BmfG0W1IgkOwpfZLkT8EPqhqG/KPrr8NPJycy9t8jkY=;
        b=I7y3POZQAZUXa6pzctMvGfeKcyYv84iYeqG9hfPsvAgzv62AyIiNUTw8t9SDQeFjBM
         30pwsS+0/ojqgEsDiqRrlvU7hAzPTPaPrnWo/BjmPOJqkrLcM58844mSIHtGTyosQ2Cm
         MW09QjXI8AEyHxKeWwm7p+FoNNBQ9/+rfDYRIo6ntcgN9/cnQAY7iTuoVNMlA0Qi6njc
         50BWnRqFyXckcr3t0KG1BdgEVP1XX/UvOvElEdvcuggbc9//dStDAiUmyiFUt/jrbibr
         QJMQ2irEhgN4r2BIuOSmfywdTtyCWHiUVcoMzj+oEEYCG39IDqFnIJkQw4XugPzVQKRf
         YB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757980414; x=1758585214;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmfG0W1IgkOwpfZLkT8EPqhqG/KPrr8NPJycy9t8jkY=;
        b=VpROKysoonaFXsdwill+/iOGrHMCDQ7Q6/xQtockxGSFw4P1rH3kP6o/MVVWi6DL/c
         1CTadIr0yZ+C6xWdRhdA8MZM0lFURmrTbERhrVWB6iWN+AB2uJocyR+cmpqeRyVI5xtq
         tDufd77iK+wLooZRp9dwJE4wAK1wUP7DlaD6UhqpfnyMsPeuZx4iG6xFnPC4Ho85HKXD
         og9nHmARVRvmTyvG1M8pJ7aI6zKtOqbu+iCvYBJcu5mOelAri+DWWhaFwFox2wKTu/UL
         07Y0HyD66Scxtd287BXFPQSHT3glBCHTEuTMlxsTQvyYzgzjB6DHUlWpuYSfqJ9c/T9D
         wKGg==
X-Forwarded-Encrypted: i=1; AJvYcCWeEbA3znWK+wMfMmGqO6kI7tstDCOkFNzc+GWWDlVz8y0+L78G8/XJ8fXsv+w5cR7FduH/OqQpbJYvkgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9IiFth0TZwVS7qzgB3g3rWWZqy3qM6dMfpUm9RKgY1ytXtwIJ
	IZ1dgIf28klU2QPSPMXN+HBLxDiXOsBVrufuAYAhCCDP65YUDdBOZzRL
X-Gm-Gg: ASbGncsV6jOnpFYbPQtHvMN+H9vYyzuDVyyCHDpqw2QX569XXOwv6kLaQcykroImMNb
	wkHz0DX7s9zdOlmhmb9VNCJ3v93zmv/x/I2ZpvoEjjq1klZh1t4JTYoID9JbM8wPNMuOssIdHTz
	afOtXr/V2j9awx4ALjUwvAEQ8GjEtN3Q8OcNXNm2SVvCwEBC8Oq+6QecvyEqvRHywLx/sClQc8Q
	fbIth6XSryYp7loE5S+2rrm+/bG94SHP3U87dE0ikyXPQtPMrlENe6//xqqzbbY+uHkiE6QqJ4C
	2/2A1s4yOxAZcjK7Wr37Pq6RjKlxzNz38CLFHRkCuIvi9f7At1Xc1hEJ6Ed5RDemp0iLheerA0+
	8/K0uMcHTu6sLajbWENuTCSIOdbsXxnVFBOrF1UXitDDMM8rk6qvKZBvVchoVHIDqN70DwA==
X-Google-Smtp-Source: AGHT+IHLVAgIWoi+HRjIu3glVhna2GE9VgX3EjwtlAMYebMBvwok+xVV62qMLLci45mipK73hQudIA==
X-Received: by 2002:a05:600c:4f83:b0:458:bf0a:6061 with SMTP id 5b1f17b1804b1-45f211f87c8mr150676285e9.24.1757980413716;
        Mon, 15 Sep 2025 16:53:33 -0700 (PDT)
Received: from Ansuel-XPS. (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f28c193f9sm118455135e9.2.2025.09.15.16.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 16:53:33 -0700 (PDT)
Message-ID: <68c8a6fd.050a0220.26bdf7.871a@mx.google.com>
X-Google-Original-Message-ID: <aMim97cvziXHysYI@Ansuel-XPS.>
Date: Tue, 16 Sep 2025 01:53:27 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	DENG Qingfang <dqfext@gmail.com>, Lee Jones <lee@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [net-next PATCH v18 3/8] dt-bindings: mfd: Document support for
 Airoha AN8855 Switch SoC
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-4-ansuelsmth@gmail.com>
 <175795551518.2905345.11331954231627495466.robh@kernel.org>
 <20250915201938.GA3326233-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915201938.GA3326233-robh@kernel.org>

On Mon, Sep 15, 2025 at 03:19:38PM -0500, Rob Herring wrote:
> On Mon, Sep 15, 2025 at 12:01:47PM -0500, Rob Herring (Arm) wrote:
> > 
> > On Mon, 15 Sep 2025 12:45:39 +0200, Christian Marangi wrote:
> > > Document support for Airoha AN8855 Switch SoC. This SoC expose various
> > > peripherals like an Ethernet Switch, a NVMEM provider and Ethernet PHYs.
> > > 
> > > It does also support i2c and timers but those are not currently
> > > supported/used.
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  .../bindings/mfd/airoha,an8855.yaml           | 173 ++++++++++++++++++
> > >  1 file changed, 173 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.yaml:
> > 	Error in referenced schema matching $id: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml
> > 	Tried these paths (check schema $id if path is wrong):
> > 	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
> > 	/usr/local/lib/python3.13/dist-packages/dtschema/schemas/nvmem/airoha,an8855-efuse.yaml
> > 
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: soc@1 (airoha,an8855): efuse: {'compatible': ['airoha,an8855-efuse'], '#nvmem-cell-cells': 0, 'nvmem-layout': {'compatible': ['fixed-layout'], '#address-cells': 1, '#size-cells': 1, 'shift-sel-port0-tx-a@c': {'reg': [[12, 4]], 'phandle': 3}, 'shift-sel-port0-tx-b@10': {'reg': [[16, 4]], 'phandle': 4}, 'shift-sel-port0-tx-c@14': {'reg': [[20, 4]], 'phandle': 5}, 'shift-sel-port0-tx-d@18': {'reg': [[24, 4]], 'phandle': 6}, 'shift-sel-port1-tx-a@1c': {'reg': [[28, 4]], 'phandle': 7}, 'shift-sel-port1-tx-b@20': {'reg': [[32, 4]], 'phandle': 8}, 'shift-sel-port1-tx-c@24': {'reg': [[36, 4]], 'phandle': 9}, 'shift-sel-port1-tx-d@28': {'reg': [[40, 4]], 'phandle': 10}}} should not be valid under {'description': "Can't find referenced schema: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml#"}
> > 	from schema $id: http://devicetree.org/schemas/mfd/airoha,an8855.yaml#
> > Documentation/devicetree/bindings/mfd/airoha,an8855.example.dtb: /example-0/mdio/soc@1/efuse: failed to match any schema with compatible: ['airoha,an8855-efuse']
> 
> Why are we on v18 and still getting errors? I only review patches 
> without errors.

Hi Rob,

the problem is that the MFD driver and the schema patch subset of this
series has been picked separately and are now in linux-next.

I tried to make the bot happy by using base-commit but it doesn't seem
to work. Any hint for this? 

The errors comes from the missing efuse schema.

-- 
	Ansuel

