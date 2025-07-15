Return-Path: <linux-kernel+bounces-732149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E66A4B062BC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9FC4A4E66
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4F9244693;
	Tue, 15 Jul 2025 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOS/GGQl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7322DA1F;
	Tue, 15 Jul 2025 15:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592720; cv=none; b=iWIRQgYJDPwKlXEPxc7U70Z6cZ0S8bJeVEeiLUNRFME5KY4AkIGnfWXWriSeui7mrKmllq/RKsVLND7sHfpQ8afSwbSfMz1ptLznzcpBUxuPg7N/7lefrjP5PY6cCAAOtY4pKCPVInRffiY6SBadJvY9bojS5Y3B8k8vJOYNctA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592720; c=relaxed/simple;
	bh=q9VBgZoVnvlYmzkNOY4MseIlWIGaQ1fU9AXJh1oGUOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lVs0q4T+bGPH8ThVIv/DHn5j9ECLBNBTXtLMau6rF20S7BUB8mARgzUWRh8rJvNm9HCvjBVR9hDZCO1MPoSYpZG8nAyRTrSeEglBiOQmGBd2+KchjRHQD90zF9DryS+44jG5M2GUNOmvZ4nmNPS7VE+Yi3SUYqtDIbPUrpMnepw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOS/GGQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C258C4CEE3;
	Tue, 15 Jul 2025 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752592719;
	bh=q9VBgZoVnvlYmzkNOY4MseIlWIGaQ1fU9AXJh1oGUOA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HOS/GGQlPyAUoJj8L470mRd2H5zQAJXW0edmGkkNbJMdPOLp5gh0pP1350jq0Jj5i
	 7HoEF3kQtAJUnDMRpIW8GLNJh5nXNZoUKznaV9BAvQLtkykzLrB0M+Wydxzi3w9NdA
	 ZoNvi/ywXtEFGnvQBuwUEOYc+k+BoPTeMJL6s5n/YwuHZN8sCHR9wtz+plaKC2FaN2
	 9592FrqDGXpwjqS0vlJW28RD5cyL3vKj89Zj9lfYm31xCyoDL+zU5n76mT8eXZkzPL
	 v8fvS1pZDHat338e2mhdHUWLdyejwpVEXFK+n1YVWGtcJRf7+7vpgNXXo9haH7amsr
	 i9fb6JfJuw6MA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, 
 error27@gmail.com
In-Reply-To: <20250710172403.2593193-1-harshit.m.mogalapalli@oracle.com>
References: <20250710172403.2593193-1-harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] phy: qcom: fix error code in snps_eusb2_hsphy_probe()
Message-Id: <175259271714.535271.17010232009134065105.b4-ty@kernel.org>
Date: Tue, 15 Jul 2025 20:48:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 10 Jul 2025 10:24:02 -0700, Harshit Mogalapalli wrote:
> When phy->ref_clk is NULL PTR_ERR(NULL) will be a success. Fix this by
> using -ENOENT when phy->ref_clk is NULL instead.
> 
> 

Applied, thanks!

[1/1] phy: qcom: fix error code in snps_eusb2_hsphy_probe()
      commit: b7acfeab8af9ee661c933522132f3d1d92ed12d6

Best regards,
-- 
~Vinod



