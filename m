Return-Path: <linux-kernel+bounces-841269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B148ABB6AC9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638BC189CAF5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2E72EE5FC;
	Fri,  3 Oct 2025 12:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT9FMZsX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D1224AF2
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495200; cv=none; b=uiQwctyfjub/YBuU/FjT54hc+q6h/Jv7n/JKLG7cqRWETs6P+rhZ2XupzzN6wMVGFZ5ArsH2no7h1ORhToIOpTVvYQ1GlPkxxkCwtrxXVGWL3rWHLwxlM0IfWp5i8KU7kQ4Lxmf8F4SAu7APsVB/MLaEcZXKNfbD57Ax2F/vytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495200; c=relaxed/simple;
	bh=9A78CDlKPdE/G3ud0FfpN0ppIk0qRsHr1onljfra9yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Els96dzdAUZoPDqPhW1100k8y6QXtw99gEMpAlzV7Q+Lm5BWrIhk/fEmHDm3pn2BBBoa7QNRfCiVswLwE2PR4KI5jWu7k71sarHHfZ12qZ05Z71REhBkshbF5VsyONS5K5HW7HRjSk26HJzfKWrtNuBOWm3ACjPU2NUCmxCLL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bT9FMZsX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759495198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T3AVLyGFLBynIcpf9ymKOC4jJBHetGtbQDv+YF5pFPM=;
	b=bT9FMZsX9gjnpdWR+jc6xnxy5BzAMAmxkIuNdpK/SvpGv+BJ7sYswre89dH9NcXTVYaLrU
	D8Sr3RDhA0utirTmlPlWG98W5Hj/4fwUoEVfE7UIeDNu0zK/q+S2DiHF2W0MlistdHl8lO
	h3uTWkoorJaHWB2QJzLi5CQ3sMQQ5oQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-rqLju7_oPoKI_SE53IapvA-1; Fri,
 03 Oct 2025 08:39:54 -0400
X-MC-Unique: rqLju7_oPoKI_SE53IapvA-1
X-Mimecast-MFC-AGG-ID: rqLju7_oPoKI_SE53IapvA_1759495193
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2811719560AE;
	Fri,  3 Oct 2025 12:39:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BFD9018004D8;
	Fri,  3 Oct 2025 12:39:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  3 Oct 2025 14:38:31 +0200 (CEST)
Date: Fri, 3 Oct 2025 14:38:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Demi Marie Obenour <demiobenour@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PID namespace init releases its file locks before its children
 die
Message-ID: <20251003123828.GA26441@redhat.com>
References: <58ac5d49-14a9-4fe6-a5a4-746d6b73f82b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ac5d49-14a9-4fe6-a5a4-746d6b73f82b@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add CCs.

I can't really help, just my 2 cents...

I don't think we can change do_exit() to call exit_files() after
exit_notify().

At first glance, technically it is possible to change do_exit() so
that the exiting reaper does zap_pid_ns_processes() earlier... But
even if this is possible, I think that this complication needs more
justification.

Oleg.

On 10/02, Demi Marie Obenour wrote:
>
> I noticed that PID 1 in a PID namespace can release file locks (due
> to exiting) while its children are still running for a bit.  If the
> locks held by PID 1 were relied to serialize the execution of its
> child processes, this could result in data corruption.
>
> Specifically, the child processes are killed via exit_notify() ->
> forget_original_parent() -> find_child_reaper() ->
> zap_pid_ns_processes().  That comes *after* exit_files(), which
> releases the file locks.
>
> While it is possible to implement this with cgroups, cgroups
> are quite a bit more complicated to use, at least compared to
> a single call to unshare() before fork().
>
> Is this intentional?  Changing the behavior would make supervision
> trees significantly easier to properly implement.
> --
> Sincerely,
> Demi Marie Obenour (she/her/hers)


