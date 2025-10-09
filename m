Return-Path: <linux-kernel+bounces-847079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A55BC9D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7127C3A9E9D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310951F03D8;
	Thu,  9 Oct 2025 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUMHd+hc"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7E1D7999
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760024038; cv=none; b=tsR0qV6tHEC0mrDL5HzJTZAEX5BO/0dMikWYUfTbR6QDIYn1ne7RXIb8+sJK+hms0zboYW3rDG19lWDCnvDzrj9WfOHVT9X/DusfigNKZdXTyGbsaEFP+B1qE6N1AdQKABHpkQ2oW8cfx02NFJVpOZvFr4nKr7dspa5vu1yidf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760024038; c=relaxed/simple;
	bh=tSXhHm/5nIOgPjlJwTx67zGytbtuMVojQkXq2p4N9O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwnXeZxc6FluaRBEBlH/p0aVrzhdkVKD6DUStYHXlatvdHJOZpSn7KPRhHeX5qN0XNeKnup5xqBA5+zkwifQnvbNJMwaOTjn3yswBVV/5jNxYP6HsXOvLDYux5qTogTtim3nZOtX7QEJSz5r/JRCMSgntpkq13nrdrZcTVuO9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUMHd+hc; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b41870fef44so198705566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760024035; x=1760628835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tSXhHm/5nIOgPjlJwTx67zGytbtuMVojQkXq2p4N9O4=;
        b=bUMHd+hcV3ZpA3DkghoLoFeDjxnNjWOR/Hgnc22Q16I0RShJSBS2kvq1Bpk+2Gamlb
         rDrAToAtQ5NEPGYiTChZed6VOxKsQA+9ZUeDK2xjuctYpGOWeQU0jUUSCB974ZAwnFiD
         dFAdIYKf9wLD4j4RSmZEFk5Zd2OloK7KxHkq8E1SzgkD00kIUhzc261vaQ/emHnkolRH
         UY8WJt4PBNh2T95ilZTZTeDnkv8mhiiei/wdy+d4aVlRpRrHeDaQvHhPMS6MkGDyIdI9
         pYrWgC0O3IVLxloA6DjFxwyTNnHVPX5aIqYQwVTm5hYWXtWcH+NchtmgvHV8tkYwjsWc
         0Yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760024035; x=1760628835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tSXhHm/5nIOgPjlJwTx67zGytbtuMVojQkXq2p4N9O4=;
        b=Um1DCEOkAy+tTvzG8WlKgaRi2t12hVB6I5TuV1HY4wF2uhKcwoLL5bdlqfhmmR7J7E
         8fjVT1N/kTX114oOzFforlKdf5dZ6rbkexR3t4+sps2xrnfJ1SUWC1+MMfWA42f1ZEP5
         BJznoqailP0ShtchN8VjpvJgWR5M7IrqdLIjek6Xn4vRtqkputis/LVmDuUPpbL7MbEX
         +gcZxDOMkAq6vmK1dxdJ8QJ+D+g8+6o+OZ2h85uvo+XMxhuL1FAmqnw0X8YYQVnFdVRL
         C63iYWIxTgLtoIGbQs0lkiYXPzsldZXb5km3eI8isiXE6odAJhFxkuW1CMBXd1wGc8uu
         aPww==
X-Forwarded-Encrypted: i=1; AJvYcCVIuLOyIvgU7QdpNu1o8OwVQWTexj+J33eXGNQ9AeeRL1z8YivfV25cWSBZ7J1npGv2qHx2U9yWb1xlcHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3oH/n6xExnzaoC6Mh752Z8//dr624+9sGVu8iQVl/CETaifn
	8YBqPzitcle8CNAYoRKlU1QYlHs7qDBXPJVEQW+S5jcfK/GJpYzrmJpEdO+xEYfB8SdHeyfU6PE
	CLT8EnaoFfYZpIxgyR6P/YvP0nl6NliU=
X-Gm-Gg: ASbGncssa51UKSMXhv/4W5uqsiY3I/9feKSV7QRc5H6laslP63IAxKOrZVNBLs0WbbL
	toUMDGodBfHVnDLVZ8IHihfVZN2wyAWyj3gwLvDlbhLgjz1/lKre6lPOI39CGndIZewT5SeFsuT
	+1nUxSfmAZxz7htC//RiGxCDh4h8yzY0e2WmkrZXuoV6mqWk1gpe89b7YdloVrJe0EyAEHHSwAn
	7xx1DWfCptlOkKpw6uQEt0FqzRVmz2xPvtSq3kpdw==
X-Google-Smtp-Source: AGHT+IH6/BnweZ3mNzMlMJsoDTrD5kw2wuxUnnf/fUi4kLw7k5i81wPVfRT8YaOXTjGWMzidnp8/KhRKuG28inavPMc=
X-Received: by 2002:a17:907:9287:b0:b0a:aa7e:a191 with SMTP id
 a640c23a62f3a-b50aca0b70cmr976959166b.57.1760024035254; Thu, 09 Oct 2025
 08:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com> <CAKEwX=OfcTDH08VrTMFL-uQyBay11H=NccYWVo73XNHVVf7bEw@mail.gmail.com>
In-Reply-To: <CAKEwX=OfcTDH08VrTMFL-uQyBay11H=NccYWVo73XNHVVf7bEw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 9 Oct 2025 23:33:18 +0800
X-Gm-Features: AS18NWA71dHoM0Fug4D0KAccZRzH9_6Mg6UINYPbSGRBRYQlJKeWYjPjVsp-Kn4
Message-ID: <CAMgjq7DTLxr4t0wvCDDzeY8wwjk_-1zS2yqVbNYvrc=6DAnXbg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/migrate, swap: drop usage of folio_index
To: Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:48=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > This helper was used when swap cache was mixed with swap cache. Now the=
y
>
> mixed with page cache? ;)

Yes you're right :), thanks!
>
> With that nit fixed:
>
> Acked-by: Nhat Pham <nphamcs@gmail.com>

