Return-Path: <linux-kernel+bounces-851916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF92BD79D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 08:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 415F61921065
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E032C237E;
	Tue, 14 Oct 2025 06:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCRvgqMe"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562FA26FA56
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424477; cv=none; b=GOrSzUs47U7sp49YnG8PedMwKquEm8Cba44U+2Q7HnGbXdD/76rv4cr8y47/6NnCbUmFZDUnlHLDYBYII+qS8C4vImefsM+/wGtdc71+WvA5j9WoZc4YllTEO2rzz4tYn1suNjaSFP2V78IUfgZPSAiqqcDgcI67YzdeOBmKQ+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424477; c=relaxed/simple;
	bh=T0wMiqSGwmsqLWJtb2GwPRS4IxEUHW2oFQEZ+rO9EU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPNiQw3lnmv4wXEXVNa+6g9ysUwGNZEJHc+Hu6ocggXnd9H4UJ2yi1ckW/0xQfz48sB9SJCdYh74r5VzSilzCr1wSzwojWTVxiQoe0F8qfrepLPz3pS/Wcls9TbBL3w5rWhCf0nQWmAGIxPs7TiNn9fygO8zcohj+MKXD6Amo18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCRvgqMe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760424475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HrRglR29VgZ69mKZr7Dx3Gx+zA5R/Z6gBu9e7njrIMA=;
	b=aCRvgqMezeprUYEyrrwhxniYL3N36C8gVg6r90oImwY0Ym+FMgn4gcXQEmQMasVEwtzAgx
	Ky3qXSz7X/R1erZP6OWz0F8t3GErXj+dacrJ20/s4BjkfUFyqNB1Ar6eZD2KYUOSJNQXRT
	L8Tw0jbauQ9mPS+uPuYTLRHB5z/6i5U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-UWRYsjyZMBKGgytfVLaUGQ-1; Tue, 14 Oct 2025 02:47:53 -0400
X-MC-Unique: UWRYsjyZMBKGgytfVLaUGQ-1
X-Mimecast-MFC-AGG-ID: UWRYsjyZMBKGgytfVLaUGQ_1760424472
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3efe4fcc9ccso4277126f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:47:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760424472; x=1761029272;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrRglR29VgZ69mKZr7Dx3Gx+zA5R/Z6gBu9e7njrIMA=;
        b=hTnE57jqYo/WebPS6QJZ6owM7/kKGlzKPYp3OhDcopgFLmsECVA4lqWBsJgynIwuom
         02lT8QY3zxyYpwyYGxbKB2Uplsi0Y5ntFKRK7CJiMBQk7VPqQFOzNMAW3naDqfF2m3uy
         QVhVV+ddUtWSwx2arbQGVkvhLE7XI70j1nvaS6PrDvujjYzbgcMSxVU8ra6EVTp1Uqn3
         u2Fo58zUi5eurOQEVciC/4Lw2Y5KhE+vTG1mOBJFHGRjw0yh5psie4Bp4e7N8uQc7Wwe
         RCC7dJPwDhu0tPCRBxB8r42pGU3cyYB+Ip/pRi1DjxKIlseTj7rsx/zFLUa1FG80G5vw
         YWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQiisVBwmJ1ESoV1Vqi0lOURNLkECRBdY6P8bH7cVQPKClTHwSPg5hlteLwr8NEe2f0HPwiYpWXWlysxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvkkPciwwwVaHfTNwOZwIErnyiHsOXUCv4rq9EIrgcvAUYRka
	hqlrc8eytcVB/lX7UPGibHsftVH1xHD5dC36gFclClMyxGJmsR8ZYXNfE9nGEO6aQPDvJS7XovG
	LXLrMN+pV33HUjuhBgt93+yHEWHlIvmNZaLSKMgA706OUh2v/sSCNpP3DxUzlqYmoVg==
X-Gm-Gg: ASbGncvlrvobnj6G5t1Pb77/P4Elt5kDXFbcmHM8ZDRg23NWiC2vF1GU5P0hZqdDCTb
	PkF5XPVgXjPlSSD9OsZ16BIoufEFX8x23kVVmAwcChGa/Y+GZx2EKycejyr8lgT2TFpqxs5f8Tr
	LI0M1sY1UIensLBgXYCiHGGFfhg8ZK3lJHMwziJ5FvRMq9dR0Zs2LzSDmfr692/dOojEOM0lb02
	OY9RNQNn1TfAzqh9SCCNItsz6tVvQG/Mg2CL1gp0vWf2YqA9B5iMh3A0IIJ8yQ4BDEvejuP+CrD
	I0jhzQQ1u2nD8MqBzpBzEnyYHydJ1lYJnklL0pdIzdKBBof2QmZHX+PS6tIYl43w6DVEpv8MZXr
	CdNAKjqcxMYcQ
X-Received: by 2002:a05:6000:2601:b0:3ec:b899:bc39 with SMTP id ffacd0b85a97d-4266e8e9004mr15793126f8f.58.1760424472528;
        Mon, 13 Oct 2025 23:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5JBS5UabB7QBXlAcwMrnWLbumJrspsJwc1HLfqZTziEYqtV5mFLLmgXxo6U+XgcAZ2uXW5A==
X-Received: by 2002:a05:6000:2601:b0:3ec:b899:bc39 with SMTP id ffacd0b85a97d-4266e8e9004mr15793115f8f.58.1760424472129;
        Mon, 13 Oct 2025 23:47:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e81d2sm22202178f8f.49.2025.10.13.23.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 23:47:51 -0700 (PDT)
Message-ID: <376fd3de-eb27-48ce-bdd5-86b0bca85ba7@redhat.com>
Date: Tue, 14 Oct 2025 08:47:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virt?] upstream test error: KMSAN: use-after-free in
 vring_map_one_sg
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
 <3480dcc9-a41a-4ae6-960d-4a13eed359e2@redhat.com>
 <CACGkMEucE6c=50egk=Hryie2fxZaEjFt22mLX20+T=68rFLNnw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEucE6c=50egk=Hryie2fxZaEjFt22mLX20+T=68rFLNnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/14/25 4:41 AM, Jason Wang wrote:
> On Mon, Oct 13, 2025 at 4:17 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 10/13/25 10:08 AM, Michael S. Tsirkin wrote:
>>> On Mon, Oct 13, 2025 at 09:37:29AM +0200, Paolo Abeni wrote:
>>>> On 10/13/25 9:20 AM, Jason Wang wrote:
>>>>> On Mon, Oct 13, 2025 at 1:29 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>> On Sat, Oct 11, 2025 at 3:40 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>
>>>>>>> #syz test
>>>>>>>
>>>>>>> On Sat, Oct 11, 2025 at 4:38 AM syzbot
>>>>>>> <syzbot+ac856b8b866cca41352c@syzkaller.appspotmail.com> wrote:
>>>>>>
>>>>>> Paolo, it looks like the GSO tunnel features will leave uninitialized
>>>>>> vnet header field which trigger KMSAN warning.
>>>>>>
>>>>>> Please have a look at the patch (which has been tested by syzbot) or
>>>>>> propose another one.
>>>>>
>>>>> Forget the attachment.
>>>>
>>>> I have a few questions. The report mentions both UaF and uninit; the
>>>> patch addresses "just" the uninit access. It's not clear to me if and
>>>> how the UaF is addressed, and why/if it's related to the uninit access.
>>>
>>> I'd like to understand that, too.
>>
>> Somewhat related: the syzbot dashboard reports that the issue is no more
>> reproducible on plain Linus' tree:
>>
>> https://syzkaller.appspot.com/bug?extid=ac856b8b866cca41352c
> 
> Interesting.
> 
>>
>> """
>> * repros no longer work on HEAD.
>> """
>>
>> Possibly there was some external problem?
> 
> I think at least we need to make sure no information as we did in
> virtio_net_hdr_from_skb():
> 
> static inline int virtio_net_hdr_from_skb(const struct sk_buff *skb,
>                                           struct virtio_net_hdr *hdr,
>                                           bool little_endian,
>                                           bool has_data_valid,
>                                           int vlan_hlen)
> {
>         memset(hdr, 0, sizeof(*hdr));   /* no info leak */

I agree it makes sense to fully initialize the
virtio_net_hdr_v1_hash_tunnel struct. I would prefer to individually
zero the related fields (as in your initial patch). Hopefully the
compiler is smart enough to generate a single 64bit store instruction.

Still the backtrace reported by syzbot makes little sense to me: "uninit
created" at skb free time?!? UaF ?!? I suggest avoiding explicitly
marking the syzbot report closed with the formal patch.

Thanks,

Paolo



