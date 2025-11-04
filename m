Return-Path: <linux-kernel+bounces-884564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09209C3074E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8321188E973
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC9A315D42;
	Tue,  4 Nov 2025 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hi1trBDo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLiA8PuM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3582314B8C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251479; cv=none; b=lf4nGwiVRog7TyWW2jk47+iv3bytzppYhgvMSQdjgkzT8MQej3WRvwgSSynIycnXgMFuj6HSwYfa4v4FWVnB+Hp6DbaJ9Ervbkxq7IWyaoRj7PmUmQ1jxa8HRdlLybNAcnn+GVpcNGVvH/Nn/CKyf1srPr3wxpM0SqV8G8xLIUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251479; c=relaxed/simple;
	bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2iuWo80VRvh9fDdS3lWDFhR0dj7f88O+xJ0mRIwpr37FNafxM2agDLj3geUYoZq3+y2zRvfsdfKiSVWxeMOnRBXs1w1d0wpQwG1vmUAkqPKNco6e6u0teoU8V2gU7K4BtK1qX/HxgtZBCaAvmzfYfkciHkr4Iddb0hoULCDUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hi1trBDo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLiA8PuM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762251476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
	b=hi1trBDoy5dam4fsJj8r8H1IoDk9GljXWL4BaVbatMcvDE9SnaXrF40UNKTjiBdSxJgtp+
	9J3g+pFmDhsa4aPGHc0adtkRQPKqzBsxmiuTTr6vUYw03A2TSwhNTJR8ITuIIglf/NOUKl
	W52jaAayorpDKMWyheZHmgWeo6H+MQ8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-DNVY_EMINcmBDbjAAr3TVQ-1; Tue, 04 Nov 2025 05:17:55 -0500
X-MC-Unique: DNVY_EMINcmBDbjAAr3TVQ-1
X-Mimecast-MFC-AGG-ID: DNVY_EMINcmBDbjAAr3TVQ_1762251474
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6409605a485so2652209a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762251474; x=1762856274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
        b=gLiA8PuMxVrWkfqY2PrsweTr0XtGDSjAT6BR1wv2jTXXo4E2PkWYRQUR2t4YMWkPsG
         zPORIOhDYAH+L06TS3C5n4cUYIxuscy8iFRQ+iZJo6VlcxwntsaTJu14JiQG3dyACnZs
         1tx5v0Y+NtOUuYP/UUoYy1Kr+TJkwuZHei1ORynKlhtbyew19sE6g18DQ5PLOoPY6mgg
         71iVic5rv4vKgH966I1sBOGIHXSXEwN/+5ZQbSS3zVsdf8876Uqg66AmQpnQdQ7yY+JZ
         IVPhq7eytJLag9IxG7FdgPbxVYyc3Sk2Y67qJ9wUhB6p/LT/TeNnQRHn4jQr1bkWRbXe
         sjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251474; x=1762856274;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0U0kFLASix37zELIkWNxq8vUqzlq9j+qqfasMEzbtCU=;
        b=gaYO7tZff1zKwVOeXEDgqaUmhbSKMizGnT39P+l2Zx/4cCYw7zKIsR+yHwWgPajh1S
         ZKhjAZVdnom/42Fuv6zfljua0mLL7fXwMYPiEHZis0UyFh8wX2WAHwbYB+XvJgLzyM42
         SKGK4lZY30mgm5s2h7b8Z2nx3JdTG8y9+ra0/SVt12oazhXKmIoBd98+N79bLRVU2r2h
         Vv1l6HAZtuhVsW6XUoQ9gIZVjez3ORksWaMKHiYpmciBF90MDYmhRC9qLm/U3iCElnMs
         Rr8zudEhqNzCyYvln2Gy9FLfksWj26/tz85HN2fyK9BvYqDoSfluDdsuuc6Fz/7CZZlb
         6PyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtX+DCx5cPV9HDY4Yko9kkWlBpkM580mydBxyLtX8YhHooDROyq7H7KT6QYGhXRBPlumBws/vKMTPnGM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRk6Aq2Kd4k3KrklTeAdu+3mhqMourvQ2csDpmHLqh3RUm0Uon
	ZrosYEi3CtuKaaooQt7J+Q/CFeS4HNtNq++9Wxe9LD8UvP0u/JEAzWj+KNv+ZvqTghmWNJJgxca
	fVRaua9+t337Jbm03vVY0dKzgHk5MUY6CTn/++isPEif2aeTWiXKXTkGX6fP5a1vL8A==
X-Gm-Gg: ASbGncv++6UPF1sgsv28zOJTPNscJ42bhpCnftl7NTi28d2INsjvBRCXdL9k/RIOXn6
	1FREjaa6tQtTadLcsxZ5IpYUi1xi3c7boUSu1dWTfPEj25dNPz200q5tuNb0eiZehvFS9a337ya
	TGi721wQHWhASIGKLszr0v38rRZShakZCIS7tJqzxmUmNIXCVmfLE2gaPV579NcTwB5P1yvVWfW
	/7FPwl+JImDsk2Dhma+vka7OyNc9hwe+PT5zqiy144iJ7CB4bNt+T3DTR08rhPxnugZLFV+qE25
	9VtG9KBbD1DFmAoFgm0adoh1Ycp1nnruWcQ0qneBKbFiSf+h7RxEsZwIF4EIsOI5jgY4ukbwAZx
	tWWbTe+Eb7NQUvjIp1x0vEZ4=
X-Received: by 2002:a05:6402:2708:b0:640:aefd:f47d with SMTP id 4fb4d7f45d1cf-640aefdf831mr7641273a12.21.1762251473929;
        Tue, 04 Nov 2025 02:17:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu5k8o/2pT/Sl7v2zX531F5JVWTzROWk3FxKJqNgqco5tJVsMjiW9FXeSfP0WsuPN495V1kA==
X-Received: by 2002:a05:6402:2708:b0:640:aefd:f47d with SMTP id 4fb4d7f45d1cf-640aefdf831mr7641243a12.21.1762251473568;
        Tue, 04 Nov 2025 02:17:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e67eb666sm1705024a12.3.2025.11.04.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:17:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 875F332860B; Tue, 04 Nov 2025 11:17:51 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, nicolas.dichtel@6wind.com, Adrian Moreno
 <amorenoz@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in
 IFLA_STATS
In-Reply-To: <20251103154006.1189707-1-amorenoz@redhat.com>
References: <20251103154006.1189707-1-amorenoz@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 04 Nov 2025 11:17:51 +0100
Message-ID: <87zf92nltc.fsf@toke.dk>
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


