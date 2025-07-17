Return-Path: <linux-kernel+bounces-735132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB4B08B36
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629014E452C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFE2DCBF9;
	Thu, 17 Jul 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qT+QkDG5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806852DC35B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749189; cv=none; b=JbHQkA0fYBmyZKykMlQz+0W1vCrpuFDbvCJvXItD0WdL+6R0VlU23EEX2uZSnQTlw7HyDCaEnPQQr75ZUdayiXCCxXjim1x9ZUDsEFjwEHfXwokKz+9OkcLmmaZr5lir0AUKcK/E8XawFsnwIXjx4wyoDgYEYaqrWSopWco2H6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749189; c=relaxed/simple;
	bh=BPQRhJu4WuTyEH2d/mXKogr4/Dl2oBnBFlU/tk2u1YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHFx/R9EdU0mRtPDaYE8pULU9XQhf7U0Fw3otuLxoexuP//0hH9+K1PMdBWkR5fUTuhO22osWro6JlDdw7+fEmVdSbhFXzTBxXzCAwKsjHVslXlNV5yFGgLu1X2qVn2V0TjIqC6JFhyFA7Uu0oGixHEqMv1+UxOf8otN6dMM+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qT+QkDG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAE2C4CEF0;
	Thu, 17 Jul 2025 10:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752749189;
	bh=BPQRhJu4WuTyEH2d/mXKogr4/Dl2oBnBFlU/tk2u1YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qT+QkDG5FL0haJPJ6DU3Jxayt9PLHcnpuSZX8OsXHGX/nFNEKukRsi/NSbThXsfHX
	 XW80y2LwnngWFYDAKhNhP6FHDqW7r+TV/p1nb9ZbF7QZp6zUo0liO9b/n6GQ+TPPzW
	 VhbkkajrXlUTKdCYVl3YL/Qj+76CuHHfHaL2v7l6rK5rakEPS51e5/usEjkgrR997I
	 kNYFgUqG4fUCoIqJ1V2a27RV59ta1UDiayakhGGEX1G1aj14UhMn++ERnfcJxyZWjw
	 +6sVO3Hn6LIun+FrHEXbA9oeHNIO5bi6QNtcJ08BEjqSF4jgH5F3a8eXjJFNi1xhnc
	 JW7bmaAd56X6w==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/gcs: Don't call gcs_free() when releasing task_struct
Date: Thu, 17 Jul 2025 11:46:17 +0100
Message-Id: <175258790439.3684657.2697022341807842240.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250714-arm64-gcs-release-task-v2-1-8a83cadfc846@kernel.org>
References: <20250714-arm64-gcs-release-task-v2-1-8a83cadfc846@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 14 Jul 2025 12:21:27 +0100, Mark Brown wrote:
> Currently we call gcs_free() when releasing task_struct but this is
> redundant, it attempts to deallocate any kernel managed userspace GCS
> which should no longer be relevant and resets values in the struct we're
> in the process of freeing.
> 
> By the time arch_release_task_struct() is called the mm will have been
> disassociated from the task so the check for a mm in gcs_free() will
> always be false, for threads that are exiting leaving the mm active
> deactivate_mm() will have been called previously and freed any kernel
> managed GCS.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/gcs: Don't call gcs_free() when releasing task_struct
      https://git.kernel.org/arm64/c/75fdf823f94b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

