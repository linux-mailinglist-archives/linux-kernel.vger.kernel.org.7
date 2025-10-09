Return-Path: <linux-kernel+bounces-847379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9FCBCAAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 21:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05CDD1A6461F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D97B257427;
	Thu,  9 Oct 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lub3eKIm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FED1E0E1F;
	Thu,  9 Oct 2025 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760037679; cv=none; b=AX0ZwCG/xjdX6u/XdCMmWc8L0KH8U/XeK/i7byE2lI4ngZjY0OC1bQuMsXKagit9f/qZ+EHY6CTfejzqaz/RMJ7WQrpB6LZgQ6wJ9tBiQKJqCFc/3yJbA0+1tqULmlBgv+Eqi1IL5zZ10uJJIEbv3TP0+NhlpZ1Q4QZfknQ0fYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760037679; c=relaxed/simple;
	bh=18fHUWDNSQljUoYJI3Axun2o+ocQ6s6w9YhkVRAnKYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzQUx8mKIP36mucV8C5N9/HCKHLSzReFI09iytAonrNicqecgmuzvuklp5i0GAJS+G9V5xCncSHH1tAo+AgpCPwJ8C4Osh2G7BdMO9dHN6oLHWIOo4n2/5DLa8DXp6OYYyGm2/hREDiQS5unnXmTnGgEXpU8qXyl1fdl1N7QKhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lub3eKIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A745FC4CEE7;
	Thu,  9 Oct 2025 19:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760037679;
	bh=18fHUWDNSQljUoYJI3Axun2o+ocQ6s6w9YhkVRAnKYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lub3eKImSDaH6fKkT2fEr9nTCW77I8rs1WjqxYF1qPPPSZmnKKkoZkX0r/tsjgkOa
	 lGSqoyXV81hvBbPUYdOBqp9zb6mdDE1QQ7srLMOcyH5tN+L4jzD02ZeSPjKDqjUWGN
	 8mZHtT5suKNHwW40jlCQj0yun3dG4RT8Gu52UB4W5+/P2V5Kqz8CafKSksKx2RNq37
	 ZUluDGJD1+JG5RDiMtl5aAIuGiCbulv6gPfc8ovuJEtOYiJ3oHav/wzDGkw8E+Qsw0
	 N8s55eRJASysIUYx9SZpKhVzmKayXmr+wEStS/nFVlQUUXOhTac2gap7af/fZ4sx9v
	 qcxKuXwGBk5sQ==
Date: Thu, 9 Oct 2025 14:21:17 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: wenst@chromium.org, devicetree@vger.kernel.org, matthias.bgg@gmail.com,
	krzk+dt@kernel.org, lgirdwood@gmail.com,
	linux-mediatek@lists.infradead.org,
	igor.belwon@mentallysanemainliners.org, broonie@kernel.org,
	lee@kernel.org, kernel@collabora.com, conor+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/9] dt-bindings: regulator: Document MediaTek MT6373
 PMIC Regulators
Message-ID: <176003767679.3125300.4178985670134779144.robh@kernel.org>
References: <20251003091158.26748-1-angelogioacchino.delregno@collabora.com>
 <20251003091158.26748-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003091158.26748-6-angelogioacchino.delregno@collabora.com>


On Fri, 03 Oct 2025 11:11:54 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the regulators found in the MediaTek MT6363 PMIC,
> usually found in board designs using the MT6991 Dimensity 9400 and
> on MT8196 Kompanio SoC for Chromebooks, along with the MT6316 and
> MT6363 PMICs.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../regulator/mediatek,mt6373-regulator.yaml  | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6373-regulator.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


