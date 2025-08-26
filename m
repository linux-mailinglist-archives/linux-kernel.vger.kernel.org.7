Return-Path: <linux-kernel+bounces-786847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26059B36C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C12D984910
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429517C91;
	Tue, 26 Aug 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2fPU4KQO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD717E0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219801; cv=none; b=Mjpue7pszYC3Ju+ifIabJ0TQmjz+yuukqjo3HVzL/DMQVpS0HcfR7MW67YzecUqqRir9hX83RVca3XhdQXwL00OUA1GtijyC0oTzeBu2fLaVs61I7R91TOiwxat2xmdKzCKokdFRqHXh5PFZ4e6NxgKUOUsDNxEm8smiA1sukD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219801; c=relaxed/simple;
	bh=D+Zva5lmwjjzMv61oTaAjEFaDEaH0w9a5G+EsYG6BVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXemdJhB2pFQQSeTX8+4gOos6qM8AuqrymTKOCg2rx2iGjtdwfdPUREH1AqJBf4AWRRzuqYxS2SF2Ao8SajLfFz1mcTBF/4y5qoFhf+u8TyK8srG/IJlnBEBEqkxFKSaPTdOlbK9EXp7B3S+Ntvl85ozCef7gBUE3CatnHTJ4hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2fPU4KQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4C1C4CEF1;
	Tue, 26 Aug 2025 14:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219800;
	bh=D+Zva5lmwjjzMv61oTaAjEFaDEaH0w9a5G+EsYG6BVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2fPU4KQOwTPJ/itNyKaf3h1sL8k54fx98gPYrGXJRiWqUuegyOhKSNSvcQJs5DHbi
	 KwUOQyLrK8wTaHOn97KPMtFSl0C34oSjiCS9jNAtPceWdanRUHMVzSr/3pFGX7kw6M
	 +5sGfzpPy5fQLWKutdWsNfeEnJx1707L8OKiyajo=
Date: Tue, 26 Aug 2025 16:49:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cheng Yu <serein.chengyu@huawei.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org, tanghui20@huawei.com,
	zhangqiao22@huawei.com, huangjiale13@h-partners.com
Subject: Re: [Question] fix CVE-2022-49980 introduces deadlock in linux-5.10.y
Message-ID: <2025082627-sinuous-ovary-21c9@gregkh>
References: <2025061820-CVE-2022-49980-982c@gregkh>
 <20250826142418.961703-1-serein.chengyu@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826142418.961703-1-serein.chengyu@huawei.com>

On Tue, Aug 26, 2025 at 10:24:18PM +0800, Cheng Yu wrote:
> Hello,
> I noticed that the community has assigned CVE-2022-49980.
> I found that the issue described by this CVE also exists
> in the linux-5.10.y. Therefore, I attempted to backport
> the fix patch to the linux-5.10.y, but encountered a
> potential deadlock after applying the patch.
> The specific call path is as follows:
>    usb_add_gadget              [(1) mutex_lock(&udc_lock]
>      -> device_add
>        -> kobject_uevent
>          -> uevent_ops->uevent
>            -> dev->class->dev_uevent
>              -> usb_udc_uevent [(2) mutex_lock(&udc_lock)]
> This results in repeated acquisition of udc_lock, causing
> a deadlock.
> Does the community have any suggestions on how to resolve
> this new deadlock issue introduced by the CVE fix?

As you are making a business decision to stay on a very old kernel
version, I think that business decision includes doing the development
of fixes for it on your own :)

Seriously, the community doesn't do much, if any, work on older kernels
like this, especially ones as old as 5.10.y, as we do not even have
systems that run that kernel anymore.

Why not just move to a newer kernel version instead?  What's preventing
that from happening today?  You are going to have to do it soon anyway,
why not use this as a prompt to do so?

thanks,

greg k-h

