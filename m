Return-Path: <linux-kernel+bounces-820421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6FAB7D9E3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068111895D02
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3702DA769;
	Wed, 17 Sep 2025 10:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NruRNwfp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA8285073
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103441; cv=none; b=R6nYxkNh+1uIWaNYp0IxTZTVMjF/PCG3XqYm0U2LxRWWep8WykWdId7ULtm1iR6YdLG+XVw0fSekkPTrfSfCRn1pYdiS84n6fkmq6p0Ju64y8XyOVmfBxZ7p2OyLrGL3pYIwQuC7K86SGGnNrgXda23XH5PeAcHjVF3tO5kZ21g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103441; c=relaxed/simple;
	bh=5ile7pgqPwBmGy9ty2MAkiU16i/ko03ARvZkVY1tBxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVNVecKcgzzwTtf7cu3It51hHJXvII+UfT7n3HRxOcfTU++QhxvEZBlpdKjxuZnWjTdXwQh6F/p3pWXf4+sze5g4vT3UnTFeGYnJE0AgMJc2uzUSPzPkre+ya+Pa3+HeCPNSDgdWltkGNYPSU+e4ImF3M7gj8tcSWcfplI72mTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NruRNwfp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45f2f9f1641so4271025e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103438; x=1758708238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gRrOX+lH79lbk3CMWLiPCWajedhgVBao1TTFuyFRYcw=;
        b=NruRNwfp8G5PddFWtMxn4HCVX58AOfwbGqCS8xwZeIBkv3/s557HOncDlIZ5xAjw+S
         W+MXT2isv1uExwyATSJGrKw9jBU/hLWQ9JsT8wfrDaZJVhu7CEej6HN1NoYDHbZZG9fQ
         hww4s5v2Au+dtbjdHKEiJjc6H5r9C6KBuwzMCHn02cKak2EyLZiH6dbpsQEv2YVo8mst
         /Nc9KBPcWgl8sVNa7fuhN7b5m0BVOLo20uqx46GRgc7KJnLuASy04FFiaQorKI3QC9mo
         hJaqbGUy/y+v9nIdkabh3LF6bY+GnHQmeVg6fYcp66k+mf0S9YVb0unb/KZJa5BPuLPd
         XZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103438; x=1758708238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRrOX+lH79lbk3CMWLiPCWajedhgVBao1TTFuyFRYcw=;
        b=tGIdFVsP6AdHmPXO8hhS9zMJiRjCiw84v5qJhtk7l0MZMDo6QNkM/wulRknt2BYwpr
         l/X6O/SE5xp8e3xTnIF26g6+lbM917qXsoHh49NQ6b0L50OIgzlNuaA9aXQ9XciQXgmB
         iB3uVP2PcKQdmPflZ3DJ9/ivm2iMqO6QRDDYNDi5YB/QQr5kbv60ixwqjzbDJ7Ra4qzd
         Y8VF54q1w2Gwf7WwXK5JLCUKEHTIv6IS8nc3HsylYIl37DMhC18OP6cMjQuiA/82IweH
         WZ+znsGJlvrJMKGtDI4Eb8apj/PSm6zAuYgGBnhpckAt9WWcbK7i+4KJMnxVi3KYpTjE
         Q+cw==
X-Forwarded-Encrypted: i=1; AJvYcCWfsds6P/1NPlYv7cGeJpSBBJtUPCUUQ0jZvJi+nQdh6u5eQ72hkT0SRge0ehkvxbnnB5NPPG09IyGAy/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXGYXSAhe7sFCi6bV0vImXh/WGSVSF00os8CcN8+Dv9QRiSkR
	kCgzl+ArGLAo13IMalgNUPslWlvSdUHgjpffcAq77kvfkkIU+ju+durD
X-Gm-Gg: ASbGncvxhQuk7bALpXkg+5xu4XEZX08XRVONRBsSX/rokkg+u5cErXXzq7PNghWHT66
	6oxRjUdU2hdw0XRT6aMPt1m5inJpSsrl8+vRDIhUNyivfCKaR79xRP3UBJUJyhD/XWKJwchtfyK
	/giELZmXJG6Bhs3neLvmGUPXZipuST8dxHCR+XVYdoFSTishUm2Bd86nG149w+rmrTjGRCrtFJt
	O6tWQ1ZW8LZkxZxx0peRLlZwn/8fHI1RJONahiVN4W7nHWChVkAVoXhLlCSBEVRu5jmVzm7LzkO
	Uned4RCJ+KIX7b+0gJOY1Jq9gdc4c/ZNlogRe50ryXCAL1Pyi1PKjOkrP+atIR1inM1TTK2t1TM
	QDuRZ88rC1vSzFEQ=
X-Google-Smtp-Source: AGHT+IHLOG5YdNiWrI2g4iNSNygtK8lUMOKb4aBkIX2ORgpQKWdmRgP7R0dl64oEM0ngNwVEe1oh8Q==
X-Received: by 2002:a05:600c:648a:b0:45f:27f4:47bc with SMTP id 5b1f17b1804b1-462074c52f0mr6761615e9.7.1758103437696;
        Wed, 17 Sep 2025 03:03:57 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:8bcc:b603:fee7:a273])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46139e87614sm31032865e9.23.2025.09.17.03.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:03:57 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:03:53 +0300
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
Subject: Re: [net-next PATCH v18 4/8] net: dsa: tag_mtk: add Airoha variant
 usage of this TAG
Message-ID: <20250917100353.dbjeh5eibkqdpz75@skbuf>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-1-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>
 <20250915104545.1742-5-ansuelsmth@gmail.com>
 <20250917093541.laeswsgzunu3avzp@skbuf>
 <68ca827c.050a0220.11f9b4.a3f0@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68ca827c.050a0220.11f9b4.a3f0@mx.google.com>

On Wed, Sep 17, 2025 at 11:42:13AM +0200, Christian Marangi wrote:
> On Wed, Sep 17, 2025 at 12:35:41PM +0300, Vladimir Oltean wrote:
> > Unless the few tens of bytes saved matter on OpenWRT, I think this is
> > overkill (and you went too far with my previous suggestion).
> > Two Kconfig options are unnecessary from a maintainance point of view
> > (and config NET_DSA_AN8855 isn't even selecting the correct one!).
> > I suggest you register both tag drivers as part of CONFIG_NET_DSA_TAG_MTK,
> > at least until the differences increase to justify a new option.
> >
> 
> Ok, was following the pattern done by the other. Will drop the
> additional kconfig.

tag_ocelot.c is another example which registers 2 taggers under the same
Kconfig option.

