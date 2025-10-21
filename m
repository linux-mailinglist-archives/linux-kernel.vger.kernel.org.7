Return-Path: <linux-kernel+bounces-863181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87260BF7315
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3841619C276D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19B8340D8A;
	Tue, 21 Oct 2025 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXOVtVLk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083F340A7E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058515; cv=none; b=AKtrrtLQm9Nod/M4ORIbF91ukv8HGIA9mm7vS/pcOiAbmX9WPqGq2NsNNgTZVn6eY/teGiZeodVp29nCtbS20H9bzwclauZ1ZYf9Lk0CIrOZ43GnFG0ybd4/bSsX6dSNH8HfvrCie2yVQA6aB6FRAuNEYyudBsIpGX1faSG20Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058515; c=relaxed/simple;
	bh=s4TtaTJObWg6v2NnNlDOilsD8aDDDmFj9Vyxed3bMVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djFe/Y7Wm3PgdcqI3YwqYPpsJpC59ODuQyGbmZiU+EyiMey9l2AOqyzUWUIZWx+7TH7SbZmPcu/Q2VE1xQn5WZ2FNeCwxmVqS5P4Iou16Pl0QO2sotegYyR2srNdTt7EpkjvSmi3pOqEPUXA24/wb/pUCUFLjzGMl/cPz5xXYWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXOVtVLk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761058512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4TtaTJObWg6v2NnNlDOilsD8aDDDmFj9Vyxed3bMVg=;
	b=LXOVtVLkpn/+tHXQeAxEFrwiF9Gk5NXLtvVHLAfdrOLKp5cE5kUScRM+LF8nEkn2gvQ5YX
	6YYSrkNA/AdOq5OfznNe2S7cuHSxLRvwa0ANuaICEleW7veo/UIqCGmqWH3fEh3n+pKe5v
	0EIfjS/4/efcHok+XPGEPtbelV0JQaw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-2wA4mpn3Ms6K33ObBWeTaA-1; Tue, 21 Oct 2025 10:55:10 -0400
X-MC-Unique: 2wA4mpn3Ms6K33ObBWeTaA-1
X-Mimecast-MFC-AGG-ID: 2wA4mpn3Ms6K33ObBWeTaA_1761058509
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b3c72638b5dso769633666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058509; x=1761663309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4TtaTJObWg6v2NnNlDOilsD8aDDDmFj9Vyxed3bMVg=;
        b=gE7f8XEaS6Ek33oSRYkGbU6i1E0am6LNQuqa9VFG9/m+zReRdelzfPT1R5qGtUVaGY
         AiCxnCuJd36kdsZzQVf0wnyufRdixDC4RXQF+GjlUrLs0Dnf5B0b01MYWVntD9R55K4D
         IIbxrDg70g6AXdQJW0szLsUsBOC9Ba/OrT+4g1fq6/+wqX4x28h8/U3OswpX76oGl8/4
         nmvIZb3AC6EF4rqBqmIhnof5m6mCKddbVTKuEkYl+PVrYiICVjZLFJwffE1ovZMmmccv
         KazfBk/TpwKMpV8i428ezkTL8Yp3PdiTZXA4dwsIgIDz1AqUmS2WhCZjGBQg9WbR+zCf
         az3w==
X-Forwarded-Encrypted: i=1; AJvYcCVL/opWEpAftavmPlM91g8ooa86OH3lGViCygdgH+g/hLNHgg0/NScbXHTTB9wyFYolgvj0mp0TNhE3zos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdzD9SMeZsldmrghhrgZc4/DLYOt7NWNhWIvsXyzn364YBeyvE
	PWqtjL1Ed6cgBXpLe7s3MtGYIQBSzV1tXA7qZwUDhZFXFxNaavAj2H2MnuQNhcIRhz7v/9kuvD6
	AFWcxinczWlwOiIu6RQYwQaElcPfEcmOSFrRx+oxQn+cz/PcUYLZUnNaW1PZyYiMYQVeNDoSyY2
	HE1m7HqPm7j+DhKSBV4qYerSTXT74mimGPeAsaSL8y
X-Gm-Gg: ASbGncv9OY+l5oa8lVxptAkMpp8o0EV5a5EFgThLx8W7ysteUYDHATP9BjMyV2ILRRs
	98NZYTeAu9Jplk7QqVKP5bHxNgZ+hChsmrvAfBeFQiZ8F63XuYwdT1VHw1Xvo7y1zNEoaQUFVUf
	tQIiV01MT5IYV8guG6zREJAH5cJtZkZmCCn38qT30f+BcL0KoDNcgOGQ==
X-Received: by 2002:a17:906:c145:b0:b57:78fa:db48 with SMTP id a640c23a62f3a-b6474f185a3mr2004348666b.51.1761058509058;
        Tue, 21 Oct 2025 07:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEneTZGyCeocsHDx/X60tO2qfCq18ai/V5BM3x9iJuhQM7iS2gxGsIzRT59aOph6KtUQDfrMxvnJbr+Tvd9Qds=
X-Received: by 2002:a17:906:c145:b0:b57:78fa:db48 with SMTP id
 a640c23a62f3a-b6474f185a3mr2004345366b.51.1761058508702; Tue, 21 Oct 2025
 07:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017144650.663238-1-tglozar@redhat.com> <20251017144650.663238-4-tglozar@redhat.com>
 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
In-Reply-To: <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 21 Oct 2025 16:54:57 +0200
X-Gm-Features: AS18NWAt4omziUwJi5neVONqyuvXqoNnsk6zlx8UZex_lIgKReoEJhYe9U30Le4
Message-ID: <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 20. 10. 2025 v 19:53 odes=C3=ADlatel Crystal Wood <crwood@redhat.com> na=
psal:
>
> We should have the makefile build this, and add a test that uses it.
>

I agree. I tried to use the example, but it would be also good to
check if the BPF program was actually executed.

That is hard to do reliably for the current example, as it writes into
the global tracefs instance, which might conflict with another user of
the same instance. I will write another BPF program that will create a
map instead, and a script that will check the map value via
--on-threshold in the test.

Tomas


