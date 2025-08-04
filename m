Return-Path: <linux-kernel+bounces-755324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCBBB1A4F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035871885654
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2026D4F6;
	Mon,  4 Aug 2025 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BARx+cGg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDA72701B4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317845; cv=none; b=UwtnT8cXXRroSjiclweL5nekOeY0uVDAROUCkDuDmd9SfouQOIyEqYlGFc0vZ6PXpzo5ewiDPPzGaqAc/dPnN/Tq+R7xSXAyTVWGen2qwZxgWSip7BBGA1qCp+tR3y1bVKgVkY2UPV2O54sMFSQjYzRKR3f7KxeypBkhnDDQGeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317845; c=relaxed/simple;
	bh=Ni8CSHpOhukdN/21kURJP+BanGjYorMPnmv5tP1P+3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TSkwC+jPEh55z9qxzBk9g9Od5mLIRWe+YrahXWCAwANTCgLja1yj9anVNlJr98T8YrRX4AT1cXz/OZ6w7umxFjq1gtm63y/5cZZE5YW3v3PQ+1gmsZgEVqMYOD0nhAX5t6IhxiHUJblqE8UtHTmbKXNG9p/6j4PIqNOtHcZi93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BARx+cGg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754317841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLfj4Z6OrcNJ/e8ghBxGUuYT9xlFmnM4pxqWJq7Kcow=;
	b=BARx+cGgarKQdBaxrqYDYT09ygs0YJN9ueCfcV/zQnd9JkArH3ZDq/Oh7th2Q4VA3mcw5U
	be/TXVOR8DKamJSD4sPXRQvR3xpDdr+AjBS+GNYBwbBlX2SbDdcuZpsPjgt/c+N+VrBHqb
	LmkBqQgantjEmRhqkNNHjcZDGzNs440=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-Q3G1GamQOFKpwVDVa7ykow-1; Mon,
 04 Aug 2025 10:30:36 -0400
X-MC-Unique: Q3G1GamQOFKpwVDVa7ykow-1
X-Mimecast-MFC-AGG-ID: Q3G1GamQOFKpwVDVa7ykow_1754317835
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C3F41800264;
	Mon,  4 Aug 2025 14:30:34 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.224.14])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EDC11800EED;
	Mon,  4 Aug 2025 14:30:31 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net,  linux-api@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [fuse-devel] copy_file_range return value on FUSE
In-Reply-To: <CAJfpegur9fUQ8MaOqrE-XrGUDK40+PGQeMZ+AzzpX6hNV_BKsw@mail.gmail.com>
	(Miklos Szeredi's message of "Mon, 4 Aug 2025 15:30:27 +0200")
References: <lhuh5ynl8z5.fsf@oldenburg.str.redhat.com>
	<CAJfpegur9fUQ8MaOqrE-XrGUDK40+PGQeMZ+AzzpX6hNV_BKsw@mail.gmail.com>
Date: Mon, 04 Aug 2025 16:30:43 +0200
Message-ID: <lhu4iuni2gc.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Miklos Szeredi:

> On Mon, 4 Aug 2025 at 11:42, Florian Weimer via fuse-devel
> <fuse-devel@lists.sourceforge.net> wrote:
>>
>> The FUSE protocol uses struct fuse_write_out to convey the return value
>> of copy_file_range, which is restricted to uint32_t.  But the
>> copy_file_range interface supports a 64-bit copy operation.  Given that
>> copy_file_range is expected to clone huge files, large copies are not
>> unexpected, so this appears to be a real limitation.
>
> That's a nasty oversight.  Fixing with a new FUSE_COPY_FILE_RANGE_64
> op, fallback to the legacy FUSE_COPY_FILE_RANGE.

Or adding a capability flag to switch from struct fuse_write_out to
something that uses an uint64_t value.  One complication: The struct
fuse_write_out layout is too close to a potential 64-bit version of it
on little-endian systems, so that proper testing might be difficult with
the obvious approach.

>> There is another wrinkle: we'd need to check if the process runs in
>> 32-bit compat mode, and reject size_t arguments larger than INT_MAX in
>> this case (with EOVERFLOW presumably).  But perhaps this should be
>> handled on the kernel side?  Currently, this doesn't seem to happen, and
>> we can get copy_file_range results in the in-band error range.
>> Applications have no way to disambiguate this.
>
> That's not fuse specific, right?

In-kernel file systems can check if the request originated from a compat
process, using in_compat_syscall.  I don't think that's possible over
FUSE.

Thanks,
Florian


