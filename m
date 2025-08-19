Return-Path: <linux-kernel+bounces-775154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F37DB2BBFA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7196F5636FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75401311592;
	Tue, 19 Aug 2025 08:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZN9b3d1B"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757631C84BC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755592534; cv=none; b=Fgj7vS+qNzIXYmi/9fCK9WQAAl7EVgppGuTX/VnskWqVh3Vg7gWjPDL9Oddwwse8xI5tjKWp11MRqLJorLcPNMnjz+3TxKxjQjhRue9nZ06x4/WyFgkeP7rmKQKjbYx28ycsH0E4lsGpE6qMowPd4g/bGFJX1Kue2Pv+PjuPohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755592534; c=relaxed/simple;
	bh=M6MAsJKmOEe8NoOIu3KbdJXFxBlN0fOMBGKcFyDv8L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h56SBgCIlkDAXPn7RpJ6XfnQ1j4yVig78s6XDIoJT6PB8IBCrdZaE22R3GFbGkbho1Eo1CvYZ6iMGELHwEnnlYh4+0u2xK0U139kPjWrdAFt8NS0qOBcCYLqXr77GWJwol+uIpT7Aq85n0fDdeD5z1BKAT5CDZg4te77cgWD3kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZN9b3d1B; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb79f659aso756277266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 01:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755592531; x=1756197331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P1cBovOT05BmrwzYOJOxZ5z+DToAOtvf0DyUqfnYGFE=;
        b=ZN9b3d1BZ+RCJIi0RYvCoTI/G/cQNOTJIQpOjJ+9JkKelLXHvkmuumRVefh7aZfZcx
         pyVcQmCFfqKuR2/yCMrr186H1j7aSu/tuOOGzXqE0tDK64emEGjmbfqklb1b/Q80hI5J
         FH2gLosNDJRhzrzcfUi3Bx4AhDXQkofus4dO77LUm/oWqvwzl616BRjEeGUdWHFgIPO3
         RtgSELcQ7IQVRzE4FC/iqq+mUnhIvn3hg7bIsGXJFYuiznoNmVubyM3sugCzUhC2IAts
         O9bAvXNSs1ZxyTWDLMj2IJeq7v/+4G9YKJaE3uYWHW1fM/ByaVeJj+XNAtQwKq8K2lXN
         vDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755592531; x=1756197331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1cBovOT05BmrwzYOJOxZ5z+DToAOtvf0DyUqfnYGFE=;
        b=CmBD14fIsN6b8c8fRDPiG43nnMMkpsPfW0VZyGNwlPW+cUrFX0R9Oj/afsf1faDU04
         XE91hp48iDsKgv4uQOZGqQ8bFyWZw+jD+X7T9cA2JopfWcoIElunvrTRtGIxIm20leTM
         zbjKTddV4jYd1dF36nNtM7PPOwAlPr6czK3VQtJdAax0W5ladSQ+TSht2Jyv7hdqKIMw
         BAx5W8/N0cWJgCbOeYinkkKWjMnY2i9xrfgy0YAPZPGAxLG1wEUw2v5/b/5eJE88AK53
         xIneqSM0rU5mKpHvsO1JVV6qvqdUYOK4tgYREjGv6V9pkG01lHJFiX4/FY2YFoHx/tVo
         Gv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxdxf4qx0GeXBdYTWwv+AT29uE0AFaFox2mnwsREL9yN/XFcIHOx1Uwxq2bLOQUi9dahRISG8mAgWYJf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfhx0TEilXqkH9LkJAYnQBsTvacGq6mZ9SDasLUliTc8tiTOHX
	nCCdA3pIiHcj47hTSCydkPHtk/2bYu0QGqHd7pVKubF0Bsd94/qnD5mZUGE2vWs4OOfgAZzWRH+
	v7OMP
X-Gm-Gg: ASbGncv1GuPSqT3pzjLAaMsWVlf8X06M5W5r0KgRPjMKa4WZWpCQ3hUPOOIWxznT6sB
	XUl4nOwUNGkceiiKHhSvtHsLg02QY5zu6O+p2bu6LoOLlNFvuFn2IfS+/+cXA9gRwQf+q01HRyU
	DGejIYmdYYc1Z9K9m4aQQmovO47pfCsQrJ68jO1zmT76lMGHvcTkZoHc5maAs6vacpFDO14TL4Y
	fT7QFzu6sUuUMycZ3QEgnrnyfSWWdW8gU9WTCgNyV4S2U1ZckbRbAExzWxmj8QC+gRwlNeBg67L
	1mWzh0OMtJkvLnECAe6KYgSsXm9AZKW1Vc1JnCe82sp9plbL184zOViIvrMJ5Qs3BjteU5r+Bf6
	W9e0kkZFWocEvXN/pzL30fxBnxA==
X-Google-Smtp-Source: AGHT+IFJjU/g3OyARUavbGWdZ5aC2lNhssJZ4ZZOaAanuC8tNwgtJ+pS5IkxfemmqmSjTrpZHwS1eQ==
X-Received: by 2002:a17:906:6a01:b0:af9:c119:3b4 with SMTP id a640c23a62f3a-afddc95da35mr156875366b.13.1755592530657;
        Tue, 19 Aug 2025 01:35:30 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce54016sm953838166b.9.2025.08.19.01.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:35:30 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:35:28 +0200
From: Petr Mladek <pmladek@suse.com>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	john.ogness@linutronix.de, Askar Safin <safinaskar@zohomail.com>
Subject: Re: [PATCH 2/3] panic: refine the document for 'panic_print'
Message-ID: <aKQ3UKefo8A_AYFq@pathway.suse.cz>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
 <20250815071428.98041-3-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815071428.98041-3-feng.tang@linux.alibaba.com>

On Fri 2025-08-15 15:14:27, Feng Tang wrote:
> User reported current document about SYS_INFO_PANIC_CONSOLE_REPLAY
> is confusing, that people could expect all user space console messages
> to be replayed.
> 
> Specify that only 'kernel' messages will be replayed to solve the confusion.
> 
> Reported-by: Askar Safin <safinaskar@zohomail.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

