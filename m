Return-Path: <linux-kernel+bounces-743763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD06EB102FA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919DA3A6697
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F5627467D;
	Thu, 24 Jul 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlNjBBR1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CFB25EFBB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344766; cv=none; b=b3YjPxVRAxtGIJQBj2md+7zfw124RnAikxJ3WclqT6/p6Jz34JaM/Ty5oPNjEL5IbVkwSOzo+VwHD4cKZPFLZPSbjyLAxTKqd0o5hIOWWHLI7DEvyW8wE7SAW/RMD3NSROSQa4BOxDbH2x3a7xFFk5VHuVVsn0m+nz+ldJQQ/II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344766; c=relaxed/simple;
	bh=a/ipn6ShNjbiMsWgtP9FJaLqXX75br7R4UxlqN1otaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6Ms0mY3fSpovGTVQ8LwDPK9+L7vkZmVmFF3u+uROkZEQEZMMKFLvMS1Wa68Tq2SSTaKEZZ+NNJHrUWHIe35nUSXZEAcYsXJRJ5Kl571MocUxBq6AeKY8Gb2pH2Gt0tyonn5yvnmj2ZzscH2fcvt5Lhv2ZUhuJY6AM4peeSJGaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XlNjBBR1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753344763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/ipn6ShNjbiMsWgtP9FJaLqXX75br7R4UxlqN1otaw=;
	b=XlNjBBR1uoqvkb37dFdXh3uJwIheGdIJNEL+YWjEynI2BNdGQCExn3kfFrydHt5E2PGara
	2Z0GJ/W9wOlcBF4JckT2SXs+8uYXcLhYwZMuMQwLOE1iwEsWq0llsjRJlUdX/4TpXvDPZb
	7whLZbKdYdTwR/BYyVvJSIVsDoZ9M9U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-gpef5CLAOP6cUgbGkzOUqQ-1; Thu,
 24 Jul 2025 04:12:41 -0400
X-MC-Unique: gpef5CLAOP6cUgbGkzOUqQ-1
X-Mimecast-MFC-AGG-ID: gpef5CLAOP6cUgbGkzOUqQ_1753344760
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE04118002A2;
	Thu, 24 Jul 2025 08:12:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.245])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C4AF3195608D;
	Thu, 24 Jul 2025 08:12:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 24 Jul 2025 10:11:32 +0200 (CEST)
Date: Thu, 24 Jul 2025 10:11:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Li,Rongqing" <lirongqing@baidu.com>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH] x86/math64: handle #DE in mul_u64_u64_div_u64()
Message-ID: <20250724081125.GA10980@redhat.com>
References: <20250721130422.GA31640@redhat.com>
 <20250721192053.58843751@pumpkin>
 <20250722105034.GA2845@redhat.com>
 <20250722130947.0c97c96a@pumpkin>
 <20250722132147.GB2845@redhat.com>
 <20250722230341.5a1cc5e5@pumpkin>
 <20250723093825.GA12884@redhat.com>
 <20250723224831.4492ec75@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723224831.4492ec75@pumpkin>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/23, David Laight wrote:
>
> On Wed, 23 Jul 2025 11:38:25 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > to remove the conditional branch and additional variable. Your version
> > is probably beterr... But this is without WARN/BUG.
>
> I wish there was a way of doing a WARN_ONCE from asm with a single instruction.
> Then you could put one after your 2:
> Otherwise is it a conditional and a load of inlined code.
>
> > So, which version do you prefer?
>
> I wish I knew :-)

;-)

David, you understand this asm magic indefinitely better than me. Plus you are
working on the generic code. Can you send the patch which looks right to you?
I agree in advance with anything you do.

I got lost. Now I don't even understand if we want to add BUG and/or WARN into
mul_u64_u64_div_u64().

Thanks,

Oleg.


