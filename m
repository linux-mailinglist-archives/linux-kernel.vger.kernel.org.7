Return-Path: <linux-kernel+bounces-811857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9BDB52EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D707B541A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 10:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC0311C3A;
	Thu, 11 Sep 2025 10:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQLCx6Fv"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2621A30FF24
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586929; cv=none; b=U0jNnZHJvuZVayXR5xGA7myyd047wcIR0RmiucYJQuYIjKQyCnRwxlMN0IwAzmDxgReZXc1SX5BVyIMEy+Vl+C+oKoNxorP3W1iKYxYmoJdNvRf1x05yKJn5S4GeCq8TXxZ9vT4Oz5/YFROWAf8CVrUO+y3W7ka56VGxCho7TUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586929; c=relaxed/simple;
	bh=NzjvQr6rV1cevgVkpV00QD1jvnHGMRHpxgPDgwVwLS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ML/TnsjdfUAD6uNfBhHgSfnovgKV5pFadtbbS+gcm482/8aursCKZjA/DfdG6UyefiHs+8fT+4pipXHTuAC+6uVvCFz//uH4TALG11RHAyRHoEW+Fl50uJvI3nY+KZXr8ufeOT7go5nRY0vusA+ef9ZDCSSbyXXMlNgtlg7c82o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQLCx6Fv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e46fac8421so554124f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757586925; x=1758191725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3QIFLOxMByJvrZI6HVvtXh95FMJYleRWcofa9ARvHs=;
        b=YQLCx6FvsiJHVS91wo4LkZttjojgIAmiO645sjGYpiBtjd7uuHPvo5UOk0ZbhxaPSD
         oPmnM2eIich+PLhYR0ce0bURYsaEIfsJK+asdcItoYqSIHbde0jl5j2YD7EOKh/ctFr4
         vFS0X6bz+YMFF/tZP3+vuQ/pTTIFAjRGLXr02IOPFPKYfToNMPsQaM6G6aW0C3jlwz7N
         kdbreSucRe5HdPKcldDpOQIaYZSbVqteXjODgsDchxhZw3xeFmyuDErGltC21ikx7IPM
         xm/ECTP4V4NHnqOD+yPMm8BMjFBQKqhAS1t9H4rqyb3qOUqs+SViX/TH2TkitEeJ3leD
         SJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586925; x=1758191725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3QIFLOxMByJvrZI6HVvtXh95FMJYleRWcofa9ARvHs=;
        b=AJOuMtkWSgo8MmAti3lFDAWauKuk3yXVl6ir+0zJex1KhvLs1Zvhm+ZisUYasYk0zV
         f2Fn4ydCD2CFJfHSmQSQ+PqZP5j45jSdA7DuP6S3UNMHdRLv/MHAlAkrz4ZoXN54kwKh
         SomgDWIxUl6uAacXq9MrO9kgpAASpj3W7jrzMWJ7yq1fdt9CYt4XaE/3LFZ4CeZSWCh6
         tV6oLVqRprE4oVbSX4Po6ac95YaioTf4NM8DPHuvVacV/wqYsF+H+XGDulZHIml5abrE
         TJzywRZLCcL1I5+ZwMdTqsML30llsyPpPjQku5MEaODvYy1g6+mrJqtWgQWKHxU3Z6NZ
         ioNg==
X-Forwarded-Encrypted: i=1; AJvYcCXXbMuC80pzpOkym6KABHgQ4hDU0oXkTbKpDe2AxNlW/PNR4Luy3beSWbVTnZYx6R+AttFTAmeOg7yvzrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfqhx1fvdov8yYU/hHgBcwIEbqSHdg+D2RewtH5FXUfaenwbbc
	BIm6URPWe3GADXszg8lTahMSCzRrbZk/OzgxITr2kV6ZHnfwVywgc6WQ
X-Gm-Gg: ASbGnctzRckZA/k9Gs8lGaxIjKGOAlQ1uUGKL6H7Q/HGO6nnAJxK/i0BxyDfHWIcJef
	CRd8eZG7q0f5bC3PszNmY+fSalqUndM6ZAccXlBzrGk0wKlP7yGng3u/nLfkdTi0NbvIB8RkmRK
	zvmWFlYsMvITMsQyXpR5HbpkWZroxqjVwbSSor9zbtoEx1+kx7CTGbtHQDhhRiFRg4yOrWxiuSw
	NIUeLQNzTOQoft6pZ4T8Y1CBfk2VIuOrQZo9QSphNefIcCUeMlNHIavyP+UIT7rFn576tJvqfhy
	5lYIAg94V8vcJiBU/wPMOycQMzPK+8ZOc8nbpwbgj6e/K4K0M+F8523enkbF77tRNWu/5TE5yuK
	TlptMhKonCmJArLVhh8YEdL7R/jzJw7RywBjxZHzxpZZiXKrNEhulCJY=
X-Google-Smtp-Source: AGHT+IEpg855pXrJAxI90+Zc9nkr98MEs3QrsGiSbSEuFuNMmc5eb3m/bwuHini65CsMQz26CwVdeA==
X-Received: by 2002:a5d:5886:0:b0:3dc:1473:18bc with SMTP id ffacd0b85a97d-3e62a3067b1mr15626783f8f.0.1757586925191;
        Thu, 11 Sep 2025 03:35:25 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:a309])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760776bb8sm1989682f8f.3.2025.09.11.03.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 03:35:24 -0700 (PDT)
Message-ID: <0ea91968-f0fc-4e6d-9910-c9802b4227aa@gmail.com>
Date: Thu, 11 Sep 2025 11:36:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] io_uring: avoid uring_lock for
 IORING_SETUP_SINGLE_ISSUER
To: Jens Axboe <axboe@kernel.dk>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904170902.2624135-1-csander@purestorage.com>
 <175742490970.76494.10067269818248850302.b4-ty@kernel.dk>
 <fe312d71-c546-4250-a730-79c23a92e028@gmail.com>
 <5d41be18-d8a4-4060-aa04-8b9d03731586@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5d41be18-d8a4-4060-aa04-8b9d03731586@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/25 16:36, Jens Axboe wrote:
> On 9/10/25 5:57 AM, Pavel Begunkov wrote:
>> On 9/9/25 14:35, Jens Axboe wrote:
>>>
>>> On Thu, 04 Sep 2025 11:08:57 -0600, Caleb Sander Mateos wrote:
>>>> As far as I can tell, setting IORING_SETUP_SINGLE_ISSUER when creating
>>>> an io_uring doesn't actually enable any additional optimizations (aside
>>>> from being a requirement for IORING_SETUP_DEFER_TASKRUN). This series
>>>> leverages IORING_SETUP_SINGLE_ISSUER's guarantee that only one task
>>>> submits SQEs to skip taking the uring_lock mutex in the submission and
>>>> task work paths.
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/5] io_uring: don't include filetable.h in io_uring.h
>>>         commit: 5d4c52bfa8cdc1dc1ff701246e662be3f43a3fe1
>>> [2/5] io_uring/rsrc: respect submitter_task in io_register_clone_buffers()
>>>         commit: 2f076a453f75de691a081c89bce31b530153d53b
>>> [3/5] io_uring: clear IORING_SETUP_SINGLE_ISSUER for IORING_SETUP_SQPOLL
>>>         commit: 6f5a203998fcf43df1d43f60657d264d1918cdcd
>>> [4/5] io_uring: factor out uring_lock helpers
>>>         commit: 7940a4f3394a6af801af3f2bcd1d491a71a7631d
>>> [5/5] io_uring: avoid uring_lock for IORING_SETUP_SINGLE_ISSUER
>>>         commit: 4cc292a0faf1f0755935aebc9b288ce578d0ced2
>>
>> FWIW, from a glance that should be quite broken, there is a bunch of
>> bits protected from parallel use by the lock. I described this
>> optimisation few years back around when first introduced SINGLE_ISSUER
>> and the DEFER_TASKRUN locking model, but to this day think it's not
>> worth it as it'll be a major pain for any future changes. It would've
>> been more feasible if links wasn't a thing. Though, none of it is
>> my problem anymore, and I'm not insisting.
> 
> Hmm yes, was actually pondering this last night as well and was going
> to take a closer look today as I have a flight coming up. I'll leave
> them in there for now just to see if syzbot finds anything, and take

Better not to? People are already nervous about security / bugs,
and there is no ambiguity how and where it's wrong. Also because
it breaks uapi in a couple places, with at least one of them
being a security hole.

> that closer look and see if it's salvageable for now or if we just need
> a new revised take on this.

-- 
Pavel Begunkov


