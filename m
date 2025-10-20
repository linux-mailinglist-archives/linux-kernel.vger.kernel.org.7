Return-Path: <linux-kernel+bounces-860779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C833BF0EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5123A038D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B903009EC;
	Mon, 20 Oct 2025 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Q8Fmiw"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0E23B605
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961029; cv=none; b=sS1i/zXwJOV25/zmVf/TxZdLcC3xGhJ8LjfHywDRN516RD7YuPhmNvRvBbNKDzrMkZ+ssBJJhJtvYMWO2BgvrrTpoq8suhsgo5CQ9UTDfyJ4DilGJcSQG9X9WQzyTPrlVklXuYjlaWykLa6NttPOpNinoCnVfxUz/aAakIF1HxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961029; c=relaxed/simple;
	bh=3Ib3zrr/tPmm6C+NhCIYGI9GLz3/YlX3IpNvy/WsbBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvR0DkYNOLwrXQZIKRemk+sBElGI1cVjPw4Z4UkJaGx3h/Iyxr4Ciknm8bSiq2jy0Dylu8Se7xVD/+fCPnV4Wpubr8Wm6ITULY573xF2AVaCDWJ5vaWHO0RSYvK9GUsECQmYQdRilHgKNkHylUpyQa3AqCHluJiQCTxWLVr5awI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3Q8Fmiw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3e9d633b78so68086166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760961026; x=1761565826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ib3zrr/tPmm6C+NhCIYGI9GLz3/YlX3IpNvy/WsbBw=;
        b=D3Q8FmiwZInTYZCNZ1U12ur50ed8ev7+xzgz0oSlfPRYDYt+iqQpVAcelpSnWzKXhY
         mc84dPtZSk5q4YPHvst/8GYW1R1Fqz++FYc81xOs3+4o6XZRgdrHKqBc38hcperdMOhM
         BNi2OmHzGRQ/CvywgZWFgnsmWPJ1zco+44sS4w6YYkVxw6P6XJlwSFAIcHj6jZsz3ku4
         QxWRbDL6dYs65cfl2du8Brrd8nBagE8+IonYB8qpYmAh2ZcMjZutr+3CumMTv+eNKs+a
         +zzm7BaRVeaf+rC/WSedHAO2QskhIHw1rKQm4ET4jXBhOUNrGEe+AA/u97YqAoE69vqh
         XCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760961026; x=1761565826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ib3zrr/tPmm6C+NhCIYGI9GLz3/YlX3IpNvy/WsbBw=;
        b=ZG4CyLq7fN+zg2w+lk3cCZXqDcxp/P2bheDg0gClyx486l2vMx2ny7N6HIqW8EmKLF
         2ytsPa22SR1kOXpZ5FOlfmpu5CyfrrdtJd+/P9ZmG0fwYJdmIgpg7cBs4FdczhAsCRoL
         MZ2S9gX8fF+N0p2vt3rLFc+tbvTbZ+DCCq+pSdv0iHc63NCID2IgE4ul/6z/s+iOR5cI
         AoYT95EUCc7Fp0glEelDWtnq64CRknRu2WgvGBVd49pxxqhQnu5bvvbsSD2NlA734yzt
         /hs5s+xHhA8n2ZnmmPdjIWDJhX79sQ81plRVzLKWiDPtvtZWUEljdcxHbO3avxD9Q8Xg
         dluw==
X-Forwarded-Encrypted: i=1; AJvYcCXZVjxUowhfkTWu3/E2DkdukC4K0yOxg86oOjRrATBdpHpu781ZV59yNFYsqXNEyJfkK5wMSBX3QMVSLXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qDgqWYrmkA/UA5HCfkH9X5HKbzwdrSHEWhyGlNt0gvwU/68R
	dF5oKpoprEpViNOYD7JyF719gFKBUNLc7ATzq5j/LnrIdJc/4Qezja2IhwjbfGGGVjGewZ8ra2r
	yYy3KGuRq6RVqsRkkw7rY0+grQTVE9UNGzQ1b7Q==
X-Gm-Gg: ASbGnctm2fFfwiTWNcNj5ZgC9Wp+8c31zNsMc6yXOV/q0e9L6ft22awR323uqSWLcIh
	cTENA6B7xPFdVxDpYy5HusXCrhu50UGVMleeHJlYgNsUFgH+A2BXFaQ8fkQn3F0H7eCsBLR0r1v
	c4mIS9vhmim64KePvwHet6Kk3ahdjwkH3MImvJgQ3rxV9Lv2Ic5oXLtClj9Eosfwr7Zl6PwaroX
	Euzv7ytNCapk5Mh67isjI9LVfMboaEqqRv/SXl3jMHlDnrD8IIsBQyeM10uRfQe+7L5
X-Google-Smtp-Source: AGHT+IHpqrZ2dPIwhNgY2sr456DoKSrudoQCSOVCHp2/+Yamq4lGHHP853dkoUAlwu2plIGKzBU9GigR01lDOFEXyUk=
X-Received: by 2002:a17:907:c00d:b0:b2e:7614:d92d with SMTP id
 a640c23a62f3a-b604e6d11acmr1848895866b.0.1760961025902; Mon, 20 Oct 2025
 04:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016103609.33897-2-bagasdotme@gmail.com> <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
In-Reply-To: <aa388d29-b83b-454e-a686-638c80c6a7bf@infradead.org>
From: =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date: Mon, 20 Oct 2025 13:50:14 +0200
X-Gm-Features: AS18NWA3E0Ss9-ztf94LkzgiKtO5TbAFbLXh7zu0w6jJDo6kFqwu4lbvMiqUEHM
Message-ID: <CAH2-hc+XQR7v9Z28yH_CTWZ4ieaF5eQFKBVut1idULP=4w03fQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: sysrq: Rewrite /proc/sysrq-trigger usage
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux Serial <linux-serial@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Cengiz Can <cengiz@kernel.wtf>, Jiri Slaby <jirislaby@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?Q?Anselm_Sch=C3=BCler?= <mail@anselmschueler.com>
Content-Type: text/plain; charset="UTF-8"

> I am still OK with removing the 2 "However" lines. We don't typically
> document or provide warnings for how the code might be changed in the
> future. If someone modifies this code and the documentation needs to be
> updated, it should be updated at that time.
>
> --
> ~Randy

Problem here is, that you cannot really modify the code without warning
users in advance. This is the warning.

