Return-Path: <linux-kernel+bounces-888594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B866C3B4BA
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D77E464C20
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D9032BF4F;
	Thu,  6 Nov 2025 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imNPCDjG"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A11DC985
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435889; cv=none; b=tzISmWgJv31+KIcfcI7Fq7PJUyUa60PuxGDgsamvH/AHSd7h7dpypO6WWc4b7HSrkHfv8IU5bmAVOsS2TGEPVcuDayb6UiGwcLvtnIJOFAvK1kTpls7FH2dKH3kSy91DdLHC5GjIjb9+XlWnW/7PSnx9uiN9zRce5STtgbQFv2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435889; c=relaxed/simple;
	bh=af/u5MPwknBUKn+y6y7ceb0RJfWLaUC6BR0VZMYiStc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/joI72l5AKMbeTgVsLlsUm6R+Rih0ELnoSKHEwEUapytQw/Mq9+T4txrj43V/AfMUNyphaYWekvsD/rBLgPrXxUH6TyPkesVtNOsVWDtxvdp5D5SHKndTAWJuAYP40Swt2MMsurkcLQeJmipleX1hDEnmoI24ygCTe3K+4/txo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imNPCDjG; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bb66c96a1so223319a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762435888; x=1763040688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaNYq/4ApcRo5kmZ4OP+eKQK3Ozb82qKcolYqklF9dQ=;
        b=imNPCDjG7fWbsWQBmVDk/vXJjHacCBkatXaq33wQ400mg5c6/anYjFRCWsYkhajyim
         /lD7hYqa/p71grXg2KLjhQlSRQaGaGV6gq0E+wuBFxLqF2qW0XnQbOvgRgFEXcQygWIM
         WXyGMznhEHO/sLHFk/zIBFBnRNmDMHC4+WB3qVwCAhrTZgfCTMaADzJsDzRdOHetln9I
         xBbosHR4HRANh4h7r/qK+ACqidJvHuLYeUYJFPuwwUPW+YlNrzkch4MT1VUaJjxX/NSz
         FUaRKzlDD+rhZmE/i+tqN3jXHe7fFBXujgeYuoeCPXxR9k9pmTJDi/OzkLmL4EmVx1LC
         iVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435888; x=1763040688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaNYq/4ApcRo5kmZ4OP+eKQK3Ozb82qKcolYqklF9dQ=;
        b=MxKWfxY8ugeYvDCQYNJlzv2WOvgDVcEPT4alqAk5XIHomADvdDFSlor0tOVbdX48Zi
         N6hmK0liY164cVps5oTn1NLOLsPf5oiMNekCcQVn5x0Kc/Sj8bpArwgXvTCcPcVCybKx
         1zN4PZyQZSeEwHeUnfsYC98IBWtrkwH3ZMZO//kTGnguf9nywqsRDrZYu9ufZC206aZ4
         Y2HeLAn9i1ydILK0XnJNpEMuFOSx6mshGBmGE0slkshxyT2+OVthPnaja8yPuMsEHSu7
         L8qYQec5B16QV3YczWQwSwfJDz1z3GyDGdy5EJ9Zl5LyzOrNub5qt2xo2FbsnScFZXGv
         +8lg==
X-Forwarded-Encrypted: i=1; AJvYcCXh54DaLI1xIclt8oijIMxCGUaAP+H4ZBonlwQeihhIvSl3sZ6mnbIteN78ol1fOknqFEX6afafWrHM0P8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzamo70pkrPq1LmRXU/rEe61A8uHGSRg9msexxCviqo6y2891dx
	xJP6cqeTZWl6hG1kUP7HbiPhec2cTVDVmUgiIt6pYEPaC1KbSlZ2CWWv
X-Gm-Gg: ASbGncvhVrwNGIUeAZddq9t4C65Pnn3fU+mfuxepkh1gcwS63GftOCv0yzaxbFGToV8
	6ge1GXxlUQ1I1n8AuHagn+wMfUuv7xibKIElTeV8IotLESdy34rc+hXJgnitYMoLYNp/WN6TSRi
	AWZQs4o6x0pwOkG8dKPiQkZym4BgXSaoann5PqAQdVS7UxwsKjfgWQLetGgrmiHKLkTGMpcH5rM
	M42jhcfNYiPhp/V+jlrU4tL+QBiF7QSJbal2v7LltMlttwohR8fnzm3A7QenBwpTNz9fHlrFMH8
	v1BxN0w+UAsHgWWv6GepSHu6lhs/A7nGOcAA5CJBMlGhKINHJceY6glSvFKtwTKzm1jGrUipWwH
	EemeAAkgbZUE0kO6QrN7/0Y0D37eGWAiPpVIIyncqvwXqQChA+Ascy/qdlAJ/1inQ89dE96mEjZ
	GG2ouhWIrhSNpiUEjGMTPCKQwSqzhnjU+ChmLbGQGcwA==
X-Google-Smtp-Source: AGHT+IEejj/dxgSw7UjjZLXM5ttCvRwZVFqv1vApKP9EbtckAjhelPP7ligXT5AUXtN3gQgrLLDTmA==
X-Received: by 2002:a17:903:1d2:b0:295:247c:fb7e with SMTP id d9443c01a7336-2962adef0a5mr51636245ad.11.1762435887590;
        Thu, 06 Nov 2025 05:31:27 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:fe91:a1ef:9f13:366a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c778a5sm29351795ad.73.2025.11.06.05.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:31:26 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: horms@kernel.org
Cc: davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Subject: Re: [PATCH v2 0/2] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
Date: Thu,  6 Nov 2025 19:01:12 +0530
Message-ID: <20251106133116.4895-1-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aQuh2czgE7wmTxbq@horms.kernel.org>
References: <aQuh2czgE7wmTxbq@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/6/25 00:43, Simon Horman wrote:
> On Wed, Nov 05, 2025 at 10:09:37AM -0500, Jamal Hadi Salim wrote:
>> On Wed, Nov 5, 2025 at 7:59 AM Simon Horman <horms@kernel.org> wrote:
>>>
>>> On Wed, Nov 05, 2025 at 03:33:58PM +0530, Ranganath V N wrote:
>>>> On 11/4/25 19:38, Simon Horman wrote:
>>>>> On Sat, Nov 01, 2025 at 06:04:46PM +0530, Ranganath V N wrote:
>>>>>> Fix a KMSAN kernel-infoleak detected  by the syzbot .
>>>>>>
>>>>>> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
>>>>>>
>>>>>> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
>>>>>> designatied initializer. While the padding bytes are reamined
>>>>>> uninitialized. nla_put() copies the entire structure into a
>>>>>> netlink message, these uninitialized bytes leaked to userspace.
>>>>>>
>>>>>> Initialize the structure with memset before assigning its fields
>>>>>> to ensure all members and padding are cleared prior to beign copied.
>>>>>
>>>>> Perhaps not important, but this seems to only describe patch 1/2.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
>>>>>
>>>>> Sorry for not looking more carefully at v1.
>>>>>
>>>>> The presence of this padding seems pretty subtle to me.
>>>>> And while I agree that your change fixes the problem described.
>>>>> I wonder if it would be better to make things more obvious
>>>>> by adding a 2-byte pad member to the structures involved.
>>>>
>>>> Thanks for the input.
>>>>
>>>> One question — even though adding a 2-byte `pad` field silences KMSAN,
>>>> would that approach be reliable across all architectures?
>>>> Since the actual amount and placement of padding can vary depending on
>>>> structure alignment and compiler behavior, I’m wondering if this would only
>>>> silence the report on certain builds rather than fixing the root cause.
>>>>
>>>> The current memset-based initialization explicitly clears all bytes in the
>>>> structure (including any compiler-inserted padding), which seems safer and
>>>> more consistent across architectures.
>>>>
>>>> Also, adding a new member — even a padding field — could potentially alter
>>>> the structure size or layout as seen from user space. That might
>>>> unintentionally affect existing user-space expectations.
>>>>
>>>> Do you think relying on a manual pad field is good enough?
>>>
>>> I think these are the right questions to ask.
>>>
>>> My thinking is that structures will be padded to a multiple
>>> of either 4 or 8 bytes, depending on the architecture.
>>>
>>> And my observation is that that the unpadded length of both of the structures
>>> in question are 22 bytes. And that on x86_64 they are padded to 24 bytes.
>>> Which is divisible by both 4 and 8. So I assume this will be consistent
>>> for all architectures. If so, I think this would address the questions you
>>> raised.
>>>
>>> I do, however, agree that your current memset-based approach is safer
>>> in the sense that it carries a lower risk of breaking things because
>>> it has fewer assumptions (that we have thought of so far).
>>
>> +1
>> My view is lets fix the immediate leak issue with the memset, and a
>> subsequent patch can add the padding if necessary.
>
> Sure, no objections from my side.

Thanks for the clarification.

I'll send the new patch series(v3) with fix(missed ;)
I'll keep the current change limited to the memset fix to resolve the
issue. Also, I've noticed that similar uninitialized structure
patterns exist in a few other locations in the net code.

Thanks for the review.

