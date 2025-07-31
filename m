Return-Path: <linux-kernel+bounces-751955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749AB16FD8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8F15834DB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856622BDC21;
	Thu, 31 Jul 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJK54FxZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB71D29CB58;
	Thu, 31 Jul 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959089; cv=none; b=miz5IU5nd3KIkQ+fv9Iu6vSt3KFxdzAYY4qA+ae8lPWbuHtn26FqQZcKUBSThH+/s4Az73NokahcPlMtveHl+4JSjGJTxCfz+ax7/3RO5L6saGcttksBOegwKh+8wfDbqT8lRevsy+qGJr5mUx1uBGXflpYqaBcGUOXArMbM4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959089; c=relaxed/simple;
	bh=MjoZxdOgo5zg/CJrXb1V39rhScwHwbsZTguPE3FT+gU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W1FXS8vYhsPTUw+PI3xGbNTRsk+P3b1C0r+ZlsxkjNmqEH0J7J+h0exlErhCDiMVN4d9OQuspr086+2EDsZrd+YP1W7JhEgoT1iWXmMjhEvJpm6915p3zungVAd5eLvE0jyJ+XVo2gw59IQePhEx0XnajJx8+NKe6HPgoJWjjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJK54FxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF11C4CEEF;
	Thu, 31 Jul 2025 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753959089;
	bh=MjoZxdOgo5zg/CJrXb1V39rhScwHwbsZTguPE3FT+gU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sJK54FxZtU60M0h//bJDUl4paT3bh6adXr7OBCsv+IlZceNVoCHlFnxh/Hdm+I7HY
	 9g0cQm6RLAgXbXyZM0DSmzohYqYVIVFCJNr13R957S3M/KmzSjplT16b2tG7CaSN6K
	 Jj5wcdkFyApsAR54OWCTD86XZ+pRMerDttrVNmlLb1sz/LPpChZiSetJVjKuFLlARv
	 IOMxiL8JB/MBMmOSfKhxQ7JSPz8lB9wANkqe9C0uRjoCJ2Fv1BJwPIiF7DQ7uytkdz
	 DRhPmkrfZ5qLQwQ++4xqWztavVNoppJiyClCqnTM/b45sMKaKAIw5ypWubAASzxCAL
	 OQ4kqhsQOZn+A==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250724111459.141633-1-colin.i.king@gmail.com>
References: <20250724111459.141633-1-colin.i.king@gmail.com>
Subject: Re: (subset) [PATCH][next] mfd: Kconfig: Fix spelling mistake
 "infontainment" -> "infotainment"
Message-Id: <175395908833.1127126.8459062166775806188.b4-ty@kernel.org>
Date: Thu, 31 Jul 2025 11:51:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Thu, 24 Jul 2025 12:14:59 +0100, Colin Ian King wrote:
> There is a spelling mistake in the MFD_TIMBERDALE description. Fix it.
> 
> 

Applied, thanks!

[1/1] mfd: Kconfig: Fix spelling mistake "infontainment" -> "infotainment"
      commit: 8ad962e1d31f1df12678909f5455c541f9ec4024

--
Lee Jones [李琼斯]


