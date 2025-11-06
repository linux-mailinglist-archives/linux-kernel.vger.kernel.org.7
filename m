Return-Path: <linux-kernel+bounces-888910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E522C3C3AF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CF5CE348350
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84803314CB;
	Thu,  6 Nov 2025 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+PFkdrL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA534B419
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444966; cv=none; b=edNHUnn2sLTriFhSu3kYFHq+ffgfuEWGcqyJkaqa7XXtDgFe581ODo3bmXL+kjU7ylG3REIoOs5HEZ+Bt8i15B3FU6fIhYA6c2GR24aEwvtzJrkWtA8AUbOLtcEy5Bf1c/9zQtdkJJiHyAwSvmadiUA4vrdsZsr+xlUN2ExS5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444966; c=relaxed/simple;
	bh=w6HePfwtKjb+QN59gloUQ2lk3XTFx2xaQ9QVJDZLtJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iqz1A0HzDloDBMe64OHtYaTChiU9IAIoHXDybTxv73VdPpB+xZj+VOJFbwN4l8/C745VmlleEHkmP+D4YsMiayUZDj7RjvGakfCsI53DivKW2414AGPkKe4HYH+WiQ9Ld1v7q5/TWv08NDKSPISkSShwa68xn66vEAe1czoS+ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+PFkdrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D058FC4CEFB;
	Thu,  6 Nov 2025 16:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762444965;
	bh=w6HePfwtKjb+QN59gloUQ2lk3XTFx2xaQ9QVJDZLtJA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g+PFkdrLQjTiTAiS97btSjvgSgVsZMGMwRq2q3s6gfKkouCaqWuojNAXWgDbeNDt8
	 qK25HoqX4a2ETXJKCFOMG/XJiGTeqxBjMZQHeJEa1CfKuydhFnDJVwif1DsddYL3QH
	 DXVX5x9u3DwrVZmYPnmLJ/YKZwIZjWGrQZh397lF1ZB42OOywvZGu/oQ2cWgIXUXtF
	 RVHXiiXbLHHA952pM8ByydRdljoaq8/wF45t7zJyePuc75CkMn8C79dfTIZvm89LeR
	 zj6V2sNKZgogFgNW7KDiBlCen8Zer+GGuWWTLEjbu/Cior5P2wfYXWrqqvo7xFDeNH
	 vR6My7JAj7Slg==
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <aP9hlpRO-0vmEHBZ@mva-rohm>
References: <aP9hlpRO-0vmEHBZ@mva-rohm>
Subject: Re: (subset) [PATCH] mfd: bd718x7: Use regmap_reg_range()
Message-Id: <176244496453.1924614.12838084027318818785.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 16:02:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-52d38

On Mon, 27 Oct 2025 14:12:06 +0200, Matti Vaittinen wrote:
> Initializing the regmap_ranges using direct assignment to the range_min
> and range_max members is a slightly verbose. In general we can make it a
> tad cleaner when using the regmap_reg_range() macro.
> 
> The rohm-bd718x7.c is doing this open-coded initialization. It's not
> really bad as there is only one range defined, but it is still worth
> converting it to use the regmap_reg_range() so no-one uses it as a bad
> example.
> 
> [...]

Applied, thanks!

[1/1] mfd: bd718x7: Use regmap_reg_range()
      commit: 1810b210872ffc9985febca0880702a7102aad31

--
Lee Jones [李琼斯]


