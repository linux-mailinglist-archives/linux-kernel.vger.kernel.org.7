Return-Path: <linux-kernel+bounces-826510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E64EB8EB2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D3A179FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 01:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C91A23B9;
	Mon, 22 Sep 2025 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcfPioy3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804219D8BC;
	Mon, 22 Sep 2025 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758504771; cv=none; b=JmLZyBhIzLviidycK0kAL+ZOO6iXFkiL521CQkDlvN8RYRXdLaG5fklZGjuo4ws4hS6D22zNVSGm2twK6W0mL2nVLiQgycdHXGVTMETMVmzn+DeH3psfUjpB9NOrC/CzFVARWlluNlMs7wbd2DbH9Lt9Yz5gET7JqFv8+W/BaN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758504771; c=relaxed/simple;
	bh=PG7649qzgTnimZO0ESCzvakNOlbFx2LGdGUs31BVO00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGjaHmtWmWAUhbP7ud9kXg5OgDzw6naF5Pv6ZMQvpZQw+FEvb9o4oHCWc1yiBrcv5fxxNh8LDy7dTxyeQs6WIWBxcBbFSfFgzzNrQcd7L4NQXHYtG6TXJYcXdKF5alTzIpwroLpzKCRrhjDJcfPSpas1BiYeEJ08w25OZb78sEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcfPioy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DF2C116C6;
	Mon, 22 Sep 2025 01:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758504771;
	bh=PG7649qzgTnimZO0ESCzvakNOlbFx2LGdGUs31BVO00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcfPioy3pdwvl2CEEZ6jcJxhgeDD8wDgufWkUu3ukyXakGbb68i/Tc3f/yi80bTGo
	 VUV6g/BOxFai1EI36SDgWHiogVP4YF7yUcVq/ni0kJouBs7ErTFb78yg2k5FPWpcRs
	 ejJTGMGKX9m9KweKegxsv5qiVp6Zmn3oZP2WCQB7G97H1dwVw4T8BeM31v5YWsNZO5
	 cuc3XvURTlWTy6jjrTvn5rdxAdtgSEv0VqAwii8jmmVIYTfFVbf7OVQlsD2CY0FL1R
	 dQ9UIaoFliGL6Kl0fX/q07Dih3J0XKBTaxXuXM5mq5Fc3Bd6FGtfs2ldOjTt82Z4eS
	 LPdsoX/v3q82A==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/7] sched_ext: Use bitfields for boolean warning flags
Date: Sun, 21 Sep 2025 15:32:43 -1000
Message-ID: <20250922013246.275031-4-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922013246.275031-1-tj@kernel.org>
References: <20250922013246.275031-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert warned_zero_slice and warned_deprecated_rq in scx_sched struct to
single-bit bitfields to reduce struct size.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext_internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 2e289931e567..1a80d01b1f0c 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -871,8 +871,8 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;
 
-	bool			warned_zero_slice;
-	bool			warned_deprecated_rq;
+	bool			warned_zero_slice:1;
+	bool			warned_deprecated_rq:1;
 
 	atomic_t		exit_kind;
 	struct scx_exit_info	*exit_info;
-- 
2.51.0


