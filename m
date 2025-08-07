Return-Path: <linux-kernel+bounces-759269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F317B1DB45
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7533A1D5F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6B12737FB;
	Thu,  7 Aug 2025 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHqHR5UK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4B272804
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582578; cv=none; b=mvgBajZASNUyfE8oO+BXKaWkIfVysjvojGOL5zK8+WeNiGYjrYoZhoJO0oJOP560fELmO+gVInqe167QnbOmoiGGH5SKNWi04TCfntt3nnKuqsltc1lC/PDp3uq4z/ub0eiKJXCtM8DOhF7erS/9zg1yAdZpu2EaWgwxvbpWzlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582578; c=relaxed/simple;
	bh=Z//UwayiWOvWJqkaPBg7axs/e+SZ904ur7krzuuGowc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LoDPHg+yzfhwoK01BHe71oEYAUHdVLya8FQddXozgNKRf4o9CNIPaJ51oRX4mk3pARdE41q7rOyyroUTfr5ll/sNwoplbx2neRvs5RIApZUjrbtSCXZLVchvfEFWqIXpYQDmWM6cWOCMlF2KM75xlj2eAjsbISPkQQUd2u653Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHqHR5UK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5f438523d6fso10824a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 09:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754582574; x=1755187374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z//UwayiWOvWJqkaPBg7axs/e+SZ904ur7krzuuGowc=;
        b=yHqHR5UKF9ELq/YczqyObfvEfEeIFY3ZzJS5l5+ruTXAW+ZnGQzMQKtINVPXP4P3aL
         2lgcmxxaxMoIpFhmbvsLyoeC72l3GdAFW0Kqf6gsYo/EtFEUUsAFj+gWHL/3PfqBp1t0
         zlYRPc9hubKGPhvrmno8Y1T9DCfqIsfVTxzgH5x5NjIbd1bxLrBp+0YOUum+ERxSscsb
         LOybji70iWMSu5jnTwU+6n+k6iN9bRuDibyWDgwZStjiDJ+UPONlurBVYHEUcDYfKvcm
         8WP1C8GE9ncz5SI66wAqF7KX2YsjQHvjtX5L6ecSCW+xPyGsz9BYsLDqLnXq7cSWGKFt
         sn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582574; x=1755187374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z//UwayiWOvWJqkaPBg7axs/e+SZ904ur7krzuuGowc=;
        b=LF+tIrZAacN3qLZH6tYwJ5VC8X+AGGvlziv3SYsOCcz2oqTfoAsecCaqAX4KpgwKM9
         ozCz+F33Nepzao6dKOzGRe4S/2fm44Is16U953a+02ymtsUreGKQUp49twDY3VlDK53b
         aic6HBxIBi3Lau6ckTRiRa64+GmK7IHoXWLMeeAuDxn7fTUod+n4Ay883AcKrJkUxEBu
         G+echfQW6GCnbc/JfFiSvBNeh5B0y8x9BcDxfonTUytrhF31zD8usNAuLaWcUuuo8VcH
         +/9ATtdudQGK4kRfK9uYKpgOYUKok9lYcwiyIWAoKpXiX4tAQ/S4DfSsW9EZgHfntqS5
         ro/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrABO8dnr3Wzxugrq8KYrOl6yScSsxikXLmUbaT31FUz2ZXXNrfranJknhl/tivbxcjd14nyJiPDe7tNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMLqrECbCZe1cPVuU4F21OSb8bM9Yq9C71zhZBASI2gURGn1Io
	Y/RRc4uT4OPDZDadW4G0KU3i7fo+ui6oYLGriAPjqVXwfux6ePVhS+fPgv0REnNzR/5qFHIuFbZ
	JyX+s6jmPmPMOSbWWJ52UdL8nFPVA5Kmck8sCcEMI
X-Gm-Gg: ASbGnctv3dVv7focY/KxePqDYYY6gyTfKjQiFkE64z9RKx1ERnM1LnJ9AQbYqan3CwV
	HWWPnc3thV/5p0z4sZT8O9wrAA8ZcMPPSKUtopvVZjmz8/LZAoi+9nG7FijcPB0fwOgMMeh7tHU
	NNysxdzq9fx+BHtlDQM8pt2aGTzTvBV1a4izvagsnPi2i8SHEFPBjwTG8A0LFVwe4YiIEdyjvrF
	7x6aUU0Yib5J3XbPZbxTS5CuLWU2HlZpT8=
X-Google-Smtp-Source: AGHT+IFASsYOqS+cSKa8zVP9xve2ND/LPdSpr3uJx8kIFFr/IcyZmEblAexSI0+MnJwWTh7EYp5HiNO85CLzvvRh9pI=
X-Received: by 2002:a05:6402:3059:b0:612:ce4f:3c5 with SMTP id
 4fb4d7f45d1cf-617c38addddmr77974a12.0.1754582574434; Thu, 07 Aug 2025
 09:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807152720.62032-1-ryncsn@gmail.com> <20250807152720.62032-4-ryncsn@gmail.com>
In-Reply-To: <20250807152720.62032-4-ryncsn@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Aug 2025 18:02:17 +0200
X-Gm-Features: Ac12FXw-L14MzSZIbdhDuuuaGoNtnHc6MgG8djKeHfkzC15_DWV0euBIlOkenb4
Message-ID: <CAG48ez114_bmuca2UL-g0ZY76-VqhL-4rQtJM_k0N2NJXE4vdg@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mm/mincore: avoid touching the PTL
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 5:27=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
> mincore only interested in the existence of a page, which is a
> changing state by nature, locking and making it stable is not needed.
> And now neither mincore_page or mincore_swap requires PTL, this PTL
> locking can be dropped.

This means you can race such that you end up looking at an unrelated
page of another process, right? And your patch intentionally allows
that to happen in order to make mincore() faster?

