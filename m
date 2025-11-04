Return-Path: <linux-kernel+bounces-885483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 391BDC331A5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3396C4E39D7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0334434678B;
	Tue,  4 Nov 2025 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8p9zBZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDD2BDC29;
	Tue,  4 Nov 2025 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293035; cv=none; b=tgP6fmEgRapExukwpj8lSQ1Eh3wSxSN7LjVVbmOK6OCSYf+eAgay/mkdkii371+lL5qX3/aZygSCJ/OKn7brxIw2fJYBSiVxWiTFregOabpTcovoBg84PYb7WESWPPAsmt4H3v5ULDbyBUCBqQ8PoPt0C0Mjmus2xpwjqv2+eYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293035; c=relaxed/simple;
	bh=orPEC9q4FSalwoQVQufqbDK4EmZtOOcIMpwmCqnqGZo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=X6CVxRLo4AtDqz2Ugz8md1s1A9fwdWtudCG436M7hN0nuiTViRDrM55izmmeDRrYrcyqwZPqXZkiTK1q7VztFQCfyPhFtlw9vkGhzRL1+28XSFuSePYDWm7WzT7qOfBc2scGiVspqAPjX5B4g8noK8TdwdvFM9AbzNL6rjFaun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8p9zBZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB47C4CEF8;
	Tue,  4 Nov 2025 21:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762293035;
	bh=orPEC9q4FSalwoQVQufqbDK4EmZtOOcIMpwmCqnqGZo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F8p9zBZUcwUIlYoMLK+Cyew9zT0VHtG0VN5PSqpXsNMYiddv0AqTKwNCw7+iVye47
	 OCi0YgfQZqE2sEz5/LzYUQJ9mz5KybuTPIpzzegvShM/LErXUwhS9PVO2nIabnw5AJ
	 Pza6vy4jfull6nRmO6kan81kWhtWkufGL+H+vten6iOJJFY9tYhlGbuUhs4kgLe1nf
	 NjnZ4bmKtmaYDgULng/CQybBh2fZLR4pi1022akZ0NZch6Mg3zn/KOVCYOgOWYWDqb
	 xdW22jlQwk1zw15/f01+sbFHdTlwJueuTT+ZlgmXSnKNuN5HCKmSsPxYEAvyb4g9jR
	 EY6zbfV/Fnqsg==
Date: Tue, 04 Nov 2025 11:50:33 -1000
Message-ID: <d0918431b616bb5e9352c327f9575cb5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Move __SCX_DSQ_ITER_ALL_FLAGS BUILD_BUG_ON to the right place
In-Reply-To: <b12ef0a8bd20e1ab8849ea129db70bad@kernel.org>
References: <b12ef0a8bd20e1ab8849ea129db70bad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Tejun Heo (2):
>   sched_ext: Move __SCX_DSQ_ITER_ALL_FLAGS BUILD_BUG_ON to the right place
>   sched_ext: Minor cleanups to scx_task_iter

Applied 1-2 to sched_ext/for-6.19.

Thanks.
--
tejun

