Return-Path: <linux-kernel+bounces-867478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21EC02BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F601A68BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8B834B198;
	Thu, 23 Oct 2025 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfL31aoo"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921334A768
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240903; cv=none; b=Ex6xessqptDJRzH06RMLoh5kZVaDwOxgFig/Dawjptiwhips9oUFFlNKmrgNkMxZWbqfBw+dkqeX2gR1agADiw/LiFsT1m3wvL+9LLH10mmaCWgt9ebV9dVU9U++h5y/OCiqR0HoDS3/2S9ApGSWbPXNISot6a1FVoP6/YTtsSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240903; c=relaxed/simple;
	bh=VwKC0UFE/hSiQYJTMaM4Bls4thTgZXjxzl37/zt9MmM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U1Y3GQf1QGAkF3FkN/v0K+K55viJwWm8vh2m0CvNgaTDRhJcNBuHGp+3k18XlkMP40199me1eRDTmaMD0HHzfdQR+gW4yKWUdqXgBIHX+Km2KGoYJxL6F5m8gGnKAsNLGr34vTrMmlZLJ8FNm1JAU1e9QcHndIdxMxZbOjAD70g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfL31aoo; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-931028aeaf9so808640241.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761240900; x=1761845700; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VwKC0UFE/hSiQYJTMaM4Bls4thTgZXjxzl37/zt9MmM=;
        b=lfL31aooYLkhPM8rRv7PFfB8QfjFZHsL+4jP0c516Te4du34QT2onFr6ZTN8LU/m7x
         b0YSTubUvbbCUPgIMYgapoIKiS9562MM6d0g6K5fU/BMCLmsW1oR6mQ7WEgb5iHaAitm
         SjaiWhKa/GqNoJGzNRHPkPNbsfTBLwxQcSJCcZx3ZR2iRkYZY88HZJ6gav3yGzQlfTr9
         QpSXzfpbv+mLVHtm9xp5TBxrM8C58GEPfjKE23QGVEBd7OQBNujHpzNqv7J+KVJMvwNy
         papknXKOBu0of51J8Wgmt1xPQAtdducEXaONk7ngeSyyfJgnVHTo0zIxJjuyX6ilthoP
         I9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761240900; x=1761845700;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VwKC0UFE/hSiQYJTMaM4Bls4thTgZXjxzl37/zt9MmM=;
        b=ZxiflbHU8Y9FI8I7MmTQZweMx242Do6etZhVqNLh0WbVnYjOD2aIUZjtUhwTjXc5Dr
         3VJ3DLREUK+toJ0+p2wc2hCywLIZW+gEX5XxlCyZ0r28Epa1Y1nMuXV/ZY/mKHHuYm3U
         ydX6tGkfEsZ/SgNEtqvjTqV2yvXZB1sJPeISNQsdnWIJPusk5m3e2ATG0jBJdSRz9qWi
         2L5HcFLl4YaSl+sxXxs5eyOWNCGGNlyk8vJTAyoayKKXBT9JL3ytE8x0dR7f6ITtD3E+
         oF0UMetlc3lYOJEx0O3JUCPjxAzqO+u39X/6d5go/62unGZ42963MvxDZeNc6f6P5/k7
         Bf/g==
X-Gm-Message-State: AOJu0YzNwQB3MV327H9j3sRPdlGu+Zx0EbUI6upfsSx40OycnY2cbBhS
	uBjmrKez5OjEBY0rcgMloOfNfYB0OHS6gSU5uke6Nd1MKajSLPq2qNwRR82IK5o8waMXQElxby3
	r3PChWQrQC5b1ehClZvrC/8pnANXHwAGJJw==
X-Gm-Gg: ASbGncsWWS7WQLqm12vkFfdCG7nzizJrmFWM6YfZNOgG8DpmU5arsGuyRdBufvomKZh
	2bkeBzmqClYgp2u96+5XQmRwQYFBiF0fCgJyIjUPGQj4LC23RE+oK1FIQ5NqRPOa1iCBJyoFhoh
	lC7B3WhyH44CcVm1IRbBBHqW2qnVwgimLiQX5I3arZOwH34rGawT7hfxcGCvrpFPeBaqjvFxVQa
	EbhsvMFnvd/VhBSVNety6kgS+btZySiBZUv8nxMposIl9aI3FgIQ8P6VZ9wzo7SASobaYl9Y8tB
	cMLbvf3OQ+7wLL5lH1o=
X-Google-Smtp-Source: AGHT+IF+d5fbVzaP8EF5FIYMDPR624oynMu4ZHl0yN7Hc3MdwvZG1GFKv+nWj7V565N3S4f0I/mdGgJxZvgy/Vqo28o=
X-Received: by 2002:a05:6102:3706:b0:5db:239a:9ea with SMTP id
 ada2fe7eead31-5db239a0afcmr2544942137.16.1761240900293; Thu, 23 Oct 2025
 10:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Micah Robert <micah.mypackagingpro@gmail.com>
Date: Thu, 23 Oct 2025 10:34:48 -0700
X-Gm-Features: AWmQ_bnm4PfU5CY3j7XvL2QN7ms7aaDTFY7dpTH6FXz6HPSHkorgTuRze2SIVGQ
Message-ID: <CAHb_yAFH_9cF-BNXEv5-cGL8ex05V=QEKbU-9zth6PBVLpqJbA@mail.gmail.com>
Subject: Custom Packaging Boxes and Labels
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

We provide custom packaging boxes and labels. We make boxes in
different materials and styles such as Vape Boxe, Cigarette Boxes,
Cartridge Boxes, Cardboard boxes, Rigid Boxes and Mailer boxes, etc.

Our benefits include quick turnaround time, free shipping and design
support. Just send over your box or label specifications and quantity
so I can give you an estimate on that.

Let me know if you have any questions. Thanks


Best Regards
Micah Robert
My Packaging Pro

