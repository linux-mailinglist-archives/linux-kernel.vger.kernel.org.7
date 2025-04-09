Return-Path: <linux-kernel+bounces-596602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDADA82E18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 19:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD38C175A3A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Apr 2025 17:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023B27700C;
	Wed,  9 Apr 2025 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMncm1TX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281526FD9F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Apr 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744221550; cv=none; b=PiPOcqLMsBYKYGFVF+ZQe5iMb1JcIUn2QRahmq0ykZAS8bd5////ohO70e9KK0GzPN+Rf0WrAb7wyG75T20N012/frlfBpoiW0SxoDpbefTY/sw1SzRp1abNl+QhhwA5DEYbBuo3fCgKKrVuBoaQoEr5gemRSi+uZixPkDByV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744221550; c=relaxed/simple;
	bh=2IVHJf7ar/rNWEmTTIZ8rQp5BCVRHkVPJ+ZwK/9yBjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBuQ8CliqEoCTT7ni8b/si8XD+Nl/suRR0A1tXey8ELM2Ed7IQ3EPEFL27dFyb1Rn15RLrpyl/ReZk6XmCBuplBc4KbG4fl9QL2kgKCDzcHN+yhBPvI95oyAC32GZST1jMhDxDp8sW9E9f30Xf5IY7yaPDUlfqvTWhGCYn/3ems=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMncm1TX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744221546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1KffZz9Dem6U0r6zjOlio/dUN4rNSBX5e2RmuPvDORI=;
	b=TMncm1TXTvc/6VaQ7F32Atb1N3hJz3amxlt9cix+P71gB9f4zzQ4x802Cmlo/Uauq77g+s
	yUKxxmgt+/fGN7xcgyd8dnSrPXvGRIb7qRjckxoFFWRWUaSyd6YOLcgGWo8HcUM27dpYQ/
	Z2AS6a4XXMMBOG9HnPoMGYLS4MzME+M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-LdkqEh4uOg2XhSJJaFnvvg-1; Wed,
 09 Apr 2025 13:59:02 -0400
X-MC-Unique: LdkqEh4uOg2XhSJJaFnvvg-1
X-Mimecast-MFC-AGG-ID: LdkqEh4uOg2XhSJJaFnvvg_1744221540
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C07F195608B;
	Wed,  9 Apr 2025 17:59:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.44.34.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 307211955DCE;
	Wed,  9 Apr 2025 17:58:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  9 Apr 2025 19:58:24 +0200 (CEST)
Date: Wed, 9 Apr 2025 19:58:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH 1/2] uprobes/x86: Add support to emulate nop5 instruction
Message-ID: <20250409175818.GE32748@redhat.com>
References: <20250408211310.51491-1-jolsa@kernel.org>
 <20250409112839.GA32748@redhat.com>
 <Z_ZjIerx-QvY7BSI@krava>
 <20250409131115.GD32748@redhat.com>
 <Z_aiWdks8SA3mtX6@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_aiWdks8SA3mtX6@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 04/09, Jiri Olsa wrote:
>
> > Just it looks a bit strange to me. Even if we do not have a use-case
> > for other nops, why we can't emulate them all just for consistency?
>
> we can, I went with nop5 just for simplicity, if you think
> having all nops support is better, let's do that

Well... Let me repeat, I am not really arguing and I do not want to delay
your next changes. We can always cleanup this code later. Please see below.

> I checked and compact process executes 64bit nops just fine,
> so we should be ok there

OK. Then, for your original patch:

Acked-by: Oleg Nesterov <oleg@redhat.com>

I'd only ask to define is_nop5_insn/emulate_nop5_insn regardless of
CONFIG_X86_64.  I understand that we have no reason to emulate nop5
on the 32-bit kernel, but at the same time I don't see any reason to
complicate this code to explicitly "nack" nop5 in this case.

As for the new version below:

> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -840,12 +840,16 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
>  	insn_byte_t p;
>  	int i;
>
> +	/* x86_nops[i]; same as jmp with .offs = 0 */
> +	for (i = 1; i <= ASM_NOP_MAX; ++i) {
> +		if (!memcmp(insn->kaddr, x86_nops[i], i))
> +			goto setup;
> +	}

Well, yes, I'd personally obviously prefer this version ;) Just because
it looks a bit more clear/consistent to me. But this is subjective.

And,

> -	case 0x90:	/* prefix* + nop; same as jmp with .offs = 0 */
> -		goto setup;

No, this is wrong. Please see my reply to myself,
https://lore.kernel.org/all/20250409114950.GB32748@redhat.com/

This way we can no longer emulate, say, "rep; nop". Exactly because
either way memcmp(x86_nops[i]) checks the whole instruction.

Probably we don't really care, but still this patch shouldn't add any
"regression".

So, let me repeat. Up to you. Whatever you prefer. I just tried to
understand your patch.

You have my ACK in any case.

Oleg.


