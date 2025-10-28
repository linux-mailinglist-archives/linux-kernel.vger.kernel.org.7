Return-Path: <linux-kernel+bounces-873070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA5BC12FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261DF3BEEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F612BD5B9;
	Tue, 28 Oct 2025 05:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dOzftIrO"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616E225F998
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629615; cv=none; b=staU8I4weNz7B1GVH2Ri1VerVq6CrA6rb6Ec5Lcz+Q6dyMe7IFuO3a1BtpnhfYC1qvmwGjQykoTCYKP/DO+XefsoPOEn11Vks+ARvF5JZNZzAzfI5yk9Tr2w50+12glJnkmzna2QV9ITKVmS4KmSzVYIuZ/cMgjCZn9QI8GqXpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629615; c=relaxed/simple;
	bh=+l4uaBwMtekNA8nK6ui8ldAW15jCbyYnOgjlIKh3+No=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ng5fNVR7JudL7HqBsv2XmTjBitvSIDVZg0ANCR3cV2LNdk7HPvfH9VOFYKlGBvQfys+0wLGx2hbErZBJtQdxmTtWMGTbK2l87io7p9DoXDbGvrwAJh5vRFHrYwjDu+AZiNGpg5zRqU1UabtS4uf6WOdAUxK8vfQq2G1svn8+cIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dOzftIrO; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so8772475a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761629612; x=1762234412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=978k93bL9MxlYRkaTWrSvPo0X/ixK1lZJ0FCxsOFego=;
        b=dOzftIrOp69r7UOSzZr3EhumDLgzsoJtMTj7CuY+JNWOP55f9lj2p1Iogcy5NEEFne
         hj5lgscJr+YOc2EHNgu3hwiDhInPsFMFnTY1zr8EZPSwdnCy+2V/OpmVDVlMuyvlxWy2
         wRlK3ZOCaWUfHRqxT/NSJHiJzVWlVLoHvAv33Kb+TMwWkRlDVl0qlPw8Jq0p6Z3N0uux
         SWhBV4di8U8KIC4JRPBl0/2SOoRCpqx+D5qJHSxZ6g3gLA1MiWg9cB0M2MDrw6HJFnO2
         440NjGByaMhjRGTw1T91Q4EqyAlLmKhJcu+beOq+sMj7lgZLcS2q/PYsT4aFCVTp8AB6
         rV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629612; x=1762234412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=978k93bL9MxlYRkaTWrSvPo0X/ixK1lZJ0FCxsOFego=;
        b=OcZW/W0F5cn5qbQNLuE5lS6mCphN+V3lwykWt8qOnBeU7KbR8GZWbJ/H5MP8qGtcxN
         Il/yGBHVbB6kxLPZ6P7qkBUxRfdGMNHexoDwKkvm0rcRtNChJrRgTr9lThWiESj19xTl
         wRHPLt3q5UGwB1DTcrCGx7hgKHojeTgvrg3s0LyJvMpXKi7FGf9rJ5bJUb8crdpXfFfq
         JrmXEigD6kHOK8h/AN62LVS90Sn4+1ucnsKpX+tEAAo5drn+FMuJshZM9Xl+Tt0Lttu7
         gVbDmjcqshOWBz+/F1jNCawP6h8fxnLxdmM8wQdxsRU76gGs/oXrdcaOLqtv/CaXBpke
         VH9w==
X-Forwarded-Encrypted: i=1; AJvYcCWTTbGH3vsl9yYopYNGKN3lO8exMKGtxikhoOESivYyhGtyL2uIH0gh2HBQdz9G7nXHxh5SJDd9jWJOlnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCEOX+QAFFOEN8J3mQDRRJdkV4fQgUFuRm5R7iytZcEY2J8jq
	DBulFoyf1Gs3rgJjaPwGCTcAhgC13lSpWF61374NfO7Hz0lwyo2lAqs1oE2rMOPkSS7yonw/lIK
	QFX8cVQ==
X-Google-Smtp-Source: AGHT+IEgPd1Vro8jar4YuvbY14ALahZ9RGAW96D7MCTDGrIDbCO1GDP/qete02Qehy0msaJmFvHad1jiwWY=
X-Received: from pjxx4.prod.google.com ([2002:a17:90b:58c4:b0:33d:98cb:883b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2290:b0:273:ab5f:a507
 with SMTP id d9443c01a7336-294cb394740mr35360685ad.21.1761629612502; Mon, 27
 Oct 2025 22:33:32 -0700 (PDT)
Date: Tue, 28 Oct 2025 05:32:13 +0000
In-Reply-To: <ea7552f1-842c-4bb8-b19e-0410bf18c305@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ea7552f1-842c-4bb8-b19e-0410bf18c305@intel.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028053330.2391078-1-kuniyu@google.com>
Subject: Re: [PATCH v1 2/2] epoll: Use __user_write_access_begin() and
 unsafe_put_user() in epoll_put_uevent().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: dave.hansen@intel.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, axboe@kernel.dk, bp@alien8.de, 
	brauner@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	dave.hansen@linux.intel.com, edumazet@google.com, hpa@zytor.com, 
	kuni1840@gmail.com, kuniyu@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mingo@redhat.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, palmer@dabbelt.com, pjw@kernel.org, 
	tglx@linutronix.de, torvalds@linux-foundation.org, will@kernel.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Dave Hansen <dave.hansen@intel.com>
Date: Fri, 24 Oct 2025 07:05:50 -0700
> On 10/23/25 22:16, Kuniyuki Iwashima wrote:
> >> This makes me nervous. The access_ok() check is quite a distance away.
> >> I'd kinda want to see some performance numbers before doing this. Is
> >> removing a single access_ok() even measurable?
> > I noticed I made a typo in commit message, s/tcp_rr/udp_rr/.
> > 
> > epoll_put_uevent() can be called multiple times in a single
> > epoll_wait(), and we can see 1.7% more pps on UDP even when
> > 1 thread has 1000 sockets only:
> > 
> > server: $ udp_rr --nolog -6 -F 1000 -T 1 -l 3600
> > client: $ udp_rr --nolog -6 -F 1000 -T 256 -l 3600 -c -H $SERVER
> > server: $ nstat > /dev/null; sleep 10; nstat | grep -i udp
> > 
> > Without patch (2 stac/clac):
> > Udp6InDatagrams                 2205209            0.0
> > 
> > With patch (1 stac/clac):
> > Udp6InDatagrams                 2242602            0.0
> 
> I'm totally with you about removing a stac/clac:
> 
> 	https://lore.kernel.org/lkml/20250228203722.CAEB63AC@davehans-spike.ostc.intel.com/
> 
> The thing I'm worried about is having the access_ok() so distant
> from the unsafe_put_user(). I'm wondering if this:
> 
> -	__user_write_access_begin(uevent, sizeof(*uevent));
> +	if (!user_write_access_begin(uevent, sizeof(*uevent))
> +		return NULL;
> 	unsafe_put_user(revents, &uevent->events, efault);
> 	unsafe_put_user(data, &uevent->data, efault);
> 	user_access_end();
> 
> is measurably slower than what was in your series. If it is
> not measurably slower, then the series gets simpler because it
> does not need to refactor user_write_access_begin(). It also ends
> up more obviously correct because the access check is closer to
> the unsafe_put_user() calls.
> 
> Also, the extra access_ok() is *much* cheaper than stac/clac.

Sorry for the late!

I rebased on 19ab0a22efbd and tested 4 versions on
AMD EPYC 7B12 machine:

 1) Base 19ab0a22efbd

 2) masked_user_access_begin()
    -> 97% pps and 96% calls of ep_try_send_events()

 3) user_write_access_begin() (Dave's diff above) (NEW)
    -> 102.2% pps and 103% calls of ep_try_send_events()

 4) __user_write_access_begin() (This patch)
    -> 102.4% pps and 103% calls of ep_try_send_events().

Interestingly user_write_access_begin() was as fast as
__user_write_access_begin() !

Also, as with the previous result, masked_user_access_begin()
was the worst somehow.

So, I'll drop patch 1 and post v2 with user_write_access_begin().

Thank you!


1) Base (19ab0a22efbd)

# nstat > /dev/null; sleep 10; nstat | grep -i udp
Udp6InDatagrams                 2184011            0.0

@ep_try_send_events_ns:
[256, 512)       2796601 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)         627863 |@@@@@@@@@@@                                         |
[1K, 2K)          166403 |@@@                                                 |
[2K, 4K)           10437 |                                                    |
[4K, 8K)            1396 |                                                    |
[8K, 16K)            116 |                                                    |


2) masked_user_access_begin() + masked_user_access_begin()
97% pps compared to 1).
96% calls of ep_try_send_events().

# nstat > /dev/null; sleep 10; nstat | grep -i udp
Udp6InDatagrams                 2120498            0.0

@ep_try_send_events_ns:
[256, 512)       2690803 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)         533750 |@@@@@@@@@@                                          |
[1K, 2K)          225969 |@@@@                                                |
[2K, 4K)           35176 |                                                    |
[4K, 8K)            2428 |                                                    |
[8K, 16K)            199 |                                                    |


3) user_write_access_begin()
102.2% pps compared to 1).
103% calls of ep_try_send_events().

# nstat > /dev/null; sleep 10; nstat | grep -i udp
Udp6InDatagrams                 2232730            0.0

@ep_try_send_events_ns:
[256, 512)       2900655 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)         622045 |@@@@@@@@@@@                                         |
[1K, 2K)          172831 |@@@                                                 |
[2K, 4K)           17687 |                                                    |
[4K, 8K)            1103 |                                                    |
[8K, 16K)            174 |                                                    |


4) __user_write_access_begin()
102.4% pps compared to 1).
103% calls of ep_try_send_events().

# nstat > /dev/null; sleep 10; nstat | grep -i udp
Udp6InDatagrams                 2238524            0.0

@ep_try_send_events_ns:
[256, 512)       2906752 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)         630199 |@@@@@@@@@@@                                         |
[1K, 2K)          161741 |@@                                                  |
[2K, 4K)           17141 |                                                    |
[4K, 8K)            1041 |                                                    |
[8K, 16K)             61 |                                                    |


