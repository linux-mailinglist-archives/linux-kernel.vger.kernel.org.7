Return-Path: <linux-kernel+bounces-794217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9439B3DE7F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBAD442F27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219B630F94D;
	Mon,  1 Sep 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="SR2P/vpe"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53A230E83B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718823; cv=none; b=VI/7Nzt02jDX56egr5YsAb9cfdwQ7+8hwFxJDSWPLic3InG7mRBySenWwDIlKsyEK8ero7boo2a5Milai2Mut9YtWjlgKjsXup6WqDnLnOTP4Z3kfz3HXOUb5mFIVu4gAtVlVfwS6bF2pdCjtjnXfQ72oScfXznELVL6l06zJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718823; c=relaxed/simple;
	bh=MNIeUEBbK9RQcYOVp0G3Wf/xu3aWLubcZd1r0MvEs58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umYBN3XBrnmUZl/J/4D66U8fWXykcgi5qXoBKrSSQoPlmyPn/+3OkK3wZxjDNf3ON340fwxJ+6R4bmQH8LE1PYRApwj2dommkdVAISNQJzZ8r5CM3SaSfXIitpBqsVBHXUg1GQtPSphwBETTS8tTyWlIecXcmqbX4mnChfXTnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=SR2P/vpe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc3953cso86682366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718820; x=1757323620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNIeUEBbK9RQcYOVp0G3Wf/xu3aWLubcZd1r0MvEs58=;
        b=SR2P/vpenXdr3KQsNCNUm6MNA27eioIzeVSjxXiDWt55OzEwbJoheHZ8jx/fmNpQqV
         Mb5NV6Re7JbkoagyH8CCZz/NYRyIrOYIQzLTkQHiA9koVYypss6NnBBjzbbU7rIE9Fom
         448+VdHhub1Rl0/kbsPJpHPQ6Z09J3q9ZXgIVdEj6VCweqMJ5hyDpw5DE8Rwha83wNT8
         yo0PhiTwj06CbHo2NpXqMUoTdjNhqpSUssmujXZ1zqt3Vr4W/KXUolWSsiTuRlM12tk1
         AFmj/P9+ganLNAOBlEwrr5kunfMJb4ZLN2I/aEBtP24UBLGkyEtzRGj+0SO3z40+EHeS
         dBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718820; x=1757323620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNIeUEBbK9RQcYOVp0G3Wf/xu3aWLubcZd1r0MvEs58=;
        b=vfCk5vU20uzNIT4Q2kJ0PuUqfGVxnrSFeL6mnIer/J6rbX6fplDD5zJY84jeLAdj/C
         sE4kFYTx67PXnbzOzozSJK9yaC75tE5PpYHUhw5wrBLviJmozxbLQlFVlze8R/gb1k7V
         KH+GJSjztalnbYGrUFoDmbnBRZxD0SgsTfPqvnda94HUXoZgO99hHvoas/24H2MZuYh1
         ZiYQw6wXfMnSRTWf57k7DEYo69Ma4qLhHe3EieioRu6b8PKAE7HCAMWpSw7QE0sR6r5c
         hasv9Q5sroANNrujP5GCXvQOh/KFZEVZHO3dAI/c4kWdtaOlg9XL6H+iMz3ya9ShWWPO
         xJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCURTztxwM5EAF2AyI3Tumdyk4lX/blF7I0SgCjOhkkO135o/BEsEzDWLpEW5nP3gY3BVpeHVs41DWAY08Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzierGxTSyJ9IdxjOFc4IrvUMy95Uenm4bjF/ZXqNGm4FwHjTHi
	am6FnfnOYQQGOPc3mUVMVwpLOv+dvi6xKJ9EJ8wyxHotWsyNWyeM6+PWt9wZTyXOMk8uEx8ynQF
	nFWe+nIP1I+odx9iy2Y/ygdihFAnF3jpsCS+qgqj16Q==
X-Gm-Gg: ASbGncuRBz6ieLFdF0KqXBeRkbjGKn2HpyUIpMWPRgu5z1RXWOn+ITry1phPj7WLGXY
	kVibcfJPe5rT/TOXl9M7lv2NkNyhFwxnXJqScssu13zbmg3j0FMXrRCl/RvWNvZAcJszu/S7Smf
	6TJ/IiiwXJJeoKmTmLbW20okKX6tELRALT035yC7h/goPviagdfQrsG5iIl46Z0OGbvNEmfNDKp
	ANZu0p4LQNuqHioIfaK59xRdNFk+HvY8s3QYt/uNwdhAA==
X-Google-Smtp-Source: AGHT+IHPjYeMma2R8IKd8tuU0SSmI/fxLC5AjCUvrN9XhbYjrH2iskmxUuf502Yh0ewqk5GEbVaCznHnlu2wEtsxGvA=
X-Received: by 2002:a17:907:5c1:b0:afc:d3f1:aad5 with SMTP id
 a640c23a62f3a-b01d97a0be6mr693601366b.49.1756718820097; Mon, 01 Sep 2025
 02:27:00 -0700 (PDT)
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
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com>
In-Reply-To: <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 11:26:48 +0200
X-Gm-Features: Ac12FXz6IHeh8Yfv6vNOMeXqRNe1GAYft_5waVwiI4C3GV_dXwn9QLUdaEOpeQI
Message-ID: <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer parameters
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org, 
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 10:35=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
> We usually write complete sentences, and there is nothing wrong with
> repeating what the subject says.
>
> All the time it takes you to argue here would be better used improving
> your patch descriptions.

Sure, but first I need to know what is really needed. Reviews on LKML
are often contradictory, and it's easy to get pushed around from one
corner to the next.

I just posted v4 with longer commit messages. I think that's a lot of
unnecessary noise that takes a lot of time to read, but oh well, if
that's what you guys really want...

(In the days of LLMs, writing is almost free, but reading all that
redundant or generated garbage text becomes impossible. I think it is
harmful to have so much redundant text because time spent reading it
is time wasted. But that's just my opinion.)

