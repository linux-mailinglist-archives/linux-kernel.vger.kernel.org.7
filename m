Return-Path: <linux-kernel+bounces-770883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89944B27FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFFEAA69B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C5B2882A2;
	Fri, 15 Aug 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pv3bApsp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D649E2571C9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260614; cv=none; b=gnxN2AYAjJT6GUTVolKn2qPgEXGHGzpqEjtMIf25eZBcypyBb5Gh9tyeQzj/inKg3lrlxIvFQyXa7jIHkn19bDrCy/bUQtWuzvy6snyNxdavuQ/lzg/JLTEDeSuYS8DTrBkC3X8DLInMNSBdlBGyopqTFMNCvJRhU7tumZIl8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260614; c=relaxed/simple;
	bh=e8Y5O+8USAyMj9qGF8vUofbC0P8+sp/aVWfH4vDIwC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajxTE7JBdKxA3hEzOeE+kKoG34f29TPric5yoSyPCy/0JfUSjsLl3vulhXdeaXjgoeXejI+txY4zeT1LGo6r/x6pu118OwD9Zxqgypa3qtdA5MFLycX5o/yCIxNq3yExoOqTKQusSybIsU3joox9a2gcSZdVH6EqxcZXTNtAKIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pv3bApsp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755260611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h/oPpehKajq7mksL9mCk+QbZa3JyvwOggoOLtH/tiJE=;
	b=Pv3bApsprEcKt1CJX00P953FBeUJ3Qx8pC9eZcnqw3jGKrfD7wqYPcKvLt9XPWuhLRRfCY
	+tphLOdm4o1wI7DRc7xHt/UMjGNbJz7BoItwjnNXMJjGH1VrUra2b5YjFjPt58XROhg8gI
	JXiK82On5Z87h3wAaSNc1MjmszV1IVE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-w5cZhe8tNYq852_-o2sk1A-1; Fri,
 15 Aug 2025 08:23:28 -0400
X-MC-Unique: w5cZhe8tNYq852_-o2sk1A-1
X-Mimecast-MFC-AGG-ID: w5cZhe8tNYq852_-o2sk1A_1755260606
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48C8D180045C;
	Fri, 15 Aug 2025 12:23:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BC9D31800446;
	Fri, 15 Aug 2025 12:23:21 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 14:22:09 +0200 (CEST)
Date: Fri, 15 Aug 2025 14:22:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 1/6] x86/fpu: change copy_xstate_to_uabi_buf() to accept
 fpstate + pkru instead of task_struct
Message-ID: <20250815122203.GC11549@redhat.com>
References: <20250814101411.GA17341@redhat.com>
 <a54c86dee04ab8047f337c102fab611d9ce2ac31.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a54c86dee04ab8047f337c102fab611d9ce2ac31.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/14, Edgecombe, Rick P wrote:
>
> On Thu, 2025-08-14 at 12:14 +0200, Oleg Nesterov wrote:
> > Preparation for the next change.
> >
> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>
> These patches and the coverletter have very little information.

Agreed. I forgot to add the links to the previous discussions,
please see

	Warning from x86_task_fpu()
	https://lore.kernel.org/all/aJVuZZgYjEMxiUYq@ly-workstation/

	PF_USER_WORKERs and shadow stack
	https://lore.kernel.org/all/20250813162824.GA15234@redhat.com/

Oleg.


