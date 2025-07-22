Return-Path: <linux-kernel+bounces-740261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9136EB0D201
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0ED41C215ED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 06:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B192BE7C3;
	Tue, 22 Jul 2025 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmvgTlJr"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD8328F534
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753166562; cv=none; b=YjkJTxmyTySiLADeGAucifXJM0thv/oLbjURVycRMqd1MFm2w1Y8RHr2HfqBop4deCZAmTmJBcopRghnNo7TVF7RwvMOBSqhKIpwohDuinWtbx7cq0nqxjdrRrxMY2iClIB9fSglzi8KtHxvq4gtPR4AZmpZUhagMw/dY/R7Kfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753166562; c=relaxed/simple;
	bh=NA36uYIdstJH2uG8YyMNqBz92Za5P96z2ySsI/waiio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Asr90yu7bkvp+C86BhMK/YcbH8n332YNMh4wpvtp8ApMXJ4g+m7kwqdYgQvjz8rNHknZs/NtGGoya25KURV/dI24/4glGAE9n5nABuyL7e188EY/ATEg0vo5HkpvWwDbLyRQDZJKanA2NUUBIz/xLGDPsldXg/9CT+mPVRyASGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmvgTlJr; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4aba1bc7f44so35410031cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753166560; x=1753771360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6h6Sd7T3RH+CtFzxBNwU/jmY2fsZCbhu4Ru+TS9LQU=;
        b=gmvgTlJrfSwoMG+fZ6QguOUaMrznQ9U5KIahdOlJ3wRGrGLCXHM0qyFYwPRD+rI/a+
         XS/gXR8ZaYh01KSI2tzV5jOV/g2cBxl00wOYsHDDKV/D2xcgWPQ/nrMe1NFtnneX+I+e
         HD/f1AVKr8ArPSjmjj9uValiyrkIpciejl7CqyGMNhxOjdlB/E/6lw2u5qKqR7Md7zNj
         5ewSt9R2YDEowO33Yiaz19Z+YSKyPDpTlOqwYfmqzFBTD1dPRSJzRixrC+29+2jabjve
         J8I7UCgCW9ba1K2Yphw80AtXXGhOh+AFIsHdHMbMf4+vR/0H0ZDRomPZUSWTHOqxqdp6
         fq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753166560; x=1753771360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6h6Sd7T3RH+CtFzxBNwU/jmY2fsZCbhu4Ru+TS9LQU=;
        b=Gd/cGlkKnLW3iwBCPLyu6kP7RkFkA24R/dXIzVhDJPMfeh9Od4d++gJpteLEWTvYXp
         owkhaHJK6V2G5914fd40RjP1+BNyApdL3G422vwHDemLEPL8prGplpn+z8Z1+u+FWwPu
         RzQImun9y2FBSw3BiUjxQiabOmPmxN7W3EUAgSp4dTekYXVADw0EvyfWO6XiY5M0rbyK
         fId3I55drlZaHO1rP+Swf7oYSf4jFGXKR9eYaEppPC0pg6fjgllZeLVnRPmbzFSYnnFN
         7MN5EuQX9aOxIf1PztZ+gPdSQfhFS7EvCnD3VEtxZghp/qKPjRP3lps8Ox8i6pxdCOU1
         dkzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKMyjYyEY/erYMdMiUIv3X6odo1KRHdJL+9N1l6EHGHMZBNMCmQLusedB7jOmnqhvSGaTvVJUL+6aaDnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjNIlneftOjUmYBACDSU9zxgz9zQissfyZCq2q0mVM0TvTUAf
	lqNJEzL9wRLKSflA4KNWRGHOvMH8EmyXLyNoqKU2wSDjsQCLWaREewt4Td1/qjEQhfoXcwzM78y
	sBxvq2QALW3zPYZHlWudOnW5WnzLhKKsuJzisrZOW
X-Gm-Gg: ASbGncs/TWA4uHRdQUBM8Bo4QWKjVqTeUPyqcpFQJr80eMDztsC7FGACfu2O+PnaF0T
	36h/C8e8wUUpWNFwKZXmatZhUaZDPIVpZGJhn4UG2iTc3uLBh50bkLCX9Vb4Qm/5EHUrKe0WVUi
	TwQ84MikKbvl6eMG9fEMZd8BbSzAlWo7A3eYKk/Gth9gdzzVRRLkD1PKSX+qjrKltvEI3/EX1iM
	dHtmg==
X-Google-Smtp-Source: AGHT+IFE18i3ZNkbmsrw1BuD3fHiD6gRMvLpTbu/niAOFe34mLrrmfHvaIzaR08VQ8lZs6la4mlmVt+dTDNJFyAXP1Y=
X-Received: by 2002:a05:622a:4acb:b0:4ab:41a7:18da with SMTP id
 d75a77b69052e-4ae5b99f102mr36129921cf.26.1753166559335; Mon, 21 Jul 2025
 23:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
In-Reply-To: <20250721111607626_BDnIJB0ywk6FghN63bor@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 21 Jul 2025 23:42:27 -0700
X-Gm-Features: Ac12FXywVAz49IpEFRm5TGn9QbbuypsOmwnVNfzN6cH9wGhw3rlyrS0T17qYW08
Message-ID: <CANn89iJiLC6ZRXqJU82vsH0Lu+-o-GP_1WAK=2bcfdGmu7nKrg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 RESEND] tcp: trace retransmit failures in tcp_retransmit_skb
To: fan.yu9@zte.com.cn
Cc: kuba@kernel.org, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, tu.qiang35@zte.com.cn, jiang.kun2@zte.com.cn, 
	qiu.yutan@zte.com.cn, wang.yaxin@zte.com.cn, he.peilin@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 8:16=E2=80=AFPM <fan.yu9@zte.com.cn> wrote:
>
> From: Fan Yu <fan.yu9@zte.com.cn>
>
> Background
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> When TCP retransmits a packet due to missing ACKs, the
> retransmission may fail for various reasons (e.g., packets
> stuck in driver queues, receiver zero windows, or routing issues).
>
> The original tcp_retransmit_skb tracepoint:
>
>   'commit e086101b150a ("tcp: add a tracepoint for tcp retransmission")'
>
> lacks visibility into these failure causes, making production
> diagnostics difficult.
>
>

> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Co-developed-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Please do not add a Suggested-by tag when the original idea did not
come from someone else.

I only made suggestions to make your patch better.

Reviewed-by: Eric Dumazet <edumazet@google.com>

