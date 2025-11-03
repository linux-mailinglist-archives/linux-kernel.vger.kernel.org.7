Return-Path: <linux-kernel+bounces-883614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B05C2DE27
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61AE6422E4C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A949C8BEC;
	Mon,  3 Nov 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqvN1Jp8"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F63347C3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197542; cv=none; b=dUjreldGgtM1cc29ovkgDk3EwTs5B/RECW0xaZ9rykLUUWbl3aF10PqzLOrrFCfAa2accUn5j5UDZiv/1cN+vBOH37zfdQzdaPctIUb9Gxem8zdGhr2YwBXNIsyEKOIg6Ac3lx3rzV2PRvr7npc0SNKkYUWpYcXd5jJZKgiZrNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197542; c=relaxed/simple;
	bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2GwOy0cYvj0WCbok+FIuZrSD5zexGe7cvvPK6He27XjgrvIIlxZ1sNDOys7rVKVPrCbh/Ysr/xojl4TUlRUZMc8ep3HLHEYANBPxPpkidH7qWrU1zFylJUOo6ulstsOH0Fb3NFno6jGB2/qMbQZeWPB5Zu9PSiRlN+FJng2Y0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqvN1Jp8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f5d497692so6302789b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762197541; x=1762802341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
        b=nqvN1Jp8S0D87zX1aiFPPz5J6yMMN6G3n97knd3SuRXhtI/NTH0NmhSQHJ7LztSZZn
         P2LnmryfdZ4Ap5h2ouZDudjIBJhIEOe7Ac7akOVh4wkucKjMowZVeS9wVLpb1wNOBuJj
         3pIbu39p6KYyTIeuWt6bHtTHZprEaeipSUDAVR1d0PKTlccqlqyn2v0sLT6HrOMAtYm1
         IMQX1E/7uuttmG2nnySdFphb1cusZXibepX/KiPq1wf+9nXa+ORZ6Q5zYlelV8aCTWco
         KKlH9ovHRtDHkBqljxCPlZgQGZK7WswkYO8zGL8lJ8SmXPFNo3xTORDXObLMBmOdsbXx
         fq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197541; x=1762802341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
        b=H6Mgo0mP57z0TRfSiUP17WoVKm76xFFsfmm8dX4ZWjaZk5xBaMByryCI3cJfvyr5yK
         e5sLW88L54eadZDPjV0HoTgt1HAGHlVgPdY+24fqidWtlEorXOkhUg2EjW7VVIhylcGW
         tpeN1ifGZ9v4AfuiNP6du4BCNjV0d65X+glPoFW4HbKS4vvag7Bwh3pE/SYkG5qDLCT1
         lvcoc4H9aT4VlIbOgzYcYRZPuV+b1J0SwQZ7caE/+aHhsmg4kGddSslFR0d/zINNagd4
         9BMGCDE8HfieVYeZSDPR+KJ6CszSDG5gUODhidjsJTBR1t7cMSbw3a4w7BXXUtYCRHCe
         5QOA==
X-Forwarded-Encrypted: i=1; AJvYcCWnR1822zuAXIli+QF71a7N5hPh20LcZ8p5aA8vrBVX6idVlOdp3DPuX9ZqhhK1VEtG9bg5XLWFeCbDfvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzycUsXc/uUUY6qHXJt6bPjQh8kh9MXtDw8OM4c/yaIxFjcQtO
	g2o9f3hMrtyNCmwX1uoYGRpQJ0RHBWkGjOMjJfNYuzxWNR/BNt5ZH9AxReO/QOuZ8Qo685Jkq35
	s0PAokmT2sZGcs/9VYdhMhA1w1pkJSS0=
X-Gm-Gg: ASbGnctMLJIw6rfj6BinMkfKKwAyajnWmM+RSwMfgNLWbNxdgVthek+g9aG9YspTUXz
	iN8a2MkfIRvPp1WKVhTr749yF95lPY3TTakG6zOe5UuUQD1kShkCHcCEhHtNV51AfSuQNdH8nPu
	3hjq9YvPoWZtlHhBoti5LkGDVwhIZtO0xOg7zWBCiwCAJNHF7e5EhEhXy02zRyEWlyt1l24pIOB
	/ma/nIraxmdon43J+sHDqmnvk+vliGnyWjISVgxkRSn0fpkn7jQ5E7WHvwb
X-Google-Smtp-Source: AGHT+IF0BSYD4ggbwG3GKDSXC0JY95fMZFQFVb8K4FHOBBwvNGu2REmpMK4jfQUnBSt+Oq262i2Kl3UblwRepxobDSg=
X-Received: by 2002:a17:902:ea0e:b0:295:c1:95f7 with SMTP id
 d9443c01a7336-2951a5271bbmr188667085ad.61.1762197540672; Mon, 03 Nov 2025
 11:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 3 Nov 2025 14:18:48 -0500
X-Gm-Features: AWmQ_bmwicNW82tRVRkXxPbIo5gT61jNLe8lZ8bOYZiBYnm3rw60BaynqJTOX-U
Message-ID: <CADvbK_cp=heq2sg0J2hEa3p4soBFmjdqvY2otSLtCkF0aF2FKQ@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: make sctp_transport_init() void
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 9:38=E2=80=AFPM Huiwen He <hehuiwen@kylinos.cn> wrot=
e:
>
> sctp_transport_init() is static and never returns NULL. It is only
> called by sctp_transport_new(), so change it to void and remove the
> redundant return value check.
>
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
> Changes in v2:
> - Remove the 'fail' label and its path as suggested by Xin Long.
> - Link to v1: https://lore.kernel.org/all/20251101163656.585550-1-hehuiwe=
n@kylinos.cn
>
Acked-by: Xin Long <lucien.xin@gmail.com>

