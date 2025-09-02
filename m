Return-Path: <linux-kernel+bounces-796048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F408B3FB5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDA14E3445
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061C2EDD73;
	Tue,  2 Sep 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SxJOqnhu"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B492E6CCF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756806776; cv=none; b=V0uTzN8nGsWbUygYIdhcZ7TqiQZlnoOmnZG7Qwu3DbkmlhL9f9lRH285CAKBd5F1fT1nN7q+3KQuyA+TI/fRwDx7/MoMrJoESeOwHislWh2xozF/Wm8XFWusowcAIVlDs46OBmHTPJWYv1nYZdtb/MpO6MRo4YSRVsdoRnNTaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756806776; c=relaxed/simple;
	bh=yJqygFJu86p3VvxR+K/6POaTs2Vw+d8nYAcptRFojbE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=miBC+5O5QQYXQzi2Hae0K/luMXFKdamAAmdqcR0ggJKaOnFppjvtQgtPgg/xmxgYqsDqwXetmEuphwa5iL2b4jfisAIN4hhsVxgyot/N8+GBRhMtkQk0kPEVB7UIBiV0h5fKltkWEakR2y6Wpy5eU0g/s5lrE6AhK8SV2Ri9fiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SxJOqnhu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b8af0b8deso11684555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756806773; x=1757411573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCSyoQoZCHpnltai8AjxVufHZRb5HZc6ehbijicV91c=;
        b=SxJOqnhuOY69i68atrPbmLIH1rJ7wGsjFmq0Xc0dvy/CwgPe7hGs2ys6KwtR0L518e
         2kPrOOjyirRwdqEF1VYCl4syCxqTtjB6e4t5c87iWkM8LAAltVMD3CXHwkUdLTlID4p5
         4uyfn4vn+WCVmkPobe+MKTt9pC3pxhFeA4dYuoejglBNfMg3YYAlemdgA2HfrzBlPVj8
         JwyCpkkXSM2XBAzYZcjqtAycOjobwqLmAPLRkpFmd4aRS/1Gb0LxIJ8FCYfaN5DUUzoe
         kNKYu4+2i12+H8O0kTLKxFPXIa1LV1zo3WyLjdvpEqFGX6k517c+s4s/2BSUAfbZxuDH
         fDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756806773; x=1757411573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WCSyoQoZCHpnltai8AjxVufHZRb5HZc6ehbijicV91c=;
        b=ucS1cmg9XYuMIrXz47wNYdiz8gAK0KJp/mfxSLk34d2JF6aqHI6CwmoUiKv6cw3vq4
         eD8QPMH2UCaKdfdqkfJVc+rT5rXJNkwA7iYEjgAWxSbjzJ/JKjnuPMu4vE1MU3LJd6FO
         EotljszGv1YAI0HLsMZjsCE1MydAnOjDJMIXdDT82afzlE9dzL/N+YmKAuQSrC4/C85t
         d2Bq5CJGOJ0hj7wqeF5X7OrNbIMpedQNyu2EwmvE4Ln2FhsGvQDDS7tn6aCEWOVVCjoB
         X8Gll2woQZvFIuuXMT0TgvFGepLRTsQdEJEiIWH0CBj2ZUUkKV9G5XJUOOnNwf4JiWAk
         WtAw==
X-Forwarded-Encrypted: i=1; AJvYcCVfeRfBCzxQqSP4OWNEW7R7JZTwEv/4SniIHdiRNf7e+NnLUpQyeR/BtcMXmKP/VUd1EaXnqpIbfod2Uvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRk7dwCr/7vP90fLgAScR6G2qkqSC0gDHoWc0IGHcF3waRhWX9
	oRsW0bsOz6GrV/76YQyftTM4t5tpmLTvpf1XdrmWpEzIgqzaA1bCh4ebjCLMBONOZ67eNTswcW8
	MbTRWGg==
X-Google-Smtp-Source: AGHT+IFhVx6/fp9bQrLU2+COALc3WyAOQyYyAQ0ATCo0PnkqRHubwOfZgEMWzw4a3O8baNUfr2wInNKraIA=
X-Received: from wmsz16.prod.google.com ([2002:a05:600c:c170:b0:45b:883d:4704])
 (user=nogikh job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1994:b0:456:18f3:b951
 with SMTP id 5b1f17b1804b1-45b85575580mr90608915e9.15.1756806772777; Tue, 02
 Sep 2025 02:52:52 -0700 (PDT)
Date: Tue,  2 Sep 2025 11:52:50 +0200
In-Reply-To: <345d49d2-5b6b-4307-824b-5167db737ad2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <345d49d2-5b6b-4307-824b-5167db737ad2@redhat.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250902095250.1319807-1-nogikh@google.com>
Subject: Re: Re: [PATCH] mm: fix lockdep issues in writeback handling
From: Aleksandr Nogikh <nogikh@google.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org, joannelkoong@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, m.szyprowski@samsung.com, mszeredi@redhat.com, 
	willy@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi,

When can the patch be expected to reach linux-next?
Syzbot can't build/boot the tree for more than 12 days already :(

-- 
Aleksandr

On 27.08.25, David Hildenbrand wrote:
> On 26.08.25 15:09, Marek Szyprowski wrote:
> > Commit 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT") removed
> > BDI_CAP_WRITEBACK_ACCT flag and refactored code that depend on it.
> > Unfortunately it also moved some variable intialization out of guarded
> > scope in writeback handling, what triggers a true lockdep warning. Fix
> > this by moving initialization to the proper place.
> 
> Nasty
> 
> > 
> > Fixes: 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT")
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> -- 
> Cheers
> 
> David / dhildenb

