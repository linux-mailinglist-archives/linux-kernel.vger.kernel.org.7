Return-Path: <linux-kernel+bounces-828744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE344B9555F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCDDA3A7296
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F32A320CCA;
	Tue, 23 Sep 2025 09:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e1vPxofD"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A7630F943;
	Tue, 23 Sep 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621310; cv=none; b=rcXPh//W+hLMxsz2LK6J4MkagomKGLiguHoilZQYDE7USXKfFMw8P8UwYX9kHmfKzYzFniJ/eI51aFsL1HgpzdX7Zbzt5Geenhz9jBXBfcSAfPMlAApQK66HkTipBlv5tdw8xyTlmVhyQM14btAgFvxga6j0YcBXYMbeGUT++FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621310; c=relaxed/simple;
	bh=MZWNmQROaaiEO4r35cOCMPw3NenGe2yMbo5yIUgeE44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SipJXGx4XfG/Y2WoVLpksMdMAjewn/dfBygxWThqiTuSgupBuxfvFfanfn7oa9On8XdBb9tq6U1MDuLh9+UYozULjHKiX8ls1QPK8ACRrBPSsPGm1ElaT2SeSFGvJQkSEgs5pJvirfheNFOl9R3Kxpn4Rf78clpcSNOK6PXgH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e1vPxofD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758621307;
	bh=MZWNmQROaaiEO4r35cOCMPw3NenGe2yMbo5yIUgeE44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e1vPxofDp0H2QyGMxhrKQ/VqWTJIn48ZIvUGHdT2CSt02BqRPzcIdg8MiL1poz9Wx
	 klbLlgYcLiWLhY7EhDEc5UmKio1aE5NShltGMmaLgMWYDSEzj/ge7e8YjlY2c67fFr
	 evQIDi4njNM+Wn6iHD99YTuAGrhDbjvKGjCNjw2tm7okuhBp+CtVe6FPqwcduEClec
	 xP8Pa9HmEefrhn5INy+7ROLk9w0L4cQxsDmfYhJwsUvAhvSVEiJ0HAjCJxmlsg1SNW
	 XvGaLJy+oFs/lvdlhyG0N3a7UcGe+AyQzrlu7vvQ98Rx8U/C7v6ZmtvWxTMEwU5pW+
	 PVaM9NxIjyj+g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 99E9F17E10F3;
	Tue, 23 Sep 2025 11:55:06 +0200 (CEST)
Message-ID: <2fb56243-1e8d-48c0-b510-8fdee489ebd0@collabora.com>
Date: Tue, 23 Sep 2025 11:55:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: memory-controllers: mtk-smi: Add support
 for mt8189
To: Zhengnan Chen <zhengnan.chen@mediatek.com>, Yong Wu
 <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250919081014.14100-1-zhengnan.chen@mediatek.com>
 <20250919081014.14100-2-zhengnan.chen@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250919081014.14100-2-zhengnan.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/09/25 10:09, Zhengnan Chen ha scritto:
> From: "zhengnan.chen" <zhengnan.chen@mediatek.com>
> 
> Add binding description for mt8189.
> 
> Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


