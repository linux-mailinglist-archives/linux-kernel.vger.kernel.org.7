Return-Path: <linux-kernel+bounces-781617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3911B314A1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F413B1FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E70225390;
	Fri, 22 Aug 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBeGujdF"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BCA1BFE00
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856740; cv=none; b=G/nEcVRkGkQXSXqTlYn1/cFLQ6agd/613Dp/FKYrcLldBy6HxgX9u/4Y6MeqEVnZGtQi2N8ZLKAEqCdjpV0FTCXgExmoEijBKvcQfXZw9V/0dzv7SuHOdGCJSI1LIrtcyfqNZozdkYVelX5GQLSq5XQtqejV8z1CjgoH4v91aQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856740; c=relaxed/simple;
	bh=FD00boVi7jm3nXXfQYGSl6CRaBgwvUPArFELpTcQcf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNi3gtreeF/hVO0raCHmq6XPgAmmaUZwY2lJWDe8L885gG9/Cx/1yYSR/NO9ZZFoy9er5XwZCKHBtZIBe3A6EbyOh+ix+btuxnilF7usa6N0yRuG03NrChy0J2Lnrno3mamRAoEQYwKlVLCocLUZqpvRzJKWXU8/2BEr2CZ535A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hBeGujdF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6059f490so16569077b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755856737; x=1756461537; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ta0x0Etwp/qHFHu8i5E2Zmb/9HCL2i+tnxSvK4L8KnM=;
        b=hBeGujdFyM7IhDkTHno7B9V8qIEHej26Fm/9D8TothcqI4OW7Cf1zreIDoin+DQpmH
         TuiOxHYbH1Aj2KUPztTogCUlg9bebpx5gLOw1mp9dECOSZKtYVdenVEXMcH4Fiw9e5Cp
         w8sxOhKpC8MtX/wTUd+Ux/sbdVBpDeIY9aRk+BUlzHMipr9VKhEp5CyCIYbom0qrwECS
         96/bekYV+lhrHl2shY49fxdjJUUFGVx2FnfoBmsg/+SpPUx5QwQYV1FLaOUB0XiVQOX1
         C4pAuzerW36KSPBxHvxH3PlOLShNbMFcLSkD0wS6TzBk9FucQD98pMg5em+DWceiv+WD
         Id+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856737; x=1756461537;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ta0x0Etwp/qHFHu8i5E2Zmb/9HCL2i+tnxSvK4L8KnM=;
        b=Dg/KA5rc85u9fg99TmKxlTAIkipr7ZhNLCmg0IfBOHJszZeEH45j56lV93xxRWtCJ+
         zygHXbnbbjTS0nbFhWpXLKC4N7rEzjTKFgzqxjCeoPmZpeGzBVakJxjoF655cN5JLlgg
         iCg20jqKrBxprAkRx9Pnmp8Tir88JoFqRnP+313HGlfxS6lU91HCitVF9hP/CabJ1/sQ
         f4NU1hSCWQmZO7dwdq9x17MBybdw/Cz7ax94SirPSTMO8+9i53OEIpVgMN6wkni1hyw4
         kX1AeSnRpXRhoMM7LzCWhN38l0rW+Z7gy6C4sgpDiKaEUpAnI9lGyVyjRcgv47FM6LpN
         VPcg==
X-Gm-Message-State: AOJu0YyGIYQWAV88ypgB3ZqTVccaXFJwty2PXlkwcH/Jt9ADbFvvFln0
	GHNDjGHNEHFjjbkKKOvGSFYX2jQEU6xXzWVonD7g0j0SDXRPdx74xiudlfxAWeJeX+GgJqLOvRk
	44/bg6ND1HjRRfnnK2CqzJBWtcoRLcw0X6bvgGP20gA==
X-Gm-Gg: ASbGncv052peB+3vgn0icbfWJryZHcJz7d6m/fAISqKH2jGWL7iuSgMQ9TjO1bMgfIp
	+LZWfBzhshUhg+NLvRFqKILLsabfE4XxL2wL5obeU6jsZ9696uSmMlC9TvRPmvbhnEzO9DX0x8S
	HgChfn1x01+7KULCR/ORm4wrh/+R8xgU/nS0PUNP/1J955ngmY80rjoLagBgfqilGthTNI9aUDH
	5rKO/GF
X-Google-Smtp-Source: AGHT+IFd0X7jkwq2XGOJ7EKMxon9dbw2ksIcL5ljDLbAAX3e91uv+L7uUO91qQDTLkLCO0orfNEA4dlYcWAaDmDw/cI=
X-Received: by 2002:a05:690c:6702:b0:71b:68ab:8bdd with SMTP id
 00721157ae682-71fdc437461mr24057427b3.39.1755856737275; Fri, 22 Aug 2025
 02:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-27-david@redhat.com>
In-Reply-To: <20250821200701.1329277-27-david@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 11:58:21 +0200
X-Gm-Features: Ac12FXyNlpfyW29hh3KLyFNs0xgg6UyHwa_qnpYtINLnggZTT9u4v5G4XN84Gbc
Message-ID: <CAPDyKFrAth_76byLZG+5+CA1ZELJVH6XaFzfo2i7nYfnMYKa=A@mail.gmail.com>
Subject: Re: [PATCH RFC 26/35] mspro_block: drop nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Thu, 21 Aug 2025 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>
> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe




> ---
>  drivers/memstick/core/mspro_block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
> index c9853d887d282..985cfca3f6944 100644
> --- a/drivers/memstick/core/mspro_block.c
> +++ b/drivers/memstick/core/mspro_block.c
> @@ -560,8 +560,7 @@ static int h_mspro_block_transfer_data(struct memstick_dev *card,
>                 t_offset += msb->current_page * msb->page_size;
>
>                 sg_set_page(&t_sg,
> -                           nth_page(sg_page(&(msb->req_sg[msb->current_seg])),
> -                                    t_offset >> PAGE_SHIFT),
> +                           sg_page(&(msb->req_sg[msb->current_seg])) + t_offset / PAGE_SIZE,
>                             msb->page_size, offset_in_page(t_offset));
>
>                 memstick_init_req_sg(*mrq, msb->data_dir == READ
> --
> 2.50.1
>

