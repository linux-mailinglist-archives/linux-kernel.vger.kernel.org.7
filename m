Return-Path: <linux-kernel+bounces-859000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52685BEC71D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 06:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A9F2935092E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 04:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65D428C006;
	Sat, 18 Oct 2025 04:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFrG/yRL"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BB82750FB
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760761381; cv=none; b=B/4RtD3wK+Y26LkLoVxDEyX2J8ydL04j200GvyNkKrIsWqN6NiqVqm/EhXYEFpo35mlR18icQjCxp1SRG/MRS7DtEH1E6qgLwQ16M9Z3wfYwCcgZ/rE8EDklh38PRbYEyRo4JLNYv2PJ6EIFFnnpnkdJi6PoWqaAxENORgDbMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760761381; c=relaxed/simple;
	bh=twucSrQ5gBaSxq5bHh4w/uiMfTGTQSSYFbLCd3U7t1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biQyuU4G2T2IQYQ7CrBQimNVFjmTOYH+k50Rb+1SGnR4ku2mpELhuC157SMYBquVClDjXMiHF1c26/iKS+cOGkvHjZlfbaZ+Tjps+NAn31jxj7noT1YFFfU+BRAn4HOacPsh5E1l+ys50QnIXbsh/qGi32NlHDYdOP7ZNlc8XZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFrG/yRL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so2225836b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 21:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760761379; x=1761366179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9sLob+FuMRhc3oCQLkxbSCKuBsggj1HN+/JP5OBcKrA=;
        b=FFrG/yRLejUwgHhCLt3PdErv354g7VQQgIlnFWEdFotO6bYVjzdCUMio53YpEOwLwN
         UbfTiwPA8hXRV8sJdkbvdiXNzSxjruImeLRWeUc6KyVdQPTxs2w2vS99o7mg3rAkeE98
         z+Adt+XqEumh8b3RqTTHGwDQiixkqa36jP1b0Oz2RLwMeMysI5wdg7WSsZLPR7WUeNAs
         L3M4h8ahUy4DCXF3oQH40OrKZcFEx9+sM4HfRfAlpH2lAoKjWc+BdHYExsiX+0GqLdjs
         q7Q0nwFI50m+i7cpXq6+gfmrWsHio93yIc9RUrRH2p91y4dp+d6rJ17xJyPzxJT0YLwA
         UHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760761379; x=1761366179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sLob+FuMRhc3oCQLkxbSCKuBsggj1HN+/JP5OBcKrA=;
        b=V+DclkXL/X9b4ksDuf+jfD9F/o0lkRoL2uhh+ZJfg089ucgwCvjIvQkBWAvujMmGAS
         aW3VtNnOLnpIoBRrze2w6qyGqPv6fdnyaGwCMku2g3zRYUKgjQqJgg9CRl9ZSxZEW/mc
         ESxPiUVcFklJ24KMB88bQGkg1ya/qstdoE2f0hq23SJDrdxHUxSeAgBxv0uqGMJVVNbG
         ahkZs8lcNU879x8AU5ulD7gtRGHtRL1VxhtWd87v5gRL0sevHH0Ui0TVAAgN2zVfBHUM
         6jpKHvZIYHbfI3xJ+907nAiU+iGo02/gtrWssZM6idE8oYO4KRKs3ZT89RDNyyzjogRh
         P/bw==
X-Forwarded-Encrypted: i=1; AJvYcCUA1WolJgJ71ZO2t9/SZoA4vTtwWPcEygSozXKWegXk6LkZlPH1v+vVpiRJoe8Fv99EWRBv13dbEiLnVAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHulA6dwgJJXAEYjPG5YaV5FlUpinMiusG4q9cMelmb/Ya6/O
	Ylg3Xj+oMi/OUGoKFiPdljwKXrNHrpkml3/Kbq5TGWYtP+u7uUuNhZS4
X-Gm-Gg: ASbGncu9LI8pDxOBQvv/3CC4nBmOVD+bS5nYlK5qtXN0s342kWIVhNyLeU706zSdimQ
	FnsjOuuZ24TgYY5wzLm45rpGHI/0KsdWG2EPruMp+mIADexJIy0BNbpa/zCOjSl+oRpae0myD1U
	jtZ3DomnUvnS0pQ6OC5D7fUBsfV0r/jvYnnNmXQiWmq5jzEbXOjh+adTyyro8GTPG+ppjICfd8W
	2tQ4V7KmlHEblO3wdcx6ClwEXRq4XvHZVlyk1mqQa5mSpvixDcX6PjdYL6vZbh6v0HbTRZEU0Mw
	ZnoiuvVS7rEMi6+zSNZgydUgUaZnrtWxBA2lBfCztWn3YfNpxf1qren3lF8xWnPhbtXlQSRjFPk
	Ti1g7GGgEGo+7HwkIsobWAvoU/wqY0RYL4/FKkxaSJ/MDZ08NKimbXYkD2s0g/GYDrWY8mMXKYw
	i1jyVvjpD6QeNdtEevy6ZWzzF59rgjjVo3bzr5048cbQWvgAoipLg=
X-Google-Smtp-Source: AGHT+IEhKFhi3mFcny1EeYAjFFvibCPRFlOFAaD2YdcMmlpvQjgeW53Ajd4FqG8YZ9mvVIB5YeafcQ==
X-Received: by 2002:a05:6a00:4288:b0:7a2:2100:1d4b with SMTP id d2e1a72fcca58-7a221001d8cmr7669202b3a.14.1760761378534;
        Fri, 17 Oct 2025 21:22:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5e2d:c6df:afce:809b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34e98sm1318508b3a.26.2025.10.17.21.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 21:22:58 -0700 (PDT)
Date: Fri, 17 Oct 2025 21:22:55 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/2] dt-bindings: touchscreen: move ar1021.txt to
 trivial-touch.yaml
Message-ID: <jxtqhq7u5obj6em7p6hnzqjkmr7svomeptqy5bgvmqr75pbbnq@d5didfx4qqvl>
References: <20250926184720.391335-1-Frank.Li@nxp.com>
 <20250926184720.391335-2-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926184720.391335-2-Frank.Li@nxp.com>

On Fri, Sep 26, 2025 at 02:47:12PM -0400, Frank Li wrote:
> ar1021 have only reg and interrupts property beside touch common
> properties. So move context of ar1021.txt into trivial-touch.yaml.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thank you.

-- 
Dmitry

