Return-Path: <linux-kernel+bounces-764255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685CB22086
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D745D1AA1B97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24332E11C5;
	Tue, 12 Aug 2025 08:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdsP88Kl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301E2DECC6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754986627; cv=none; b=bECAgw9FPnsck5GrCszeHoW0uas7rBX1aTNqmVmCWTnqfvhi7d4YwJMl9BIQ9CeCvgihIus1YKb+YoYzBqtONzcGWIreaLJvZE7RPzmHFkhg5lPjSl22QCyd9GVy1sVCNZHy0s1OLCnimHOQQ5ADPyD6NFhwNtLUAuntb3/Sw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754986627; c=relaxed/simple;
	bh=yRFc2sOlfC1VRaec8lpMMCRXQPh/gQn/3HBQl/s0F4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ry1pRIxfXh6nlRp7LiEY5bBiKkjCXggmbHMc/XQTXMm/O1ecdlqZm8P5DofR/ZbwpwBdtxmQ1OWquzWCGfl+bDT4nFVr1DheUOwW1wigIloXR7uQmXkuvKXDvTy04y2Bod+5stAh9NDwioNtgpTNzqCJ3E8M5cCPlfzU2mDh0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MdsP88Kl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754986624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+sWFNTm6ZCYaG4jfBrFltTWcj45ITlaTFvMx8eQ5+0=;
	b=MdsP88KlmO3ypqbclnsJb4YTp6W2Q0enq2LTqMGHPm7nsJ59//s+4+3ooi9K2VF/BO8HrL
	Qb7sLRLazmodue5HDt90vSfblPO0gmS4cMJLminvnZppylBMerOokwKhTSNwIAGkaYNzrR
	F6F4zUuerEWF1qptzyhbFndT9jcDlY8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-EPfAYan1MTGEKHFl_1HrWQ-1; Tue, 12 Aug 2025 04:17:03 -0400
X-MC-Unique: EPfAYan1MTGEKHFl_1HrWQ-1
X-Mimecast-MFC-AGG-ID: EPfAYan1MTGEKHFl_1HrWQ_1754986623
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-707648b885aso103088896d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754986622; x=1755591422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+sWFNTm6ZCYaG4jfBrFltTWcj45ITlaTFvMx8eQ5+0=;
        b=LzxNhvkFmDImGfQ/jpXHk1xXC7or21p6wG5Nd2fB48quviQo72kpuxyAVUjO4zWwJG
         P46x+R5TfcalDzvtcMYT0t+kjducxjhik/u79BFbYkcXYbVBTVBlriU1KWZOkOtH9PP5
         cw2EQnwnMUSv4ASfKG0stY/RBAkTmDYW8h0YvkD4FYcj2zMI0GdQk+Ksg45SZNr0nlpR
         T31zQPGREi95giBGZERBGJ12f4Mp4Qaa1fY4rgJEX4l9KdSQGwQtxe/vtoySRvWP9nlZ
         /Xq3bmsmrh8sthn1KuY140HWs39fuIk5Dl0MH8KR9xFIorhhFHEe7vtgzJNDT6TthMeh
         oAnA==
X-Forwarded-Encrypted: i=1; AJvYcCXzhXa6ggDJmn7/6tkLAVlJqOzYvPiImWskGq7v0+oc+1DdM8FTF6N0j0jPW1ybZM2CrusjbR1DGC58Rfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGRi3bmODwRjgyQB3MiFlUcA1nFb/MwvULohdH4Zsh3pCPs1w3
	9J8XI0J4+7Kn4WrBpblxz4ldVkOSlw4yuMtXsm0KEYLNcpIGaua67tK9nbWviUHVejZrY/6+1QE
	R//QweCw5JidnmqOmK14FiCWJT/KDNI+2p5KwiZEW8Q8xXcK5j6pkSCxOVeHlsasnpg==
X-Gm-Gg: ASbGncv9a+7Tu/ih9eEpRhoc2snOQy+HyTE83yYt//FcZv/1GUXbUUnWczfHRmmZCOs
	S6Q8EPc5sAJNOktqr2dFRkkE+82ZTADaSqkQuhcJ5kZW+RXwyxDM70VbZXSVD2l3WugCne746l7
	sr6zKuzAUygC1pf1ZN8SFMnb37UqVBVjKOyIsw6bprULh85P7CqpFeiN0Y1mLcs0Pyh1fWo0Rln
	b/GiBdJtqfQERjGlAQ8cprS5sMEH2UTeQKPTWZFTwpMMBQ5hqpfjxAtoyttQYcyR8ac/gD2E6mS
	f0gaCduRIQMckMOyyNidQeoFka+DsIfsfsxwkxRcvF8=
X-Received: by 2002:a05:6214:c84:b0:707:ba4:a21e with SMTP id 6a1803df08f44-7099a1d06cemr216500806d6.1.1754986622692;
        Tue, 12 Aug 2025 01:17:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJbyxt0za6gU5BC/SKoFHX+kaz9ByoX6QEm/XkTEr0Kp7Xbz+qdisalcp7XQIwZgZx/aDtsg==
X-Received: by 2002:a05:6214:c84:b0:707:ba4:a21e with SMTP id 6a1803df08f44-7099a1d06cemr216500656d6.1.1754986622302;
        Tue, 12 Aug 2025 01:17:02 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70937821c2esm147748396d6.68.2025.08.12.01.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 01:17:01 -0700 (PDT)
Message-ID: <0c3291b0-ab8a-4958-b317-ffdafe61b332@redhat.com>
Date: Tue, 12 Aug 2025 10:16:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ipv6: Check AF_UNSPEC in ip6_route_multipath_add()
To: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>,
 davem@davemloft.net, dsahern@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev,
 syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
References: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250804204233.1332529-1-maksimilijan.marosevic@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 10:42 PM, Maksimilijan Marosevic wrote:
> This check was removed in commit e6f497955fb6 ("ipv6: Check GATEWAY
> in rtm_to_fib6_multipath_config().") as part of rt6_qualify_for ecmp().
> The author correctly recognises that rt6_qualify_for_ecmp() returns
> false if fb_nh_gw_family is set to AF_UNSPEC, but then mistakes
> AF_UNSPEC for AF_INET6 when reasoning that the check is unnecessary.
> This means certain malformed entries don't get caught in
> ip6_route_multipath_add().
> 
> This patch reintroduces the AF_UNSPEC check while respecting changes
> of the initial patch.
> 
> Reported-by: syzbot+a259a17220263c2d73fc@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=a259a17220263c2d73fc
> Fixes: e6f497955fb6 ("ipv6: Check GATEWAY in rtm_to_fib6_multipath_config().")
> Signed-off-by: Maksimilijan Marosevic <maksimilijan.marosevic@proton.me>

Please resend in a 2 patches series including an additional self-test as
asked by David.

Also please insert into the subj prefix the target tree ('net' in this
case) and add Kuniyuki into the CC list.

Thanks,

Paolo


