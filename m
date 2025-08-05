Return-Path: <linux-kernel+bounces-756410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1ACB1B3A4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22DD1825CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6512A27056B;
	Tue,  5 Aug 2025 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP/feiuA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3F1A0BFD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754397862; cv=none; b=s/LX6rH4h3rrdM0okUReB4+pWADAznjvAGMd/tqYnkFXRwLtVLJd4JWSsF7uuAEzmZonotcynnGtsDiOll0opdrDPHSd0lcjpFT2LjVSXJ2CeJCuJSIpTBth74FkKapRuTPdMiSikrkoBYvstcB/RmBgsiow4K5k1Z7e6fQzlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754397862; c=relaxed/simple;
	bh=G9961m1tbKgfqRsf3FapE5jKGaky3PNuYKNN9/JNXIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BM+7aezeI62gQ7zfAiZBycjfKjaaRkvhbeQqRPSvM7uVi2omRENTjFvVjjDkl2Tov2E3ooSPA8edAiujw7ZayW0BM/zkEi+/4lSGOlJzQ88uOuZqT4IUjima5ov/ytcpBHidW8lSo40MXEqO8rAkBKZkV3xmcaetPpkIM1QI6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CP/feiuA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754397860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BRG1q6AqVJMdo+NBgx/LIt8o6LydghFBWTbZ7lAWqJA=;
	b=CP/feiuA4hOh+2veq40jse4GSZlatuq11RqR8zuDpGB12uPFUGjeSdc9vCaQT/kwP7XEbD
	LBXafGM+opgJvWItSo01fp6vS53lcF2I88HGy2G9jfrcau0iTLAOpB8FBiDL0ZNaOroSD2
	uoIZsj2lh2qBIDXHmk4t7HltJVfaNl0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-49mpS3CcP3u6ekWPNB-y8Q-1; Tue,
 05 Aug 2025 08:44:18 -0400
X-MC-Unique: 49mpS3CcP3u6ekWPNB-y8Q-1
X-Mimecast-MFC-AGG-ID: 49mpS3CcP3u6ekWPNB-y8Q_1754397857
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CAF8D19560B4;
	Tue,  5 Aug 2025 12:44:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.134])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 382B83000199;
	Tue,  5 Aug 2025 12:44:12 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  5 Aug 2025 14:43:05 +0200 (CEST)
Date: Tue, 5 Aug 2025 14:43:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Xiang Gao <gxxa03070307@gmail.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"joel.granados@kernel.org" <joel.granados@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pid: Add a judgment for ns null in pid_nr_ns
Message-ID: <20250805124300.GB27131@redhat.com>
References: <20250802022123.3536934-1-gxxa03070307@gmail.com>
 <20250802022550.GT222315@ZenIV>
 <15b18541f37447dd8d5dbd8012662f67@xiaomi.com>
 <20250802084525.GB31711@redhat.com>
 <80be47cb31d14ffc9f9a7d8d4408ab0a@xiaomi.com>
 <20250804114900.GA6656@redhat.com>
 <20250804-gepfercht-delfin-0172b1ee9556@brauner>
 <20250804124402.GB6656@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804124402.GB6656@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/04, Oleg Nesterov wrote:
>
> But. I need to re-check, but I just realized that pid_alive() can't
> really help, tsk->thread_pid is not stable even if tsk == current.
>
> This means that, say, task_ppid_nr_ns() is buggy.

After the quick grep I don't see the problematic users, but if a zombie
task T does task_ppid_nr_ns(current, NULL) the kernel can crash:

	- pid_alive() succeeds, the task is not reaped yet
	
	- the parent/debugger does wait()->release_task(T), T->thread_pid
	  is NULL now

	- T calls task_tgid_nr_ns()-> ... pid_nr_ns(ns => NULL) because
	  task_active_pid_ns(T) returns NULL

Do you think this worth fixing?


In any case, I think that task_state(), sched_show_task(), bacct_add_tsk()
should be changed to use task_ppid_nr_ns(tsk).

Oleg.


