Return-Path: <linux-kernel+bounces-783527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A0B32EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731D124329F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F081260583;
	Sun, 24 Aug 2025 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdDECLdL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D022D795;
	Sun, 24 Aug 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756027114; cv=none; b=h4ZoMWZ3OsJ1jUxl4UCPzbffZniJaV7a9sm8qMuv80QtV1LksODUmrDRZuGiKdq1LjGZo4uUlkY203A2PjLJkbzOw9aUg90RWuSRlmcfCV3tPI/xqVlbyLgDAff/luH7cpUABLwFcLwuNcchxloGd+/NWlGAHFzFmNLgb5hRrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756027114; c=relaxed/simple;
	bh=VPsCCUiQs1o14TPS3fqpP+XKEkTMO7z0UnbmUopc03M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRnDIpJB2gt9chM7lrEi752YFvuoP9BI2wjs0pVW49rTfQ2Fb/4qWGT8JUxhtM/MBUx1XIry6MJya7s35SLAg2JCTUwSRwc0S7hkMCOKi0CO4B4/8Jvsa7IOsu3gEbJ2XftS0PTBGq5RrzNNaHXVwq+jhNua8q4hhyXtV1E2rKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdDECLdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65588C4CEEB;
	Sun, 24 Aug 2025 09:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756027114;
	bh=VPsCCUiQs1o14TPS3fqpP+XKEkTMO7z0UnbmUopc03M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdDECLdLKNWb5QGcc080B8DxENTo+q4OqlzyJeYfMRT8BU+mpviia2JuWz4dPPW7K
	 P3i1R5nGqClren1DPuJNpnFvzFuXLxcDZyqKKFlxKUyZkBC/abkH7xxAqKNGFE9VC/
	 TgN6msSkTDJ3ixALl/HNQhZ47tzsyHkCvfZ5BpnyABc+G056DpONrgyKry8Wq6Btan
	 t+2UK4Ove/HAZ2x2qBjbmj4JA3JcdXiDw+vRnne3JJNIS8nn5Lo9jrfMrgiT7aICxj
	 nS0rEXrkSmfVUovI8zJjmFcCF15bAg67PFETe3DBPcKiGEhpbGkyoqA0UGk6xgBtVT
	 PKLTXOD3rERSw==
Date: Sun, 24 Aug 2025 11:18:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: robh@kernel.org, gregkh@linuxfoundation.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, peter.ujfalusi@gmail.com, devicetree@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v6 2/2] usb: dt-bindings: ti,twl6030-usb: convert to DT
 schema
Message-ID: <20250824-invaluable-sparrow-of-fury-da67b6@kuoka>
References: <20250822201727.71593-1-jihed.chaibi.dev@gmail.com>
 <20250822201727.71593-3-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250822201727.71593-3-jihed.chaibi.dev@gmail.com>

On Fri, Aug 22, 2025 at 10:17:27PM +0200, Jihed Chaibi wrote:
> -TWL4030 USB PHY AND COMPARATOR
> - - compatible : Should be "ti,twl4030-usb"

All this should be in previous commit.

> - - interrupts : The interrupt numbers to the cpu should be specified. First
> -   interrupt number is the otg interrupt number that raises ID interrupts
> -   and VBUS interrupts. The second interrupt number is optional.
> - - <supply-name>-supply : phandle to the regulator device tree node.
> -   <supply-name> should be vusb1v5, vusb1v8 and vusb3v1
> - - usb_mode : The mode used by the phy to connect to the controller. "1"
> -   specifies "ULPI" mode and "2" specifies "CEA2011_3PIN" mode.
> -
> -If a sibling node is compatible "ti,twl4030-bci", then it will find
> -this device and query it for USB power status.

Best regards,
Krzysztof


