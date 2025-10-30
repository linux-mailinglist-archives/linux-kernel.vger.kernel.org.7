Return-Path: <linux-kernel+bounces-878719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA95C21550
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6439564379
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B76D2E1EEE;
	Thu, 30 Oct 2025 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXfB9OT1"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A919208961
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761843105; cv=none; b=HBTGCxeDL9mo5lMXRzkqcdjQcqO5PshWsOfJLG59hn9FiuDc3lAZ0FqtrChWPBWSeuAzXuFJOZdeDYKbRM3el/XxNVuhXe4KzAjWJBhqL3fZ1vBG3FRhIlG3Q0joGqqbZiMQqyykQzUCfzZbC7V55qVgFhgF0EjuD0pAuYefCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761843105; c=relaxed/simple;
	bh=w7MdZ1mfZj0HzaTPQ6YcuBUX1x8B6b4OhuKTS3ausrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tcd3Rh7PigwFnLHRyu/WUuQADWkoC//wMTyXAMnPbgAX9T0dH3+P8xkW6n57xPg3IffiOiNF/Nbl/Kx9qhkQqPqWilhIZsFCMEA5DSU0Eie7dVKBAXhxESFF91mBvCCU5Os4NL14zmPhDPrwGyr4EaS8rpGQeDndEaN8Q29hxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXfB9OT1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-426f1574a14so899696f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761843101; x=1762447901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=642ZNIF+OsydxL+rTU9JAq3ae2IkWd/EfYGNdJrsMAQ=;
        b=SXfB9OT1nVzlVGO4+JiPRUDwqnv2oqjnyB/7hXMnMT32TdpmOkxEWux4pM8My1/TyG
         6U8Cnelu/jqJpDWxwDT2M+VDTcDcoudG+bajb+Zcf70e8VtXtz56J5L7mp3zapZFrSjw
         dLEwfeBguhQBxHmbrRX41Jn1XRRHyFRvLEIYfPyoFLPpHY7tOsQdWBzzZLpAaS/9acmx
         8R7+0EO0O03fEy8/WDNA3hpwjsGhcgAKSL/oAYgvD7x6daYUn7jmTju3aKrGwAEHU0i4
         UJ7aAB8rBvNc5aQyxIsTDEN6PpKWtUVw3lwwgKQu8FCh4rdSYgiZsj1eGcrEFyoESWpy
         pEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761843102; x=1762447902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=642ZNIF+OsydxL+rTU9JAq3ae2IkWd/EfYGNdJrsMAQ=;
        b=b9j6SeJAd7xUqfcGmdW9sbxQyqvij5Q7J43ow+YVcnVLH8ezCiBffKSUdUf7reSvfh
         Rl5oBPS7jmfMcAcd92siP8oSNXGNSLnq2e2mGPKOxoq+Puq1uPfMEXzYSkP3mAL8Tjo3
         e61cPcC6uCaDPsH1uExiCblixl40WvgCPHjDkESKdktPK3B9LPPp/yYDNkcW+bNhAaBN
         e4CbCm6VvBH/w/6haeUa41/JuPhGnfytki6grH9pG98YCgIkpgrEt/ZxdjzF64g0Eg3u
         CIOPC4drMhf9kfwQVVPRRi+5smd55corZCr3nWrwE0hC4eEGj4RQ3E3CtaydL97dJfiQ
         YLlw==
X-Gm-Message-State: AOJu0YzOAOClCL9C9ng7HY24j/u86qlnb161KfGCeuqjT+bJbO/vATrW
	3DPUariecJPxuj4s3fWR3WhUmC/am64qhJ7EhM5FYdl5C1uwYF4F8uIF
X-Gm-Gg: ASbGnctNtZO4aortk1y+Qjsb/6f5D2NqOf7A16+hkqM7LTkL7MMm8aMI6cdLfR/IaQV
	4sgL88/GuNafgsO4Z3n7Eg/7r5zzar4mHYBB5Zc9uwaE8Th7a7GAXZj74xaZ07J44Jgvm/LfQjP
	8dOKnUOncZglGGXp6WdmVKxonTvb1V11pq+BjOGq9jvi7AXo/lhMYMiI8y2OSFSW8j9mKWl9SOE
	cNvph4cJHLUXLGsfwG8VUasVgNGnhVUxCk5hgtt0XcH4pf3YygqKLjuYE6f9613BwDOI1k+rTpS
	/2JYjCIX6uuhYjfjrDdze3grBt/+l4/ILoxCd4bXJT78ysiNSEBMIFMuy0qDYMraGWUnMzvb0k9
	Sm8sA73c4maxFGjH9cySXu5kBQvDHazcYnNsDA7SqgHv0n8AVQwHLaz8yBXUX3GH5B0lWYNE4Kt
	HashHxODpPDsG4wtT5VRc/gFt+tP8LMQtzmNgVPvPwVw==
X-Google-Smtp-Source: AGHT+IF0stTDl7rTDpm9gRcYmpqwUW/qObxz//km/bYGg5tD0DL27Eyh3Cfc+jrTsHmK/BoF87V8SQ==
X-Received: by 2002:a05:6000:240a:b0:428:3e7f:88b7 with SMTP id ffacd0b85a97d-429bd699099mr253991f8f.38.1761843101322;
        Thu, 30 Oct 2025 09:51:41 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4772ff83182sm2950385e9.4.2025.10.30.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:51:41 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:51:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Kujau <lists@nerdbynature.de>
Cc: linux-kernel@vger.kernel.org, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: maple_tree.c:3738:1: error: the frame size of 1040 bytes is
 larger than 1024 bytes
Message-ID: <20251030165137.56eb618f@pumpkin>
In-Reply-To: <bb105b91-1f11-0a2b-a666-6ee72f86d989@nerdbynature.de>
References: <769dc761-3ea6-76b9-d6a3-cd64a3fddfe3@nerdbynature.de>
	<20251030143400.09fc0a89@pumpkin>
	<bb105b91-1f11-0a2b-a666-6ee72f86d989@nerdbynature.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 15:48:30 +0100 (CET)
Christian Kujau <lists@nerdbynature.de> wrote:

> On Thu, 30 Oct 2025, David Laight wrote:
> > Does marking mas_wr_bnode() 'noinline' help?
> > Some functions are marked noinline for KASAN builds, the comment suggests
> > mas_wr_bnode() is one of them - but it isn't marked at all.  
> 
> Yes, I've seen that too. But adding noinline or noinline_for_kasan did not 
> help, compilation stopped with the same erro^W warning.

I've just looked at the disassembly of mas_wr_bnode() of a build where it
doesn't fail.
It is horrendous - best part of 4k code, the stack frame is 0x408.
Which means I must be building with a larger stack frame limit.
Is one of your debug options reducing it?

OTOH it looks as though the actual place to force a stack frame 'break' is to
stop mas_rebalance() and mas_split() being inlined into mas_commit_b_node().
(Probably instead of all the current noinline_for_kasan.)
Both those functions are large and don't have many parameters.

Oh, and the WARN_ON_ONCE() in there is all wrong.
A WARN_ON_ONCE(type != wr_split_store) after the call to mas_rebalance()
might make sense.

	David

> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 39bb779cb311..90ec87d4d49d 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3727,7 +3727,7 @@ static inline void mas_wr_append(struct ma_wr_state 
> *wr_mas,
>   *
>   * This is where split, rebalance end up.
>   */
> -static void mas_wr_bnode(struct ma_wr_state *wr_mas)
> +static noinline_for_kasan void mas_wr_bnode(struct ma_wr_state *wr_mas)
>  {
>         struct maple_big_node b_node;
>  
> 
> Thanks,
> Christian.


