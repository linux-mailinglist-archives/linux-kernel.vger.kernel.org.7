Return-Path: <linux-kernel+bounces-877127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF5C1D44A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E033B070A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF782C375E;
	Wed, 29 Oct 2025 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIAl34wu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B81B3923;
	Wed, 29 Oct 2025 20:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761770771; cv=none; b=m636VSek5bxiGjuWYDPeqeu1Ud1G/YKKsV42pi9vtC8W2hnsFJbodRJd3UEMR7lKZcjDAUIzTU8/WKZUz/L0T3WsbBdKIzrfygTxjrhKBSDu4+AK9Qle2UKsDbVCZP0yQrFWkwlIUHAxhVc83p33IXgta+mdzxBxWMKmMTUfJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761770771; c=relaxed/simple;
	bh=ddXQqh+x+Kwhy4WZ/KiwyJzyhhYJujXrSFpF1btAfxo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=eBBBBXNe0qdemDzbQrzrWsVVwf7TOdjq34BUZFpSKKXwLGyV/O3LWsu+Eo8XrcliiJVs7X5VIqNQ7NVGzHNHptVq9is1feaTXLEHPyTdhgHQ7S/I4eXn44XL9bukoYAFvFGZ7LUfJ+fwWFA2Y9eP49zaw0DovxLCCPjizOWoXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIAl34wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA20C4CEFB;
	Wed, 29 Oct 2025 20:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761770770;
	bh=ddXQqh+x+Kwhy4WZ/KiwyJzyhhYJujXrSFpF1btAfxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AIAl34wu9WmP4CMpqpDbWdQ+8vXWhibFwvWgVb2OC04yRaSA1UG05ngrjdPOPSeJj
	 zQDJwXJO+m/sEdihfzH8Sjk+YnOWIHGE6gJDfq3PClfsmqoxhv8IkIniBL+DJpqFuX
	 cRdUPweJxYWpbzf+ASr9+vwqcizCuj/Efzi2p2VyMhngZghXc8/cYoRZKkWGNOhsSg
	 eJRCHlv33bmnvSOogriGi3a4Q9c8tH6k+KM6U54/98ljLFzJAFhNKeZwszQswBgICf
	 P21+rUXuas2jx1Wdr+8W1CKINyjkNJ00JuHOW5bA4LFtbt/u1XbhLCcw6TygqBdz3r
	 QjE+Jc9XDrJSQ==
Date: Wed, 29 Oct 2025 10:46:09 -1000
Message-ID: <0bac90274a876d04c27cdd366c336768@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext/tools: Restore backward compat with v6.12 kernels
In-Reply-To: <33d319a7063f59638ae1be709f4e10e9@kernel.org>
References: <33d319a7063f59638ae1be709f4e10e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Applied to sched_ext/for-6.19 with the following comment lines removed as
they were from earlier and no longer apply:

 * Build error is triggered if old names are used. New binaries work with both
 * new and old names. The compat macros will be removed on v6.15 release.

Thanks.
--
tejun

