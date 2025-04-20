Return-Path: <linux-kernel+bounces-611808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C669A9467E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 04:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112C27AAB57
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Apr 2025 02:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D5E3D561;
	Sun, 20 Apr 2025 02:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faBJtjaM"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5E6134AB
	for <linux-kernel@vger.kernel.org>; Sun, 20 Apr 2025 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745117218; cv=none; b=vARFICdwR1xEII2vVX/HABfH7ECFGXxRDxl6srWQ+OJRX6UKjeHlgpxfSVwr1+PcjkRFZLeB+9bAHzFTaXNWixJdOUPAY4H0LCqDhpit5uBEhtsJSKil4+QGO6uh58GbWHcuStN98b6AulDW+cXON9q+El1F4W3Jy754j4msguo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745117218; c=relaxed/simple;
	bh=RX0DQFLGP/0iZh+sJKoEjSPI1MNZkBbZnzHH1JstofY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AwpDpURTotvt6CQHT6cfT9ORPi51x6qW5w6efc3joGNcloX6taNfH3XJLp5NRcvYJnoCvzrV2QIytIjFzQzp+8CjS7IKf/zWXeQvgCPJw2ymwYX2EgVmC3ReygSj0UJH55BicfXYVXWSRk1plVDTK0WB/kKYOALyFtJXUjLd3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faBJtjaM; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so442545ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 19:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745117216; x=1745722016; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3AbfIt9FSCD7UR2vpfZ4Tlq1YzE8cazt4gjeig26RE=;
        b=faBJtjaMSrUSKCe10NPeozAlndcHSIMq01dEyqNwybVZI4TVchyAKMq9KepB/cRgro
         H9VHn040QOBWCnROzc3pF0SwiQ0SrisK2iEupvnjU4ER0oAqRtBTxnmD1dHVkGzIeOr5
         cX3TebRfcGMqRhLY3nyq9xxhzccvRLybI08pl/+ri4N4rNlhLTlPENR3OR7sjV366aPT
         5WP0rTCrnE1EqlvnFhTYLr5FThdpbYgR6QQIloDu5MBPFla4s0mTAVGdUK2skytMf7jQ
         44wNOWQJkfGR22vfCQrTa0WKSfreZiGoPT4SqkHMJDFZewzf1yEIyPQ5yKR1BymI6VIi
         GKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745117216; x=1745722016;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3AbfIt9FSCD7UR2vpfZ4Tlq1YzE8cazt4gjeig26RE=;
        b=L1NKLLkD2911YJgqbiz50Jz7k7vXC1jc7RUASHRf8FJP7moQ6LlW66ZT1lLYnJmZAk
         bpz9qBj5GZy3/gwuGBcpJ+tV8Sqq3DEpcyWR3ErdUUzjDxV9El+/kKvus4324z9FERYJ
         L+K+GbNrt78/quaS0v+zPvkVgU+k0h64/m2GkgCZZnfobOPA2O+f0BVboiuSxUNsxUdw
         Y1tsGodUDoDVm8F1pP38wvj6QnYZ/qwOKzo6VpBMHrYhi1vUMalbr7OkUl+sVukrjUGj
         GXKzLFOJbFcOzsNGPt/D2mAxtD9h1GhcU23E5b91OfjhXD0dDpmOSEmlrHBrbczuVSIB
         qJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDjGyHQbsYDeDLgrdD0W06ivWeIRbYpO9WWNnLTxAX6PckjQBvDQE9q89KxoMBY+olJKqtLxriZqqlxEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcgFH+kOev0Z0hXXj5ZU4yxnQLsy2eTbhNyR1Yp9MitjCAVob
	lFTypXByJTsT0OPVHxLqqP7RRi7mnuI/XHTCup62jaoxwzQu45oH+P+1qLLvTw==
X-Gm-Gg: ASbGncsheT7xqIlGpOHZDfRwSnxZHVlz9DysI2xcanuqpJ3L7epMX1VSxh9f0mMAjWu
	hHMI2hsfImbXbRghoerCYINe5Z2Su44JhQ8R1KCMoWj87xneWYRfdxj9wcKJS6KIxbmW8GGW0qL
	lWtNRBlCpNigDfXGIVhDJvYCjFGd+k2T8LkWC6JvKA3LzokP9HhP85xC0z8a3SweOw8Fmxbxe7S
	bD+1MjAqJldrgHkrMp+LlOXqIIyPYQUwZHVqqM72uzF/qoh2EgCSBANaU7BaVrUcuFe6RLDdZPQ
	i1OWmh8JVWX7to41DO/+NqDxBSRVHAIhTEuw8oYp3lTp8kRy0g8zvtoVuI5bB5HiAajuv+6kAvc
	ImbGYGgLBCEgxl9QyK/nst7qBXPHHayT+1RY=
X-Google-Smtp-Source: AGHT+IEB1MivelMqBg7qBRIjgszdRZKSAAXNwNwBAgpJqNtqVqVuwjKnA+G2zTtSG4iwngyXa2WwIw==
X-Received: by 2002:a17:903:3d0d:b0:224:6c8:8d84 with SMTP id d9443c01a7336-22c529e6033mr4798395ad.4.1745117215563;
        Sat, 19 Apr 2025 19:46:55 -0700 (PDT)
Received: from [2a00:79e0:2eb0:8:3e8e:d566:514d:339b] ([2a00:79e0:2eb0:8:3e8e:d566:514d:339b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df4e15asm3841408a91.36.2025.04.19.19.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 19:46:54 -0700 (PDT)
Date: Sat, 19 Apr 2025 19:46:54 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
cc: cl@linux.com, vbabka@suse.cz, roman.gushchin@linux.dev, 
    harry.yoo@oracle.com, surenb@google.com, pasha.tatashin@soleen.com, 
    akpm@linux-foundation.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH] mm, slab: clean up slab->obj_exts always
In-Reply-To: <20250418061459.3898802-1-quic_zhenhuah@quicinc.com>
Message-ID: <1b517fe3-635c-6785-886b-6ad38f4de11a@google.com>
References: <20250418061459.3898802-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 18 Apr 2025, Zhenhua Huang wrote:

> When memory allocation profiling is disabled at runtime or due to an
> error, shutdown_mem_profiling() is called: slab->obj_exts which
> previously allocated remains.
> It won't be cleared by unaccount_slab() because of
> mem_alloc_profiling_enabled() not true. It's incorrect, slab->obj_exts
> should always be cleaned up in unaccount_slab() to avoid following error:
> 
> [...]BUG: Bad page state in process...
> ..
> [...]page dumped because: page still charged to cgroup
> 
> Fixes: 21c690a349baa ("mm: introduce slabobj_ext to support slab object extensions")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>

Acked-by: David Rientjes <rientjes@google.com>

