Return-Path: <linux-kernel+bounces-762546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BDB2084E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C874217BA33
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C822D321A;
	Mon, 11 Aug 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIMANRA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4CF2BE7B3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913911; cv=none; b=o0bC5DM7eePIRk/gL1HEWGb0zEr7vWkPlb3YA+Xbzb2bYAJvXi6KcpxlHci2SmSe/Bfh7usKhnafysnLGmE6I8uMXq/dyN8O+2D1qZnF+FsldokKNVeBsvgEB21cidStpmIqcZhta7fp8YCoxPCeZPoa/rzUq3w2OS7/VTZ0ZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913911; c=relaxed/simple;
	bh=99hH0t8BmmfPSDcs9stJyBQ4nZ4aeI4XZXCgdCqeWrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bq49lsyGndppmOcMrwQHhxZpRDtnmcbom82QmX8B6dgs2LhfbJxtovwn98Sj4GlKWXrBJbODFdn4xU8E/Jg3ZxoozV0rZ2jgtTmVef/yeNBkLEkyguk9vala49l9WqG27E9/Xg/qJ2M1W9d6NrI3mg+MO9lyWiRJOnenGz89Gq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIMANRA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21D1C4CEED;
	Mon, 11 Aug 2025 12:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754913911;
	bh=99hH0t8BmmfPSDcs9stJyBQ4nZ4aeI4XZXCgdCqeWrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIMANRA9nU5eZ1bzDo+BC5F8pExgAUWt7KrajDRY/AfArlsWTYAm3kVSYB4fO+oq3
	 5EC7KOvhf7V2jrHa5Unb2c8DbmteD1FvX+9wgjvfFkWz3syM88CebGsT5AHd4jpeaH
	 j5kVs1/QDAIveeZOXLhJgPelFF/srTkxtKX1YmdTqjxmqMlNoMBSB5861aLmR4c4ra
	 QTYSdOKaNjrbh2xN1r0dcnyafPtKFhVvws+qT0i/1TWwPRpfyOxwSEe4/RU3oJ3l02
	 xbGnJ+JchYMsq1s4tV/q7cpUgtOperSN/quzRdsYKVhC43ax8+KCQN5bnmyw9Le3Z+
	 EIYfAKKyWIPVw==
Date: Mon, 11 Aug 2025 13:05:06 +0100
From: Will Deacon <will@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: fanqincui <fanqincui@163.com>, catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Fanqin Cui <cuifq1@chinatelecom.cn>, hanht2@chinatelecom.cn
Subject: Re: [PATCH] arm64/module: Support for patching modules during runtime
Message-ID: <aJnccgC5E-ui2Oqo@willie-the-truck>
References: <20250807072700.348514-1-fanqincui@163.com>
 <aJXlegQfZTdimS3k@willie-the-truck>
 <3d4011c0.6aaa.198981027d7.Coremail.fanqincui@163.com>
 <86zfc68exk.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86zfc68exk.wl-maz@kernel.org>

On Mon, Aug 11, 2025 at 09:01:43AM +0100, Marc Zyngier wrote:
> On Mon, 11 Aug 2025 08:37:32 +0100,
> fanqincui <fanqincui@163.com> wrote:
> > 
> > Hi will,
> > Yes, you are right. The alternative callback function lives inside the module.
> > This callback function is actually similar to kvm_update_va_mask in KVM;
> > 
> > The module's callback function calculates some values based on
> > the current CPU features and then performs the replacement.
> > 
> > The .text.alternative_cb section is actually marked as SHF_EXECINSTR | SHF_ALLOC
> > during compilation, so intersections() includes this section and sets it as executable later.
> 
> I'm worried there is a chicken-and-egg problem here. What if the
> callback itself requires patching via some other alternative? Is there
> a guarantee that this always performed in the correct order?

Maybe we should just reject loading modules that have alternative
callbacks that don't reside in the kernel text? I _think_ that should
cover all the in-tree users, although I didn't get a reply to my
question asking which module triggered this bug report.

Will

