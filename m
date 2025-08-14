Return-Path: <linux-kernel+bounces-768532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F168DB2623C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28BC16E556
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC41307AF5;
	Thu, 14 Aug 2025 10:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pdaaq+Io"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF53307AD3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166461; cv=none; b=VUrxnx2gvThu2rEUJWg7GEyPStBpe/ObLcUhECebzcq+Jw0PYJHIRoQ2+5CYdh7EQztHJggosMfNE34XnVdL3rPCxrLBlFgUMoy2i1+A/6K1x4gaSo6eQANpxlcUVWpcPlJY5Adk6hHK0hNH412Kij+0mcl/fdN1hYCgeCpmXSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166461; c=relaxed/simple;
	bh=nS70EmogJ5a5ZyRM36LiX+2RcGfpT4Q2XtkUsyo6SL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYI1Ptwy65Lh1o14cj5mDI6xDQK9q6J0Z4tW9vBYVxV4hLQeSot6djKmeixqzhQ8ltbxpaqepusty1KzxaVwT5KGO2OZgw9EBBiatdcAUPiopaOJo9//Ty90Bnj8OI/BQsr7/tsSvQ2O6hDQpJyWlzEzmAYHTHVT2ytz+a+WNHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pdaaq+Io; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755166458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nS70EmogJ5a5ZyRM36LiX+2RcGfpT4Q2XtkUsyo6SL0=;
	b=Pdaaq+Iobw5O78vSxg6rV9F9fpvD9wo2VIJ/PITM7lkxMeUDB7sh4MQLljXM2DMwsSxpDf
	QnGaqJqWyWMWm6PPcqhFTPSEBj33UgfTGvgxEVOES+xw8xpgnB0MIPGubN0vZmUb9UCZsk
	8PjVsXcUHRbHN6mv1nW8A/LLNLfSRok=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-GXmPe5o6M2OeHYmWqPoDzQ-1; Thu,
 14 Aug 2025 06:14:12 -0400
X-MC-Unique: GXmPe5o6M2OeHYmWqPoDzQ-1
X-Mimecast-MFC-AGG-ID: GXmPe5o6M2OeHYmWqPoDzQ_1755166451
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A9EFA1954203;
	Thu, 14 Aug 2025 10:14:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.62])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 4BBA919327C0;
	Thu, 14 Aug 2025 10:14:04 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 14 Aug 2025 12:12:53 +0200 (CEST)
Date: Thu, 14 Aug 2025 12:12:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PF_USER_WORKERs and shadow stack
Message-ID: <20250814101247.GC26754@redhat.com>
References: <20250813162824.GA15234@redhat.com>
 <a4cb5e3e-717e-4a86-9e15-5b14ef322314@intel.com>
 <20250813191441.GA26754@redhat.com>
 <0e906a8a-5545-484e-9fe3-9be3e07a033a@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e906a8a-5545-484e-9fe3-9be3e07a033a@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/13, Dave Hansen wrote:
>
> On 8/13/25 12:14, Oleg Nesterov wrote:
>
> > So I'd like to ensure that ssp_active() can't return T in ssp_get().
> >
> > And... Dave, I understand that it is very easy to criticize someone else's code 😉
> > But - if I am right - the current logic doesn't look clean to me. Regardless.
>
> Hey, I'm all for having "clean" code. But if we're going to add
> complexity (aka. code) to the kernel, we should know what it's getting
> us other than "cleanliness".
>
> BTW, how many PF_USER_WORKER threads _are_ there out there? I wouldn't
> have thought that they were prevalent enough to justify much of an
> effort here.

Agreed. I'll send the patches I have in a minute. To me they don't add
too much complexity and imo they cleanup the changed code.

But! I understand that cleanups are always subjective, so please review
and share your opinion.

Oleg.


