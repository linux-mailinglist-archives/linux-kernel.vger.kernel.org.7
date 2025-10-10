Return-Path: <linux-kernel+bounces-847862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9F9BCBE7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 09:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A16EF4E290C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2822727E6;
	Fri, 10 Oct 2025 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOSW/o8S"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D1024466D
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 07:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760081085; cv=none; b=jynpR9XacShix0cFMPUMncQf81zgc8TXVdrYpY00YqFTlrS0BGwyqUX6zHlBNUoPV6Wz4EZuhiP8D6F6+1CT0CEbbkqXMrkvdTTVXSy403VBiK6rbgiv7EwjVGqpUcAa+08CTLOXCz6bof4lmxhXhEAVjSkCwaw4+nUG3mArvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760081085; c=relaxed/simple;
	bh=ytu0sh6Vnk/ajf2WY1W0doPoS5rmLBL0Qv13X0hEGVk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wsi0rS9mSfn5mPHKn6bwxKTabIIDsd2nBcN8bvSHi9WSBlq3t5GvGR3VZMMOpk3FAd2LG7T2nc5M6W/YsXQwx0LOHPyesSPDbOQm08BcijvzVqpr+/dleN4z5pkrxhSmQCF2L0afN9LkfPigk5mU5blA8d9wLO2LlWoL4d74SXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOSW/o8S; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33255011eafso1917406a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760081084; x=1760685884; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ft8+GHyPaWE5QNecvMBDFx7PoSv3gOXNdAI64yMkvI4=;
        b=HOSW/o8SdW5rOQ0RM8qufMs8XZ8r8reX8oVei0o+4w+Tdui1qzIL/F6K73CYTR0LHG
         F1qnJboJM0XvatdYn8ZCOLjAZaXVF8SF5TT/G+2Hrvjs/ZpUuMMHv8LI5xr7vHJlaANP
         SJHPX9zVHCPsCwdJwALEHtlb02mbEUKkbxIpNX46pLKcTaoUOmC389pwpgATH+nBh9hU
         w/viM/b10xn5LmNcVuzIcjIE4rCw3+XHNchGzOxbRjsX5j9uArxBIZZTNGCCS2boPQzW
         EcMm5dBRm44RW+YIeJqYGhpsPZRkpieC8no2Dm08DM/fXK6rol0tZjxaWG1XkvTCdd5O
         TrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760081084; x=1760685884;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ft8+GHyPaWE5QNecvMBDFx7PoSv3gOXNdAI64yMkvI4=;
        b=C9pH09ItCeDioShX561kPMrG2eh0LZq1UuXvk+LqXRu6qOwWI7VXvhQPFihkf1yBM7
         AJqCdhERvw26EW0l0svfZrs1OzLS3aZ5r7dNcli4SRRT7/Naxj1q337IBjfv1+VjCqCI
         FaXh1c50Vn5yUuX6kvdV3eJYQDAnxUY3dFf68gn1MAwY3wtMMFP4PhUVP/dm1Gy4T5vY
         p+oXW/5OEdvbZbHEJ10rxEQFLx/FFeGzjy1A0WW0plQrVbIyDY4jf2q+Te8WeCqkXiur
         XBvk9B8VwpYCQGjGGEe9H2j87Z2zDFqzKm9ZCei8gZyYp88FefDo5wKuh4YSAYslgaOn
         mGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5elebN7hTu9ggCcVOco30xOAZLXiQ6iG+OxnSeUwO05uuCU74DCsjQw5bdj4o9mYcK2tPXEC5kvvcJBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuYRMI13pIx1tBQo9+FoBnfEzkg94z8XTyotHSdK6OsdTUk/F7
	HThF2gyYr5SoUErImUXRkREXgY5I6Mn3UCz//H6UzWOMy1wozFD9NPDg
X-Gm-Gg: ASbGncupYazLeNM2TGR1RY2GSjkpFMSEAjMOGItvi9ekg54gao5JyLwiacnyYrZrUwL
	A/S9EYNK02mZd7QwqpsUzXprGqThFqJJD98NPOVTBCxj38Ae2Cjj0Xi+EGk7A2+Fktf8ubVE7Oa
	XLNRo0EYXFnUohjPhMYqpBtbCjQRdJMdJVgBZsxinKPdDlheBK4y/dbpqZHLXo0WCzuVxD7Bmr7
	gqMUNOGGrMU+32ZBhM8mj8ZOAS0H8Cyz4MXL4RS1iMzHC6AfW22keVP99knZEdCSqn6LYEjdFe7
	tC+B8Q+VY45cczBDxYj33icyabTC8MMis0r51dHBPUAgIfEnflzSSIxC16sq41NQKv1GfQKiAZN
	ae5Z9LoGoqt11p0xkf3h3kc8Aygl+fk85ZIaOcRYkq6uNe2XTEsZXP5lq
X-Google-Smtp-Source: AGHT+IFA9+vMUY6ByW+p1IF2nfK0SeJw3kFZAH0hcme8c+WfP183AXo+6f19C2sWzvxtw6EiZAMrPQ==
X-Received: by 2002:a17:90b:3e8d:b0:32c:38b0:593e with SMTP id 98e67ed59e1d1-33b5114d3d4mr13407741a91.5.1760081083631;
        Fri, 10 Oct 2025 00:24:43 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddcc604sm1540479a12.11.2025.10.10.00.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 00:24:43 -0700 (PDT)
Message-ID: <49f098d8cdaecaf05e4e751a71bebaefd62f6fdc.camel@gmail.com>
Subject: Re: [PATCH v2] nvme/tcp: handle tls partially sent records in
 write_space()
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Date: Fri, 10 Oct 2025 17:24:38 +1000
In-Reply-To: <33dd4088-2a48-4dbd-a374-e2204aff3941@suse.de>
References: <20251010042514.704249-2-wilfred.opensource@gmail.com>
	 <33dd4088-2a48-4dbd-a374-e2204aff3941@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 09:03 +0200, Hannes Reinecke wrote:
> On 10/10/25 06:25, Wilfred Mallawa wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> >=20
> > With TLS enabled, records that are encrypted and appended to TLS TX
> > list can fail to see a retry if the underlying TCP socket is busy,
> > for
> > example, hitting an EAGAIN from tcp_sendmsg_locked(). This is not
> > known
> > to the NVMe TCP driver, as the TLS layer successfully generated a
> > record.
> >=20
> > Typically, the TLS write_space() callback would ensure such records
> > are
> > retried, but in the NVMe TCP Host driver, write_space() invokes
> > nvme_tcp_write_space(). This causes a partially sent record in the
> > TLS TX
> > list to timeout after not being retried.
> >=20
> > This patch fixes the above by calling queue->write_space(), which
> > calls
> > into the TLS layer to retry any pending records.
> >=20
> > Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > ---
> > V2:
> > =C2=A0=C2=A0=C2=A0=C2=A0 - Unconditionally invoke TLS write_space(). Th=
is means we
> > don't need
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to export tls_is_partially_sent_re=
cord()
> > ---
> > drivers/nvme/host/tcp.c | 5 +++++
> > =C2=A0 1 file changed, 5 insertions(+)
> >=20
> > diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> > index 1413788ca7d5..6016510577bd 100644
> > --- a/drivers/nvme/host/tcp.c
> > +++ b/drivers/nvme/host/tcp.c
> > @@ -1079,8 +1079,13 @@ static void nvme_tcp_write_space(struct sock
> > *sk)
> > =C2=A0=20
> > =C2=A0=C2=A0	read_lock_bh(&sk->sk_callback_lock);
> > =C2=A0=C2=A0	queue =3D sk->sk_user_data;
> > +
> > =C2=A0=C2=A0	if (likely(queue && sk_stream_is_writeable(sk))) {
> > =C2=A0=C2=A0		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
> > +		/* Ensure pending TLS partial records are retried
> > */
> > +		if (nvme_tcp_queue_tls(queue))
> > +			queue->write_space(sk);
> > +
> > =C2=A0=C2=A0		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue-
> > >io_work);
> > =C2=A0=C2=A0	}
> > =C2=A0=C2=A0	read_unlock_bh(&sk->sk_callback_lock);
>=20
> Minus the whitespace change:
>=20
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Ah only just saw this, sent a V3 with the white-space fixed. Thanks for
the review!

Regards,
Wilfred

>=20
> Cheers,
>=20
> Hannes

