Return-Path: <linux-kernel+bounces-754457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0F3B19480
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAEC1715AF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC631CDFAC;
	Sun,  3 Aug 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+k8/WMG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D7A1A2C0B;
	Sun,  3 Aug 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754239780; cv=none; b=C1PJjeR4MLpS3enY6QU1Q6V6W/UYKR7u7KqY/9JKM2TMCrI5+m3HENhyZXZaU031yh/gF9+JW+JCx+4S5RjkACqE9j6QuL4QVM9LmeRGrofskwcBOAtJV4/fIupB8/B4HC6krBuZB0rZYREnxDb/N3P49B2XTpN9eOY2NOhJK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754239780; c=relaxed/simple;
	bh=ukGOvHSLxM6DOts4OpuXE4dv5VI5mr9YJi8g6MkF0F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG9Erp3We8SmEwR0zUeLBOQnF4WPIkBzeb+PMJOUjt20GAQtJJ1ZlBc1i4O8V3I80Jaqaa/NTeNmxWYL1bwthF5LcL/io5hNE2qngiy2tyLrFCpApHVou00jhUO/7xNEfhrfQdQd7J3hrulAmxvA3CvcchhGVi8KNzfW6uLMjmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+k8/WMG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696C9C4CEEB;
	Sun,  3 Aug 2025 16:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754239778;
	bh=ukGOvHSLxM6DOts4OpuXE4dv5VI5mr9YJi8g6MkF0F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+k8/WMG4E+UOPnYVLvs4p9NCXzqsIT4GD3eHe3wEFBCjFJPfeUkxeFgUwSUEm+mO
	 KDlqeqVOfMSzaY4cTvPQ79TG8Ya5yHUFAwiZUp+SIRijb+oJEAokS9ca70iX3CXfeb
	 qyXuPP67Mo5zAOB4AgdtByEw9E2AfVVzEHzGryH0JAcW8K/xdPwAnJvGEq3M1hI8HW
	 cgyaP5eMt2RToJRQ6CSmvdviwj2A/Cs1KFqhxC/lkCRzui7dyNS68Z8OdhLrr0Sar8
	 TFr/xrsCD+3rbZpYuLATYAUuGa365gkJCy/F+wQ+hX9AmSOuuw4A5aaEywp/mVVqET
	 zvHnOH7tsztwg==
Date: Sun, 3 Aug 2025 11:49:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@gentoo.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-riscv@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	spacemit@lists.linux.dev, Inochi Amaoto <inochiama@outlook.com>,
	linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
	linux-clk@vger.kernel.org, Haylen Chu <heylenay@4d2.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH RESEND v3 1/2] dt-bindings: clock: spacemit:
 CLK_SSPA_I2S_BCLK for SSPA
Message-ID: <175423977710.518524.17027664815968438984.robh@kernel.org>
References: <20250731-k1-clk-i2s-v3-0-2f655ddb0c6f@linux.spacemit.com>
 <20250731-k1-clk-i2s-v3-1-2f655ddb0c6f@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731-k1-clk-i2s-v3-1-2f655ddb0c6f@linux.spacemit.com>


On Thu, 31 Jul 2025 22:14:06 +0800, Troy Mitchell wrote:
> In order to use the virtual clock SSPAx_I2S_BCLK in the device tree and
> register it in the driver, this patch introduces the macro definition.
> 
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  include/dt-bindings/clock/spacemit,k1-syscon.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


