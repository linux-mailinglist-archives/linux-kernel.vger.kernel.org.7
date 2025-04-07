Return-Path: <linux-kernel+bounces-592424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18801A7ED02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 21:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D47BC423F67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Apr 2025 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA1421C16B;
	Mon,  7 Apr 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OMDR6KzA"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1003221703
	for <linux-kernel@vger.kernel.org>; Mon,  7 Apr 2025 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052534; cv=none; b=PgiXwkRuF+2+p87BmdbTVr9g2NpHLqOCy8fc/HXJ4dxdoTDwVVph8XJqujfuaP+G+/VeTT9li64mFLJ5m2tZRjwNPKmkNzx1KRmT2WzAoNljm0bGae3qc4CIF6g45o5CcAvXt6ARU4P9aQmNaxGfx7o0z3fALyi4BrqiDBjOf+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052534; c=relaxed/simple;
	bh=5p46mHbHYbgNmEFKQBrcT25druIMYBXTDi09U3Z07wM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kOf0eG6GlZ2ioQSQ1NZQWQLIwvrnZFLaA8V8rlg+SC0xIhWvfwE6CF6Z7g18Pg5R5iLBV4tug4Kt9nzjG/P7QE2X2hyiZFGRPoRWeuJZ6LiAYfNwl4jjnZHkaU2PuDKptGaxttZdwQZv4lYvhhd2ew+H29MtDGnB/gAZRm0BUC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OMDR6KzA; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744052529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9jGo2/h5oGHCzMdIv7e/mxRijM3ED9bWZOjvtDk/LE=;
	b=OMDR6KzAJpkeYOUOHNpIvfuRhmA+gZRzFJJ86oErTUJpx9c1RAxEXETBzDPmlKJo588BbS
	D6nUY33RWvQG37dUmhJuSC1KGUQCpeT6yzgIYmdOlornAJc1lEbXzbcHLbZAxl07GEZ5PY
	3wFRaCCA2Od07P4M2ScI7Ddxx5M2fV0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [PATCH] scsi: elx: sli4: Replace deprecated strncpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202504071126.37117C5D@keescook>
Date: Mon, 7 Apr 2025 21:01:53 +0200
Cc: James Smart <james.smart@broadcom.com>,
 Ram Vegesna <ram.vegesna@broadcom.com>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-hardening@vger.kernel.org,
 linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <67E5FE26-F258-4690-A466-236A7E7484E8@linux.dev>
References: <20250226185531.1092-2-thorsten.blum@linux.dev>
 <202504071126.37117C5D@keescook>
To: Kees Cook <kees@kernel.org>
X-Migadu-Flow: FLOW_OUT

On 7. Apr 2025, at 20:28, Kees Cook wrote:
> On Wed, Feb 26, 2025 at 07:55:26PM +0100, Thorsten Blum wrote:
>> strncpy() is deprecated for NUL-terminated destination buffers; use
>> strscpy() instead.
>> 
>> Compile-tested only.
>> 
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> Standard question for these kinds of conversions: Why is it safe that
> this is not NUL padded? I haven't found where this buffer is being
> zeroed out, but it probably is (given the "- 1" on the length), but
> without run-time testing, this needs much more careful analysis.

I think this was submitted before I started to explain this better.

'wr_obj' is the zeroed out 'buf' returned from sli_config_cmd_init().

I'll update the description and submit a v2.

Thanks,
Thorsten


