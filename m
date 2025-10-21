Return-Path: <linux-kernel+bounces-862158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A86BF48E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE5AD4E5E04
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D1422A817;
	Tue, 21 Oct 2025 03:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3rfyRuU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68EBD515
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761019040; cv=none; b=CCc7h6K//m5L/PWF0Vcn9XtLdMzsrItHdajms8EaTrgQ3Jl1+jnXZeSjP62oC3jPF7ts4RcG68YP6U6/dgCpXEaAQMJm3GXPiva72MA70QEJlH5GLM4UhDNY6OMrKMlGgg7vaMpEkMASzZPH4Z/S1IB13C4wRxrmlvrds8Ard1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761019040; c=relaxed/simple;
	bh=avAnboTjW6tMpgAJHhMAVvcyuciRZrXEfhoaUrC+C7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwxRIjS8jms9tXicKZgfzhomZ9ztA+09Y6ipxEQAh9CP9yULKt0R4OFqE9LWSyimrqMHLTDs0ie4Sz8oisOW5KeuuvdUB5noeX/Asrz/9vwcXWag1i8TLxQtaPwfpqWYYQ7RSEUYuoKGInwauU1CDxqtAXDRLlogMrXy3HhPXcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3rfyRuU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761019037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avAnboTjW6tMpgAJHhMAVvcyuciRZrXEfhoaUrC+C7g=;
	b=H3rfyRuUUslppo0td/r0zKcgf8dJ6DZFUw7STobdMcegUgcF2ZPWleM4pAM6tMwnXtz1An
	5y6GqYb/bm4S+P/TUEN1i1G6M+keaorkdv/99AgdglHQbuFQljYUYFDBwt3BtfpQxB756V
	n3Csajlhk4jbyouG1bpD07U56DqJvMc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-Zt2rw2EVOFCqXDTZ4SFFGQ-1; Mon, 20 Oct 2025 23:57:16 -0400
X-MC-Unique: Zt2rw2EVOFCqXDTZ4SFFGQ-1
X-Mimecast-MFC-AGG-ID: Zt2rw2EVOFCqXDTZ4SFFGQ_1761019035
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so9361117a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:57:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761019035; x=1761623835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avAnboTjW6tMpgAJHhMAVvcyuciRZrXEfhoaUrC+C7g=;
        b=vxG0rgztkG36o5pCvHzsIc68gBipzExJCCkkSLdy4eIbTCDSvVZO3x+uVL99tVyKmp
         +6gDVg1PllHyhE1L8qrjI0OUID123G6JsXgyVRHb03Zk5oHYYd+povz0xzNnIbUeWd9d
         MzD+OZFcPLKC7v7/lKDQJVFpyOJHNszFPiDPqZtJv7ADAS1rA5w818V775FYVMYNoS1y
         +QARNpLz9NX2wkMhRWUIfBQYBJXeh54YjgOowpmnZTbQPjLIv0k5oCFLiFhC3IMerrmL
         O3Na8vNXjKnZhBG4JAx4vYo2UbQUzbKM19w7yiIufciUoQdyG2JQA/tVR1Uzor6M3TwF
         /WWg==
X-Forwarded-Encrypted: i=1; AJvYcCXgOCAuUPUsUQbIab9ACqMaVQjgjmgMkE92f/KEYPozMbGGTLpELkjWZzwl9G0zXSp4PD83JuzHpk9936o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxAanQEd+lcM3CfQuBH+Nl2iZMvCSKpHjC3TZDxBkqsz3ksSq
	9+w6Fp+LCcvbN6+rHyNOYPTD1Uc20r/zh9n2ZyhFcynXVq9WR0igteAFmdjx8MwcIOhjhnIBiGJ
	pM8JpwEVI+nouzxYe6KF+GdciqsPBeAXJmMmvMraqQqb8ht27ytX2GM7KJaN3Sl/b8uBhRwKIqW
	Q7ABHpvfyGyDhPE1e078IINWsKj0ysMPr/9kVGFcMf
X-Gm-Gg: ASbGncthzBH3txxgbhegm4CJTh32+z/u3+ZeH50B3iK5AW4C7OJDXfWo+2rvfc9CLFk
	E3RSHJJmIRdl1h3M86hJQaC/w9jPbIKxzTxOujjwWWxsnIFhUcxgOPstORR/9F05cz+Z+o+u/Vt
	1Wg5JWdFhyOi8dOnr9bkr30GHwEhZQm6FlR0gdb1UWowh02WjGJz4toK3L
X-Received: by 2002:a17:90b:38c7:b0:338:3cea:608e with SMTP id 98e67ed59e1d1-33bcf9080f6mr17871944a91.31.1761019035291;
        Mon, 20 Oct 2025 20:57:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2AQ5ooNC2Kw7cDDlHQHODRbiZf6YTTMcGqTJDIYsLuIjekqTxqXC2ulUIAMgLEFP40yd7yWnPZVSHbOEH18k=
X-Received: by 2002:a17:90b:38c7:b0:338:3cea:608e with SMTP id
 98e67ed59e1d1-33bcf9080f6mr17871928a91.31.1761019034912; Mon, 20 Oct 2025
 20:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925103708.44589-1-jasowang@redhat.com> <20250925103708.44589-16-jasowang@redhat.com>
 <20251020190537-mutt-send-email-mst@kernel.org>
In-Reply-To: <20251020190537-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Oct 2025 11:57:03 +0800
X-Gm-Features: AS18NWBjFmb6ytc1dmje5mqVvtGdnhFl8MQMgGfdH1ywtzn-hKtlF48bMq1pbd8
Message-ID: <CACGkMEuLgO55NbLVFC_RiwEqX+RATrf90UOMQ=+8npPuvusYUQ@mail.gmail.com>
Subject: Re: [PATCH V7 15/19] virtio_ring: factor out core logic of buffer detaching
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 7:06=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Sep 25, 2025 at 06:37:04PM +0800, Jason Wang wrote:
> > Factor out core logic of buffer detaching and leave the id population
>
>
> "id population" here really means "free list management".
>
>
> > to the caller so in order can just call the core logic.
>
>
> in order -> in_order
>

All fixed.

Thanks


