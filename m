Return-Path: <linux-kernel+bounces-744079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9046B107C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F53AC3DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C923E264A74;
	Thu, 24 Jul 2025 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC4yZaL1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A18E1362
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753352973; cv=none; b=uAv4cdvDtUrwbfng1gQoGDMj2P5XnE4O17dAewtThgS+jM+DNBonPU4y90FC5/qOOt438NVg4rBc4UKd7OmNeMmgWQ2oJXQrMkxWMZyjGjLabMFaE/JPix27yOT9a4lqpdExSG8jQjXyX8tP/r3tUS231xAp55fN0Qq34oW9M88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753352973; c=relaxed/simple;
	bh=4PvlALyP5ZXwYZ3Ea1q3Cs0kpULedbRdnamlm3N+q3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6ihZ1tFn+TN9L7aJOXfFl9Kifh/6KjQljqFJhDoSzQd43XtTiCWzqexdWcgXPSv+AmXOivissHr6uwxFRFLiKa5yEcEnLNR/67+2mbMmSfnjBiWdn0DOsKmiTv16J4BVK+p1WkwqlSuC8dagY9QKTHkF8eEljd7s781lamzp80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC4yZaL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6A3C4CEED;
	Thu, 24 Jul 2025 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753352972;
	bh=4PvlALyP5ZXwYZ3Ea1q3Cs0kpULedbRdnamlm3N+q3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PC4yZaL1gJ8sMgcuCOxEmYqq4UJfpkW/XGLg+LxFNY9SHo1r8FMW3r9hd+XACOld/
	 YlL/Wu9bt9Ufhi3j3WxMxpzwYoCEs3Esir3qSuyVmvMv60FxybzyBe8Rz2E1nxkhAl
	 dUWjqKKmnG0NjCeRbphNlFjkjzeuc3JgvOY1AYiZN7ChYojKfqe1E1F9spvKBySiy/
	 /V4WBEMIPl4mozcs7F/VR3UyK/dxRUQp9jSu9UbqNKgSo2ZOD1TZpGKkegtNzcMB/H
	 E05XlnS1QOVriHcr6Bmv+DCe2Vr6M7v9B/EYwEu2K3wrJfELHSyv/OiUaCuU2CXuZl
	 FT1SDGbiCljeQ==
Date: Thu, 24 Jul 2025 12:29:30 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 3/7] timers: Use scoped_guard when setting/clearing
 the tmigr available flag
Message-ID: <aIILCj1BSMKPNZ47@localhost.localdomain>
References: <20250714133050.193108-9-gmonaco@redhat.com>
 <20250714133050.193108-12-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714133050.193108-12-gmonaco@redhat.com>

Le Mon, Jul 14, 2025 at 03:30:54PM +0200, Gabriele Monaco a écrit :
> Cleanup tmigr_clear_cpu_available() and tmigr_set_cpu_available() to
> prepare for easier checks on the available flag.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

