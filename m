Return-Path: <linux-kernel+bounces-849327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0F8BCFD6F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 01:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 57F384E3670
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 23:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9423AE87;
	Sat, 11 Oct 2025 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JV9AFx7Q"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6CD4A32
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760224180; cv=none; b=uGITaqeueLg3os/Usw15F8cR1XD93Ht8V37w6O054qHFbgLiXmQ73i53uubfDgRQze6HNsp6aDxkfyijfbOYZIxfzYhqE2CnqjauKH/QLbpvBzx30kjK4LAS1NKKMA2jaYlIsxA5R7PActusM8UtedneqksLhDlatLbIRQmSc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760224180; c=relaxed/simple;
	bh=kwIziZXW/b3GUweXf89b2mnDrh6hjt4lnUKaaWXhI2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2891GZeZJV6m2kdJqmO7gQnpOKF1x7Mc/J3Kqmgx6HOnsM1Df9eekDufUVFtNfBjUt9e3DX/L2Kx0lLYRN0fNiTM6sgLovwik/awLkXIBJJvEitAfEdrkNPrxECxDhnGuWRKhOncC+oy5XZ1k+YL0CS0Nmr0nww8RHkXs8eDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JV9AFx7Q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso5049611a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1760224177; x=1760828977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n2xRuevGbELiV5K/IQ/amUfqczSe5GiGmwjfYw+TDgk=;
        b=JV9AFx7QtIKv1jdjt3vkbEUPJ+KDkKnF6fQf/hGYrCo/EewhFPnCNxZL8lQvP4cstU
         JZtRF/1zqDgLAg6+SvxE+oPWY5p3uQ7WzUO5lKYnZQLqSdRgjKvwXkr7l7pDpyWYhyaE
         rf5iBAsAbgcnyoOJryk8PvZpGUOtI5HTjaiu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760224177; x=1760828977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2xRuevGbELiV5K/IQ/amUfqczSe5GiGmwjfYw+TDgk=;
        b=l2hTdR7hhJ1CpH9y+pusEL4h3swbUMIYcIMt+7CVmq4udZ/I/n8qt6JGZ/ZwGqWv3P
         Yq1xZL/F1NSzcV9ystmticBYk4b/IFhl0t8o/q9iLPqSCOlUNOOfln6+tlsRSj0Dda8w
         T71oFU5LNzmZjxz21AHPIECUyn2zq7spIDp6vT315g7qa3EVoUOVI2TlPfAnzgG0r/yG
         8LNdVUgEk1KQfI1lrEyc27ijk97G2DdX+Ao9JTs3KjQGdmm6ZyW/gazoQSSr7RDMA7nk
         qH34lfX4YDg6ZO/gSJxU9DIx45Qh1CbvFr+QSj+WQBH6igpLnIWk6zg1LjuyW0ujErQ2
         FAWQ==
X-Gm-Message-State: AOJu0YxfrU+VV9+ZfbQCEELx3bFT3hM9t2DYIyw2my1K3nmn11ibQyBJ
	UGQ3eNnDoyBlKc/3aEKIcZAVxyCvh+/w3ZWRuVR16xjqq5XWY3bPPn8unfqjXaXRykMS+OCwgOe
	KdLVtDy0=
X-Gm-Gg: ASbGncuawMcoSemTBt3BWxur1Bt6cMXwVxs1jgUK2Fi2+rWR5oRpTYcqJ+4mSkqhSIS
	CzGOFFHaDa1BbgXChGBKJQTj8EMlj0iSUYC7f/85CT1lILl2xmByLcHoWXLk7Kufb5gxIKap+IH
	oI1DgH3CNAWwwOh5Dcon8ZGaT5QvqV/e0ZwPhEVv4V57Q4NQFcR6KsfaiP+54TqOtX0nfbgQDrQ
	AXINI6vVsM3Ucxl9SqcAUa/3jgmWT8NrtAIzFMVFABsPVQ8rPRdTeebRaDMykuTTcdriS1tlbCZ
	MoI0fq/cz9m1WsQ/8HbD/KTA1UqJw4y8o0YfPjrPmiv5XMnzPEtKmMSwIsB8xzVLgl5rTjzlswX
	QteOhcdve3qaTKClo6mD99KxpbkMsqxMQtAMpaQwYtAKc8dwUbYviKHPyBPfpWx1Wp+Fe2CBSWG
	xrECa+1FgB/rd0pWsMNurHz1iSng==
X-Google-Smtp-Source: AGHT+IEeT7vSt4WrCmhObgiFADX4HyEbO9WYmUeJFzyda9cRgM8ILOQzMHTpsDhfj+HmJy2JT4pu8Q==
X-Received: by 2002:a05:6402:210b:b0:639:ea7d:f675 with SMTP id 4fb4d7f45d1cf-639ea7e625emr11430586a12.9.1760224176671;
        Sat, 11 Oct 2025 16:09:36 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5235e7ebsm5641020a12.1.2025.10.11.16.09.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Oct 2025 16:09:35 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-639e34ffa69so4776659a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:09:35 -0700 (PDT)
X-Received: by 2002:a05:6402:354e:b0:639:fb11:9952 with SMTP id
 4fb4d7f45d1cf-639fb119c26mr10082623a12.3.1760224175190; Sat, 11 Oct 2025
 16:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011155240.59f0ff07@gandalf.local.home>
In-Reply-To: <20251011155240.59f0ff07@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 Oct 2025 16:09:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whYZVoEdfO1PmtbirPdBMTV9Nxt9f09CK0k6S+HJD3Zmg@mail.gmail.com>
X-Gm-Features: AS18NWCNr9tSx5dq64gGFkTrOZmlQjQOwrWHOlF_QnSSXvtjAT3TcwkGGDt9DBk
Message-ID: <CAHk-=whYZVoEdfO1PmtbirPdBMTV9Nxt9f09CK0k6S+HJD3Zmg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: A couple more fixes to v6.18
To: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 12:52, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +       /* cnt includes both the entry->id and the data behind it. */
> +       size = struct_size(entry, buf, cnt - sizeof(entry->id));

This seems very non-intuitive.

Why isn't it just saying

    size = cnt + offsetof(struct raw_data_entry, id);

which would seem to be much more straightforward than saying "go to
the end, and then subtract out the size of this entry" - which then
relies on the entry being the last thing in the struct.

And if somebody wants to have a helper like

   #define struct_offset(s,memb) (offsetof(typeof(*(s)), memb))

in order to get some kind of "typesafe offsetof", to go with 'struct
size' then by all means.. That would make it be just

    size = cnt + struct_offset(entry, id);

which looks fairly legible and logical, and would go with the comment
(and would pair fairly well with our other "struct_xyz()" helpers, I
think).

I've pulled this, I just reacted to how odd that calculation looked.
It makes very little sense  to me, since the calculation really has
_nothing_ do with the size of the struct, and you explicitly have to
play tricks to get the offset that way.

         Linus

