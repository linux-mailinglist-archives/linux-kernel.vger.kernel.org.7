Return-Path: <linux-kernel+bounces-771314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876B6B2856A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D45DB05C60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81624DD11;
	Fri, 15 Aug 2025 17:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7K630qx"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C23A8F7
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755280402; cv=none; b=pVai8kjgpy7y76OV6DsDqXLv/uBa88PQU1m24U8dglNQFQo4FgrYUAqexz+duFM8e5WMR0jin1zhZ/53ZjpPeqepktYW0TGUgpIy2h6SCLQl635bOWaWI0eDjm+z9SPZl56fpJSuLCHwuwSP1zACceMBeg6PRTlvbJTWNUvuuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755280402; c=relaxed/simple;
	bh=abWFleF15VeAMD0iYFeMYoF5y/t4lrPeiLNzaQBX23Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qIJOBvoaNc/ddpePMNI3kGVYv617f/Q3mVs34lIzr+54QPj4Uq9n0xeE2DTT9tYDX19jdMjtc1QRuwumudOjlAkB1RMDFXNEjmgs4GKJUs2nmrdTdPO/HbQLw3d/MMSu9yLLYJuZSztT+GOxy4DNWrSIEmhGZGcZQEGvz4xSg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7K630qx; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9e4140f38so286158f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755280399; x=1755885199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JnR+6SXeSTNJPAcPnfPZyM/O5krw9O4MexFcLYOmRkI=;
        b=W7K630qxL8wHsi/q7Um+PDCkj82bxzE3tFs0zdL5q6q4Q+vsUUyK+Z71XK0wRIsnJg
         aUSSevxxJNz77J7L1ECRC6Sm7kTqYHgp+d0Uj5ZPHt0J8jHaxF/KHAV2xRmWrs/heGkZ
         juk76GkvtliNRzo4vOqRaWceudJ5kEKhNlJCAUim8v1Nw4XFP3TuyjNw7osz/eHSQ46m
         8rANjMnzID8Ql1IvQld1B9A1z0OryR1jW2l5mnSOUg0FbzgEQ6mwQs/i6ndBnx4UajDw
         gb46P1ejZh1vEbc9oCLIWaRhkPrlCn3MPg81W0ZVGIRhrW2dzinV9pM1b8E9MVITFRRt
         wMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755280399; x=1755885199;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JnR+6SXeSTNJPAcPnfPZyM/O5krw9O4MexFcLYOmRkI=;
        b=McxikuUl7ishLkCwAgc98XJcGwDYF0zNv9V52fHw+zDR9Tm7Egrq25MHVysEdqt5ql
         tsmGyMUedK9HBtZJQB8cKHwqSBD2/870ecAh/Uw02bUHFd8rPeVgVFHA3EMlUKbTb+Ko
         71AkJLrgOMAuwXcbyvWSbCUCSs9nL7Sk8o9dAMLeFAobaK+JPmipWhMI0d9JHp5kmoPn
         gatoBXFViK8LMT3VbaqvBX0GzvzMpNc2Q3OH2lUdCH4frigxHIXBFg7P18La4LgC+a+w
         N5Fe8jkaQxZMqApqsHNLo1u+yFMUT6TzqTai/nIIFj/SHtjKgrG4YyRuOGLEeZbvhEB9
         Bg8g==
X-Forwarded-Encrypted: i=1; AJvYcCWo+9Vx3HOcogLPpoq/aHf2ZGjFqVd++LnvZY/Kmgmz0rB+KfHxcPypWFTPEiz54VpHQNI4HmRPccun5Ag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9W8m8vBSgL1PJNAfc4OqhMycRWYUaCUl9v9Kfx33n04mDXN9P
	rJnVtLwwNop+TqhUtwQ3KMRjiyKWjdaewWup0NFhOOtx4FAlJ3sCbjsE
X-Gm-Gg: ASbGncubNtwOEauSM7VkoIEQkQ8g4fr20dvKT6HUNEkIfQUfSHlrlfqIXkSYxgeq6re
	qUe2pvrQ8VBqnSegkcPdn+3ICYvObw7mqw1aoBKAXFLUyOpH4EYaxz9gKjf0DkylChTZnk7X1Pf
	zZ0/Ggr+5sqMtHbf3MELxJaOi5anXCICV18mj8G3pScDBKuNfd+QGJnpjjwEvVY5FClJ5lpkB4Y
	l6q62PsMcjvVToClHh0qqk/FUc5wo9TqjqOk992TXbepYRP6vgBL7QRDJ2mfKACPFsZm3iz8PYl
	0KEyCAJR5PTmmvaJeD/NyxdHY7h0YrBpKMXyPducMhqntHRiZ1YJx+wP5soHvRn1DMVS4AYHA68
	Rr9XjGMiX8QVkKUimRJtEK5/sJUxrzC6l4chUcFI=
X-Google-Smtp-Source: AGHT+IGHvEYjsDpgg5kr7y8uLGzdNDDOiuYK8jstfDIjhTKBkrII2jX1JM5xw1E1LLuCJ7d0kCYKZw==
X-Received: by 2002:a05:6000:420d:b0:3b7:88a1:19d8 with SMTP id ffacd0b85a97d-3bb671f50d0mr1170662f8f.6.1755280398846;
        Fri, 15 Aug 2025 10:53:18 -0700 (PDT)
Received: from [127.0.0.1] ([185.70.53.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758441sm2696079f8f.13.2025.08.15.10.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 10:53:18 -0700 (PDT)
Date: Fri, 15 Aug 2025 21:53:15 +0400
From: gio <giorgitchankvetadze1997@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, zhongjinji@honor.com
CC: linux-mm@kvack.org, mhocko@suse.com, rientjes@google.com,
 shakeel.butt@linux.dev, npache@redhat.com, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
 dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
 liam.howlett@oracle.com, liulu.liu@honor.com, feng.han@honor.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_3/3=5D_mm/oom=5Fk?=
 =?US-ASCII?Q?ill=3A_Have_the_OOM_reaper_and?=
 =?US-ASCII?Q?_exit=5Fmmap=28=29_traverse_the_m?=
 =?US-ASCII?Q?aple_tree_in_opposite_orders?=
User-Agent: Thunderbird for Android
In-Reply-To: <1CAF2012-C9A4-44E1-BEB1-A1ECE0BC0C3E@gmail.com>
References: <20250814135555.17493-1-zhongjinji@honor.com> <20250814135555.17493-4-zhongjinji@honor.com> <20250814160914.7a4622ae1370092dde11c5f2@linux-foundation.org> <1CAF2012-C9A4-44E1-BEB1-A1ECE0BC0C3E@gmail.com>
Message-ID: <0A987E18-9E43-4ED9-BE02-EFCD8D6BC528@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I believe the patch should be accepted=2E While the race condition might be=
 rare in simple workloads, it can become significant in containerized syste=
ms or Android devices=2E The proposed solution is simple, low-risk, and dir=
ectly addresses the identified problem with minimal code changes=2E

On August 15, 2025 9:52:17 PM GMT+04:00, gio <giorgitchankvetadze1997@gmai=
l=2Ecom> wrote:
>I believe the patch should be accepted=2E While the race condition might =
be rare in simple workloads, it can become significant in containerized sys=
tems or Android devices=2E The proposed solution is simple, low-risk, and d=
irectly addresses the identified problem with minimal code changes=2E
>
>On August 15, 2025 3:09:14 AM GMT+04:00, Andrew Morton <akpm@linux-founda=
tion=2Eorg> wrote:
>>On Thu, 14 Aug 2025 21:55:55 +0800 <zhongjinji@honor=2Ecom> wrote:
>>
>>> When a process is OOM killed, if the OOM reaper and the thread running
>>> exit_mmap() execute at the same time, both will traverse the vma's map=
le
>>> tree along the same path=2E They may easily unmap the same vma, causin=
g them
>>> to compete for the pte spinlock=2E This increases unnecessary load, ca=
using
>>> the execution time of the OOM reaper and the thread running exit_mmap(=
) to
>>> increase=2E
>>
>>Please tell me what I'm missing here=2E
>>
>>OOM kills are a rare event=2E  And this race sounds like it will rarely
>>occur even if an oom-killing is happening=2E  And the delay will be
>>relatively short=2E
>>
>>If I'm correct then we're addressing rare*rare*small, so why bother?
>>
>>> When a process exits, exit_mmap() traverses the vma's maple tree from =
low to high
>>> address=2E To reduce the chance of unmapping the same vma simultaneous=
ly,
>>> the OOM reaper should traverse vma's tree from high to low address=2E =
This reduces
>>> lock contention when unmapping the same vma=2E
>>
>>Sharing some before-and-after runtime measurements would be useful=2E  O=
r
>>at least, detailed anecdotes=2E
>>
>>

