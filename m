Return-Path: <linux-kernel+bounces-830801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B55B9A92C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FC23B900C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265430DEBB;
	Wed, 24 Sep 2025 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBFTC4KJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354A30AABE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727338; cv=none; b=Nn0MzJZnI7NLf8w+7LiflxA4yzzf+QkxrChYalTgqbQx0zZ+AAilUmfLi1SYT5OtjUWQSKw3ud5BJuH/DiWE5XtK9gkyNmgc2ZrVrOGwYCZOxMYKAoMBXUMHEltb8jsfOrsGBYqli4lvcKNME4qQf/8jxKNXrlLyXmaq+g/EnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727338; c=relaxed/simple;
	bh=1muA90RWGEC6wPkRDjbeO+tMclOaDOmxsXUUd/1V9Hw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TU9S/EqSNFN4rtHyYCpFhJRU5Tw/Cfk5W6ka63QN8ZRMHjaosS+QYxHYTzp5TFxy8o8gypeOxF6ci6sxP1MwW80VHjforbX8KMkLUMLtmK1bV+ZX1jOqUCJlzND3ies77HuaX4066L8fJBAayGl2i4Suk5+i0W08iR3kEUZ9+Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YBFTC4KJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758727335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Bg2MsKKDFmCYY/YDryOM8vGO4DqIBOZHKhqnpmhTQOE=;
	b=YBFTC4KJ5D230joRZWMGVTIFe1dySJcTS2nk8Bgtkhcm7wWHSFmxfinxDoNX1garEJ/klQ
	+0Yi/DujCf+EWcwGvMPY8/YDyCe19QThpZ47I4jDWY+tj3sOckGw9ShnZ1qyOVP11cXRHA
	D9cYaRHNzPojyu1rX1b6l067e1l6W/k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-9XdygmijNjutBTl00o1wnA-1; Wed, 24 Sep 2025 11:22:14 -0400
X-MC-Unique: 9XdygmijNjutBTl00o1wnA-1
X-Mimecast-MFC-AGG-ID: 9XdygmijNjutBTl00o1wnA_1758727333
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdd61b798so3847466f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727333; x=1759332133;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg2MsKKDFmCYY/YDryOM8vGO4DqIBOZHKhqnpmhTQOE=;
        b=jKQPtIo5RDHDNaAwMfpvXbB1yeWyM5Sd36TXzwtYKWOt9CZW+TSwGHlom1x2qjIdeV
         eBkoClYa4dq++kce7+yutCX+pEKXMpraU8bq2JKjv+I6PBzg7/bKvdi4YJKCjJ+Kkxze
         IbVXI4LoaFjceDcoUeKYMyNqfsbEgeGWvzEQkudj1X54tLdf+mwLXI2a8CcdpQKdUGNq
         MJPhJzsMw33n447zqlbtX84cGkvfNr6i2O0q4sMQkCMnsU4tliIhtaXZ5Dp5Se2zY+d2
         HLxfTWBMW5rD5cYuT8IptQDDz3QhW30TkIjB9e30NfjtGSgY+Je7KFYKTb3yP2iRGkz/
         7vyA==
X-Gm-Message-State: AOJu0YwFSg7LPfOP7y/cc1kBf1mcJuhlzuHMzfg7Twg3YN4TLGz9G+Od
	xFXlztFUy2Xeox2X9mFTpJGl3YrUkERs1W4ZsnQ/x2FosuL8qf9pupc4R1oSud30tGhjjFbtaR9
	104UN0cXMsn3Ng0CIs9OBZHUcaTcswyLmsRJzeTJegp92MDtvdfkwRikwlyZO2ZKGXw==
X-Gm-Gg: ASbGncuj6nR497Yp6x9qxG1ylYNGlouxlTm8vdvqGLRr0186OMllStEBTV7tTK2/OkG
	bITOMmJ82r5szI3HqNsL3uSUpvrbtqG3JkxwCkpDANieQIZWhRuwiwm1BK/YHwsjjIOjiye+3O1
	JLMQbnCSFYl37oVxKfI1rU1EMFkUNPyMPT+Zl67uzey1h/JnTYwM3E2qwCaHkTfOzJjnyqh62i6
	0BevffKhd+zHjeH3yNCNTojBtXsUC7rYWToUxp0KLqg67SIk0LUzHWKcj890XF//euBpaS2TZOF
	dJfLJpHpthxVWMzSGVBnKQYtOMm/vJ8DWiHHCpsQFszshbefy1ruvPl5eEbc5Xf4OQ==
X-Received: by 2002:a05:6000:1ace:b0:3e7:6418:247b with SMTP id ffacd0b85a97d-40e458a9caemr329741f8f.10.1758727333015;
        Wed, 24 Sep 2025 08:22:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyXMiav/N/da9iJwE0NmEHYfqO6HQalEGMq0ozUxtHZDCD4jU1uW6JDuQDhvzuX2tQxnrSMw==
X-Received: by 2002:a05:6000:1ace:b0:3e7:6418:247b with SMTP id ffacd0b85a97d-40e458a9caemr329704f8f.10.1758727332529;
        Wed, 24 Sep 2025 08:22:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbffaeasm28554615f8f.62.2025.09.24.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:22:12 -0700 (PDT)
Message-ID: <8e51adf20a9eafd3046c1189989f87734576bd57.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] rseq: Run the mm_cid_compaction from
 rseq_handle_notify_resume()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	 <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
  David Hildenbrand	 <david@redhat.com>, linux-mm@kvack.org, "Paul E.
 McKenney" <paulmck@kernel.org>
Date: Wed, 24 Sep 2025 17:22:09 +0200
In-Reply-To: <d5183516-92ea-4a76-9506-2f7e4da0b0ad@efficios.com>
References: <20250716160603.138385-6-gmonaco@redhat.com>
	 <20250716160603.138385-8-gmonaco@redhat.com>
	 <d5183516-92ea-4a76-9506-2f7e4da0b0ad@efficios.com>
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

On Tue, 2025-08-26 at 14:01 -0400, Mathieu Desnoyers wrote:
> Your approach looks good, but please note that this will probably
> need to be rebased on top of the rseq rework from Thomas Gleixner.
>=20
> Latest version can be found here:
>=20
> https://lore.kernel.org/lkml/20250823161326.635281786@linutronix.de/

I rebased and adapted the patches on the V4 of that series.

To get close functionality I went back to the task_work and I'm scheduling =
it
from switches (rseq_sched_switch_event).

Quick recap:
My series tries to reduce the latency caused by `task_mm_cid_work` on many-=
CPU
systems. While at it, it improves reliability for bursty tasks that can mis=
s the
tick.
It reduces the latency by splitting the work in batches. This requires more
reliability as compaction now needs more runs, which is achieved enqueuing =
on
switches instead of ticks.


While this solution works, my doubt is whether running something there is s=
till
acceptable, considering Thomas' effort is going in the opposite direction.

My tests don't show any significant performance difference, but I'd gladly =
try
different workloads.

Any thoughts on this?

If the approach still looks reasonable I can submit a proper series for rev=
iew.

You can find the series at:
    git://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git mm_cid_=
batches_rebased

Thanks,
Gabriele


