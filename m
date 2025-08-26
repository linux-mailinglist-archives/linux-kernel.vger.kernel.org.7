Return-Path: <linux-kernel+bounces-786764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2E6B36859
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74DB1C27F32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2561F35336E;
	Tue, 26 Aug 2025 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Unj1Lgxq"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4092B9A7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217181; cv=none; b=NW9zj0N/bnlF5JPlgZn+WVE9JRe/7SpqlS+2zMjftHfTav0W5JXBqbGPF+emEJfDTSyUZJMuM9UwKvzCWTKrD8CtYJ6hS0VwHzVwrUVcf+Ac+leHZVnPemhyUdA2qeaIZFIidO4/GV7dqhiGDFyD7Qm5O+Ov3+aiRyAgkYWiIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217181; c=relaxed/simple;
	bh=QCj1Vvy93yZ6bsOTF4xxqJ3kzTZvrOBpLj0CgeZABsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0L+IvNBlEt5Q9qoakIqMozdARSodBjblfaJ5kPItELYOQiBO53fLIkufkh2wzq52MT/qsD29jughurKfDDYvLDfVMfRQngk850PFqgMb/prTXWe3qzOs8N4OGfbUR78U5J0P47bnxTlxeGLBatq/ikeR3ozUY73jyeUqTcfGlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Unj1Lgxq; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c8fe6bd038so1199747f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756217177; x=1756821977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlKAEubDhdWXLTp3RgKe1j2zx0nuB/WOtFKlQ/1PMDc=;
        b=Unj1Lgxq8+/y/hTGhM+CD7PeRVtaS2/BUZQLri6Iq74SYmtwcaJNwvowGwIRQlWXFN
         UoUB/ruGyeG/n/dnNAQsj2bJgS2lsga5KAkF5wvl5BI/JTBGqrv2ri+uV+evwOe2vc5w
         Deiu/1FU3w4A97hvmseS/5mPQHSa/Mdgry4ctt6/5PO0e4kU26UGw3jun3tTmRBhjty5
         Wt6JyQ58i5iGcm2FdgZzauM8QjOwrmvJnBMShJTwvwWEpXeBs4HzI4z11jOdKn6lKUFT
         tp6N2n5nR34ODJwIunxPM7dqo7JxepuiiidwVnxZ/FqxWHGyFrrhzeaajNbwn3rJT9Q8
         ZqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217177; x=1756821977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlKAEubDhdWXLTp3RgKe1j2zx0nuB/WOtFKlQ/1PMDc=;
        b=tXLvJXn0qwj2xlTzm1rjIEDNVxfd1A5nCVol/VAjPnSeuIQZJf8CZK4rpBGD58+3gF
         wnrgrewH5qaaau0iIvL38p3UWWKYMCwWWZqNjc+hekDvF1HD5onlK0zvBYGUbqKPJ1R/
         6Mqia+Xb7VyLElnppoQe+suXDamZ92an9V3958xIiPI3AMJlO/vzEm6NdWDrtWfW3jYQ
         JDdpT+RD3fH+ep0HoAxsb3IyT1lsPAYpdvtFpFZZy3HtjWkaoHuC1ePuIe2dZdS0mewV
         Qqsk0r3yg/MIiuPmF6jW7L9xmV99a5rfwyOwnn56sohf9dsRaphvT7Bx9g95mCTqM4Mf
         vW+A==
X-Forwarded-Encrypted: i=1; AJvYcCXS86HpUwnZ0/+pHHA1Qn0LVaHSAu4P/4mR1zvkkXFL5bOwWnKJT7NsnN2es3wL/QurI1VCmuw1j4FtE94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWgnSsSNg6DzOANC4V1xrb1DMY9pwfJy8Ku4F5NGW9/Ga1/b4
	adzXmV+cSesUAuWRjOPplBIp536Rqllqkdrs8Pvlo2M5ff885VP2rZuZ
X-Gm-Gg: ASbGncszSS7nhdqdzawFmCWB/c+lArWE8fB/RTFdDocENidXPDJE9YvXV2NM2Y9xReS
	piwEP564vUPpMnb50DeP1YpGG+LpHKXlTRiLSZAm84SW1avqXam3oANG7ytzylTpinkR9gtF0XP
	kYJiiZDyQOeVNBx52cqie5MGKZZz7z5ZfQasZBe7vjHDKev48rCnGC3AWB9MyUVWCXxP2Nc/zHE
	mAY8ObrkzMDqvkevZWPBbgBjEy81y5k1Q2By0B21oBUi7YWCZmx53ltH/9r8der3MPwmL8A/Miq
	iywWilCukcdagjyeLQGeBq/HOoJaa4Q7Yw5JZlKSY/sJe2rrReMeZkjTMHEQiICwrJkQNfn2CDz
	yjvpOcjIvSnzxfFVX3s8JwGCkyug4ICIz3zRVNx0=
X-Google-Smtp-Source: AGHT+IG22gPI5488uIPs25oszBDX56Yi53KPVP8VjvbYnpIG7qN6HDEcXj2kkT7vF5pcH3GSgehc9g==
X-Received: by 2002:a05:6000:1446:b0:3c7:f0fb:834 with SMTP id ffacd0b85a97d-3c7f0fb0c5amr8807636f8f.42.1756217176808;
        Tue, 26 Aug 2025 07:06:16 -0700 (PDT)
Received: from devbig569.cln6.facebook.com ([2a03:2880:31ff:54::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c712178161sm16263514f8f.67.2025.08.26.07.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 07:06:16 -0700 (PDT)
Date: Tue, 26 Aug 2025 07:06:13 -0700
From: Yueyang Pan <pyyjason@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/1] Try to add memory allocation info for cgroup oom kill
Message-ID: <aK2/Vesgr9Xcl5gy@devbig569.cln6.facebook.com>
References: <cover.1755190013.git.pyyjason@gmail.com>
 <6qu2uo3d2msctkkz5slhx5piqtt64wsvkgkvjjpd255k7nrds4@qtffskmesivg>
 <aKdw6Pkj2H4B6QDb@devbig569.cln6.facebook.com>
 <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tiwa6wnkdf6q2pfchxbbqb6r42y7moykqumvnzauckhavyemg2@zc5haja5mlxs>

On Thu, Aug 21, 2025 at 12:53:03PM -0700, Shakeel Butt wrote:
> On Thu, Aug 21, 2025 at 12:18:00PM -0700, Yueyang Pan wrote:
> > On Thu, Aug 21, 2025 at 11:35:19AM -0700, Shakeel Butt wrote:
> > > On Thu, Aug 14, 2025 at 10:11:56AM -0700, Yueyang Pan wrote:
> > > > Right now in the oom_kill_process if the oom is because of the cgroup 
> > > > limit, we won't get memory allocation infomation. In some cases, we 
> > > > can have a large cgroup workload running which dominates the machine. 
> > > > The reason using cgroup is to leave some resource for system. When this 
> > > > cgroup is killed, we would also like to have some memory allocation 
> > > > information for the whole server as well. This is reason behind this 
> > > > mini change. Is it an acceptable thing to do? Will it be too much 
> > > > information for people? I am happy with any suggestions!
> > > 
> > > For a single patch, it is better to have all the context in the patch
> > > and there is no need for cover letter.
> > 
> > Thanks for your suggestion Shakeel! I will change this in the next version.
> > 
> > > 
> > > What exact information you want on the memcg oom that will be helpful
> > > for the users in general? You mentioned memory allocation information,
> > > can you please elaborate a bit more.
> > > 
> > 
> > As in my reply to Suren, I was thinking the system-wide memory usage info 
> > provided by show_free_pages and memory allocation profiling info can help 
> > us debug cgoom by comparing them with historical data. What is your take on 
> > this?
> > 
> 
> I am not really sure about show_free_areas(). More specifically how the
> historical data diff will be useful for a memcg oom. If you have a
> concrete example, please give one. For memory allocation profiling, is

Sorry for my late reply. I have been trying hard to think about a use case. 
One specific case I can think about is when there is no workload stacking, 
when one job is running solely on the machine. For example, memory allocation 
profiling can tell the memory usage of the network driver, which can make 
cg allocates memory harder and eventually leads to cgoom. Without this 
information, it would be hard to reason about what is happening in the kernel 
given increased oom number.

show_free_areas() will give a summary of different types of memory which 
can possibably lead to increased cgoom in my previous case. Then one looks 
deeper via the memory allocation profiling as an entrypoint to debug.

Does this make sense to you?

> it possible to filter for the given memcg? Do we save memcg information
> in the memory allocation profiling?

Thanks
Pan

