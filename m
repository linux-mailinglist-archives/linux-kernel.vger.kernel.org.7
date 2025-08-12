Return-Path: <linux-kernel+bounces-765102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DDAB22B71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3202C188CEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC1E283FF4;
	Tue, 12 Aug 2025 15:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MS+aaoNb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACC42F4A1D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011427; cv=none; b=UAIWFja9e8DNPVkgzKmDvbWdLQ/oFgPJ2FfvUeogq7Ol2q+XMibTnjJbCm9yqPSyRTP+Cyzwkha4PKX3v+Y/ePkqlDF2SaPFCi7qLj0OasmKWBguxmtcmDKhtnwe1NxMH1jdaBobdyl/hNDVn3pYcKp7nE07F7CrDW8SiSEXkO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011427; c=relaxed/simple;
	bh=uXg3JiDSGGOqupxRJv/Ih8srHvr3OKayFvnpfkLJXvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lirVkoNz6ipc4VgUyZk4FaJcQa1kmLunK6tHY2zMNDZnBYgCfyfNJXUXxpUxz3pJvkbqWKDDRRBQv53+tjvCTStbh5fvpo0m02mHCBxpzocr3mObBj+uQwR0+A2r/DMT8SqT/RNT7QblGs1NpI6KuhmaOr3euz0lbCXtwzNCqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MS+aaoNb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755011425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PrBFm9KN1k8udVr7PX4kpGMG0V0UIL0fa5o6pxCVKL0=;
	b=MS+aaoNbp9uqj5PVpncpCRlCsWk+Yhsf4/5fSMWl4WJBgJCftLAVxKxhBYpDTyphdYSBKE
	TE4efQ7ySS7HCMm7eGpzLFNEq2BkE6eLaVMIrDRsJctCGBXXPMQ8nEi1qhDNmUbd+Q8F14
	+9zW3SOk+heY45z8YRhOtpQTzFUAf0E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-SghTwAjnNS-be_4HqIcxxA-1; Tue,
 12 Aug 2025 11:10:22 -0400
X-MC-Unique: SghTwAjnNS-be_4HqIcxxA-1
X-Mimecast-MFC-AGG-ID: SghTwAjnNS-be_4HqIcxxA_1755011419
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0E1D1808966;
	Tue, 12 Aug 2025 15:10:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E3871800290;
	Tue, 12 Aug 2025 15:10:09 +0000 (UTC)
Date: Tue, 12 Aug 2025 23:10:04 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com, elver@google.com,
	snovitoll@gmail.com
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aJtZTLPtHUfUsiuQ@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/12/25 at 08:49pm, Baoquan He wrote:
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=on|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
> 
> So this patchset moves the kasan=on|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> kasan.
> 
> Changelog:
> ====
> v1->v2:
> - Add __ro_after_init for __ro_after_init, and remove redundant blank
                            ~~~~~~~~~~~~~ s/__ro_after_init/kasan_arg_disabled/
                            Sorry for typo here.
>   lines in mm/kasan/common.c. Thanks to Marco.


