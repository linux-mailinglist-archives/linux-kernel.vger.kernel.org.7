Return-Path: <linux-kernel+bounces-775200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE76B2BC75
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493753AEFE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB80D31A06C;
	Tue, 19 Aug 2025 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENHtZMCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FE14EC73;
	Tue, 19 Aug 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755594108; cv=none; b=DRA0QeD71e1pPV/DNefXI2GokvoxuERPxIsdSE33pXNR5rQZf9UldBxc0wzasOUWu3Dxpt2Igv/Rd/iJkMJ+SKLjRzRs+keC+omjH9IP5K5D/1SXGim51MuwEeKHpkDS3gz9GToxcUNAjAyV1bnzRXB2K/kv79578bUS+PHIlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755594108; c=relaxed/simple;
	bh=ldliHNwmjVthPS25DXxnPDhZKu356HejM/lq5pb8N0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsCr/5YDDSU3VOM986jaE9+M9uJCYGUUYUP+SEDcgWLNFhaF73ZA7TexJlmRglNT+a1JI7No3wwY3D+I67wouPtKdvkIzKA9xGqBV8dY3h1wUHNqMXTUqe9f45sAWEM6BhQqQ4/s2Mw8BlrS1AGEjP19YgDIqbWgcCPXxG48Qc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENHtZMCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 445DEC4CEF1;
	Tue, 19 Aug 2025 09:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755594106;
	bh=ldliHNwmjVthPS25DXxnPDhZKu356HejM/lq5pb8N0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENHtZMCTGMtmC15HCNDd4P/K7Q1lX2HOzIXe4s3bSPcEF+QRVPp66UnAGTkZz1Z5e
	 wkVUDPJALFDtsxu6FJfxdD1SbPV6KUVfvfQreL8r+g+ulHhodtnh9SynJFwnje0v4A
	 eZfWOsPfNF04styNt/oqZdfkxWqQ+4CfZor6NILN1fmNmLbyGbDTAEKb8zGRS/hGts
	 jcUoIydxaWDCpYxS5qolCgNtoU9JSMMErTVe5LFZsZPyCZ8tdMxE/oQRMl/B8YSIUO
	 /02clzYtUp0BQhZNexJbHDiQrI+QlEn41MawZxCgG605Ocp2jGOcMnMKnejs6OoE/7
	 J7a0K9q3+AQrA==
Date: Tue, 19 Aug 2025 11:01:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yunfei Dong <yunfei.dong@mediatek.com>
Cc: =?utf-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4=?= Prado <nfraprado@collabora.com>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Nathan Hebert <nhebert@chromium.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>, 
	Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 01/14] dt-bindings: media: mediatek: vcodec: add
 decoder dt-bindings for mt8196
Message-ID: <20250819-expert-airborne-marten-caea84@kuoka>
References: <20250815085232.30240-1-yunfei.dong@mediatek.com>
 <20250815085232.30240-2-yunfei.dong@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250815085232.30240-2-yunfei.dong@mediatek.com>

On Fri, Aug 15, 2025 at 04:52:14PM +0800, Yunfei Dong wrote:
> Add decoder document in dt-bindings yaml file for mt8196 platform.

Nothing improved.

Best regards,
Krzysztof


