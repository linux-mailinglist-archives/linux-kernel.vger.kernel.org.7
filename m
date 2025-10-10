Return-Path: <linux-kernel+bounces-847859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3782BCBE66
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A43F84F0493
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C29271464;
	Fri, 10 Oct 2025 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiMhiydg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F6C271448
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760080895; cv=none; b=M3oumzXeRC68QEOF1sddFla75obz4IlZOE/poCx36yc3S24ZwSyN+LkHiwBvXrxbCcazyltJiwoSLgF6L7OnIQub0GGIc2C2aDRczfWG/B66s6K1Xoqy58T1AUD9Z8pb0feFvA5EHcuvUz42l0aajucBHPKDZWcjdQjT4jvL3ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760080895; c=relaxed/simple;
	bh=WoN0dpJjGxiZ0wQf4DNv5iwB6nIANTg2G+mNbipfa0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0ZGrhWOryDMKbwvXDlwoD4n/j8XPBpQFxFqNPOG+wnKzMMyCtEnjUhG04WrotCVF5eVjxYaw8AJ2SDIIuj8CZlYgizBEmQMuxBu9mHCy+iWAUY1JQBO3LmC0WaZKRh5NK3hVOC9sYC/0FRUlumJXtxIeJDhJoAb7j4wN2tnnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiMhiydg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760080892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WoN0dpJjGxiZ0wQf4DNv5iwB6nIANTg2G+mNbipfa0o=;
	b=HiMhiydgfwF8QBmM1UFbqY5uVFwzUjNy3rWg4zmywMdaxlnMUu0Ck3dhINSaPKq2fNO+H/
	u8T7FPiehmi4tDzZ8oF/HZ5ZPCbAk8GZdRG6PtIdnCMIlNvUTXOLzuUfDtMj6ZI3SViL73
	2bHJqbptRcGgGaAs7cTKmQxuvbZAWdU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-bKtLugnVPeaO0BPGnEQIFw-1; Fri, 10 Oct 2025 03:21:31 -0400
X-MC-Unique: bKtLugnVPeaO0BPGnEQIFw-1
X-Mimecast-MFC-AGG-ID: bKtLugnVPeaO0BPGnEQIFw_1760080890
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b4c2f26ab55so172697166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760080890; x=1760685690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoN0dpJjGxiZ0wQf4DNv5iwB6nIANTg2G+mNbipfa0o=;
        b=IV2/b/rHrogwMVp/ps8nDGfC5lhdJ1IOvw+4j6Ev2WDoKRfeVc7MY1hOB3nkNG+tuA
         fq62Oubb6+1c58kbeycvzpA0WlsrBsezh5Ikg6GwEwqlBwHgLKgAiABht0aizq2frWFI
         nSag7EVtytbv244IZw8m5NfqjoCCzqgAc4x1Az4c5XYcqCnwZc26MYhdbyIsV3Ebd5Zc
         pnNRc42gwk9PUQMWLcqRHMCpuoPbQEDgJu6akQW70VcAlyZ1buZVV5czxzHs+5cFtHBx
         v9uDkRfciwQ6YpZ/NJ4RaN1WmcZjKCc+uyCeJOk3FPlWgB4FzOep1hm+k0pc5yLnd1bP
         7Uaw==
X-Forwarded-Encrypted: i=1; AJvYcCVmU2Q4AUvM/mywhpju8zstmXpGhlgrY07GpxiuNng3JlkvSVi6UJ2MROAoU8VsBrUjPXpBei9b6hS2SzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr6jfIZjqOu3iDxrd/k3zBQwuRdB+Sxy5IMJk2bcHxSN/lhENi
	lQnQHcvZYwcIJ07lTWVSxrzuVaQlM2GfPNHZ49xt7NJF8u1fZHgr48QWXXPEuRwit+eNclfN00F
	EHgkIhiH3zsedumfX75wsSIXLrqEM5u6qgzQYdqcBaDPz1rPQbzPRYDYsRKcW72Lig1AL4w5vd8
	KR0PoxUezVR3XfTUPjHg+2ziZQJrCOd7ekCMWpdz0s
X-Gm-Gg: ASbGncujjtI9yNIGDLb+7B8v9WuDjPtBhEp3HGusGtxnrNjsIBJbmxgFT9TbpZIlpzt
	N/I3wEGFlOIuSMy7VL0ISQ+JmnMXn2jCP6+znsOZ12xmKEFvg58KI3NrR1ThVOoO0ZRA46JULyc
	Tyo3fcRncUDHvgcHLt8MWBuUz0jzM9BJQZIQqby4SROIQf2iIJm7d0Brg=
X-Received: by 2002:a17:907:d0d:b0:b46:6718:3f29 with SMTP id a640c23a62f3a-b50a9d6facemr1103279866b.3.1760080889814;
        Fri, 10 Oct 2025 00:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtxGrbv0D1tCUVxtHfdMD5J4fwcx28uznIcAJssW+Z5+SL/t71bkFpdvjGgLGlUSDvq+NWmofNFYne2QiySXY=
X-Received: by 2002:a17:907:d0d:b0:b46:6718:3f29 with SMTP id
 a640c23a62f3a-b50a9d6facemr1103277466b.3.1760080889404; Fri, 10 Oct 2025
 00:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008195905.333514-1-costa.shul@redhat.com>
 <20251008195905.333514-2-costa.shul@redhat.com> <34afd8ffbb1c889e91fa536cf60369a697d86575.camel@redhat.com>
In-Reply-To: <34afd8ffbb1c889e91fa536cf60369a697d86575.camel@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Fri, 10 Oct 2025 10:20:53 +0300
X-Gm-Features: AS18NWDd9gdjeL-7ac1kmmdkaQjxIh8CkWqVuO7GoExI0sLzGguXDNu6X50mDgE
Message-ID: <CADDUTFwFerzjRTPp1F+Rw+_U2DoomAxyDonXudCwh9gyXSn=nw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] tools/rtla: Add fatal() and replace error handling pattern
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Jan Stancek <jstancek@redhat.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Oct 2025 at 00:55, Crystal Wood <crwood@redhat.com> wrote:
> Looks like there was existing inconsistency with newlines... maybe have
> fatal() include the newline automatically to simplify callers slightly?
> We're not going to print a continuation if we're exiting.
>
> Otherwise, for the whole series:
> Reviewed-by: Crystal Wood <crwood@redhat.com>

fatal() belongs to the same family as debug_msg() and err_msg().
Historically, the prototype and usage of these functions is identical
to printf().
printk() was identical as well, but now it adds a missing end-of-line
automatically.
fatal(), along with debug_msg() and err_msg(),
can be upgraded too, but they should be updated together for consistency.

Thanks
Costa


