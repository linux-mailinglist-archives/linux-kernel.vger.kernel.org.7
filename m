Return-Path: <linux-kernel+bounces-875564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F069C19501
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D763BE327
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EEF2EBDF0;
	Wed, 29 Oct 2025 09:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzQ19/Tk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567CC2E9EC7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728519; cv=none; b=aY4UXrXzz6C2RXlXxu960XewMjlH1Mi0A4zGtsD4J3NmMHHQ+bfxfzHQTc/qPYD3GeYLBeqdt6ArNkbybP4H7sm/DnhBux/xFOU2OHsShhntAWs+LiMWboL96lZCP7TgHs6zoquTNdSpU5+3oF6gNDnpZpqdJg9IC8CXXgWChAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728519; c=relaxed/simple;
	bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ncsY7Jc1YoF4yWAyUI6VzpikfKeII3NMmY/hIVtoLBrwtn1zCr6Zt+XuPvxdluzf/gzMTq7bFDxUoGm5mn/dhK13pN+jL88qd0LFl5yEgvH8gf+V1d8QzNu4ARD3+I70+aLC0vw5LrtpKjjGfYjZRZlooo+hl9aSnjEHlpgHXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WzQ19/Tk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761728516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
	b=WzQ19/TkYND7jhNUeVENLQnaScwLJamnqRbgUmcsv2M9qYWhW8cDWvJEemed6eudZIWvHm
	wCW8rjUvnLgdhmlZq+mXjBCU03t0pspBVAUVEAoE3KuXLCPWCW1z9OLxgKcIEvZlRgAxfr
	wiQk+ONKtYjwBGvaxOh/peSSpijwGkg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-rNMCpZ3YPf24-gXHb6oL_g-1; Wed, 29 Oct 2025 05:01:53 -0400
X-MC-Unique: rNMCpZ3YPf24-gXHb6oL_g-1
X-Mimecast-MFC-AGG-ID: rNMCpZ3YPf24-gXHb6oL_g_1761728512
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-63c13b3f23dso5856927a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728512; x=1762333312;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
        b=e2mQwZQEVnJr5n/racMuGkPiCy4+j49oDFHoHBcVJ58vJcS1HW0jJ2lTYs4TXqJxNP
         zXG1glM0GJdZ3BIkbHiJm3t4vHvUOlXSJcXX8BHtKuL8Ff9/s7tn1ymxdT65ACQ9/Snu
         Yf/Wmv/1a3+BGWdC2YtmXiGmns6Dp3TyfzBRXVJEb1zfrSS0DcdQorHJimFXdEYx/4ah
         qYzeHyZSJ1REwO8Mv3ry3R8bOQtxL5oEEwhjOjWfY6/5koZTIbWOJU6w6e3RytXb2HA7
         A/Ug5b6XJSLTuCJGyF3GwMyUgU7NvmMQz4k+h4DAWN3rYl89xK3GkDu8c0GB527SuU93
         rwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpjSDIIdJYblSbvDyrhPS2JkkAdmTaaKneXtJMPVOtvArR71H1+5Bmqxst0QyRF2EGQ+dHpWmqkGud1fE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+JOPhDrxSW9kU1vf4UM/OJvkzdBYxFc9g7V/kDiphbeKiT/52
	s8vss9AUkhF+s5WUBvwPvBB3uhra1oVMUPIeHc36GCGGxDuI08iIrcElDzrBdIHJ4LYDui16JYb
	s1idlLUjly32OqlzwfnPbTTlCEbQEallhEF1LgPaMaBK0UEfbMHODWTfOYGbxK5hUSg==
X-Gm-Gg: ASbGncsDUwWuW3380Ec+eKts4ei50les2D1p00sNrcw5QKCOBxHOJBoicPgQGu0cY4J
	/I1vPzjfEA02gHU0PhZYaIm8ez0oPsjOf8W9KsiLhGxZVnzk95XQkl3PiTNgBGzcI2jLfz2XCvt
	uFBqDVdCzm6ctOMtANVrnyvN6PR6UkEFXz2Dvb5d5xJqIgdQykgmuFfFmGJKLCOr52RW3kkKRm6
	SQrEzP8YsmS1L+pTQaC+vYQgyGVm+MR2k/re2PL6Tq/e4j0VMcjbTPPuo6VI23q6FCjJBKFvqyn
	suqn+md9B8WmGQ8cl5uP/T/xsroXUmoupn8jYaDloRDj++TavuP430rcVKKMRIkcqQ9+Co+xHaf
	bdTWLAWsABZB+2h9TLUZH3Ys=
X-Received: by 2002:a17:907:74e:b0:b6d:961e:fbcd with SMTP id a640c23a62f3a-b703d55d4aamr202755066b.50.1761728512235;
        Wed, 29 Oct 2025 02:01:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMkTxdQ+/5aKXOuyyh5AS0UFPHYZnXvO/Q6mw+JBd9i8Az/ovnrbFoR0xn/NRL22/zzcs1Fw==
X-Received: by 2002:a17:907:74e:b0:b6d:961e:fbcd with SMTP id a640c23a62f3a-b703d55d4aamr202751666b.50.1761728511716;
        Wed, 29 Oct 2025 02:01:51 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853eeea7sm1373575066b.47.2025.10.29.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:01:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 623092EAE5D; Wed, 29 Oct 2025 10:01:48 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, nicolas.dichtel@6wind.com, Adrian Moreno
 <amorenoz@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
In-Reply-To: <20251029080154.3794720-1-amorenoz@redhat.com>
References: <20251029080154.3794720-1-amorenoz@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 29 Oct 2025 10:01:48 +0100
Message-ID: <875xbydqtf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Adrian Moreno <amorenoz@redhat.com> writes:

> Gathering interface statistics can be a relatively expensive operation
> on certain systems as it requires iterating over all the cpus.
>
> RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> statistics from interface dumps and it was then extended [2] to
> also exclude IFLA_VF_INFO.
>
> The semantics of the flag does not seem to be limited to AF_INET
> or VF statistics and having a way to query the interface status
> (e.g: carrier, address) without retrieving its statistics seems
> reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> to also affect IFLA_STATS.
>
> [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


