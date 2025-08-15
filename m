Return-Path: <linux-kernel+bounces-771382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB98B2863B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8018F3A9ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F930225402;
	Fri, 15 Aug 2025 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3ye08IV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777793176EB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755285279; cv=none; b=fbRO8++oNAxXZMCkxoozWCXDrhzH2UnmPxMFuwfgULApT5r7kWWrpPHD0C8eX4bim0e0ZkagBIJwY8mdvK1PUQcYbL+zvnSrPT8q+Cn6BnKfV/Mwv/VS3bd8tzkQ29kytRK5Y4ZyWeuMMRqJa98FxVqEGnqZRgqe3FDCwipd92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755285279; c=relaxed/simple;
	bh=t7lDdd/prjdNckA3dH6FxmW8FJ9YrEOD3cdSwXgfAn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAvBhFY6JQ6yqeutTa2i+3dki2cgWv6+Dk5/mqdWNLFGyUTVaHzlQ+aJSdYcbwyKTdAfbLNHp9w913n5KPdPm31KMoJLRSm4jhu2jo638UA1xkggz4uH0NSjgX5ky4Tm4upzeV2E6WvoNf1OS5xLZGDz38Wgj78wA6sRq3a5tQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3ye08IV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755285277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7lDdd/prjdNckA3dH6FxmW8FJ9YrEOD3cdSwXgfAn8=;
	b=h3ye08IVIS4vqh0NgpaPq5i7ILg5F9wmBhqf0VrDJWbm2ZBvqkxOyb/nlVZ/YpMeMx9DCv
	lBo3KVSJPtPBIwNISGc0Ci2MN1YAxFp2oGJIUcnCLK3aTH9L2NvecMa/yPHv2iJlOL9NB2
	O80rMYP3B6YaNas8zZ7dvsN/1vzebus=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-Qq_5zeBEO0qiGHCA0Gd_Kg-1; Fri,
 15 Aug 2025 15:14:33 -0400
X-MC-Unique: Qq_5zeBEO0qiGHCA0Gd_Kg-1
X-Mimecast-MFC-AGG-ID: Qq_5zeBEO0qiGHCA0Gd_Kg_1755285271
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74C1D1955D56;
	Fri, 15 Aug 2025 19:14:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.33.47])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CFBA81800280;
	Fri, 15 Aug 2025 19:14:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 15 Aug 2025 21:13:13 +0200 (CEST)
Date: Fri, 15 Aug 2025 21:13:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "debug@rivosinc.com" <debug@rivosinc.com>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 5/6] x86/shstk: don't create the shadow stack for
 PF_USER_WORKERs
Message-ID: <20250815191306.GK11549@redhat.com>
References: <20250814101435.GA17362@redhat.com>
 <8818b456954644ce609e07d77a65714788ef9098.camel@intel.com>
 <20250815121702.GB11549@redhat.com>
 <cf6441dca8fe5d7c568d01e43adf715e9a35a9ba.camel@intel.com>
 <20250815165445.GJ11549@redhat.com>
 <e802f42ac5d6cf4f5ac5e5693357efa67b2af85e.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e802f42ac5d6cf4f5ac5e5693357efa67b2af85e.camel@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Rick,

I'll try to write another email and send V2 next week.

Although perhaps I'll send some other unrelated and "obvious" cleanups
before that...

Until then:

On 08/15, Edgecombe, Rick P wrote:
>
> Maybe you can explain

Damn yes, agreed, my fault.

> Stop me if I'm telling you something you already know...

Or, quite possibly, you should stop me to send the patches which change
the code I can hardly understand ;) And that is why I CC'ed the experts
like you.

See you next week,

Oleg.


