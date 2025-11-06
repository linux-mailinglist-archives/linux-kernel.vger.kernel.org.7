Return-Path: <linux-kernel+bounces-888729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9DAC3BCB2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13EE3AE0F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007533BBB9;
	Thu,  6 Nov 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmAs4SUI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5322E32E6B6;
	Thu,  6 Nov 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439522; cv=none; b=Bi7BJ6zPok551YV6wMmZpYjfGMettXeQi3Bm7HiIDCEpNoPWL+2GXeAVps7ephBw+VmufQwBhE6mamnqWs9/W9B23hGG9HmR+017a2Y7XsWW1vu85osZR+FV/dKER1FFWQ1iyRvnw9wwMQcGw40N90VWrrbN9sH6FNpsvNlZvGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439522; c=relaxed/simple;
	bh=JGUYC4+gcMsKU3qtcGUGOQeUoOnSuVvjAJ+OKcr6/0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rVq/UdeHvUmay8sgZ8Hn+4Ovs40dNN00DIvp1JSvL0c4CCRBkZRMbHpEp1GmVbHaz2fW6/0XDEpGuu7CYshO7bglN9FlTJ7IjtAJWm7B4qBzOtG58kiXbKTIXTy9ForOsp4ERzlyjm6ray+xxGr9hXaF4zxvWtDHUTeGVIlI1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmAs4SUI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E293C116D0;
	Thu,  6 Nov 2025 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762439521;
	bh=JGUYC4+gcMsKU3qtcGUGOQeUoOnSuVvjAJ+OKcr6/0c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gmAs4SUI0+9cMa8SNHmeFaF8ncEcN+3Rqe3r8/BD9Nw8wMR+HNphwhWyH0UqUEDc3
	 nNP7ncao+RL/kiPck9D3Wg1qnaiHhwLxSNAQQcmHvAKgu50Kd3F3dZvnkGNaSu5Q1v
	 juMduuxemeRwCMWSJbe7qqemHnKSCkCBIXGKvd87tkJ+p7OTOWeGmXUxNohuQmk+c5
	 M0392fqNgqOSkPGIynIb5X0jfuLwNqgYtpVpDQEWdudysDUrw00XXnks//2tr/r7p7
	 YJB8j9nyiPgXfcJqAJruiNV4+rsSWLXnAh9gnCg5I5DgtTMcCznZOXHklC+g29XDtz
	 mOOJrNzK/blIQ==
From: Lee Jones <lee@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <871f52e7ab5d12853bc39f36ac78b5a8e484d863.1761391599.git.christophe.jaillet@wanadoo.fr>
References: <871f52e7ab5d12853bc39f36ac78b5a8e484d863.1761391599.git.christophe.jaillet@wanadoo.fr>
Subject: Re: (subset) [PATCH] mfd: da9055: Simplify the error handling path
 in da9055_device_init()
Message-Id: <176243952026.1877393.7368996860439286431.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 14:32:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Sat, 25 Oct 2025 13:27:16 +0200, Christophe JAILLET wrote:
> If mfd_add_devices() fails, there is no need to call mfd_remove_devices().
> The needed clean-up is already done in the error handling path of
> mfd_add_devices().
> 
> So, remove the unneeded (and harmless) call.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: da9055: Simplify the error handling path in da9055_device_init()
      commit: 049929c5a159c8671b9b0c12a7da963fef535b00

--
Lee Jones [李琼斯]


