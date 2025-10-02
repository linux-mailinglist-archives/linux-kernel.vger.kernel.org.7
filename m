Return-Path: <linux-kernel+bounces-840520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A5FBB4991
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC119E2DC3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6626A1C4;
	Thu,  2 Oct 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FY3HUZKr"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC59239E9A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424059; cv=none; b=Zf7K8FKBwrZuhXB3f45T/Hq94tjjsuaMzSOxqu1hbcMRO03azKizJvtSrXGM1F58loKoOjfbofdZiMjK0K5sbJzCavoT7U5C+QmLhixd6GJIeiWatp993B2UR0YLfvpvI6EmwGkDRc3zQ20hfzxziRQtajEzGZ0GlH4d3vI6wKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424059; c=relaxed/simple;
	bh=DWu5dR4Lz86S2AgggcpTnA6S7OA/C7uP7lj7+WsDpqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfPYGtIj4ZPwwZq5v1bYbUmday0jEOlSJm0i1N3jRvlWc0rl0FXxk2x4Xc0gN7WI8WdVQDpcHiD7UdE8pvfjOI9ZyAHcSEkEpxsTE5or+p+lHmLDeHno/I3r0QMoovw9A00DUedrYCUmdYBCYP4cc6kIpNkYRnHvoQmUfRcGvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FY3HUZKr; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-9379a062ca8so38183339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759424056; x=1760028856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFqI3aHr2jj4uIbXpxHrhOEHaGHnaMLl/UipyF4uEpg=;
        b=FY3HUZKrjXbRq3WYTVv67dRMW4u+ydDODm4vlKWtOezuDNistJfyte0yLQxdnNZd6b
         YkC3zOH9GvXEw2+wHvVFepKTMLuoKjLOn4GAnX/NXX1whdFh2dFWk/HTrlBSZj+33PT9
         MpZfbbwKDViQq42JVyog79bW9VCbdpXO5Rg09uPl18x4vATRlwriw+tkvE6PWxKpydKI
         wKMkQQ4GTWYaGVyFAtSEHh0doLB2XdnR7WoPZedm5ihdmfHIpcUhgGzToQLOz5heMnBK
         AEyrruTVurB1HI6tHWc5sn+VUJXdaPizc3SCwQNY2wcZ+MV8Jyq1XIMskQHo+d/1MynD
         BkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424056; x=1760028856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFqI3aHr2jj4uIbXpxHrhOEHaGHnaMLl/UipyF4uEpg=;
        b=VjJ3TAR+CoYbIN1ABiHIqbHJSO4LotiZy6np0sE/d9alydyGmxF2dxfKcu/kAYB14+
         gZqytaMhuZeTEVJbFs+uvLPWb/trl3P7f70nh6u/pOCQLvCs4cYM4Y+A6kAz9MnrBPfA
         Yij1GRczy7YlfQVB4eeTfiCJuUOOzjrKOWGyZbZ6M7+5pwSPKfkWcYdQAVURvdSgHIU5
         P9flV+Y/AdyIJaUVpc4+rrNXEIrd/iy1baLIdcMvRVRGQ6nOJ9TtyHAAlUGlmI2HCyRH
         p1w9rENIoRFf5OKOEtVzDEuplFC5T7FfJDUPW2m47OwlZCcOi1MzwGxjxCTd4Fkmx/xF
         3D4g==
X-Forwarded-Encrypted: i=1; AJvYcCX9PO2Jye4HTsEpYJU0MaUQMWlmic+QMhoco/CEfRXDnUwT6kgnuRX0rkRaeWCtzzZt6LwMzc35JNrOKQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBEpzdAp2kpCpKaDIL8dp9y1kecfUjFfUC4GeVWqwnHz55j2g
	LVaRdKB8iS1ZQta2E5CVlzJEjj6jgQMxOahX2Suf37Q1UUW5eHDU78E+U6iGm99FhLQ=
X-Gm-Gg: ASbGnctiC/Yd1MUhaTN2F0jQ/p+d7wtH0xcYo24Mgf4jLWqa8K8iH/9/zm6Xjph44G3
	ya8mnSc3KU2fdo++6oiZ98q+tgUj11UO6+FgPzTOwqU8sgNOBlW7gZSPqR2mrNK8zCg7KPfKvsp
	AOB84FqmwPG2yTNNIMQHw3kHxgzliGR8F21QGXIr7seCmh6bLHkqFQcg1qxiG7LK76BJmYNKP8r
	/ZwI43sNaHpL1NFh38VVfMro8/3IJnNJARLJfcyVIxLLb0LtlyJNXx+QdU0uF9IAmdfmh6lLuDE
	VQGy8BS+jH9e9Qii84XUM9gQtKai+BMB2vubxWHMe8ff2m9lLoOq+aIwMjmc5JPaSksfxUN5W4s
	WhswqmnJgXrBdhQIBT24dAKy33KFhsahy/2KIV1l3v2KU
X-Google-Smtp-Source: AGHT+IHH+bU75feOc3kd43cHHM5DdNH15l/a1Pxl+MA4svn7zHgpfz9FVBhHlZNAnl8YqGJNYlTTlQ==
X-Received: by 2002:a05:6e02:1988:b0:424:80f2:2a8 with SMTP id e9e14a558f8ab-42e7acef8bdmr2852995ab.3.1759424055705;
        Thu, 02 Oct 2025 09:54:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ea805c7sm1005335173.32.2025.10.02.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 09:54:15 -0700 (PDT)
Message-ID: <4054d4b9-29ca-4164-933a-49143755089f@kernel.dk>
Date: Thu, 2 Oct 2025 10:54:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>,
 linux-block@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, hch@lst.de, ming.lei@redhat.com, hare@suse.de,
 sth@linux.ibm.com, gjoyce@ibm.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250730074614.2537382-1-nilay@linux.ibm.com>
 <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com>
 <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com>
 <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
 <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 10:49 AM, Linus Torvalds wrote:
> On Thu, 2 Oct 2025 at 08:58, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Sorry missed thit - yes that should be enough, and agree we should get
>> it into stable. Still waiting on Linus to actually pull my trees though,
>> so we'll have to wait for that to happen first.
> 
> Literally next in my queue, so that will happen in minutes..

Perfect, thanks! That's what I get for not being able to send things
out early :-)

-- 
Jens Axboe


