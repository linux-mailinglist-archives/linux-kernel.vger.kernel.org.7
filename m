Return-Path: <linux-kernel+bounces-646181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5BAB5907
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12B2189A4E8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58C101EE;
	Tue, 13 May 2025 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DylD+XfW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB22BE117
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 15:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151226; cv=none; b=e6/3/Yv/zs4SWgbRPieh5vqCn0pg4QTMXXHb4WJceG0psG3C643+u53VVAFxz4IeJpYW8aAWaP9m08DAGkUesA3wmh+iqQaGddS7N1eYacZqPpLek1VcMiVqq8R8xdLHQJutKWK0hpaFQzCm45O3/aiVh+53Z4ZxI86cQSGI5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151226; c=relaxed/simple;
	bh=aKfYPwMjbQ2ut0CHCdSZS9rO32RR/ysjSXNgz6gdx7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAK6EEQlKlmg58sh+fmY9zMmUvFyyvOfqUZ0vLZp66S0EitHARL4Hx80dqJEy6wz7pWRc0EyrCOqrWhNy3DI3BKWqCJlKHBONPtCTAklI+qqsW3Wc2ZwM9i4IxpFS5NNCwjp3ZUTt96PnZcS+qjY8hpHnyS0gR3dV2Dliwkm70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DylD+XfW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747151223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EoFODGgtQlH8iAxw0nt4puzOn0SEDaT4eXMVX63NuE=;
	b=DylD+XfWtWDcRav7WV5ywh1UZHv1E+8R5ec7Ad6A+dKDhcVkXFTkaaJ1iSUjjB7FwCBkTJ
	ZRLtv2rAGQVLF0YQOnTA0Jp/oKngjCsTi8G34s5cGtJdHo9du2uVV/vi2phOhd3x0THNkH
	zFWXUCyumLzwyycKLl1LI5A63hyoyjA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-VmiCkp95Ph2-AEtOA9W4dg-1; Tue,
 13 May 2025 11:46:58 -0400
X-MC-Unique: VmiCkp95Ph2-AEtOA9W4dg-1
X-Mimecast-MFC-AGG-ID: VmiCkp95Ph2-AEtOA9W4dg_1747151217
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C3E771800360;
	Tue, 13 May 2025 15:46:56 +0000 (UTC)
Received: from fedora (unknown [10.45.224.118])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CF0411944A82;
	Tue, 13 May 2025 15:46:53 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 13 May 2025 17:46:56 +0200 (CEST)
Date: Tue, 13 May 2025 17:46:52 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH mm-stable] uprobes: Revert ref_ctr_offset in
 uprobe_unregister error path
Message-ID: <aCNpbPuY6FI1Aiyx@redhat.com>
References: <20250513122125.1617722-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513122125.1617722-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 05/13, Jiri Olsa wrote:
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -581,8 +581,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
>  
>  out:
>  	/* Revert back reference counter if instruction update failed. */
> -	if (ret < 0 && is_register && ref_ctr_updated)
> -		update_ref_ctr(uprobe, mm, -1);
> +	if (ret < 0 && ref_ctr_updated)
> +		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);

Acked-by: Oleg Nesterov <oleg@redhat.com>

And just in case, I agree this has nothing to do with the recent changes from David.

Oleg.


