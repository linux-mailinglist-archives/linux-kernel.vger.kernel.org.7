Return-Path: <linux-kernel+bounces-756759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF51B1B8E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5504F17A99E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA3279333;
	Tue,  5 Aug 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVFuy2Bn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF22AD14
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413419; cv=none; b=L81XFnN4cSQQ7fhPKZqjZbRC4ja8GlSS2c9RwinSRKxSzweNsH5rix1qQzthn3M7ixXNA+hDJnn5IQdKnSEBSegvhM13esx5Oo+4++x8mNpJx1dJokSEEMYBHzSeJKiltlUxY6GD7sQK8xEV1F05kj+BtGlGN3g1V5+6tYrpDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413419; c=relaxed/simple;
	bh=Kh56pL20T7H5zlhh9Vn7vZ2/KCtiWdU2V/izuigl+nM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HfH7e9BQyzu7UF+uyog4AGLB8w4yYY9YkNMyG78TNSU4EpSohtgvQXBjS/51AJGRuG2LTIfJoJAUsqtCgahlcoG6GtIiH4dsEBP6qd48N58PzhGdrtLbUnFnm2aK+4RkwXdV9lvTOmn35wgSaivceL7z41qj0UVWRxt1GC5I+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVFuy2Bn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754413416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbVVoGaAB5mP5RybMnrtLIB1JKz2+YRNMZHEyFUTSmw=;
	b=EVFuy2BnqoVMoKsaS0LikDTqB5Mlgt9KAO/PetsFbgE8QctrypnnGaAKYqYlwvT9vCOnoT
	C7yZVBppUGjebaSDMnrxw4WVUyH97S6+S8EBhEhw83oRi8daH+VJhJNi8zFLSRln42qOlW
	mmdaJgFBvfAnRfjuppYimWFp/AbG2qI=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-p_B9ua1jPfKu7QbYKeHcNg-1; Tue, 05 Aug 2025 13:03:32 -0400
X-MC-Unique: p_B9ua1jPfKu7QbYKeHcNg-1
X-Mimecast-MFC-AGG-ID: p_B9ua1jPfKu7QbYKeHcNg_1754413411
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-30bbadb3f41so2098796fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754413411; x=1755018211;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbVVoGaAB5mP5RybMnrtLIB1JKz2+YRNMZHEyFUTSmw=;
        b=Ma9JSRsdCE0aGCjfsRtg87/Q8meZ+36JToM03iLFyzHuaXauvBBebJeJOi9H7SIRcY
         ed4NpaRhAtYSWc5WJ7xWlzKHr788c1oJVDlJh7JIaEqaypOedpUpCcYqJBnHEpfzeO9Y
         lxyDxjtyMp0R/eQdMeU6jqvO/E/GZBteAGG9MrGbUskwm32YdxgSYYeXHimuqLBwQQgm
         BqT2gQgSLAIFobtVj2GAdu4qGbOj0OgtOg9fC0grPGI5k28rD7od7R5NyuDtSmWvPn4i
         h5YCWq6Y/9iGvviO42brSlG7kJLIzNfGiva7C0lEaf6+pFIkqAGqedu+Xa8mavfXVD6f
         WgpA==
X-Gm-Message-State: AOJu0YwLbI/MqD0JvWEy49Vh0ZhtneUydxu0qq6PHO3OopZdx7FBoxqe
	+bJTLduUGt3DP5HHm15CjloLSYGLMh6Wwr25m6p6lLKybe7F6PWpIXA9ZY4ZpjreLpe48uDKNZu
	ystemUrmYVVYviIw6i4xI04HLuNuqx/pIHWYUHdHJHSESIAM2zkTwddTTQP+LyQKPnQ==
X-Gm-Gg: ASbGncumUQXS+mHW2H7x30O64b8UxNLlXab0iXhzmoFikiccMq5bWjtMQfqsuHAN/Jj
	ry5d3V+J28bUDwWjD50R+ldZCYTbMaVudpfr3u2ejxZ5lrMCQb5p/r4tA8hicrls29KBftF1M+t
	tMjbGgMASmuYySQra6i+gL3tDM2EByyXOoVjd6A3EYWBcV4vRByd+PhzQJ5/wtjEcySmgFwdtlO
	YdkpukmAl+FXLHsNzZvMv4kbgb4w2tNjuYIt2pZwjNY6CMn5e8nDFYWcFkugjFYQ1yXB1KphpYk
	AhHlxmo7oBg0pwW9q2o29duyvwgM/sSO
X-Received: by 2002:a05:6871:2317:b0:2f3:4720:f7ca with SMTP id 586e51a60fabf-30b67628183mr8873977fac.2.1754413411372;
        Tue, 05 Aug 2025 10:03:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc+1OdQM+G/winnp5rPILb3JTMTlJWC5iVwWvIxlu/QYRJKW6ClokbBNAn1HhCL44Xbq8bxQ==
X-Received: by 2002:a05:6871:2317:b0:2f3:4720:f7ca with SMTP id 586e51a60fabf-30b67628183mr8873915fac.2.1754413410937;
        Tue, 05 Aug 2025 10:03:30 -0700 (PDT)
Received: from [10.2.0.2] ([146.70.8.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-742fa231cefsm434274a34.45.2025.08.05.10.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 10:03:30 -0700 (PDT)
Message-ID: <d6588ae2-0fdb-480d-8448-9c993fdc2563@redhat.com>
Date: Tue, 5 Aug 2025 12:03:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: fix mount options not being applied
From: Eric Sandeen <sandeen@redhat.com>
To: Charalampos Mitrodimas <charmitro@posteo.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
 <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
Content-Language: en-US
In-Reply-To: <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 12:22 PM, Eric Sandeen wrote:
> On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
>> Mount options (uid, gid, mode) are silently ignored when debugfs is
>> mounted. This is a regression introduced during the conversion to the
>> new mount API.
>>
>> When the mount API conversion was done, the line that sets
>> sb->s_fs_info to the parsed options was removed. This causes
>> debugfs_apply_options() to operate on a NULL pointer.
>>
>> As an example, with the bug the "mode" mount option is ignored:
>>
>>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>>   $ mount | grep debugfs_test
>>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>>   $ ls -ld /tmp/debugfs_test
>>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test
> 
> Argh. So, this looks a lot like the issue that got fixed for tracefs in:
> 
> e4d32142d1de tracing: Fix tracefs mount options
> 
> Let me look at this; tracefs & debugfs are quite similar, so perhaps
> keeping the fix consistent would make sense as well but I'll dig
> into it a bit more.

So, yes - a fix following the pattern of e4d32142d1de does seem to resolve
this issue.

However, I think we might be playing whack-a-mole here (fixing one fs at a time,
when the problem is systemic) among filesystems that use get_tree_single()
and have configurable options. For example, pstore:

# umount /sys/fs/pstore 

# mount -t pstore -o kmsg_bytes=65536 none /sys/fs/pstore
# mount | grep pstore
none on /sys/fs/pstore type pstore (rw,relatime,seclabel)

# mount -o remount,kmsg_bytes=65536 /sys/fs/pstore
# mount | grep pstore
none on /sys/fs/pstore type pstore (rw,relatime,seclabel,kmsg_bytes=65536)
#

I think gadgetfs most likely has the same problem but I'm not yet sure
how to test that.

I have no real objection to merging your patch, though I like the
consistency of following e4d32142d1de a bit more. But I think we should
find a graceful solution so that any filesystem using get_tree_single
can avoid this pitfall, if possible.

-Eric


