Return-Path: <linux-kernel+bounces-727990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D7B02228
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEEB45A4C99
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03D72ED152;
	Fri, 11 Jul 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQe6KxRf"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B04280334
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752252600; cv=none; b=LBTtObwcE1Hm9PyxWGfhjkoyafGl3QE9Cy1VL3jexX/eFOTnhaosyX98Osk+VS22kGqncCCJ0B+iEHRFhRI297HsF5GuEjYRpPlKzQgirhAwYbIB1SyDe3SLnVmCK47o7N0JWLEfVgL+GI5LnUb4hyw6uxxPutB9yYW7UMlqGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752252600; c=relaxed/simple;
	bh=jJV/8V5IGWzVYpWSU1Y83IJfh90xFubGN/taaRl11jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SarNGyq3lNVRUSYJ3ulldlLLbp7HziGAia6EEyfSaR0D6fT5RR6ABQe1ddGb6a4DkHo9A/OYyCeTM+P+ub51DYEyd+biSFmLopo7hI0qwpOTdrR6YK9GIaj57quHbndqRtC4iAf18KFvzrfEuMikHGr35lNL0RT4cJTy8qmddqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQe6KxRf; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2950127b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752252598; x=1752857398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/BPRr3b8XZik6ItGuMoyNpcDSmLghtHCDrC4aFnVQew=;
        b=NQe6KxRfrXC7ZxTpWDnjt2Vrjd+OtAp6JgAL6bMwJsn4ovuuwBw5mfNPDD4Qt+nywm
         ZVn9fFTRMqvNG/esJ3NeuNhF3WI+sk+FIzrx7J+HQybV7Juxllw1sJdcP8mVQkSCIV7i
         xv+0F5OkQyjVqC+27RmmENPUJgpOcKfU6Zh5uiWn97cyPUXqavQfqc1NwnBuidSAVjR0
         Z2Wgf12L1YMBg3lbWawrAuHsFmZ+bQv60PBVxS+IuPWQUbEi0SKljWNxhSA5OZR0ANny
         NPf4wsw2FCpR7Bjf7UVwszbVLm+vAuAF4AGie4+rLcr9agn2ekhecNEkBTJFmOTS6vt0
         0SNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752252598; x=1752857398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BPRr3b8XZik6ItGuMoyNpcDSmLghtHCDrC4aFnVQew=;
        b=uII8Vab0YzKYjQ+Xzcyy5m4yyzvhlf7e+UaCurkvc5cTl5LPyvZV4b/4G789t0I4Aq
         7hhOdkO+e3Wg8B3hwRWx9kkWURkUlMbN2jamBVFsg2BnjPIO5cx6dDOSm0lJbnyHk3JY
         siFwCMs7V1CFns7ZhbmnKMA3ZhC5Z+OskOXveII6P9vqIr025BynqZ36ujKguKT36ARI
         CN7vgNVt+WEWXrpZ1GzxMzwsn87U5WgETvZMoV+vQZAIZkmZwfVlUr/9jg7DQD1ISud0
         M8D1j/XcexFL8yyvYWcTQgjWb4sx2go/JN7HaZGXk9E80QhJ92OOPPupBl+zn6hyjIH0
         6P6Q==
X-Gm-Message-State: AOJu0YxAVpdPZ2EdzGS92Hg9lYgBHZ/sYvHkcFPflHARQsRXFrPDO8bC
	wDp36zDKs0KYv22ih7Is5LLqoPGQ6lIuJ30JW9jgXXpvJhB+Da5vIxqmuaOE6g==
X-Gm-Gg: ASbGncv9VV2/F34xQZ3PwZoOcrwIn48Oj8iL+UWyzSY7ShHKVfeiSqlJ7zoC9h3eo9j
	rfmfDXjV1t5OJVzGtchhG248naNVGdgq5rh1F/z/NP1JdHUUo2XWOeOYLv6cAfMlIyl2pvxDhdO
	0pfAfDZAFFLRYOd483iAmchsaHkTKv9/LPxgK32vh/X3qf69WAj1bIEgaHYoTiHxZHTd68w9leu
	vynCNmPmU/Q/lEMXZTddKmK6l/xotpzwpjIVISujy901qSixFSyysAfyT40UR2J5bE1I5+FcRKP
	6I+ATgTR8JlE7rwUWN984Vua5JTCfBND5EWS0zUzH6vQPlCdFi7ItIq/IWpItKFCEMhktYaxbI2
	ORZ04H5fFM6iJBG4WJR1pO3/BfzO52Gg0yROyYOhBFZLiTcz2UDCW9g==
X-Google-Smtp-Source: AGHT+IE+r6tHSOKakmRHvPgLyaFBSP9uCqwzwYhKMnnqq9pCRCKOqegDnCwYy1AuJupAL4FT8HmB/Q==
X-Received: by 2002:a05:6a21:6d85:b0:220:2fe9:f07a with SMTP id adf61e73a8af0-2312551f2b1mr6540914637.6.1752252598118;
        Fri, 11 Jul 2025 09:49:58 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06a04sm5058626b3a.44.2025.07.11.09.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:49:57 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:49:54 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, willy@infradead.org,
	muchun.song@linux.dev, osalvador@suse.de, ziy@nvidia.com,
	vbabka@suse.cz
Subject: Re: [PATCH] mm/page_owner: convert set_page_owner_migrate_reason()
 to folios
Message-ID: <aHFAsrMKYTvjRDj_@fedora>
References: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711145910.90135-1-sidhartha.kumar@oracle.com>

On Fri, Jul 11, 2025 at 10:59:10AM -0400, Sidhartha Kumar wrote:
> Both callers of set_page_owner_migrate_reason() use folios. Convert the
> function to take a folio directly and move the &folio->page conversion
> inside __set_page_owner_migrate_reason().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

