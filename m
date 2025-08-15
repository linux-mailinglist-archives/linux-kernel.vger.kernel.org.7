Return-Path: <linux-kernel+bounces-771151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06451B2837D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3CCEAC4E97
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCAB308F31;
	Fri, 15 Aug 2025 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fynFi1g0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81F291C18
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755273855; cv=none; b=RlkLY0IlNmxXsVAwjur3zxTE7QUG9UnhgitMBMUFlKXMm8c1VnmtcN0l6Q25nqzaQ1kbYA/mGNanGzP62ofREhQdITFfNpT1K4WerUgCElaI+/GyS4LFnDmFEM9RU0EXyXGAc5SFBLkmmdjnIoUss5xdb8ituUu23tWYwR/kmZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755273855; c=relaxed/simple;
	bh=lKMogr4ajRlJk619aEelHGKAjLdqaDJr87j1olYJqJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfcEiZICJVGejJcP8VexghzbWQcPZXqShM+5uWUh1V+Usxw08bfGl8YC0S/OFJiqfLF4hHPAaBVBF88IXcsgEBQaLr60bCcXbWTQsm9M/SEdo9okVKuFN8px9w/Hc/u2+QFnZeyqHf3DMAQUYeSsx6fkGTGV1Wod0R/roqFzDEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fynFi1g0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755273852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKMogr4ajRlJk619aEelHGKAjLdqaDJr87j1olYJqJc=;
	b=fynFi1g062tkUEWSQKesK5nQ1kbhyDxlqoezoaXbUeUDP6dRCeQ/qK8cYReUecGprMqsuD
	jhBK4pPfF17Y1VBDTz7N5DWIK59CcGYEW8KEIn+diPsKkkPAEeKDDbiNCFo8nXtI3w+I3f
	+N6jMWvdHOZoo8U97v3s0netNvuC/KQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-zliQYkXHOyqrvZrgwfCzhA-1; Fri,
 15 Aug 2025 12:04:09 -0400
X-MC-Unique: zliQYkXHOyqrvZrgwfCzhA-1
X-Mimecast-MFC-AGG-ID: zliQYkXHOyqrvZrgwfCzhA_1755273847
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60F3518002CF;
	Fri, 15 Aug 2025 16:04:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id A1B52180035C;
	Fri, 15 Aug 2025 16:04:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 18:02:50 +0200 (CEST)
Date: Fri, 15 Aug 2025 18:02:44 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] x86/fpu: don't abuse x86_task_fpu(PF_USER_WORKER) in
 .regset_get() paths
Message-ID: <20250815160244.GI11549@redhat.com>
References: <20250814101340.GA17288@redhat.com>
 <20250815155220.GA3702@redhat.com>
 <d74b6f8b-2662-47f4-8221-2d2e6e7fe580@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d74b6f8b-2662-47f4-8221-2d2e6e7fe580@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 08/15, Dave Hansen wrote:
>
> On 8/15/25 08:52, Oleg Nesterov wrote:
> > Dave, Sohil, what do you think?
> >
> > OK, it seems that 5/6 (and thus 6/6) needs more discussion, but what
> > about 1-3 for the start?
> They kinda need fleshed out changelogs first, don't you think?
> Especially 1/6. It also needs an actual cover letter explaining what
> it's trying to do and the larger context. Ideally, it's self-contained
> and as opposed to links to previous discussions.

I agree about the cover letter, but what else do you think the changelog
in 1/6 could say? ;)

OK, I'll try to improve and resend.

Oleg.


