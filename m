Return-Path: <linux-kernel+bounces-833043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C89BA114A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA3F6C1159
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC48631A56B;
	Thu, 25 Sep 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1NgSsp6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21F305E2F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758826325; cv=none; b=qhJc93w1xto1jjhRaQ1ZSeXZBPnmBQW6nuAHaPyrSZpfupS5pOfsUNdnioExBNXBVHu0XPo3f7lYGRuTHiSh9zg40sM9Hu7ZZtHpBLoRFaI65f6I8VknwdBx5fyQADCof60MiVGxJtx4jRjobVc8M21kUq2aDcI1l1Mxcj5NWLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758826325; c=relaxed/simple;
	bh=2nl3Q+zYpLf4KxXkaeDSprSRUWy8a1j4w6Z+Pcea0d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbO+O4C+g14PdnidDOPPaRy6w+wxlTnkz9KoMtNHws53Rq6GhX15ZkZzNGe1GuTMxX8SJRcAcO64GsusB8aJc4Y4O+CHAj9zj9zWsM4rx5jnGOdW2djwdZUmvAqnkORwQQ5+et7XaJ/H/b2r5+ToLfHo7s7tYrr40zfPw+J/76o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1NgSsp6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758826322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nl3Q+zYpLf4KxXkaeDSprSRUWy8a1j4w6Z+Pcea0d8=;
	b=C1NgSsp69X2bS3fTBqVnO2PFgegAzLC9yywO5BGzKJ2j8j2KRI92ttbvGDruYtwGJF8lMn
	qIgLIi0666V2OdXwoVPvziryJYrUg6yt3Ral/AUFdjaBvU2AT5B1k/zqAnLMR66APxo8ER
	wK11Q6NzMrGfxSl/RcJy03uzxeUpXbA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-bQeQQS8TMbu5oCYscIer3A-1; Thu,
 25 Sep 2025 14:52:01 -0400
X-MC-Unique: bQeQQS8TMbu5oCYscIer3A-1
X-Mimecast-MFC-AGG-ID: bQeQQS8TMbu5oCYscIer3A_1758826320
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F38A19560B5;
	Thu, 25 Sep 2025 18:52:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 48D961956095;
	Thu, 25 Sep 2025 18:51:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 25 Sep 2025 20:50:37 +0200 (CEST)
Date: Thu, 25 Sep 2025 20:50:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: Prevent prctl(PR_SET_PDEATHSIG) from racing with
 parent process exit
Message-ID: <20250925185032.GC25838@redhat.com>
References: <20250913-fix-prctl-pdeathsig-race-v1-1-44e2eb426fe9@gmail.com>
 <ef4878fe-3edf-4bd0-bb33-116ced1a4eb8@gmail.com>
 <20250922154819.c3049158ca006e1561ff5dcb@linux-foundation.org>
 <20250923120344.GA12377@redhat.com>
 <CAGudoHED4nx8QT-yw-zdcUApUyvt2HCOR9c3SQ3tAm9J7Q1jEQ@mail.gmail.com>
 <20250925162759.GA25838@redhat.com>
 <CAGudoHGiO8vfyzuRmVHePR_TCeMSXjOv1TFpQ3i8Jk9+RMmTtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHGiO8vfyzuRmVHePR_TCeMSXjOv1TFpQ3i8Jk9+RMmTtQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 09/25, Mateusz Guzik wrote:
>
> It struck me that this mail thread is perhaps a little rude towards
> Demi, so I would like to state the reported race is legitimate and if
> it was reported against come core functionality it would count as
> "good spotting".

Agreed, agreed. Sorry if my emails were not clear in this respect.

Although let me repeat, I didn't know that people still rely on this API,
but this is is almost offtopic.

> > OK. I won't argue with this patch. At least the usage of tasklist_lock is well
> > documented.
> >
>
> ye.. avoiding smp_mb may be a case of "premature optimization", except
> it is also simpler, so that's a really tough call. good news is that
> it's not mine to make ;-)
>
> I guess if the lock acquire goes in the sky is not going to fall,
> worst case this can get revisited later. So fwiw I would be leaning
> towards accepting the patch as well for the time being.

Again, agreed, and sorry if it wasn't clear.

Thanks Demi.

Oleg.


