Return-Path: <linux-kernel+bounces-889889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57447C3EC44
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 284684E7979
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130E330BB97;
	Fri,  7 Nov 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="faPVeM6o"
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2F30ACEA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500961; cv=none; b=dbe28r9sRSaobqzjsKrSQI8Lrcp3XSf9hhE5lsnu0uvgWmxfym3DGjhNcwNvh9/0cwm7WtV74Kw+WT06TpTdqfZyUKTc8UB2czObEdWNsS3T1mm1bAXsd7VzdeWzvqQdK6Hj41dYyICVJEiykljTAPohKhNvyg/dkTnR497DEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500961; c=relaxed/simple;
	bh=wxnF9UDlN2KL8vWxyumUhUWhZYGScRCsMP3ZVZwv4Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d04cKHr6RIWSTQ+3aS6hZ2G/iWyi17Lrgj+W0gCjTF7Bt8iRz3JE3JEBug6gOtvFNsYzoB3BtmRmDnAu8Jwei/EndD5Gy+GfGdGV5PgOqUJddGyqeXKtCll8H6BKBicPuakZketnEjGpiJvdnzLOHJl4k1UJeCWmwWtT9coGTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=faPVeM6o; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1762500953;
	bh=FEpZb56KqjnmaWgqu/CaFTzPbPpQX/a3IPoGROSJb7U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=faPVeM6ocDn51QCXUA5svNYAOiE1SPL+kMhOIb1ldVz/pPS3TbG01OtWWoi2FgYXy
	 mUW4bkC9IDfc7AbZxJp2FsMkm3WrT+TCFKuS5zv523V/RqQS/wVebfq5qHqnn72+Ge
	 X2K49IfuAIjUuslT9S8fcLHvZHcuxjvMj4Qxwdec=
X-QQ-mid: zesmtpgz6t1762500949t9e620a40
X-QQ-Originating-IP: +YsyyQuPJCCGIZfNP5VNn0BbnRKFOlzj0C7lA1Gl3YU=
Received: from = ( [183.48.246.190])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 07 Nov 2025 15:35:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10424017919000955698
EX-QQ-RecipientCnt: 16
Date: Fri, 7 Nov 2025 15:35:47 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Xuyang Dong <dongxuyang@eswincomputing.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, mturquette@baylibre.com,
	sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bmasney@redhat.com,
	troy.mitchell@linux.spacemit.com, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
	huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: Re: [PATCH v7 0/2] Add driver support for ESWIN eic700 SoC clock
 controller
Message-ID: <1618037D174FDF5F+aQ2hU1J9oLEKCq25@kernel.org>
References: <20251023071658.455-1-dongxuyang@eswincomputing.com>
 <1abb85b.c11.19a582bcbbc.Coremail.dongxuyang@eswincomputing.com>
 <039a3a41-c60f-4296-afd9-2bf3467574ca@kernel.org>
 <6d2d7ddb.cbd.19a5cf92465.Coremail.dongxuyang@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d2d7ddb.cbd.19a5cf92465.Coremail.dongxuyang@eswincomputing.com>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MOsFB0BkgYBJ7lTPqLfjz7TfbtmY65yLFzNZ606shFGVI8mQgIbKg6hR
	1jSzsm45JxpAzvFb2rpYPIyvtdhPw0LL6luJy0giIFMHSBASgbbu3GEl2+06B/ntHEBg8t9
	a5e0GBGI05OgK4C728dE3wpB6WR6fhao0pCNmCyY1PQi9/NwFzu0CO82pSEz3rzUbclgrp8
	RkkXElysGsu2yKJCgUXXIn9q2+iEKhqWj7Pkd4QoqPqsDPXV7hcZt/g+LOVf1stobtt9k4r
	cd1xiGYR+9hdZ/1RvxdqtOJQ8HfvIbI3kq6+WpRP3mb+HTGN/0RyVL9XZ7D85lSZbE5yLa0
	yocW4cwco124yJiyRoECClz4cxf3Q70u2OxB5aoSn6o/R7PpRZBsQipnOnW7Y/9Q8e86BBE
	eid1j/OqhHoGMoMXskJBktx2VqFXuYoE4s5/w4GhWwvhWxK2TY6+hZz5P8WYDZ2gBEfoviu
	hgOC8VEJgzm/q/OiF5XeJNtKaNkIEjDA3uX3ALpTHFRz4L0BE6TLVab8bCVsEK/fp6aokMI
	lFvixO1HQWXSPOrZBbY9TVMrhhxXdGcBNhwNlCAMr19cP+29Nf+PNCm7ftBMa2Ao1T/5qHU
	vReszkbgQrwRzptwtbPiZFxHDJV6jePpwFN0/c7QFrqzCOKjxUacX4v2t9kEXZuCzsswfq7
	k1A8ODge9qTuVGpFSGV8ltaBISTcH+IYggNxzwu8MGeOJA2sfqyG7ptkqlvoQl/LUCqRQua
	fAUJ1BHCIr+phhFirdOcYkfRnMahp4aCvDSC/R1g+i+6fVMzOANGNUrIX0oo1nQAhQXhO1J
	SdK7QMzGBPCtAy3akuLorj7Wq+FdLHkZF9DNbt7/8daRAPl0m68LGnu4af7Y6IIYXZNFcia
	edUvOFkjUaoayrVKiMhc70nmqtoqdmetGT4bvFKOQeDzyK1gtC3iEva8NVRVFXlL8GMe2BJ
	kGhY0km1Cp8fSVmM2ToWmaI1BlIRrSUheXsw03asZdFt6JvITviAjl9SnCCTAXR0KRyDMvR
	8d/+0GC2J6WcW17UJ8A0td2peo4C+JlqY0Bo6JTiIoVsC7dozFerosuscc0jx3rAhlh4pL8
	D5dedAe255auKHEF4CUjwo1uJHVkHpBgIa7dsSk333Y9qY3/PaIz3KLjkOwOQnMLZHY5Fzp
	AZjzfWj/KKLNckqr8zA0S4Ft/w==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi Xuyang,

On Fri, Nov 07, 2025 at 02:20:23PM +0800, Xuyang Dong wrote:
> > > 
> > >   Gentle ping. Looking forward to your reply. Thank you very much!
> > 
> > Please do not top post.
> > 
> > You did not add any maintainers of these drivers, so I would not put it
> > high on our priority list. 
Do you have any plans to become a maintainer? If so, this patch might get
reviewed with higher priority. I think that's what Krzysztof meant.

                              - Troy
> >
> > Ask yourself - why would community
> > maintainer like to take unmaintained driver? So the community maintainer
> > would maintain, right? To add him more work? If that is the case, isn't
> > better not to take the driver? You see where I am getting at?
> > 
> > Also, I don't see any involvement in reviews from eswin. The only
> > reviews here where from DT maintainers, Troy and Brian (I hope I did not
> > miss anyone), so again - you just put all the effort on us and then ping
> > us...
> > 
> 
> Hello Krzysztof Brian Troy,
> 
> Would you kindly review the updated v7 patches at your earliest convenience?
> 
> Thanks to Krzysztof for your reply.
> 
> These patches have already undergone review within our internal team. 
> The reason for adding eswin maintainers to the mailing list is to ensure 
> that these colleagues can promptly receive community feedback and stay 
> informed of the discussions.
> 
> Regards,
> Xuyang Dong

