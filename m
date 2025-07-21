Return-Path: <linux-kernel+bounces-739603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B493CB0C86E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB651651AB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBFC2DF3CC;
	Mon, 21 Jul 2025 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqrU+IEC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FB285075
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114086; cv=none; b=InIh8pDd/NxR/BrO+GCC3UC1KBCkYzsuTtDiIj2wOnSQs5zMsHUVyGNsuvrB9zH2ZXj3W1LwowGOU38XjR8PT/UbeQM5vZUBCiIY43o20uNKg32DJ45garzO3R+hMUFxyMcyE+OWJCWiAQbdKYBoTnkF+UXCu/7F7AyEPuy4sD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114086; c=relaxed/simple;
	bh=Qh7SUFf1B3cq7mTejXfSq7AWODMEWAbVmNisi4eu7ro=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=alkfMz2NMGlSHihldAdLo79ZT6UwOZ5Ijb7EXaLmNola7/WzYMlhX7fHHblmLVwmYJCNM5lKKoTbVzNpy55ei0dSjdXtdi1ztPueAovFA4qyWmimUUjUndtvyqQ/ZhWvt5E7xnke3+r5OaooaoZtjtZQMe66CKW7EfR2xz3FL9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqrU+IEC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753114083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cu9wGNux++7JCsJCsDX3KrdXqV88PlQmqNNIUVitAj0=;
	b=CqrU+IECKagzaMVjbR4qB7fwXW0LsNhbPjFfF/rB++07sqy7rsp/ffBuwnsp8kqUkUUiSf
	7fe1SmdkWyNal3nlrtT22BG6tTtHorEsmlCKtKR6wpkfCUNjRv+teVe7szmDMSTM/x9hf5
	gqyHJhQgGyihFuHEcckmDR1gyY63f4M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-KLl2QYInMMWHyIxNcsUSIg-1; Mon, 21 Jul 2025 12:08:00 -0400
X-MC-Unique: KLl2QYInMMWHyIxNcsUSIg-1
X-Mimecast-MFC-AGG-ID: KLl2QYInMMWHyIxNcsUSIg_1753114079
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455e9daab1cso9404075e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114079; x=1753718879;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cu9wGNux++7JCsJCsDX3KrdXqV88PlQmqNNIUVitAj0=;
        b=TSFYZR+vVY/gX4wmOZGbMg23kfgqapfuszQtuT04aklUEAvrABVRj1eTBpjbjrsV+w
         wZB4mNxNrXCAjZPkR/dISZ6sMx593kt47/S+MtrQ0V7sxYpuZ28oRKMUqaDATkxh13nZ
         ws0MxClUhDysZafBn4Wnjd1AG1U+ZeCcqscp1aA7HXmUDl2CWmhWQQYNOf/FDSXuJvDV
         7J/7AFsV1Vq/Fk59lLO/e8ngw8kGUA4anmBFW9GY2DBsoTGL0OyBr1iuHXOekrf5oYyX
         IeMt+ehA66RlMzkKjBexnX7qYxbeMrd4h8abtk700KheO7Z3FfzPnY0cU1cnufxTmy1L
         Tbvw==
X-Forwarded-Encrypted: i=1; AJvYcCWlkz+au5qVPBkKK6KNrxTKnTT90xJBhrbM9Wnywv6dybgdg7ZkJ2OEKb5KEarsiLJ+zJi1TqKHOAlRda4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPpJ2lstHvy+BFk3JoQaxFTgk0X25/mEmU+LF9fmVta5bjVPS
	y+r74rP2uZRlLg6BSUl9g1WV/D2JK54cvwI8iU7empGf/Ts+0Z6OYqG60EGv/HwpyrifXGlTabS
	MZ+iS+YOxdI1/luhxNNPZiQj906ELX0HV2ZH6ZEPqhbSMNFlj7oV+z31xdEsxggLWuA==
X-Gm-Gg: ASbGncvqQW42NcwUKb6XDl6YJkf7wDwJcFk/bDVIJ6Lmbix2O08U29+85bdb+FMaN+6
	rzP6E7CTIS/5aLUNQaOIjzRVXDVwlakfaRoVBjSh78c8Hq8/To7rJa2QV92w59RnSp7Wmm2/Bjf
	9ojODeIQb0d5q9vD1OrABODmfe4/jbYVtrp0R89tNxCmjYde900rLHI/D/z85bFlRMeI9tD+4kM
	dqIMVEpMEzebzvdltDCc1mjCQt95faJOJzCAxZAe9x26lZTeZ/Qb/Cfh/ErHa7dj+lpTGGn2c+I
	CRxgbovKAX+Sl7vUVNOumzag3FOPTHMGxS9uMb8m4nOAE9vJqzqrDPbj02gLAkOyq2RPulDzOO8
	95phKg9VYDzE4EZPVs9RBPAY=
X-Received: by 2002:a5d:5d85:0:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b60dd88792mr18018363f8f.53.1753114079338;
        Mon, 21 Jul 2025 09:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrCA1pF8sImumfSHdQ2k+0yQLP5WebAAcanozxpaX2zPA+ngbvOPE0ORhEtm3FdkZUAB4rRA==
X-Received: by 2002:a5d:5d85:0:b0:3a5:39a8:199c with SMTP id ffacd0b85a97d-3b60dd88792mr18018339f8f.53.1753114078928;
        Mon, 21 Jul 2025 09:07:58 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4563b74f5f3sm102754515e9.25.2025.07.21.09.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 09:07:58 -0700 (PDT)
Message-ID: <f9801a25-9338-45d6-ab22-344f4e8e77b7@redhat.com>
Date: Mon, 21 Jul 2025 17:07:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_withdraw
Content-Language: en-US
To: syzbot <syzbot+ed42f17ebcb58526788c@syzkaller.appspotmail.com>,
 agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000a7170b06211f16b3@google.com>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <000000000000a7170b06211f16b3@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/09/2024 09:54, syzbot wrote:
> 
> gfs2: fsid=_){&.s: about to withdraw this file system
> ------------[ cut here ]------------
> kernel BUG at fs/gfs2/util.c:340!

Syzkaller has been patched[1] to avoid using -o errors=panic with gfs2 so expected withdraws should no longer BUG us.

#syz invalid

Andy

[1] https://github.com/google/syzkaller/pull/6191


