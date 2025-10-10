Return-Path: <linux-kernel+bounces-848451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FCABCDCDD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87D2B4E3FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3737237A4F;
	Fri, 10 Oct 2025 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3Kfn4M0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4463CB;
	Fri, 10 Oct 2025 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760110242; cv=none; b=gYZHb5QM2nQIKq8fKaCIZvGRDvjkehgSLrbDokc8balvUoTjRHukNnTNbXZ0EBXFD2qToOtXYwSHCw+P4w853JGIK2m2k1qdOri+2UsYdbwO6dY/QW0d9N/p+wrOHwl/a2uO1C6Qj3mEdsOC/yIEQEIYDZuqSYU/vN3EOaZpxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760110242; c=relaxed/simple;
	bh=0FgtE1FuFrHwceHZSNRvv7QKCEuf2vCRcpmToNvcTM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsN8RDVEAHC0XoDbwe/GeEGzazpPuEZjhdcSA5LwJ61CoAnOKmntrHp4Jo2rl87hrF1pz9D9XcpdNHtRByinYRhZHv1IdiVPSChCQ6/b/6rdLcmzVIGujufg4uqMawyi4ylWkBP21P9yzm0BKcJQLrbQwdQhbzz4SZlGVZlyz9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3Kfn4M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47B61C4CEF1;
	Fri, 10 Oct 2025 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760110241;
	bh=0FgtE1FuFrHwceHZSNRvv7QKCEuf2vCRcpmToNvcTM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s3Kfn4M0lb4wTDv8wieX2f0AvhGWKL1IoFAy/L8eAE6XujDAk8AxOL+7uxjEXDfTU
	 bNu38ehshYV81JrxIWLTGazoUyS6OFe2xd80xrmgeDO7aZnCQ5K2IbUjI3iA1wBck+
	 LGMLCaioBrIGq+rsBpSbJdOewvGLNgFp+BoPE5bdx2iy+MLA2Esk4WVIx7NCEWijLM
	 VmaoR8sVJ3ef58ckorK/j5sL3t/9yRJWtaXdwPt7MecnHzWsOmPT022Kqur79CtTkt
	 nRHpOHqpQRt7U5qM2NcTfIkG6kI9ZyX2E5hvUKcejE1fiXdoWVZJ/tOsvq1qQ09Dmw
	 s6rwL3sOZ/t5w==
Date: Fri, 10 Oct 2025 17:30:37 +0200
From: Greg Kroah-Hartman <gregkh@kernel.org>
To: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2022-50455: nfs: fix possible null-ptr-deref when parsing
 param
Message-ID: <2025101056-coleslaw-underrate-ec0e@gregkh>
References: <2025100118-CVE-2022-50455-24fb@gregkh>
 <54b0b560-493b-4f08-859c-8c1c41cf4c27@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b0b560-493b-4f08-859c-8c1c41cf4c27@huaweicloud.com>

On Fri, Oct 10, 2025 at 10:19:40AM +0800, Wang Zhaolong wrote:
> 
> 
> 
> 
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > nfs: fix possible null-ptr-deref when parsing param
> > 
> > According to commit "vfs: parse: deal with zero length string value",
> > kernel will set the param->string to null pointer in vfs_parse_fs_string()
> > if fs string has zero length.
> > 
> 
> Hi Greg,
> 
> The patch "vfs: parse: deal with zero length string value", which introduced
> this issue, was never merged into mainline.
> 
> It only exists in the mailing list:
> https://lists.openwall.net/linux-kernel/2022/06/28/18

Please always use lore.kernel.org for emails, I had to go dig out the
whole thread from there based on that to determine what happened here :(

> Since the problematic behavior never existed in any released kernel,
> CVE-2022-50455 cannot be valid.
> 
> Please consider rejecting this CVE.

Makes sense, I'll go reject this now, thanks for the review!

greg k-h

