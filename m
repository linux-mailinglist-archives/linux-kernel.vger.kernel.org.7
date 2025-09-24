Return-Path: <linux-kernel+bounces-830989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87057B9B16C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044471899A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC7F3168F6;
	Wed, 24 Sep 2025 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EB24Z0xr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96C205E2F;
	Wed, 24 Sep 2025 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735607; cv=none; b=EzQlR8srjBke7Y8oZSlBLOu8TrvsV0kXtwf827sqhbTFmUnULqd0p/X24GXA0/CnUAMsynLWcwTfMrU6pCHJFrc4bsHj2ABRVloshe0PL7MDaPwowzPkZC3l2ckWnoUIBuKZHZDlcNlx1bghoPkSHNLL8Gf4A/US2aDwMSuENwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735607; c=relaxed/simple;
	bh=iCaAY61V+27NeMsC8KdTTr73hAfJEBQvPdkDUj4Shp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+lVHdTpZ1h827uJz/+qBYIDAywdgOeWxGBzGFDKTNvAoLEsoUne6F7qnIdn74EWogctyZm31gbAaR/iYT6Zle8Gj+mBm2YS1p97/C/atk/AJmpk2lXC6MtiTS3i7JeEyiBGRuTkHPT/xp0Fn59q1AMhh9MjErCcAUVYHMinvcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EB24Z0xr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E7BC4CEE7;
	Wed, 24 Sep 2025 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758735606;
	bh=iCaAY61V+27NeMsC8KdTTr73hAfJEBQvPdkDUj4Shp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EB24Z0xrsn9ItoWKpRgPuDi3c56ct4+2CQMggfZhDoLGqwxfg8Pi9N9OuZ98W23UE
	 E1V0Ev2rEf4PB97E//pPKb282f+vNVXZhZ/oi7seezV9x3mXr4yXfPjKaXbmuohik4
	 a/vmGoeE2opdhN0XkHeubPAAPhV6mguqjSqGBy8zSZo5fjV0MXbztVcExfJJC+xR7+
	 6vy2Ydi3Xcno4P1eeGUiOsgQiIaD/Kgei6G5FJI/eDWKMiRhz5Qoah40EwtCH0NAIV
	 SEB26hQG3IfwpCjor21fN3gs5NUKzlyrUDiNcM7zDEJaViReArHTLhmSIX/Dtwb+c2
	 2R+IcREPpClfQ==
Date: Wed, 24 Sep 2025 12:40:05 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] dt-bindings: net: ethernet-controller: Fix grammar in
 comment
Message-ID: <175873560257.2244947.10640089441769131107.robh@kernel.org>
References: <20250923-dt-net-typo-v1-1-08e1bdd14c74@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250923-dt-net-typo-v1-1-08e1bdd14c74@posteo.net>


On Tue, 23 Sep 2025 01:10:01 +0200, J. Neuschäfer wrote:
> "difference" is a noun, so "sufficient" is an adjective without "ly".
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
>  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


