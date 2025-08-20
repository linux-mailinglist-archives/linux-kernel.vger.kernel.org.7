Return-Path: <linux-kernel+bounces-778330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DD4B2E44D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E969A2582F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4EE279794;
	Wed, 20 Aug 2025 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv+JIZlh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DC4278E7C;
	Wed, 20 Aug 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755711757; cv=none; b=EzNdIKTJ/o19H9XV1Se4MO42G1FGRIFBC/3Vjw9l5qtafDgu9ZAlidNg7/b6IinaR1c++YUBEWCf7v+0bmgfwfGK702dqZBk3K2b3C1SqZknNQIBT6KkSqT+ycRClFMusE0oe3WGOAE+ey3MUv56tceWFPCLNYYC83XQFcf8vzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755711757; c=relaxed/simple;
	bh=f5b/XZjopr8Cuv8VprlPMa8Ukxq9ScSdZbNIDsH+L6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aweJ04lQxlazo9M8yKMN2anUL26Ifvo4CXgpgZuz04fhvIrQ+PIccmVIxyiX2YgoUUfCS3YoIQPtQyG4YEqECxBirw3CQkMImoKV0gyqFwtBAse5ZhIHdSYj9il0BLA2guBdgbPcJT6+uXWPW+akwInOoH7FDx5ayxnOwLEbqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv+JIZlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3804CC113D0;
	Wed, 20 Aug 2025 17:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755711756;
	bh=f5b/XZjopr8Cuv8VprlPMa8Ukxq9ScSdZbNIDsH+L6o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sv+JIZlhwxm2bzqHaIT0dneeU60FkdTIN/60NpfBHVCytLiCHAtYgsZ0gEBNATsgl
	 eeoMa7f2g3Elyr6Si+n6ft6bQPwBzUnd2RCZXo6/tar6V+8JR8CIZ8PfL7PumZUoJT
	 kgRF2SESj6VD0kGpR6DFJLCZ+e5l7gfWkgGsUS16Z4PRjK9AzFmXte1RZ6t6R/j+Xj
	 3DBnFXSZgfk+K843yterdk5wWUVEsavkrbo+5x8XUL2xMKpW5ruLPSb8LWWtEtE2v7
	 ARLaJ53I0Zc2nGh6faRELNA3Jxiqec9n1e6cQuk7Ji5nAOM/iultrADMEp3nyfJHgi
	 miHUy9/Ew6GgA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250730162712.2086439-1-colin.i.king@gmail.com>
References: <20250730162712.2086439-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] dmaengine: ppc4xx: Remove space before newline
Message-Id: <175571175477.87738.3069092823141018312.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 23:12:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 30 Jul 2025 17:27:12 +0100, Colin Ian King wrote:
> There is a extraneous space before a newline in pr_err and dev_dbg
> messages. Remove the spaces.
> 
> 

Applied, thanks!

[1/1] dmaengine: ppc4xx: Remove space before newline
      commit: 1daede86fef9e9890c5781541ad4934c776858c5

Best regards,
-- 
~Vinod



