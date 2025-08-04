Return-Path: <linux-kernel+bounces-755614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC63B1A937
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 20:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8B2171A2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6045422A808;
	Mon,  4 Aug 2025 18:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="19E5wnH1"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B61F1311
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754332285; cv=none; b=FLMn9KOQKg2uU28U6aCu9ZuqheSRgPDDuTD+qxufwlLgyWoSSZInC/4HrVqWW9gOIvBD+ImM9ZVlNLZo4xPyaojKI5xr9tDK+9uiozBgYIlKiP79e1MC218SZa4Yg8BuuaXDtjZLrh3YVNbwzgnZTNLEomm2EG0/HHUMKLKb6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754332285; c=relaxed/simple;
	bh=2ZVlhV6ndThCFd4+zGJNIWInZ4a60Ev1vYWmuIdzmJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ikmz0HzVOfoLqNW8+DYvygc6TTcyT4Nt3RVN6skv8oNgYxia9A9UuCX8dvrMH9/OkxEs/729jVcSt3PTJ08v+RnIyobYViFnGTlKb9Ljn232WlggI+4WBB0o40BpRDJPoZLZTQh1im6lrjTq8GgZxmrwJ+7S+siw7JL4aytw1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jyescas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=19E5wnH1; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jyescas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-237e6963f70so92499645ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754332284; x=1754937084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZVlhV6ndThCFd4+zGJNIWInZ4a60Ev1vYWmuIdzmJ4=;
        b=19E5wnH1xcWWnluOpw2kqQ5rHIaUPP11QZII2es13gK63dNEbQfPs7cbs9shqgmbIY
         HYKM3jhFZkbMTsEphYjdoBGcpm8pQrJX0tbkV4/ImrphGETzqXlNOFHL1hVE82FYPv5L
         n0xzUyhHUHVqB5V42dYZRBXfikrx4UxS/QeW1hRHP6AyD2rcGIeV+qefSq4Q3RF5h/vz
         kO+muXerE+vYSTo6ddN6v7yXWTlmcJzsMeV96VKcR1bFSMbHK7xEfT8t3E2WIFyNdIV2
         sDf77HhL7/uJE8zRC8Te0hAe42A+YTQTwkmKSLQ+4eQeizb35mTIhl9MfuG8vyAqCCud
         dnbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754332284; x=1754937084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZVlhV6ndThCFd4+zGJNIWInZ4a60Ev1vYWmuIdzmJ4=;
        b=HC7qO0NcqnRtdELsnMZIi7+s+mklCLmgaw4z39/OlMs38tkZZMYZVvn9tGOgop1j21
         Y/67KHMjoAuMx0yAVyctHmbtQhTTUiXcwO4rhQ0irnCk/+MBz2krWb0BApmWxR2ho24f
         e4emnSkrrA5RdrTRsCv/Djizty6xZobfb9B3lboNLJ0q5YIZHvglx1oHo82DF5a3gNal
         xzuuuBjXjH0C6UwsAuBTSI9ldXNR2FqzlL87upz0hSBKxo1+JGDsB0zTPJxnPJejtfA8
         BBPVcosBWZ7OzhmOZZrYZi6t7qPxvF6bfLkxNYibeOuIq837vYOvuCz3AZLNLGa+a3nn
         COsA==
X-Forwarded-Encrypted: i=1; AJvYcCU067Yg6SHy4vIVdrQcneZi/yej3Xc2LsYZ93yLJIX5z6MxZwyaj8Cx2i2pxmCKUk3644Yo1yzl26DeyJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRS+4D5B6b/pSWZLQt14adnWymS/PKrKYYyoYat+PZ4PbHk3dY
	hgpUKhL3Tq9surA358kS9T5KlVQF0KI6n4LIXam9s9Zt3oOBDmTb0Y5H3N07Bd2yf3vMMvGU+Tk
	R8GY3NEXq1Q==
X-Google-Smtp-Source: AGHT+IHWBu3VQz8pzZ+1rcfbz3HxJNSMQP0rdBf6OTWgijBCozRjoOUWrc/UH4pOKHcnDrH55Kq6u4Oao4QE
X-Received: from plgw17.prod.google.com ([2002:a17:902:e891:b0:23f:fded:852b])
 (user=jyescas job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d506:b0:240:52c8:2556
 with SMTP id d9443c01a7336-24247023afamr130598435ad.39.1754332283728; Mon, 04
 Aug 2025 11:31:23 -0700 (PDT)
Date: Mon,  4 Aug 2025 11:31:21 -0700
In-Reply-To: <67a54f31-e568-427a-8fc8-9791fd34e11b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <67a54f31-e568-427a-8fc8-9791fd34e11b@redhat.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804183121.2892827-1-jyescas@google.com>
Subject: [RFC PATCH] mm/page_alloc: Add PCP list for THP CMA
From: Juan Yescas <jyescas@google.com>
To: david@redhat.com
Cc: akash.tyagi@mediatek.com, akpm@linux-foundation.org, 
	angelogioacchino.delregno@collabora.com, hannes@cmpxchg.org, 
	jackmanb@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-mm@kvack.org, matthias.bgg@gmail.com, mhocko@suse.com, 
	surenb@google.com, jyescas@google.com, kaleshsingh@google.com, 
	tjmercier@google.com, isaacmanjarres@google.com, vbabka@suse.cz, 
	wsd_upstream@mediatek.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hi David/Zi,

Is there any reason why the MIGRATE_CMA pages are not in the PCP lists?

There are many devices that need fast allocation of MIGRATE_CMA pages,
and they have to get them from the buddy allocator, which is a bit
slower in comparison to the PCP lists.

We also have cases where the MIGRATE_CMA memory requirements are big.
For example, GPUs need MIGRATE_CMA memory in the ranges of 30MiB to 500MiBs.
These cases would benefit if we have THPs for CMAs.

Could we add the support for MIGRATE_CMA pages on the PCP and THP lists?

Thanks




