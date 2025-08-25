Return-Path: <linux-kernel+bounces-785632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8248B34ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D024F1A86DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB82BE7AB;
	Mon, 25 Aug 2025 22:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbVsfzrM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF54D2BDC0A;
	Mon, 25 Aug 2025 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159989; cv=none; b=gDA7JbSfMJaf7kUm6Z1LNX6apM3CE+y1YIhH8lP3F1x/ew/AojONUgEkNcdgVymGd2wpB1Wezkw5RKknoFUvqsqyIKgP+Xk68sY7fQ3O0rPmI45VZobNBtElyD9y9QSLGkBsf8HEY4u8RrnrD1nTTKtGzqCsrqn/8rQUPFYo8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159989; c=relaxed/simple;
	bh=axR1PkwP3PCqOGhdZ8Q4aVIFEtqKvQk8HL5Bpa2psbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQj69rIFsE7/LSp6+zPgvhkj9swbopU+Ttijo/kbcCEzRAhdixHXi7aCv5Sr0Yjd15R5yA5OjHbP62Iz8gljUxZM2FrdVwRMUJ9Q0cSlWM+wdmdIQehjkewQJQxyqnDC2iBm0b57ZnwPYoznHUer6DdKtwDFRm5wxvJ/7oOztS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbVsfzrM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9115AC4CEED;
	Mon, 25 Aug 2025 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159988;
	bh=axR1PkwP3PCqOGhdZ8Q4aVIFEtqKvQk8HL5Bpa2psbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbVsfzrMFuOr+nJXmpVPp9JkyG99YFvsMrUil1SnQWkqErVIxmv4pUaZlOS8R57L3
	 hUTW3wANCZidwqn+wj6n5D4l9mHKR+K7FTEzhQAe/n7JSeNh4julMkVljOEcqP51FS
	 ImSvV82sPM6T+1ivGgsXbHspVdcxxcH1nh6OhH+jOLfSYJXe40v/DxPiMUhrgdU7O8
	 x5v6NIEiy3HC2rv0h0RDdDpZoOTVTSLMqzBAmTmkHmk7xuXPLy2lsxmdZcQ384XsE9
	 YNOQdSyQ45EhoLMwZBD5mIqY4GWO6VrQO1QJe9wCAe+91SrfU+sF2G99lDqWGGeYSB
	 UDK9HF00vP5/A==
Date: Mon, 25 Aug 2025 17:13:07 -0500
From: Rob Herring <robh@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Message-ID: <20250825221307.GA706481-robh@kernel.org>
References: <20250825-t8015-nvme-v4-0-6ffc8f891b6e@gmail.com>
 <20250825-t8015-nvme-v4-1-6ffc8f891b6e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-t8015-nvme-v4-1-6ffc8f891b6e@gmail.com>

On Mon, Aug 25, 2025 at 05:15:04PM +0800, Nick Chan wrote:
> Add ANS2 NVMe bindings for Apple A11 SoC.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>

You forgot Krzysztof's Reviewed-by.


