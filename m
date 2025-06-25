Return-Path: <linux-kernel+bounces-702359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632FAE816C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A296618961A8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 11:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CBD2DA747;
	Wed, 25 Jun 2025 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvLbqGYw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5552BE7B1;
	Wed, 25 Jun 2025 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750850993; cv=none; b=Gp4OptftE3W/aq7MurHxaQ6E3fDPletyGhfhtPJ4m5pf3pAqVkRvnYBryjDM4FFq4Exr+DjuCM68wJT/F0OWK6+f4ukqKe8+fd74iSqfp/1xfExdVuOJ6TJw4t5/fJ4rKfGF+OBf3VmPP/geWfrQFtW9Dde+fHK0TyJeSjWRb1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750850993; c=relaxed/simple;
	bh=yc+bpIzj3RuTCwRqaRtkYp2iO7JryhOC28AKjYU3ePA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMw97BXQ0R9meErPSWjgnKQ095SfYw7Q3Ez2HGEuxhwr7JxRUzm+DE9rXFRhRfcMYZoLNIB6dM1zzbGeGtGkmqkJsRa6KusBXnQqLMjCkoeoZPzSIwCeBOk4D/kzsIscsgrv6op4iNQ0ypyel5TiS5u31J1NIFlMhcOO8w9KTfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvLbqGYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049EFC4CEEA;
	Wed, 25 Jun 2025 11:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750850993;
	bh=yc+bpIzj3RuTCwRqaRtkYp2iO7JryhOC28AKjYU3ePA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvLbqGYwHXqjRDfqbaU7n7qxtI6yueJeCM14y35ldQmRRAJTNz1w9et8Oq9KLIDhW
	 vaFUSEL77Zd2ZiRKhM937si8P2vMES45oDEJh9FQSMsejqssy2B4TPtmcHNnn2S68c
	 +2Md4o66VIRkBt+xcfD1kQU1wVVmAEVHyi43sNuu81vZypTvLmy7auK4m6xkfyViMS
	 in7fksxijOGQgNbY20SLDh9gs8r7wQJmPZUxFpwCvTtTU4LhPGRF3Oh+VRAE0hzros
	 yGxUfQFFkhaWxOzuqwjivog1PwboaWp7z4z0jLjBj0OI0bV3G2h/hAL3efrWKNH4Ks
	 4XAFiBgYwpwqg==
Date: Wed, 25 Jun 2025 14:29:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: chelsy ratnawat <chelsyratnawat2001@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Replace scnprintf() with sysfs_emit() and
 sysfs_emit_at() in sysfs show functions
Message-ID: <aFvdrcoPJTtneJy6@kernel.org>
References: <20250619123707.399022-1-chelsyratnawat2001@gmail.com>
 <aFs4H0gT286-cmvC@kernel.org>
 <CAOeBcHNpsz5-gapd4pVO5vryENHhFrL18Mkxpe+YLndL3rY=Rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOeBcHNpsz5-gapd4pVO5vryENHhFrL18Mkxpe+YLndL3rY=Rw@mail.gmail.com>

On Wed, Jun 25, 2025 at 10:35:25AM +0530, chelsy ratnawat wrote:
> Thanks for the feedback. Updated the commit message and sent v4.
> 
> Chelsy.

Please read

https://www.kernel.org/doc/html/latest/process/email-clients.html

vger will ignore HTML emails.

BR, Jarkko 

