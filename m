Return-Path: <linux-kernel+bounces-746149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D54B123AC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20194AA5F85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E00233D9C;
	Fri, 25 Jul 2025 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBgfdy1K"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFCD8F6E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467469; cv=none; b=kmaYQ/RNLbKdslxVozJgAKp8ygy5LOuVoSIJDCLNIfaVJ0hetEyr9ilKGaxr+NS5R3DfJB4n6kJ69k7aWL/2piSSZMNCK//AfBMSP7XJiUJK8NpRpUvA1zqSjsq8NT647GcRuJ9adcDqq0tt26+9WRWSSrIE6ypQnSBWPisparc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467469; c=relaxed/simple;
	bh=nrPdIgDKLj/mpAIfTARNhw3eqSfvxtYnXEcqZbCDtjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3VM5u3UVpYnbmfO4l8QUakvsSgaP/KwDK6/1FNqkwp4IhGfAYSVyv78ElbGJ2G93WaPRTI3hMv4jZndwBNAgIzcEazq9n9VJ5AAbNssyPwM9Oi+dUQDGL7ZUEKtrO5Gs31Z2A4GSQG12kKQy3ud0NOODE9rt/XXcTU0y5hh6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBgfdy1K; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e5e6ab7b8so22811557b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753467467; x=1754072267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeM7IuoQIkUR4J2lJM41mRdSF+EtBai/uwDsajCHaho=;
        b=fBgfdy1KUZHVgzza7Soy0+5QqTOWuJ0TrAIT2eKiGAXL4caKj46RaFZ+24N1aqg/7/
         GlDo/9F+GYQIZADMuMiWo3zPWsFSMqtxqJEd7+lKD//gxiTOK/aWlIBeDTKoWr9M6koo
         sKKJjUkePfB60A5baTA7FKV6Vx8rtT+wghxICYL7+GInxTcOUZROMjVgZrKMcTd3D3wX
         COLOr8DqWWKC/sey+GtCuVPAiC0eMTlU71Rl2XvIiX5p+/CFXB0rTPOmgewKc+qBe2dA
         Zg6VOeUaic5BUL3lXXyYejz3n0gEqfy0I49AsKqR8H11WkCySZbn7rANjAnyXVUTwAFw
         Ue5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753467467; x=1754072267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeM7IuoQIkUR4J2lJM41mRdSF+EtBai/uwDsajCHaho=;
        b=TtiLexoBJsefHLQCCVoAFnT7hRAHwOWvJoSlwmXa6g5sMHZt8axpDqUXbtHhgCNub4
         CTik5VJFHHI2hsuo7ypYtp05M2wFFeQsSac0SLUKwXHo0iiM8smkL2SPODSghRFKtDz/
         IIxJKahRlEvZMBF2EGGRukQHYgHMS+a1XlezdKQHAHDqSKOarMWxPHn5JO7ujqUSCnxP
         jtUcgwHPzbm5fjAdzFLLMg/OCucG91jRHhzQUUJW0GFwCfEwhgnE74laHgLsrDp6+6Vb
         nRl53hOiYsOH8SUnkOXirEKXlCXqkokJWBgrtYIcqRXz2HjcpqEykYeJN4D7xK/5wD7b
         biQg==
X-Forwarded-Encrypted: i=1; AJvYcCX/pLZ97HlUP7Kc9qPXNu0VmTqyexqCSUVXwbdPVDbxk3lrnDq7ZJaoVAmlodPTecVxkM3D67q/jId4jPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MZW1hhVcaLAg0n/jWyPc3L1cDXNBUpRkNvIX8LNSkfDR0OMd
	CSO5JxLE4jNUCTmNmSyAtKmGtJmMXSB9D58Hhce3GoBxAAG19sqmsWPYr4FzRA==
X-Gm-Gg: ASbGnct24/CFLZAjEYLiROCqHo6MYBQRl3NcqW0nq1XAAbP3S1SfVe9L3T2jmcxvR22
	+QaK+0VRj3Eyj6sV3qNldWfgjnMAJEW0wvRVvVIzOq2DZbpodlmZw4LkhconGnQEesY3O/VHTNa
	hGEVgSdPKcnVaZ0aATjuTsUWbraMzBlJoATmInS5hdimO7P7PM/Nhsuldrb16DAgx2VsjV/C624
	uVqwXC7Bl8wmzVLcw6XxvFTsaQn5gP3WL5UTUVU5a1sqFd7H7jjp4SCcInZ3ypT583PslcFrb0K
	7A8cptszli5hQImUs+iS4t3cf49aMoURqDNpfdDYIsx9y5xTDZGDqo3IeqAk0xzV6IS+CD0QTYQ
	WPnzoPgeci/EO8pYz1eMDNnfRuRHJzjEr
X-Google-Smtp-Source: AGHT+IH/38TmYy2syg/0GKf0hg71IOf1MWOIAEKCD39p03XO+eVYqErkVKfZE9DTfnNjbia20dJJBw==
X-Received: by 2002:a05:690c:dd3:b0:70e:779:7e84 with SMTP id 00721157ae682-719e341de28mr36872037b3.27.1753467466968;
        Fri, 25 Jul 2025 11:17:46 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f23e85e4sm823477b3.84.2025.07.25.11.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:17:46 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: Re: [PATCH] MAINTAINERS: Add missing headers to mempory policy & migration section
Date: Fri, 25 Jul 2025 11:17:44 -0700
Message-ID: <20250725181745.2494226-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d546df23-70df-47a2-9211-2bb971f8834b@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 25 Jul 2025 20:03:09 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 25.07.25 19:56, Joshua Hahn wrote:
> > These two files currently do not belong to any section.
> > The memory policy & migration section seems to be a good home for them!
> > 
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >   MAINTAINERS | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a8bebd0886df..dec8db8b5cc7 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15838,7 +15838,9 @@ S:	Maintained
> >   W:	http://www.linux-mm.org
> >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >   F:	include/linux/mempolicy.h
> > +F:	include/uapi/linux/mempolicy.h
> 
> That one is already on that secion on the mm/mm-new branch

Hi David,

Thank you for getting back so quickly : -)

Unfortunately, I can't seem to find this file in MAINTAINERS in mm-new.
Perhaps I am not looking correctly? Apologies in advance if that is the case.
My HEAD for mm-new points to dd811f4553a9512501205ba8e58ef1a6af4cb291, for
your reference.

Thank you again, have a great day!
Joshua

> >   F:	include/linux/migrate.h
> > +F:	include/linux/migrate_mode.h
> 
> Yeah, that one is missing.
> 
> Can you rebase to mm/mm-new? Thanks!
> 
> -- 
> Cheers,
> 
> David / dhildenb

Sent using hkml (https://github.com/sjp38/hackermail)

