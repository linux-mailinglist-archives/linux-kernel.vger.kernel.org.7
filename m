Return-Path: <linux-kernel+bounces-791643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA6B3B99A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 13:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCD66869C9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4492D12E4;
	Fri, 29 Aug 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Fo8KVRxS"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1563101D7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756465441; cv=none; b=NdEqiPNQ1GvmtHmWLmX9H7BZFbjvHy9a4VkiyUvo4tEX2p88VvePeEnFoRzYW2izlRJv32H0/OKRpyjjrmirIa4hFlJAlyNDXuJ2jW4O9vUqNx9AFNzggsFJoAM83BVUD5I/OhRlXaJ1EqfabbNihcxkcSrRI2Dj1ROx1sc1gR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756465441; c=relaxed/simple;
	bh=YuYDNgvmByukeEjHw0NdzkrN0QNksChG2e5fXtNTVOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFn5DkGkFL3NIcfImasCGr8QVmUYM7Qo/OPhCI/nE3FxS/iRqgL3vP+umlmNy+RC3LCOuP59xdCh3BNUCUKgSkn/f0SheVcIX/6c8ikonZsdjKmex6F+LUYkgmJND+NS4vlOhBFngoIrDCAaB+NpW9EWO3C1NmIk+7/I5mAhk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Fo8KVRxS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-244580523a0so20412395ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 04:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756465438; x=1757070238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IIaSrq6Dx+kKyeLRsgFivteR1euTnImW9J7nYHhbSJY=;
        b=Fo8KVRxScIwX+4IqOcKVSQHK1GhgE8u2mNSZg4G9BHU7ACOZqWvF8NBWtYa15l4mW5
         GH17rSSfyQ4f5ng1MU8iTh8sFBPWNC5errVy18VTnFoL7V283SRbuHEizeSji9nXXu5N
         mF45k8F4KgGYl5AaBugVTZv0C+/X9WkUCy8NR1aiDEGDAUZr8iEo5++XWT7dQoBKOGtq
         fjVKeKI9Z0SV3NmtU6bsDC0yal2pv3n71guX7emGh11zbIJCHM6RkPcIpBzQ226OHCiy
         lDs/SDCxlDviy3P892hOlrolmZg7J/lCmDWdZDEDgD//CEIJsOwlMqLyUDdvB4saV2Jh
         imfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756465438; x=1757070238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIaSrq6Dx+kKyeLRsgFivteR1euTnImW9J7nYHhbSJY=;
        b=LMrFClDAPKrnUDme+WBkZzfsz79NGx73PQnSpUGCwaPuphYkDdz7zph96ydbUcgBRA
         NRYsIZ9dUVCm1kMGF4iHnJGaAZa3B+Y7I2gjgadRdBLFD692uFKT3tloNgdwOvyjZwG9
         jyQXbZsnfI/IiJRBYkDRJjsTKJpWMJ6sTcT0sw9u9EmkAHFbNYKEeqOcyDk+uQ8Q6b+P
         mNyshdi9voCX1WSc0lSKar9sPz1KMAkqwmVzThHYJ0ocj/IlLzK33dbUZn31Pq3ngkKs
         Vz8dGwL8JK5ABDCaGvTjRpbme/FTh8gW6Xx6Z1mAD1fNNpuYJB5Q8rMO0Ej+lvRcsgAS
         1iHA==
X-Forwarded-Encrypted: i=1; AJvYcCVW+fiEhJ0qI8/z6gQdNKN9DieNHkAV0kNVvR0i/JBO0trEBoV+5oIesPuNn9PaM0GZmHrGlBq3WOMCvEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83BEfvuBP/XiuTKyqv/1rPs+PsIJQpf/Tts2mYd15+UmOXdwx
	s83hGB8HgxQehEDZ09ihWjvAiyCWTfK03ZEs2Jqz9rb3YiP3K3dqcl1WH06fH5BpCxk=
X-Gm-Gg: ASbGncvkOBw2uXpNylBz1LSCNpK3poWX22jg5peGJTtqozXisoXDb8X2cQVudkmqo4S
	ePfUtAtyTkMA9LBOmpZq4UYzIo4mAXBWeL7tJNskv2W5b8/6pi4eeHmYx/Uop8opbW2ovzzZV8b
	dCT+TvVJrIRGRQ3AuFlWEt3uyIjGhEeBs9BA4VNBxoFXyg1+FzLlxy6NtCKYVb3ydTOelocAfPk
	gxv7B1OEnl9DdOHOzGIEMsGvmNAJjp0ozKj/bKzkBfBd0Kl3DZvl3vfihOwF/DcuV1wTWyZAAKK
	6ccf+GS3KCdViUpti9Rl8AYn2V0IUz88BhWE9sE2ncJsyMbkwUP8bxpesXcufgfyOLeDBayu9mB
	5Y9DrZquaDUeOWNPOC8VI
X-Google-Smtp-Source: AGHT+IEzZ/p9as3nrF9ljeFhdkvVqD0Z2ro3p43Bl/n630t9nzydCZuiImxupdC2b+91pZmC3AWS0g==
X-Received: by 2002:a17:903:38cf:b0:248:aa0d:bb25 with SMTP id d9443c01a7336-248aa0dc43amr125044695ad.14.1756465437860;
        Fri, 29 Aug 2025 04:03:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f5925adsm7949756a91.10.2025.08.29.04.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 04:03:57 -0700 (PDT)
Message-ID: <6c85f96a-f012-48e9-a2fa-f1c7650d8533@kernel.dk>
Date: Fri, 29 Aug 2025 05:03:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add RWF_NOSIGNAL flag for pwritev2
To: Lauri Vasama <git@vasama.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Simon Horman <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250827133901.1820771-1-git@vasama.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250827133901.1820771-1-git@vasama.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 7:39 AM, Lauri Vasama wrote:
> For a user mode library to avoid generating SIGPIPE signals (e.g.
> because this behaviour is not portable across operating systems) is
> cumbersome. It is generally bad form to change the process-wide signal
> mask in a library, so a local solution is needed instead.
> 
> For I/O performed directly using system calls (synchronous or readiness
> based asynchronous) this currently involves applying a thread-specific
> signal mask before the operation and reverting it afterwards. This can be
> avoided when it is known that the file descriptor refers to neither a
> pipe nor a socket, but a conservative implementation must always apply
> the mask. This incurs the cost of two additional system calls. In the
> case of sockets, the existing MSG_NOSIGNAL flag can be used with send.
> 
> For asynchronous I/O performed using io_uring, currently the only option
> (apart from MSG_NOSIGNAL for sockets), is to mask SIGPIPE entirely in the
> call to io_uring_enter. Thankfully io_uring_enter takes a signal mask, so
> only a single syscall is needed. However, copying the signal mask on
> every call incurs a non-zero performance penalty. Furthermore, this mask
> applies to all completions, meaning that if the non-signaling behaviour
> is desired only for some subset of operations, the desired signals must
> be raised manually from user-mode depending on the completed operation.
> 
> Add RWF_NOSIGNAL flag for pwritev2. This flag prevents the SIGPIPE signal
> from being raised when writing on disconnected pipes or sockets. The flag
> is handled directly by the pipe filesystem and converted to the existing
> MSG_NOSIGNAL flag for sockets.

LGTM, only curiosity is why this hasn't been added before.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

