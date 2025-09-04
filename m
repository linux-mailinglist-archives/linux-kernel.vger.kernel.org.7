Return-Path: <linux-kernel+bounces-801555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F45B4469A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 21:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C846A4083E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B1E2727F5;
	Thu,  4 Sep 2025 19:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="glsruVWQ"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177025E469
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757014877; cv=none; b=c+WPNaPjS2Phx74Ih3lpVet8HzPU363QeHjlUI8TyIfF5keqQEFGdkb6NAXz3xQHCqhTBbei7jLDgNyOwqzXzJQVcX1nwskplpnxtVdfiueQQkir97lTaVmaJRgaF35KTBg+juXJpMW4lXKlvPjHdTIKNsgpxbTMdp7nxCU+CEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757014877; c=relaxed/simple;
	bh=DwES1wrjYaHfI91Feyf2ssbbKbox3kR6dFZNwsihPIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9ySGE4yaVwV13Z0FLTzWznCGhf3NSbx1tr7ahgsl//LlktgZExYmg20TJm7tVOQqUD6R1SgHikqMdZZo+XBMQTjO3vk7pGjjzGiuUjdyT8QVDqlZSLeKPolWPGT8I55F4mOqlQKFDGIfgbHtDJ5xQPZ9nin6DJ2pGaRzTB/UIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=glsruVWQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=DwES
	1wrjYaHfI91Feyf2ssbbKbox3kR6dFZNwsihPIM=; b=glsruVWQ0NXAEunbgIhp
	ewUnSVdUEfF/nIifW5ym1larMzX78qtZjp8/nelGKg+PpXmP7bBMyLOQaFJJHWWn
	eY9rWz9MH0cDGlg+Vs1cd/SQ7B18oiiWAlvzAljkaWBF/9VOezA3GbqY+NItM+RG
	HRq4PDnraQET7bQE6CPSW4j2cpxXsz13147UPCM0Y/iXYapa79oBGq/Hx1WBed2M
	3/FciEC8nggumVnbFArJIggNDcYTS+/w1Q6+LmVuTTImJxUEnam0SMGc7qGABwFb
	HLy9pWvgyiiLQs80KVSJrV99A3lZ5qMIxiXlAp1ZkED1XeyVdAfu3eaiT9yiWaWB
	Hw==
Received: (qmail 3776238 invoked from network); 4 Sep 2025 21:41:11 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Sep 2025 21:41:11 +0200
X-UD-Smtp-Session: l3s3148p1@5xpF5/49GtQujnuV
Date: Thu, 4 Sep 2025 21:41:11 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: i3c: renesas,i3c: Add RZ/V2H(P) and RZ/V2N
 support
Message-ID: <aLnrV0VBVvQ-XB83@ninjato>
References: <20250904160305.247618-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aLm5kbgRIcomBo6a@ninjato>
 <CA+V-a8t9VU4+Q6ofTYru2=OsrsfiSM53=rtvEzxoYmu_A0wwBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+V-a8t9VU4+Q6ofTYru2=OsrsfiSM53=rtvEzxoYmu_A0wwBg@mail.gmail.com>


> Yes with the P3T1085UK Arduino Shield Evaluation kit (logs can be found at [0]).

Cool. Since it reports two temperatures, it must be my modified version
of the shield :)


