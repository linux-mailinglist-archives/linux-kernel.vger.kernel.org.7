Return-Path: <linux-kernel+bounces-877692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F20C1EC21
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87FEA4E74ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EE92F6579;
	Thu, 30 Oct 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJhUixEl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8A2D46B1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809444; cv=none; b=qJLOHFxVZMHixMZZpbgHfPKvVYyaQUREesWn2sYvwuahOqi4F7Ih1dIFtKz8wi5On4Nq+FyaE/QStAnMd6rY1j1hxq7KmFp1CqXrFPhq7/Qttuducfx2+TDKOm0GX4KBQ3Z7htcHzPq7bJW6wiWYn7zsLKLMafCvc5kIlZCzfOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809444; c=relaxed/simple;
	bh=B7Ikaos5Tgz9P+H1+RQwY6SYiEJARwsehjHJk5gBsmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbrlukfPgSsivJ6UhQBSSSyhW2XDU3zOqVVDiyDApvW/Fq2oATgge9pXV7MoIOMsGy6teGW1qHim4P+bXsnqUuM9VHV70L++uQE1wl9ta+KGsPOsNchgFn9eCxMVIEf2jinl94hnjjQH13UxpycpO5d929evb1PI5346jvGzFic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJhUixEl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761809441;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=tRXdFEpnzPmzAHyo9qVQw6Cgrk4YP6KvgVQeZCk+AW8=;
	b=aJhUixEljOqGrFmPnsIbpB5OmYlug+uNQPqIg/f+fXArv4tQw6SR8hFWkw1NLhqPF764mK
	DFpME1rLoovM/ZJrSKXnEta12nupA1uhsWxE7/EFzUeoQ/ctfDMG9CXXS9TWY8HzWPDDWd
	IZIBnOqmH/sq1TZLSmtX+zBR9zaLUj0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-prgjbORCNPSRbe3IOa9O8Q-1; Thu,
 30 Oct 2025 03:30:40 -0400
X-MC-Unique: prgjbORCNPSRbe3IOa9O8Q-1
X-Mimecast-MFC-AGG-ID: prgjbORCNPSRbe3IOa9O8Q_1761809439
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED1171956060;
	Thu, 30 Oct 2025 07:30:38 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.44.32.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6640B19560B7;
	Thu, 30 Oct 2025 07:30:38 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
	by tucnak.zalov.cz (8.17.1/8.17.1) with ESMTPS id 59U7UZGg4063189
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Oct 2025 08:30:35 +0100
Received: (from jakub@localhost)
	by tucnak.zalov.cz (8.17.1/8.17.1/Submit) id 59U7UYr44063188;
	Thu, 30 Oct 2025 08:30:34 +0100
Date: Thu, 30 Oct 2025 08:30:34 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: Fangrui Song <maskray@sourceware.org>
Cc: linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Concerns about SFrame viability for userspace stack walking
Message-ID: <aQMUGvXv6sy75nKn@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
> I've been following the SFrame discussion and wanted to share some concerns about its viability for userspace adoption, based on concrete measurements and comparison with existing compact unwind implementations in LLVM.
> 
> **Size overhead concerns**
> 
> Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is approximately 10% larger than the combined size of .eh_frame and .eh_frame_hdr (8.06 MiB total).
> This is problematic because .eh_frame cannot be eliminated - it contains essential information for restoring callee-saved registers, LSDA, and personality information needed for debugging (e.g. reading local variables in a coredump) and C++ exception handling.

I believe .sframe only provides a subset of the .eh_frame information, so
can't be used for exception throwing, and you don't want to lose
.eh_frame_hdr either because then dlopen becomes very costly and it will
even slow down exception throwing.

If .eh_frame is considered too large, rather than inventing a new format I'd
suggest to work in the DWARF committee and provide further size
optimizations for .dwarf_frame which can then be used in .eh_frame, or agree
on .eh_frame extensions to make it smaller.

	Jakub


