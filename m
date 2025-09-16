Return-Path: <linux-kernel+bounces-818684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDF7B5951E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A58F1B27EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30382D6E7A;
	Tue, 16 Sep 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvvCaRh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0372D0626
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022060; cv=none; b=uNSFM22L2Yg/Lmm2DV7v5rW/WbxbdbnOypuMu2tfFkxqLfB452/dXMxFkYAh+JdYVWmJmgDwEv9exgnwaHvAtoMYMeT37D1iS7hpQ11oMYMIJ0ymGdxrGrLcKrOGo59PFaGogUIYuMoAFIoSR6dexOhCt9CIYnrCY0uHloptfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022060; c=relaxed/simple;
	bh=okEYccf6hmjUkWPil+AoQbOYKl0uGSFJhrQ1afLCbyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZB7zkKE5zVaFsVGo2ry5nxFFoniRvPMptOK/WInz7GRMSRHTo13NxGTk/g3Hk7lFhuTh77oqB+NWtbBWT3W0jvyD33rzzbeG7hnJatj+bKnpZhs9257lVzSr5j4mF58oyKEfjN7pNANnvqgml7wrNF0f/r/X5k3Dm5xqlcANhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvvCaRh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E25C4CEF0;
	Tue, 16 Sep 2025 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758022059;
	bh=okEYccf6hmjUkWPil+AoQbOYKl0uGSFJhrQ1afLCbyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvvCaRh+58pjObJhqL+paAUEBxxADwJi1eZVRfFbggxL8bXfR5Il3tpyG0z14qQyC
	 PRUWCcd1Pp2GVpkijSZHY8uGMsPaK0i4uoIt3d95LcV947794vKo65Ti6O4IiFBWyS
	 UwGT2E+/jnAOp5qrbzW7DqG8qOVh9H5pX/B0YKBHgCUZ7W9JbSlln38XBnBB9JJYHd
	 DXYXYMJU3uSbfruvITrvQAA5WNFon2C73xN5/FNTto27zXBU0R0VYssO4MZ4k5Obp1
	 8aENP9KQ2Bw1dymL8RSj7y+g51GytSG9iB32VL5IIjXHpW0NfVn9nxP1pMzE/s/xxf
	 YBWoaHx/aoYMw==
Date: Tue, 16 Sep 2025 13:27:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 8/9] cpumask: Add initialiser CPUMASK_NULL to use
 cleanup helpers
Message-ID: <aMlJqDjWNyak07LX@localhost.localdomain>
References: <20250915145920.140180-11-gmonaco@redhat.com>
 <20250915145920.140180-19-gmonaco@redhat.com>
 <aMg5EzmxG3hG7aJK@yury>
 <820443ea-56d7-4fd0-9535-b1339e53240c@redhat.com>
 <aMhcYCCJDFWoxcyw@yury>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMhcYCCJDFWoxcyw@yury>

Le Mon, Sep 15, 2025 at 02:35:12PM -0400, Yury Norov a écrit :
> On Mon, Sep 15, 2025 at 05:02:45PM +0000, Gabriele Monaco wrote:
> > 2025-09-15T16:04:53Z Yury Norov <yury.norov@gmail.com>:
> > > So why don't you pick the original patch instead?
> > 
> > In my opinion, the /juice/ of that patch was included with [1], here I'm just adding part of it.
> > If you prefer I can pick that patch and adapt the commit message to reflect only the part included here.
> > 
> > [1] - https://lore.kernel.org/lkml/1706509267-17754-3-git-send-email-schakrabarti@linux.microsoft.com/
> 
> Yes please.

And can we rename CPUMASK_NULL to CPUMASK_VAR_NULL to avoid accidents/confusion with real
cpumasks initializations?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

