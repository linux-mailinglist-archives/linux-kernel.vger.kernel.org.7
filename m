Return-Path: <linux-kernel+bounces-786977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E36B36F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69717C38F0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E012C3761;
	Tue, 26 Aug 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="LIQ/38UW"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DF313E09
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224514; cv=none; b=WZKvelMPJwHWzYs51l3PswdSmLtx2TTapc72n+rO2T03IGvWyYhIjq8jmpPjXe7cNpq+2fmHfTqMt6asGDLiZcbmg3oShBznfTZMaTRFmn+M32UOp+DtjLha7HixfJ74nAVw/18KIs5oE0GfhC2lcpSZCa/1w5Mmo2wSnzpApLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224514; c=relaxed/simple;
	bh=vjgTUmBptG96Ivs8YmyV7OyA9pvN4OjuURIQOSCcEO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pttFGFS8ms1agwrAtTU3a8jOUADfXkIOZb9x7aU/Wu/Pl4UcQCI+qXKK7PCGhvzuvNoN7tkrjgEjbCoCtLxOpsUpB0zlIDa4tThXisZTFiGM4mCCND5yrNT13Coo5AEnB/gJvSQmu15KLIclzSWdao2+9KrSiPdStG+mhk9bxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=LIQ/38UW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24687a76debso507675ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1756224510; x=1756829310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lnnKYGUwqSfcJFego4cSUIS6ucMudXKnod8NwY7i8c=;
        b=LIQ/38UWlOOqneWMvZafuKTdINtNKgnGKwTZJYhfnAFNDGebKaGgUTBSDmR46z+/GZ
         0mPLpqbOkbbeFZ7Cf/ilDnsfwuWg8wbVhUIAYLnATStHQ1/N3tlLDhRf9EEZYC/dNIWQ
         O34PfAD25hnQJqXRXu215Mp6Jf1nMRzEvIDLdkuxi95aGy1ZzkoLWkkSkS69zYlkRP8m
         8OoSXZ1XVvxVVPSxINr6Kc0xKck+r1fpvXx87JvOA77n75iWltcG6q7G6D6mdcp/4xQP
         xXrIqo6hgvzhVb7yZNr5uftzs+r/rglko+1OCxekqc4mf9qS/rumNhGrRaQtGU2LzhT3
         Z0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224510; x=1756829310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7lnnKYGUwqSfcJFego4cSUIS6ucMudXKnod8NwY7i8c=;
        b=mMzcwEt/Dh2RBvxxAad18A0ywOrt6nWjaZ135YIJilpuHcY+R4T+1U/QiGvsps/Qgz
         yLPwG0lH3P1z//LRdgvhWYE2tx8CHcqBcoLgCO14Bc7+ny1h4Kgd5lCsCfnp76Cc/c32
         95BFcFJDcp6HLPOdyTJ/sJEDqc0Lz0uyEW/DtBYP9tRdX6AN5s+CltB0HRpoGw7wsv0T
         EjQ8HM0b7Vut72pYwLS2bkOp3NpVp5uOovwmmFCmQ+frCDIsaKXS+bM328N8TQCQOUuk
         c3IVNdcThqrkOYoEqsCRBCj0yu7TMpmJfs2piqXjXwIagORl9LHtur4VNjAzcXAp75T3
         oCjg==
X-Forwarded-Encrypted: i=1; AJvYcCWK07Hl84ucLE41IpvjyeWDb3uk2Z8EGjnGeU3l0Hhi87oIxwWZ8D5zapKCYblBz/TO/jXb1MGksf7qHKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5j2ABpC1pgzWTekP1un1tKpS0JOk3FJ12BGhDSWYjvqsrXn6F
	9xOTxZhvR0KhfmNOH806GRJmIC4dwrEjthgIZR+I+hkZ3988BM3ID+OUFzsFHdvfuPMw2WEREjH
	t8hHl
X-Gm-Gg: ASbGncs1KiBSUjboybZ9RMghv3vI1v0yJOdcLdIVg43kNlXDj0zxax3IcU4YXu/tkwO
	1copfobH9QrCvGWQAxLUmg7aj5ZZxjeaPWghwrQWcLKgAEYWb+eYs9QK+WyP+IdMn7FXl9TKkyO
	ymjjZRpaCV1HdVlJeAv1lV7M2oMpqn5km8oCiJJSxMHeUhwtoHftV5ZBJYNFJyUyHwTn1QxE2/G
	V84XmC3tggAZauXlO7McU/KeATT2NLT6UiP2E8s+xXg356sJimeH3K+P9hzCaMnPQVbSkigUKd6
	6r6vSevBh5UGn5Q5Rku+p7evWGmo1wgAmRJ+8oVH625JO/XCs+SRe5uOAqPnhTXJbN9dDJkasz4
	yPfBL6J7cUMzNIC88qDgxWadBNKoNGjEQlXxe7GHBtXTmdOejXOhvQ+W1lQ==
X-Google-Smtp-Source: AGHT+IHBymnkisdImbt15BBgGxtQ701XAL6YAtQjtL/ST2M9m9uQL0hCOlCTDLJ6oWSnx2iPq8/b4A==
X-Received: by 2002:a17:903:11c7:b0:246:d5b3:6303 with SMTP id d9443c01a7336-248753a2961mr26432485ad.5.1756224509773;
        Tue, 26 Aug 2025 09:08:29 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:f8d5:8589:bb53:d71d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3274fbbeb5csm1904203a91.12.2025.08.26.09.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:08:29 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: visitorckw@gmail.com
Cc: 409411716@gms.tku.edu.tw,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: btree: fix merge logic to use btree_last() return value
Date: Wed, 27 Aug 2025 00:08:26 +0800
Message-Id: <20250826160826.686111-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aKyVQRG9k/CboNRn@visitorckw-System-Product-Name>
References: <aKyVQRG9k/CboNRn@visitorckw-System-Product-Name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kuan-Wei,

Thanks for the review.

> On Fri, Aug 22, 2025 at 04:58:51PM +0800, Guan-Chun.Wu wrote:
>> Previously btree_merge() called btree_last() only to test existence,
>> then performed an extra btree_lookup() to fetch the value. This patch
>> changes it to directly use the value returned by btree_last(), avoiding
>> redundant lookups and simplifying the merge loop.
>
> The code change itself looks correct.
>
> However, the subject line gives the impression that this patch fixes a
> bug, while it actually just simplifies the logic. Could you consider
> updating the subject to better reflect the nature of the change?

Good point. I will update the subject to:
    btree: simplify merge logic by using btree_last() return value

> BTW, it seems that only the qla2xxx SCSI driver uses the btree
> library, and that driver doesn't actually call btree_merge(). So in
> practice, this function is unused in the kernel. Should we consider
> removing it entirely?

That makes sense. Since btree_merge() is currently unused, maybe it's
worth considering removal in a follow-up patch.

> Signed-off-by: Guan-Chun.Wu <409411716@gms.tku.edu.tw>
>
> Is the dot in your real name intentional?

No, it was unintentional. My correct name should be "Guan-Chun Wu"
(without the dot). I have updated my git config so future submissions
will use the correct name.

Thanks,
Guan-Chun

> ---
>  lib/btree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/btree.c b/lib/btree.c
> index bb81d3393ac5..9c80c0c7bba8 100644
> --- a/lib/btree.c
> +++ b/lib/btree.c
> @@ -653,9 +653,9 @@ int btree_merge(struct btree_head *target, struct btree_head *victim,
>        * walks to remove a single object from the victim.
>        */
>       for (;;) {
> -         if (!btree_last(victim, geo, key))
> +         val = btree_last(victim, geo, key);
> +         if (!val)
>               break;
> -         val = btree_lookup(victim, geo, key);
>           err = btree_insert(target, geo, key, val, gfp);
>           if (err)
>               return err;
> -- 
> 2.34.1

