Return-Path: <linux-kernel+bounces-871898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E02C0EC76
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCCF55020A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E057930C350;
	Mon, 27 Oct 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RcM+SSkA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6183081D7
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576968; cv=none; b=C2/Rd+VjM25kYrKQ+nr6eQla9GRY2b48dUeMvxAx8GePSmElstXxEdN4WBUzRGfcVoUD79k+O/STgvJqGlcqRE/QnzHqc8M30by+INTcZqYPQ86kVrhaLnDJdTLdxI03JZOYFSl1Cai7auqfSxzcPt64JubYQOeV3kp/6vMkLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576968; c=relaxed/simple;
	bh=MdHdwbyRwOneokDrrak8W58rH/i7XxR4qPE6h2RGc/0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=IXGBFDCwSnfKRHLThBBeUCGEp6eBAyyRW1l41b/fBEIop/0xozFiR3+kSO4KkvjhXrPbMXFJ3q6pn3RnSGUNFIQnmTy3V6xsu8PifGuLle5Ewn2Am439fSVzp0W6jxQoiCz6ihz4nY7DOXKld7z6GHjyhyuHa0Of4fzTOlMAkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RcM+SSkA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oLyWzWnQzJKD0XolAql4Q3+iH78Y+upjEhl1CSo9Dzw=;
	b=RcM+SSkAPHoCYnYsDkFzwi8TXJKTXwyjj87gSgaA7gh8728i9GiRM2YG8NcfuNwnu6XsTY
	3nUkW0BXjfwEbxOuWdjrEaPUDp7Wk0s3Fi1CRdPAWBNeva5/YD/NxSrVlV2qyGKh22VmRC
	y4rHHFYHVMIuU1VGzbr5JZ1D0j0pxBs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-kXZrtj4dNwuzfVfBFUHFcQ-1; Mon,
 27 Oct 2025 10:56:00 -0400
X-MC-Unique: kXZrtj4dNwuzfVfBFUHFcQ-1
X-Mimecast-MFC-AGG-ID: kXZrtj4dNwuzfVfBFUHFcQ_1761576959
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87A55196F747;
	Mon, 27 Oct 2025 14:55:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9CFA19560B2;
	Mon, 27 Oct 2025 14:55:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20251026143501.GA22472@redhat.com>
References: <20251026143501.GA22472@redhat.com> <20251026143140.GA22463@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Alexey Gladkov <legion@kernel.org>,
    Andrew Morton <akpm@linux-foundation.org>,
    Mateusz Guzik <mjguzik@gmail.com>,
    "Paul E. McKenney" <paulmck@kernel.org>,
    linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/1] kill task_ucounts()->rcu_read_lock(), add __task_ucounts()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2258931.1761576956.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Oct 2025 14:55:56 +0000
Message-ID: <2258932.1761576956@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Oleg Nesterov <oleg@redhat.com> wrote:

> So I think task_ucounts() can just do
> =

> 	/* The caller must ensure that ->real_cred is stable or take rcu_read_l=
ock() */
> 	#define task_ucounts(task)	\
> 		rcu_dereference_check((task)->real_cred, 1)->ucounts

Can you use rcu_access_pointer() within exit.c?  E.g.:

	struct cred *pcreds =3D rcu_access_pointer(task->real_cred);
	dec_rlimit_ucounts(pcreds->ucounts, UCOUNT_RLIMIT_NPROC, 1);

David


