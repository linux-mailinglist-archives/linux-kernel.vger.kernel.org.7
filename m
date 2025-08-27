Return-Path: <linux-kernel+bounces-788607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EDAB38735
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920D4173390
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A632FC860;
	Wed, 27 Aug 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpOsRemV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EC21CFE0;
	Wed, 27 Aug 2025 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310394; cv=none; b=PS3uJCkF2vooLllELIC1d71uKrD68RyKm018e9Tzw54HJeTzb25FKP4YdpBYKYFUUbPifGZTq+UZOh2c/qah8TgQTBrpTkmFLL7vQZIOI2BKyS27Hhx8r+JChYjdpDlRmP6adgc3+fRp2N0uNPoYGjmBKUXJbm1z3J/NpB3X//I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310394; c=relaxed/simple;
	bh=RFezkzaQXkCbowCKLjQPIDEaCnTCQ9QXLpMxI9n1tC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cibDCy5QOLzhQM+OJlxlsVWc7W0wmNe4n1xpgvme8N3mDnL5kTqVM9NKPZPCs72UCIvcOHUov/JZ1kwdFjVzEttgRE7JSn8XhthFQ5vuMqc9LHP2bcVNeLUXAFpRTd5pxxtECjQGPs6+sgzXfkdjtV5W46c2Aes1Fyut2ObZmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpOsRemV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E54C4CEEB;
	Wed, 27 Aug 2025 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310394;
	bh=RFezkzaQXkCbowCKLjQPIDEaCnTCQ9QXLpMxI9n1tC8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GpOsRemVboGQI+m7uT41s2OPjaYVcJxV4BM0hfRQvGXJbJdY4G9g1bLLY4aHN+BGW
	 w5TYIN/AOs0athPh5ZPzuyWdZclqi09W0tc5nJUj+x043xF/m9qc5T5nR9uVBjFRnr
	 jXVCtFbp1ZK8F32XFDghiFhEO7ay24WyDUiURfmL7yAm7wRJEjZ5LRclYjbE1+5PaQ
	 A9a+1Cv7AXZ1WDme19nuJgMxjIE+S51w9Sr1SiHNJ8FxjSVXlJiGvqkvp8iEOIM7O0
	 1nohygQFjKBcpH5s14Sqw5bZS6uUWrzlI69pmiI1r88Dh0A+tvNK/IOZMR5/uXEq3N
	 X4bAN53kCnlpg==
Message-ID: <871a3abf-3dbd-4360-9b89-7951464f0d89@kernel.org>
Date: Wed, 27 Aug 2025 17:59:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] nvme: apple: Add Apple A11 support
To: Nick Chan <towinchenmi@gmail.com>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250826-t8015-nvme-v5-0-caee6ab00144@gmail.com>
 <20250826-t8015-nvme-v5-2-caee6ab00144@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250826-t8015-nvme-v5-2-caee6ab00144@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 14:09, Nick Chan wrote:
> Add support for ANS2 NVMe on Apple A11 SoC.
> 
> This version of ANS2 is less quirky than the one in M1, and does not have
> NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
> SQE.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>



Sven

