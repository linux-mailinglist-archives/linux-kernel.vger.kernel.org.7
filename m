Return-Path: <linux-kernel+bounces-848249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823B2BCD01D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92103189334E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCFB288527;
	Fri, 10 Oct 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DDluU58A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F31C5F27
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101377; cv=none; b=FiMrm9B9X/JthbMySxe2H+5BWTS3wB0dRDheFAtOpvH6Vwunnjw90c6+zCOnW+HLm5kdg5XjRM3jdyml291azY7WUro0Gf+xEqf0YzRZ+n43ViJjmXvTbQLLIh0vZQTG/9Rn2QGWhlHarYAfj+Y2c8VpYLh5Ne5QDUDKn0Rm2DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101377; c=relaxed/simple;
	bh=FnimfbU2FanRO/TFNV/nIlg6CaWFEdZfo2qAFRmfFTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZMJzYZGiyP8JqzBT0qEKF1f2gaW81ViBQHBTm7/NWv3DvGfPhog1EHTb31pXMDHL3nyFYvrXnrfFuzs5HyAI79j3+nccGTb8LaBT/FhnYuzDb6wvmz7mvKiv+x6i/Y8V/NFbHkBVEmE0YTSHhqzV4+SGlBjtgDHzXdUJ+axI4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DDluU58A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760101375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FnimfbU2FanRO/TFNV/nIlg6CaWFEdZfo2qAFRmfFTw=;
	b=DDluU58AyztwY/tjcYgKVN84m6CqVmRnDKLV2jMjiIjKVkMGX9uz0Si9cs7bXjO0l0NecJ
	7qLWe+i4yDO5De8uZ3UPk+G+t+BIkU2eF1FS/ObIRisu/shLjRdq4w3pF2Q16Q3qlOUT+t
	TcXPpDcSHGJSh+/msCSF6uGC9MIOMks=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-XgNtLAIkNbqhGBmjyXQhNw-1; Fri, 10 Oct 2025 09:02:54 -0400
X-MC-Unique: XgNtLAIkNbqhGBmjyXQhNw-1
X-Mimecast-MFC-AGG-ID: XgNtLAIkNbqhGBmjyXQhNw_1760101373
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8645d397860so958480685a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 06:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760101373; x=1760706173;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnimfbU2FanRO/TFNV/nIlg6CaWFEdZfo2qAFRmfFTw=;
        b=ZIDJvqXwRRHuJ36IrAnpIjlteJRmrQLeaGIwe/jrEBgkI7/I5cGBUFRshA73Am13PT
         /weO6svIm1+G0xCx2cyGto5zQe5K5UHezbiiUWjre9CLarJ67i2UNFAZpae2D4wYz1/s
         S179Xh2fIk4RrrkHvQyPDauplSy3a5HvBNr6njhcavjg9XcmT6AlqNGofSEWalXaxh9y
         96iFqKa3owAejUeElK1WJf1gjamxXdQ6oUMhzl6Y6NO2vjcVQ9yybaAr1qojobrTaXKL
         hOLjwSl58Jlj4uq/07Mwi9qXjHEJ5JBcEROci1qouRVZXNGqsDC5US7cUheimTU3Xh3C
         mycw==
X-Forwarded-Encrypted: i=1; AJvYcCV4+tjYIO6Lqo9PvUO6pEBoNA9XXASWDQVi3E/j+3YbFSRlEwg690GGa2LqPQuW9oY2mMKYYVOBdIszTgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yCM1pXkWcdIMog3ZJq3Du3sdr8B7I/oF2I27kDI7o+ASW6O/
	+mSS0V5iFnlpN2grePF/K7by+YPKEPZvV66jdwOm6ghbQVAYIYeDTS1msDT/ZbtA0R9TpXmiJjR
	UPTrwiAIyQOT3FskOWB9PnpujVSQ3keXa/EZFi2VqxgVorHpcG9wz89VtjlecAsFwUg==
X-Gm-Gg: ASbGncu38+GDQkaIOjmDNjtH0npT4H7XMmAOwSQgCqDv6io6smJaY1MGQf0egwZ6I2X
	9lwne6C/o3uYjGgHCccOl9BAGFTPIKInQBZr0M6z0b0B5e6MrtgVgy+0X20HOExDbr1dL3JckIX
	YzVrm1extPpq+k2QfSBgFfiftfZpznuRxYdEol0CMmk2fohdNh4f+U90BDlsmIOmYQI3mYDXW2t
	IkbhJRTYf+PXKzRX1vWUcynNk+2CU0JmHlVisUw//OhDVPG67oULQNvIjA5dZoqIIutFRm59gxz
	IrEToXylyNq1wNzwmLtfNMHvQPmySAxoLmbsxX6kHTY3y7666ZRbAS4fjwwE9BRogvmr
X-Received: by 2002:a05:620a:3955:b0:800:367d:b9cf with SMTP id af79cd13be357-88352ab0a0amr1681030285a.38.1760101373405;
        Fri, 10 Oct 2025 06:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnBnL7bmfY10viDPL7rL1Bs4KKFHHbDdLEX0MPg+8h0pURGT9gfkD0AmyKBdVqjSuBGaneJA==
X-Received: by 2002:a05:620a:3955:b0:800:367d:b9cf with SMTP id af79cd13be357-88352ab0a0amr1681019385a.38.1760101372490;
        Fri, 10 Oct 2025 06:02:52 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ac935sm402758185a.15.2025.10.10.06.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 06:02:51 -0700 (PDT)
Message-ID: <0f438533d0a0189efb4649dfac3190196330868e.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Date: Fri, 10 Oct 2025 15:02:42 +0200
In-Reply-To: <20251010125823-9bcb33be-96b9-4753-8ae0-11576f0e8d40@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
	 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
	 <20250922162900.eNwI7CS0@linutronix.de>
	 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
	 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
	 <87ikgxqrna.fsf@yellow.woof>
	 <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
	 <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
	 <2536a7777eb54ede40a335fa4204e87301b13040.camel@redhat.com>
	 <20251010125823-9bcb33be-96b9-4753-8ae0-11576f0e8d40@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 13:02 +0200, Thomas Wei=C3=9Fschuh wrote:
> > So if I get it correctly, you are both "voting" for removing reactors i=
n
> > favour
> > of tracepoint-only error reporting.
> > Am I getting this right?
>=20
> No, it is a suggestion for a cleanup/optimization where reactors are not
> directly called from the monitors but instead from a tracepoint which is
> triggered from the monitors. It would decouple the monitor and reactor
> subsystems.

Right, now I understand this better. Interesting idea, we can give it a tho=
ught.

Thanks,
Gabriele


