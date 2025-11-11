Return-Path: <linux-kernel+bounces-895056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DBDC4CD03
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAC914FD6A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183A32FD686;
	Tue, 11 Nov 2025 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q07RRt1P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E304C2FC89C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854663; cv=none; b=uCG69xG0SjOSGpDQY0MhEVLXuxfo5ziaQ23ZjGMNgzjuj1B5iFhwsskVd6Cgh3C+v2FYlh5U+MHmUSLkejqazWERsDS4CWKkHp2fRwRnq9m/D9k9KV6vYOfi4iJZgkXs74R7EkRjxuU9yyZAyXOOyVP6MaIPKE2DYN9vPTp/Zw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854663; c=relaxed/simple;
	bh=d/6qmPIr6XfIAiRzU4wN1UuSbgtZ/Xh4tt0OqSWfrPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h3j8GigPqW+MS8vrN/1ZL9bbcjkOrhsYC4pB9z1SshKTYsl/j5KB8QusYPl5wSNfcLztSiQtMDWLocihMHaohDDYQUANplNdGsJD2qhxl8YlPJn7S5KsBDH7vqiR+GuHXtanaXB5391yB9SILBFPA0UYggAFy9D44toLBzs/KXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q07RRt1P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762854660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Scsyq6luIilwuHQq5aSleNZrTNqfMNUGhbn0iJxWQUY=;
	b=Q07RRt1P7tUlyPv9JneWBFWJ91glgNwKZqIptf123d8SBphNKcYhw2QVN6m4tIv1Iqj2e2
	+0ty8u7d3TGO2G0rEPzoqTfL0yiTnBeSIr2LcZ1TMU27ggt4nxBuFj67TQa6hgPkIAFNER
	m6YCucrd/oK3l5xHmMazdlHiELmzXvs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-PKQaNzSFPMevevEoDCLEzw-1; Tue,
 11 Nov 2025 04:50:23 -0500
X-MC-Unique: PKQaNzSFPMevevEoDCLEzw-1
X-Mimecast-MFC-AGG-ID: PKQaNzSFPMevevEoDCLEzw_1762854621
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A683180028A;
	Tue, 11 Nov 2025 09:50:20 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.45.225.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C7082195608E;
	Tue, 11 Nov 2025 09:50:15 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: hch <hch@lst.de>
Cc: Hans Holmberg <Hans.Holmberg@wdc.com>,  "linux-xfs@vger.kernel.org"
 <linux-xfs@vger.kernel.org>,  Carlos Maiolino <cem@kernel.org>,  Dave
 Chinner <david@fromorbit.com>,  "Darrick J . Wong" <djwong@kernel.org>,
  "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,  Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
In-Reply-To: <20251111090547.GC11723@lst.de> (hch@lst.de's message of "Tue, 11
	Nov 2025 10:05:47 +0100")
References: <20251106133530.12927-1-hans.holmberg@wdc.com>
	<lhuikfngtlv.fsf@oldenburg.str.redhat.com>
	<20251106135212.GA10477@lst.de>
	<aQyz1j7nqXPKTYPT@casper.infradead.org>
	<20251106144610.GA14909@lst.de>
	<8b9e31f4-0ec6-4817-8214-4dfc4e988265@wdc.com>
	<20251111090547.GC11723@lst.de>
Date: Tue, 11 Nov 2025 10:50:13 +0100
Message-ID: <lhu4ir0kiei.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

> On Tue, Nov 11, 2025 at 08:31:30AM +0000, Hans Holmberg wrote:
>> In stead of returning success in fallocate(2), could we in stead return
>> an distinct error code that would tell the caller that:
>> 
>> The optimized allocation not supported, AND there is no use trying to
>> preallocate data using writes?
>> 
>> EUSELESS would be nice to have, but that is not available.
>> 
>> Then posix_fallocate could fail with -EINVAL (which looks legit according
>> to the man page "the underlying filesystem does not support the operation")
>> or skip the writes and return success (whatever is preferable)
>
> The problem is that both the existing direct callers of fallocate(2)
> including all currently released glibc versions do not expect that
> return value.

That could be covered by putting a flag into the mode argument of
allocate that triggers the new behavior.

Thanks,
Florian


