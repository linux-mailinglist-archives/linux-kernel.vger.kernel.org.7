Return-Path: <linux-kernel+bounces-863403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11FDBF7CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7B1544F23
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124EA34A764;
	Tue, 21 Oct 2025 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYBpIhKL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FBC348869;
	Tue, 21 Oct 2025 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065692; cv=none; b=jWs3+IKB5lZifijL2LqezswPHVX+k2FRCFlrzSWW42atdnRmO/gthUHARRAQr83PzksB8gpjNsaTGVTX7dRHeXG3bwuoCxKGLuUq+AHbun5kL6ncgrwu9zBQoMkiBr5No2npO8KBveST06sLrltvite/2RbxMWwsCQmFKXY6M9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065692; c=relaxed/simple;
	bh=kcJe89EUvp59KaUJ7RAP9IH7lYX00mLmtsiVqwhSc4c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E+UxFoadWNNgMnL6Vo0vXmdwanE8TPe85QebRVsSiL2tRmK5QeYdZlpPpleSHTNRZzZeCsACV6jFiqYtq9R5kC379jNh4MO4gBjbIk+cQ+T9wEGZKBvILrRkf6gQ3bodkT8fjZHsopVfqvJ1RYiBWxK8lNGWsQG+gER1X2JiDmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYBpIhKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B5BC4CEF5;
	Tue, 21 Oct 2025 16:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761065691;
	bh=kcJe89EUvp59KaUJ7RAP9IH7lYX00mLmtsiVqwhSc4c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oYBpIhKLxjvi6aQi1PUCD8cDzSPRZZ3c1fX2T8pHwltHk42aIqAM0qvDpKkD+HAfO
	 GHkAgLKzPV5OkBlO9bdFHELLZrIbQlesC2RkfVeBNZniAdfbHY8LIKorsZNwcIlhI6
	 tovf2fK83OEhMhFU9Gu/7tX4FInFo6K6wk2EormtE0eDX5Gq65jBAQdo1jp2VdJOTn
	 y0D0CgvSjhYN4dpdjBuxiPcotHG/wzKeHIj6MKc96PHQwxEHp9g+qxfWpSnG9inQ2/
	 tUwvxljR9/TM3gfjwAZNXVkD3Wb9rW3TcHTZBIIHToJ3YCgAOSnpxitnQjeaTTlUAU
	 v1NGmzaRRZDlg==
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id E4A4C5FBE4;
	Wed, 22 Oct 2025 00:54:48 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: wens@csie.org, samuel@sholland.org, 
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20251020152704.4804-1-jernej.skrabec@gmail.com>
References: <20251020152704.4804-1-jernej.skrabec@gmail.com>
Subject: Re: [PATCH v2] clk: sunxi-ng: Mark A523 bus-r-cpucfg clock as
 critical
Message-Id: <176106568889.3123154.11081141825428499092.b4-ty@kernel.org>
Date: Wed, 22 Oct 2025 00:54:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Mon, 20 Oct 2025 17:27:04 +0200, Jernej Skrabec wrote:
> bus-r-cpucfg clock is important for peripheral which takes care of
> powering CPU cores on and off. Since this operation is done by firmware
> (TF-A), mark it as critical. That way Linux won't interfere with that
> clock.
> 
> 

Applied to sunxi/clk-fixes-for-6.18 in local tree, thanks!

[1/1] clk: sunxi-ng: Mark A523 bus-r-cpucfg clock as critical
      commit: 1dba74abf3e2fa4484b924d8ba6e54e64ebb8c82

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>


