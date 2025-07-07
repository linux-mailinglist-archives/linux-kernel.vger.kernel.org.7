Return-Path: <linux-kernel+bounces-719738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5EDAFB1FB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 13:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BDD4A1126
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056629993D;
	Mon,  7 Jul 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXyVI2jY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C536298CDC;
	Mon,  7 Jul 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751886568; cv=none; b=ilYzFDcKlpaccLuUyTw6jZhiZSS1kP+bzisRz1065vSe+XKmjV6S4+qvkbdOv3FzPBocqHQWbbOxQ9i8zu7vwbqKN/V2CqulmkRCrYEJVkSRKo3k5lB+2TORDdaJE8rN4H06aXo1U6NA0UzNfsbuj6ainOBTZ2lQLMMnnlXBMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751886568; c=relaxed/simple;
	bh=mdQufwooJGuRjPwQ0ZE4RMjhFcUOFMDbayVEM+4VCiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgqA0VbehSfeeVQI0b/iZagcc7d4Y43niALFxPD16GrCgbR3TuFBmfK17g9QE+/qaOlpAeR6/dAuLIcV23wVuMkotZHZuRNHZYnuBcaDujgFvULH6cb1lHHYcECiCGgGhjN+IoQcNK27NstSJ2X3dGNIpIrm8j0aDRtNEYoT6Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXyVI2jY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595B4C4CEE3;
	Mon,  7 Jul 2025 11:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751886568;
	bh=mdQufwooJGuRjPwQ0ZE4RMjhFcUOFMDbayVEM+4VCiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pXyVI2jYRJppQhucU+MPEF/FzN2Q8sX6klKv/GgHk1AcvE1PhVWtWBmbZnp/wTKUa
	 ZwT32HGPMQP6xQ+py63nVrwQDZjiFDTT1ULRVmG75e3cP3HaPARwL2S9+GoCRPwi0G
	 yxj0s7mjA9OW8ohhtjreXLCuTAugHtZuWhleM4NoIMYCNQNTgFlxakxcUFjXN+Vh38
	 eShCC6k2aX7XA39nVI5Uwzg1w5wL4V9S2UyohVLPbPqqFI+NMSYsuDiDL+lsM/2WML
	 gi1YaqgDtkBsmjqzAqcybMssd99KVYQsxZCInXOnu1oA16V6ZpapxHMBLYK+fMnAJE
	 5BqVqdlWl4OAA==
Date: Mon, 7 Jul 2025 12:09:23 +0100
From: Simon Horman <horms@kernel.org>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, saeedm@nvidia.com,
	gal@nvidia.com, leonro@nvidia.com, tariqt@nvidia.com,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next v3 08/10] net/mlx5: HWS, Rearrange to prevent
 forward declaration
Message-ID: <20250707110923.GJ89747@horms.kernel.org>
References: <20250703185431.445571-1-mbloch@nvidia.com>
 <20250703185431.445571-9-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703185431.445571-9-mbloch@nvidia.com>

On Thu, Jul 03, 2025 at 09:54:29PM +0300, Mark Bloch wrote:
> From: Yevgeny Kliteynik <kliteyn@nvidia.com>
> 
> As a preparation for the following patch that will add support
> for shrinking empty matchers, rearrange the code to prevent
> forward declaration of functions.
> 
> Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


