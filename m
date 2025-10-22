Return-Path: <linux-kernel+bounces-864828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3A0BFBA3E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A5214EA399
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F80338938;
	Wed, 22 Oct 2025 11:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq4Vbwk9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F1338924
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761132492; cv=none; b=T7t9ii6js3w2w7UVH1uky0C4cCJjwnc51Uzyd2/jbRz8nOAyVKyJyPdgx22XAQml5rP0kGW/+CvQqHdfkb/ucbkFpMjOyEAiSYiQn5xRTDUL2AjVzConjKV5Pxlo3nY31K12At8b+uItqm3pvKM3jfv2LP8fuSWZHscg3y14Mik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761132492; c=relaxed/simple;
	bh=GeYp5ENRNtZGT10yPqhZlLkA5ANkd2KNx9IryLw5koY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k4y74pYGLiSJIvvXy0F3cClxpxleZjMTj0kxdfeQM0WpZup2DlBjBJsNvYC3DCkp7LNQOqkjQ9TZq8xX8a9TAXgYlbYQif01nJimJC9bv/LTy207gckKQQiUhQ/nkvzlU0FCZ/wqmukdrqwaE7bMlECYDNUlXPi58qJkwIZABaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq4Vbwk9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so84902335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761132490; x=1761737290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqxPU3ybT0jcPtSpvtuctUbg2p7l0ybpoGGX4OXazrw=;
        b=Aq4Vbwk9QcMPBwjRSfJ8fYXQwlFKWqKPBgHX+1pgX316vONZTB2U1oVm1owf7xvMwJ
         rZ6ivxyMCC2ZFVG0QwHh+KkrYva1+zrR+gJdDY4n42TNqIcUlhV8dXxifBk2B+PEznpM
         TcB7LXZNONQQCT1URzBH7Kgs9Kf38Ui7KKdk4MWaBf5IOz/E0R4qopDZEMpP+P4ekaTD
         IY50LpsySBPp1JhAiWyvcP598uKZMQ7RYWGXQuIKZT9DWfLLhjt7gZjRLshYMu1YaZCe
         8HAsy+B3fA8QXint2qjcSG0h2TmpD9SqFcXqoLw/bxKv72E77MgWBSDHrGOpRXqbrbpR
         hs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761132490; x=1761737290;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BqxPU3ybT0jcPtSpvtuctUbg2p7l0ybpoGGX4OXazrw=;
        b=a80Bu1LcZPdZ1e31WJJg0ufqT5u13/FWh/oncNnEHh56WTWbkFajZANs4pCJXAG9Mw
         dqVoMzYFWQSMEkZjDlFM2JjQY3wpLBgr4aPvtCY4yCoYAvSW0ukOwc6rMsVo14LJcfO/
         q8Dm02xXlf1J0hGWAVnjs9kcEhRwNfykgaFBTQNN2rvA/xLBe3s4ws+1NmfFyKThYjAj
         jJqKLX7b7V5y8QK6Ut8Z8wc2dq2AiCo55moJG0qmnuQkbtW2WAf3DGimjJy5/slfqB8t
         57N6F2pBaN2Jcf1oGEi5p4thkZ9bJiHfwGz2vwkwFrYffObFfSsyharWevmXYGvfB7r3
         4oEA==
X-Forwarded-Encrypted: i=1; AJvYcCW4qElS5nDbETiG4TdJZTYyjtvVP1mbTwoS//aOp7+Tmzs9qRlPa0uWmvgKizRj0iKKyPuPSLGr7CSTsHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfgX2BF3I4PHJFvLd81udNq8CXIgffWq9I+S1mx0UEyMot9fto
	sAqIpsgtRuqwCRuWWIYy7aRpBUVLRCm0nYFc4KH3T6vPAbNEFt8sFEs4
X-Gm-Gg: ASbGncvMz+1Z7yxBcBkm997ploOXxLb+AnyyniCM3oB5W+6usOUqavbeHuRX4YOEeaC
	LncR4+T471ejIKl5/4+7BSLwxzgpuY28Z3PGnSu5rD4yxdL8uJMYCwKv3+y33lXyHCwRtG809nC
	aeEYRZClHV7WF6kquSWR3YE2izMrcvCJ+e7lwfNOhNrABbRF6ou2fG568EtlOeRx7NS42CRUjDO
	2RecAbjEVCRDVhw3HOcwJmNhKyS/7SGW+tjdiq7MBUH2I2nlnQWW8LjAZkP/K1GCccplLyLSYCt
	dK23gTqF2NF8r0h6S9peAqh2CpWLTYGbVtA/ux3958hPirMU8daPmJlbMumJQPPYO8FWWxVla9E
	biMnnjhf1miBf8dOxTOSXmke3zvAmwABm8O5VFk3hoYNCynNQaGjOtFBuRPm33Qjn+qxvEGZkua
	7CmXV17VkXAsziPdUoq4PAdUXdLI1ZIUSctfpqEytPBmEZCf6oDizwHv02W/xG7cbM
X-Google-Smtp-Source: AGHT+IHGaMtzm0oPfRLcVei5D22QVh6bUWN9a4cAiOtccRcsTBGutGIH9BwZOenuaOtlvKNrgysN9A==
X-Received: by 2002:a17:903:138a:b0:290:26fb:2b91 with SMTP id d9443c01a7336-290c9bef53cmr248187565ad.0.1761132490409;
        Wed, 22 Oct 2025 04:28:10 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247219357sm135633135ad.111.2025.10.22.04.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:28:10 -0700 (PDT)
Date: Wed, 22 Oct 2025 20:27:54 +0900 (JST)
Message-Id: <20251022.202754.1583747778621840789.fujita.tomonori@gmail.com>
To: dakr@kernel.org
Cc: aliceryhl@google.com, fujita.tomonori@gmail.com,
 daniel.almeida@collabora.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, frederic@kernel.org,
 gary@garyguo.net, jstultz@google.com, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 sboyd@kernel.org, tglx@linutronix.de, tmgross@umich.edu
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_count_atomic function
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <a5cca6ca-9147-4531-81d8-05af1333848b@kernel.org>
References: <DDO06754OMN5.G0AN9OCWTFLW@kernel.org>
	<aPeTFMeVoIuo8Lur@google.com>
	<a5cca6ca-9147-4531-81d8-05af1333848b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 18:02:39 +0200
Danilo Krummrich <dakr@kernel.org> wrote:

> On 10/21/25 4:05 PM, Alice Ryhl wrote:
>> On Tue, Oct 21, 2025 at 02:35:34PM +0200, Danilo Krummrich wrote:
>>> Please replace the match statement with map().
>>>
>>> 	read_poll_count_atomic(
>>> 	    ...
>>> 	)
>>> 	.map(|_| ())
>>>
>> 
>> IMO, this should instead be:
>> 
>> 	read_poll_count_atomic(
>> 	    ...
>> 	)?
>> 	Ok(())
> 
> I think map() has the advantage that it is a bit more explicit about the fact
> that the return value is discarded intentionally.
> 
> But I'm fine with either version.

Then I'll go with 'Ok'.

I'll send to a different patch to update read_poll_wait's example for
the same change.

