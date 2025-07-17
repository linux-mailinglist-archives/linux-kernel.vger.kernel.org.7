Return-Path: <linux-kernel+bounces-734509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56668B08295
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38841A65A29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E01E0083;
	Thu, 17 Jul 2025 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UEpo+rqR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF331A4E70
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716701; cv=none; b=K7vywl+1y4SuEDJh//qSSj7yxistqux9InlAKsL4ddt/K4JbUTsFeGcXW+pJMAt5feGqMQu6NnXKVj55c4MMVM3MLE5VDMIl6aaNQN3V98laqq92cFNwFJfPST9Pof1tAjq94fdmN6mMDj0rQ8hUiCK+Ain45zDHL5Je10WQbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716701; c=relaxed/simple;
	bh=ONLWOvD91xvIKfJNcN6tYgfnVKNjFuGu3WLSSsooFIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRePpydD//NFRHeAAhl3/1CwIksSMoP1aFdgfuM2VmQbCTQndl0FXdfkoloAYExMqyUK4s/o+BvRlTCpPeH/kPPNR77phFVeNq4MV/Cdy9Cuxt6qSw48Xv+wHEOEKbr9z29z5ZwoVjTZbT9QuUEMmBKNtyMe2nEzdxn/2uUzQqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UEpo+rqR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752716699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONLWOvD91xvIKfJNcN6tYgfnVKNjFuGu3WLSSsooFIs=;
	b=UEpo+rqRB7UkN/kwSwbljk4nUP+F0FUFeWaEr+3/5Zo80qfLgWmIYLbFvLSMw4eLK+cQSR
	zNRVy2JkxSFRj0J4ZTNBeBtCqtkRbkhsNrhThZP3oyKWZ+NQzr4hYK3IGuBsLobL5CPazn
	BWtrVCfpwPSNmBe2R9rj+RnXhFlcLzg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-3xMH7MR0MAShw8kPpdOueQ-1; Wed,
 16 Jul 2025 21:44:54 -0400
X-MC-Unique: 3xMH7MR0MAShw8kPpdOueQ-1
X-Mimecast-MFC-AGG-ID: 3xMH7MR0MAShw8kPpdOueQ_1752716693
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CB51180034E;
	Thu, 17 Jul 2025 01:44:52 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.32.192])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 50ED11954213;
	Thu, 17 Jul 2025 01:44:48 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 17 Jul 2025 03:44:01 +0200 (CEST)
Date: Thu, 17 Jul 2025 03:43:57 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: Peter Zijlstra <peterz@infradead.org>,
	"rafael J . wysocki" <rafael@kernel.org>,
	len brown <len.brown@intel.com>, pavel machek <pavel@kernel.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PM / Freezer: Skip zombie/dead processes to reduce
 freeze latency
Message-ID: <20250717014356.GG16401@redhat.com>
References: <20250716062639.1528066-1-zhangzihuan@kylinos.cn>
 <20250716062639.1528066-2-zhangzihuan@kylinos.cn>
 <20250716163854.GE16401@redhat.com>
 <20250716183637.GJ4105545@noisy.programming.kicks-ass.net>
 <f5985910-d175-4c51-90b6-9d087a59936b@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5985910-d175-4c51-90b6-9d087a59936b@kylinos.cn>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 07/17, Zihuan Zhang wrote:
>
> The main reason we didn’t rely directly on PF_NOFREEZE is that it’s a
> mutable flag — in some cases, it can be cleared later, which makes early
> skipping potentially unsafe.

Afaics userspace tasks can only set PF_NOFREEZE in do_task_dead() and never
clear it.

Apart from lock_system_sleep(). That is why (I think) Peter rightly suggests
to take system_transition_mutex in this function earlier.

> In contrast, exit_state is stable and skipping tasks based on it is safe.

I don't think it is really safe...

Oleg.


