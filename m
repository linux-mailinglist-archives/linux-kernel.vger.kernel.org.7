Return-Path: <linux-kernel+bounces-851028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7092ABD53C2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64D294F8F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1AF284880;
	Mon, 13 Oct 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RW98i+Jf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898526F44C;
	Mon, 13 Oct 2025 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373311; cv=none; b=dH59m2xIRYOPvs4fJpqkWrRf2U/DXDGGIbsMavHMi566LSjzjonRBrQDGrW19vlx1iyrZ4qGdHAOdk/ypS39MtWgKmDTyTpyjtc4dzVT8gpyeahgTIY1bHSSCqJKAypICUQGWnJKb8HbW/CGzB3hWsO4O5KdMr6ucDG3gkjP6dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373311; c=relaxed/simple;
	bh=IoSCnKCJ1L3ML3MRHwKlp6nKUp3u+G0BJyHRjDxDaCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrJLDvTivX/hVFzmL4sSjEiBDgAY8OOlGunV6vtvkrLFolCK0y3MQopEczxSTCo4VdzmEZSo58+T9OELYvbJ+NWDLnqadsm8BSd7++7YWsk2uPz+eMVn9sSKEcIrttbrJIcDlW1yrJIieS/g+24a1g99IgaTpxjGp4tkPPGZXrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RW98i+Jf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F99BC4CEE7;
	Mon, 13 Oct 2025 16:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760373311;
	bh=IoSCnKCJ1L3ML3MRHwKlp6nKUp3u+G0BJyHRjDxDaCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RW98i+Jfn8jV22aolvb0R4zcUFPFyUnEV8abT6oqDBe8lJjoQS2OBJKSvCFSc6Is7
	 TNYfQjsPbtRaje2y1J1nuIDL2eDNHlkCNLqDf95jChF5g58v0MX0qGmAJrH40XGynT
	 73zpkITcVKt2Hr6dqJPaNvf19QXhV4q2X6bnQGseHuuWWXdWBp734OnXFBsRAIdQ+U
	 VNE57myzlu7O+zsPvrQoB3bNUbyCdX8fRaB7SaUTwqGvNXMYziVKcxcJFnMJDBfwtS
	 i3jV4Uzc4z1OqiYLzSh1YRpQR2z3QNcLCdzDjjScYSBc5G/nTBelVq6Q5pgkrHX3X1
	 UszrWKcw+er8Q==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Johan Hovold <johan@kernel.org>
Cc: Sven Peter <sven@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] soc: apple: fix device leak on mbox lookup
Date: Mon, 13 Oct 2025 18:34:57 +0200
Message-ID: <176037325545.63580.4781606533946374244.b4-ty@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250926143132.6419-1-johan@kernel.org>
References: <20250926143132.6419-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 26 Sep 2025 16:31:30 +0200, Johan Hovold wrote:
> This series fixes a device reference leak when looking up mboxes and
> simplifies the sart lookup by dropping the corresponding reference
> sooner.
> 
> Johan
> 
> 
> [...]

Applied to local tree (apple-soc/drivers-6.19), thanks!

[1/2] soc: apple: mailbox: fix device leak on lookup
      https://github.com/AsahiLinux/linux/commit/f401671e90cc
[2/2] soc: apple: sart: drop device reference after lookup
      https://github.com/AsahiLinux/linux/commit/f95f3bceade2

Best regards,
-- 
Sven Peter <sven@kernel.org>


