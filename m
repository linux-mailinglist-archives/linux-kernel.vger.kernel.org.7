Return-Path: <linux-kernel+bounces-710299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F304AEEA86
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jul 2025 00:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3581BC3639
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 22:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17605245033;
	Mon, 30 Jun 2025 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrU3Hb++"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7772E53365
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 22:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751323076; cv=none; b=ZFJZLhUehZTKtQoNYqGItu648LCPBVDXfK7vhBE8zxBip36eXk5SMaKzdRCmCGm/zjc2eiUDRFR5KI6L9VlNGmI7jPcvr469KeIaPZQ2xe75UssprlgRt1BHw+uT71VF2AY/Itj9afjxUtwt6PtPe+7kDDr9DrZuBToQeGbDLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751323076; c=relaxed/simple;
	bh=70ucvB4aUq/iqvMNuc+VM5RiPbZbdmEYZzLs1r23dvk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Bgl0qQysYLyNZWqO/gOQhq4TvRbfQNACZW+onPYVkAbV2GGcQTnPe2+eTLIVO3yCFWlNQSQEmsJmY80RJ1/j5bXLkha6Da5678XkUyP8Po6pEjY21lPlW2D+hAWcyB5PLsNh/2iW8lWKD0R0sZw+HNQKtPRAeQ/l+NzFZ51fnSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrU3Hb++; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751323073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BecaxFgtj7pMRsMs9KUUG3vkYqYBX4743BMREMi+3UU=;
	b=QrU3Hb++jpPS5YcP3YxrCmSFAjDNalb6+3P26F3WBt2JsLqwZIuEnBrj6IndoIdlrCMOAb
	OfjyNFM5zOjOSFEjcdBm86SuA6oLuv3ycJlQ99wYWq7hlxh2i9dzn3jiFcTgJuoT2PruIm
	q8TSeus/vdC5K9dGcoJz8v+zhGl/Kfc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-zSDp7qCiP--Nt3jm6LTobw-1; Mon,
 30 Jun 2025 18:37:51 -0400
X-MC-Unique: zSDp7qCiP--Nt3jm6LTobw-1
X-Mimecast-MFC-AGG-ID: zSDp7qCiP--Nt3jm6LTobw_1751323070
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78AA218011EF;
	Mon, 30 Jun 2025 22:37:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6725195608F;
	Mon, 30 Jun 2025 22:37:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250630180440.3eabb514@batman.local.home>
References: <20250630180440.3eabb514@batman.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>,
    Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
    Masami Hiramatsu <mhiramat@kernel.org>,
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer: Remove ring_buffer_read_prepare_sync()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2127242.1751323067.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Jun 2025 23:37:47 +0100
Message-ID: <2127243.1751323067@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> =

> When the ring buffer was first introduced, reading the non-consuming
> "trace" file required disabling the writing of the ring buffer. To make
> sure the writing was fully disabled before iterating the buffer with a
> non-consuming read, it would set the disable flag of the buffer and then
> call an RCU synchronization to make sure all the buffers were
> synchronized.
> =

> The function ring_buffer_read_start() originally  would initialize the
> iterator and call an RCU synchronization, but this was for each individu=
al
> per CPU buffer where this would get called many times on a machine with
> many CPUs before the trace file could be read. The commit 72c9ddfd4c5bf
> ("ring-buffer: Make non-consuming read less expensive with lots of cpus.=
")
> separated ring_buffer_read_start into ring_buffer_read_prepare(),
> ring_buffer_read_sync() and then ring_buffer_read_start() to allow each =
of
> the per CPU buffers to be prepared, call the read_buffer_read_sync() onc=
e,
> and then the ring_buffer_read_start() for each of the CPUs which made
> things much faster.
> =

> The commit 1039221cc278 ("ring-buffer: Do not disable recording when the=
re
> is an iterator") removed the requirement of disabling the recording of t=
he
> ring buffer in order to iterate it, but it did not remove the
> synchronization that was happening that was required to wait for all the
> buffers to have no more writers. It's now OK for the buffers to have
> writers and no synchronization is needed.
> =

> Remove the synchronization and put back the interface for the ring buffe=
r
> iterator back before commit 72c9ddfd4c5bf was applied.
> =

> Reported-by: David Howells <dhowells@redhat.com>
> Fixes: 1039221cc278 ("ring-buffer: Do not disable recording when there i=
s an iterator")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Tested-by: David Howells <dhowells@redhat.com>


