Return-Path: <linux-kernel+bounces-776530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C01BDB2CE8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33335168282
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E131159E;
	Tue, 19 Aug 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zYSTnI3o"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6595202983
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755639063; cv=none; b=HyoY9wywkVYm8MlJFcgJVx5tFvNMOCZaQ1lXkkN6U44P8rifxgJOLgzxBmkkkloT1ILLqCsBha/DSCw3VFQUdGmS5IUIMxM8v3Aby4i87M2oaGOJmhQKZsk8ZuD7pNKKNZlh970qv2Udz5oih3MntVO/Buvw3SA34W3PXbzHKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755639063; c=relaxed/simple;
	bh=/UQSGrmwmn8YczXd4v1oRryMb7Tfx60LkhNyEHK8aRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em/T5IsJXi4A3+crcLcvF9Vq8KabWKwLzhvRyNDVec8Xzr0blgAk72ur6Gac05dnSnpbtY+ag9fGDiN70rDZVYuVeV8wIpgbTSUqqurc3kj3+cjwA+QEk65RXdUsZYUDeNdLBh5Be9Cj5ESWPwsXveeEDivKMKKHnmmmzkEO5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zYSTnI3o; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55cef2f624fso470e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755639060; x=1756243860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UQSGrmwmn8YczXd4v1oRryMb7Tfx60LkhNyEHK8aRo=;
        b=zYSTnI3oVfFKK3nY8DKfD6yS2+e3kP9Nu7iHeV+BJ7hH6fFwVEevGnCk//QWGs/BYc
         Rp4PRy95lltrOQfXmNvxF/iT3iKT4WMHF7uMeWqstefWI8aJpaFGLS69xeKRCsQAlryc
         XkiVTFHItSWmWde3cr1lz5m38nB2Mjp92VdfE6YGCvhsRMjojIkgc9Up31YEfxCbif0f
         PGFPFc/oCuE6gEXnXtqOw8TxsH35cM0luBSAq6fhyNLobp79+XNi+zrc/rkyINFumZ5m
         GZZPrgg7fqF7kQ8Y/hfVTb62ceRZ/aNK9HWPNW4uOz+khel0SeEcOBEXsniv6/NMXCeZ
         goAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755639060; x=1756243860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UQSGrmwmn8YczXd4v1oRryMb7Tfx60LkhNyEHK8aRo=;
        b=bHqvjLLUpaD+HALtM4qM0RLqifum++ni5qy0rTLhVoXeuJPsDMgno8nLfDz7y4h6hT
         wfuF/hIeKfUtHcje17TOUAvjs/2Dbqn3FKJKtC4v01uCLLrhXH4i6/9rzss0G8G713CU
         0pZRTVBVdIzFels4Z8uzTqora4rdUlsf7XjjDQJxKJq83i8SbPGVa6Le/CfyYla0iqf6
         qMP/0B0cmrsLq3QG9hqY+ixcjOzSRTkM4EM72yGOhDxJ/24ezmqHPAzsV4S1BParVVom
         ybX9o17S8SnYYa1sFEmmF0zQWCr9m8hOH+zMs4jugOsmBVVMAM7xTr4e8gGrDqWLjQoQ
         PuQw==
X-Forwarded-Encrypted: i=1; AJvYcCW8iXewJHeaB3Q8ZUFNTzgcoCtu7Sd8WWWIzowwnh/T4go6BD6B4idIrj3R0WfnGZv3gWX7PM+M4nR1m6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJee1O7zrzVuCSRAOb01WNIhfbVounBCoBlDb02zQ8hUHqUxm
	JHCIdS+fXCbkOwTCeyt6tYviLB9Ml6PnJ49hDtMAQkusfpcX37HCF9/1CrN9eKZjdECETqN0J6p
	eg7DofzY2oWqEwldEfgCIxjgY5+CO7vF3r+IV5XZq
X-Gm-Gg: ASbGncsgww96ukXyUMvCzDP0ES+crkzVyRt6CPr9GsJj6ptAqDAt/UOTKxgAKtbIPzF
	mipgCu0iMAQwoWp30XuWkGIcihyyZba0TAGZEGqZkGtjqMv2kglLSePW3X5TIew/+mw/J3fZVjU
	/VPjYUNQbsU7C8IuZGYpIxBH/LJuVG+tIQKzSBelDQGdbIymEJiFFCfedwQ5mYgJ3hoarV/2eNZ
	WBWrVOnOMepeQ5q1cB9pmQrwNTooO3Q5ykwBfM+kLY8pSr5zM3BR+8=
X-Google-Smtp-Source: AGHT+IGdMHPs1GsyML54rmJWwEz/UgGgdUvH4DhmTG5Te/uyjIvvo9Y/djBh8mKSRlBD20AX/zgNoduJqn/WAGp1obU=
X-Received: by 2002:ac2:499b:0:b0:55e:24d:ee80 with SMTP id
 2adb3069b0e04-55e07047031mr20680e87.3.1755639059692; Tue, 19 Aug 2025
 14:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755499375.git.asml.silence@gmail.com> <bc5d49dc4dcc97b4dcf2504720e9d043b56c911f.1755499376.git.asml.silence@gmail.com>
In-Reply-To: <bc5d49dc4dcc97b4dcf2504720e9d043b56c911f.1755499376.git.asml.silence@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 19 Aug 2025 14:30:43 -0700
X-Gm-Features: Ac12FXxjiGJ4UU-vDlsX8zgDS9DbCBuv6ltBRKcrZz6FLHRi0lrhBZIW9GIkYsQ
Message-ID: <CAHS8izOeM0rXEmbQTfKb1RL+itS4wwH8J+pCxO4F3Adq_b-NnA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 13/23] net: pass extack to netdev_rx_queue_restart()
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org, 
	davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk, 
	michael.chan@broadcom.com, dtatulea@nvidia.com, ap420073@gmail.com, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:56=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
>
> Pass extack to netdev_rx_queue_restart(). Subsequent change will need it.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

