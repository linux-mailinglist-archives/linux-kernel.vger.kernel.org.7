Return-Path: <linux-kernel+bounces-837585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10782BACAC1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11443ACFCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BFD2F533A;
	Tue, 30 Sep 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A2Nxd7hI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899942F39C7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759231353; cv=none; b=AvUeFA+74yIozgUD1uAIUJ1sfvCk1Sqi/33YdvV9GvWc4FhFoMRC51YWV1IqFWs4rHkxlFAZRy/HGXZ/Cn2jWG1eajzzouespvVwVchSTBo2/S1eWthR121jDvS4BuL9Ao1fpIjZ7J2WyjuDMBUAf28cpqAmLCtZXbsoiVX/DZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759231353; c=relaxed/simple;
	bh=mxmlp0+kgm8oajba2F/5gG7EkSAUa/XXcrExOmQTeBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAu8VQd30QX85IrqOWjKu5ftlE6jogB0v67A03eCUODCGef3wazOoyXtOA7hJqGOU+a3w9iD8oy8u3Q6a5t0aoZq0JbOVn8MGEEDk6jnXIX+mw8rT7WDL1fi2Rj4q5f7cej1Um1A6bC4hcLupm/kB3sYvn/yGXd1e8LCwddChF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A2Nxd7hI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D86C4CEF0;
	Tue, 30 Sep 2025 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759231353;
	bh=mxmlp0+kgm8oajba2F/5gG7EkSAUa/XXcrExOmQTeBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A2Nxd7hIV+beq2nHXhcEMCHhw2UtKlL80AshJFWwQV9p3Pr3ljmV0y+caBigB+Doq
	 IVcEYqa86RRxHeLMM27oXykjT8LoNPbca005ihujIqIwE0NlE/+SCq5oCSVxINLFVI
	 tiiMQD4TL75bHSSv4+gnFmbPaLC9HB0YVrKUSONo=
Date: Tue, 30 Sep 2025 13:22:30 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: "cve@kernel.org" <cve@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2025-38495: HID: core: ensure the allocated report buffer
 can contain the reserved report ID
Message-ID: <2025093058-iciness-talisman-8a9f@gregkh>
References: <2025072818-CVE-2025-38495-3b28@gregkh>
 <90bbbd1083635d251b04fd03ec81a4e7e4720bc2.camel@oracle.com>
 <2025093000-shrank-vending-2bd1@gregkh>
 <552d5ba4368ce43b12b4aa8b01852a4d8af1bdbc.camel@oracle.com>
 <2025093001-petted-boney-29c2@gregkh>
 <883ad6064549f85dc56b2669bc3f395191b3da9b.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883ad6064549f85dc56b2669bc3f395191b3da9b.camel@oracle.com>

On Tue, Sep 30, 2025 at 11:09:50AM +0000, Siddh Raman Pant wrote:
> On Tue, Sep 30 2025 at 16:29:03 +0530, gregkh@linuxfoundation.org
> wrote:
> > Then the second change is the one that gets the CVE.  Any "previous"
> > commits in a series that were preparing for the real fix are not called
> > out.  As each CVE entry says, do NOT cherry-pick, but rather always take
> > all of the commits in the stable release.
> 
> IMO it won't be nice to change an identifier now and a new ID should be
> assigned instead.

I do not understand.  We are not going to change anything here...

Let's start over.  Is the CVE referenced here in the Subject line, and
the git id it references not valid?  Does it not fix a vulnerability as
described?  Is there some other commit that also fixes a vulnerability
that should also be assigned to a new CVE?  Or is something else wrong
here?

thanks,

greg k-h

