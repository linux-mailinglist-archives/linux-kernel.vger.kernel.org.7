Return-Path: <linux-kernel+bounces-727612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F04B01D06
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF14A1CA227B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FF27EC99;
	Fri, 11 Jul 2025 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A0FSEsNa"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8D7288C06
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239450; cv=none; b=UB3rAk1db+66R+125v1LIaUnI9c8XDmS8eNIuBgO+dMVjir190JquuoWxhR+Z5tBmZyliSZwnBKSxbRf/J8iSrh+iUFdpaB9JFhVpehiZanCi4R+k9N2ufCnmHEFebQZ0Hg5Mpjc37tAGBkNTYV1oG4xX7hfs90Y7xFTLmZIEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239450; c=relaxed/simple;
	bh=NVO1zCDHv3ROadHLdK6tuJ+N4zlgm56IubjILAS0Pvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqVgdEYrobKhgmrXYfyfJ3oK7PkYzY1c73dzYnrluV6OB7KhphFvoB/beEnxxtMP0/h0YSgIGeiUqwPyvtDLenBdDDzosMZa834g0cuRd6Yt1u9j9DfE5s5jqLdM6P2ABtdNeqNVwdHSfJhs8bVvhS6m424V3mQmQzmlZyTsOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A0FSEsNa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4537deebb01so11712275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752239447; x=1752844247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVO1zCDHv3ROadHLdK6tuJ+N4zlgm56IubjILAS0Pvk=;
        b=A0FSEsNaEy4W9xAXt+1JP6DRy3As3ecGcfCwvqU1pasFOTXXPPpGespkTCjQSwMdeo
         rhIsF8XVZZJrs7+jjcqnTZwdRYZ5lTF0fwQTLyeiUYS3HKJnJWdjmZNI+dQcy2z8XVsj
         rZncVDnnCx72vxa37jGbESghg1xElgcvAzyPjjQailpWvGGlaape2uZl4uJAvrVcCdtQ
         t6CUVi2HBRJVTXeQDpdJlxEFF2UTkgetbImQbS44CKUTp/BZzo4kNvox66YRx1EnnSIW
         Dms4sRYCAfe+9ddJP2MFJGChwQWMzxL6b+Yn1AkGvvIryTerSRtZwImpUzM00sey9U90
         0ccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239447; x=1752844247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVO1zCDHv3ROadHLdK6tuJ+N4zlgm56IubjILAS0Pvk=;
        b=obc1v1HCI55H9L7S19KzgzmFUe+d+XF0nhM8DSiN1eC33SFDvL8pdVHZpfK+ZBJppJ
         KToiMiHKYu4s7fU4WASArYWU6dbTHZRVtRNGPOj24wMlO/F+FiExKFAAlkbECzRcGint
         x51DTXoEczCvTBMZwc6NN7LXdOxApJNRfV/jTur17+99ItHkxXd9MKLdmtBuoJr2FWP7
         TctrvFZFTq80hgZIyoZ172qMHqzjMITMoSJm4SuOK3jvyfuGw4ozZWutwZbrTVEMUb5T
         0zQQKY34vREYQGHZrDw92A8XdbezGlhmMiDNBhim2Yq+TkpTZGXhvjB4wq7Vp9922Kyg
         +lEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd0Wwc2WFG3ix79Mu/b61Gp8sLJGaK8BeCiJ3zBcPie8WFWIXRSmX1YFnioYy+1qzQgmIVcwN1Q7x5AM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhVMznPxlZnDVXywvaXj5uPxgCSX8c0QdbE/ALKdfScAwaSZH
	jrn6RhjtVAh/AjTBVWOuM9CAvYjAtBpnl1b1gwlxlmnE0V6/WFaNZ4hRk5AEjR49NNg=
X-Gm-Gg: ASbGncuAnHNiF/IE3uEWoE0JcqriWOPU2JW4/XwTknGVZvZr5bbV8tPaUOYaFX1ocmZ
	diu+MjXd6OqRT/LIV6HZDlelv2Trdw1TjE4sYgRWy2/gJy4WNz8WtN1o5VWXpMB/SAqrZ6lNzsW
	uYIYaM/TEvAfptqHjjhIFBd8eqprzqZdWY1WTyBDMdJPftl+QDeqrssvoWVXaR9zW+ey0idD9Sf
	kupcLm+K0Pm22OD5FkpDUwmo46zq+9SHMBDRVOgRL5MICL8Ig42mOI7eWH3s2dDnCvq6Cn6KvME
	GybDMLl2QygB5cptRbUXE30IQVb5xw6J+nM4JcFZfXe+8ZxQ570TPC1tOE4f+yc7r7A9x5OdwdF
	esMkTZYzB2rL47r8ibRyMdyHV
X-Google-Smtp-Source: AGHT+IEP8mpu0Iuuf0a1ln8zktC/M79WYzkXuE4a7OZhLTCL2N1ClTroKbqdRnpP4IMAAWbs4Tnjuw==
X-Received: by 2002:a05:600c:3b9c:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-454ec13bf6amr28698115e9.4.1752239447146;
        Fri, 11 Jul 2025 06:10:47 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd47528fsm46969975e9.13.2025.07.11.06.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:10:46 -0700 (PDT)
Date: Fri, 11 Jul 2025 15:10:44 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Chen Ridong <chenridong@huawei.com>, 1108294@bugs.debian.org
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
Message-ID: <bio4h3soa5a64zqca66fbtmur3bzwhggobplzg535erpfr2qxe@xsgzgxihirpa>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-5-mkoutny@suse.com>
 <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>

Hello Ben.

On Wed, Jul 09, 2025 at 08:22:09PM +0200, Ben Hutchings <ben@decadent.org.uk> wrote:
> Would you consider reverting this change for the sake of compatibility?

As you write, it's not fatally broken and it may be "just" an issue of
container images that got no fresh rebuild. (And I think it should be
generally discouraged running containers with stale deps in them.)

The original patch would mainly serve legacy userspace (host) setups on
top of contemporary kernel (besides API purity reasons). Admittedly,
these should be rare and eventually extinct in contrast with your
example where it's a containerized userspace (which typically could do
no cgroup setup) that may still have some user demand.

So, I'd be more confident with the revert if such an adjustment was
carried downstream by some distro and proven its viability first. Do you
know of any in the wild?

I appreciate your report,
Michal

