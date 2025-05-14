Return-Path: <linux-kernel+bounces-646846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 417C6AB6153
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 05:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9271462F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 03:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA731F09B0;
	Wed, 14 May 2025 03:51:57 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A91EB5C2
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 03:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747194717; cv=none; b=FFIWsz/7spRRolJnWkz7gT7Tb01x1fzxnYPHL5HXnUkSOe3fCbo40FPD/RMXgWecMuSRUviOq4/chVNYvCo7s5HdO4471GJy2TZI2wM+BKsEd0jX2ibRoj0aJVewBFndQBFh8fFst6gZjMhOxI7TDp1a2MlKLxs+CjpadmYkLRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747194717; c=relaxed/simple;
	bh=r+900GmI67uxErSP2GNq2T78xo+2Cyqm8I6e6bOAIFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciZ5N1woQiMeOB3oU4zPyD+20JxVApOWLSwsziSYkHpK72Cf2IzzUcJy6yF8s9eMh5lqOnqIqBfOblyKCCDLjZKoBI7lkYIe2KH4xOxsPuW1DWfZHAHbsHI+A4Sqxdjigol4OgeS6Cuf71hM1pc8t0F8QtjMBCJnwebnZom7btw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-151.bstnma.fios.verizon.net [173.48.112.151])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54E3pPRB010817
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 May 2025 23:51:25 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 3B3CE2E00DC; Tue, 13 May 2025 23:51:25 -0400 (EDT)
Date: Tue, 13 May 2025 23:51:25 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/3] mm/filemap: initialize fsdata with iocb->ki_flags
Message-ID: <20250514035125.GB178093@mit.edu>
References: <20250421105026.19577-1-chentaotao@didiglobal.com>
 <20250421105026.19577-2-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250421105026.19577-2-chentaotao@didiglobal.com>

On Mon, Apr 21, 2025 at 10:50:30AM +0000, 陈涛涛 Taotao Chen wrote:
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 7b90cbeb4a1a..9174b6310f0b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -4087,7 +4087,11 @@ ssize_t generic_perform_write(struct kiocb *iocb, struct iov_iter *i)
>  		size_t offset;		/* Offset into folio */
>  		size_t bytes;		/* Bytes to write to folio */
>  		size_t copied;		/* Bytes copied from user */
> -		void *fsdata = NULL;
> +		/*
> +		 * Initialize fsdata with iocb flags pointer so that filesystems
> +		 * can check ki_flags (like IOCB_DONTCACHE) in write operations.
> +		 */
> +		void *fsdata = &iocb->ki_flags;

Unfortunately, this is't safe.  There may very well be code
paths which depend on fsdata being initialized to NULL before
calling write_begin().

In fact in the patch 2/3 in this series, ext4_write_end() will get
confused in the non-delayed allocation case, since ext4_write_begin()
doesn't force fsdata to be not be &iocb->ki_flags, and this will cause
ext4_write_end() to potentially get confused and do the wrong thing.

I understand that it would be a lot more inconvenient change the
function signature of write_begin() to pass through iocb->ki_fags via
a new parameter.  But I think that probably is the best way to go.

Cheers,

					- Ted

