Return-Path: <linux-kernel+bounces-846718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F49BC8D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 13:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A6C189BE53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8102D8382;
	Thu,  9 Oct 2025 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lLWLBamo"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9E246BA8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760009770; cv=none; b=quRx9ZR4emrrQr55+I64C/MMzWNjUt1jODVUu/LuOFYeGDK1+/0W7mdOPiXeKeRhn/PE5wpxE17Jx6MzAMmkq7+z4vhLQPLGgmOX5wAF5kz6zlJm5R8izXMFLVoNK6ckvqAqGE7gzjrehvxRsOIXKf3Si7uBIKD+SL7M11GMFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760009770; c=relaxed/simple;
	bh=V5FQj+qs6DmW6o9C6/UxAhR39wjcn7nWtLY34WIZgGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxZEPwBFRXsjYg4V1b2Chb3Ade4W9PB8aANUdnyqyvIPFbnNQYXaB+wRtmy6qi3rgNJK7xAesnWkNBRjgv6TJ6yMoEZ0wSrjeDWZy+07BZ90blv8g34BT/oY269qlsNUt4ICqwjrrHOuIeQ87s74WW5lbYKkzyz/gXkWQMQa4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lLWLBamo; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Forwarded-Encrypted: i=1; AJvYcCXsP/tCUF3vNQJv9snMzMsFUKGF8v6SdvstcaoMw4XJoKn6NloK5ge0PXGxcHFGsgZrm+kpxfaGLUpsDbI=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760009763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5FQj+qs6DmW6o9C6/UxAhR39wjcn7nWtLY34WIZgGw=;
	b=lLWLBamoZ9Vze3bbffxc2NqDZEkTkmP5NueaLuRLtDk6TDt6G0WH/OCkcluwDVjtDzhbu9
	EnucY5dxtbCFT9qoGLojckSegsaErZzsjCuDeonorqG51W6AIjVVoGGjxFgMmgrzuYD07l
	rzomPzGOmXyhJTfOi/yfr74DarXFxD8=
X-Gm-Message-State: AOJu0Yyc7QA4m50epTQOt+kM7eoIY0urNwzuIiuNuA/gsJkt5xcw9qBt
	FYxOnif+a58w4E63sQwYl0JuFNhftqBVNhVU4fdYjRyMq5By1znXYl6Q8aZ8aiZwyX0rapIf21X
	c3U1Cwqemws3v8jnLViKvwe+eKpRL+y8=
X-Google-Smtp-Source: AGHT+IEn6DfUJzTF+qrN0U8A3hpm9iF5aoWwXO0T2nuUH9Z0DtFZJPr2qGDgZztcydKq4KsrmSpqANEY2EpX+r8m+YY=
X-Received: by 2002:a0c:f701:0:b0:87b:b6ad:e647 with SMTP id
 6a1803df08f44-87bb6ade751mr19703066d6.6.1760009759425; Thu, 09 Oct 2025
 04:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007063100.2396936-1-anshuman.khandual@arm.com>
In-Reply-To: <20251007063100.2396936-1-anshuman.khandual@arm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
Date: Thu, 9 Oct 2025 19:35:22 +0800
X-Gmail-Original-Message-ID: <CABzRoyZZKACWQ4jeOUmHS-0-7t8ELjD-GMZ-RpiYDGL=T6PZCg@mail.gmail.com>
X-Gm-Features: AS18NWBdt3Xvr1mjG1xmHMEbEeTM17-hxQa2VvgahlWoWMB1DxgCulMHrUr3oNU
Message-ID: <CABzRoyZZKACWQ4jeOUmHS-0-7t8ELjD-GMZ-RpiYDGL=T6PZCg@mail.gmail.com>
Subject: Re: [PATCH] mm: Replace READ_ONCE() with standard page table accessors
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 7, 2025 at 2:31=E2=80=AFPM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Replace all READ_ONCE() with a standard page table accessors i.e pxdp_get=
()
> that defaults into READ_ONCE() in cases where platform does not override.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---

LGTM. I still assume it is a no-op change :)

Reviewed-by: Lance Yang <lance.yang@linux.dev>

