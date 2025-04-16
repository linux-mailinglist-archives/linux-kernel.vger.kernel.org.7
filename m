Return-Path: <linux-kernel+bounces-603288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D43A88598
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 16:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33AD1617C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 14:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430B72973D4;
	Mon, 14 Apr 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ErlMj3PN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B52820BD
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640935; cv=none; b=L6ayOr2ebK89U5qiaicBvoPQylQeI6z5VQCe66zoo4mDs+uW7pqBBXVqd9R96Ds3IRA5RAq5PO5MR63iEhjVgNgPbq/A7xkmveRPTuv0DiKplJqzuwREFT1c0cPV/IOfewc2ybSvksWNDp87hdJq4xCql/5vQGfQu3y1vhYjCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640935; c=relaxed/simple;
	bh=blv48R6B7vWiz0UYLJWcs3h270DPa8dk2P5WDUKDcFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbS3mAgJvC81TDd8nZ/oigZrtGuqXlkG0PcnK2+tkqw5Vb0/VsENT0bSkKdH4p7pU+l+NjD/wyCalVgqoO+rsAxpEWZlO+Vmn+X6gZUQ/NW6TTG9ZnQ73f+eNtxdIDDD2IL+baXdRMU2dU1rEh6EqZ97/ua+6YlcTmUDCQItPKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ErlMj3PN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744640932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmzL+6oHQI4eVdsu/YCAC9ojI8tmHQUBWtrcimZovNI=;
	b=ErlMj3PNgIITryvizvZo7a+M2XsnqTTX7eAiemHoNw4JtRIU5V+4sy97lRGmq9dJ5736GI
	fK2QFbRuv8o875c8nXSNN3ZasXJHc026j98m0pNaRhJ+3EMgDxfTzD5b8o60UBtGsdnF6g
	JfT1TpqoeUu45Jlryv7AfttAX3pDNWA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-lWgCaTSoPH-42IKj5yl_QQ-1; Mon,
 14 Apr 2025 10:28:49 -0400
X-MC-Unique: lWgCaTSoPH-42IKj5yl_QQ-1
X-Mimecast-MFC-AGG-ID: lWgCaTSoPH-42IKj5yl_QQ_1744640928
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB5C8180025A;
	Mon, 14 Apr 2025 14:28:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B24CB195DF86;
	Mon, 14 Apr 2025 14:28:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 14 Apr 2025 16:28:12 +0200 (CEST)
Date: Mon, 14 Apr 2025 16:28:07 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Luca Boccassi <luca.boccassi@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Mike Yuan <me@yhndnzj.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
Message-ID: <20250414142807.GF28345@redhat.com>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
 <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
 <20250414141450.GE28345@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414141450.GE28345@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04/14, Oleg Nesterov wrote:
>
> On 04/14, Christian Brauner wrote:
> >
> > -static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> > +static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
> >  {
> >  	struct file *files[2];
> >  	struct coredump_params *cp = (struct coredump_params *)info->data;
> >  	int err;
> >
> > +	if (cp->pid) {
> > +		struct file *pidfs_file __free(fput) = NULL;
> > +
> > +		pidfs_file = pidfs_alloc_file(cp->pid, 0);
> > +		if (IS_ERR(pidfs_file))
> > +			return PTR_ERR(pidfs_file);
> > +
> > +		/*
> > +		 * Usermode helpers are childen of either
> > +		 * system_unbound_wq or of kthreadd. So we know that
> > +		 * we're starting off with a clean file descriptor
> > +		 * table. So we should always be able to use
> > +		 * COREDUMP_PIDFD_NUMBER as our file descriptor value.
> > +		 */
> > +		VFS_WARN_ON_ONCE((pidfs_file = fget_raw(COREDUMP_PIDFD_NUMBER)) != NULL);
> > +
> > +		err = replace_fd(COREDUMP_PIDFD_NUMBER, pidfs_file, 0);
> > +		if (err < 0)
> > +			return err;
>
> Yes, but if replace_fd() succeeds we need to nullify pidfs_file
> to avoid fput from __free(fput) ?

Aah, please ignore me ;) replace_fd/do_dup2 does get_file() .

For this series:

Reviewed-by: Oleg Nesterov <oleg@redhat.com>


