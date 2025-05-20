Return-Path: <linux-kernel+bounces-655779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69813ABDCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 16:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31B01BA80EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD97242D9A;
	Tue, 20 May 2025 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpaS5hHl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7208824EABF
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750822; cv=none; b=YwKmZlQIF9E9HJ+HRnJhsMFyySpqHvaeO6D7HzHGabFFNo9mlNy5HJAzwN5MLoi2c7YsWMNjvLoDhNSV0QUCMKqi2HPisRN7fTpvo03DMTX3MNKpkOZerEUMpuwXJrokyEQsg3cto56sGrxdBHtiCsXYzB/Gayl42i5KLCmITZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750822; c=relaxed/simple;
	bh=+pKe3ck/6B3jjTiCmlM/AatiZWL2tPejKJVBqxJfsVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZhcL1ZOmGSOcwbOAYlaljjz8rjAYM4vYkPKqbG3J3SBtP3XF9BjVzdRrcAABw37YA8BVwZj8105WAcZfn2/A0fynR0al7TV7iJKIeO1epdxczW09yBeB7RdxUKk0bctWxwxvIPGu62iOk7s2B+BeDeV21T5b/WICZIqFc9Ugsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TpaS5hHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747750819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pKe3ck/6B3jjTiCmlM/AatiZWL2tPejKJVBqxJfsVw=;
	b=TpaS5hHl11hLfIkT/mk8Y93OvwBoOXGX0Oq2I3Dk1ywmA4rwj4AMAqq569AocqVOsacd0d
	9L05mFmI1sV42KZgar60fCW38vhSfhW0YTsMpomi5dHiYBgr+yyoJMcT/3dOXBHvtt1BZN
	bE+CtmXHR+f/f0HnJ/HVnhTB6679rxE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-H7R8yQVyM1qhTni96rWP5g-1; Tue,
 20 May 2025 10:20:17 -0400
X-MC-Unique: H7R8yQVyM1qhTni96rWP5g-1
X-Mimecast-MFC-AGG-ID: H7R8yQVyM1qhTni96rWP5g_1747750815
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7499119560AE;
	Tue, 20 May 2025 14:20:14 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.11])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3330418004A7;
	Tue, 20 May 2025 14:20:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 20 May 2025 16:19:33 +0200 (CEST)
Date: Tue, 20 May 2025 16:19:26 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 01/22] uprobes: Remove breakpoint in
 unapply_uprobe under mmap_write_lock
Message-ID: <20250520141925.GA14203@redhat.com>
References: <20250515121121.2332905-1-jolsa@kernel.org>
 <20250515121121.2332905-2-jolsa@kernel.org>
 <20250520084845.6388479dd18658d2c2598953@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520084845.6388479dd18658d2c2598953@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 05/20, Masami Hiramatsu wrote:
>
> On Thu, 15 May 2025 14:10:58 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
>
> > Currently unapply_uprobe takes mmap_read_lock, but it might call
> > remove_breakpoint which eventually changes user pages.
> >
> > Current code writes either breakpoint or original instruction, so
> > it can probably go away with that, but with the upcoming change that
> > writes multiple instructions on the probed address we need to ensure
> > that any update to mm's pages is exclusive.
> >
>
> So, this is a bugfix, right?

No, mmap_read_lock() is fine.

To remind, this was already discussed with you, see
[PATCH 02/12] uprobes: grab write mmap lock in unapply_uprobe()
https://lore.kernel.org/all/20240625002144.3485799-3-andrii@kernel.org/

And you even reviewed this patch
[PATCH 1/2] uprobes: document the usage of mm->mmap_lock
https://lore.kernel.org/all/20240710140045.GA1084@redhat.com/

But, as the changelog explains, this patch is needed for the upcoming changes.

--------------------------------------------------------------------------
Just in case... I'll try to read this series tomorrow, but at first glance
this version addresses all my concerns.

Oleg.


