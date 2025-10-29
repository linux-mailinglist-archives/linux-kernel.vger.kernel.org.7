Return-Path: <linux-kernel+bounces-876525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CFEC1BD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1841B5C5952
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAE1F5827;
	Wed, 29 Oct 2025 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMRXmryx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED692D6400;
	Wed, 29 Oct 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751878; cv=none; b=P93XjTq+kRYkjcGX0bS2fqM4yVDuMDWeEn1wVmDAj+NCp8J813jNfW8PA1LfYNyP1u1c8t8RP/tNQZH1YjvUgF5gsLEs2M75ZNlncn3DDLqogW3mNzU5O0jFv0Ioa8mpzO4afHchNGahfN7c5wKcHsGM9PGTAL+RHB3oP5+f730=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751878; c=relaxed/simple;
	bh=bpM3pbImB18M6jWoNhB6h/A5FON6+44Q0QgkUbxqClE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=J3wu3ZW7o4i3fxp9/jPbn4fQSLaDTbbkberNMD4KbYKUK+XHhBhljmR+Y+Zo2coo2OUMhtDBJMK+DzgnfnqWzTQR4Yz53YfX87xVyT3bSCmrIEv1bV3UmeEU+oUvr0R7UZOULj1LfIBq0b4zgCqjaOJJ4MZb+O1TpIGKWcflHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMRXmryx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518B7C4CEF7;
	Wed, 29 Oct 2025 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751878;
	bh=bpM3pbImB18M6jWoNhB6h/A5FON6+44Q0QgkUbxqClE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hMRXmryx9p/dxSsdH3qYk6wu0A7kfdmevu9Rpb/4IoVRF75SK2gjOjB/CQDDBAvCI
	 yHmOFjX3W7GKvKrmd1kw9NgEy37FNxBHzlVN5M7kaSymU9pf8SljZ0ovnboPonRSgg
	 w2UqNgsHb7e0lyjsoe9RE513PhGTDBRT3gctx44O/26rtPC7HfvAl5M6LlLdok6Ng3
	 tC05QrexpUrl3dI44vtydLrwYOTyId31kycX792tlUcSAnAo3qSRPZHa3++R+dm3wN
	 TY+zgyLLv7iUGP3HDi5QgFFKNjooQnMhR8OjZ89QDg4AtowzaVNnorH5DdFgV1/GNT
	 AVpwUjY4pmD9Q==
Date: Wed, 29 Oct 2025 05:31:17 -1000
Message-ID: <59f2be0d936552dc199ddacb6510c59d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCHSET sched_ext/for-6.19] sched_ext: Deprecate ops.cpu_acquire/release()
In-Reply-To: <20251025001849.1915635-1-tj@kernel.org>
References: <20251025001849.1915635-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> Tejun Heo (3):
>   sched_ext: Split schedule_deferred() into locked and unlocked variants
>   sched_ext: Factor out reenq_local() from scx_bpf_reenqueue_local()
>   sched_ext: Allow scx_bpf_reenqueue_local() to be called from anywhere

Applied 1-3 to sched_ext/for-6.19 with minor description adjustment in #3
responding to Peter's feedback.

Thanks.
--
tejun

