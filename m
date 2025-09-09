Return-Path: <linux-kernel+bounces-808941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43456B506BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B305D7B71AC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FEE352FF3;
	Tue,  9 Sep 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQ3+rucx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F67933EB10;
	Tue,  9 Sep 2025 20:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448574; cv=none; b=ker2fOjH39kSJRMRcT2BsENIhQYdJN54Eq0eiQthhdj1dGNBO48z+nxzJp9cdeAiwP2bs5etZsWtXPyh3h3z5eqDWciMee1Eer140ugPH9a9BMLukBx7bhp+Wfrs1SVa4BdMO9KL0bkYcJWnYLkW6R4e2ldcVTDke/r/a8Zc/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448574; c=relaxed/simple;
	bh=8GQ+2Zpkds89Ttvwx4jgfL6tP646QVvAv4WlNgizGWU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEL9mSWXUmyAGEBgt9HmpTXFlAwtU3wQDtSJQaZYjHxVVs7XBxGFQumV1dhRahaGDPA76jSWK+xPigW66IG9P9PiCHBm0aB25i3vqp1s/sicyUmp5R08nxuBisqkv+bM06kI0NJPCfLkrXhHCbaildAkDu4s1gJxVJZKtBXJJMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQ3+rucx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1CDC4CEF4;
	Tue,  9 Sep 2025 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757448573;
	bh=8GQ+2Zpkds89Ttvwx4jgfL6tP646QVvAv4WlNgizGWU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WQ3+rucx8Jwo9LJe2b6oe4qzOMoROxnStaxcNsb1Vzb8IjIobCe65ZJli83pvF98k
	 Ep39P4mk+uA1oYoYEPNdYfKdHiRpL2XT/qKzXNhYLi7A+AveK/77XCtVBkcejxAPap
	 tdvTLya6fB2V53cus6Y7XworW0FpPaEsGWtMfxmLVT1I6G3xoaoAGU7qGf3w6JU0ey
	 7vkIGzzWWbJA1XwhcSajbrQzuH1rWapcP3OQvzMqMB1RP7Bu9CZIGT4GafFtX6fUN+
	 2Em9VNz/WrTbSu/PSJ6UidFW1z/7t3A+KjYbpZjTE1CQPPUDbD9usD/K4Fd7RRzMmW
	 4dx2EcZ7LjZrA==
Date: Tue, 9 Sep 2025 22:09:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250909220929.2a6bcb68@foz.lan>
In-Reply-To: <20250909215824.1968220c@foz.lan>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
	<d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
	<20250909215824.1968220c@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 9 Sep 2025 21:58:24 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Tue, 9 Sep 2025 00:27:20 -0700
> Randy Dunlap <rdunlap@infradead.org> escreveu:
> 
> > Hi Mauro,
> > 
> > I have a few patch nits below, then some testing info.
> > 

> see, having this:
> 
> 	.. kernel-doc:: init/kdoc-globals-test.c
> 	   :identifiers: ROOT_DEV 
> 
> will run:
> 
> 	$ ./scripts/kernel-doc init/kdoc-globals-test.c -function ROOT_DEV 
> 
> 
> 	.. c:var:: unsigned long ROOT_DEV;
> 
> 	  system root device
> 

On a side note, looking at the description you wrote for this:

	+/**
	+ * global ROOT_DEV - system root device
	+ *
	+ * @ROOT_DEV is either the successful root device or the root device
	+ * that failed boot in the boot failure message.
	+ */
	+unsigned long ROOT_DEV;

the output logic is not picking the description, while it should.
The description is there: we just need to add them to the output
data. It should be stored as "Description" inside sections.

The code to output it should be similar to:

	# For ReST
	self.out_section(args)

	# For man page:
	for section, text in args.sections.items():
            self.data += f'.SH "{section}"' + "\n"
            self.output_highlight(text)





Thanks,
Mauro

