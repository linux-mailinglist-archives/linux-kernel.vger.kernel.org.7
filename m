Return-Path: <linux-kernel+bounces-844884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95ABC2FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C169F3A4F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF793224AF3;
	Tue,  7 Oct 2025 23:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvj0o8mJ"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E837182B4
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880934; cv=none; b=ftzqQFl10VeVVBG4yt6tiiQyRM2C648sIel4DoGhfUB1E/6Yhzjch1lSSG0vGtX9dCc1397UvlLjjYJrMof9jkEtUpNr4KnwpxMoKqLm6uero5iDB/Zuo/Df0pCZEJ7shCW4qH56atDb7CGzEd+aLLXIB8CfKGSJo560GeLZ1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880934; c=relaxed/simple;
	bh=KTrkGXnyKHFVa/Dswya3ynmDrTauPJRZ5aGaaq8QjdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIR9MGL5MSBGGE4H0nkaokTf35xt7Pkh3B03R/G2ykj/NXdL2sHdcGe2qjOrBfUUuP5vkGRutMxAM32Pp6YsMI2OMWpMbr4FxSkENHxvOlCjdThV76k8vse4u5wTUKpc+i1LZhNWz9VnsPJP1bAu2BRRTrAqbB6ePeyFjqpp1fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tvj0o8mJ; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-9379a062ca8so250213239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759880932; x=1760485732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTrkGXnyKHFVa/Dswya3ynmDrTauPJRZ5aGaaq8QjdM=;
        b=Tvj0o8mJ5dyXEpXWQrECkrD0ND7Z3gRpijTVGI4m9UMRmR4s8SCtELr4CfaloQSE0Z
         IJQOf/RaOrp2icthSGsSMIdX9JJpKEjz3RUAiAlEpFztlamn5/5Xb9DG46xFvC+H7DGY
         Ii7yeS4dUlX8++tpBytRru+3ENc3pBda/LtQXFU//Y8F+RESif5mCciO6jvYzoXE2Pi3
         rppZJmlQ6QDmgjNJGo1uk9RCbP7wtfydoP5oYZJQjz5Av5gBB2KM6xY/vDhYk2jls39+
         uojcj++bFK19twsXeKjjAqWjN2oYEpHqglSvP/0EUni3Bugi05Plb6jZcLpOpwoj/uL7
         JT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880932; x=1760485732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTrkGXnyKHFVa/Dswya3ynmDrTauPJRZ5aGaaq8QjdM=;
        b=hzc75QtS3juKYs6JHy0u+KgD1dk0RJi2Jc5OfwhGwnEKPKObYdVPu0YSUcYzjeRftN
         l5H+QLFUrvhUoME+OYlSLenkM08Y3ZQaeOjDffFOYHoLCtqoDKph23aFCv1ZmZrmaSPR
         WfGtgkkUJJOGPW1DMzNUcLpl4MfpQ8W0PjHFVn3b95icQan2cuQkHb92j5HYUlfTLKXl
         whrDedYh2mPkZjxQosbD27iu2FeKKw/IdOvI8bsTy329D1A3SLInvNKSuGmSkJQu4pHe
         CBKBx6o/DvhsYZnDTxFj+uMYqOf7plNix9v1uBgGEQyrPSgYGRPTxbTeDf4S9QLOKHO0
         /gAw==
X-Forwarded-Encrypted: i=1; AJvYcCWO+p5eEcHUHyzTBG/ul7svhA8ktJ38iygqpxqgqDZ8E5On1u12JRL19KGhczYQ/xamtQwidr/QKEG0S8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLQgcQpU+r9NgDXzxVw95XOYPobrQ+t74+N2QVI+v+H/IaXHB
	v3VLzGw4QXykTCzPN+Td0P0wvrTvYWXDabte/h9wkoQbitehq1tRlmpSdgEJ92zmyEwJfMTI0Ad
	MQf5en/CQ1zPkqVVQE7zJCXjKVFPHUDE=
X-Gm-Gg: ASbGnctEidwvn6dATRS4vJTHWPpUWsaTq1N/tRX8oTdTYx8vbxcYmq4bh+d0tJP/Gj0
	lstLqp6wPIQQfgsgQ3afjM1mRWs2Q/5SSpt/Dsuc40nOtxCrCtq6S4DEWSRvr53KzS7JlxKFCvY
	mB/V2R5fuuibBD0jZC2kv4byViR7WaUm3myE5QqoW3GMJxfQRpKoYEDeO11Idc9XVVIzFko8U4b
	ZhHpRF+jcnfqO1RdBYOgUNgan0N9k9oP2YFvi6pmerI4y4bsLa1yHDOzg==
X-Google-Smtp-Source: AGHT+IGj19t24JgCl5KO9V5v1EPwjahIu3R5hY3KOGEPtfgUylqfyLaq6Gthhlzw4D29h6T3Jq4pX4DjEtbtAWVOp6w=
X-Received: by 2002:a05:6602:3f03:b0:8eb:13e6:aed9 with SMTP id
 ca18e2360f4ac-93bd1966acamr130126539f.12.1759880931714; Tue, 07 Oct 2025
 16:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 7 Oct 2025 16:48:40 -0700
X-Gm-Features: AS18NWBEVi01jmt9rUQqVyEgBnbeYQcYv9BfSDryjudvNduK48EulZs4TumR5Z8
Message-ID: <CAKEwX=OfcTDH08VrTMFL-uQyBay11H=NccYWVo73XNHVVf7bEw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/migrate, swap: drop usage of folio_index
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> This helper was used when swap cache was mixed with swap cache. Now they

mixed with page cache? ;)

With that nit fixed:

Acked-by: Nhat Pham <nphamcs@gmail.com>

