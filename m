Return-Path: <linux-kernel+bounces-870162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45CC0A13C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 02:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3B63A7DCB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 00:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA12AD11;
	Sun, 26 Oct 2025 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FrHoRY/3"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E714A91
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761437420; cv=none; b=qHQX2Az9cFMxr673/hJafzjCV3zn1Qc206YqzvzXtV2CBvjQ8Y8VML6/OJQwQPE7zYZvbOndipBV04Uv4dZq9TSFKL58dD6+rmZvBJuZKGQhpd7JEhos/D7qneo7DhZUn7X7VE8WrMUu5/Z/NL2biy4iiM8eCjS14xdQgOCo/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761437420; c=relaxed/simple;
	bh=3L2Cn0VQ9BSiyQpq+zxAO3fbOHbU9xIDiRXeuCnK2Vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSdIqUSYrgWp74xrhSFzUu1Y6jreBaoN+0zYk/NJLzajrpE2/MaEoncSmn3rpWXUUaeqm4oWzCFBW1conb87TLOUpzhxcRkr93a/C1D4hD7ZescJpNlwLDP0jTFxSMBafUVKRCyqrSJ5YjJAfjWiMmRKZmxb8mElTEan6rqK8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FrHoRY/3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b6d402422c2so795348666b.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761437416; x=1762042216; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KHT88HQYbjysn9AJ2rZNaLUIGndxQt+sWOeqUNyjpSk=;
        b=FrHoRY/3AkT/G2dohthlXNuEQ59OF5V8L+r6rBlAAcOG+fwjOoCXftf5a09nhcezWY
         E3VT/nmOm5FOd5+HDrRULhxACce4zfIREFI49dTSxY8OHtnkSVjXUaw2L0f2KY4A6PZo
         aFIpJPABqrH0hZ/bjdIS4rADBSGtlnALhvmNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761437416; x=1762042216;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHT88HQYbjysn9AJ2rZNaLUIGndxQt+sWOeqUNyjpSk=;
        b=QCRIuGfJsejNnThd3rlNggNVF1u0W1CCPlXZhC/NKSpec6kCJb5P+9YnlMYmqF+W6N
         4/XsiwbvCcKM+Qau7WQDdiZHIuhfkBixiP7A+rACy7jKTjJTw/77fUkKNLx2jNCC+LBg
         A8UITkNUlmCVmmGKcktlu9i3eY8EDUzi4EZno0Yt+uCkVORESDGiSoOVTvrDs6RGFRlR
         JqDMYAVlKhY8E2opsKbV1Ql/7rECFHMznRQBqEPkpl/IU/B0xgIE6J6uiCgctSdRzUaJ
         wf+NYCY7V5xue0WK+yVpm0nvYg9T2ibGsK4Xmwzn4az2c/QD62givKxpT/2wKkz+EWrj
         LANQ==
X-Gm-Message-State: AOJu0YwTxGtj0zn2g0pRQlDzPQMo5YHR9ThbVFxsfBo+8L4yNLX/79W+
	4kA/yyi30Xpc5uxQZZg7jWHmuxb9ulhrUWM6xLTTuzOpn+rfpC4p/cPyq1K3sPRHrkXD2LU33vl
	Zw0L9Bb4=
X-Gm-Gg: ASbGnctWmnwueANCtimhs9ymnGv5AdttaIbTzxcB98PheHJrc3tuonuhYgK6e9qnXOw
	YUt4ib17HYvvBbHBpYVRUwcKJBRuhnhzWztvuskdIXHw1ZzzmZVGWuD34rpsR36kKXe2UyahsjO
	R64sGfEnzMe0eMOmfPpYe52nYBos3vdaKnR+yznJ6w84P6f7wFAHB71zV88Q/HehH15oz0h3KqT
	QJuDgkk4dk/cB6qal+bS9TZfC4YHGUMcwgVX60Kudcq+57fIPG2Q8mv9KtxbFt2zQdZHAb+SsNS
	WJX5HO5q+Eswe3Ymr8Pp1UEBoirIrgOdy7k+Qu8qxEe41qE0k53gl6oUwx+wsRh6qiSORUG4Oal
	fEb4NGol4GBydTnsGSn03BjSR5nW+PaU95uf8DMvpIKX8rn9HwPDXPNwLs9fwkw9YkmkG1H77RL
	rvw0L+pKTzHm50eguxSd05zqgwYU/WIF38VENRpnJVdY/F6OZxh7bdbRIGOVbx
X-Google-Smtp-Source: AGHT+IFgdfz/SsdPhkjiEpAeFGQlkdLlYHnWbgjzyCpHao3X5vMBmSTPqUGAM7VcIB9Gp8F0E6nxpg==
X-Received: by 2002:a17:907:1c0f:b0:b6d:6ab3:5d02 with SMTP id a640c23a62f3a-b6d6ab3656bmr811361566b.64.1761437416561;
        Sat, 25 Oct 2025 17:10:16 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85309074sm323542266b.2.2025.10.25.17.10.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 17:10:15 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so5239810a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:10:15 -0700 (PDT)
X-Received: by 2002:a05:6402:a188:b0:626:8e29:8d42 with SMTP id
 4fb4d7f45d1cf-63c1f6d9471mr20649012a12.37.1761437415485; Sat, 25 Oct 2025
 17:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025211519.1616439-1-jim.cromie@gmail.com> <20251025211519.1616439-4-jim.cromie@gmail.com>
In-Reply-To: <20251025211519.1616439-4-jim.cromie@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 Oct 2025 17:09:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwpTUr8keTinnPU8kTN9dpYgDtwM4wONRF_j=1gvo3MQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkB-wuhFoSsfx1tBl8BEy4xJ2x_b512DolaOIzwuqOsKKnndLl-pSrsTks
Message-ID: <CAHk-=wiwpTUr8keTinnPU8kTN9dpYgDtwM4wONRF_j=1gvo3MQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] compiler.h: add __chkp_no_side_effects() empty
 hint/assertion macro
To: Jim Cromie <jim.cromie@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@linuxfoundation.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Oct 2025 at 14:15, Jim Cromie <jim.cromie@gmail.com> wrote:
>
> Allow an author to suppress these warnings on _var by adding
> '__chkp_no_side_effects(_var)' to the body of macros which trigger
> that warning.  This may reduce blowouts in CI pipelines.

How about just not doing that checkpatch thing at all if it causes problems?

Seriously, I think checkpatch often causes more problems than it
fixes. If it then causes us to write even uglier macros - and it's not
like our macros are pretty in general - it really is just causing
pain.

I think we should cut down checkpatch to things that are obvious and
real issues. Not things that then cause people to make code worse.

                 Linus

