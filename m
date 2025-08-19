Return-Path: <linux-kernel+bounces-774925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEA2B2B94E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18651963A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDFF2620C3;
	Tue, 19 Aug 2025 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwwTeyWO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B0038B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584316; cv=none; b=TEnBCMsBqu8ebQxXV6aHY3Vt6fWazTCDTQZIn2oOjj91dCbu7G+idTr+g00YWLzSqKErop/LtPLw/dMgVvTcrTzAd3DmZ8mjls1RWrzkZqPS8YYyLyQvN/lliBdGAFz+CmMNXWwa/uIu1M0YiKzw+Kl5x+v/r0cPxV0R3nJQM24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584316; c=relaxed/simple;
	bh=MUXSemgemx2RSAJemxhhidrCft+naaehO5l4DQnoJy4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UUh2deUaU29JanMLuS4l60HJVdBRiqXRQMWpI3esTsS9Y7KfMifAmNH+9dTjJcNab+sqz46JIfZ2/z2KnS9hY2lSgHbEIqLyGwafDHsQE36BgT8JXuAqPO5xyvy0iVs0MkJ8dtEdl53tNGmP+T0CiduPitCrf4EUQLNJjBHF+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwwTeyWO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755584314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A79+ZhsoGDMTj40WO9EJXb2tzabNrvwgqs+8konhKys=;
	b=ZwwTeyWOHbwhhHaOOnnfOVpD7A2cxgxb2EQuu8f+eJwOUCHgYKPlzD5tN9DeH5JLj8Vk/j
	8emC+1VQZg1aQ7RlR2wvt6ygIz2vocBNzXIVGya8C/c+ufYhWaqYwHA24wssaeLrdBNFtg
	KD58fdAlIfWJjL9f4PPagBGj2ZKWX5M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-mia76B0vO_auLu_H0x8c0w-1; Tue,
 19 Aug 2025 02:18:28 -0400
X-MC-Unique: mia76B0vO_auLu_H0x8c0w-1
X-Mimecast-MFC-AGG-ID: mia76B0vO_auLu_H0x8c0w_1755584306
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C68E01800286;
	Tue, 19 Aug 2025 06:18:25 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.44.32.125])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F265F1955F24;
	Tue, 19 Aug 2025 06:18:21 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Jens Axboe <axboe@kernel.dk>,
  LKML <linux-kernel@vger.kernel.org>,  Michael Jeanson
 <mjeanson@efficios.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Peter Zijlstra <peterz@infradead.org>,
  "Paul E. McKenney" <paulmck@kernel.org>,  Boqun Feng
 <boqun.feng@gmail.com>,  Wei Liu <wei.liu@kernel.org>,  Samuel Thibault
 <sthibault@debian.org>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
In-Reply-To: <aKPFIQwg5zxSS5oS@google.com> (Sean Christopherson's message of
	"Mon, 18 Aug 2025 17:28:17 -0700")
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
	<87cy8sy2n6.ffs@tglx> <lhuwm70qvac.fsf@oldenburg.str.redhat.com>
	<aKODByTQMYFs3WVN@google.com>
	<lhujz30qu9f.fsf@oldenburg.str.redhat.com>
	<aKOMlWxic86puw4C@google.com> <87349oxk2n.ffs@tglx>
	<aKPFIQwg5zxSS5oS@google.com>
Date: Tue, 19 Aug 2025 08:18:19 +0200
Message-ID: <lhuqzx7ygus.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Sean Christopherson:

>> If I make that:
>> 
>> +       if (!*libc_rseq_offset_p || !*libc_rseq_size_p) {
>> 
>> then it makes sense and actually works. The pointer can hardly be NULL,
>> even when statically linked, no?
>
> IIUC, it is indeed the pointers that are set to NULL/0, because for unresolved
> symbols, the symbol itself, not its value, is set to '0'.  Which makes sense,
> because if there is no symbol, then it can't have a value.

Right, that's how weak symbol references work.

Thanks,
Florian


