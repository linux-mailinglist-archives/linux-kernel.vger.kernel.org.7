Return-Path: <linux-kernel+bounces-765932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E408FB24036
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 07:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90CDB625B86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CF42BE640;
	Wed, 13 Aug 2025 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXWYzETY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A19242D74;
	Wed, 13 Aug 2025 05:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755063202; cv=none; b=BEipH2MPfvTmbPkn4Gcoy586fPF8LxVZ9e4a6gLkiSOq7jTRCR9+f8Y1D00iEVg2o5A0HFUAy0mW+yc/mtmJn901SG3vvQrGs+bPYeBBSFG273lH4BjWj5MU2J8O0mK9oU56PBefD92jMSmwWjpe5T9HvEOyQ571tNIYib2sVzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755063202; c=relaxed/simple;
	bh=SQBB+QuUHQ1WK+SyPt+Tm0tHTtKC0fjHu1V5AzSo2Dc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E7xgGY8/RxgxHctiwygzNZNQhrYA9MjTkYc1GE2PAB5n+MmGSIerfohgAqXWs3yxFsHFbclbqJd1mjPCrxDjr6A+yI+pvnkUdJdLKGMoAwJBe3gaEvi/Z64Vv/kPl64x3UtK8mBbijEGkgG78rgtEmfZPbyWnQiiTUHuWEE0AZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXWYzETY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5A0C4CEEB;
	Wed, 13 Aug 2025 05:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755063200;
	bh=SQBB+QuUHQ1WK+SyPt+Tm0tHTtKC0fjHu1V5AzSo2Dc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WXWYzETYtyVTbS+6jw3ig8Jg4izOU3AzTb1vxENfqDwjFC7caZVy1NbSDCnPFYjoF
	 dIegtibAh7/9wIcfgd4mdvrngkSa42WlCaV1Tbri6p9VC+Fzk8w+9TFlNCRwTGO/ZH
	 Boj+8UB/FyjvMkTYJwTl+oGKzP7Ct5oFJmqX0hueRsqjpDeackJjtfa+8sAnLcpMwG
	 KpnSdvMMs8lbZN3Yqds11J/ukeDaxk5EpUfN2ZtDPt+qy1jzdPutW+KKatuvOaF5rb
	 A6pTZALHITKaJYxJTE+poZ4yzTEA2rXTnJQalVfgL8bxbb5J8qo8c0KVeGLeKfO7HD
	 5UURnsGuSl0jQ==
From: Vinod Koul <vkoul@kernel.org>
To: vinod.koul@linaro.org, shumingf@realtek.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 flove@realtek.com, oder_chiou@realtek.com, jack.yu@realtek.com, 
 derek.fang@realtek.com
In-Reply-To: <20250725101100.1106673-1-shumingf@realtek.com>
References: <20250725101100.1106673-1-shumingf@realtek.com>
Subject: Re: [PATCH] soundwire: debugfs: add SCP_SDCA_IntStatX and
 SCP_SDCA_IntMaskX registers
Message-Id: <175506319789.649283.14444520276823005932.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 11:03:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 25 Jul 2025 18:11:00 +0800, shumingf@realtek.com wrote:
> This patch added SCP_SDCA_IntStatX and SCP_SDCA_IntMaskX registers.
> 
> 

Applied, thanks!

[1/1] soundwire: debugfs: add SCP_SDCA_IntStatX and SCP_SDCA_IntMaskX registers
      commit: 8b63fee9f62361a7d96394611ba05734ec21e2eb

Best regards,
-- 
~Vinod



