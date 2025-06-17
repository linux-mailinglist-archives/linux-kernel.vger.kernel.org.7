Return-Path: <linux-kernel+bounces-690926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5DBADDDF3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 23:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E38C3B542E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFCD2F272F;
	Tue, 17 Jun 2025 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mThStFc6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B872F2707;
	Tue, 17 Jun 2025 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750195859; cv=none; b=alYbZKinaB8XPbc+igu9SkbZ5ujR2DtYheeJ8FhBjz9DR50JQJeQKvy4a1AZo8L1/ZGSYSCVpDairz9v89ak8AMya6FOLv8Jvl4n93anxYUojDwEQ4JrUWFxBV80xWF0VKO9wlI1iiAuxzK9zYNHH9Qq+PIr4XmAUPzMCwfgJ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750195859; c=relaxed/simple;
	bh=+AVJtkADX1ZsehTSMEkzz8csKFgS7fgQrxOyASGuj1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hENYJ5CZvLX2mVYc7vlFU+gr7zb9IUI0CWynmXT8AKACv2+jq+7N5QYJRrekrOUIEMRCLSRjukTeQyGjT4fs5R41xV08eB6AtNBsVG7cNwepJQpXkTp+ybzD/nYJXP2AWzJnDnGmgk2SoX9ECSk5RM5YQtteXtN/J0HxumhZSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mThStFc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCBF3C4CEEE;
	Tue, 17 Jun 2025 21:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750195859;
	bh=+AVJtkADX1ZsehTSMEkzz8csKFgS7fgQrxOyASGuj1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mThStFc6jCikXs2uo6W+NF5YvEORiZDeUdOBUgkPD/A/3O+gudg3d+XCDTm99JtC4
	 FeaGP7377as3P+D08h45he9kHwINuNuNzY7sk9jByZBkwd6LOqGdfcDwFBYL3szzPm
	 J9q0Xb+WbJXdRnHWuBvUfxi3nZCvMwh/XTRMgTl+SvsAgggqMvYINARU+17BFaozh/
	 h+z5r1/1InrCvfUrpG5iHnETApvHtPHCzqQ9G5x6TIzBVSK6H0R0jhafv5ByU8/XlX
	 UKNF92qNbFaJCfwjA0gwVzPROq9Am2dcZUof+UDxZnfePW0vLmJNZ0WtN4lPRHfjNX
	 iHXBhKK/ZbNHw==
From: Bjorn Andersson <andersson@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] remoteproc: Don't use %pK through printk
Date: Tue, 17 Jun 2025 16:30:52 -0500
Message-ID: <175019584837.714789.5721540056396177513.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611-restricted-pointers-remoteproc-v1-1-f059097ba663@linutronix.de>
References: <20250611-restricted-pointers-remoteproc-v1-1-f059097ba663@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 11 Jun 2025 12:03:06 +0200, Thomas Weißschuh wrote:
> In the past %pK was preferable to %p as it would not leak raw pointer
> values into the kernel log.
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> the regular %p has been improved to avoid this issue.
> Furthermore, restricted pointers ("%pK") were never meant to be used
> through printk(). They can still unintentionally leak raw pointers or
> acquire sleeping locks in atomic contexts.
> 
> [...]

Applied, thanks!

[1/1] remoteproc: Don't use %pK through printk
      commit: b0dc512ab7ba177442cfec4a65b2681355d7cb64

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

