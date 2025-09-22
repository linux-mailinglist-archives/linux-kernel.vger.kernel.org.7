Return-Path: <linux-kernel+bounces-826887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2E8B8F8D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724721897EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D75A2BB1D;
	Mon, 22 Sep 2025 08:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SH/79TpV"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547043009C4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529802; cv=none; b=Nxgac2g/DBg4+qmABHjG/74D0cDlYiMgszP1SxLd2jXYIPH4k/gwALXAgtUWq3taPzlaabYeMWplfoDnodkcV9+0K0d0E+AXZcgPs3KZyqaEnrQee5Gybxi/oMFjBWurYS0lFecRiP3zhzYWuHHNK8bL/CSIICqC1gUezBAPPgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529802; c=relaxed/simple;
	bh=9bIui4T4fKjYkvkbJ4kHDpDLL+A+t7pTNzTpq8o3nzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPr5cQLICV44qntGcHKya094Yk6C62z7Th+6SFVV4fZ5GCMiVXDKwfDVNgniA1woBtDPFiTSjye+6AEtP3lytBbR1Fy34UjokSrBb9G/R6ajibE8KQu2SVB9YJJkPZfQKNnf1vt3BpxD8iJsQn9kEj7Eyf4tLk5hFuw7RbxNKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SH/79TpV; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-57e36125e8aso741860e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758529798; x=1759134598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWul91Ypvcl4/Z8/7o75pIG7A+MoT7DTZL7QIYZ08GM=;
        b=SH/79TpV0IXp5G8GGIt37Z842ixiqQbT9JboI/qiE796NKB6SJ5PfvZohf+nnsNSfm
         V6niIjVHzOnW2rCBAy/A8wdlIzfKNoUGR+howa4oTETzQDvqhZQEU/LIc3QLmmrZNFZO
         NUGy4xh096i+LeDKjq6o3fIFR5wvrnqbnA+mbC8PpjS9/I+BNFu3h27Udp+tNfsi+1S3
         UKC1Yw1uWsXd7+XXmnPKaheL3yg7wFj2AstJmJJ9d4dgA8B+gjLbxcg4WiCoItctz3MY
         8OyvxkxkMeR1qVgMQ2pHWdY5WDxMHh6hxE6KeNvYPZuZLg9MHJh2YGcELXITiP4oP/7F
         WjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758529798; x=1759134598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWul91Ypvcl4/Z8/7o75pIG7A+MoT7DTZL7QIYZ08GM=;
        b=ERNSObDJWUHQCAtSBgGtixGizn3C7E3sIIFTHOTNtPlkx5pa6Fkr2tZqPBPZMHs27R
         a+3xRyIlTduH8gp8+zIfRcpHMIiNyX4Fx46+Z0J30DKHpHD9H13ex/j1RvxYoYMAEG4d
         BLrWMlQ2sqyQfG6LMYTi+0IfWTLpJ9AjqPmYO4nvYE9onp3QRKbGpNxNNE/7As5+EY9O
         TpBko7krXfo/ww6v2/m+vPFnKJzLVMMuaE0aijIzEDCUoBemWjxd2qms/gOU5gF8Cyv9
         AMVLw1l2QxHynGOn2z9OSVRWdko3Fw65QJstIlLaZJqrjT8mZI6GoQ0WORleInzsvQPr
         fETw==
X-Forwarded-Encrypted: i=1; AJvYcCVSjwL/YeLr+zkNkUY7viEGGQypQb4VEpBKuyqMypiyCPdqGeUvReClX1oztvaP5N9QD9fv3NdlhJUs8o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5q7edqtT16PlV40tXSeOPM++1IZ298gKbKlkklPnEud4dq0Fa
	jRQ8Lp906Qubzed7aAkwB77rYiqpVT8XIKBgneoMUsg2h1OayCJtpzBsywEHOlo79pMdZR+9C/e
	CnOWL
X-Gm-Gg: ASbGncttwKAdZ0/GETYfFL7arf9UHMDUmXYnSHqMoD5e5IEoVwTLOZC9vSHDK10YiF9
	gRTF7ZbdBYY6dR8NgjMWtjle1/KP7/Ygm+ZbhLExXg8XWlSSEbT7mJcrlTL/6/Z3GQuvwVI95oA
	6Lok/hiYrHxC6+Dbw/NiUG3JJTU4RABlknm+VclBPST3e+m29jwKq1UtSsOvIJObMEB5cPkBe3E
	Vqioct3trerp3Bykj73AvacPmOOdB1rzqy6ZGaOg5baVSAiANq6WFRSIdEvqCczWTnB97XPiZjR
	uSwufdqrEnzTu5+QXKpe9dujxN4GEJi58j7D2FyqIlT3SqsVm2EB+SR2M5su5CsxhpJNqs0cLQ2
	gB4dwEkT72Ae4L64X+qiOrZiB2Vpw21rPqfvoVAQSK9Nl
X-Google-Smtp-Source: AGHT+IHxaY0GwSB34k5+NBnTaegItK7TZCUiH69yPauB/fSzm2ILNNKQYpIgAd49Vk4qkxbTnJOrIQ==
X-Received: by 2002:a17:907:970e:b0:b2c:15aa:ff4b with SMTP id a640c23a62f3a-b2c15ab1084mr303701066b.4.1758529255122;
        Mon, 22 Sep 2025 01:20:55 -0700 (PDT)
Received: from localhost (109-81-31-43.rct.o2.cz. [109.81.31.43])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b29b80eaec6sm426411666b.87.2025.09.22.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 01:20:54 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:20:53 +0200
From: Michal Hocko <mhocko@suse.com>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	roman.gushchin@linux.dev, david@redhat.com,
	chengming.zhou@linux.dev, muchun.song@linux.dev,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH linux-next v3 0/6] memcg: Support per-memcg KSM metrics
Message-ID: <aNEG5W0qLPKKflQA@tiehlicka>
References: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921230726978agBBWNsPLi2hCp9Sxed1Y@zte.com.cn>

On Sun 21-09-25 23:07:26, xu.xin16@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> v2->v3:
> ------
> Some fixes of compilation error due to missed inclusion of header or missed
> function definition on some kernel config.
> https://lore.kernel.org/all/202509142147.WQI0impC-lkp@intel.com/
> https://lore.kernel.org/all/202509142046.QatEaTQV-lkp@intel.com/
> 
> v1->v2:
> ------
> According to Shakeel's suggestion, expose these metric item into memory.stat
> instead of a new interface.
> https://lore.kernel.org/all/ir2s6sqi6hrbz7ghmfngbif6fbgmswhqdljlntesurfl2xvmmv@yp3w2lqyipb5/
> 
> Background
> ==========
> 
> With the enablement of container-level KSM (e.g., via prctl [1]), there is
> a growing demand for container-level observability of KSM behavior. However,
> current cgroup implementations lack support for exposing KSM-related metrics.

Could you be more specific why this is needed and what it will be used
for?
-- 
Michal Hocko
SUSE Labs

