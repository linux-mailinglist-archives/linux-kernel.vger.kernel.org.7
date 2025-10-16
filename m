Return-Path: <linux-kernel+bounces-856179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8DBE3541
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5E6483CE2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE3B326D50;
	Thu, 16 Oct 2025 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5zRyjXE"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DC2E36F2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760617290; cv=none; b=Jh4LtcanioeiAvLktuBo37eiDdyvjNUSI2NYgJ8W265P9KsRvQGEnjXmDoGPeSTiKljf+p5Rk9INQYIHH3AMzMZ08FU+lVFAJ7BfIHcavL4DVHPUjDsukEKc6opP7JvZmkhPNk7K3DHu7PIbAtdUBBFg92aJwOOhHPyELBYePHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760617290; c=relaxed/simple;
	bh=KUh1qpUvCoRIVjcYMMGFdz9Txe84c3YMB61TU+pzTbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VQeBZSKQ7aCKUhmuUQ/0zf2emc1pfgSBM8xhIqHFQbiKeMP/bTHxIE2EiNG67puGq26mF/uMZ4akAETFxoViI/P5pRJXiQEQyiKZTE6YUb32aKC9Mp5/CNBZX49XMoxgQmB+2JVswR09w+nxm8Vj4A7SezNSump9hjgTkZ8mAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5zRyjXE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-471144baa7eso4270905e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760617287; x=1761222087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oj+7JVJzYt2MeESVToSk9PHEDGCUb9iXVkdTtzPmSsQ=;
        b=r5zRyjXE1B0kDx+bvGJFpp4HNqKiCW2b0vrGVRBcKHO7f2+G3oSXB6bvgSlzh2iFI/
         iNxZkrEa6j66w/+slCjiXStJEwzkb+ROxR1yDJOZssgThGNovSe8s6ljNLgUgBGJ4r6G
         O7rgDK/P7OjCQg5iwuycQ46THZ7B2f+w35K1LRxi6OWUaZzmM5Z/ZsJbFhIvcq270U93
         TLVkw0GBkb2BpXXOIv5gBNG9BXgnH6qrdgFARmyhUs/P4j1qg88+02VJKgLrvD026P67
         iu1ZQGEnubdnVi0Dh/cD/gzhqQMQj/6PKIgTE8lZ0TkvPgR+C+WNtWYQVGDf9Sj5tR26
         6yVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760617287; x=1761222087;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oj+7JVJzYt2MeESVToSk9PHEDGCUb9iXVkdTtzPmSsQ=;
        b=uy7eYkrt4yK9/8nkWpJ4M1CPyLGjLyR0YIb5Y51N3gw0gJMpzSnjnJAHHH90HSCY1q
         AAmbV3Tk/cE1Z7WTzqlBv+LjePFoLhNs8VrtLhb7REk6Z5Ohzp56+mztTxyV+LbTOhPs
         +cnk7HFpcAcb4ZNBeU0ThZy0z/fqdoaiyzYBv0+ryOU41wEz/fL53T/qASGl/7bVsKQU
         j1iBjLCLFqJmOdS3rfARO3c1nyIXxkvhIC+1HwnRK+m1V7JmKIoCi2muaP7vOhKJkv/6
         qMj7ZBmMIyzdGfopPdAigQGT1sn8WwSYYXFdwQifi0dj5WnqjeAu31jXlz9lV61/Qzak
         nRAA==
X-Forwarded-Encrypted: i=1; AJvYcCVpLcoPf39wNPYDgkOcmaF4Yq9qFLYGI4uDYyu0hJEJoTL6c9XhT5ydu18BbcOuDBPAKp4tmOcg8CKAMi4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysvu7YcvQQ5XrkHmV/clg69PEO/PdejQqh/vSlVgp2wVihLISc
	9Nj8paHYcwE+7IB1SruKHaE1BnhWnJeMSCyI6q1sTTZk+fJaj99JaJOJcHpmyVbsAKxYIijwUvJ
	OaBzppK2BUZm06Q==
X-Google-Smtp-Source: AGHT+IFS7L9sj6FgZTHTjlmwEWmHUin0eHTZ2sZonxDRhb5l6W76ulxICg9W5TzlkbO7bTUpRVPV/1k+qNgsxg==
X-Received: from wmo10.prod.google.com ([2002:a05:600c:230a:b0:46d:ab31:6ece])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f0c:b0:471:21:554a with SMTP id 5b1f17b1804b1-4710021568emr41282865e9.13.1760617285206;
 Thu, 16 Oct 2025 05:21:25 -0700 (PDT)
Date: Thu, 16 Oct 2025 12:21:24 +0000
In-Reply-To: <LV3PR12MB9265D0A464C2F597219A7B1294EBA@LV3PR12MB9265.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013143444.3999-1-david.kaplan@amd.com> <bjgjmijirueqwwmuen5dr6v7yqdcivk6kwa6gbukn3rodfcwko@fb5yxyqycena>
 <LV3PR12MB9265D0A464C2F597219A7B1294EBA@LV3PR12MB9265.namprd12.prod.outlook.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDJQQMISWO5N.3ODI2YXU5D1Z9@google.com>
Subject: Re: [RFC PATCH 00/56] Dynamic mitigations
From: Brendan Jackman <jackmanb@google.com>
To: "Kaplan, David" <David.Kaplan@amd.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue Oct 14, 2025 at 6:06 PM UTC, David Kaplan wrote:
>> From: Josh Poimboeuf <jpoimboe@kernel.org>
>> > There are several use cases that will benefit from dynamic mitigations=
:
>> >
>> > Use Cases
>> > ---------
>> > 1. Runtime Policy
>> >
>> > Some workflows rely on booting a generic kernel before customizing the=
 system.
>> > cloud-init is a popular example of this where a VM is started typicall=
y with
>> > default settings and then is customized based on a customer-provided
>> > configuration file.
>>
>> I'm not really a fan of this.  It adds complexity to some areas that are
>> already struggling with too much complexity.
>>
>> IMO this would need some REALLY strong justification, more than just
>> "hey, this makes things more convenient."
>>
>> The mitigations should be a "set it and forget it" thing.  I don't see
>> anything here which justifies the considerable maintenance burden this
>> would add for all existing and future mitigations.
>>
>
> The problem is there are environments like the one outlined where you can=
't just 'set it and forget it' because the kernel needs it set at boot-time=
, but in these environments you don't know how to configure the system unti=
l much later in boot.  So you end up running with the default settings all =
the time, even if you don't need them.  And the default settings can have s=
ignificant performance impacts in many cases.
>
> The cloud guys on this thread may be able to offer some additional color =
here since I believe that's where you're most likely to have this situation=
.
>
> --David Kaplan

There's definitely a desire for more dynamic control at Google too,
similar to what Boris said.

Getting the config right is tricky and let's not forget it's
fundamentally a moving target as David noted. Even without dependence on
cloud-init type stuff, it's very useful to be able to change mitigations
on a timescale that's faster than we can reboot hosts.=C2=A0

