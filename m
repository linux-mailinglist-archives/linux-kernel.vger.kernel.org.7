Return-Path: <linux-kernel+bounces-750506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954E0B15CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB998563DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5031E26E71A;
	Wed, 30 Jul 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IeEIjADn"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82D276058
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868788; cv=none; b=k1n1O86PqXguGe1Ynwa0cRLDMx2GDD49sx14FH97HGEehmi7JFYdzz9hu3xDQfeV3uApOf6f9LIE2ZjWl+HrCikH/NfEU6AVzj0sF9VLKnO90EHWdvvqUqnXVgZgC++QHRM92hnxG5hSLPaNg0T0wPODZ4u3+CnRTU5bENoYcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868788; c=relaxed/simple;
	bh=H+eO9x3o3HEzJ/TzO+DsdmWT3RV0fOgkKgDt/oqEfgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaLvzJs/FfMyqmpe8EJSxAY0SUeb5h3Ept9wvXYJyTip7IXPViESqijZO6D3b1dpJvzAl+WI7CVWoMsnqwgPEYUpBq+pCDK7QshlgCME3C0xC7NPl9OpNEmrFyndWt/XsTWlgR1Rq6NDYMOs5E4T8aGl/ohkl6gcsSu56dS4gp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IeEIjADn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b2c4331c50eso5720840a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753868786; x=1754473586; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+eO9x3o3HEzJ/TzO+DsdmWT3RV0fOgkKgDt/oqEfgY=;
        b=IeEIjADnIsZRJHEvX0Ff3yrE69ga2mchAMoSSv/uX0bCI/xWcO8tTiM7/yp3ZmamR3
         vUn73nXzCTgHpJnjde/rjqyRE4voZhBXKFr09aDqmWL/c0eKqO0Mu1LdlBoBPOBhi25j
         Jx+TpAyXnbO67CzEdIJPvXhxRg0Mb8DZSO6K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753868786; x=1754473586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+eO9x3o3HEzJ/TzO+DsdmWT3RV0fOgkKgDt/oqEfgY=;
        b=N/71J95fkvbtm5QJPkvNrqz9zVEaA5Ik8lpLHrd1Df2slDQHUMsB294+n9UwS268eW
         P/YlYFGOAec4hL/VxY5kFzgh0oVnI//D8Dn2AgCTETR2FeTpXu/UoiIwedsVB4AdWYLL
         anZ221m8U/SgRSTXgfNj4Wy9OnMZuKTYvZXLydXywbMx0KVEk4Mi7LKED26nGLEfVs8J
         OayoXhuQJfqIpUTRBpOIlnkFijdW3vpoc9FBqQQJIyjM5nudaiJ791l0yes+X6Uzmm2O
         58CeNUntSu0wzAeQ9R2D1fVJhqL1vTOlBU1AgyOJuDYhsH7RsbtUuqXgTJVWelaU60+g
         1WXw==
X-Forwarded-Encrypted: i=1; AJvYcCWAjog80aLVtOecwQgP0wSkbv+m0gei281iNGGHtGpkvpEdqdrrrbqgFFVny72We8ey/WJGZQ27OhHTTnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWZ5jBq01dnj0itAWloj61Wxm2XAyO0UmQCzWV1Z0zbEKdSmq
	QWG5i1bS5R2JQiCTKHBF17vX0j/XIEg0ihB2N5EC+hbwhj/bbrIwMvSdSRQd9Ywsdw==
X-Gm-Gg: ASbGnctuZT0fZwGgk3gCjFfq1618UoHre8Zdqf6Ll9oTl+EatZeMAk8mGL8mpVXhTmR
	PzqDSx9mlkBhu/zD3qQL63Jl6daz07odoOTSzdDcViNihVFVH6UD6VAmeGZFuFXrmdFOLC7cpqe
	bxfDtAaLUOqyAgKzmcTo8KuS3J6PjhckdhN7Y1/0NUv3yEArLh5oMypPEmbUnnHSyJsF5OMcJbu
	decwH0XC8hrVosB4yD/gb1/iZo/yd+KFNdCqkYQwi41USm/ZHQDQ+DWEqmyY5yBo1ipGNVTlHIJ
	4DolMd90svvufBL3Zb2rYljHrGyNX7v0PKtpn4XFUMaUPmaYjZZ0Z2szrbV9fuTpztgJpTqbnkG
	HUr/0NiiI6xw8moWJjgpi1a+x
X-Google-Smtp-Source: AGHT+IFgY9h8F6GUsk225KEHiyu3fwtF8TCpp6Kf4pGAPEDn2NXvnjYf1fNZ2RD3Wd6uEQ5dGgopjg==
X-Received: by 2002:a17:903:4b2d:b0:240:8323:365e with SMTP id d9443c01a7336-24096b455fcmr41642675ad.47.1753868786505;
        Wed, 30 Jul 2025 02:46:26 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2c3sm70641035ad.30.2025.07.30.02.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 02:46:26 -0700 (PDT)
Date: Wed, 30 Jul 2025 18:46:20 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Joel Granados <joel.granados@kernel.org>, 
	Anna Schumaker <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Yongliang Gao <leonylgao@tencent.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-ID: <iln7qlvkza24tpcre6emzsjxjynotew6iha6pshg3c3yiz65ef@oculodcngg6y>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
 <174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
 <tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
 <392dc660-b4b0-4a0e-8e70-51e19c62589c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392dc660-b4b0-4a0e-8e70-51e19c62589c@linux.dev>

On (25/07/30 17:22), Lance Yang wrote:
[..]
> We should also consider that in many real-world cases, the blocking
> chain is just one level deep

I don't know if this is the case, but consider example:

- task T1 owns lock L1 and is blocked (e.g. on a very huge/slow I/O)
- tasks T2..TN are blocked on L1

There will be N backtraces of T1, with every T2..TN backtrace, which
on a system with small pstore or very slow serial console can in theory
be a little problematic.

