Return-Path: <linux-kernel+bounces-786743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38021B367A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8539C8E4E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E081834F481;
	Tue, 26 Aug 2025 13:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei/5Q//S"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8834F461
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216334; cv=none; b=EidyQpO/Bzaf7v86Rlpe7lCi3U9KTYn2+GTWpys3iFwWrke2EXcIL1rDdfZ4YXdUubjM0mdyBl/pJLw405p0cNSKRLaaA2upCx/hTYQETXXDAW5yrnNB58wqqoDBWGhrD0gBXzrRGk/Ny+3punTHhcxgUoOkt0VO+kV3HTOI8RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216334; c=relaxed/simple;
	bh=nsAzEpREfyqwCalVLteglM2WEUudaalre2inaFCyQ1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBtptmRVOsXYv2nz2fBBTbqILog1pgt7hpHTaC0mqMJYgvX3QaGL48rGtpk9gySB3g1JzNdBWy9dM4+xmxgwiUniZi8Rn3ihvZVaKYIACwdtt16EpRliJH+jy1hMSseZbI4ubM/aVfntfXIWbdnbJcB5e7Q+ltKEz5tzEEH1fmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei/5Q//S; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c380aa1ad0so2860389f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756216331; x=1756821131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d0RJ5MIbPMLBw2d/Ope4l99pa6BtCCu8eU768yu062E=;
        b=ei/5Q//SzEhAuPIFbfhQledvPrcZpmjfXG5JbS5hjK081/4c1HAWotlgFdbHNjXJ64
         sGKP2qhjULJm/ltpb5IznJ9zJK/kf0E3+BGu/2rFcQJtmYlJJ4pAGkur15bG7oKfFB/N
         +npZ4McheCD7lmY91CJ5BbVnvBtv0QrjWcATUK31fCoU9zHDxCGu4zMUNfFPLZ9cEJm+
         2CIea7Lzy1V+CCMMBlOw2jaU43PV4OVU/vEZqBTDzkp+nEsShVhloguiXWJdDjsPkwZF
         bKvWITkuYbXIz6fG27fWaGCJfIJ0i3S+D/jAfqZm68WhQ3I1NHKdcwPC1Y0flRlO9GKt
         v8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216331; x=1756821131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0RJ5MIbPMLBw2d/Ope4l99pa6BtCCu8eU768yu062E=;
        b=Lx3kLe/hdpSBqOHO576XAYXvI+s+m63ZwfPlmgZHLE+n4paLqIDx6PzSqZQTMG0/Vx
         I25H7sp3wiDSQjSgiTbArTRv/q0qmacNwpYuDJ5jAxPXOzUcPV1eR7xm/QFmzeNwUwOE
         WWnD2sUInloHkIq04Np1rg4tPvGdFQ34Z+VMiSX+5pi/aL3uWqqe/Wbvt11HslTJBBB6
         zE9F1nubo+kyr2a6YDtPz0dq27hMIO1wHY397n5MMojq4RmBOMc9Oue2ZSSgwxFkmlcI
         63ZIFoZortYdbYBti0e0VWxLZGRTPLgaKjWAN3JaD1xq6bwZ1xohQRWHE6RkBPCodXyd
         g6SA==
X-Forwarded-Encrypted: i=1; AJvYcCXtLxr+rfIE2in0n9CO78FwTz6EQiTlyYLTI2x/KImkY+M8UOnIvifU+OL13eFgcbttjr2fT3CDVOpDrCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kub1SezD1ZHoh70CsJFrnezFEwMA9tPYu6M8K00JjosG4p1D
	l7eaqzCICC+DU3pW+9xQFichnKdLlYQGt9j1yNDbfwh8uIJi/zkZW1J2
X-Gm-Gg: ASbGnct3ZQHdLUM7x2yConMRVJeG8qi6J1SEs2DlrBsZl+cq+3odUL9EWF3KdWX8xlL
	ObNtra07EAFaLltwp02DZL04abPEpqs+t0EZ29nA4C+690QjtS3BrrLfzUGtkDMs8zTL9QOvoIz
	olugrGEylk2KyYWViYK4wUYKmRtaH+08alhGPwubk78Pjs6Fng5YKkN35Trjrwyosm40Dt3xbYL
	R2TnvIMlTw3kbd6p9A7y6Y4sXZOnWIJE03lZ8Dt6IBiE/VH6NvygwlkNT9k8yGddLzpnLSewq38
	h1u+umIZVE+1kdbr+q1TFj/A8Z04gCd3HyOvegyGKKqfvXP0OKSxBhZqYDTJM2zZMw9hn5a26op
	efiuV/DykAIdFhZvLXucnc/eUJnFdv+6K9Cex4Q==
X-Google-Smtp-Source: AGHT+IEjp2yGDtvnOY/+wJx7BwMFpeVlyxftPjDY2xU0V+FjBiKh1w46T/k9BNcNGen6Dcv76DyO7A==
X-Received: by 2002:a05:6000:2411:b0:3c7:c594:232a with SMTP id ffacd0b85a97d-3c7c59427c6mr8426437f8f.19.1756216330408;
        Tue, 26 Aug 2025 06:52:10 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:4::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b575929a0sm150127695e9.25.2025.08.26.06.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:52:09 -0700 (PDT)
Date: Tue, 26 Aug 2025 06:52:04 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <aK28BEMMelOAMi5U@devbig569.cln6.facebook.com>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
 <CAJuCfpFKNQrjtoctVt0N=r1cABeyPjpwrzP6M=OTpp1Rq_0QaQ@mail.gmail.com>
 <gxildlinmmimk7rd4olsz4rstsiapttbjbtbtzbekrmfxbvuhh@cmio2ckbyzxn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gxildlinmmimk7rd4olsz4rstsiapttbjbtbtzbekrmfxbvuhh@cmio2ckbyzxn>

On Thu, Aug 21, 2025 at 02:26:42PM -0700, Shakeel Butt wrote:
> On Thu, Aug 21, 2025 at 01:00:36PM -0700, Suren Baghdasaryan wrote:
> > On Thu, Aug 21, 2025 at 12:53 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > >
> > > On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > > > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > > > Right now in the oom_kill_process if the oom is because of the cgroup
> > > > > > limit, we won't get memory allocation infomation. In some cases, we
> > > > > > can have a large cgroup workload running which dominates the machine.
> > > > > > The reason using cgroup is to leave some resource for system. When this
> > > > > > cgroup is killed, we would also like to have some memory allocation
> > > > > > information for the whole server as well. This is reason behind this
> > > > > > mini change. Is it an acceptable thing to do? Will it be too much
> > > > > > information for people? I am happy with any suggestions!
> > > > >
> > > > > For a single patch, it is better to have all the context in the patch
> > > > > and there is no need for cover letter.
> > > >
> > > > Thanks for your suggestion Shakeel! I will change this in the next version.
> > > >
> > > > >
> > > > > What exact information you want on the memcg oom that will be helpful
> > > > > for the users in general? You mentioned memory allocation information,
> > > > > can you please elaborate a bit more.
> > > > >
> > > >
> > > > As in my reply to Suren, I was thinking the system-wide memory usage info
> > > > provided by show_free_pages and memory allocation profiling info can help
> > > > us debug cgoom by comparing them with historical data. What is your take on
> > > > this?
> > > >
> > >
> > > I am not really sure about show_free_areas(). More specifically how the
> > > historical data diff will be useful for a memcg oom. If you have a
> > > concrete example, please give one. For memory allocation profiling, is
> > > it possible to filter for the given memcg? Do we save memcg information
> > > in the memory allocation profiling?
> > 
> > No, memory allocation profiling is not cgroup-aware. It tracks
> > allocations and their code locations but no other context.
> 
> Thanks for the info. Pan, will having memcg info along with allocation
> profile help your use-case? (Though adding that might not be easy or
> cheaper)

Yeah I have been thinking about it with eBPF hooks but it is going to be a long 
term effort as we need to measure the overhead. Now the way memory profiling is 
implemented incur almost "zero" overhead.

