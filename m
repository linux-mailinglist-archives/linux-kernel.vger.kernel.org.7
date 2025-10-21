Return-Path: <linux-kernel+bounces-863048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 190F2BF6DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348C54636B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D05338930;
	Tue, 21 Oct 2025 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="viqO8nEJ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893F833344B;
	Tue, 21 Oct 2025 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054528; cv=none; b=Df5IpmKKKDiLlqlmtPG+22IedXcPLGp6egJrntqNyziAtWbs3pvUQt1/MYR34jZIn5trKSE87GlnooqRxlaktdnWw7ODIlImydyAtKMZgNVoUf5etIdYevpYBk1T4jHnkdXxpgzJ1JasN8CTJDwUG99uNum4NRxvtDCfIw8HNHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054528; c=relaxed/simple;
	bh=QCjj0PHFodRc3o9Thg58ng8c08UeiEwxmUBntf/zLFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zpo3fW/fSr8MDjdB3iVg6X7cOc2RDDe+rSIX9YQGROLSD7ce0lRXIFUitW9totXOntbPSU+jIMTKB9iHZuFdwQXdZYldTDBUBmQYv+oxWTD+LGLYn28b0Ee4k2Lba9qg5K2zdhQ5ZxW+Ru2ee/HkRREKiQ/aYb6nl/Q+FICjVtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=viqO8nEJ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=OV5vokNxg0blL37suXlq+pnS8+wa1U1T+EP+IjunwO8=; b=viqO8nEJsR2dnoqQ3yy40W5YJl
	fQPaH0avx6D9pZGte/+v0/qL88fiddfjMlSb0jOSR7NWLOZN3bNbz6pCf8aQ0WtGZsjS7xZXyzM6m
	KW9/Bmo/RnhsGKdt66tsjrpRAKydOktAk7DKIE5DY97anYkYfFNWvSzuSR6WnfD7/9l5F1ggMizIr
	ZvVrihP0tbG2nYws3v67xbCL6tbBz09N7tqeNT/kRvPWEUR8t/mxWAiyJ8N9oI6Putl9eqPX4Dzul
	RTXonT1BVGLVeRRzGccpX270sSAKcQC/hPhu/uiHrNxlY1r//Tg9o8OvdycNSs9/ZNmmow3g9mTOd
	J9SrNpjg==;
Received: from i53875b19.versanet.de ([83.135.91.25] helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vBCjB-0003ae-81; Tue, 21 Oct 2025 15:48:41 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: mturquette@baylibre.com, sboyd@kernel.org, sugar.zhang@rock-chips.com,
 zhangqing@rock-chips.com, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, Elaine Zhang <zhangqing@rock-chips.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, huangtao@rock-chips.com,
 finley.xiao@rock-chips.com
Subject:
 Re: [PATCH v4 4/7] dt-bindings: clock: Add support for rockchip pvtpll
Date: Tue, 21 Oct 2025 15:48:40 +0200
Message-ID: <2168478.KlZ2vcFHjT@phil>
In-Reply-To: <20251021065232.2201500-5-zhangqing@rock-chips.com>
References:
 <20251021065232.2201500-1-zhangqing@rock-chips.com>
 <20251021065232.2201500-5-zhangqing@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Elaine,

Am Dienstag, 21. Oktober 2025, 08:52:29 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Elaine Zhang:

> +  rockchip,cru:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the main Clock and Reset Unit (CRU) controller.
> +      Required for PVTPLLs that need to interact with the main CRU
> +      for clock management operations.
> +

I don't think we want a whole syscon exposing the whole CRU unit to the
whole world, see comments in the pvtpll driver patch.

Thanks
Heiko



