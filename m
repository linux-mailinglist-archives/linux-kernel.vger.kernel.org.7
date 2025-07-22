Return-Path: <linux-kernel+bounces-741325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0C4B0E2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87622AA1B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DD280335;
	Tue, 22 Jul 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUgTL6CJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C328000A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206217; cv=none; b=qSuSr5kblw/2EWgUHfx7IBZRd871tc44XmjQ8ipMuqJivRNGRG8eaxN1fVeg7fZlAAjtO+EGkjshRmni3hMjs4SAqD9p8RwM3lP/A18rVR5O8XhMm+1D1nfWLqs/Pb1JdkHBqbpenixOAuWF98e+z4/57MUJAFJwcSNgmnUt3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206217; c=relaxed/simple;
	bh=ArEJu7u5sgLXdgm71MriBBa3tnjtkmVflKm0urSixiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmiJXhlZi89E0D0kHUTc0NJzzMFbIw+dVQ2S3RfhtmzvXxqQPyTrRvaRiza3ac9BQHpUT04+hMW0x1cAZl1mvp/focgpXlx8bkRrunjAAZcsNdI7nDPtHkwI6y1D37sgCGW4zxaDEAH5PYacRP8IzYD0w/svNZ4NKq/nmQ8c+mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUgTL6CJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753206213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsDH1uioSNYFyJB6j2gj5W37ON0NSVyJvbRCti5KG5U=;
	b=PUgTL6CJ4m+lbxT8rLcPhswDMwWFUrR8MU/4pg+2bueBdtrXHG25V5O703tmK0anuRqukY
	Mj7yXkG4uRyt9wIhAHCc1iW4BRUsh2rOT8SaxhbZxPASGexMVxiifaZgHp6IajhueKPc00
	iiODhRrijghXfX4wcn+QGUCfkgv/2R0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-7xmO74w1N8OwyMtFAf3zTw-1; Tue, 22 Jul 2025 13:43:31 -0400
X-MC-Unique: 7xmO74w1N8OwyMtFAf3zTw-1
X-Mimecast-MFC-AGG-ID: 7xmO74w1N8OwyMtFAf3zTw_1753206211
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70e86a2a1b8so82880667b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:43:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206211; x=1753811011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsDH1uioSNYFyJB6j2gj5W37ON0NSVyJvbRCti5KG5U=;
        b=XHcSVf32zLSWlR/dGdoLI65Hz07C5ROa/tW2eh79cE1NaLlGX5fQZa7OQQrHURjIKB
         rajzi8zMYnGiySEmKiRjDIHJ5B4BJ3gjHBjEDC92mrZD17/K3W14bdPKNBFyr4Ph79B/
         TM/bE8Jex6g65lFPvKtkHgGawUIynnXBu4rp5JViERJmDko8mBmq8fEaPW3cBOy6fNSt
         VQiusi8ygxl5sdceGshzORIGVryqNGsf16cIP6HDk7Wx/MxLYIYsLwRZ51SAjc9X9R+e
         DQTkBrU7OzF7oWrDyqvYF83HLYX0hD8nfCbCGHOZr5e2TtAVI6tSIgTlicsVxUE53BMs
         X3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5jbSR7fBW4/PEqnk2LtFVsl8cTaywOczoc6ubTmash6u1X0TyMthEuLgXMxU9l66prBsePY9BynjqCDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/FArlxKQci08kpwHhIBalwSUkyDHuPXJxJSxooVcj8MeIztQ
	15iieaBuQaCouP1q2fNdtNEFaIDqI0wNSATV8xf7XX8GZQAmAQGxqDMiNqDTbDdm3voKIb+E7Ev
	cbcFbeNj4/DnRi66/v9EwhjkfR0wheE7EbBi5M4s4MewCtci6oannJsaW2blkrE8XIrQLqz0qAf
	gnecEDaiLqlrAY9KBkH/V+y4McHK+abGx20rnhhZLq
X-Gm-Gg: ASbGncuQCKX4ukha+MSAQNyvKREAoCEV8srQdBQ3bv+gnwaYSDpMWUelela7I50Hs8P
	+NYL62pQw0nMZ2NjS9G3IHdARTS/JbQPB7bZHb9mvznJt2Nccr13lQr5AK0xGmApReco1O+hSrW
	5qFmVlo1W7qqQBJyU2boqAMEg=
X-Received: by 2002:a05:690c:dd1:b0:70d:f673:1412 with SMTP id 00721157ae682-719b40e10d0mr713777b3.0.1753206210924;
        Tue, 22 Jul 2025 10:43:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJY0nNAxT5tewwnLcCVplQzJwNdk/gKqQRCywyeYDl6NvY1tKvaGB3litrfV1J9rWe/RV38T2/mmZ8Vp3FheU=
X-Received: by 2002:a05:690c:dd1:b0:70d:f673:1412 with SMTP id
 00721157ae682-719b40e10d0mr713527b3.0.1753206210605; Tue, 22 Jul 2025
 10:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20250722171904.142306-1-lorenzo.stoakes@oracle.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 22 Jul 2025 11:43:04 -0600
X-Gm-Features: Ac12FXzAodyj834b2REngbgzb2Y6TeaeeWycPt5oGwsuolzLS38sonZX2VsP7wE
Message-ID: <CAA1CXcBY4rFLkNqJM2Dj-EajPw9TMTHNcYapw9P=U0bo=QNqkw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add missing mm_slot.h file THP section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 11:19=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> This seems to be the most appropriate place for this file.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 837bc5cd6166..3f83fb317f51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15966,6 +15966,7 @@ F:      include/linux/khugepaged.h
>  F:     include/trace/events/huge_memory.h
>  F:     mm/huge_memory.c
>  F:     mm/khugepaged.c
> +F:     mm/mm_slot.h
>  F:     tools/testing/selftests/mm/khugepaged.c
>  F:     tools/testing/selftests/mm/split_huge_page_test.c
>  F:     tools/testing/selftests/mm/transhuge-stress.c
> --
> 2.50.1
It might also be worth adding it to the KSM section since both of them
utilize it.

Acked-by: Nico Pache <npache@redhat.com>
>


