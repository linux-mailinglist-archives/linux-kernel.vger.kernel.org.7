Return-Path: <linux-kernel+bounces-836287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC2ABA933D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B273A9A69
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9470F305E28;
	Mon, 29 Sep 2025 12:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="YnZatRgI"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1D47F77;
	Mon, 29 Sep 2025 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759148914; cv=none; b=h9WiqNsltxdV+vVFEsXZ5Vg2Fq0DO/h0rv4c1v3LLJYmL955upEP5U305KU1gHV5UrxQcfwAN4ADJrjliExBwZnRKxlcP8tJxxQ+hP76fSU5mAC2gwshakhwxuO26020u1xMAsQ0fxdHNXqTbHoIMnjoRPni0em/YhvkmoOLC+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759148914; c=relaxed/simple;
	bh=B8HxvMsbOZxtQTKCjlW7Kh23DmVfi7q+asxmvEAD1C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbeaDbZmIiZxlWqMxCeaVXt21ptFRVVZ5VIU3ruraG1Bb6UYSx5/dF+hNMVrODbUstvTmB6G0S1oObJEuiJxpdKblN8lamiUkuzHglcvwVWHRYLclplArf4rKEnOLSEcuuNqQWajobmv2fPWyeJsp4EhRLIwspTVPfASTHT5mZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=YnZatRgI; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=B8HxvMsbOZxtQTKCjlW7Kh23DmVfi7q+asxmvEAD1C4=; b=YnZatRgIPhzKJONzIVGCaHMQQY
	1nrYsVtq/K941C5fGf/uwNRKN5rpgyYTJxcdEqv01pa3i/io1qTiUIeD2E13IysRIRmGuq7WVnolv
	0PH8/3iDNtsHv0GA8H5JZVDb8tYU7K25jONEw7wcLq0smzrOVKJTdYJggftRdF7iBGjjCuzyLeLz8
	CESZJ13RqBC3+UmFqITlg0lh/cGlu96DLslx6zJFrh0+0dC3FLKc2Z8fBZVms31Al+8ilqiE7/kJV
	/SpF8mDF6ZqnhzquOzCIPes56n9bUSSGnGA/b7XYgIUXIo98F4Eg5bZ+qWSH1SXpr6eB04jWUJrmJ
	7AKnu1VQ==;
Received: from e227-076.eduroam.tuwien.ac.at ([128.130.227.76] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v3CzL-00072s-3M; Mon, 29 Sep 2025 14:28:19 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 quentin.schulz@cherry.de, kever.yang@rock-chips.com, naoki@radxa.com,
 honyuenkwun@gmail.com, inindev@gmail.com, ivan8215145640@gmail.com,
 neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
 pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
 jjm2473@gmail.com, jbx6244@gmail.com, Liangbin Lian <jjm2473@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Date: Mon, 29 Sep 2025 14:28:17 +0200
Message-ID: <5700676.tIAgqjz4sF@phil>
In-Reply-To: <20250929065714.27741-3-jjm2473@gmail.com>
References:
 <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-3-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Montag, 29. September 2025, 08:57:13 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Liangbin Lian:
> LinkEase EasePi R1 is a high-performance mini router based on RK3568.
>=20
> Signed-off-by: Liangbin Lian <jjm2473@gmail.com>

In v1 this patch received an
Acked-by: Conor Dooley <conor.dooley@microchip.com>




