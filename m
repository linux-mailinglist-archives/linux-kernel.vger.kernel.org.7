Return-Path: <linux-kernel+bounces-830659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CD5B9A3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD70619C82CB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792C3064AE;
	Wed, 24 Sep 2025 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCLDgZTZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5121305E3A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723767; cv=none; b=hlKTbXfj+ia3Ikm78oFgkkYj4oHzFRnJXMXFn1RQrPb+KCL1fsJ3y2gggeX3Y1BL6sjiKjsazxkClIctgCfG0sWzk0NVgwuKhySERgxwxnCY0RtSXunwFtmK6iJHdd2skIEzYCnKINqs4QFZBNnfoMpWMbUDRp/qY1Ruu/JY1aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723767; c=relaxed/simple;
	bh=T+TlB5/WWmHdJA8TVHlkIqhuzeoigk1nH0oWP9WXTqQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=szoUqZHwueepY11UrpWlWvs6QuLfpHTLH5zfto4mn+vnXwuQtcrR5x/zEF4m1hThMBRzs7R1SG/bgEP/3z9RlGhzThD4xT55Z2xNyNa+QvDMlIizmqWDsA7Di78Mo5iW3bIHstgp87biaK1PnQs3W+1QhDbDcLPbOh8CacTp6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DCLDgZTZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758723764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wby1HXNZLmnkUVqmiAwf+l/HkcGX4ExMR1XfrTH2JXI=;
	b=DCLDgZTZeioxYy/NyLiP4wbS20xFiPQQLnwbYKu94wU9ZMf/PIlubZWluQ9K2RIhxWNxem
	NP2OJH60YecOyUFmHyjRDki3frm5QTpr+Vx8TLu+cA2PJH5nns4WlIQoSoFEEHHIffeBSZ
	FBIbXfy8jetbDNCkDpaLl2Im6ca1Fww=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-s0TyKrfZMO62zzZGK5gFYg-1; Wed, 24 Sep 2025 10:22:41 -0400
X-MC-Unique: s0TyKrfZMO62zzZGK5gFYg-1
X-Mimecast-MFC-AGG-ID: s0TyKrfZMO62zzZGK5gFYg_1758723761
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-854bec86266so459601885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758723761; x=1759328561;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wby1HXNZLmnkUVqmiAwf+l/HkcGX4ExMR1XfrTH2JXI=;
        b=Or55KjggeRY8BKtXJ4Mow+Eo6G4DxTEa7JpP2tAr699NbnpnsIKdW0guiB19h37Ugf
         sm+cRAp4WGmTDZooHEdVipSYaxm9cJjoZJTaLEtl6pv2jo1wERMpFoK8E+E5U+3DFzK1
         Fi43y2S1yHMYpoORCnGR7Uv3kFF6xDJBH3J8IJaKXe2MFqqdyoi6K9iedTvMe61/XaYi
         4eMKiEu80K8s5F0fdvzMURo0NbL8OpxGAN+7vIGV5LVRLCA6lUWeQpe1lbJxATvI+xO1
         oStFKSgFcAKjP0aR/hlRwnYiZTtcmz4Ch73O4ZTDtWWOrd34AOcciIUbOHizPKF/AjdL
         F2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs2ujIjXHGDlwZdBnfBn7B5JMN1q/ZdX/sOPrRFk0GbdxWPVlc9WWBsNGM0d37IZ/kNFyGfi19xketGsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk9iW3HNbjG8CcQuUbOfMxEvf+PL636oGb/OkUIuADUHqzHh+7
	VxcwH2vIi8wko9KyVMsfDucmLGwqZyIz3WbpeEDP6oba7euBI9JUuNbbN6pZtnQ3UE/Uqt9qmd6
	1aE65j4rqZ6M79fAV7sVmNLQV9tOLhZZGtTxJ6WZnsRKHv6o11UM+5/SONbonWZ9N+g==
X-Gm-Gg: ASbGncuWm3MXzPl9uw46xuptt3Q3L5OPwQkdqiCS8Dk1g0VHhP8/vON2n4QpsiOzBcF
	OLbaK2Mft+LISUjgQXSyRF/jxJM/jf+uvhWbIajzJ5FFRa0+ozxPm9fybefOKvQSFlmCLFqW1Nq
	fcnDWZwo+1hk8U+rZV33WKqVg6p19PSvym5alGP9pFFNrFX2oKWOjEWWa5548mdhFBNCt5YHoYc
	gmeQd3rV17DXFz8Zk0gBNvv5U4dDK6lAbrU5fRPjCG31k6wLDA4ym7/ANS96gxe7wSczKMSpL+p
	wkb0CQ5DzilpU+kBY09XvpvzrdxiE2ahoZkvP5CINSjY67G4vqo3GyaqHZVmrRVKbtCGVfixzVq
	ghm4XF/7ACpI=
X-Received: by 2002:a05:620a:172b:b0:857:d63f:bef9 with SMTP id af79cd13be357-857d63fc21cmr230714285a.55.1758723761162;
        Wed, 24 Sep 2025 07:22:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF88n9s0bGR/3Shfxt+WgbbeN0XtSEIOpetpaIxDn+nxXKnsNKcU9o5+9lonCwBs8VXTMfzZg==
X-Received: by 2002:a05:620a:172b:b0:857:d63f:bef9 with SMTP id af79cd13be357-857d63fc21cmr230709685a.55.1758723760681;
        Wed, 24 Sep 2025 07:22:40 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84a1daf7548sm552009385a.3.2025.09.24.07.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 07:22:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ad9f8b77-9435-44f6-b316-b6785c9f0089@redhat.com>
Date: Wed, 24 Sep 2025 10:22:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex:add MUTEX_CHCEK_INIT to detect
 uninitialized mutex lock
To: buckzhang1212 <buckzhang1212@yeah.net>,
 "llong@redhat.com" <llong@redhat.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
 =?UTF-8?B?bGludXgta2VybmVsQHZnZXIua2VybmVs4oCm?=
 <linux-kernel@vger.kernel.org>
References: <20250924022500.2577-1-buckzhang1212@yeah.net>
 <dbba6b72-d270-4b7e-bb21-39ac8a46864a@redhat.com>
 <377cba8b.2bd3a.19979cf5b04.Coremail.buckzhang1212@yeah.net>
Content-Language: en-US
In-Reply-To: <377cba8b.2bd3a.19979cf5b04.Coremail.buckzhang1212@yeah.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/25 11:40 PM, buckzhang1212 wrote:
> Hey Waiman
> Thank you for your reply.
> I totally agree with you that A mutex must be properly initialized 
> before it can be used.
> But my customer engineer often make the mistake like this in TP or 
> fingerprint driver.
> I want to warn this mistake at first because it can be used normally 
> mostly.
> when enable CONFIG_DEBUG_MUTEXES,we can get more informations.
> This check has provided no additional value and it slows down the
> locking fast path.
> ---- how about move the warning to __mutex_lock_slowpath?
> Can you give me some advices?

As suggested by Peter, additional checks like that should only be 
enabled in the debug portion of the code (i.e. within 
CONFIG_DEBUG_MUTEXES or other debug kconfig option). The normal way we 
test the kernel patches is to build a debug kernel with all the 
appropriate debug options enabled and use it for testing purpose as 
performance isn't a concern. This enables all the debug code to be 
activated and check for correctness. Don't rely your testing just on the 
production kernel unless you are testing for some performance related 
metrics. Even then, both the debug and production kernels should be used.

Hope this help.

Cheers,
Longman



