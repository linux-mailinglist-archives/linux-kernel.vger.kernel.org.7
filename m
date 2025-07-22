Return-Path: <linux-kernel+bounces-741452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC5CB0E452
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFA37A6475
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F347284B39;
	Tue, 22 Jul 2025 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbcekIhq"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C72641E3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213188; cv=none; b=g6ItEXxbn6lTxgoo9EozG9RASkQ+nM8TrZUbQjfFLBHmjhtYG7nR9EI+7NymEDFBYW7QhDuHYfmmP8FTGXlNg9TLWTmxEssiTvz92Isyf0I9jVc2FrBz4ztmOuEVhp11cB/5b2jGeJf6lUydwBEvj6kwL1BD6nNQ1iVvcUbQuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213188; c=relaxed/simple;
	bh=Lk78BRNbPfqw2aOwF3WJ4tG7Q6B1MnAW15Bs8qgZoEM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHjcjgxKq6eVd2CehjZ6x9yboh5EaybDUVPujaVVJHHhmrI7t+8Mm33M5jmzbhww28a5x+8bFsH+Husqt0jdyDbpZqRabWpakTYhvfcxAJ6GLQTqb12gnFklyUVDtT8b+LdhiGm/kxlwXMcsFDBixlUSJ+r+KX8xak7KffGddWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbcekIhq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5561c20e2d5so7607896e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753213182; x=1753817982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWwanWZIN6VJqRUWaw2x8mt5qLkeBEti+V7m7T7sRfo=;
        b=dbcekIhqxzfD0XWO+Cc7VTuStCKjWTDeIw4DfSKE6LUEe42bx6nCud6CeHsSPCaZ3a
         WJXr57zjTPNMuBc8ZFZSyhVaPuyB9NjT3aund2yFc237kUpSGqwNfQlL8XwCxoC9oe5X
         xH2oQ7JoPrzfm0tlk3GqMauJbcGwDulxfcW4eM2ICF8583ts34RCxkI9JK1DZA+JD3Qk
         2BBcGvIetf7bCvn6Nz0QaLL2lL8XJxY6ZIPK+7R/o2d6z8Az4ek/5cp54+58ENHvnLxO
         PMjqUUOcq0RpyOTQEsmy6HyzlKNSUfyhm13aS59LHXeMYslA6GxlNB2stIgGeTuDgQUx
         ws3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213182; x=1753817982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWwanWZIN6VJqRUWaw2x8mt5qLkeBEti+V7m7T7sRfo=;
        b=i5ODtaMaL9nq9DNK+Ns+/nIq37U+Ud9VZNS/cMXF1oeGtwLSJitSFa2hpcjfZd4sXd
         xkdQjbejytokEL5JDomawC8nrX/CcqElBJ9ncVrzZoBIYrZ2yH9hAB1+O5tkRwiOF/9/
         icHG2L5buOIRi2KLW0gchHiyog++la3FsEV1jMT4mGXuJXur4MZQE7ZxllGnDKZytYwf
         5QPTUJooGjnrk031OJAORLmv6UBSs1qiCHh6/0X8Hn+yolQsrSmQSk+2BAMOC2FN//34
         sk8gOaoC5QmHMFy6ujdJ0QfOFWCCpyPa4oknpX+xyyrtq9OULjKXpEHor2XRZMi8VO9Y
         Qvsw==
X-Forwarded-Encrypted: i=1; AJvYcCVK9YOFkcbwzo2xMkzNZCHu52H9eidZFj2X8TJIjGmrgTio9ODycwAWEgWl8AsJH+vmwoVy8PGhq9Frqmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxldhuZnchp/8nAVoFCdOjSTKLD2UO6vM8JTB4IZELrdCVR1/y4
	vgGw56Xfr+GtRAHVjGUJdkI3Za+1IEafBkX6vLe06UQoMhAidUo+PpnUTyHS3g==
X-Gm-Gg: ASbGncv434qSTq3RyyugsQCY4LggEvNzAWeL/Ma3i8p92q9YyLDWLCLaphIuLpL8q31
	lx/OiO4VYC+3PNYcI2LCai9fGou9PfLxaCYhAV2ZQFLg7guvLqVnC7KcuYsh0KIq9kmIGFKoKyb
	udd9Jqk7L3/lA9P3lPE6ccXszB8X3/b8yJwwmbQVr5XGt67Au94pgi8Wwwl5MdUBZYYh0ve4qqa
	d2XXkmmq6m1RAxjLUaoV20gkDSyabUwxuzdmfZogRtKss+yE+RVSG0JVqF4O9Ona1Ug2thFFoAp
	/1BMKNVa1VPNmyJkGRSO0LFDqIVDubVhBslvJJPs6Gd0368i7XtUeTZcGQTKkNYN
X-Google-Smtp-Source: AGHT+IFbHt2xpyOsVVT8UPF6x/qDC9IiOeFqzRPNDED4QfUqrtireW40AQuhtFawGjwFKenKZbGixg==
X-Received: by 2002:a05:6512:3daa:b0:553:2f50:5dff with SMTP id 2adb3069b0e04-55a5136aab3mr87983e87.17.1753213182060;
        Tue, 22 Jul 2025 12:39:42 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a4eb36cf9sm139815e87.222.2025.07.22.12.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:39:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 22 Jul 2025 21:39:39 +0200
To: Jia He <justin.he@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: vmalloc: use VMALLOC_EARLY_START boundary for early
 vmap area
Message-ID: <aH_o-85T-EexGWrg@pc636>
References: <20250722040850.2017769-1-justin.he@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722040850.2017769-1-justin.he@arm.com>

On Tue, Jul 22, 2025 at 04:08:50AM +0000, Jia He wrote:
> When VMALLOC_START is redefined to a new boundary, most subsystems
> continue to function correctly. However, vm_area_register_early()
> assumes the use of the global _vmlist_ structure before vmalloc_init()
> is invoked. This assumption can lead to issues during early boot.
> 
But we just should not redefine the macro. If there are such places
those are should be fixed, IMO.

--
Uladzislau Rezki

