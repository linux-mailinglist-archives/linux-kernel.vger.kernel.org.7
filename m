Return-Path: <linux-kernel+bounces-808617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06267B50256
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A47E1C26521
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22033A01A;
	Tue,  9 Sep 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z74WEAn7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517392192EE;
	Tue,  9 Sep 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434727; cv=none; b=KheWYzAzKUUhyCNX6aUUNd4oDu6BPRnBz9XXdj6KF4ApTMBK+6FJEW7oRHQTfkk+OJ839aG+wLcMrnZergoYKBgRScewMAUATrCSPAqoTnY7raVYcIo81ycmuVOk3jOqUxpDKnPhhGsr5n20J4D4FMts4tzxtKAZ1QDtaJvNSHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434727; c=relaxed/simple;
	bh=q/QS87Eux0wk/HOaswmx7nspa5Qx9l4MYEZAWalFsVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evl1FNWzLXJCQ3gD0XZpJxc+MXlzSPR6z81NRJDBr8Kvm5lf6fk9KytmjQuaia1RUi9mycKR5LIsl1qLXJg3k/gzYXyOY80F1rzxvuWYg9p1eHQVgck8zEappg2pX3MUFG9jmnmeKbvGVNfWevuv8o5ulZ4TXeNIo2TiKdAMADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z74WEAn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F01DC4CEF8;
	Tue,  9 Sep 2025 16:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757434727;
	bh=q/QS87Eux0wk/HOaswmx7nspa5Qx9l4MYEZAWalFsVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z74WEAn7othpgb+/zZWmZxw1Jc8OANJ+OTKjJFtiFlbh4fplBeE51+d+zLxVsyvHq
	 OLeg9bWR7Yq9bSmhYaawWA0334Xei/BavQs1bhfycOumBbxZMjk2ufqRnTPzGUObkX
	 zQW08oZ/pSgkEKZ8+d8dEsIzwO+U5txUimW+kIIEgRmsRZS0JPb5yQDquqQ/qy3W/X
	 GDNcMWmM1ZXGp1HgDL7cXAkInqVfbYg11o07V3NVXplRH2GMZKV9L1BaskGHwwdCX0
	 f/rVTVPVTGZwP3KwBGwhMi2gamfsUjZ9VoVWqMRDalIyr1lg2cU7mMqxJthextRUpf
	 8FeeD/I+dQZkg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uw13N-00000000R47-19GR;
	Tue, 09 Sep 2025 18:18:45 +0200
Date: Tue, 9 Sep 2025 18:18:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <aelqggrynl7acn54tqm5ntqsynghprqtzmbkhvgf7khlbmmq6v@tf4gdfh2fvla>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
 <d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
 <c26160b1-f1fb-41d3-a8fe-acf589ad9f7f@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26160b1-f1fb-41d3-a8fe-acf589ad9f7f@infradead.org>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Tue, Sep 09, 2025 at 08:57:07AM -0700, Randy Dunlap wrote:
> Hi Mauro,
> 
> On 9/9/25 12:27 AM, Randy Dunlap wrote:
> > Hi Mauro,
> > 
> > I have a few patch nits below, then some testing info.
> > 
> > 
> > On 9/7/25 9:22 AM, Mauro Carvalho Chehab wrote:
> >> Specially on kAPI, sometimes it is desirable to be able to
> >> describe global variables that are part of kAPI.
> >>
> >> Documenting vars with Sphinx is simple, as we don't need
> >> to parse a data struct. All we need is the variable
> >> declaration and use natice C domain ::c:var: to format it
> >> for us.
> >>
> >> Add support for it.
> >>
> >> Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
> >> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> ---
> >>  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
> >>  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
> >>  2 files changed, 55 insertions(+), 1 deletion(-)
> >>
> 
> 
> > So, I grabbed some global data from 6-8 places in the kernel and put them intoinit/kdoc-globals-test.c. Then I modified Documentation/core-api/kernel-api.rst
> > like this at the end of that file:
> > 
> > +
> > +Kernel Globals
> > +==========================
> > +
> > +.. kernel-doc:: init/kdoc-globals-test.c
> > +   :identifiers:
> > 
> > The html output says
> > "Kernel Globals"
> > but nothing else.
> > 
> > My test files are attached. I dumbed down (simplified) a few
> > of the globals from fancy types to just unsigned long, but that
> > didn't help the output results any.
> > 
> > What's happening?
> > Thanks.
> > 
> 
> My problems here could be from a patch mis-merge.
> Maybe your patch was against a tree or previous patches that I don't have.
> 
> You could supply an updated patch or I can just wait until all
> the patches are synchronized for further testing.
> Or you could just take my sample and keep testing it.

I applied it after my sphinx-build-wrapper patch series,
but it doesn't touch kernel-doc. I did a rebase just to make
sure, on the top of docs-next branch from Jon's tree, e.g. 
on the top of:

    git://git.lwn.net/linux.git docs-next

e.g. applying it after:

    7e5a0fe4e8ae ("doc: filesystems: proc: remove stale information from intro")

Patch applied cleanly.

Notice that it probably depends on some changes that Jon
applied for kernel-doc after -rc1.

If you prefer, the patch is here at global_vars branch:

https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git/log/?h=global_vars

-- 
Thanks,
Mauro

