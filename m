Return-Path: <linux-kernel+bounces-811870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1C1B52EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B45DA022DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247AB2561A2;
	Thu, 11 Sep 2025 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuT7IwUb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F101288DB;
	Thu, 11 Sep 2025 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587545; cv=none; b=VMx/jTuPig4Wy1PhXAQygfccm3BGpNfX5Nzd9hvVwWPfCAuRspt27lKSQXzC6PikDxgq1cdsDoj/BZ8cOdAtbQRPa+DccObVQ2B8EstwInmK4RcolMtJnxWzN1JqMlh4rBKBkfofIR28FgOgPM9Ajq3MhA3dtXngL6b9UT8F8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587545; c=relaxed/simple;
	bh=PGyDk1kwqGlGnY3yqeZ/nZfsn2kc59VhhIU4X3i/eeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LI0cl6HmdwXhwypMxQCj+OcYf5N1Zx3XipGc4RYVMoJh8uMbMN+Co4R2mVQjyH+JrS/ZWrVwTviPZD7TH7qXJLHJg52jCaC0rOEmRW0ywFljNrZts74yMRznrTmD+rhbQ2dNscoAHtwhqwaXGV+JhvOUsgFhXJrlNYbyHbmhgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuT7IwUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFFFC4CEF0;
	Thu, 11 Sep 2025 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757587545;
	bh=PGyDk1kwqGlGnY3yqeZ/nZfsn2kc59VhhIU4X3i/eeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuT7IwUbgks03qK2f0vhYdkQCen+8efFQlrm47Cx6jX3sPXHFNHTMnraulcUqesJC
	 B2lz34YXedawFyi4zm46L+nfH3bBrY1Ms7xsxIa3ehMFqKdp/laLj0xmSbFLSoM+8Q
	 70Fa0AV6eM564L9iFrsiJgBBy5/7xymNcAw6FYfOY87bG+K8ItiAy1R4rendvueBdm
	 p/Oz8zdiLGDojoD8iClA1zNi2gRbcTpRKcpqz8ZtE39gyFnrlZ3KZ70x4rFmTM017l
	 5ld/W+ON8o4V794YJxICl4fpum2zWzewp5Dr3CgMP9FnqfACJvnlEkaPCHhllXCRRh
	 dGIl3qz0hD/bw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uweoA-00000007A23-1Dov;
	Thu, 11 Sep 2025 12:45:42 +0200
Date: Thu, 11 Sep 2025 12:45:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/19] tools/docs: python_version: move version check
 from sphinx-pre-install
Message-ID: <uuiuvshiofi23es4rr6mzjdruagua34la7vfsw3qo6ozwgs7vj@bskm4epl4twu>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <784ca5070326558220cc275deaa046a274badebe.1756969623.git.mchehab+huawei@kernel.org>
 <12f948d2bb995d9321ce07d8765e00bcbd822402@intel.com>
 <20250910142427.61347215@foz.lan>
 <62eddeec2ac82b6631957a8ce1dea330fd6862f7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62eddeec2ac82b6631957a8ce1dea330fd6862f7@intel.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Thu, Sep 11, 2025 at 01:28:28PM +0300, Jani Nikula wrote:
> On Wed, 10 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Em Wed, 10 Sep 2025 13:14:33 +0300
> > Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >
> >> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >> > +        # Restart script using the newer version  
> >> 
> >> I thought the whole idea of restarting was completely rejected by
> >> approximately everyone?!
> >
> > This patch is just moving the code. There is a patch after this one
> > changing the behavior.
> 
> Shouldn't we fix that kind of problems first, instead of refactoring?

The patch order doesn't matter, provided that it won't break bisect.

-- 
Thanks,
Mauro

