Return-Path: <linux-kernel+bounces-895805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 794A2C4EF59
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EF13B554F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C19936C597;
	Tue, 11 Nov 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShpdqHqd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7gO8GYo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9133CE92
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877706; cv=none; b=NrU7p/10lIbFsPkqX2TpFwvak47VgIyxSWx+Qc4B2I2TNQeRcRvlEkXCsQBvdxY0LL1ccxeHiZUsxsfbZyuu2dB6FM2v7FCnk7Ynhyvm+1y1e35nTQtBfynbOjnG0qpFA0dzayYZxPx5nYFt/1mGuXUkITBnleO6vjPrRZN7Eho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877706; c=relaxed/simple;
	bh=CAzz4tdO9jRd3NYeIx+mzCdWu/XNR9YZQNSh6xs3tkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bo11sOAn9FeGonubVe4DQVrsGzqpJExwSnfh9hcoNU0pKgB0vCYOBoEHXqJN8eyA4QU06lmiHiF3is5i0hxU4G/CNfC6dVS54halpYI4AaJC1+QJfOtAwd3Gx9U5kxdov00Llmw/GKgqc5exS359DsMlhWecvw8oWnGETH5TMUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShpdqHqd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7gO8GYo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762877703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAzz4tdO9jRd3NYeIx+mzCdWu/XNR9YZQNSh6xs3tkM=;
	b=ShpdqHqd+rzXQjaYRwkTL8gcJ24Pgkfs9TIw6ziKC4xuK2NdrxtcRnkVHXUony4ixqWMAZ
	T+pG42eOOzzv/Ga/HnJxqzdBHw9Xy7bvHAYjroeN7yIJiOhyFSssJTpSKgRtbqnqry6tCq
	ju2Co95NeFB89rsiYwwfkIYg1M3KAPM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-XDLL3cT3M7SCUzPz3i5i7w-1; Tue, 11 Nov 2025 11:15:02 -0500
X-MC-Unique: XDLL3cT3M7SCUzPz3i5i7w-1
X-Mimecast-MFC-AGG-ID: XDLL3cT3M7SCUzPz3i5i7w_1762877702
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b1c1d39066so1110014885a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762877702; x=1763482502; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CAzz4tdO9jRd3NYeIx+mzCdWu/XNR9YZQNSh6xs3tkM=;
        b=f7gO8GYoC8MqmXdqCaeuPrwYc/o1ZTt5TwoG+7p497nALVc5haN6UkLoPC1fPUq4i6
         aqqVaMBUoXfZvcMvIIucuWFbg/+UeQGALsvDt9eabZLkj6ekGsR1pJY2zne/54OIbeOH
         RXhpKQw7KJs5Kauii1V+AVaDnTUecJ/QynXXQh03T4hwpopeyBgdR36oOGytl/XahJPV
         Y5nNtsQlj/K0UGYfQYABkfQP80YJWEa/6V+PspzlB1ogQRgNFQ/q5pOOuMqH2yggMaC+
         GZhw5EnbnY5BILZUiV3AyeYhNMPt7DPHSwpQs8XkQvO9yPslLowfkwaBnTQLK9doxkRl
         ldEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877702; x=1763482502;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAzz4tdO9jRd3NYeIx+mzCdWu/XNR9YZQNSh6xs3tkM=;
        b=U+M21UG9X2vNt6w46zoOHpHnRl3iF1JMdZDGlJ1kRIp4Vj3kMbPSOCo7YAmIel0t3u
         eLKppu5K5dfhcEY9JkFQS4/tW3M3um+AaELFVX/196KeFA5LU45GlqTFupeiYryiam0z
         hxE0NhQguXkNaGl5qh/tpQg8z+evx/PGZbZXv/kjnExb8u5g4dR1CAluFLvUmLBOA0HC
         sL4ke+p2i3W7RGcBfTqe1RBz2Ictuc3jiPHQLpEjQG7eIh4gJ3Mkn0BxdNea3C7UMObl
         qbxHSUtSGALCNPxcgBHrD1AbGyU4ZcZxBNGPhtkxPfwYQyWeK2ux2zpXgqoF/q+VfDeS
         irKA==
X-Forwarded-Encrypted: i=1; AJvYcCUcAHD1reEtGyLWGytmQ2qO0iCwuNE7nOJIlZwLtDeJKKUaE0W8kTaS+0DizcKAI0rJmztbmfYjNp6hd/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW4XEAc+O0soeUSbNlJh6ZkG8py1PbOT4ERIYTr1GwlwBtC5yP
	NptYYzUg4O86w9W92HYf321DmeuyTe4en3PEdtrKQJbXHLq9lkl8ZNQWgzl+yQjWP8IIdgZZQb+
	F2/71mG+CKRpEtHoBzumEd5peb83XDbgPEgl2lNWp4C8UQfQ4MO3OlP1PPawCTFGYiw==
X-Gm-Gg: ASbGncs+VCiY2X+ssVRz5uasPhiGCSTjqryGf4dPTJONlFzyB6tsY1v5n4zkAAwjs1x
	y3fjgACEQrGpM9qmZ/shFybihTzuVkZ9RCpRwYwXhwoI/Qpi8NegO3t1pnoFz5JpTa0BgoGaAG2
	oTaups/HVzdpgIaQXqciHLuE/KE1la8Hicsi/0ZRfrlrgTVfH//kNqDkmaRaN1FqNy9eKOdRCL7
	gv0USSXGCDCZgMx27HDnQzawehP/lv6ZSjZF17++6PfRDwIndVf7CqdvHmWLArxOf7I6KIVlFrK
	i8A2X725/1BqzJfgaoS3gNZgah8K1jgDs3C/XmIzsnO5dpNrCJ7aE4yOIFUeXqAA2h1M2g==
X-Received: by 2002:a05:620a:6914:b0:8b2:1f64:7bc5 with SMTP id af79cd13be357-8b257f69f9emr1539504685a.86.1762877701883;
        Tue, 11 Nov 2025 08:15:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZzM88+sgVGmR4fCbMdvG+bTstulnQHQtfzsOqHKlcvJHTzfGD4ZKhDU5deE0z92drdTBPyA==
X-Received: by 2002:a05:620a:6914:b0:8b2:1f64:7bc5 with SMTP id af79cd13be357-8b257f69f9emr1539498485a.86.1762877701360;
        Tue, 11 Nov 2025 08:15:01 -0800 (PST)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::318])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa25791sm9814985a.52.2025.11.11.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 08:15:00 -0800 (PST)
Message-ID: <1ce413b202ca7c008e077a6f1cfa88f94a3a7cbd.camel@redhat.com>
Subject: Re: Module signing and post-quantum crypto public key algorithms
From: Simo Sorce <simo@redhat.com>
To: "Elliott, Robert (Servers)" <elliott@hpe.com>, David Howells
	 <dhowells@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Ignat Korchagin
	 <ignat@cloudflare.com>, Herbert Xu <herbert@gondor.apana.org.au>, Stephan
 Mueller <smueller@chronox.de>, "torvalds@linux-foundation.org"
 <torvalds@linux-foundation.org>,  Paul Moore <paul@paul-moore.com>, Lukas
 Wunner <lukas@wunner.de>, Clemens Lang <cllang@redhat.com>,  David Bohannon
 <dbohanno@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 "keyrings@vger.kernel.org"	 <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org"	 <linux-crypto@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"	
 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Tue, 11 Nov 2025 11:14:59 -0500
In-Reply-To: <IA4PR84MB4011485C0EFFFF9F2820A1BFABC1A@IA4PR84MB4011.NAMPRD84.PROD.OUTLOOK.COM>
References: 
	<IA4PR84MB4011FE5ABA934DEF08F1A263ABC3A@IA4PR84MB4011.NAMPRD84.PROD.OUTLOOK.COM>
	 <501216.1749826470@warthog.procyon.org.uk>
	 <CALrw=nGkM9V12y7dB8y84UHKnroregUwiLBrtn5Xyf3k4pREsg@mail.gmail.com>
	 <de070353cc7ef2cd6ad68f899f3244917030c39b.camel@redhat.com>
	 <3081793dc1d846dccef07984520fc544f709ca84.camel@HansenPartnership.com>
	 <7ad6d5f61d6cd602241966476252599800c6a304.camel@redhat.com>
	 <69775877d04b8ee9f072adfd2c595187997e59fb.camel@HansenPartnership.com>
	 <3d650cc9ff07462e5c55cc3d9c0da72a3f2c5df2.camel@redhat.com>
	 <534145.1762588015@warthog.procyon.org.uk>
	 <IA4PR84MB4011485C0EFFFF9F2820A1BFABC1A@IA4PR84MB4011.NAMPRD84.PROD.OUTLOOK.COM>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-09 at 19:30 +0000, Elliott, Robert (Servers) wrote:
> The composite motivation is to provide some protection if someone
> discovers a basic flaw in the PQC algorithm. If quantum computers
> haven't arrived yet to break the traditional algorithm, the
> composite still proves validity.

Given you quoted me wrt composite signatures, I'd like to make clear I
do *not* necessarily favor it.

Unlike regular software or firmware, kernel modules are generally tied
to a specific version of the kernel, therefore there is no real need
for long term resistance (unless you plan to never upgrade a kernel).

If a defect in a signing algorithm is found you can simply distribute a
new kernel with modules resigned with a different algorithm.

The problem of using composite algorithms are many:
- You need composite keys (or at least two keys, depending on the
implementation).
- You will pay a higher price in terms of CPU/time for verification for
each signature.=20
- You will pay a higher price in terms of disk/ram space to store
multiple signatures.

It is generally not worth paying this price when the remediation is
easy.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc


