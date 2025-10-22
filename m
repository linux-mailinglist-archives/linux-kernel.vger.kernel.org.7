Return-Path: <linux-kernel+bounces-865154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FBFBFC5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CE56E060C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38CF34887F;
	Wed, 22 Oct 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWyr7Hjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EE9347FC2;
	Wed, 22 Oct 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761141030; cv=none; b=bJk5TKmfleLspugxyI1oChJXyjwCw2NaHG/dCEO2v+Z2pQeR74TkXHDk02KBdf7ixfXKQP1TzZD2puaMOXEawsnQQmOBUpwqzuxtQ/V1F9B8XXFeOwVk1v4jBfoufPLfBHWZsGqv0Tu2ykXT5I6zAK2wn3fY/GEBhtgcpOEobFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761141030; c=relaxed/simple;
	bh=4q54NyL9BUJnCJ65isVEm3uQJQT5pbbLzT96h2CIzbw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VckuzHjQDUrCePBhwHyy9qgyXjhtqPRcNnzX+PgR9V62nLqj56XwTFnYZZE1GzQ9++UTyLMRwzHLg4eGK98cTjLfo84DKJmDue+cULA413mT4ajuqkr9XcIEHKwUg++PP30iHkemjJAXO5JrtWOLv0WQJmgBlVBs9JEXOemWLrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWyr7Hjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B374BC4CEF5;
	Wed, 22 Oct 2025 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761141029;
	bh=4q54NyL9BUJnCJ65isVEm3uQJQT5pbbLzT96h2CIzbw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YWyr7Hjk0uAHY3sKgeXvhwKG78pVsDenMZJcSGrxmKJcRnZCRIkd6++4oqzQJAbbx
	 KK41fh3yO45kfrWgUNrtmTd06QE6VuaUkGNVaAUvMDCMUY9ShTTpD8qMF6EIoS8Ua/
	 olWILwGewGyr6ekC3JWRnr0imSo+sD2kkLd3Ba1814l2ajdhJ/0LnNmr5R7tqRxZww
	 SbDGOW0FEfwEGeXI02aq6+ur8wH3bbOtevxz4EGCcAPhoxLxxf8WQZeV8c5pcxxFm3
	 umNYMM/F1NSelhlBumeT3jTrelaU3vt3wuFhYIn4F1TlLqtmlotnFJQlYtgBX02i0Y
	 A7zZjnBm+OU1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE133A78A5D;
	Wed, 22 Oct 2025 13:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 RESEND 0/2] Add two new ID for MediaTek's Bluetooth
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176114101049.1909224.7135864082942324713.git-patchwork-notify@kernel.org>
Date: Wed, 22 Oct 2025 13:50:10 +0000
References: <20251015033150.498866-1-chris.lu@mediatek.com>
In-Reply-To: <20251015033150.498866-1-chris.lu@mediatek.com>
To: Chris Lu <chris.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, will-cy.Lee@mediatek.com, ss.wu@mediatek.com,
 steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Oct 2025 11:31:48 +0800 you wrote:
> In response to the customer's request, add the following two
> VID/PID to the USB driver table so that btusb driver can support
> the corresponding MT7920/MT7922 modules.
> 
> 1. VID/PID 0489/e135 for MT7920
> 2. VID/PID 0489/e170 for MT7922
> 
> [...]

Here is the summary with links:
  - [v2,RESEND,1/2] Bluetooth: btusb: MT7920: Add VID/PID 0489/e135
    https://git.kernel.org/bluetooth/bluetooth-next/c/bb9da27b29d0
  - [v2,RESEND,2/2] Bluetooth: btusb: MT7922: Add VID/PID 0489/e170
    https://git.kernel.org/bluetooth/bluetooth-next/c/042b9b4c55c7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



