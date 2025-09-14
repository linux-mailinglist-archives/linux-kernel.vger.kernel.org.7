Return-Path: <linux-kernel+bounces-815820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16D9B56B77
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89F53A700F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F032853F7;
	Sun, 14 Sep 2025 19:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLKFin2/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A42273D60
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757876578; cv=none; b=HHJ8Ch7lLFLO8WlfbTPTcimctdGOlBEDFSGweQGZp6g4Brn8CMxAbuF+yBsymHwgzyjaNjnZ6LjqC8Syf0wf/P3JnOIU90SHON0sebbMxCLy+TY1WUjHzIeMM98A171LNlhray2M6dnTWXqumTINib/wVFWowkxMI58UyMkHL1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757876578; c=relaxed/simple;
	bh=uQ8cc/B0l1LxciWirvipcGopabdiN943N6lZ6WRge7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iELMaVZI92D8J4BWHHJkNn7QxL14PfT28xO6qbt+M5Pa5BpPsnH3k06GulUDorO7XHA+4fzODCx0CcRsbOnGya/hAqHzKw9CQOiEC1oVsT12deX6xmthYoA5VH5HcldhoiNns6igTd1+kJKy03ZEk1QUrj84ip3rjqSLdaigUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZLKFin2/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757876576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uQ8cc/B0l1LxciWirvipcGopabdiN943N6lZ6WRge7g=;
	b=ZLKFin2/css++PB8nSILFX1KV7F/zz+CZiF3X5CbVmlCK9BAT1Slfb7mI5uq6/Q+p28b3h
	LOjwOvXRWTOqHu0CR33a0rHPqTxdFVWlx3c6pmTXK2g620L1dr56Ct2FQOECJR09urMiE8
	MwhSdUxMhdkC+tV+Ee1ZhI67I//jKng=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-ZzSL64iTPr-ch__u3t6XRQ-1; Sun,
 14 Sep 2025 15:02:52 -0400
X-MC-Unique: ZzSL64iTPr-ch__u3t6XRQ-1
X-Mimecast-MFC-AGG-ID: ZzSL64iTPr-ch__u3t6XRQ_1757876571
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5EAD180048E;
	Sun, 14 Sep 2025 19:02:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8805119560A2;
	Sun, 14 Sep 2025 19:02:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 14 Sep 2025 21:01:26 +0200 (CEST)
Date: Sun, 14 Sep 2025 21:01:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fix the racy usage of task_lock(tsk->group_leader)
 in sys_prlimit64() paths
Message-ID: <20250914190122.GA23082@redhat.com>
References: <20250914110908.GA18769@redhat.com>
 <20250914110937.GA18778@redhat.com>
 <CAGudoHGwEYg7mpkD+deUhNT4TmYUmSgKr_xEVoNVUaQXsUhzGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGwEYg7mpkD+deUhNT4TmYUmSgKr_xEVoNVUaQXsUhzGw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Too late for me, I'll write another email tomorrow, just one note for now...

On 09/14, Mateusz Guzik wrote:
>
> On Sun, Sep 14, 2025 at 1:11 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Fixes: c022a0acad53 ("rlimits: implement prlimit64 syscall")
>
> I think this is more accurate:
> Fixes: 18c91bb2d872 ("prlimit: do not grab the tasklist_lock")

I'll re-check, but at first glance you are right... Thanks for taking
a look and correcting me!

Oleg.


