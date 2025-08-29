Return-Path: <linux-kernel+bounces-791225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42617B3B3A3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5FA58315A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D70725F984;
	Fri, 29 Aug 2025 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXIUtayT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA625DB1C;
	Fri, 29 Aug 2025 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450148; cv=none; b=by0TdbMVuDebji0vFuT+n5pK+pmz6WBGq7gnJZxl8abbLsF5bCNFTQTxWJtU5oXWp2XNEZ087i7Lyzmyd8IAPm/yszdqzlfd5Vlnec22zzykwqsRMvJOQ1X6+pH/vbmvcAM7epx+r8fnEO5NGZP9tpPXHY0xgm80OqxWINZZ96g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450148; c=relaxed/simple;
	bh=6bcq9zt/NpRi6mq0YCfI9xt2nKhZqME42o36Ib3lF88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuxL1ZOOwJVGHLsBFYh6OXxCcUzHhFjxH0gyA95CoRInslTGIEXSQPUGUNrEVqN3eG/6gYorwkKFRJKUqyDW5lhhMqwew8QzSb0+j6zHZgydI7b/HCZOsAgc6VRGUoFOcyCjG/D7VpQa/ZQqQ1TBky25LeBAw0SiIRV1cVu08dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXIUtayT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C218FC4CEF0;
	Fri, 29 Aug 2025 06:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756450147;
	bh=6bcq9zt/NpRi6mq0YCfI9xt2nKhZqME42o36Ib3lF88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXIUtayTen7s+65e3ZLlV7vTinbyBakYn6QvCkaqfAeDXk0k/IWDP9Uh0GNjICUft
	 hZa0x+AVGTHCO5eqCNyoZLUr5LBsKcYK6smjyga8RrVd4+a5mhtih5gkavL1YPx64Z
	 QO4nBYgDI7f13f+RIJBh4JaOhj9W+FMgw/t9fgbHYdEeMSt4jmf7Ke75wozmNh8Sti
	 lWan1m7trIAx855hlbdP+LFdZl6ht58VQL5XieW0yXVsBxYY+3rFAIIokwPEC/cMMl
	 BN33hu09n1FFHpsRpz6opSZopeW0PfroWFzpiZZppgg3espuV+aGFV5W+wdXCRUbSL
	 NAsvSIxKld4pA==
Date: Fri, 29 Aug 2025 08:49:04 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Chen <paul-pl.chen@mediatek.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	chunkuang.hu@kernel.org, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	p.zabel@pengutronix.de, jason-jh.lin@mediatek.com, nancy.lin@mediatek.com, 
	singo.chang@mediatek.com, xiandong.wang@mediatek.com, sirius.wang@mediatek.com, 
	sunny.shen@mediatek.com, fshao@chromium.org, treapking@chromium.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4 05/19] dt-bindings: display: mediatek: add OUTPROC
 yaml for MT8196
Message-ID: <20250829-little-independent-slug-2465c8@kuoka>
References: <20250828080855.3502514-1-paul-pl.chen@mediatek.com>
 <20250828080855.3502514-6-paul-pl.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828080855.3502514-6-paul-pl.chen@mediatek.com>

On Thu, Aug 28, 2025 at 04:07:00PM +0800, Paul Chen wrote:
> From: Paul-pl Chen <paul-pl.chen@mediatek.com>
> 
> Add mediate,outproc.yaml to support OUTPROC for MT8196.
> MediaTek display overlap output processor, namely OVL_OUTPROC
> or OUTPROC,handles the post-stage of pixel processing in the
> overlapping procedure.
> 
> Signed-off-by: Paul-pl Chen <paul-pl.chen@mediatek.com>

NAK,

Never tested.

Best regards,
Krzysztof


