Return-Path: <linux-kernel+bounces-736094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B898B098BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 02:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426F0587BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB51F3C01;
	Fri, 18 Jul 2025 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP66Bp3N"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48F136E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752797320; cv=none; b=MFGeNFr9GFfVXjbdhV1THQgud8IPgOnzPnAtoim5aHhqHaxJCyvqPF7lQsbmdEwuWAaD4XAqCq1ljSX+oKQPrcohLwaCVgP6dpq9V+ndmkugZ9XpnGuGEFuMSjO1GHocOXV+axjttuf0X96eZ2mLqOovsuy1Q18kbcR2sQliklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752797320; c=relaxed/simple;
	bh=JeY33aur8NgMXEsFc4tvFqJ4a15tPE7HFWKyBUtp0/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEduFM7lLQiPhAVro6G1wWYf0x/hir4/nnhUuMqi/a/x1te0tm+mBmXmX/a3dEfzHaLW7KaP55R1xcxCDiQtoYQj+eTWEznO45D3LF4j9KFfIKVA8oLW/fqUBv3sK8hxwKSWPC1fCaRczu/4TUgNKQbIsFD8Ty/pQvpBSAgzdx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AP66Bp3N; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso2875607a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 17:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752797317; x=1753402117; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhQi//tguIymHl7c4iQWzQm1A1yTH3/vuiNc90Z4NM0=;
        b=AP66Bp3NrpEdFa1nO+xQAxFCENr2VyzO5tORue+HGWHVnXWY7OPcVykErpDUweZSGG
         XoWACkyrD1W4988MLOQLrDX2VU2G3Z17UiBwNVRHQ3z7INpG4OWPsu8RKBBgdE5Upvt5
         RjkY1ATztZtSjvL8wVyVUcg86bFxAqXl/wy/DfkxZks3/mu565dUY2RjnNz4hPN3hjW3
         wPWeWIezIXQAxc/kQvO2pKlVjV4YRbvRgpB+MiX5zpqT13nLvLuvlZOezvjBcbRKoSyO
         sqOLgGeli9xpBbv0YYXSniX4yj/f3vr58uqSncbJBu05I4eCiumNbh+kdTOakc2xQ0p7
         y8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752797317; x=1753402117;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhQi//tguIymHl7c4iQWzQm1A1yTH3/vuiNc90Z4NM0=;
        b=nTogZOgVDuIdxnXLZH94x0Anie/b1+R9UvRqFHR3lKY8H+5K/89EPKw1EYrt7eV0Qe
         D9chzEKH5qzWfL1QTZowsJcADE5unLiBCMlpgzm9pCe9bByzPrDzXN3TFMfpdU62AULj
         Y/Ov8gs+NKBI0yNOH80kPSV4r4s5I//9m7r//3DIRz0onzes46bt5jK1SSdRsRS+U5os
         PTDulb0G8fD1IPEYlbUQw9ZwNVA/wgsNP8V3cBJvRzr1hFm6b/ftjFwL5xYZV1Kyq5ua
         KmNvLgZCP/secHt0pzxh0hry7uGhzQwl4VFsZhTjg8+08NgJpClh4xbw/avCNBIunLmO
         twLw==
X-Forwarded-Encrypted: i=1; AJvYcCUADy8fy0Hnux90fZ5ETRYGA7LDV/Y9J/QJ5uULsOtvQVb3M0uvopFr1FfY2et6mo4bPGlWKTcbe56dtYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXs3hq0b6v6fuKxYegi93abHRA4WgEyhp4+dABnlTtG6Py8Dxq
	qm5zbQ9+JmMoomTJ0z/1g+zDJZ9W4R0bHf6oGcyNh5yllK+1+8cxXN9pzew+sRO6
X-Gm-Gg: ASbGncux3907k1CQldJ53oQTZzMbCLk9V9lN9UEP1BROYbf95Y6Pqhs3OvoHIAZmmpH
	HbIYEL4ewu5nhN991q9H9Cpbc21KUix0f7s6B2NFhVlmEys0RD4JxyhlmhOfmGtm4qSryNggzA+
	FeV+Xw6DfmtP4U1t9g2nR6hNeo3TKtxgWeWDCLUbXTfKGTUy9QUvfHiK91aqq3ffBXhosxZr1QS
	KZD1emBvgDlAoUbriB4BE0DyXI+hMUm2+wb6sYSk9KV9VVDRjQIMvBzfOwZGhsDzeb9t5y03boe
	5vq9n7dje/O0N+x/qzRmgydnkdQYLsrXyZxrhIBo1JmneF9W+SN7Stye3Qql7LjZ4p7DB4vUdpF
	xNf55lmyDJ52S/6vgALFeEw==
X-Google-Smtp-Source: AGHT+IH0E1V1knOZ+5dV0lZMo0kAYPPdv19pRuoZvLCuPf8zsCs0bF50J1Farv8YsMqZx2u3MJA5lw==
X-Received: by 2002:a17:907:d2e7:b0:ae3:67c7:54a6 with SMTP id a640c23a62f3a-ae9ce07df63mr730619166b.34.1752797316567;
        Thu, 17 Jul 2025 17:08:36 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d46ffsm21159666b.42.2025.07.17.17.08.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jul 2025 17:08:36 -0700 (PDT)
Date: Fri, 18 Jul 2025 00:08:35 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: wang lian <lianux.mm@gmail.com>
Cc: akpm@linux-foundation.org, broonie@kernel.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, sj@kernel.org, ziy@nvidia.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, gkwang@linx-info.com, jannh@google.com,
	Liam.Howlett@oracle.com, ludovico.zy.wu@gmail.com,
	p1ucky0923@gmail.com, richard.weiyang@gmail.com, ryncsn@gmail.com,
	shuah@kernel.org, vbabka@suse.cz, zijing.zhang@proton.me
Subject: Re: [PATCH 1/2] selftests/mm: reuse FORCE_READ to replace "asm
 volatile("" : "+r" (XXX));"
Message-ID: <20250718000835.65qaxtwfgwborgls@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250717131857.59909-1-lianux.mm@gmail.com>
 <20250717131857.59909-2-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717131857.59909-2-lianux.mm@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Jul 17, 2025 at 09:18:56PM +0800, wang lian wrote:
>Several mm selftests use the `asm volatile("" : "+r" (variable));`
>construct to force a read of a variable, preventing the compiler from
>optimizing away the memory access. This idiom is cryptic and duplicated
>across multiple test files.
>
>Following a suggestion from David[1], this patch refactors this
>common pattern into a FORCE_READ() macro
>
>[1] https://lore.kernel.org/lkml/4a3e0759-caa1-4cfa-bc3f-402593f1eee3@redhat.com/
>
>Signed-off-by: wang lian <lianux.mm@gmail.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

