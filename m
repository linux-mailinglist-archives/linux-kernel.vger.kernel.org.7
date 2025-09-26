Return-Path: <linux-kernel+bounces-834275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF265BA4520
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2671C037D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF621F9F47;
	Fri, 26 Sep 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMUiONk7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B91F419A;
	Fri, 26 Sep 2025 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898778; cv=none; b=EGnfLV/5Ult0h16gZZ0QbnTKsjou6iXM1JaId8ZTs+2wA8YAf8gyEGmDMntA13gLXa98BgPe+NM8ydnha2e5UiPo0YJDcmBiM8+508qcDFE2/LpEfu3bViCZIk9dqHxhaNTNIlG0BGXsbjRXS/9IiNcxtfFGug5c96pMsRpKOmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898778; c=relaxed/simple;
	bh=7dxgN7NeLEQ/7j39HKCLIeMvAf2J3M2y7izUrZX/pVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LUASu4bCuXDqoLBiOBoy/yTwOD/hNvrlogkLmD6EBUZ8LrWr7B+5HhJ6+0wtb9/RbkxBGQNFwiB5/PIKhhD47BKyxg3SRVTiM/mEl8DxVdcBSqm4qujdEm47gnJh8P5vhnMe/DZNEdxjXwEdtxJYQFnKIRSOFhgT8N5IneoMT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMUiONk7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F8AC4CEF4;
	Fri, 26 Sep 2025 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758898777;
	bh=7dxgN7NeLEQ/7j39HKCLIeMvAf2J3M2y7izUrZX/pVg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dMUiONk7NKWagQqnnUzQN+lUuU7YUz5xsQdfpUVebuCu1jcmvOHZscBrcdN8NNzB0
	 XJf0SYV78Stf2LrozRx0S5nhPkLneVXWL7hpUisFuSrt+do1AfUSSRrgCPwqpZDj+T
	 od1xP7f7EFggpR6EwQDznyrRJbF4633pRVQyK1bqVpIkEd6lZEEFm+112f8qI0FXxS
	 hCZOWBTCl4xtdr3cJ7CxH2+RaLqApSSWgcKkRerNOd/s6tzI6g04JDAsMKgN15fp7d
	 jyLNziv0CNo48NL8vi4p6xVdUXVbh7WgjiaYiaSbZOK1GYQ4L0lpVaKEYJZs7tveay
	 iLgPd7LlC6bPQ==
From: Daniel Thompson <danielt@kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, 
 kgdb-bugreport@lists.sourceforge.net, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250507104337.201695-1-colin.i.king@gmail.com>
References: <20250507104337.201695-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] kdb: remove redundant check for scancode 0xe0
Message-Id: <175889877637.8040.5055145066289975102.b4-ty@kernel.org>
Date: Fri, 26 Sep 2025 15:59:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 07 May 2025 11:43:37 +0100, Colin Ian King wrote:
> The check for scancode 0xe0 is always false because earlier on
> the scan code is masked with 0x7f so there are never going to
> be values greater than 0x7f. Remove the redundant check.
> 
> 

Applied, thanks!

[1/1] kdb: remove redundant check for scancode 0xe0
      commit: fdbdd0ccb30af18d3b29e714ac8d5ab6163279e0

Best regards,
-- 
Daniel Thompson (RISCstar) <danielt@kernel.org>


