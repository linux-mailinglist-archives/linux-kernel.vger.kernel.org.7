Return-Path: <linux-kernel+bounces-778868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61594B2EC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0E73A3166
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9282D94AD;
	Thu, 21 Aug 2025 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDYgn13X"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD121805E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747718; cv=none; b=Dc/i8pnJfMET/LJHgfdyl+vakgC93V9nFBpsv3+D3JTlAL+Y7hzAB7emZE1UA1S11pQ1lK/8tPEZ+B55/2irn4XhG3czflFUFv9+BHXKCDv8+KIRsSWYav8/d072BPAaXQ71uIbQSXFG1uDXghOvOzcCn8KdVhQYukXvON9H6h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747718; c=relaxed/simple;
	bh=YiwkmmbsLbpvcvYhIyLFGdSVD8nnf2CMSbS+teXFHDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alOigTlAKOVn9GMVzuuiV+sI7ghkNhQXSk7fCUY6sMHV6Z8HIegkPGURdG+o9GmO6fvv8pM5INEBubwFMBJiUBdJn5fiZ/OyTViQD2Str3DBjKCN6vjvPBPCnDWFRfocE4gJyVkKFPVYjsl5kdk91yFiY1x1+VhU7RmFpXskwCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDYgn13X; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b471738daabso442418a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755747716; x=1756352516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRLfDVwYP4ZCgK56gRuVbf3v6A1tlVDw7Fe7cw3dhoQ=;
        b=kDYgn13X8LN/o1sM7Kqi6K5SWBcZiN12bCRA9ULRMcCX4L/CvpqJpnru9QP0YHMBk+
         fBR8kWtF0klWUkeZwjhSY9ubdOfF2xmazY3KMvGCBT19O9Z/RNTzFowb8vHlkX3hftra
         EoPimEZFnEu84T42G57vrtIPbFliNCDbpi8EAXDN5HpfKuoRjWu5rzkks40ElM6BNkBL
         OIvy+GdMXAyiwirDfymqY22fCJtCXTV4CgfEUWtJjZ9B7pcXDv3R24LJjsrtjklTckWa
         yonTDxNbSrBXnEILHHZyyTDcc3Go8BvJBFr6B0/J+k73gAF96t1mfL9uVje7G3OuCe29
         y91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747716; x=1756352516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRLfDVwYP4ZCgK56gRuVbf3v6A1tlVDw7Fe7cw3dhoQ=;
        b=xUT8MISJKDmZsOsGZJnVnYNp1B2as1hgpD8B7eXlA6DUQzo5J0T/LqNntfhadTFasx
         gQW2pj4dwB6X1p0g2/Ym/tj8KjIhrabVTaVukjsQoQcGf5xcfTAL+2nvjejIS+HB1wOf
         aI7wB7SKTYxrl82jhSZ6iCcSpTDlnEDTPXmJYWycH6uFuij/vIz5gRELcHABYB1/f53p
         atl3d3w6BFu46KwDSZLPuZg5tC65Tsd8nf+jzUAlhrAOPelQTkaZffjXKZ5yUZk/Y5+Z
         +hgj24V99nqd+H7J8ZpMcESpt1biRodbdlpsA5j3lkKia9X2g0ArCE31Q4IHNVGI6VSC
         2A7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZIXmaUzZ3apEAA86vPjeQq2dTQ5QUE+yZ46DjvgcebxRZbC9+pWDtTias7s5VCQVPuGhFYY6DDi+fXVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAeUqee1YzJwJ5OZMkPUPNX3A3EI+dPfkM+6Ad0WWp6ZkJ3BZc
	o3uhWry41ydGX1T/YOXx9x+HNLZqU61HaYJZ24by93gO7GyUJI+ZcuBc
X-Gm-Gg: ASbGncvzOWVBA30hM8j1hl45YxpMmnnW3RrIGSf/7t/wZV4kWsw0mCMKu2opOeS6OOT
	4hykML6gsFeaeEKq6HBN1R3cTud406DJXxfBUO646JquEE6w4/FV8PdySy7PfwahjTcupFfVlF5
	I5jYOZamv5m9gE8J4mzILJUT63jtuuCMoVdQ2WaRHHrrt9tqwlykvbtTE6B7rmgSIA4hEdXOSFO
	X8PkfoQooVjfZOdiZ9T+od1kOOX1Pv5VdtC00ENMEWNCuZOe4fvgrsBdd9a+bpJznx6VOaMqHH3
	u+r0P+vG4vzQzqdbOb1dH0aXxq1fwe5EnGWFeUKlVIlHIhKhoP7L5rGaWJEDCoaYImBRTxjE/zY
	7/EF/JKJl9jyi5z4=
X-Google-Smtp-Source: AGHT+IGHVc1FTNUDeFUsPOjRM4aR3LLXqdfdYwjrp5/bYhy1+SZ1tq+Kh46WSZHKBqSXtdOxVJeNpg==
X-Received: by 2002:a17:902:d54e:b0:240:469d:beb0 with SMTP id d9443c01a7336-245fed7e65amr15261125ad.31.1755747715733;
        Wed, 20 Aug 2025 20:41:55 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:6::3058])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51aa14sm40806585ad.145.2025.08.20.20.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 20:41:55 -0700 (PDT)
Message-ID: <3bfd0f8c-cda1-40fb-9642-bd305d3ff98f@gmail.com>
Date: Thu, 21 Aug 2025 11:41:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] crash_core: use panic_try_start() in crash_kexec()
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: pmladek@suse.com, akpm@linux-foundation.org,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com,
 joel.granados@kernel.org, john.ogness@linutronix.de, namcao@linutronix.de,
 sravankumarlpu@gmail.com, kexec@lists.infradead.org
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <aKaHvnxEaXF/fLnW@MiWiFi-R3L-srv>
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <aKaHvnxEaXF/fLnW@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 10:43, Baoquan He wrote:
> On 08/20/25 at 05:14pm, Jinchao Wang wrote:
>> crash_kexec() had its own code to exclude
>> parallel execution by setting panic_cpu.
>> This is already handled by panic_try_start().
>>
>> Switch to panic_try_start() to remove the
>> duplication and keep the logic consistent.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> 
> I had to use b4 to grab back the whole patchset, but I can't comment on
> other patches, especially the patch 1.
> 
> Firstly, this series looks interesting. It does enhance code
> readibility. But I am a vim user, I like open code on this one line of
> code wrapping. So leave this to other reviewers to decide if this should
> be accepted.
> 
> Secondly, the lines of your patch log are too short, it's not convenient
> for reading. Can you set your mail writer to change this.
> 
Thanks for the feedback. I will make sure to set my email client to use 
a wider line length for future patches.
> Thirdly, please add people to CC in all patches. I don't know why you
> only CC me in patch 3 if the whole patchset is related to crash and
> panic.
I use git send-email, which automatically adds the To and Cc headers 
based on these two configuration lines:
	tocmd = "scripts/get_maintainer.pl --norolestats --nol"
	ccCmd = "scripts/get_maintainer.pl --norolestats --nom"
It seems this isn't working very well. I'll find another configuration 
for the toCmd/ccCmd.
I would be very grateful if you could share your configuration or commands.

-- 
Best regards,
Jinchao

