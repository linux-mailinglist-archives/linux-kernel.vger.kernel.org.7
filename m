Return-Path: <linux-kernel+bounces-897754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3193AC538CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B786956589B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845F3431FA;
	Wed, 12 Nov 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+h8W2eB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWAWroho"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6DD340DA6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965247; cv=none; b=KXCEdbAQJ49cp+hrXyF2Pop8r3PN3Het6yRZycDjBkMPGIkNgcI6LvIQrpsXHdNZyxi6SWO/5nQIJdMV9PEfVPLqKUWUXQbrh6DMTmdJ2ArIlQUOYgw/V0Xpkx70aRp6xznBFcqhf//yIKfMLxz4llItY7e/JU7YMwX7l393yuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965247; c=relaxed/simple;
	bh=d/E8bVn48ysm7hAvgZ4eePo49+HzJRuHc5TY0GjWRsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nraxn5L29YPz6VoXQMhGnCIy/FCXm0R88w1WBe2iX0wBoPq6ZEawxQe7qKldOc3bRsqrP/Fkm1RQ+h2YWWAoxG9viSsj9mHePNZOSaIFA0xs5m+n+dU9UdWf5SsLjZTGK7I7hocivHYHlYt0YznW61yViY0ln2qXAWbeGJg4vuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+h8W2eB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWAWroho; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762965244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/E8bVn48ysm7hAvgZ4eePo49+HzJRuHc5TY0GjWRsU=;
	b=H+h8W2eBaMt0JQ8uARG8jckx/HDygkS/21IC3Q+l+OLeE4qL+ZnOt7SF92fIpF+I9tPy/3
	hSRIPxzmr6xWV5ifzD9qFVG4UeBSEfbq+3Jwsw1TgCmKngX+fWOMrcX38CwnjBsPKKJLEH
	gUmCf1krWUliEnnZ+3cYWk2ewOp8VgQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-ceaa0JTtN_eX-C13faM6WA-1; Wed, 12 Nov 2025 11:34:03 -0500
X-MC-Unique: ceaa0JTtN_eX-C13faM6WA-1
X-Mimecast-MFC-AGG-ID: ceaa0JTtN_eX-C13faM6WA_1762965242
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b733a653a8cso50604766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762965242; x=1763570042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/E8bVn48ysm7hAvgZ4eePo49+HzJRuHc5TY0GjWRsU=;
        b=BWAWrohoJ6sq3Auil0yuGGI+q/2TlOCJaHfC3rmn22h3d/z6UG4ZZ1BU9FHexSLama
         kBSBTW13k11QP6K0jIFaHqIVdBx6xH389RV383rmNs6+4fo4vcawU2JshdAKP50fw7qQ
         X4l+FXDd3D7CM/RH98RxLEP6LB6lvVXNwbvI6Q+ze6xhFxI59Q5X8E8zx3k9rbMoboun
         KYwkGzUXPTdZ191GjeW9IimWNKu24rv401j5/WOvwXL57v3tTXC3YSbr2cB2WYksXi3G
         TgYLMYWIvcYZiB/ALee/DDdvkUpV9ExwGGCxcepYOoayAA/LbNrC7zrTT90tCP/mburA
         QtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965242; x=1763570042;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d/E8bVn48ysm7hAvgZ4eePo49+HzJRuHc5TY0GjWRsU=;
        b=OLRiMaiEWEqfSLmxeGGoMYlaIF8RhoAgvPyEpvnRvjjuTNvHl9DSutaEHq3xN+5VEl
         iMAYlbkXk0SM26EkwOw5+f6QUbHtikF4rKvCIkJ4ZzsKr131lTaQ8OkNOOkHQCWsDBmV
         9pHTueG5+BanmRkWb41z9xGrguze3kkDqjR4QOBUNOisNZQ5T60T7Ljn2hwCcN2FvLtW
         xXAXlZtC2TAZqdyllEvci9IloyuZ6P7UnNCyNf39XA+20L/a+GUmCkWOTg0QwEbXYP4a
         PcCU4JvF1ICo0w2qxpf3iDB0/NDvEEuN7gOgoEtddGfU3WfvNopRlPWs2ZHpOv0GS9Hi
         QCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKNbLFlIzcpdCymPOuaVtYDTRi6fJr//HZs7vYjgTc8bSInL5GqGD6MLQilol2jer5P/BdD1n9rvJohw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSlXVPuzYDJROvuF0KR7HCfIhtWl4y1JA8opkuvSVDR11FNtAu
	pcGG8Ov115OF7w8BpggynZFpvqDUyer5ZzfGJ/frpPlt/SHp0jgVoW2uBnmTT0/fqqGtN0uDgiz
	q1D2AUTMkntTaSKOI3zIqoFvugb76U1p5aqjGPeE1Hp7I1xemn0BE2MqI0JHVpcB1cA==
X-Gm-Gg: ASbGnctpZAXGTHtLnni589F/QFTCDo/PiQIhrXp5HndRSvaspsYuTcPei21OTxUab9H
	J3xischZDwIzcOOHbAMN/TYZPZueFXXxUi12sDbToS2viM6omnQOd5Zo3YZE/MUYD+jQvDG4vUW
	E/AeGTxnyA6mNjqXlEUL7KffwbrX+DHVEcrsuQzWKNZScTS3NmnGsTDML2ISVW10adsg/vo9f17
	OohbtqlxCVeia78gKQFSm3zGQWR5SQPu2fKTpjr38ajeiBQpgQ9xRqx0//6vtobmtT6t3O6MYPM
	CwNflawtK60PT01CQKOeHU97xUCdmbSWRghYeQAwv2KeyT4vphusxdWUY0m4NkXin1igKfMdTUD
	TralQa18fYD4Ewnv5SITo/L0yAA==
X-Received: by 2002:a17:907:9707:b0:b6d:5df7:3490 with SMTP id a640c23a62f3a-b7331958ba2mr346273966b.1.1762965242202;
        Wed, 12 Nov 2025 08:34:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZm9pebiaIBZMLTLeGd2x+5ZnR+JDb8zNhfxlSlwTmdqUrroewBp8Rd3ZxS65aIC+OeC4oTg==
X-Received: by 2002:a17:907:9707:b0:b6d:5df7:3490 with SMTP id a640c23a62f3a-b7331958ba2mr346269066b.1.1762965241655;
        Wed, 12 Nov 2025 08:34:01 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b73456babd8sm13351966b.0.2025.11.12.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 08:34:01 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E4F5232974F; Wed, 12 Nov 2025 17:33:59 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>, Tariq Toukan
 <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, William Tu <witu@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Alex Lazar
 <alazar@nvidia.com>
Subject: Re: [PATCH net-next 0/6] net/mlx5e: Speedup channel configuration
 operations
In-Reply-To: <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <874iqzldvq.fsf@toke.dk> <89e33ec4-051d-4ca5-8fcd-f500362dee91@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 12 Nov 2025 17:33:59 +0100
Message-ID: <87ms4rjjm0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tariq Toukan <ttoukan.linux@gmail.com> writes:

> On 12/11/2025 12:54, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Tariq Toukan <tariqt@nvidia.com> writes:
>>=20
>>> Hi,
>>>
>>> This series significantly improves the latency of channel configuration
>>> operations, like interface up (create channels), interface down (destroy
>>> channels), and channels reconfiguration (create new set, destroy old
>>> one).
>>=20
>> On the topic of improving ifup/ifdown times, I noticed at some point
>> that mlx5 will call synchronize_net() once for every queue when they are
>> deactivated (in mlx5e_deactivate_txqsq()). Have you considered changing
>> that to amortise the sync latency over the full interface bringdown? :)
>>=20
>> -Toke
>>=20
>>=20
>
> Correct!
> This can be improved and I actually have WIP patches for this, as I'm=20
> revisiting this code area recently.

Excellent! We ran into some issues with this a while back, so would be
great to see this improved.

-Toke


