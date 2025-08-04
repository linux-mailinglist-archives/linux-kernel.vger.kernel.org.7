Return-Path: <linux-kernel+bounces-754929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F6FB19EB5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75ACC3B47D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12162451F0;
	Mon,  4 Aug 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fgwxBoeF"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCA2459F1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754299406; cv=none; b=VPnGJ4cAzk/jbKg7NYIjE0EcKaAVIiv98Jfp6AenkgEkdYmFmIu2bLIrqCacjay3tmyrP3IjzHDmEVE+A1ZcQ3BPHwi0d26fs4BCojPKdhgXv3Y993Dpp8mi3SKxAPV+1F+Ecao9Wgv+ORtfsrIEzR0N/UTBD0M0VK6m1GJjXFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754299406; c=relaxed/simple;
	bh=bl4pvcQ7PmhJNds/3JVxi4Rb+Sc6+NTkcOubu84sWgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3eZYh+ZHNUhyFG0ra5ldVALcZ5aTJze/LNRjObKD17NusNnO3nzBJKL8LuaynL0QWAvpS7H+dt96ifXcTzcb5KEJNBnuoMC9kGgwcK7Y5R1Jr6a2WsY3O9y/ALLpDOR+Po6XkJ+nLucz6Lt1vK8uNbIUCbh0Gi9v+WnZ72dJQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fgwxBoeF; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-459d62184c9so5819845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 02:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754299402; x=1754904202; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AIvooEURLKmBQsBvckse7hDqJtnWUv025cagmh0D7jI=;
        b=fgwxBoeFGUmW26aiIV4h+ZCJgXkdhWSs0qAPJjnqZx9UnMhJQZwiE3lFiSagO/Ss7u
         I6TSBADKo4RufTfr9vp/8X3GisybYy9UeF1A88H+/HpMA2PYv42XDTMDJ+YP2B7EtJXz
         IcHK/qU90Qt2s8Z6LcdRnXSwxlEFJGJozY5WnQqPWBs/zdtY0BCNkH7LHlHs/Z1NuCe1
         1+mELm5fXcL2K+F36Tcv9Xe+O8ZtYd5TRBKy74c1xD9SYzfdTJq+S1A0H7jHqPIpIURV
         Ypve1hXwnXUHAOBGzcsEqWBa4z0qu7qifNWbQ/CSu873oYhqaKgvw0oaAuIwFzLC3tgW
         NQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754299402; x=1754904202;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIvooEURLKmBQsBvckse7hDqJtnWUv025cagmh0D7jI=;
        b=DYNAumRXcnzzsiTvinaJ/1US+KNMiV3Eg0+QkpmtWOYqR5xDglpiWiZiQlKnZDjuYY
         QhpBco0IDrLhS7lchd6NIMpyoRQsewazgERsm5uwC7fMgb4Kodd3gUckJYm33Lz1LtxG
         4V9WGyzBiGx+zmo7S6Zgvt78IYeLEU4VLOXpbxrEVuyU9iDxZz5pjsGxmEeRpYGGaGo/
         6YGmQeFrBIylAw9IyaNpbP55lhHG+iTKlzkPL00/i+XS9h3+MlufPIiIy2gjfuLc39ar
         rctZjn0nsxusJDNaHNXe0cRW2dMGTvVJPRkZqjC9ZisTuaqnoAQbLPew+Xb3gUHnwBdL
         H27Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3TIg0G2VN7DT7Yv4ayeawMHQtxJ7jsz6wBwMTgyWHnSe5n801g3mLb4OqUAGrD6X6KednClDGGo+t4gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLWjrBoV3xAa2OZdiwC7sk5YSFoCTQNlprli4MK4f7zkCHp0IK
	xetJL8RfFRDaJgHbmuvaFUDiYsv3YVy0ySZQwpGN1LlnQoGAWO84NQyYRzzoFtb354M=
X-Gm-Gg: ASbGnctJZH6LoZH7wLabrb/Zrm8mBJeryThJ5qdKoFTva9ddvokJjUBhNtNzYNNL2qR
	lsFWHMF525LNG7UZE6vlaJVntbYGFnaG15sDrab1vGVPsUxkXGoYmNQKPjERQ3TExSSmhV8sGWG
	rdhNxM8ea4xjpaEVDwnKWJzfEPtRMi3CgAV73d/KWL5MZbo1o/MQcEMf0XoAxhdbhZi9EQMNwND
	X1Q6jjzIZZbgivDsLsYmzTXK2Emxra0XGwItz4BW0A0wnMlg6zq6gI0G3qWjcnciCq1sT0AUypU
	VoVtI7JXYwtCybpKY7YFS/NpgAPChIdCnGGRgWyJ4ucfkx3QfqATMFP9xxoka/xj0c7/AoD4q8/
	CRC0ORky+C6mIlSow8jsAYoExGi1QB2Atsidw31PjPGj8RNUrZdSYulYRCYm0sdsWS6vNYeH7EF
	t5qh7dT47FAjC6q2wpiZSR
X-Google-Smtp-Source: AGHT+IEasBox7LzLdn9lD/i3sfDKKBoMxY+rEAlISaXJV7oTeph6/hbIU7OkooVpBnih8ZL0dl9DAA==
X-Received: by 2002:a05:600c:3b9a:b0:459:443e:b177 with SMTP id 5b1f17b1804b1-459443eb2bcmr28240165e9.25.1754299402352;
        Mon, 04 Aug 2025 02:23:22 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-8394-58e6-9e1a-64e5-71bf-cbcb.ipv6.o2.cz. [2a00:1028:8394:58e6:9e1a:64e5:71bf:cbcb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8e054036bsm5016796f8f.31.2025.08.04.02.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 02:23:22 -0700 (PDT)
Date: Mon, 4 Aug 2025 11:23:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: David Hildenbrand <david@redhat.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, corbet@lwn.net,
	linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aJB8CdXqCEuitnQj@tiehlicka>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
 <9afd157a-296d-4f4d-9d65-07b89ab3906f@redhat.com>
 <2025072832-enrich-pampers-54b9@gregkh>
 <1bd04ce1-87c0-4e23-b155-84f7235f6072@redhat.com>
 <aId1oZn_KFaa0R_Q@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aId1oZn_KFaa0R_Q@lappy>

On Mon 28-07-25 09:05:37, Sasha Levin wrote:
> On Mon, Jul 28, 2025 at 12:47:55PM +0200, David Hildenbrand wrote:
> > We cannot keep complaining about maintainer overload and, at the same
> > time, encourage people to bombard us with even more of that stuff.
> > 
> > Clearly flagging stuff as AI-generated can maybe help. But really, what
> > we need is a proper AI policy. I think QEMU did a good job (again, maybe
> > too strict, not sure).
> 
> So I've sent this series because I thought it's a parallel effort to the
> effort of creating an "AI Policy".
> 
> Right now we already (implicitly) have a policy as far as these
> contributions go, based on
> https://www.linuxfoundation.org/legal/generative-ai and the lack of
> other guidelines in our codebase, we effectively welcome AI generated
> contributions without any other requirements beyond the ones that affect
> a regular human.
> 
> This series of patches attempts to clarify that point to AI: it has to
> follow the same requirements and rules that humans do.

The above guidance is quite vague. How me as a maintainer should know
that whatever AI tool has been used is meeting those two conditions

: 1. Contributors should ensure that the terms and conditions of the
: generative AI tool do not place any contractual restrictions on how the
: tool’s output can be used that are inconsistent with the project’s open
: source software license, the project’s intellectual property policies,
: or the Open Source Definition. 
: 
: 2. If any pre-existing copyrighted materials (including pre-existing
: open source code) authored or owned by third parties are included in the
: AI tool’s output, prior to contributing such output to the project, the
: Contributor should confirm that they have have permission from the third
: party owners–such as the form of an open source license or public domain
: declaration that complies with the project’s licensing policies–to use
: and modify such pre-existing materials and contribute them to the
: project. Additionally, the contributor should provide notice and
: attribution of such third party rights, along with information about the
: applicable license terms, with their contribution.

Is that my responsibility?
-- 
Michal Hocko
SUSE Labs

