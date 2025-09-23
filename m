Return-Path: <linux-kernel+bounces-829096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A48B96465
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01B54A3279
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672A725A340;
	Tue, 23 Sep 2025 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieP1rUai"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D47233722
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637352; cv=none; b=DiK2sH28JSdpEYpq6d/q38iG+3yqElTGRCsMRUo5whHNrGiOEqQSxeFEj6yem4le8EH/3anM2NGkjVJyugCFohukjZyf8vdK00dI0K4UpJBlfVyv6/A+dc/s7YmfqCytF9SKz3fGXfFiV0nRGQZiqPoCDMuWaTV2I9YiQUwB+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637352; c=relaxed/simple;
	bh=jxex2Vy8xhpU4HlbEMJEgN+VUIJscyKji7VvhhBioyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8qLrXoY4vrTZtRcuVMo9ZwaInRupx3q3YlYJcGNadUZZtXWbT9DfdjsjfRTNyUTN8X0HjXx7o85k7yn5+8Q50GqYhKe22YyRtjZORIe4xoZlwWPBn9gTGADzgyr2jmA1U32prg06MifZWOASqatXJ2BMJ3BxJrxK8p62k1fvA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieP1rUai; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3405242f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758637349; x=1759242149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxex2Vy8xhpU4HlbEMJEgN+VUIJscyKji7VvhhBioyw=;
        b=ieP1rUaiX7+hB5KNhsbem9pHhGx7kV0jCpeUea6d7aysjErYzPmoA0KMz8iM4SqFQx
         qoMMsuboVl/G4DlBv1xWX5NWM6r++qAxJYao2xth8lfRmZby90vlHapCHC6XbmhNS2Ys
         CbMldAsX/sRRXk/M7NXdm4oWbfKuOqbtwnmeWFklHPGZ7/DO5zXSMtjrD2vSNgMaasod
         D2vAzwCBixULa5/yekSdpDoeiCYLqoRDb0Oi0pxQbGw/6TTYnd6gIVHWHnl2yeWjMHeO
         s5SVzkoR1wgzv2NrTZe/K8bBAYTpqkPtIhsomv1R2HKSIOnji5qh1abGI2fYF/var9yT
         OWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758637349; x=1759242149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxex2Vy8xhpU4HlbEMJEgN+VUIJscyKji7VvhhBioyw=;
        b=tFCL7fEMmLq7/FquEWIU45+e8j7VPm5soqVdwSc1wmb2Ifiq2916AUQIcEWKHLHtSy
         T4aQZZ7k17zLh8ejFP5BpLO3k0Yj3cXPFxv9qdIFSABvjix8LN6hBENKl1f8JeWMeBFi
         V8+uEorLfaRZEbFF0602dHw9KB+bMYScRGzywb/EGBqJT7E4x6o1fSQKk318bdlm58g3
         NE/qTpQMDc2ZRL5YHFIp7xqXOS5tPIXGv6dRvzQVOqm+HFs1nFjks289lWdTtP0LcMM8
         lUwrVWFqeRYjUjNcxeSkILI6sc/iV00DHkphqjXKNU48KG759y/lhWzmALXTkdPifA5y
         VDBw==
X-Forwarded-Encrypted: i=1; AJvYcCVxhoCWcu8lb66vdlhNZp6mhST7Xm98Q8sXA6MQStr9iPqoTgn3CR58LDvcPf3fnUEolbCkf+TVBk40+4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ3nHjrb2fLtNDDnfegJWnEYGxScHPFRTc629Y8VKF0bvYIY+3
	37Qw+hQkUGyDxiIAlhnXB4WLvB6Z4Ccbp3lWMmfhiPunC4/wzzQvmps9
X-Gm-Gg: ASbGncv++LMi7RbqDHiyGRi+XMDAibFwlVQouq4RUFL42sR3cpJsyOS/ng52S2P+ZDj
	CfZ4iuCimGk9Jg0KqlvQdMeAVUV/XZpab3BuqfXuMczVQcnh8Ptenk6jtPdcPxDE0m0wWXn05ks
	1ao2ofAimwKOwr7lQ7wgl3MIohHzhlTDHX9kKu5LZ/zx6bXvH1+aiY61SY8jw8vh/nA/2g3LqJD
	LEUIfhxglRnnZi69hQIjvScdSPb6mXdK+2Y4Rh9ggrtk5ngT59uMiEOYadTYe5A+qFETbtMDdw4
	vJ+tgdkq+OE2bieoLyKqvenXRUAgdZwtPgJjyFFJDyCNdmoAspgw1uOSNBArWCSA+n1X1+XI2Y2
	wyfa+7ifk2+EaFwvyk5wJkoJyx6nCcdFAlYdGqhKkvEBscz35k03hsOpTy1SJG3/rRse6viGWhv
	Hvu90A
X-Google-Smtp-Source: AGHT+IGjet5wQJA7x9sBQkHVST1A9uu//deoXDFw+WZ7o8/Afi/1TjeFJpy7+SiHbPkDBXjldSD9Ag==
X-Received: by 2002:a05:6000:290a:b0:3e8:f67:894f with SMTP id ffacd0b85a97d-405d299fc65mr2558272f8f.26.1758637349101;
        Tue, 23 Sep 2025 07:22:29 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee074121b2sm24139332f8f.27.2025.09.23.07.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:22:28 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject:
 Re: [PATCH net-next v7 2/6] net: stmmac: Add support for Allwinner A523
 GMAC200
Date: Tue, 23 Sep 2025 16:22:26 +0200
Message-ID: <2797545.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20250923140247.2622602-3-wens@kernel.org>
References:
 <20250923140247.2622602-1-wens@kernel.org>
 <20250923140247.2622602-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 23. september 2025 ob 16:02:42 Srednjeevropski poletni =C4=8Das =
je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
>=20
> The Allwinner A523 SoC family has a second Ethernet controller, called
> the GMAC200 in the BSP and T527 datasheet, and referred to as GMAC1 for
> numbering. This controller, according to BSP sources, is fully
> compatible with a slightly newer version of the Synopsys DWMAC core.
> The glue layer around the controller is the same as found around older
> DWMAC cores on Allwinner SoCs. The only slight difference is that since
> this is the second controller on the SoC, the register for the clock
> delay controls is at a different offset. Last, the integration includes
> a dedicated clock gate for the memory bus and the whole thing is put in
> a separately controllable power domain.
>=20
> Add a new driver for this hardware supporting the integration layer.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



