Return-Path: <linux-kernel+bounces-799448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCECAB42BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4C7170004
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4343E2EB5DC;
	Wed,  3 Sep 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIm/iPg6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944A2EB5B7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756934861; cv=none; b=sOYSsTnXpvnCbfJk8ifdbXdyWvVUMWa3OZg5PNi4XxBNIhYrvMvaSCLvy/52njKK/KSvCllnHPXhhKD2uRGDmjYAF0JI/ayWtkswCJCEJYpG/Dt0dPh6AjxKzDevN6zwJ/GbqGUJ04ocSu1DThhitjVtCNWnrnfJ7pOcH807W90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756934861; c=relaxed/simple;
	bh=LDEavBgpdf6sYM/MgH8ENkdlyZyknViZWzX3GHBJMuc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=nxubSTPu/ThKFIjIumyNRp0ypE9Jz8ioYNOW/1rgsADu6rNzBxb3dAXIJhMoaPAUDQvweDhrIRExNIqJqmYwfu+INY3rHg+kjFHOja+oViD9GNzvw+rHJzfdARFXJxCS0PCS23dhMjEacu4zDvJngaE/LOLESo1ssBp7pPkLAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIm/iPg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544CDC4CEE7;
	Wed,  3 Sep 2025 21:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756934861;
	bh=LDEavBgpdf6sYM/MgH8ENkdlyZyknViZWzX3GHBJMuc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=KIm/iPg6kx16gIafv7f0CtiOtExR8gU89IBmCE0vnx0Xvs0u3xOEPCjGOrdE6+ahW
	 3lR/UkRwtu8eEAFVhXHvWkOFeHGw1hWmRJ1oNr6bkdyIgX9avxrPIbaKp2lw1hs+6e
	 1tY4zESTXlnp78HD0gJmNPgwua6kuwREysr0H98J5/DWOpsof2Rjoyu9kfXgVPZ0y1
	 rUI3sZkmeC0EUFvHxqpU9zj4QCgLQmYRFjKqDE3soOJe7C+N2x5eDxkn5cC4SBs3Fh
	 0dt1yvFaIY3jN493HvP8hhxJJqhCHgYvZ7UkzmsSTVzcBUdzxC0e9pajfv7tXdKUkV
	 SQLF1h/RVIcuw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Sep 2025 23:27:37 +0200
Message-Id: <DCJHFF0AEDB6.6JMTQPQA5800@kernel.org>
Subject: Re: [PATCH v2] Revert "drm/nouveau: Remove waitque for sched
 teardown"
Cc: "Lyude Paul" <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, <dri-devel@lists.freedesktop.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250901083107.10206-2-phasta@kernel.org>
In-Reply-To: <20250901083107.10206-2-phasta@kernel.org>

On Mon Sep 1, 2025 at 10:31 AM CEST, Philipp Stanner wrote:
> This reverts:
>
> commit bead88002227 ("drm/nouveau: Remove waitque for sched teardown")
> commit 5f46f5c7af8c ("drm/nouveau: Add new callback for scheduler teardow=
n")
>
> from the drm/sched teardown leak fix series:
>
> https://lore.kernel.org/dri-devel/20250710125412.128476-2-phasta@kernel.o=
rg/
>
> The aforementioned series removed a blocking waitqueue from
> nouveau_sched_fini(). It was mistakenly assumed that this waitqueue only
> prevents jobs from leaking, which the series fixed.
>
> The waitqueue, however, also guarantees that all VM_BIND related jobs
> are finished in order, cleaning up mappings in the GPU's MMU. These jobs
> must be executed sequentially. Without the waitqueue, this is no longer
> guaranteed, because entity and scheduler teardown can race with each
> other.
>
> Revert all patches related to the waitqueue removal.
>
> Fixes: bead88002227 ("drm/nouveau: Remove waitque for sched teardown")
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Applied to drm-misc-fixes, thanks!

