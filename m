Return-Path: <linux-kernel+bounces-733181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC6B0713E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54C1189EA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAC32F0053;
	Wed, 16 Jul 2025 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6Hd7IEZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96C92F0043
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656887; cv=none; b=siILgFoO+//+6lMEjpAfwNbz3lGuHUqOTSFUK3rUQUtsyeL9ehZ4D6WGsN9cOh4/nEXokGzFlc4lON2gJYtfJnftrQwbf1Ykc3Lt4Jf2PEhnJGxtG5ni832rQonfO3EDeno9FjSEaSb/LNpiyuPuc/XciuX7AGiis34HpyntPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656887; c=relaxed/simple;
	bh=a/2JWXu4g5bm3JwW78AetYwAFF9NnzYpIwjHOkiK8AQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVWZbhuzGNzouoE749NjV7i/dSJwYSS6eSDr8bII9anXQf3sl5Z9hkMq35SmOFPYTahM8eur2ssCkd4QYBmvCYpiEu1SHyrxk8WMPXH8LIHOxQR5xBQ19cfKTpJQXm3aNyO112rpfLyCEls21UJHCksdUU1jUvByrjP7+Y8BEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6Hd7IEZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=a/2JWXu4g5bm3JwW78AetYwAFF9NnzYpIwjHOkiK8AQ=;
	b=O6Hd7IEZ48skx0KD9BVbOL2RspVc9AF8zRlaCm96FDCQYKzaXY7ywMBdVW6ZMeTnoGlUHl
	BqH9oTG433umNSNcoIIbwRANDLirNuSPkXOWNPPIMkYIy4tVlWGahXuDY3DatNtHy4fewq
	hrMV5PxMguU5kcuqK1I33OgH5v/HRA0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-_D0GBWWaNw2r_1gxYp2qEQ-1; Wed, 16 Jul 2025 05:08:03 -0400
X-MC-Unique: _D0GBWWaNw2r_1gxYp2qEQ-1
X-Mimecast-MFC-AGG-ID: _D0GBWWaNw2r_1gxYp2qEQ_1752656882
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso4538465e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656882; x=1753261682;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/2JWXu4g5bm3JwW78AetYwAFF9NnzYpIwjHOkiK8AQ=;
        b=Fd81pj758TDpl6jPD70qfKu+bwn7jSvXue9z2FgD3uStan/qRPvL1jeYAXhP2mm/F4
         q9/bk4EO0RytceuwNHswlDgOBd8NCFv1OHl0Q0vHnQl8TvUmABNyDEWToSdnm9ufLxqn
         ea/NerKo7mCIU1kxzjICjO6otL8qbk30O+rd3e2Uj9AqqQfD9s91oPscOQk+P/LC/NvE
         1hNZQz/GiNKNRUbpSoc4RHVc1qoo18XvZToedkLt9rJwITYa3nqXSHp+TOJPF6mSy784
         +dcacn8NoVHXkPdp/LM+5vTQbsd3LXXNGY5ELcTWsSAoqlg5d1f22Dffrq3+99kxCyM9
         3TSA==
X-Gm-Message-State: AOJu0YyMnN+8DxBLR/q5Os30NQieNZLHaNCaaJfhlhnrgaImB1L4/SoQ
	5452hBD9ZUMhUWBCNG2gSDDv03PB6f9LmrQJC+dBZhC6Zg47P9x3D5AOG9DyyN9/YzFVInVLg8r
	jdSdfZ7J8OvlpN8FTkuFifE0K++0sPdz5Dt6Z/mFApmdatblfhs4EKf/6dTUT2K8XM4uknxEswh
	s8
X-Gm-Gg: ASbGnctvj1fAaviZNba+Bb6m9ss6I070Vz2Z9IvAczRthWNO7M2PJumbN/wmGg69Gro
	bn1RFf4egsTb9H864UnKUVMFzn2L+dgz7E2/OKWGdiIEhHk6DoqkziI8GhYi0KXf9n+sbybvGC3
	4Tb1KvqmfZtnBLkDoFNlVyA8MaBqoARwTnkown5IiKOfnelsNvhNQ6n25XMNKu11rl2RAVS4c+W
	LUEke6MmYBmad71i/Sc988b0+MsSYw10kleyYsnsHR3YYMh8AF5QhvJZyC4FQj+tbeDVasDRsB+
	VWqGmeMtgFbHQyEoAcNYyLwU9X6cPAbYdLNkVrWRDq/h0R85i69ZaA7ZHJYxMeB+iA==
X-Received: by 2002:a05:600c:1c96:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-4562dc7b418mr21706705e9.7.1752656882183;
        Wed, 16 Jul 2025 02:08:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOpGvTBaJnZqTeWSH6ykKhVOwvfDAdzZU8N/vWUacHNon9SjRxLwmhdvqbVLNRlns6FZQz5w==
X-Received: by 2002:a05:600c:1c96:b0:456:1157:59ac with SMTP id 5b1f17b1804b1-4562dc7b418mr21706365e9.7.1752656881758;
        Wed, 16 Jul 2025 02:08:01 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd15bfsm17600498f8f.19.2025.07.16.02.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:08:01 -0700 (PDT)
Message-ID: <9647cdbf96f13fa3fcbc784549175b68d371187f.camel@redhat.com>
Subject: Re: [PATCH v3 10/17] rv: Fix generated files going over 100 column
 limit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 11:07:59 +0200
In-Reply-To: <20250716081304.K_nK3k46@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-11-gmonaco@redhat.com>
	 <20250715150828.BNdFfB8h@linutronix.de>
	 <17efdc2b3e206730cfbef410fc89a713da133b65.camel@redhat.com>
	 <20250716081304.K_nK3k46@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Wed, 2025-07-16 at 10:13 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 05:24:11PM +0200, Gabriele Monaco wrote:
> > Right, I didn't make it obvious in the commit description since I
> > thought it wasn't too important.
> > Those are the monitors whose lines are going to be longer than 100
> > columns later in the series.
> >=20
> > Changing it there saves a bit of complication in the next patches,
> > where I only add lines for new events instead of splitting the line
> > /and/ adding the events.
>=20
> Ah, that makes sense. I thought the script went wild.
>=20
> > Do you think I should mention this in the commit description?
>=20
> A maintainer once told me that the rule is "one thing per patch", not
> "half
> a thing per patch".
>=20

Sounds like someone familiar, good point :)

> This does make the diff easier to read in the later patch, but I
> think it
> is not worth it. For this case, I can easily review the later patches
> by
> regenerate the files.
>=20
> So I suggest dropping these.

Alright then, I'm usually finding the diffs in emails confusing so I
prefer to have as much help as possible. But here it shouldn't be a big
deal indeed.

Thanks,
Gabriele


