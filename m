Return-Path: <linux-kernel+bounces-886994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D928EC36FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8958418C24A2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696C1338F26;
	Wed,  5 Nov 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gI9h6sbT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC1248F73
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362153; cv=none; b=Gq439m21HlKeKmsPCC7Z3TKeA4PFF0qSbAUylHd+5hvUPyPZdT20gJpABIVHUZh+SOhN2oKnVbHT+m125KN4tcAl9WkAqf+RyLKS4DHfKmDOXXRvBxJoAhtEltX0MFiiJfXuWyY//WdrPK+bnmk91dpF0A1hIrIaHOA3vvZFW4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362153; c=relaxed/simple;
	bh=nDQxQG1MsN22dnDpF9b5ijOo8LpXpq2wAo2KpACbXN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UK5/6Qs3cKZb+VWAnDWeDdBqKJ3FsYImbgnItcNMT+lt5Iqs/2pa0iIJoz4gqlm/DVq8sgFiZvw3Y3x5JXK52y3CEVHxT+FYr9WvAfYIT/xniH1XxV9dgWe0sSWKU7gfgfGEhttKrMM8CdItXoaarEP/qFqYsKQ8osL1cqAY7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gI9h6sbT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BCFC4CEF5;
	Wed,  5 Nov 2025 17:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762362153;
	bh=nDQxQG1MsN22dnDpF9b5ijOo8LpXpq2wAo2KpACbXN4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gI9h6sbT0HytQ8NVUpbxDxF4zg+cXOBuE+Nq+cI0Fp5qawbLEePFwPnDLKdQofC6L
	 cu2c0i1eOFpH1sMp8kSfFj9rNE0u/g5rbXEmUgRGRsvHSD7i/2l/dDA+DFgfJ4fvDf
	 nJK8a904bGuzaAVdbL/GZIHXseGN+s9NsgAP8KDQV3OCNe9CFq2sC+zgg81a8hjxZP
	 KbG5Tn6R5NmU1GXPI3ZReR4jhZ2JwHlHaREbxdfFUB61b7S7fvfRXLQRaFan7vcvDL
	 wY2NZl1xxCFhwr5D9MjRHBoQ8jh9ChpHQMxkZAXfbksyzxts51EnKdIMzNskCNtpzI
	 J3M8rPj3ld+iw==
From: Srinivas Kandagatla <srini@kernel.org>
To: lee@kernel.org, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20251103232942.410386-1-heiko@sntech.de>
References: <20251103232942.410386-1-heiko@sntech.de>
Subject: Re: (subset) [PATCH v4 0/2] qnap-mcu: add nvmem subdevice to read
 the eeprom
Message-Id: <176236214930.37998.6223370598511994293.b4-ty@kernel.org>
Date: Wed, 05 Nov 2025 17:02:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 04 Nov 2025 00:29:40 +0100, Heiko Stuebner wrote:
> The qnap-mcu is firmware running on a Weltrend WT61P803 MCU and there is
> an eeprom connected to it, that can be read via the serial interface.
> 
> The eeprom is somewhat important, as it contains for example the
> assigned mac address for the rk3568's gmac interface on TSx33 devices.
> 
> So add a nvmem driver for it and hook it into the mfd.
> 
> [...]

Applied, thanks!

[1/2] nvmem: Add driver for the eeprom in qnap-mcu controllers
      commit: 0cf064be87a6ae0708f171c6b863b26ba9453054

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


