Return-Path: <linux-kernel+bounces-850133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E8BD1FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43C344E123F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FBC2F2617;
	Mon, 13 Oct 2025 08:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uo7o9GOd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6E32F0694
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343439; cv=none; b=Mc8zG1xHEB9NPkqCV+wrJUcojtkv1xz1JzcSlCUm5vh8Bt6AOKZRj5mi5sdiiZTL1RK1Ed7Ck+UgrrIdfNgy/NbI3LHQx0Ab5P2DYmxkE2dLB3s8KUaKpMiao9Ign2+PafP53GrE9YQEHjtyZOjFdzy51avdfeAOZadJjnJxYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343439; c=relaxed/simple;
	bh=bbT9yOnrUpGxMOJQdhtTIrV7PDDNbFu+OWYMIHMr4KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArJfDW4H/ve3sSFS8CKeY/erUEriPvsD9oZhXpEVxGCfymImXSlAa32NgPUgqIU00sGK5gDUAQ7tuk5tggeiZWFUsKuJfHwVVLKl7N0SdVxhvMoPELmKlxC8xgXzzKvr2ZGdMFp3/gg+h2hbtERu3dzAxeNTLhBUDVkSzstNCL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uo7o9GOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760343432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iqj5d00jcHO4W9mBttRtSq9Cpy6KvXlw2OhtfpPjxks=;
	b=Uo7o9GOdLPaOqNMiv21/DtwqTUVxerwndyKtH+1YUe1bjvCQ695Hv38MUN5xw0Aa1lrkEa
	knb0r6S264hWEFHwb6CbYMP9tveBEzAyeLbHwRMyVMt60TczprCsWZfjDPJw3s1MjT5LdH
	ZZfMPzDsF/4xmpzB0lBhvmS59Ac2u7I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597--L9xzA45PYO_J08S3uQURg-1; Mon, 13 Oct 2025 04:17:11 -0400
X-MC-Unique: -L9xzA45PYO_J08S3uQURg-1
X-Mimecast-MFC-AGG-ID: -L9xzA45PYO_J08S3uQURg_1760343430
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-426c4d733c4so1854793f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343430; x=1760948230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqj5d00jcHO4W9mBttRtSq9Cpy6KvXlw2OhtfpPjxks=;
        b=Xsdy0AamPzGfY7EIa+BqsS+JOI/PSSbXq6LMxFm3kpviud4EP5hFHFgqUWbRvGk8Zc
         fAvwQYSWRNmc7/Pwc3KvE5mA96Tr4C9wvtw+bXZUr4Nu1e0FIWeoJKjoyquLees/2zSu
         zGtNnR0QnBwLFOXWZb/pNfQhR1M/CeGE+eWabIgwuT3cRUPamoaGGp7sXIkkYwXea1C2
         x1Bge/2OzBDMkTf+JCZ3hjuGc4f+tRgkbQsV/XcQc/xraTsfqVDEDtm8cPuTYiGwn4P5
         eeprpxpQVOCHRIp37hWXgxl6vxjqHSIyJ8SNSvkDUgJIMXtJLP7CgiGLN/N2oHDwZIAY
         0hhQ==
X-Forwarded-Encrypted: i=1; AJvYcCX262OZQ4wd0v/ZzLSUAxeWZa8FM+e8zQBjprf7l1dcfCuwQrNJxC4zi5vg/OmBeEsjbyY84z63DQtf9LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6FXwV4SgM2ITEytChv0TkE+HA3AoTM5oYQGRhoGrhtc5fn4Z
	ZgfJWBk5WKefnZMAsCJDRSEBkhvi+6v5PfJlVDD78ubozlW6hJGEQ/LxWiOReXAL5vd2cW69ISr
	lG8XAV8exUbKaXWIruq/PaOUf0f+puojwxulcsOrbJPQCBqvx94IhAdkNUg4Zrew8VQ==
X-Gm-Gg: ASbGncsqV3BeHr0T6D5pn59UbLHAVTAZrj/z4un1JKFcHRGs/UI2giVEJjDS7Z9t/We
	B/VK/Tldamx4cs5W3Kcx7I0tBpSiSZ6mAcbsFBTnpwxYrHxMERyIpuBKaQZt7INZehU3Ze4e3Wi
	75oqhXYl2uwp378KrHpsB49P7/S32WVjniYVno9it6ikXo8/NERVeJotUzyT3cllXZNEtD/XtqI
	L2ujCUT1DoGlnlfOOhUjZPjvKhjhQOdmimBzvIVn09JurPsiAzJQBULOlM61vV2Zx3jHwgS3LxN
	NOAMv9NN6P9ceyzI3/jOMMN2duQNU3ETOlgDq+eza8qR
X-Received: by 2002:a05:6000:4382:b0:3e8:94d3:765e with SMTP id ffacd0b85a97d-4266e8e6f33mr12096949f8f.61.1760343430203;
        Mon, 13 Oct 2025 01:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHNOu3j942TJx+SPp1N0vqDmsORYCRvGGBs28WUJxp2fKqfO/+R3TDIqKAKYVdaJfte8zuJQ==
X-Received: by 2002:a05:6000:4382:b0:3e8:94d3:765e with SMTP id ffacd0b85a97d-4266e8e6f33mr12096930f8f.61.1760343429832;
        Mon, 13 Oct 2025 01:17:09 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.153.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm17326350f8f.32.2025.10.13.01.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:17:09 -0700 (PDT)
Message-ID: <3480dcc9-a41a-4ae6-960d-4a13eed359e2@redhat.com>
Date: Mon, 13 Oct 2025 10:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in
 vring_map_one_sg
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 syzbot <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com>,
 eperezma@redhat.com, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev,
 xuanzhuo@linux.alibaba.com
References: <68e96ebf.050a0220.91a22.0177.GAE@google.com>
 <CACGkMEtnrayDWKFdJ1P22QyCrZuDK0C2LihhOtvhUyTOKSp_HQ@mail.gmail.com>
 <CACGkMEt0aJh1yAj+q1UNnXToLa_yGc9fT_HfeNptHsOQ7vXG+w@mail.gmail.com>
 <CACGkMEsh_j9wCAv-LwOVxLjvUzEuKuu+7ZGMGcdJr7ettdBYTQ@mail.gmail.com>
 <0f20cd6a-d9aa-4837-a120-1e2e7dbdc954@redhat.com>
 <20251013040810-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013040810-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/13/25 10:08 AM, Michael S. Tsirkin wrote:
> On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
>> On 10/13/25 9:20 AM, Jason Wang wrote:
>>> On Mon, Oct 13, 2025 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
>>>> On Sat, Oct 11, 2025 at 3:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>
>>>>> #syz test
>>>>>
>>>>> On Sat, Oct 11, 2025 at 4:38 AM syzbot
>>>>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>>>>
>>>> Paolo, it looks like the GSO tunnel features will leave uninitialized
>>>> vnet header field which trigger KMSAN warning.
>>>>
>>>> Please have a look at the patch (which has been tested by syzbot) or
>>>> propose another one.
>>>
>>> Forget the attachment.
>>
>> I have a few questions. The report mentions both UaF and uninit; the
>> patch addresses "just" the uninit access. It's not clear to me if and
>> how the UaF is addressed, and why/if it's related to the uninit access.
> 
> I'd like to understand that, too.

Somewhat related: the syzbot dashboard reports that the issue is no more
reproducible on plain Linus' tree:

https://syzkaller.appspot.com/bug?extid=ac856b8b866cca41352c

"""
* repros no longer work on HEAD.
"""

Possibly there was some external problem?

/P



