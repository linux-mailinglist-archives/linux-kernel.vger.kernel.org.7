Return-Path: <linux-kernel+bounces-682480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF7AD60B2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 23:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7812A7A3DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5D2BD5AE;
	Wed, 11 Jun 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1w3/1yT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CAD25F989;
	Wed, 11 Jun 2025 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749676133; cv=none; b=TJw0xFnoAamtp3lXH21z1/yY+5chDSAriBjJMzvM6k073rLocfkYLqxxhoaKGyQ7+lim0Wg3X9XvzPSPSbbZGbzh+tKL4XFCUn60GsCMHshTRCVQ3MM0u8yvBlOZegLFoFjalHGA0sC5l3iunIGn6sbK15qAUif7b+3b0A3PdhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749676133; c=relaxed/simple;
	bh=8otFxMFPmvz6azZ3wQFI0rUizbWWfdTcfcSGvGtiz8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6n+/O9T6MX4I2S5OczHUXXrnWJo3fevSFcM1hNn+1Xptfihfj/6DOi/cznlg+nC8kU4UOeD6onCLoN7gycMBEQp2ShlgDE9iSM/pc/wO3Pp8oonwJk+fk/4ZDDtRH3F1q3rIBefv8AFRviwjO97hYYPfw4uUovCSEYABFblPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1w3/1yT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3226C4CEE3;
	Wed, 11 Jun 2025 21:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749676133;
	bh=8otFxMFPmvz6azZ3wQFI0rUizbWWfdTcfcSGvGtiz8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1w3/1yTRA16ZYAEMmn0+G2NTd+DAXew2qa3wMTAFUba7rF5B1ZDJq2cktGgbAvGy
	 DoIrG80TK5nUzHjuNpJKcHwC/4yGc24VahPPAqkHvuhhm3HM4AnvuGvzUF6jBw1l0s
	 UTyQmIjEJcS02zVlrbQRjksqCksWAxRKhCKoQpFw0VaDfnD/IDePmj3WJPWp4gbAYL
	 +/tg19HvJ/xvVOC5wRR/ULbKuDrBWn3ed1owdak37oLQsLQM6woLMJX2PkIVmOTKjm
	 Vy6gQmt94q9o8vqKFHoKtD0ImRFZKtt2DKvGZI1zVw0ri67LpcIQ1ZOz4s18uuVW5S
	 iS5qAxkPRVg5Q==
Date: Wed, 11 Jun 2025 11:08:52 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	sched-ext@meta.com
Subject: Re: [PATCH sched_ext/for-6.16-fixes] sched_ext: Update mailing list
 entry in MAINTAINERS
Message-ID: <aEnwZDmZy5k9CYe6@slm.duckdns.org>
References: <aEnwVlCeVCOdLx_d@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEnwVlCeVCOdLx_d@slm.duckdns.org>

On Wed, Jun 11, 2025 at 11:08:38AM -1000, Tejun Heo wrote:
> From 47096d301e39f96962ca1fd6c7b71bfa796c53db Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Wed, 11 Jun 2025 11:05:16 -1000
> 
> Use sched-ext@lists.linux.dev instead of LKML.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to sched_ext/for-6.16-fixes.

Thanks.

-- 
tejun

