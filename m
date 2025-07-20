Return-Path: <linux-kernel+bounces-738474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED802B0B8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 00:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A828017ACDB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00FA1A01C6;
	Sun, 20 Jul 2025 22:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzxscFhd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80722A7FC;
	Sun, 20 Jul 2025 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050742; cv=none; b=qKws/xqFaecRPYpxWLrpzBXXNnTFJ9/L2GB8YiPHjAlf8GLPPZe2fKQfvO861ST0HE8NrDbn/JC8SOlOCn/lws/g8IBCvkUrci209Gb/aROnLZAwvmviv6jYxNiKoH1pKVPtZhFEBjyKe0Lkp09SSLhVIErWe4oUgr4gb4XURh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050742; c=relaxed/simple;
	bh=wz7il3rwlqXu346/86AuP/gL4vVWy8HvWTyDbXEfd+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pxj71mxn+wG+4kMnU7l7qiS8uv4V0j9h0S29Tuzs56gYQmG2BzfgRFzH0lFztfO01LBekY/3s3BpBzRgxmgMToMjxHQJFA17K1wA2GCTfXiClToWqdVdSqLyGcF74SV5Wi4ImQq+XF5jXNz3u3chtq9cuXlYEEalkOPDK3lXIzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzxscFhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FBFC4CEE7;
	Sun, 20 Jul 2025 22:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753050740;
	bh=wz7il3rwlqXu346/86AuP/gL4vVWy8HvWTyDbXEfd+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzxscFhd0jBwdrP8BdLUpLCEV/5haQsKJtwx1EREM9FtuWJXFvgVVMTuo8SrziUhK
	 78WI/ciGnSqFapKHjp8J2m9AQFrMpEYP17zFmRrlLIeSQtknBtZFKvTVu5DJa6lgU1
	 iHMeoKINlrRTUjEPc06ZqcgdL+lT2babDFnxoA6glnjPOCW/BtDkYVj5Cw4OfgtasM
	 KhJyD6Caoapavce3AHqBn2U/f9Y1mR5h/gHniWMVz0hGAdERUaCz4DTRcCoRXM6tcn
	 EFkXK1zAdq+QBkDY8CvRiYzL32+tQny3w1k9BsUZ17Gc5tPZdBRAjp40bu+Yz1CFO2
	 IT1wcCUSaYyWw==
Date: Sun, 20 Jul 2025 17:32:19 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Arseniy Velikanov <me@adomerle.pw>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	linux-arm-kernel@lists.infradead.org,
	Flora Fu <flora.fu@mediatek.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT6789
Message-ID: <175305073930.2915534.16459259911268975205.robh@kernel.org>
References: <20250715225746.1321-1-me@adomerle.pw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715225746.1321-1-me@adomerle.pw>


On Wed, 16 Jul 2025 02:57:45 +0400, Arseniy Velikanov wrote:
> Add a compatible for the PMIC Wrapper found on the MT6789 SoC.
> 
> Signed-off-by: Arseniy Velikanov <me@adomerle.pw>
> ---
>  .../devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


