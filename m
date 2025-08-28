Return-Path: <linux-kernel+bounces-789208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C637B3923E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DEB97A5403
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 03:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFE61D5CD7;
	Thu, 28 Aug 2025 03:34:40 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA4213D503;
	Thu, 28 Aug 2025 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756352079; cv=none; b=V5dW6gvNyGibaOsPoiqdY23UnbClBGg7n2VFW76nNj6G6CMYQe8nL60TqXmEojA5jfOcF/jbMW7LktU0gCSRdYOHbD6WYtggf7K9WWCfGMkZP9hIoMW4KaUzINmxksarHSM/TilYdfP7b1AaH5OpHYB9oG7XGMa2ywkMZwZAT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756352079; c=relaxed/simple;
	bh=Qpx1dn0FArzKvR4L7Is+PubzWZH08yfbF3q9BqACf5g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gp0iWnm6tdhgkevF5OOHAAG9Ba1FylyWiZRUh6DDJUOdO0tA6aqlCPNkwkdHXiZjABy2YObuafGyXcQ5eS0KD3HGuUATkt+Y/sYm0ENHf34ELG3xAViSXjAorqU5BLUvg1sIkeIQuPqpp6ZuNkcGRCXaHRbNZ29KH+z1T94w7pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 57S33u1U072759;
	Thu, 28 Aug 2025 11:03:56 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 57S33GrF072241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Thu, 28 Aug 2025 11:03:16 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 11:03:16 +0800
Date: Thu, 28 Aug 2025 11:03:16 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: Conor Dooley <conor@kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: cache: ax45mp: add 2048 as a supported
 cache-sets value
Message-ID: <aK/G9LmmT120aPXL@atctrx.andestech.com>
References: <20250827-negligee-kinship-7832ba58deba@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250827-negligee-kinship-7832ba58deba@spud>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 57S33u1U072759

On Wed, Aug 27, 2025 at 07:03:44PM +0100, Conor Dooley wrote:
> [EXTERNAL MAIL]
> 
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The QiLai implementation of this cache controller uses a cache-sets of
> 2048, and mandates it in an if/else block - but the definition of the
> property only permits 1024. Add 2048 as an option, and deny its use
> outside of the QiLai.
> 
> Fixes: 51b081cdb9237 ("dt-bindings: cache: add QiLai compatible to ax45mp")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Ben Zong-You Xie <ben717@andestech.com>

Best regards,
Ben

