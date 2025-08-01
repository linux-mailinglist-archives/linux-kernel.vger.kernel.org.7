Return-Path: <linux-kernel+bounces-753039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD31B17E02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 10:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645D2581D54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A3720C01C;
	Fri,  1 Aug 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSmEiG0u"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B99188734
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035586; cv=none; b=JXiFAcp5QEqJ2FMR2fJYHtffkXEGD5q5J0So6Oh2JBjrUhOju0KMQeHeD1/LzoCYGR+BHL5fddqfAMe2QO2mpIASNAK79JA/sayHc91wKWkMDmrIUh3KiScpeUenDWClnd+Z5/TmXiGI2aZYzFuShgiL3oJjpsCsyeVTJ9SJem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035586; c=relaxed/simple;
	bh=vd78SXuialJaPvnj8hPu+N2YlkKX/hUriyvsL21fTrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoJbO2YFv9N7Lq+YC662+UsGCrsQoN6cksYdQhuYBabWvGH/TCtoGfY3ecepmZomR1XIISW/Y6xZE4+jf/hNCvGZbEJ45PIcxcow3zvTnFUIAHaa1sSVLTv6/8p5hsjJyILj6jKB9+Y/EwL/6AdFIo+XvJMnLaLi0dOwUE8kPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dSmEiG0u; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4561ca74829so6261775e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 01:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754035583; x=1754640383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HC5FdN+p83TIgj3QdaEXrFkwg6zsrhmSO1nWzeQxiOM=;
        b=dSmEiG0ue09LZICHHIKISo/7lfRKo112Lv6TDyby5WXXxVTj4BVBc5WiOfeaCp1WOj
         vGPL4U8jAFa33VmlSfj7i3jAAsfvfYAg6oOBs0xAA+YFcJOHToB7lpzdPKZawj6yIeyK
         qf0ndxn2KPx+L+7o8kMelOXiijzyeRrcO11Ak8H3i7J6a9q4BSSwZBK1Sq197eRhjP7A
         QNADrhZ8nKVuZIqMBZ8ks2JiE0cs4+zvjUjLb/tFNA4nVvzzUJBan9yVqkWYfTBsdYZR
         tEdD5NX8cj2JbYbH17kwHB91iDEcwTzpI85fber2+hr4Amzzu312sLpYQ5vhuDf0fMBI
         8h0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754035583; x=1754640383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC5FdN+p83TIgj3QdaEXrFkwg6zsrhmSO1nWzeQxiOM=;
        b=h1EyocheZPiHnG/11GWjM02q5b9GmzskZLbbeYHBXLDRSKyBo8syALZtlvbXpzowYK
         AM3tYORVMrt+0Xq/2juQUplB4EwojQY9ZpFqGaUmxS0JTPpF4TQb7SXtOXgQcmaDzAub
         qbA8MeXo67qpFkwQOBwkPe6YlsJrYt+z1skHklULb1TX6vFkJIcsyedMR6fHLnsM0v41
         5tJLHh03I1vceEMYkYasJCYpdRG8ZBdD/SPUjmfRXZt1cI4bPzxTGeQCgcyqMpxoHWg1
         OEhEwf8qCau00Upih3Za1M757kWkQzKLtlHo4IRcBdxW1qvSbOdw5ty7QboyZbVHhznz
         XLMA==
X-Forwarded-Encrypted: i=1; AJvYcCWC7xte90lqIxX94LQh7iMe/EKYwIPD2zAOqHCw7uaDiq6WvfDQTYOm37J5ek4yVJzcODG90rlSDzg/nNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzrgF3+thoLkVdj7u5wdwnCBy+7jXg5IKfJ65byl7b8RIfGXW4
	6lvtH+0dNWtflTdpLzWjuhPmoWDHzogcZDvNkGbjTD7X2GWPuZMASWpgkrvoi5RJnuE=
X-Gm-Gg: ASbGncsHRrMINH8Ahaz+ZXvYljE6Nr2J0SeB3TKoe+Bj358IszXpE08fPyexhFFboul
	FKmdaLK2hWBOnnTw7J4ggfe7/dJOIKBtKDh8UnvdYIN31/REN9DYkJH3pD6g5R35Z+goGNe9e/3
	lDe5KSOxvi4bIU7/0lgUQ7ZSs1LP8AZhQvWWxyhswFrjUf3+kdf/jVLh4J9ix3PQX93kNdxQ7PG
	5kkdk4q2byxD/vHTzq1HjNtE/niP6v7PjxreanxQN9DNWvUvdf1Ybd/zpKvLVaEBKQ6tg1HmWkV
	ocY8RPXIgOW/9vuTarkTebzhKksbmzZ+tWTWqS65/n99fdtxz/NfRKH5RuAAGYubyy9u4zX/LQA
	MsIWSWKHxGKGI2PSbBjDJnxaeKp8=
X-Google-Smtp-Source: AGHT+IFZ5j/ri1LSVCrIKHdpKUGNZ4kJZd0EPzHedTGKYZyuiPBOa23Fu0ExGYYHmBSKu3o8jHljdw==
X-Received: by 2002:a05:600c:4f09:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-458b0216ba7mr6486295e9.0.1754035582631;
        Fri, 01 Aug 2025 01:06:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589f0803e9sm56881375e9.0.2025.08.01.01.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 01:06:22 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:06:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ruben Wauters <rubenru09@aol.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc/xmon: replace sizeof calculations with
 ARRAY_SIZE macro
Message-ID: <bea4e3d0-78ac-4c96-8d5a-96bef8037839@suswa.mountain>
References: <20250719225225.2132-2-rubenru09.ref@aol.com>
 <20250719225225.2132-2-rubenru09@aol.com>
 <62aa5231-ed31-43e2-84b7-d6b6ec86e78d@csgroup.eu>
 <8381a142d72f3cd0e92de4dac6acfc0241a87365.camel@aol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8381a142d72f3cd0e92de4dac6acfc0241a87365.camel@aol.com>

Can't hurt to try at least.

If they don't merge it, then for code where we're not upstream, it's
pretty common to just endure style issues.  I'm thinking of ACPI here.

regards,
dan carpenter


