Return-Path: <linux-kernel+bounces-862705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE55BF5F22
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADB874F2E96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C482F25F3;
	Tue, 21 Oct 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+ea1Ut7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8AF134AB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761044704; cv=none; b=mj5W/frPbs4s3w/Y4A1kGDtJba7PUAWEMEEyCurKb39iwbmf7nxmpGrzNdjNvhN5QdmJGqB5bZOrI524hdCqY4gSb+4VXiulMkj3X0TTGDro5oL9q7ppI7uzN2s+w4/Cf2/ooHyr8cIox459Jd2oQT2dokaWr43hm1NfiILx+lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761044704; c=relaxed/simple;
	bh=BxadSGC2F1Ff6lv20T7r85txG53GNtpdDVx7vnZ1LDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oLktPETCv0thiERhg0HapV0idWCAp1qOfnyWQOvjKIiKh1s5/zTTG2iRWwLB2CzGfCY4Drkj3u1ql8Q2BnSgVv5Kdc2wzry/yqs8Rp+ggu2VhFMngLZdJIiO46J1yxRNHp21bJWGv1YLrLhykSO2CVs2dY1I3u7VpZM7c3QANJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+ea1Ut7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1770C4CEFD;
	Tue, 21 Oct 2025 11:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761044704;
	bh=BxadSGC2F1Ff6lv20T7r85txG53GNtpdDVx7vnZ1LDc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K+ea1Ut7YNqWm5oaxF9rUktpKMXsfDz/7+VnHQi2OeCTUdOLPVrVo+ydYF/SXy/5D
	 RCLcdNZwUSTP0rTaqQVYQ8oEl6yejOr7L+CNzRmArX6DMTGtwAVIm+sipI72EGeBBj
	 a8wgA67C7Bh257/2ic1TzCpzKHsdA+nmjI8oMxeMRtIKk1NzZndXJ5m9nA3b0jppvD
	 2LDQ1oH+Ls7EsVz/WVfSz7dNFcRSg/Wvuk82CPcoSbMOs8x8TnZUBvhheS8DUau0N1
	 Sm33jRIQpZFpbZNc4TH6oVNU3yWslaaIHYsBH1YiT1MLqBI1TB8B9gZIGiPNIvmDQq
	 z9l38ynKSUNEA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org
In-Reply-To: <20251007095424.138878-1-matthias.schiffer@ew.tq-group.com>
References: <20251007095424.138878-1-matthias.schiffer@ew.tq-group.com>
Subject: Re: (subset) [PATCH] mfd: tqmx86: add board definitions for
 TQMxCU1-HPCM and TQMxCU2-HPCM
Message-Id: <176104470354.1195155.2342145197046335984.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 12:05:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Tue, 07 Oct 2025 11:54:24 +0200, Matthias Schiffer wrote:
> This adds support for 2 new TQMx86 COMs:
> 
> - TQMxCU1-HPCM (COM-HPC Mini Module with Intel Core Ultra Processors [1])
> - TQMxCU2-HPCM (in development)
> 
> [1] https://www.tq-group.com/en/products/tq-embedded/x86-architecture/tqmxcu1-hpcm/
> 
> [...]

Applied, thanks!

[1/1] mfd: tqmx86: add board definitions for TQMxCU1-HPCM and TQMxCU2-HPCM
      commit: b8617ce7ee161845040b76a31fdd427d03c7afd2

--
Lee Jones [李琼斯]


