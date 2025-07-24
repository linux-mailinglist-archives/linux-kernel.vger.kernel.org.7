Return-Path: <linux-kernel+bounces-744976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161A4B11333
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4676F5A7515
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1C0239E9D;
	Thu, 24 Jul 2025 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0RaP6Qy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7960219CC02;
	Thu, 24 Jul 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393075; cv=none; b=lX0YiiZfzudgl6nyoVlW4oqTKnj7F+HLvpc9t9Knf+xmn96bkel1rRzuFnLpm9kD2zbwJjxypIYy+RD60C85nIg5HjUY5rDSUEzYP5QTJGV96dBzzLmKbbdaTx5TWfBo3JfEE5fIUkdhKUZsuBqgoauYWICeo8ImLBOyVs0lPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393075; c=relaxed/simple;
	bh=Kk78a+V8SCEPOMRyTIoa4fUSGyDQJ80SaoIOMYf4mxo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=Zkcs2I/WzYsBqrQCZdy/TuaAE9h7urGf6WuhusjoQq4fzG3jj1h+9XLXOGc39gbNR32dfkBQZtrZC1nwCXCQWV0ILVBls8d8lGq+k8Lie8++2JGHyvIQcnhpVrI25u1nr0ZugJnZ6RHPjd18dbf5FCkO0rbPh1lyFD/+9G1jH/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0RaP6Qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CE6C4CEED;
	Thu, 24 Jul 2025 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753393073;
	bh=Kk78a+V8SCEPOMRyTIoa4fUSGyDQJ80SaoIOMYf4mxo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=U0RaP6Qy2A85SHsCUAzQFXalB+ePzDyIXEVcPG7Wjg1GQlVN+ybFh6lCa7Y87G2Ql
	 psvtI6Q3fiGY0ZCR/Z6kdnhd7ciIby68asBPKKV/Iunzy4+9Crz1CAdOcW3jiQWTkH
	 BQIqhFcngs9jAS84Jty99lX3eVyyypy28eyCu8zPEMFUPxGTBOw1WhpIbJzDkFo5nR
	 fvwH7Oopc5+E4mDFXiwigN6D9Vy/aC8+XhRjkbeWVqC3qSy+U9gIE2mHfi0a7d9OOs
	 98/BlqFSwWx4E5akKTLMCc8+ZLN/x2FdBfKbn+9ZuzH1peQsrLoFF8ohF3KglOxcjR
	 BFMfz4YZacAkQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250704075400.3217126-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com> <20250704075400.3217126-1-sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 06/80] clk: imx: Remove redundant pm_runtime_mark_last_busy() calls
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Abel Vesa <abelvesa@kernel.org>, Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, Sakari Ailus <sakari.ailus@linux.intel.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Date: Thu, 24 Jul 2025 14:37:52 -0700
Message-ID: <175339307281.3513.6881609632116291164@lazor>
User-Agent: alot/0.11

Quoting Sakari Ailus (2025-07-04 00:54:00)
> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
>=20
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---

Applied to clk-next

