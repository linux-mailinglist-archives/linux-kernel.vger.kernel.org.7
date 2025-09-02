Return-Path: <linux-kernel+bounces-796129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA6BB3FC3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2224E1F70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69E82F6184;
	Tue,  2 Sep 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a81qtAVi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E02F616A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808575; cv=none; b=Dw17l9YiRUO8FDcTqjuDR3nn6meLIfWUD+h0aE2mKtxxF6GGOeWvBp/iulae6+ofvZR3sRtcnjxlADUnl2Gn6UAND0zo0rIfrIeasAk8H50FrMam9YOHA+u1Tb4fPXkiC3IT46LGNNrxZdeFMdXOSMhDyCpR67rRnQPiL61crC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808575; c=relaxed/simple;
	bh=LAr35df8qUCjAGPSr40+H65MtsPBLjxKxKPuu2aDTrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O2VG+rloXa4sUcwYu6fypr4Qt8trZRYaEjVViNbYUa9HO3Y2p2OzbsBMl/tDCmd0Lo5dniTFeNGt2aYk9m3WyG8OYTjN8HTtmiVSQ4UFAYFANr7ncrm262wC1lVS0uSZVf++hVNdOoECwGMOwpD5qM0Xy0R0KS3c31CBwbgn0Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a81qtAVi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6963DC4CEF7;
	Tue,  2 Sep 2025 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808575;
	bh=LAr35df8qUCjAGPSr40+H65MtsPBLjxKxKPuu2aDTrU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=a81qtAViY/eoZZRDP3QLh+2fxWpbWx2IYujSUszq9FMH0gK452n3I9b3Vc1Gyy6TA
	 CBrOsCEI2D7AGLoCQoE59vY+op9ujnXLln49RvAcX+9/RQZs+3z06taECCg9zYmXJk
	 5s0oR8ndcoAuO7qfMYBD+04PQEa/lXsUMQPBYzrQ/pMsekXO2roORC8qQXFqDkmHzQ
	 S/KJ7kYtwDeIcE4JJqpsL5Ieit6oof+HrarJm8R76omC36z+GeFi779y7svo/xZUlc
	 dd2ZPMquriNGPcRKwrySdq7tLrOxGihr4DS2v/H3PgoBV0sQgqDt9OPK+Do6t/J8OD
	 OAOkzSaAKWR/A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250812093104.103193-1-zhao.xichao@vivo.com>
References: <20250812093104.103193-1-zhao.xichao@vivo.com>
Subject: Re: (subset) [PATCH] mfd: kempld: use PTR_ERR_OR_ZERO() to
 simplify code
Message-Id: <175680857417.2253924.18026146608837622221.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 11:22:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Tue, 12 Aug 2025 17:31:04 +0800, Xichao Zhao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> 

Applied, thanks!

[1/1] mfd: kempld: use PTR_ERR_OR_ZERO() to simplify code
      commit: 36844f47e692214c99a3a46123a29475d73cff2f

--
Lee Jones [李琼斯]


