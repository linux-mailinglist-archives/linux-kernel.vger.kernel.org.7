Return-Path: <linux-kernel+bounces-794279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E466DB3DF68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56407172002
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87513009D3;
	Mon,  1 Sep 2025 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Zh4FisZ3"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1C2FABE7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720862; cv=none; b=CHIBSChO3GzzFGSORbUIVvmrqCGCyEBKU4zVAcvnqUowdGUN7SxOTkT4H9m+U4jt5uz5UyAMIIGAeB90wPbcLskod+kLLq53uZkOmEDk04ZWRVKjrP8wzDuCdL5PiUjlDIo2Ns6s3QT7S6i4d221Aas0ApR6QpLV2uOmGJBt3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720862; c=relaxed/simple;
	bh=RZtA043f+9J36uYAZQCeR3xnwdSFMzlTWbO8nJwmBYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUgkOU1FqZdmj1TtBCkmT57zMv1zIqdMWsb7bEBnE20o51k5jmT5CSkMlTh7/lIaTQEXETRR+iEy9Awf6ZdcukeRS3g6dLwJDgoBBqWRmk2fwH2J0AWqnqBvqhNOz/5XhN0/gf6Aj7u4mJ6Qqdj5HeJViJ+6HhfIVDrcnqHja1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Zh4FisZ3; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc39551so107207466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756720858; x=1757325658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZtA043f+9J36uYAZQCeR3xnwdSFMzlTWbO8nJwmBYQ=;
        b=Zh4FisZ341Gqb8sVxC9w6eMoZREGO1gQrxEEiA6L8qtTusCBCIcrb1fIxdDlawfrIF
         3ubHNtl4J0An9mougjRQu032VkJd9km4UbHKK/T7BQ/K8Dkb4TXJGSO63DPdk+Vkc4og
         ld1avlIoSt2PzsMdNx6VOQ2EktCEtxggyw1zI9cOdNRtd2VJtsePDjvLQ9U40VEvyYhA
         nz5mb0ksLBRKkxQaWG0O/DTW/gRUhpUm0ECD2Gaj89NfDZZLJjcPv+MkAteJuSP5+yCz
         V8Ps5QF8xVMyQVmKhR2xNP6OepFwa/5KBsKQOMpWhsmBOjXB96ARaTiqfgPas/feo8qR
         fqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720858; x=1757325658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZtA043f+9J36uYAZQCeR3xnwdSFMzlTWbO8nJwmBYQ=;
        b=q9sE1FViIDMevnvrbWUipsp4Vr1Y+uAqS3ls6S4WTuAtzLPcd9MnGc8k7990Fr7OUY
         Kmp+sGyV2vT3q5IIsiQPPWh+ANR71ePOISaIgz8huzw2d87T0W3FaaT2+ls25J3TUxz0
         EwFu/Sqz6LX5EjMYFuWXS9G791DWyP5PN9RDVbvi8efp38rp4at/QjTL/v3tEpWms+Np
         W8O8IjSLmb6282dpqWbfMj4SD2/p++DljoZ/k0y600nUI8OLUnTX+CUnBhjqCSosJ7Y/
         xWyvt9t3JjzY7wtdRvN+pzEefZl+Rcz1uMc1CwbHaqJPtw1nEZhUI2V/xJqak3wLJXAa
         K3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGHVE4OpOdG1+AAYrYCb/8OeQ+5nMKWM7FTDedTejnVWip/qoNZldRl21cFB7XzfvzGM+RZwqhQlqeOkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXdSe3gtQWtCVVC/S+/dQDxfd2dW0hmPAzL3yQs+P2YM5Qu7ou
	Vhv2HuRVJUdDzUCIMNRYxznR7SGJG9FY3OTL/K9iIC4OzHIdgr2jep8ZUfWrzNkbNZ2/fDs0xlo
	J4SgO8DMpxCiuv2EmTHoT1KSMaJkHssRfFFS7ApcrPg==
X-Gm-Gg: ASbGncttyBRdaJq02xmALsWkE6o2k+HrOqMwzffY4Y6L/L3dbYjVqS+XRo+ZarcWCa8
	jk6EY0xr5enlq4/rUnkMeiPG5AX5Ie95YmLFF4nBJ54OcLCEoJI8GpbuMWf/e4ehZa/X/K91Lm8
	wlACiJq+D3xoMEhBQDHXgckbmmMdZLgFXb9mJ3fDQIa65pipXKKCgYtXd6pC0p7BpZ4f1LOtwJS
	R2T3G7RRMFJfbz8c2RjCjhufJ7ytVkBEauMbixeuLjaGw==
X-Google-Smtp-Source: AGHT+IFFGUfCdIOz+No84FDiodUHrtTEKs86fTObEn6rdLKazh4yTfRj0xdajRcJIzy0MlKpo8dtV74RUFC1PXI/Aw0=
X-Received: by 2002:a17:906:4788:b0:afe:d5bb:f424 with SMTP id
 a640c23a62f3a-b01d978fa6fmr674225866b.45.1756720858484; Mon, 01 Sep 2025
 03:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com> <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com> <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com> <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
 <661e6140-572b-4480-9ca2-6a127730f32b@redhat.com> <CAKPOu+_KbBRdtB-WiZuiva7Fqsus4x7zBOPkqdhwfYFkdS-doA@mail.gmail.com>
 <25f468d2-8474-4d27-9013-d4cac7675897@redhat.com>
In-Reply-To: <25f468d2-8474-4d27-9013-d4cac7675897@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 12:00:47 +0200
X-Gm-Features: Ac12FXwPOfV2ePklaWMKvCg_OF7F56ytbjMw092zZPB8xbwjl_q_F2iE4VQLqzs
Message-ID: <CAKPOu+8YMLrtqbhhQ0SgfQN2xErVhZCLEoStRL-YJy-SeHE8ng@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer parameters
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org, 
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:53=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
> I'm sorry, I have no time to argue about the basics of writing a patch
> description. I even proposed a simple example of what we (multiple
> reviewers) would expect as a bare minimum.

But Lorenzo Stoakes and Mike Rappoport wanted much more than that.

> If you feel like you need other rules than everybody else here

What other rules? I get confused by different requirements by different peo=
ple.

Quite contrary - I want the same rules as everybody else. For example,
the same rules as Matthew Wilcox who already submitted similar patches
(with similar commit messages) that were merged without pushing him
around.

