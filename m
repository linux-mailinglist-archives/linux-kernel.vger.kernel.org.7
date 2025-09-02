Return-Path: <linux-kernel+bounces-796147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D89B3FC80
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536FC169E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B022773CD;
	Tue,  2 Sep 2025 10:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRwaOtZG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD0D72625
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809065; cv=none; b=OfZmF5Uojq/llz+r/Y68bOje3X31MbF9KSij168McEgGAtrFd2CEEqSbQvOsDti6FZHEws4/ma7sMNkUgKkZnq+JlwUdI8bGYGCyWP5bA084p3XRBb5q09LJt8E+HLYjnOx8/H/mHQ6aWyE9HkI5DMf2D6yZmf+AQgyVa9sJm1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809065; c=relaxed/simple;
	bh=YN7eLYWuco7AF43p9BloY9tUtk2VaRed60/nA85hwOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HBsWt5slLqA/aGYP2NmtolWMmD7pRD31D3TsDLM+Dy7+B82+aQrUFS/tibBvDTbSQbuqZylEbAPmoh27s8iwirNubBvo+fqNw8BOBTotVSsu8unhVabHHW7cKnR84wRQ/hg8WFFrNoWsnkWl4CKzSSEedfomblx2128n3vmDDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRwaOtZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA6BC4CEF5;
	Tue,  2 Sep 2025 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756809065;
	bh=YN7eLYWuco7AF43p9BloY9tUtk2VaRed60/nA85hwOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kRwaOtZG3wtBWE+RN/vE0cRyVdUVz4n9KxUjEzWutfUKN6au+0y+f+XgA2wto/f3X
	 5Xak5ybCJx3dNcLRvX58xJe3gzi+5ft6StunHCpVMTUkB4wygH6WE51Y1lPhegoubP
	 aQRT/6pd5oysNa+pKd4L11wkYOIlmKTOcGqZtQJPzxp+5yFhGTC2OEAy+qXUwFDQHW
	 jEIAssHhaqJ/PCm/icTjmjJxXU3rotEPKj3zFc1TMjT8YT0zKn3izFwds0HOvu3R2l
	 MFuer+WJkJOQ9a/8ty0oGhwJz2vZF2XGJRdfpf3LdrWyeJBG05UOHm0JBq1trBtKcv
	 rg62XPDXHP9DQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250815100601.622923-1-zhao.xichao@vivo.com>
References: <20250815100601.622923-1-zhao.xichao@vivo.com>
Subject: Re: (subset) [PATCH] mfd: Use dedicated interrupt wake setters
Message-Id: <175680906442.2258639.2984759717773465983.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 11:31:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Fri, 15 Aug 2025 18:06:01 +0800, Xichao Zhao wrote:
> Use enable_irq_wake() and disable_irq_wake() instead of
> calling low-level irq_set_irq_wake() with a parameter.
> 
> No functional changes.
> 
> 

Applied, thanks!

[1/1] mfd: Use dedicated interrupt wake setters
      commit: 075ac9d669512ec65a7340428c7994167950d868

--
Lee Jones [李琼斯]


