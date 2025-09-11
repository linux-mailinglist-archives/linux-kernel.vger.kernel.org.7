Return-Path: <linux-kernel+bounces-812354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98BB536D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2065166F40
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B7343D76;
	Thu, 11 Sep 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6C2/l3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A28032A82D;
	Thu, 11 Sep 2025 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602948; cv=none; b=K30ojacZABb16nzAFVDg4N47USKM0kRlp0rFFzQUBkqcihDd4gVqb+9ZlpUmgguuqAv7cR7cj5dbTtPB8pLdl/Fjqx2MLwzPmgXA0MMbfmqOTkBmOl6eZ8QbIFCThjFScxEftQitH9ibXKy4XBajlegfcnupXbe1c7bZENlKFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602948; c=relaxed/simple;
	bh=76CftYET9y/GeZqWboDnlaeHAAr9g/hu7CkzJ2AoGEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ianxX/PJTr36EUCkBunwNsk5j2L54CcLWCtbf7pufFrXDTk+5CKwP7MXHTd1C/c70Iw298Uyp7D1CDrNpQaz4JF3xv14UplQP7NOn0UmRhdRkW0W/KzLGJpnD8EbZn3jmcTje9T7SGWV/w7h3CcxQuYdKHglL+f0in5MhXG7M/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6C2/l3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDADC4CEF5;
	Thu, 11 Sep 2025 15:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757602948;
	bh=76CftYET9y/GeZqWboDnlaeHAAr9g/hu7CkzJ2AoGEY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J6C2/l3csggr65x95Ol5GboM2FLk2QqcEo9MICGB/WKUFlDww8/X98FevyHjWhiL8
	 iMSkCQ0xLt1C15hynwQm0U6lznM+AYCvXZutkQzwbkaAq/2uHpUfZQ53YaDrkTNOgA
	 ALR/uMMFmTGNLx4FfBpE1ZZdUfmvtyCV/rGsWybjkLVDiWFdCaECkymxZ3xffQHVUp
	 7r+7l7dXjywW5KEP1wjlmq7AJCGuklQPsYm/JYjxK+3wEkhU1Ls0jkSw+Tv1MGFX9Z
	 LwxIN3HVDsurQNO3AfoHh6lQ5ray5XfUbbZyTUwnYgEtIX4a4CXgFKbKiM2ABMEqRz
	 xJabHoHHMKmaw==
From: Lee Jones <lee@kernel.org>
To: broonie@kernel.org, lee@kernel.org, 
 Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
References: <20250903094549.271068-1-ckeepax@opensource.cirrus.com>
Subject: Re: (subset) [PATCH 0/6] Improve cs42l43 suspend/IRQ interactions
Message-Id: <175760294630.1590509.18226068089141441889.b4-ty@kernel.org>
Date: Thu, 11 Sep 2025 16:02:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Wed, 03 Sep 2025 10:45:43 +0100, Charles Keepax wrote:
> cs42l43 uses pm_runtime_force_suspend() during system suspend, however
> this means care must be taken that IRQ handler code isn't running when
> entering system suspend as force suspend will ignore that the handler
> is holding a pm reference. Typically the result of this is just a few
> error messages, but better to improve the handling and ensure that all
> IRQ processing is synchronised in before system suspend.
> 
> [...]

Applied, thanks!

[5/6] mfd: cs42l43: Move IRQ enable/disable to encompass force suspend
      commit: b3f893e969b6e8bb80bb2307c509ef1619e1c3fa
[6/6] mfd: cs42l43: Remove IRQ masking in suspend
      commit: d614c669a205f39ca8be545d5d829a6b9f3cf61c

--
Lee Jones [李琼斯]


