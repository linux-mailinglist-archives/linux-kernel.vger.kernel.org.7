Return-Path: <linux-kernel+bounces-818179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C788B58DED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 07:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEDEE3B0A0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 05:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8AD28505C;
	Tue, 16 Sep 2025 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McD9h3Hp"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907C2EAE3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758000746; cv=none; b=RDNT5uYgei/g7btB8oU84WHUdiJwUGBNArIsY3w0F3aBZa2q67Cw5SS291FPfhDkCx2vZAaNgt5OKQ44/SW8tmt4Tl5nUz2ipBFwtMQya31Anhj9NKXZLb0pYcyeq6qzsP5WICgZxhy+RTXxwKVr592OZdhP+M4HhW+sKoYDJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758000746; c=relaxed/simple;
	bh=blUK5lUquFXgyd/iFJfvn2Ge49c0E7Ce4My+ATYjKns=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TJmuihrqU9+VxqxEu/dST30duAW8UiLrj9Hc1OfEebC6MccH1Cb2T8JVX5U2YL8p8+cKzKAeQEP/47sUKSWiSTYz5Z8iPleq8F2aNwNlGlU6tdxIkxJySIYFq81/7hdwpl6jjUJsdi7QOlcbeiVSD/ILvtAo8bX5ug7nfLkef90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=McD9h3Hp; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b54acc8c96eso3373352a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758000744; x=1758605544; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6voqErnEQOmB44o/am2FrWyW/OWGShTujrCbNNtL5TQ=;
        b=McD9h3Hp4rMPMuiEZ8RMtMOdJzpf95PB+XjSG+JNcRkywcBFS5PjanfqtQ09W33ACa
         AYH25BgefeCMYa3mCXYkmRkZ5UnhyA74kYHf2R3zOzMQ5Jwz4Zctko33e7Y08FzKust3
         xK3rqq2YEyWtLr8bepNjcka6LQycj3zcK85EJkQOX3aDy1sjkP0N3zSwkw7NuAttiOkm
         A1moAZNrDaupD1beVGL/TwqP1cEf5ZEBYlDMG7UYUq8qZMJrZZjZ7ncIxzgUid+eBXwd
         hrYT1wgZdXL5uxmnPQLsSFCyZRexbx8+QF639BHPl2dUBVMXBZCqIBgCFp6AhRLFkgqZ
         +VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758000745; x=1758605545;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6voqErnEQOmB44o/am2FrWyW/OWGShTujrCbNNtL5TQ=;
        b=j4rDWlFv8FJKHFM09tNvqpvq5PvLScUmN/ncpy8IEfUmQhUS0hpdVmxcG4slnRu9Q0
         Tlc7irf6mZ6nQz90mK2SWNeVDbcewd/I3i+F1GX8NszsPxICP8grF6o5mxd0ZKfWq7+S
         mvVqGuVx58nHQeyGnyxH0TRDKgzgxCkoq7BNiRWc9sfRCygVDmpq23Mnw7KvFl1oWYdU
         tvqRXOQ3ocVg3eFrDcWgAqnHpAv4vNYOYeLtmV5mZUyVDsnEeygQoo99ccH+VM4RgN97
         VkoWS2pUHCCUdxJ5ennd5KpFW5/plPf56hMRBN1tzRhB4xPCoJkNOKBLirz3zZeTsDS7
         Bkrg==
X-Forwarded-Encrypted: i=1; AJvYcCWkrViWhSOCLyfNRnADAncG7dVrPAGXNI1B7Jw83U93X2QEoV4M7ek+skO1wkKwCQuT6JzhrW0I1RzYkpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqpCukj1MijjI6F/qBOqv+vnGkAne29pl28uTWveUDOHx/heL
	MKO86KU/rA5juwov9INHDfLbYTqZZgTK1RiHqO3uRfyfsCtcafu63stKPwlYVT61cw==
X-Gm-Gg: ASbGncsf4MiD+dGraNrgKnpyKmOs8kAZdh8+HL/cc2uEe/gbAc7hbUIUFIMxtEhOAlC
	7PSHw8qK8NIzt6D1kFhr4Wqqc/ddHzzgPt4UBVSOtxks0B8ScQKL39LN0Z+l4TGK1Un1HiM/uDD
	PDDyFHWA04OyLXXQYBmZq80fdVUQAb3U0W1xnddicfc3c42mFkViX7zZrKMMcxNbsOjSpgrVOxf
	g8DZ13yepZ6h8LcyJeVr9SpWIb4XsgfyWatBeFidx6B+Zh3z6z5FK2A8Hyuafcm2lvhDXV6jvjZ
	Iia1x5is2Ms3pB7+VVmb/ibRt6e2BgUKOOTzei7uKAi+tBklCpFaoWMvTPvLQaomeZdJCfPttT3
	tYQjuvlH5LdCSNYT5WPpINI+iQG7HuX+4tMaRJ+PYpy1u1V/cSZsEaV67jieQvQ2L+o5B32NFab
	BEFWamh+ASeI1+pg==
X-Google-Smtp-Source: AGHT+IEnkvhTw3nUkfiJeNmFc7oYbGNJ4HyrSkWvFKyAiuoLkwC1fVikGMm/aWV1OtdK1zVaOsSiEQ==
X-Received: by 2002:a17:903:950:b0:267:b0d0:eb39 with SMTP id d9443c01a7336-267b0d0ecbdmr33737535ad.51.1758000743957;
        Mon, 15 Sep 2025 22:32:23 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2647bf5bf7asm63906485ad.1.2025.09.15.22.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:32:23 -0700 (PDT)
Date: Mon, 15 Sep 2025 22:32:14 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Lance Yang <lance.yang@linux.dev>
cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
    ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
    npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
    baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier
 in khugepaged_scan_mm_slot()
In-Reply-To: <20250914143547.27687-2-lance.yang@linux.dev>
Message-ID: <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
References: <20250914143547.27687-1-lance.yang@linux.dev> <20250914143547.27687-2-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 14 Sep 2025, Lance Yang wrote:

> From: Lance Yang <lance.yang@linux.dev>
> 
> Let's skip unsuitable VMAs early in the khugepaged scan; specifically,
> mlocked VMAs should not be touched.

Why?  That's a change in behaviour, isn't it?

I'm aware that hugepage collapse on an mlocked VMA can insert a fault
latency, not universally welcome; but I've not seen discussion, let
alone agreement, that current behaviour should be changed.
Somewhere in yet-to-be-read mail?  Please give us a link.

Hugh

