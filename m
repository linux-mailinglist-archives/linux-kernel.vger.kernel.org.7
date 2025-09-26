Return-Path: <linux-kernel+bounces-834448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07470BA4B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266D71B28922
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A975C305E08;
	Fri, 26 Sep 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKBeNyTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4AEAE7;
	Fri, 26 Sep 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905301; cv=none; b=krWJcDiV8s2WNOld/9ddR/yJraWWLrMkecnIE5GEQdnyB+k0w+LQbAETwqhXLJys51XtXt7XoBz5jAAvqYpQiYc1LGnF184Y3nh0U/HXd0eMz2XjY6SCe+GO6hkubht/z75md7xKYIWgWHCajKd2H6GQOHZtVICuxNUUHdFSaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905301; c=relaxed/simple;
	bh=aYe63XxFo5QK5aUoNElZrceNs4q+2bbOZSo6fH9A2yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOAYRIegP4nxoyXfmNGN3167QQr9c4WegWkqkgmTfqtf1jkF0pftPcJwGBf6MhKKwT1uAhLCpOCPj4MrncSqi6q+B6qP0AsiWA/Pt+ElydG8O3tdVrjvjaeCk7/Ffvzxh3JdFrHnBcyAFgwso9MlENfbN4dk9CbPEeNG2WRJ8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKBeNyTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EDDC4CEF4;
	Fri, 26 Sep 2025 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758905300;
	bh=aYe63XxFo5QK5aUoNElZrceNs4q+2bbOZSo6fH9A2yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKBeNyTfZoeAbJGWR81rox3ej+WWPKIvKoyNEPK7NSjlkDGjSMTL3/5UK5wwozUhG
	 CCH/ppGVSt9l985fXQQP1fBIGCEr/ecyaodXtxHBn8IhMIVarxoRf4K6E9LPNuyCtd
	 FAvm1R2qAt9JJtMyqzjZVzZ6dyiQLsbYN5hVL+BkxfGtA54Hx7P2ChCQnjwHx9WvVr
	 /iteW81eOhBYpgTqZe6lEsbI5lb2MnudAVS55QTckba4z7sVxXxcbCT4sTR3xv75Kc
	 +/RJDS1UnxncAk1yMAWmdtnaRgSdvOY/dPX8+p6lHcRYARcuFylrSBr7Zuw2zCXFDy
	 qrCiiKtc+A5HA==
Date: Fri, 26 Sep 2025 06:48:19 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 12/14] sched: Add shared runqueue locking to
 __task_rq_lock()
Message-ID: <aNbD004LOA9xOF27@slm.duckdns.org>
References: <20250910155809.684653538@infradead.org>
 <aMNnLenCytO_KEKg@slm.duckdns.org>
 <20250912115459.GZ3289052@noisy.programming.kicks-ass.net>
 <aMRexZ_SIUVgkIpZ@slm.duckdns.org>
 <20250915083815.GB3289052@noisy.programming.kicks-ass.net>
 <aMnk5Wcdr2q6BWqR@slm.duckdns.org>
 <aMnnslT_mUfAtytN@slm.duckdns.org>
 <20250925083533.GW4067720@noisy.programming.kicks-ass.net>
 <aNW3du48v3PvwPbq@slm.duckdns.org>
 <20250926095934.GD4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926095934.GD4067720@noisy.programming.kicks-ass.net>

On Fri, Sep 26, 2025 at 11:59:34AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 25, 2025 at 11:43:18AM -1000, Tejun Heo wrote:
> 
> > Can you point me to the RT interaction issue?
> 
> https://lkml.kernel.org/r/fca528bb34394de3a7e87a873fadd9df@honor.com

Ah, that one. Thought there was another RT proper issue. That's the one
which can be solved by having post-pick_task() hook.

Thanks.

-- 
tejun

