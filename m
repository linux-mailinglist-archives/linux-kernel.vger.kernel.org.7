Return-Path: <linux-kernel+bounces-872981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D168DC12C40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578881894A43
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65F327991E;
	Tue, 28 Oct 2025 03:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mr0pPjTK"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF723AD
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622283; cv=none; b=MmfJ8NLuISdDkGDdIHxFmAZmJX/chfa4MSlkb5ShM5xbOqgjDi5kHDhUpj8Tv5ioKD/mMAZEHWnNoS1nj79zwDcbAHHS9dU2u8XAUq6f+mEW/f/VpgOYps4sKBPIgx1EpZg+/CRpFgsrXvQwo6hxAf3gV2QOz00dhJMmbO3eFcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622283; c=relaxed/simple;
	bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Njll4cR5Ue49qXwGWEx2qL1Y//HJx3kEqjjn19hi/Y3ChNMdsy8ULIP/RbEo6Th1iA1kRiOOuJIfpYo7pqoyqG2dZpH+23bG0kq8JbWufIXgVywztJXO2+JiYwlFWhKPvd+BDt7vGB3mLipKdNPW2m8iGisEedLI7xkt34zOfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mr0pPjTK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-292fd52d527so55057785ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761622281; x=1762227081; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
        b=mr0pPjTKpqmKglIs4NbjktC22qUtAQDnv5F7niBoXR9XL6cq0j8BGWDf1xYaQ4GzNp
         ZqMtTTTmHGkW8/iZTQR2hgm67vDtkBS9v//LIu7KXOPI1zV+hB8mEHSdopPUyvAcVWZo
         M/lxNmOSp4JvdjK/7ouP+R64DZCKANW/dXJI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622281; x=1762227081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/WJvY11yZe5DNuh0SmLl84KhyrfL2n7Y6FVCkvFsiMg=;
        b=DptBYdcTXJX9mw7ybHsWPZJPdcDj2TToShiAGjsKib5LvoXbHhQd2ecySUL3Kbbx95
         WI60yHVKH9p3psAEZFC6tMMRxV9ltPgNB8NyIwg5HjNjjx4RNGVSKhV/atHGkvScP4Qf
         C6c7FZOTdLjzl/r19PHNrV2vBP7bBatFRNYfGwQfuLuKj9r1/AjvOqIAllEoUsiNpXN+
         uB0nBIm4LSM+GNXaXT+89zT/HANEj+TPLGYD/M22jpd1OYUaNXLY3ZhXpMfpuMQNvL+X
         xB0RPFN7F6pWMTmvgxNbCnJ4CBBbORnCFU0F203Otzx6QlBxvuAYBHF+LlgqNhDo00EQ
         5DSA==
X-Forwarded-Encrypted: i=1; AJvYcCXHgtXE+WLWft+UJly+t7qT7Nb7QkJMk+bh2z7FaVeFmIj7LZgQnVZDG0YcrQLvYjdCQXN1CtLKCZSHedA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhTSBUGxEMyu5LZOG1z9xoytlzdohYL7mSpgQ3xtiaYxi4PIe/
	vNkTl0bpkq/KjZjpM8yqoCSUoi72jPF7TLjA2pLfS73sSyRXeKnNSexfjyDXtsKXV7liwWZBGK7
	azG4=
X-Gm-Gg: ASbGncsTj0AgSTeyaDhnEW56EeSRxfiUtLD2J3mpjpTzXCzGl80uxQkg4ECXdAJdiOL
	fpCWP57+PWCLOVMF2+auWCOVCodUzz8KZSdRRQM/AkuOtd6Ch7bu05HWDn91SQvQxBlbB7aylip
	DRc2VV/wWWHe+0Fq0nPu7gKzmS0sEtGrtzsjoSsI+QTw7TzkQbRyZ9ybuYlQNE+nPBHGAalja6d
	hGVsAJPHgw8iScrCXkfFQRKcD/gRJP6q5GzowO8b9ZMrHlASpDI9AhbhvE0GuMjqBNStQmZikUn
	30WzpLmunAMrF8lDqFWRqW9HYYGE1BPYcutosjIKapIjpvA1r4RrUiw5yP4nfJLqNZxKiyNar0j
	9SMqC/scLjV+Zycs/XoNdGLGRTkFSXDnZHnhhitxK7QECUOEA/691CjF1q81eiOPJHXxuKtzXAu
	Q5gPr7
X-Google-Smtp-Source: AGHT+IG4vfR0LE0WG8LCYJmEN31gkl7hCsYmhmgxpsNHn1XBOsYb/cbkA/Iv5cZPqQ3IQLRXV2PyoQ==
X-Received: by 2002:a17:902:dacd:b0:290:af0e:1183 with SMTP id d9443c01a7336-294cb6746c8mr22090685ad.51.1761622280960;
        Mon, 27 Oct 2025 20:31:20 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:2c65:61c5:8aa8:4b47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm100342125ad.6.2025.10.27.20.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 20:31:20 -0700 (PDT)
Date: Tue, 28 Oct 2025 12:31:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: jinji zhong <jinji.z.zhong@gmail.com>, minchan@kernel.org, 
	senozhatsky@chromium.org, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
	christoph.boehmwalder@linbit.com, corbet@lwn.net, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, axboe@kernel.dk, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, akpm@linux-foundation.org, terrelln@fb.com, dsterba@suse.com, 
	muchun.song@linux.dev, linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com, 
	linux-doc@vger.kernel.org, cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, zhongjinji@honor.com, liulu.liu@honor.com, feng.han@honor.com, 
	YoungJun Park <youngjun.park@lge.com>
Subject: Re: [RFC PATCH 0/3] Introduce per-cgroup compression priority
Message-ID: <4tqwviq3dmz2536eahhxxw6nj24tbg5am57yybgmmwcf4vtwdn@s7f4n2yfszbe>
References: <cover.1761439133.git.jinji.z.zhong@gmail.com>
 <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=MqsyWki+DfzePb3SwXWTZ_2tcDV-ONBQu62=otnBXCiQ@mail.gmail.com>

On (25/10/27 15:46), Nhat Pham wrote:
> Another alternative is to make this zram-internal, i.e add knobs to
> zram sysfs, or extend the recomp parameter. I'll defer to zram
> maintainers and users to comment on this :)

I think this cannot be purely zram-internal, we'd need some "hint"
from upper layers which process/cgroup each particular page belongs
to and what's its priority.

