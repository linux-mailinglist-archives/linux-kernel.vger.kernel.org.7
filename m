Return-Path: <linux-kernel+bounces-866861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F161C00DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2B213B2631
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68930E0CD;
	Thu, 23 Oct 2025 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSHez1p4"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59B30B51B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219693; cv=none; b=AZUdXJ8z+p0WoefUgyhYiIRD2QCgnl9aLP0/Y6I7AMraVhdWWu2Iz00mb+xVwJx172fpsO9gZwhS81KwI2oF4NKtNNTVpYy4C8MkfCrBGVRyEbe/jWfBNWwJJeVil00QCB8W5skVEz8YOu4S8r4Tx6lwZns5EDaDQSX1Ua6ymLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219693; c=relaxed/simple;
	bh=tCWB8eZl8/ULIrv/Lv1JyFMJF12YEm+OEzrPMhTM5Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iO6IJgYSy97JT+4+6oQd/CRrexKnfjBqvhj8T5X9/M5vTkbRxJMrfDqecuAeuNv0enMp5iPC+prU39stqhfBYRzpow5MttT8Sx7YZyS4CNHUq6eGYRrsGP+B22gi5VbnRNZ+mqBcWH1Pm3kjlPmko1kqASTGFdO5xd68JVuwLuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSHez1p4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471075c0a18so7874425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761219690; x=1761824490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZyKD383bQoqOxFZk5G6Ho+/pzc/ouF37MPGyirm0sM=;
        b=BSHez1p47gwsvywGYwab2fMcPReF/+6/m4kG6H0EFEUxqVLLRQ9cBsfLenW1TUbqFf
         1NcchsVjjDBJEZI087dXzIGviz1a2lBSznlVU4EzYPvJ8dp5xj6Ra6icAZ+1aSPxzbmE
         tG1Zg5OSPQpabLlH6Pud40I3fqKZxBHkE2OGEXVIgvx4u3eL5LZkn0xBD1YYa1ES0/bu
         8wLkKQREkHRzkIithzfB7rZyuSsBos+liyBKGYqxbPjQZ/wGGu2soxTfTpJGz4kJ+65E
         qr4CP+2J5R1jnPvO3nSTts94zEemIQisAzVjE7oSi7TDo7XxFVRMkwduluaEM4/KH79J
         QnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219690; x=1761824490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZyKD383bQoqOxFZk5G6Ho+/pzc/ouF37MPGyirm0sM=;
        b=iAxx1zBa5CCW04RkWi9eUpXv1g/breMHCgd0i3X62UndPt1jF2OBI+hYsJcUSPU2lc
         YYjevTewDqJyD8MHj76crJMjF8V6BjGX1G+lnRvGFiRpMKKM6mA4XKWJ1YuUeC979z8G
         NVBZc/4kKlNrXCFQYEWUVhN7Thc21R2ebhf+Ud0Mz/RNxyY62Ujy/Qv3mjwVGTIBvPg3
         Ns6CNP7zJPWLwaKXxbTnWexFx9dbdaOax5rfdoRduQ3nGPeZtoSNjf5BwZkuPCMcfUZd
         Btk4Vz721a2WkBB+dB/G1vS+10hPkJF+XNCxIT73sbDmPs+rhuB1hZxygYW8uXovGtnL
         e8MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfot7WsPziS3IEx+5XtcW8dcPk+CbxrzRBCyWLpv0IWajgD/89UNQrjsAh57l5IdvxdBH/2Kx79jEino4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFNI9xqf59l0wkTBlNeYTGvpoBse1MsSjsN35vqIEy/4NqK9ir
	ESKkAiRcSW58aI2r9abOK5e9B8rOITWEAcqiZNQFzt0QyPgc5c+qSbSq
X-Gm-Gg: ASbGncvs1iagSIaLFGIk2My5L3x/wtd0hUM0pOChliRa/l8XjBjs8XHvGrxdqOQUT36
	sBTbTI6tFkuvpy31rOucCmRIdnxAkkLmzBzBrb6/CrduP3SzqeqltXIEgEERbwBN/t1ej163N8G
	hUELT0G7IMn3Fo9Ab7xyW0od/py92bqzW+beD6fJiWfqAU5oVOgXQ08Ik4/ezHxHB6e5eTqOjJa
	dQBuT+bOOejlevDZ6YJVJyRFAdirw2AKDMrwQCgvkbt4xKc1cjKlpJY4rIgBNW7eBsSd2Co8/za
	NqACpO1zWhEyd0pprxS25TWN+RQEqFksYt6aLWruB1VHn3nUwAwLhjypfxW5jnA2aMoAEN3pDm3
	andSGa+hE27QTF7hY2QJuYQoOkt2lqoNcmdxZOTbfPz7ls5pSFxXwdrwmDVpPXX3eK6b+JH9eiY
	8OdxY97gdvh52safKkgEZA0bWoqykjROJN/rAG/3BQ5w==
X-Google-Smtp-Source: AGHT+IGlUn2L6ygzDQsBh/Eml4gQWf9e/nvZjjW9f4ITDsLcyuehhyiV2w5QA4lrO4ML01ofHt+lFA==
X-Received: by 2002:a05:600c:3ba1:b0:46e:47cc:a17e with SMTP id 5b1f17b1804b1-47117870544mr196707655e9.1.1761219689367;
        Thu, 23 Oct 2025 04:41:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4378cbesm89230435e9.16.2025.10.23.04.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:41:29 -0700 (PDT)
Date: Thu, 23 Oct 2025 12:40:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Gustavo
 A. R. Silva" <gustavo@embeddedor.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
Message-ID: <20251023124043.3dab5646@pumpkin>
In-Reply-To: <268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
References: <20251020212125.make.115-kees@kernel.org>
	<20251020212639.1223484-1-kees@kernel.org>
	<268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 12:43:06 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 10/20/25 11:26 PM, Kees Cook wrote:
> > Add flexible sockaddr structure to support addresses longer than the
> > traditional 14-byte struct sockaddr::sa_data limitation without
> > requiring the full 128-byte sa_data of struct sockaddr_storage. This
> > allows the network APIs to pass around a pointer to an object that
> > isn't lying to the compiler about how big it is, but must be accompanied
> > by its actual size as an additional parameter.
> > 
> > It's possible we may way to migrate to including the size with the
> > struct in the future, e.g.:
> > 
> > struct sockaddr_unspec {
> > 	u16 sa_data_len;
> > 	u16 sa_family;
> > 	u8  sa_data[] __counted_by(sa_data_len);
> > };  
> 
> Side note: sockaddr_unspec is possibly not the optimal name, as
> AF_UNSPEC has a specific meaning/semantic.
> 
> Name-wise, I think 'sockaddr_sized' would be better,

Or even sockaddr_unsized ?

> but I agree with David the struct may cause unaligned access problems.

It probably also wants the 'sized_by' attribute rather than 'counted_by'.
So wherever the length is saved it is the length the user supplied
for the structure (or the sizeof the protocol-specific one).

	David


> 
> /P
> 
> 


