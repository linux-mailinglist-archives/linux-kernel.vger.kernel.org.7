Return-Path: <linux-kernel+bounces-890339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E7C3FD52
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 13:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BEA9F34C059
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 12:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069512F49E3;
	Fri,  7 Nov 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="jiP0aSTQ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D032F3254AB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762516870; cv=none; b=VXoDO5Q+TCo/rFD0xvxwrssUQ+y4ln8p6IGzZTnN3ImKU7zQ7UWnFqf6urb77xuVD2LSVPVvm79EakyOusIVukadoMYYdMgN96NfAGSBUY9PVGY13KgJkgQqZ+Cd/btPI9MC1LkpkXtOUYZHzvAGFZ2y+UOl1/5TpUAEF37ztSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762516870; c=relaxed/simple;
	bh=53FxiJ2qQpY1dafOedja4bq8nuIV5SHVfyMnsMguH1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH6mQ+8nRpeSMyz39Y6ycDtjQPaMTaVKAloqgQy11a0JrHCUBLJlsOTCNlZ1nfP5SRWU9+wXZZu6mg9FTjgYxRrdRlIgLRs+q7SHdlcEvqcqygPCASycMBvhj1SrljX5F2IFoXvsw1w9yk7P0AWgq3S6qL0AzfOXzs5/0llY+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=jiP0aSTQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-641458f71ffso865140a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 04:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762516864; x=1763121664; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lUsVfRHnhaTc6L0mfrJ+S8eMrRvLqjKV9gyOwEzhVzo=;
        b=jiP0aSTQhjUnZZiq/Imd+J35NHxKl3C3rZ420Tufrz3qqJInPyaOMzu++ms2YSVRmT
         Zw9W0Km8UR5lIJsZoGhB193gQ2Ugoi1LFonVe9eam6aVzHqTWsv9rpIzBqa9N+EVqen+
         JkImJ7NEdlTk4TZJxhHsg0NfOi2l45JxVa2ihjBbH9kDWvCO5M8+4DUaIr+RXmDDwDbp
         sAPu/eIzaQLfQcZZlTgr9gPoKn/LYIL9Z9fgHR+65O4Y3oyoO4hERctncBr42mikwJ+R
         PtoytRv6/1IqLJDkk2X/m/nZ4sFFR5uXBubyeKXtvMkSgaXlNyBhA8IRhSQNJpLa2exx
         uISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762516864; x=1763121664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUsVfRHnhaTc6L0mfrJ+S8eMrRvLqjKV9gyOwEzhVzo=;
        b=BRlRRL4KC85DlAZE2ORbNKZfm6hr6nA7GXPWzA4hz01R1t9V7jHB5VPua25m4tiQJ2
         kRdb8lifXXicpHmyy/ylFu2iFmMI4uF2F5twZMG1YWPAsiTezmZtmzZfxKfh5of7r9GQ
         8GNeFa3D11dNC7Wis2ZJ6PF1ox3Xqn+PH2ZJgvWWetnunTEFxD2uSAtn0+F1eBStKAoS
         lt8/+PiNFt0PqUWuxunrklCoOQbP0lxcB1v41FkdR5jh04ZMkX+sWWhM2P6BdllqYhR6
         AotvMzAUAUpvfw5+NyRWaodP7GB/qNGdFjjuyg/O8Xo+zTHislfLAlufVyROtWCW9t6q
         J14A==
X-Forwarded-Encrypted: i=1; AJvYcCX8EAZuqArq29O63hmlpEV83y0mqtAgh9qMdXd/M1h7aUrE5slpz/FVnTZoOYLn3+YOrKiM3BZnwafuSKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeb5V4u5/zPUTu6qmHatvdRUKA7imVpgvWyXG9Lj4P999etaeA
	1uBKsgBO9Q3kGPdYR7uyz3jl6YXIy44CUEZhaid9RihfJslw7bKMzXmgXHr4dl4Pjc6O9KVDYRh
	f3mDj/xFfgDh8bNAQWJe7JDLHBviZP8/Gq5rxae42HA==
X-Gm-Gg: ASbGncsnfKDcOh64Kh282M8zAP7BKGZRZN0AnV9IeiY5J6vZhFf6LIQc1+nBJdLlORC
	NSD7KJgLfnfFAI0DrIw45n8nw4aXKIhJr9s9PK+qMNPXgQXUTEJyS0a/bdhe53ZXAsqM2q/VbxF
	I/mbHyM5ZaH2+vAA9gJmAm3MFQxgJHi7/BXzNVD8hm/jKICNn1yzLcLcceYMnnNswOU3jgSWg4O
	2KdoIyXmpdHKrl0djJo6AU51UHNf0iRKl55LBD6NDvD/UfB+HliGKm2JlhL1udUpY2k
X-Google-Smtp-Source: AGHT+IF9pn2F0a39L7q6vQA1QNL5mEmZPkN59pguhs34CMH4Kd6QJlTFZpAj3QhY1fmeJmLCWP6NNkx5xTN4CeVBEd4=
X-Received: by 2002:a05:6402:518b:b0:640:9b62:a8bb with SMTP id
 4fb4d7f45d1cf-6413f063ab1mr2470983a12.22.1762516863928; Fri, 07 Nov 2025
 04:01:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
 <20251101142325.1326536-2-pasha.tatashin@soleen.com> <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
In-Reply-To: <d7651272-f979-4972-ae41-bab2faa8473a@linux.dev>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 7 Nov 2025 07:00:27 -0500
X-Gm-Features: AWmQ_bkI8wIkZ7GC8hYGylBjaXrBxtU3ZeBWwhoHk2_ITShMsozqrZ6SHuSvZSc
Message-ID: <CA+CK2bDSvtuwrrXGOC07Rj42yGFHWR4Sse7Q5z1z8f1ZFHWQ2Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/9] kho: make debugfs interface optional
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org, 
	tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hi, Pasha
>
> In our previous discussion, we talked about counting the number of times
> the kernel is rebooted via kexec. At that time, you suggested adding a
> variable in debugfs to keep track of this count.
> However, since debugfs is now optional, where would be an appropriate
> place to store this variable?

It is an optional config and can still be enabled if the live update
reboot number value needs to be accessed through debugfs. However,
given that debugfs does not guarantee a stable interface, tooling
should not be built to require these interfaces.

In the WIP LUO [1] I have, I pr_info() the live update number during
boot and also store it in the incoming LUO FDT tree, which can also be
accessed through this optional debugfs interface.

The pr_info message appears like this during boot:
[    0.000000] luo: Retrieved live update data, liveupdate number: 17

Pasha

