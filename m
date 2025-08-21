Return-Path: <linux-kernel+bounces-780361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA4B300D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F341CE63B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F832FDC42;
	Thu, 21 Aug 2025 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtNs/1Se"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F642DCF58;
	Thu, 21 Aug 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755796683; cv=none; b=QSahJHTmejpuG5821Qe3R1M0uvJ74Wn4SznOp+DaeOIry80FbGk77m9Tp9tHbIE9IpHnDNmJb17LG77wW6O9BfkTZHHkJ3307+o2Sh7QD48+KqlY8tFtAPrkOAMVQkyLg/HXuK0rGnVlp9ekCeC9Hj/qA3uB1BVsqlDBVq+wly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755796683; c=relaxed/simple;
	bh=LrbyNf39tSzJ81B5o+I7bZf5pg3uLPwS6g58MGHjZiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBiOHpTzz7aoZ5ZlX1vEmmfTGaFj1p314Teuga3eCBWlOVFCnFsr5FpzBfanVsbE0LEH1h7NQHmHOg/TdJzeQsIYtuzuznBTsXY/d8h1m5i5lDtEo8PeNZ+76g6V2E5rgGUolvcWNxVhrYYI4m2Sz/xRFTu3+WU1PwgzDom8DDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtNs/1Se; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021D1C4CEEB;
	Thu, 21 Aug 2025 17:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755796682;
	bh=LrbyNf39tSzJ81B5o+I7bZf5pg3uLPwS6g58MGHjZiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FtNs/1Sesz/JZXOdYDKeDRpzpU9nzgvbE55KiJMeICzCpxd0Jd53B2UYTQl19+3m9
	 00vgGbcWcI29+QAI16d/oidRF787wKXwjAMmiIfGraLvMciZ3U+fsbKEZAYSs+WT/1
	 +7Px5y9K/Rpf/ii3bN6u+NXf9nge1e7UpBnIq2cIPF1MHBMdmAOL0fjn96scaHIz/O
	 7uOWtgHWSSJADfxXMOAR4oEyZLKuv8/1VdO5lD18GURK32a3bol4aI7qSzLdjh7hJ1
	 YZA6227v8EI8eBps+L/yfiSF+PH61BKhBZ2EDGaP2CeXZ7RuRdcRLpZRqwCIfb2Zcf
	 elWlwpjccdMXQ==
Date: Thu, 21 Aug 2025 10:18:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com
Subject: Re: [v3, net-next 0/9] Add more functionality to BNGE
Message-ID: <20250821101801.2d0820d6@kernel.org>
In-Reply-To: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
References: <20250821211517.16578-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 21:15:08 +0000 Bhargava Marreddy wrote:
> This patch series adds the infrastructure to make the netdevice
> functional. It allocates data structures for core resources,
> followed by their initialisation and registration with the firmware.
> The core resources include the RX, TX, AGG, CMPL, and NQ rings,
> as well as the VNIC. RX/TX functionality will be introduced in the
> next patch series to keep this one at a reviewable size.

Please make sure the timezone on your system is correct.
You sent these 8 hours in the future..
No need to repost (I think, we'll see if CI is okay).

