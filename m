Return-Path: <linux-kernel+bounces-896841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69849C5158E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E08188C8EA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E262FD7A8;
	Wed, 12 Nov 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euNYJl9Z"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457A26CE04
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939606; cv=none; b=DVyzG+SqtWydcznbc0zDXzIpONhJxwkA8iSDIzmvTHwpgyrqfhgUY2QeEC4KLEOpwehD9/ZKGCE+XJvrdGGgubVvgnQQsENUXE651nQPrQzRcdqZRdCGIGJ9DDUcnFTNfyRdZx7tcI6iULTy0v3uR8gQMIqu6lTMZmF2NEGcu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939606; c=relaxed/simple;
	bh=13U7AVC+v5UBTnrbtBPdFJDstqOHomUS2ScWYjnJ9zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKZv++yV0Gu6qXdezKn+NP36ayGp9YLx/K6gCF4cNYr62rPdL1ICUnJn2LHF5oZt9v+YWksnM+6509BGo79wGp/46qe2ktj/fDDua+9V/j8RfaMQjFvtbyhr+3chSkAy2GATxAbJvLELBXZn2G1shfRc7DyF4eum/rrEUHSNrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euNYJl9Z; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7880686d178so6747677b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762939604; x=1763544404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=13U7AVC+v5UBTnrbtBPdFJDstqOHomUS2ScWYjnJ9zw=;
        b=euNYJl9ZPbauanN8nO67FCtuHDkt/SsxxTJpPhT8Fqrk8cH52AKRx6jy6VJV+LcTdg
         +UVWfR1+JXaZ2pIAGnr61azQ355SNuQZfg62DRMDlDuV4/6irSYFZ6IyGjKix8dHhj5i
         wIQ0VOTb+9pPCMfEnTtcgIeWF6WUk1X32WAtH+6M9lSpQpMgqIF6uJ2OVYyLl8wblBLK
         0hywloITwE7CH/zMpYlO7Vz0a/UfDNeVADTGtQ3WmBxw9hZyNPpyrndBJy5irkGJY2/k
         tM4PUDIhtf52LxzTJtqTq0PSOS0mt3Z8XG980ItvaUJmvKGU6M1CsOowhfkf7ntV3LRc
         /b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762939604; x=1763544404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13U7AVC+v5UBTnrbtBPdFJDstqOHomUS2ScWYjnJ9zw=;
        b=LnKpie3C1VTPikCCA/VjZsY+BvSeD0eBYjaqNLRkNnvxz+BFTwQ7KdpsP0EL1aolgH
         4xrZNbWY/k3vXy9HJXwtjQ9p9hFak0zGsYoWHmMi2Kma8JXbKCEWxwNDEXhTYgb6ba6P
         Xt1gO9DrtMNgom057sdyjOPI9f9Dvy/taVdh9Vn0N81AdeY9A5NaSsGaYn7WEqASuGwX
         0kEIseE5B9JbHCIeSdNj9cEB4AqDztvEQ/hZvW3BRA8c67VXCSN3c8BEppdhmCv8gxaH
         q6tvNNAdd9G6E8ALE2zzDXf9hgeP3H9hZKUdI6pLSDmLXCxMNUDzySrSs3Ynp5srKgHj
         QXjA==
X-Forwarded-Encrypted: i=1; AJvYcCVVgn7mWo074cqv4SFtZzHKbic6w4KU16g4qwvLKkB4VNKoWtFoWfcLQBEt4iOu5VQ0ETT9L0phl7TK9r8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJX3SAsSSZdSXhAQRsFqzhTAbKluzVpMMZNvAy0lZL2uh1EJSm
	Vzxxg68h4hbSaZ0QsWLdNChp4XrOTtnwsOSJWcNeeFWcWazOtyVgofP94GnmviV6GxP9FiPnZfa
	/OrkD5rJ9Ljz+XUKg5dd/C+x/ceGBX3U=
X-Gm-Gg: ASbGncvwXiMDwJYSBnPi7iZheBriAvGzWU1KvRtlXJJ4fgmjx7D67/Ff2g7IZE7+LjL
	WqlLYWF5tpS63/kIar2vo/cb8k3cB+BDoWrzTgdfxNtPGnvdzAhm7ZQU1iM5iIUmJw94+XuXrl4
	GcZf+BTD5EGvl0Q5ddUnFPlF6xBR7S54My1a2ZSvIDRDWPLh5qYTbsb7C7Kp1BH+zKGidzDfdoE
	bNKqfFjXYvWRUyfy8QrzxV6sOKW5umxak2MuuEvHm99mEfUKm+BN9kZ+iodrxpM8WBiIM+Q6S83
	lLdYa5vTeiQhP+yjlQ==
X-Google-Smtp-Source: AGHT+IFeg2Gqvtsptiri6ePX3FBgv70zi6fuHZ1BwTdto3EYCmKxE4YFDolr1iUmWcSeBCbWwr8e8FtaD2C0e2n3xP0=
X-Received: by 2002:a05:690c:a742:b0:784:a232:b3d9 with SMTP id
 00721157ae682-78813621726mr15697227b3.18.1762939604074; Wed, 12 Nov 2025
 01:26:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112031631.2315651-1-kartikey406@gmail.com>
 <2a10f8c9-dbdf-7bac-b387-e134890983df@google.com> <aRRPvn4DYAhuGtq3@localhost.localdomain>
In-Reply-To: <aRRPvn4DYAhuGtq3@localhost.localdomain>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Wed, 12 Nov 2025 14:56:32 +0530
X-Gm-Features: AWmQ_bmaI_JIe64abNiasFhIiNWEIeB6vR-Ar5fHJ7UfN9zGaffX73JU93uBIJ0
Message-ID: <CADhLXY7-62Q51_fCXs01kiZ5u=qpieXJbjqrJnvwGEpaR37khg@mail.gmail.com>
Subject: Re: [PATCH] mm/memfd: clear hugetlb pages on allocation
To: Oscar Salvador <osalvador@suse.de>
Cc: Hugh Dickins <hughd@google.com>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>, 
	baolin.wang@linux.alibaba.com, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Oscar,

Thank you for catching these issues!

I have a question about scope: Should I fix all three issues (zeroing,
locking, uptodate) in a single patch for v2, or would you prefer:

1. My current patch for just the zeroing (security fix), and
2. A separate follow-up patch for the locking and uptodate issues?

I'm happy to do either - just want to make sure I'm following the preferred
approach for the mm subsystem.



Thanks,
Deepanshu

