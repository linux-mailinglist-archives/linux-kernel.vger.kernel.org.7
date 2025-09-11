Return-Path: <linux-kernel+bounces-812678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C376B53B54
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BD7F7BA506
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F4136932A;
	Thu, 11 Sep 2025 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMD01O56"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8224DD13
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757615058; cv=none; b=si5UEqtc2uR3xJyazAYiKrNGSyAghH28CFyZeGnHU9A0DP8vQPNIkGlI/djBph3DLt3sl/NAYH72Q4AYzyCOVY0jrTOpcvdmu2V98Y0gKXEu51x6LDKU6b90E46eCtVE7VA9B7SpJvVnrb+rNYR3O3I1cO8DTN0YdZLzx/aq2tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757615058; c=relaxed/simple;
	bh=KGKsZ6Jdy+3V7bqBCI1fO91V9AiE67DdDKtogHTKR10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzGEVg+gSSxGN0KxO6D1imL3Hv1Cu99E5BXhs88mXfJf143Z+8LkdS2jD7LdLaBeKyuzjfz6NDknbd86z3rba34VdUgFy3EA6yJrMwr1p+euvx1lGhjnW8kqfzYJI+16qZ/ixImOTYpPjrTLdNnZfwhTW1sVISA505z/AVEYbnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMD01O56; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93FBC4CEF0;
	Thu, 11 Sep 2025 18:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757615056;
	bh=KGKsZ6Jdy+3V7bqBCI1fO91V9AiE67DdDKtogHTKR10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMD01O5643228nVTISLl6oNk0ig/HqJ9ueeGKeMHtjtToRo1d8/+4ioBx35VX0CSM
	 Vi4BgSkQ/VLfruag81haTEQIiJARsq5UAVANd7+YBz86QDcOc0fidiyuWMzCdumkHL
	 WPyHJA6/WM0mzJJQKM5VSKhEd8Fco39Vo6sgdk8OdfWTyziUexxapRFeW+gFwAPjju
	 sn+GAGdveKWfEKTtFoCMjmgRaHo9LczpsyUnbS7TJzou/JZ+RiFozywAfXBk4TZyCt
	 Ug5Dv/erhfFcNi897erR6IF9V4nDPzk7p+ptUFm0hzDfxuxhxhCQ1/fhVcpjXM2FZO
	 X/cpKAwdOkQBQ==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linmin@eswincomputing.com,
	Pinkesh Vaghela <pinkesh.vaghela@einfochips.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cache: sifive_ccache: Optimize cache flushes
Date: Thu, 11 Sep 2025 19:24:06 +0100
Message-ID: <20250911-moonscape-bulk-cd1312329fa1@spud>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250909224131.276800-1-samuel.holland@sifive.com>
References: <20250909224131.276800-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=448; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=A9m2rI5/mArBo7YmC6ZAr5oLZmcnI7j3BQisSPiKdxE=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBmHhY8bXAg18jw3qTzx6M1uNaP9WmyiKzaYKb47tm3Sp Qm7VUMMOkpZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRvLeMDO89Vf9GqjDOfbj5 68sm2x+73C+W5RRvDL7mYcSxo74trIaR4dq8GRk7JC+0Tjpyawm3gMGW4Beis5foPpj1cmNYEXN 3Mx8A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 09 Sep 2025 15:41:27 -0700, Samuel Holland wrote:
> Fence instructions are required only at the beginning and the end of
> a flush operation, not separately for each cache line being flushed.
> Speed up cache flushes by about 15% by removing the extra fences.
> 
> 

Applied to riscv-cache-for-next, thanks!

[1/1] cache: sifive_ccache: Optimize cache flushes
      https://git.kernel.org/conor/c/941327ca5ddd

Thanks,
Conor.

