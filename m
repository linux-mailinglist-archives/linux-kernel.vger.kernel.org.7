Return-Path: <linux-kernel+bounces-800389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8767B43721
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFF25A202F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2B42F7445;
	Thu,  4 Sep 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIp5rGKS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E44F5E0;
	Thu,  4 Sep 2025 09:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978238; cv=none; b=XsIXDhxlHDbQlq1gmPnetBKgQVmcb8jutT9MuASFQnN70MuWBMzH9xXc9Yjy4/FZvsdKlcNJ/E24jEJhMLHKj9sCJCSY7ZPKeqLzS2bDV7us3bJKVMIIp8BXFhNsKQYhj/O2wbcWw5Yi9oHiZsA2E4JQig03UeINarv++6/3mss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978238; c=relaxed/simple;
	bh=NuLfP+r54LURDa2LMo8LpqmiyCBnEVHwC9eXfZe3py4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCszN7YG6z5MvhFH7r+RSl+r9cy9cM8J6/mXaK086xdWC6Lxgjq0AJ64IbIJRu1QXe8PNEyTlMPnXntNid88ucHJ9KZ04GQBtX3CLf5LIHK2rb90BMT8flAXxNKhE91RgcllqkY9rRzybHLkB1Fa1ozKVIaXN5gorUFNGhQrnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIp5rGKS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58917C4CEF0;
	Thu,  4 Sep 2025 09:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756978238;
	bh=NuLfP+r54LURDa2LMo8LpqmiyCBnEVHwC9eXfZe3py4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HIp5rGKSsb4OffYTPRkTkmC9E5V/Dz1pqOk7/EYbgLIWe3oY2+HwirS20q+oEPy7Y
	 JMxHmdnotOEJ8ULS1BDyK7jDnnJH74Kf9u3jTPldI2ZFawLqRARtARC8L0G/wqu+p0
	 kzUoCsSHywe6b6JIv+2jQ3aWL7u6dlQ9B7W402IpH19nRtWcuJAxd3dZbBZ/ptL9Kg
	 +bvoO7gBWo1QDg/Qwsx3T+tFveH8XnAxmfJRrAb6JFrjJLS2B1hUcdAEHYu+udoGUk
	 UM5tvz4E86r5BCr809NTNldr6BMX4bc2Qm8AYrLLMPjIimyfDxJVOxcvQPidbWSuvi
	 3Wu5OChGPV14w==
Date: Thu, 4 Sep 2025 11:30:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chia-I Wu <olvaffe@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: gpu: mali-valhall-csf: add MediaTek
 MT8196 compatible
Message-ID: <20250904-practical-dazzling-quail-f1bebb@kuoka>
References: <20250903225504.542268-1-olvaffe@gmail.com>
 <20250903225504.542268-2-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250903225504.542268-2-olvaffe@gmail.com>

On Wed, Sep 03, 2025 at 03:55:03PM -0700, Chia-I Wu wrote:
> MediaTek MT8196 has Mali-G925-Immortalis, which can be supported by
> panthor.

What is panthor? Please describe here hardware or provide some
explanations of not-that-known hardware names (if panthos is that).

Best regards,
Krzysztof


