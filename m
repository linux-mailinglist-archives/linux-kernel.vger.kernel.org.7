Return-Path: <linux-kernel+bounces-831544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EBDB9CF84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B725E326BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761CC2DCC13;
	Thu, 25 Sep 2025 01:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGwolgvC"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76010A1E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758762123; cv=none; b=cUFfb8nLEtlNgKlVVS2yMq0zanxSWzLQEmlTbA/38h5tYmWNrtPTX6kfm05bDw+cuUyX1wPQlpmLElGwbHKgPRnKxS49pc7gHAMNOiGMbE9k2JP9kDb9ZBHCyMSyfx4PSxSVRm+uIjevHdjpK4rm+TbBhkWGYg7h7I4x/dGTP84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758762123; c=relaxed/simple;
	bh=mKHz5g2SjRx6/2pB8T1HWNmTeW2hLBk/2LihIWitt70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP6GZMfVudVvrpUORypcMWuewRgXnVFvS6I8CvWpCtiDwaWFhL1HjXodg0uW7LcVH6MxaBgjNh+gawhraZCfgNgVRblpbL28UDGr4PbJfcZy4kHBvXygln4FlWdRQIjeTsr+1uyEGPxb7FE3dWM0BS3gEcx/O+0MQNLZA84DVxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGwolgvC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b33d785db6fso78754466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758762120; x=1759366920; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UT/fz7W2Q59V6JjyRJ9jtQEWf+zMESy3JFVBEjGnVz0=;
        b=cGwolgvChZ0TBeAZVe312cwlgfrrGpZ4r3AOJzWYrXrrnfDgYQuIv+kof2+AiKysTm
         2K1lcPPdrrOLuQWnOFkBONhmLEnbXPjfxFCtGJM4IgtkIafgTcJmQCw5g5UcaR5ng0kh
         1a+jndEwVRXi0ZoO28p9jLpTbUGvCxTlOopEfhBMQjg5zdMBJCUFesgva8ImhBwXYLEY
         BaEJCeAgEEIqqhQueW0z0EERRTarajfXxUO7/qMvcmz3HpqQvmaFV/gHk/xc/42CvZFr
         t3nBlgu06exRYQg5I3KgqNmW2rtBvPuBp3xKy/QqE/1KgER9myu1ZM6RweVxGyAkkKHC
         7U4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758762120; x=1759366920;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UT/fz7W2Q59V6JjyRJ9jtQEWf+zMESy3JFVBEjGnVz0=;
        b=Vea7sO5P2khWqbVBgmccBXKDYhoam5ve0vGF5tMFTt4l6EEVfuTT00h3tZjZAHWrAD
         sEujW8rHzmjpvLMO8RHEyffAPrQVJrhTl1Jbg4C63RNLV2gE87sv3DbptBYnw7i4IPw0
         mManmrt8D48/r7xI7KyjIZZZX/fP9sxrGW1CPIXbUtHkmTJw3owJepudkxhxAdrURzpT
         mr4LCkc5hHpLbR6qJGBwnxnSHzQI37VYJvupsZM4e5XAUX+KZe5Ld8S7GW2SS5TDWg0d
         hES2d487nIBx4mtVYDVIQMJ6XPSEVXeM89lCfA2I9SNVAUDOiZ3yQ5O5GVUvwCgpcnk0
         kuGQ==
X-Gm-Message-State: AOJu0Yx8DMyCRS8BC+rsOlWF+HbpuIoIL7Ef+CzaI9j0aS3ETCS8aBMN
	kny3lRiV5ouPUqyntSbbNiNYidpn32abI6QUAarWfFM41LmR24PhDW9K
X-Gm-Gg: ASbGncvb9rzOC2ynzXoXYd7orBKnZSDgzdb6Xri+anyPVIvxA0CBwivFb3cfk4M4RVW
	m4JTnRzX63PleNHcNNab/jTMzbNSKDz++3x7Np/y6R+ZFlq9QOM1blFxp775tje4qSugneLsYBD
	buhs2gsSbKlDEf8K9d84LddlV2C90lNigrp5q82Hpw/TzNKs0L41v5LRAQlfDDly2hTKDJSEHbw
	6pKjnBmxf6vhL2puSSeuNc8/2Ws0uO1ie8fQuOY9bdDYWrfhx5+D5BxH/yFrsrNlKPkmYrvzZAe
	YURjfnprpMWqGGkhCeEJ7tTi8z2XvVQBhNiVxMq/gasWaC9exFrYn5/OCqZ7ieNm3xlNXzVu+GZ
	BfsOLDXUD8fvdw0C+NwsRwg==
X-Google-Smtp-Source: AGHT+IGSwVZwfkijJ82DMmOlzOe1J4ZJJFXvzKoeU/M4Yrgt15c2Zwukdh41qG56Hw5/4H7YE2VnSw==
X-Received: by 2002:a17:907:e895:b0:b24:6e6:7117 with SMTP id a640c23a62f3a-b34ba93a185mr185900466b.32.1758762120190;
        Wed, 24 Sep 2025 18:02:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d155asm53519466b.6.2025.09.24.18.01.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Sep 2025 18:01:59 -0700 (PDT)
Date: Thu, 25 Sep 2025 01:01:59 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1] mm: convert folio_page() back to a macro
Message-ID: <20250925010159.psdey3tir2wvlnoi@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250923140058.2020023-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923140058.2020023-1-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Tue, Sep 23, 2025 at 04:00:58PM +0200, David Hildenbrand wrote:
>In commit 73b3294b1152 ("mm: simplify folio_page() and folio_page_idx()")
>we converted folio_page() into a static inline function. However
>briefly afterwards in commit a847b17009ec ("mm: constify highmem related
>functions for improved const-correctness") we had to add some nasty
>const-away casting to make the compiler happy when checking const
>correctness.
>
>So let's just convert it back to a simple macro so the compiler can
>check const correctness properly. There is the alternative of
>using a _Generic() similar to page_folio(), but there is not a lot of
>benefit compared to just using a simple macro.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>Cc: Vlastimil Babka <vbabka@suse.cz>
>Cc: Mike Rapoport <rppt@kernel.org>
>Cc: Suren Baghdasaryan <surenb@google.com>
>Cc: Michal Hocko <mhocko@suse.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

