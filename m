Return-Path: <linux-kernel+bounces-861470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E14B2BF2CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 007C24E4944
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C97932F764;
	Mon, 20 Oct 2025 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ds+9mSHs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FAD17A2F0
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982720; cv=none; b=IK2EsBq/DH/HBoBOtpmiqjBZGWavMUe9Pjpzs/0PPDbz1pYGdw21zSVLNC3sBLnuoQ68Wxprbws1itjf2kabdftJIU31cznmgbgsT7UIbmFWJqo4fJ7DhHLEq3mdlf0nkI1XtLmi5QgzyksOzHusxYxdgAXsuWMrCl2+jKkAGsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982720; c=relaxed/simple;
	bh=mQ9GH5HDrPFv43DOp9fAbcLQHpsfgaEiT26jgLDQ2EI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGK2haDbZrKYWkIV8igyD1xGPhTsngtDV3Ga3eiuT0yM0Yh9FRRZDD/DmrpqbbQqMPZDIatg4TG7JUw1WXfzfvhHuSTQknJ51FRJ1ffGak3983KlxP//mtfwHIbfLGjCTWMbVhaSKofkesc6Xd2JF9XY17f5EcdT9KC96ZqhCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ds+9mSHs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760982717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zixpkQdeW53Ziw6ehz+7cd8zL/NbyToKZVA/ovjsiQ4=;
	b=ds+9mSHsceMiwVOSPiVEk2n5WPlIKn1uttxpvo0cIiA740vVVoCTc6R4gh6B/s3tXmhOTD
	4VhYUQie2otaVFZx91sGKCeXIJVdQJSDhrlQGTj1DIuQ2wWUhSauh2XzPj+pRvws51eiaR
	a7K4W0941lkW8NgVYuRIzf2ryS9yG0k=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-tyKXUVFDOJyf7bByfy8q1Q-1; Mon, 20 Oct 2025 13:51:56 -0400
X-MC-Unique: tyKXUVFDOJyf7bByfy8q1Q-1
X-Mimecast-MFC-AGG-ID: tyKXUVFDOJyf7bByfy8q1Q_1760982716
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-886e347d2afso506860839f.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760982716; x=1761587516;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zixpkQdeW53Ziw6ehz+7cd8zL/NbyToKZVA/ovjsiQ4=;
        b=Cxo0ntVX1Z+0uJALXWVSP0KnB4kE0qaJellqAuiUVXTXrybr65PbDnesCTWeDIgTVW
         tsFWY7y7ZxUfhMiPalalTKUvkY6Quo6sWMzrBMo9VuBnisj7mmVqcbuRbha1aNXr+I45
         U1RRdYAmqQU9M3N5epGJmVaoF0LZ//qS6Rlxeiizwi/08r2cb9xL/ldAn1I+BvOiPTGZ
         usRih0uM0zLFsgeM4fyj72y1493DTvfcaUldOb1vI/FKW5Cy6Ik9gFvaA9qUQ3ih7NaJ
         L5Lh+pyAyruvXNEzP9FGOGqrDKfDtvT04ZkAqR+PkYqAcVISQsgGgIPm8eaTBAEk0yyG
         g+tg==
X-Gm-Message-State: AOJu0YzhNHx/RESIMmp8OfyKyUCp0qdFDqrQgIExm1N8/PPgp12eQVuc
	XeComhL6lU8cwUMWenebBXeyQtqMK5aUoOpuT4ig2lMtkdwqx8smbOc1eL0FJ99phxlLTIeK4Z4
	LsITG6eAnq/k+5zlvt7nVkFuK53ZO+V4htxkE0IOY2BwqCkMEQddYhyUDvjVhxSLl0g==
X-Gm-Gg: ASbGncupL47iMevTTTjM0jDPy7T7/yMSWj+AgtJpBk1zC1KABbAaKIg1sYK4yEmR/DP
	X2n7fSqnMNdfbIRfqLJmaWqX+0OROtdqeG6Lbfr0HoCigOYYajJv12l5BZBZDWFLNJZHS/F4qtb
	X2mzi4OyKFdyq9OnFEdfAXzzViCDBXy3O3/2jfHzDgPb37Ta17KaZisExe7wQ8RKX89LlSVTs0o
	vZkNWZW3UeOkK+u2VL1cnyLgZyd3gFPIcBtdQZSDcSu9njJnfUUFBmrwaCcVBeS9VQObQGiRB/f
	103DuwBaYIgqVIj7SY96wsavqSW0Is0mj2472RlYAoOF+99GsB5ZLh4+3z1URMA9wkNcJzxPOKO
	ELDfIgvwQlH4RP2yoL6JJ/KdB6Err
X-Received: by 2002:a05:6602:27d3:b0:927:bb0b:3ac5 with SMTP id ca18e2360f4ac-93e7644a567mr138665939f.15.1760982715696;
        Mon, 20 Oct 2025 10:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyz5HfZXSCeXqA0kQoKsN3dOXG9qM7Md3dBC/sJ07LakDX8QnQ+9aJIfFVeYPOL3djFS/IsA==
X-Received: by 2002:a05:6602:27d3:b0:927:bb0b:3ac5 with SMTP id ca18e2360f4ac-93e7644a567mr138663039f.15.1760982715271;
        Mon, 20 Oct 2025 10:51:55 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e866cb276sm316709139f.11.2025.10.20.10.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:51:54 -0700 (PDT)
Message-ID: <4bd0779b41a1e635d6bca738ba2d15ea708a03f9.camel@redhat.com>
Subject: Re: [PATCH 2/4] rtla/timerlat: Add --bpf-action option
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Mon, 20 Oct 2025 12:51:53 -0500
In-Reply-To: <20251017144650.663238-3-tglozar@redhat.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-3-tglozar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 16:46 +0200, Tomas Glozar wrote:

> diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/s=
rc/timerlat_bpf.c
> index 1d619e502c65..3c63bf7aa607 100644
> --- a/tools/tracing/rtla/src/timerlat_bpf.c
> +++ b/tools/tracing/rtla/src/timerlat_bpf.c
> @@ -7,6 +7,10 @@
> =20
>  static struct timerlat_bpf *bpf;
> =20
> +/* BPF object and program for action program */
> +static struct bpf_object *obj;
> +static struct bpf_program *prog;
> +
>  /*
>   * timerlat_bpf_init - load and initialize BPF program to collect timerl=
at data
>   */
> @@ -56,6 +60,10 @@ int timerlat_bpf_init(struct timerlat_params *params)
>  		return err;
>  	}
> =20
> +	/* Set BPF action program to NULL */
> +	prog =3D NULL;
> +	obj =3D NULL;

They should already be NULL...

-Crystal


