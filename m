Return-Path: <linux-kernel+bounces-885275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA5DC326E5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2D1189EF9E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AEC33BBDD;
	Tue,  4 Nov 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugPQCSCS"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F523875D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278481; cv=none; b=AaUup4hgBCerkgS2MwpgyZCzhYJ3vGtBUH8X8jLmpmh1SQsVcaUg6GqnAFf9TG+btvzLNcIArwXSp92PvBrf91pHn4sS10VqAdKkOFmuSF88dqnWbH0Z26CSwOwrmkFolFTrJL9C0dJIhriLLJlOcpaA7mlaYn9AMJJAL/NP2/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278481; c=relaxed/simple;
	bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PSYWkzBFF5wMaq8poneqgfYe4M1rQ1NmxBVN58B6pCXc7C6LhHQQbhdnKpMXUNAiWN66MnS4op8oDmlOe5bV2jwb5AjAl3Q4btkBlsd7smVrmNqT5rBxkCN64djE7J2qJNA27aYG2fcbHLivXfY1ib0cM2SnCeg1oSn3X1LNeN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugPQCSCS; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640fb02a662so168a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278477; x=1762883277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
        b=ugPQCSCSXojk6KFtAa99RlQNpQhR/iSiUJkjX+ysoYt7kmvj5TjvSYZJf7X06XbckA
         M/P7ERcol8+OFYvX+8af7Bc7UokUG9fiMbc74rThA1q6LZS6e7fRwHzNXdO3Lh8o6Qe/
         PNBbQIjYC4vMqOx9xl21aIw60Oo8KPnARIG1F6GPti9POO4CI3GjhSj65PQiqfaRtSCH
         l2ovvTL/ClDlnYQUn0Aj1Cv5t9kCb4Q9ZCnJllJNePRFgnfMCM6sVFv/ksI8IQDREV1S
         DcUhmIFr+veFz/g/Xj9LOt5aXpLIMM6DJUooeXCwrnZJP3bTjkSXgrLUZeYxi/grCIHR
         1Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278477; x=1762883277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naZDWD+jXe2RTykUsxPPBYLTaOHt15sOSQ4dJwHulZM=;
        b=YlsdfUelom5zlMJG1nNh8X1FeT9/WBaZqps5z0123GLSxuTxd6vTV2Eczlfkf8a8T3
         w7p4XTM31rS7kNoGj6Fy13ElC5W3R/GRyowtSwTYpAB71ssLZzCKWYWEycUhsaI06sDQ
         KtIzzWDJxLmoeTYhcmKxVWFcvjvAx73C9bOgt/R4eA6GC+Fc7u90ajeS5LRPBmfl5T9S
         okuwauLqrSnPZdLI1SYdblA2QGvhl27qkGOEpEd/wr1i6VC78mjNFcspYCkFTt3wfMBO
         S8hkh79ug3skNjUImEtkCto+j48RxB32JgmBY/OFSLKF6b5wjRZOyrA0sJ7txWfMu5Xg
         +F9A==
X-Forwarded-Encrypted: i=1; AJvYcCW1G+jMpcGoELfKoq9wG8KX3jXQPiRAgHFMzZrD0RGk3Iy3CGc4KCLZnSO+JysWKQMEkrs7fmmhOZulVqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJJwm+PBaBLUZrQsFkIZPnbAySNIQd9OIObEwzvjk85pmKvgQ8
	OPS8vUn7odULEFfaUiQk3GRQGV4QOe/8PzlHbIjWWhVTSkS3SwsWvPiW1oaoSEiMGfKrOz5OH5y
	iB2CT7tp+0IUQOrs2obwNnlZWVScA3wqWzRe8nleX
X-Gm-Gg: ASbGncsb0AxiSC3J6BoKcqDhjEDLe+LrCRxLPBkZMW/5oy+EDN5SGDIiP32gN7oxnu9
	n7ltw5Ml2lbU0Yz9f7EbGzHYAano09+x0/GJ2VDg3QN0uFd7h4CaF5OoWjl4Q7DaXZYqq3+jNkK
	mIuww6Up+9jAj1eUH9kSmYhP1nskYq79UtQ30P6BNs6b/z937OBi2DvQfIcwFyYksNmY+vEsBjX
	vNtVdVd+A/CKpyDzjqUHRAw/KWcHQkWR0XyCHwn5qQHY8NbXMGfn6PBAOyp2YOaCNdxTKJiowtU
	YtKEs16FnNknVaRoISQCSklFrQ==
X-Google-Smtp-Source: AGHT+IFxVdvZoaaboVMnWhHpGqiOgxBaCtl8Wdw4aZprlhirqeuesq/cXrOlHupxbHqRD67wfy6/JLS2mKLwz3kVBAY=
X-Received: by 2002:a05:6402:d5c:b0:63c:1167:3a96 with SMTP id
 4fb4d7f45d1cf-640e9327aebmr121052a12.5.1762278477045; Tue, 04 Nov 2025
 09:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030180832.388729-1-thostet@google.com> <c8b2b414-149b-4f35-8333-43011804ea2a@linux.dev>
In-Reply-To: <c8b2b414-149b-4f35-8333-43011804ea2a@linux.dev>
From: Tim Hostetler <thostet@google.com>
Date: Tue, 4 Nov 2025 09:47:44 -0800
X-Gm-Features: AWmQ_bmk1rluEW2OlBfvkjh-u6qvpegsGbFrmPmMfNLljZ4WeLV2baWrh6d4TPM
Message-ID: <CAByH8UtTVvLQwOe-ieyfvdFUnLz8X11b_ipWmbNhGkAZAXWfOw@mail.gmail.com>
Subject: Re: [PATCH net] ptp: Return -EINVAL on ptp_clock_register if required
 ops are NULL
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:32=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> The patch itself LGTM, but I believe it should be targeted to net-next,
> as it doesn't actually fix any problem with GVE patches landed net tree
> already.
>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Thanks Vadim and Jakub, I'll spin a v2 for net-next and fold all the
input validation into one WARN_ON_ONCE per Jakub's suggestion.

