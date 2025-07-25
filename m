Return-Path: <linux-kernel+bounces-746298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68C2B12510
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B05AC5EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8E7253B59;
	Fri, 25 Jul 2025 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6q+i5BC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C324DCEA;
	Fri, 25 Jul 2025 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473873; cv=none; b=SYD3bv4aIl4LWHD0KUMo6MKmggABCgVfaAUjkWXjfvCitOL0O8Gpb7BE8wBEa/PB9vzthKoRADtVzLp5RQ+7bsW8kWOTcWvgSqSCvo4qNxemmZU4dxSLBIFYsxF2Dlpjh8DdRZPDsbHew6hCKWdpfE9/S2z1sVc5CjubiDWPSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473873; c=relaxed/simple;
	bh=j2xP2YzjEhO/30DThbGEpUholDVj1payjvPb0Iem0lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THM8mAhDgVpKyy2OVS8aztkDs/NmJY+W2XIOPn5zrRzk1ZnoDDYX7gKNIbt3PXRaSJdrvZ68/mLAlZYsoJjxi1c221JqCw32kTJlA3pHpqpmIPX7XWA/S/mOAVqhhtyfi8DlCmHzYw1Qt0aCvrgW3dtrLYyja/f7/ffhoHFvRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6q+i5BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE636C4CEE7;
	Fri, 25 Jul 2025 20:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753473872;
	bh=j2xP2YzjEhO/30DThbGEpUholDVj1payjvPb0Iem0lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6q+i5BCLBcSN/DYiQwjJAei6Lyf2boWZMGLisUGWhnTSvhjllyce7I9bQP1hszi5
	 1X7bklybM3GzS9ckn8txmcbWhAlejexAonWa4/7EgzxQn6dTAYmhNXwgS7umhARiWS
	 pFlj48Du8XGZ1dVczH7C877p+MLFOPjgfaACzIDFELxaXf/+ZFhWjQpw4N9Iz2UR09
	 5o1082nlM58UCjjElqObxvGtLQ4Wmz/O5BpA+etRU4QQZ/TTtKLH+uxyxuXMEOOTzr
	 lGRoV9oncbE22SjmSwwDl5iH/Z2iazqq6aOhhx2cUk0xCZ8JdpXu95RDNsh6YlKpm2
	 lkpKe2UV76yEQ==
Date: Fri, 25 Jul 2025 15:04:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: jonas.gorski@gmail.com, netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, noltari@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v2 2/7] dt-bindings: net: dsa: b53: Document
 brcm,gpio-ctrl property
Message-ID: <175347387153.1759527.1350037540423103055.robh@kernel.org>
References: <20250724035300.20497-1-kylehendrydev@gmail.com>
 <20250724035300.20497-3-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724035300.20497-3-kylehendrydev@gmail.com>


On Wed, 23 Jul 2025 20:52:41 -0700, Kyle Hendry wrote:
> Add description for bcm63xx gpio-ctrl phandle which allows
> access to registers that control phy functionality.
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/brcm,b53.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


