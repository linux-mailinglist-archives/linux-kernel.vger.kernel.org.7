Return-Path: <linux-kernel+bounces-880294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73839C255C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20AAE4E6EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90806346FB8;
	Fri, 31 Oct 2025 13:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PznRy8FW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C10333BBA6
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761918874; cv=none; b=N508DH/ok2JH7cjBaiW3AhLgvX7MQ592HMfQuCbN6gl6FrDcUzNUgipHfoI5JWqR1ZuINV9Bkc+mgQUOk4oqmBKKV1Q9YQLe8KsV0GrV00I0qKrMl5ZrwMofS2LomNsn8A/7lz4bDZVKKLtXG8HbXW0gR0cvkYQvWmgroRsZNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761918874; c=relaxed/simple;
	bh=UpmbjF6Zs1hHIWQyIDco0Hra0hpNWLtyu9EnR85Tt/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh+HG46F1JYLmz+MO/thfm2O5/MxOonc/D/Sid4lLYLR/y6dIbr3Io1/tsxDT5HicETkrjQYWtq3zfjjU+fWb8VTXsHFncKjPkbJTFomQPwPINssBxZIDHVrWcMTUBEYdsWFjja4+6bff4X4Y3C3lVEVA7uNxVtwaRpQPUB6i1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PznRy8FW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761918871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BqMO2QKUKe+E52TSitgq7APz0ND774xAGDj2FAINAxM=;
	b=PznRy8FWf95ETYzk5cs11ANT/p12ZmB3CK4VjkiSCpGHmoy9UkEfvaAMfHIUpHJnUHisC3
	atvRzdz63dciWoHYwcS/Np3aPFvOvTO4wceYYnBiHuoS1a5+XUrH53uk/acO0h1J3exKbU
	8MOSLjrHDorHzO2ngyvZw9NR+zj5/6U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-TDS3OoOJNgeowEKBAl_aoA-1; Fri,
 31 Oct 2025 09:54:27 -0400
X-MC-Unique: TDS3OoOJNgeowEKBAl_aoA-1
X-Mimecast-MFC-AGG-ID: TDS3OoOJNgeowEKBAl_aoA_1761918864
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F16019560B2;
	Fri, 31 Oct 2025 13:54:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.109])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id B32E519560B6;
	Fri, 31 Oct 2025 13:54:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 31 Oct 2025 14:53:05 +0100 (CET)
Date: Fri, 31 Oct 2025 14:52:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	u.kleine-koenig@baylibre.com, Nicolas Pitre <npitre@baylibre.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Li RongQing <lirongqing@baidu.com>, Yu Kuai <yukuai3@huawei.com>,
	Khazhismel Kumykov <khazhy@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, x86@kernel.org
Subject: Re: [PATCH v4 next 0/9] Implement mul_u64_u64_div_u64_roundup()
Message-ID: <20251031135255.GA22251@redhat.com>
References: <20251029173828.3682-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029173828.3682-1-david.laight.linux@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/29, David Laight wrote:
>
> The pwm-stm32.c code wants a 'rounding up' version of mul_u64_u64_div_u64().
> This can be done simply by adding 'divisor - 1' to the 128bit product.
> Implement mul_u64_add_u64_div_u64(a, b, c, d) = (a * b + c)/d based on the
> existing code.
> Define mul_u64_u64_div_u64(a, b, d) as mul_u64_add_u64_div_u64(a, b, 0, d) and
> mul_u64_u64_div_u64_roundup(a, b, d) as mul_u64_add_u64_div_u64(a, b, d-1, d).

Sorry for the noise. Can't review due to the lack of knowledge.
But this reminds me... What about

	[PATCH v3 1/2] x86/math64: handle #DE in mul_u64_u64_div_u64()
	https://lore.kernel.org/all/20250815164055.GA13444@redhat.com

?

should I resend it once again or we don't care?

Oleg.


