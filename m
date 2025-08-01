Return-Path: <linux-kernel+bounces-752817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15097B17B41
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 04:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45442544FCA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0C813A3ED;
	Fri,  1 Aug 2025 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NEKyYuHG"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585939ACF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754015865; cv=none; b=CQUYFRWV4LCp8+3W1Z5BZfQwJsT8UK+ZxvZkCh5gAZIcIiXrHUNUuY9hFJScVqn9oppx+XcgViU45/Ot2UqB2AFGsKeaTIvZ4WWQD6xcF7qyHLAPfGwhNX5YoQAyjmKSUqI1QOghrMl7riONr9BgVRHiDiJngYPDuopeT7OAybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754015865; c=relaxed/simple;
	bh=45AzozUO49h9DjZku9afDe6PYn3ISnW/1R4c+2+dR2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSf2LxNETBMAgZqV6Ov4MK2tstUXIsQXpk0O/cIiOxwqwbNgMbCDkNk1KtYVoc4obuIeR+PAlkClhId95ZkrGlXWKRmhVnc9NMUljYbn84UJHa9mCDJQ8OtU3N0jRW9nIE8nieplJPku9ZB1aF+vyhIGZkuwF8mrl3GFJbShDmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NEKyYuHG; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 31 Jul 2025 22:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754015851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=45AzozUO49h9DjZku9afDe6PYn3ISnW/1R4c+2+dR2s=;
	b=NEKyYuHGyFqRdbxGmb2ywWtOlpeZVz5biKwPiqAZNgwsG09ICsYZrgUY0pfnlwz7aAFCEb
	XpUQ6WXaPzSwVwvGNGojMnChAcQkLrcdxA6qpjGR9J5iqWAdUM+NGx48fO2iOFDNnIdvPP
	2mmELnujrcG2C6kewP2nofn/9FViMqA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Cc: Coly Li <colyli@kernel.org>, 
	linux-bcache <linux-bcache@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bcache: enhancing the security of dirty data writeback
Message-ID: <zcxdklyr2ugq7cfbed4olcsfcboy3nksxtpjs2g76bauvef5cq@4akbspw3ydiw>
References: <20250731062140.25734-1-zhoujifeng@kylinos.com.cn>
 <etlu4r6gxbe2jc3eemj3n4slg6xraxtxxydvxvmhv77xv42uss@7aw3yxbdgrdl>
 <tencent_656F159830BC538C2D26CD68@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_656F159830BC538C2D26CD68@qq.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 01, 2025 at 10:27:21AM +0800, Zhou Jifeng wrote:
> In the writeback mode, the current bcache code uses the
> REQ_OP_WRITE operation to handle dirty data, and clears the bkey
> dirty flag in the btree during the bio completion callback. I think
> there might be a potential risk: if in the event of an unexpected
> power outage, the data in the HDD hardware cache may not have
> had time to be persisted, then the data in the HDD hardware cache
> that is pending processing may be lost. Since at this time the bkey
> dirty flag in the btree has been cleared, the data status recorded
> by the bkey does not match the actual situation of the SSD and
> HDD.
> Am I understanding this correctly?

For what you're describing, we need to make sure the backing device is
flushed when we're flushing the journal.

It's possible that this isn't handled correctly in bcache; bcachefs
does, and I wrote that code after bcache - but the bcache version would
look quite different.

You've read that code more recently than I have - have you checked for
that?

