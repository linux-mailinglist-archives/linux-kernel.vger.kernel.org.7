Return-Path: <linux-kernel+bounces-895528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE4BC4E36D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6D144E4EFE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E6334C27;
	Tue, 11 Nov 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="xWpSYUW+"
Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEC233ADBF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868597; cv=none; b=r4wyieL5CVo7/wZlaVdbjJbqBUIoc8nxlcmoJhfIOGMhKVYSuE6Y/nuLjWBEoCQBvAaJe6X6C/OFF1+E7+6xj95ayuNDu1u9B1SsIJZ9PgzQkgmT6V8vf4NjNu+y9hm7iD8PJPXOwvHTwNLDbAqqQiQr9N29QuMW52YL9C5T1tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868597; c=relaxed/simple;
	bh=0H+Gerke8ppaRRjtigYGXTcaKIwDUqySBp2HGWMLq8o=;
	h=In-Reply-To:To:Subject:Cc:Message-Id:From:Date:Mime-Version:
	 Content-Disposition:References:Content-Type; b=T902EjWRpE5VyTfxiD+k621r1ShXXrSmN2aCOSND5YecTPUtQ9vEkE78AbzozBA765DqlAVfZFN864wLSf+9Ha1dhjDSCxyLF40jOzLRSAkJjmG4BUZyT5LUXhDakmarbg3fJl6dyflgYu7X5AaHoRIOhwGuFWu14JiILnYJX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=xWpSYUW+; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762868589;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=2b0zj8nz9IcPCTEaSOwNKpCL+oqq9pnCWEKq4tv2bec=;
 b=xWpSYUW+pfKj4cO3OiSy+Zqb1p1zeYS/RcMOADsFIwftnDA6Bh7pTfEWMHHRCbh2MIobSp
 HIObglcX8SxdRCvk/Gxfsf8FC9afz42SP7FgCJPSmv1/yrWgFcxmySo5iHevP5BrywLltQ
 jMp3jSPNlxI78wkPdf1S2pULt5v+4FvVVFgasfMpkWV3t77+DFun1CO4GCDujTGsBHLHve
 +R11eIs/taS7KMCPRebecODXEY6YjJ69+rRC+g5YjvJsx2AelbGq+pgh2lr7/lewqfWzCM
 BobTFGDq5tSFKaXwfOdSHPa4tyOGlX/uUxXkAIH+rkVyiGX7TYh/bKtEX+3akw==
In-Reply-To: <a956504a-55af-4c2c-95a0-15663435624a@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] bcache: Avoid -Wflex-array-member-not-at-end warning
Received: from studio.coly ([120.245.64.178]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 21:43:06 +0800
Content-Transfer-Encoding: 7bit
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"Andrew Morton" <akpm@linux-foundation.org>, 
	<linux-bcache@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>
Message-Id: <7zweggwc6mkksyhxzbdsphachjj5pzlaebli6xitryfl4yiqdj@eziyaibeuhza>
X-Lms-Return-Path: <lba+269133d6b+56f6ac+vger.kernel.org+colyli@fnnas.com>
From: "Coly Li" <colyli@fnnas.com>
Date: Tue, 11 Nov 2025 21:43:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Disposition: inline
References: <aRHFchrO3BmVMH5c@kspp> <7g2dkwi2nzxe2luykodsknobzr5bkl23d5mbahkyo7adhg55oy@6uisoc7jzgy6> <a956504a-55af-4c2c-95a0-15663435624a@embeddedor.com>
X-Original-From: Coly Li <colyli@fnnas.com>
Content-Type: text/plain; charset=UTF-8

On Tue, Nov 11, 2025 at 10:28:57PM +0800, Gustavo A. R. Silva wrote:
> 
> 
> On 11/11/25 22:17, Coly Li wrote:
> > On Mon, Nov 10, 2025 at 07:58:58PM +0800, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > > getting ready to enable it, globally.
> > > 
> > > Use the new TRAILING_OVERLAP() helper to fix the following warning:
> > > 
> > > drivers/md/bcache/bset.h:330:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 
> > > This helper creates a union between a flexible-array member (FAM) and a
> > > set of MEMBERS that would otherwise follow it.
> > > 
> > > This overlays the trailing MEMBER struct btree_iter_set stack_data[MAX_BSETS];
> > > onto the FAM struct btree_iter::data[], while keeping the FAM and the start
> > > of MEMBER aligned.
> > > 
> > > The static_assert() ensures this alignment remains, and it's
> > > intentionally placed inmediately after the corresponding structures --no
> > > blank line in between.
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >   drivers/md/bcache/bset.h | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
> > > index 011f6062c4c0..6ee2c6a506a2 100644
> > > --- a/drivers/md/bcache/bset.h
> > > +++ b/drivers/md/bcache/bset.h
> > > @@ -327,9 +327,13 @@ struct btree_iter {
> > >   /* Fixed-size btree_iter that can be allocated on the stack */
> > >   struct btree_iter_stack {
> > > -	struct btree_iter iter;
> > > -	struct btree_iter_set stack_data[MAX_BSETS];
> > > +	/* Must be last as it ends in a flexible-array member. */
> > > +	TRAILING_OVERLAP(struct btree_iter, iter, data,
> > > +		struct btree_iter_set stack_data[MAX_BSETS];
> > > +	);
> > >   };
> > > +static_assert(offsetof(struct btree_iter_stack, iter.data) ==
> > > +	      offsetof(struct btree_iter_stack, stack_data));
> > > 
> > 
> > I have to say this is ugly. Not the patch, but the gcc 14 warning option
> > of such coding style. Look at TRAILING_OVERLAP() usage here, this is not
> > C, this is something to fix a gcc bug which cannot handle FAM properly.
> 
> This is not a GCC bug.
> 
> > 
> > Gustavo, this complain is not to you, just I feel a bit sad how GCC makes
> > the code comes to such an ugly way, and it makes things much complicated.
> > For anyone doesn't have deep understanding of TRAILING_OVERLAP(), I
> > highly suspect whether he or she can understand what happens here.
> > 
> > Andrew and Gustavo, is this a mandatary to fix FAM in such way? If yes
> > I take the patch and keep my own opinion. If not, I'd like to see gcc
> > fixes its bug, for the this code I don't see the author does things
> > wrong.
> 
> This is a false positive that needs to be addressed in some way in order to
> enable -Wflex-array-member-not-at-end in mainline.
> 
> Here you can take a look at the patches I (and others) have submitted to
> modify similar code over the last year:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=grep&q=-Wflex-array-member-not-at-end
> 

I see. I take this patch, with the above complain...

Coly Li

