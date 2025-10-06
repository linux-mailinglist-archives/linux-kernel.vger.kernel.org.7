Return-Path: <linux-kernel+bounces-843280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D22BBED40
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11134189AAA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C6524677C;
	Mon,  6 Oct 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CaMM2Bp4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE2221F1A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772312; cv=none; b=J0ykOpw5aGm7a3/UFMuAhQC/PdeRG/D5e2UbwDlhP0+936cAjwfDR2916l0Ue61SJFcNVsmxB3492AuikwfGFD+NwYx6RihXj6CtM+4hOE8GyD3DA0kptBfz4c5Xp9K9AgkwRj9zVJQ/hZe7zgdZcbZnmgGEvckohv6jgcFQ1QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772312; c=relaxed/simple;
	bh=Oh5hYDV0H1cKbRUiUHONhkC9FY9iVP3YY0oPxwsBdMI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uf8BZ+n9hsr0ZeqIVPhV5CharhpmokCR7oQvLQYxXRqdrRSmQl9dGMDbMPcZ97RNUIUPZhfmY/vn832Rc0JE4LQWyPw0Lje+uNaB8y+YPQ+E4owylXWkJibhNDywEQLxTf+OPWQnqF18/ONq1t2qFypeYVHZtkq1OPPeM39kEV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CaMM2Bp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AABC4CEF5;
	Mon,  6 Oct 2025 17:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759772311;
	bh=Oh5hYDV0H1cKbRUiUHONhkC9FY9iVP3YY0oPxwsBdMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CaMM2Bp4ZCv2x9Fo5TLYVRrIE3hX9Fok+hS6qRPyS5xmGVS41P7I9IJyINiIP7Kwb
	 rPDvNWxTL/QHGz+th1u35DFigkcVBI+0l4XU23C2J7nPHw79Gsq135TRfjJWJLlJQw
	 e1QnXx5wQP5um2OM5rtymErODY17epMWYZEn4LK6YYmo7fIi8zo4Bz78OnL3MwNm3Q
	 fEh0uZOGBznYqxIatKRHOOyVlDKhII+lMD8oxThiOQUvS8626tJVJImSgVwkl5G2ps
	 +j/sZ8lMo+uHy/OAhrK4n9hKqRP9yM8VdSvvvo+rvI7XYWCGoWZAaHNjAqJq5pWIQ8
	 1/ZHAgZ+Rih9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE00239D0C1A;
	Mon,  6 Oct 2025 17:38:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs for 6.18-rc1
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <175977230150.1449062.13164485414655381958.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 17:38:21 +0000
References: <aOAOS864BmSwjfGm@google.com>
In-Reply-To: <aOAOS864BmSwjfGm@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 3 Oct 2025 17:56:27 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs for 6.18-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/86d563ac5fb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



