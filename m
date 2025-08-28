Return-Path: <linux-kernel+bounces-789167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE85DB391DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D414E1888804
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355D269D16;
	Thu, 28 Aug 2025 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AacTSgpz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3746D26656F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756349375; cv=none; b=M1X8G9/JKbva0ni7tN9DB678KRCHAg4LAr+VBWap4ZycLsXEv/6sjD1amZtWERK1LsmBx0eOs3Cs+Gyj1bRDmKKs/uK95wi7v8JO2k71/w3iBJgVDDtOdkbuUh68qEFDGdPA4cEfaNNX84ckn27wC930QApUQbi/nNIPtj6hF40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756349375; c=relaxed/simple;
	bh=MY12FLgHJvDO8ZWuSX9iiKYIYofyf+wiN9Q7AGKJHTs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vk4PhlPREG9XeK3p+SIQJ08IxoO3T7xiXYaUvXO82ErWbjNporplYym/2dekgIAXwa9nkSxr3JXsfqLZvR2qIF0uPtm24fgF98O5Sve9rdqha+RviQZJ/j8ijNK4sp+/R9YyUzw8hobf0dJjAC/ru3JDP097Jfz45dZq3QMH8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AacTSgpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D77C4CEEB;
	Thu, 28 Aug 2025 02:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756349375;
	bh=MY12FLgHJvDO8ZWuSX9iiKYIYofyf+wiN9Q7AGKJHTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AacTSgpzIB8RE6dH17Zp/HcjWv29c1bx6rPALNeUjF0fsPcoc8wCkBSjEn2pJz6Tt
	 CxbciPpAX5WkmVvXhjDXrMj1kDhLHlZlvrfrNlWBKp+NgXW5uEdfnW0/WRynJLwzXZ
	 JpgK0vmR6luiag+OecOwILbQyzDBQl7D9fkx7zPs=
Date: Wed, 27 Aug 2025 19:49:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <muchun.song@linux.dev>, <osalvador@suse.de>, <david@redhat.com>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert
 "hugetlb: make hugetlb depends on SYSFS or SYSCTL"
Message-Id: <20250827194934.f30fe19856fc343005c9703f@linux-foundation.org>
In-Reply-To: <0138514f-c580-c066-c16d-2a0b207e0604@huawei.com>
References: <20250826030955.2898709-1-linmiaohe@huawei.com>
	<20250826203552.b4340b12b16a374396f49343@linux-foundation.org>
	<0138514f-c580-c066-c16d-2a0b207e0604@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 10:31:51 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2025/8/27 11:35, Andrew Morton wrote:
> > On Tue, 26 Aug 2025 11:09:55 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> > 
> >> Commit f8142cf94d47 ("hugetlb: make hugetlb depends on SYSFS or SYSCTL")
> >> added dependency on SYSFS or SYSCTL but hugetlb can be used without SYSFS
> >> or SYSCTL. So this dependency is wrong and should be removed.
> >>
> >> This reverts commit f8142cf94d4737ea0c3baffb3b9bad8addcb9b6b.
> > 
> > f8142cf94d47 said:
> > 
> >     If CONFIG_SYSFS and CONFIG_SYSCTL are both undefined, hugetlb
> >     doesn't work now as there's no way to set max huge pages.  Make
> >     sure at least one of the above configs is defined to make hugetlb
> >     works as expected.
> > 
> > So there is now a way to set max huge pages?  A reference tot he
> > commit which made f8142cf94d47 unneeded might be helpful?
> 
> The commit is just wrong. It overlooked the scenario of using hugetlb through boot parameters
> when it was submitted.
> 

OK.  Could we please have a description of the user-visible effect and
a decision on whether we should backport the fix?

