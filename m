Return-Path: <linux-kernel+bounces-720518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A574AFBCC2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53CA57B0EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043691BCA0E;
	Mon,  7 Jul 2025 20:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RXefyldC"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F593137C2A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921190; cv=none; b=lCpYBjSo93dPoCxZUvtXyP0loQWedDtfmYdfwpk0PV1zpG4teRzfhDuuzVqRL8bJuiXqdfbMhp10pHOFlfnXfUqpY8eneOIBclMz8gLulVQJ3E/dr+rEvhk6z3ziZS20fXtbnF482MBD4HfMc/8uGk6tFKG562X2/5dJTcLw0ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921190; c=relaxed/simple;
	bh=xq5+8q6Hq3wyNqK6vOVdbDr6xhABcrkJYe13gKuBWi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMd3hxOE9mj6E1q0N+PWOldldcsRloNH4GgVvEECmFgDBsCLMOc4xP19X/4SYF6ZLVTDoKF8FoW2Ou5ng0MgYmq1abTkrcRy7FxingqJWRQhaGPzRy3WZldOEnvvh4zN0YwBLohM4yhC8NXtruvDr5OQg5E6cyIfW3ibt5S7Uck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RXefyldC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso6392571a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751921186; x=1752525986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEDgBaUeWk+QDb/AaNEeMgvkFy6FrKw47awCwo707GE=;
        b=RXefyldC9tAcsoJs+eIes05sVmCfDorI49LB2yOrOelW2XZGcNi/Rhc9gcKd3ezfw3
         asQ3IkPw9aoHdbrEcLGc5I/Hdf0RgWR/MZBmoNKujq2VSbe6dCEQ1t0V/whl9g8nuWRP
         viq2B0g3uhsypJ2ojZx3mtW+9KEZdfV6nGq64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751921186; x=1752525986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEDgBaUeWk+QDb/AaNEeMgvkFy6FrKw47awCwo707GE=;
        b=bcHRDZSkywf+PfFzfdYQXpDrUb8BtiHdoTOZsKweEjG2wnUt2MTKQq0sH/An4PhGAW
         IVbDc2jzY3yh05WZB2f5u89/VRlkfzazBmP5NfLP/qdF8G0Al1rXNljPTE4malb4+4zI
         xpNHe/hPLNmtpnwt1mOueJssmA85QrxkOyrJjG/wtFiDNLvnDSBKCGiqt4JKZzMNd/5B
         x/4Ztni8hF2wSL7tBACg0Uqf68BF++pp7QcJxDmoFqZaaYPWT2ssRg2poQyJ1KYNjpv8
         HCYcHd4C3f/Ualwy8eKE0HqxACEjldzYm9kcpR3VTgQvb0tK0fMhH6DcmgP312e+A75i
         1eZA==
X-Forwarded-Encrypted: i=1; AJvYcCXc8WBnmtmLNVlrrrh70A1/ByUULx0vpCPY1WG/+eDHmiNjT1A63pEuRqW9ZT3a2N9b17DQ7TxtCoXqSKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6CBngCLwKNH3Id9/tZS/Q5b5Pvwjlzri/9/66w1L5mTSPC+qA
	yq8CvPWUxigzpdn9l7YPDnlBwLTEkDTKPUikXdWnA8R8O8A/mW2rZK0DaW0/zvumc0khlUwWrEn
	XYq2BLx4=
X-Gm-Gg: ASbGncuR46OMju08lRvYUkTBz7ATzcg0y8ZH6sU5XNMfkvdgpzX4dvpCTKFEyq8qaC3
	x29tInbHyBi5TrYdbINap1tEbdhaD1MU9jXY42jgMzSnSQolLF+shZrPI8X0R9wOG5dDXiBBrzW
	K7Rcse+kBJwQEhdGf33SzjM2G74aCOhIulWqc2WSDRFw4Xa6x/O6mTBFPjOtmXDVWk0LjqMB8Uw
	7Zs+/h4gXOhwHT7ZaXCnXcC+WP4RJt+scz2uwoYrKDyGmxkZsWDsqe9RQsXrmUn9eghgXWR4ik1
	xgolrZZDVdPU5HOxkMJEi7trbQcM7QRa1d+q4iKhN9SXrqpSurwK5h1vGUejFc97R1y2ZdKy4nW
	sLAC5QFARHyymNQCVXSv7upU8LomOX6ZUpa7M
X-Google-Smtp-Source: AGHT+IGR8yPVlDMV1OqYwMC4FECPQ0XwGzNe7R3Efj8kj0jpqXAEahQeKyZLjxk+x6IzJwAOi6HSMQ==
X-Received: by 2002:a17:907:1b10:b0:ae4:ae1:c31e with SMTP id a640c23a62f3a-ae6b004618dmr53765666b.8.1751921186168;
        Mon, 07 Jul 2025 13:46:26 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f692bcf4sm761758966b.44.2025.07.07.13.46.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 13:46:26 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so6490409a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 13:46:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3XyV/vuNAwuoM8r0egkrjAf6ZFZ5oDBUJ5FXP2oZEJMQY20QoF5XYNrst3gOCvy3W9P6mU29WQKdDYvA=@vger.kernel.org
X-Received: by 2002:a05:6402:3902:b0:60c:3f77:3f4e with SMTP id
 4fb4d7f45d1cf-6104680323cmr886164a12.22.1751921185468; Mon, 07 Jul 2025
 13:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
 <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com> <20250707193521.GI1880847@ZenIV>
In-Reply-To: <20250707193521.GI1880847@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 13:46:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcyA9kdWUc7HL39AhBoGzP90ntOzbBYpp=Z9M29bMPoA@mail.gmail.com>
X-Gm-Features: Ac12FXyTJdvBtSzuEgvvQf3FBl3I6foxcrWvzU70QsGHoB59-IiGkLMHShqelF0
Message-ID: <CAHk-=whcyA9kdWUc7HL39AhBoGzP90ntOzbBYpp=Z9M29bMPoA@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alejandro Colomar <alx@kernel.org>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Jul 2025 at 12:35, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Lifting struct membuf out of include/linux/regset.h, perhaps, and
> adding printf to the family?

membuf has its own problems. It doesn't remember the beginning of the
buffer, so while it's good for "fill in this buffer with streaming
data", it's pretty bad for "let's declare a buffer, fill it in, and
then use the buffer for something".

So with membuf, you can do that "fill this buffer" cleanly.

But you can't then do that "ok, it's filled, now flush it" - not
without passing in some other data (namely the original buffer data).

I don't exactly love "struct seq_buf" either - it's big and wasteful
because it has 64-bit sizes - but it at least *retains* the full
state, so you can do things like "print to this buffer" and "flush
this buffer" *without* passing around extra data.

              Linus

