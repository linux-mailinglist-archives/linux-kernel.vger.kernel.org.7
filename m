Return-Path: <linux-kernel+bounces-812424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8070B537FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038D81C80499
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505C5343D7A;
	Thu, 11 Sep 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJOIP2zN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9CE1DBB3A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605141; cv=none; b=SD0Ykw+QB8I6sVT47Et3I5Wr2MtBazTPK5t0VXZVobMeK9z+Hq9cDJKCTeuznOtSt6isrr7ZM/J22LaBs4OL/uK5M67GTGxT6exbPEDwtxgVqZYftYvE8xNumSxYhfks5uV0uoB1jjajb9IGF3U8ijW58IIsBEc6AxnsBts7qM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605141; c=relaxed/simple;
	bh=nCsf494lbrsFwdRnPXvDG/WSQ2rBD02adUSqbVnfi0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tl65/GRLESkR5P5nbHvaGD3cVWqbX06XqeH2Z8yuIqKH5VrTCytF3hS3dezaz6/Bg5KPPPp1/m1GLROGmcTT+hBuEUufaSowgueB24BEzyVAAdbNmW0G6Eav+DJMFMSCvtpx+kOLCHjEEszgzyw/gkWIVhGJwS75A6Y9xLxtYeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJOIP2zN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261E3C4CEF0;
	Thu, 11 Sep 2025 15:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757605141;
	bh=nCsf494lbrsFwdRnPXvDG/WSQ2rBD02adUSqbVnfi0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rJOIP2zNocRC/k2NSk0pbZq3vIAN+w3DaImpOaNjggbVQGIgDlXhAoQoN2mocSA3z
	 tJnoM7fHdhFe2js7PupbnI+yHpXexG+8+t7DxlmZ0HI9ey6yd8NW7yDS6DcQ59HW2O
	 SFKqo4Lqljthybbop6rZHSzwjsHVn4vVY2u5WJJgotC3kt7Xrvw+6MKjq0SilNw4Xs
	 Xvnvn5K6ASdZnTa19yKCu0pWCtS/SbyPWdJIGeCoeYFDJpqYgcIzADib5j7mAd2MY6
	 isOLhF/Dx3vqenfo3308T48DDpRBWd4LqROtUY8Q79Y7upUaPJcnFMHDx6oe9oS/Ed
	 gZhBiB7eF0xtA==
From: Lee Jones <lee@kernel.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250907-max77705-fix_interrupt_handling-v2-1-79b86662f983@gmail.com>
References: <20250907-max77705-fix_interrupt_handling-v2-1-79b86662f983@gmail.com>
Subject: Re: (subset) [PATCH v2] mfd: max77705: rework interrupts
Message-Id: <175760513990.1627985.1771345684666137279.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 16:38:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Sun, 07 Sep 2025 13:39:56 +0300, Dzmitry Sankouski wrote:
> Current implementation describes only MFD's own topsys interrupts.
> However, max77705 has a register which indicates interrupt source, i.e.
> it acts as an interrupt controller. There's 4 interrupt sources in
> max77705: topsys, charger, fuelgauge, usb type-c manager.
> 
> Setup max77705 MFD parent as an interrupt controller. Delete topsys
> interrupts because currently unused.
> 
> [...]

Applied, thanks!

[1/1] mfd: max77705: rework interrupts
      commit: f890f771be68c1e7da422835a8295dff9f4d2d61

--
Lee Jones [李琼斯]


