Return-Path: <linux-kernel+bounces-725459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D20AFFF62
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55A9189D293
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0A12D9787;
	Thu, 10 Jul 2025 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXvyHr2X"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F772D8DDC
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143712; cv=none; b=JdgbNwjmNaTpoq3mGTTxDVtkkZbjKyXG1AFBxICe0yl2PntxhuWKoJj2AcSE+QVLsCtvETFgpQ74VMr5PhopPamp90u4rHbbLyeUlx8F8AAmtpX56Lxg0iN4XcUiwoMOdKtvT1QZy+xBlMSNfgwFNRjKVNcb5pDktSsksLT67bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143712; c=relaxed/simple;
	bh=99oEEEUiByTxkKHr/ilwxlCtWKKclOV3G1D2WgNGtFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFagwg2hBe5gY4XitkjMPZuWuc3wPpMDqjwiyJr64AsvuoIMKkQUmPqf6LHAymjgqcq+ejF4bLP5crbvxIJ4B0uT2fGxpG5rC6ScbR4oKAMOU8KvMXSC2fjL/7v1tjPvHEhkJ6/Og4ZRJ6rLSgjAcZOBunxL47v1QhTW1mzcx9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXvyHr2X; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45363645a8eso5756255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752143708; x=1752748508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O46lRCRwlN7ZP6YoYpqRSRhCIO6qyk+cDV2qL9WjBMs=;
        b=mXvyHr2XHIRJ0Hfugule2kNJJqWpLN4ZRvLW6LO2RLIGbm1QrzxuklC5bR6Tkj+kfJ
         rBEsq5wzRJndiAc41uVHIN/uzZOySr7pNieKFi1K5E23PaCuD8Aichs/ffttwnti4CL1
         1ak0R15MiiuedmYSP42jc1jz39vyn3Cjfgiuma9RoSoT4Pz2YBgnBZTN5Zr3qvDrYTD6
         iOiD/jlIFy/azIxSc933mcNhmWONkNAWs2P68b8a72q9y91aFWB1VbLHeDTGWjhn859L
         xR3lj59kU5FXTpMBq3rcsHRdM8wJOUT6QvO6v4tmsNP0WdFhtxxP/n5E60S4Bl5Hru5F
         6VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752143708; x=1752748508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O46lRCRwlN7ZP6YoYpqRSRhCIO6qyk+cDV2qL9WjBMs=;
        b=BdPdQuZw/JdPSvPz8+BHOYfnkynPe5kLbI2uigQaJmZZKTY7buLDDA4UA1XqGXs0Vl
         DnRxuzvTYydeCLAmBqSlSFJMtLtV47GQFEnCslenphKQv0tGvNbmqQnN6fTdQTx4L1yR
         9wmAhExmX8Ok9dXKvj+JzWiWKRwNuIl4UYBPpvb+S4Muq0XzhhT7EP8Ac2DeHctFQPWa
         c7WwfYj0Zq77juqOOV+5Qu33rymSx0OgO83ia0t3TLqhJjaon8ZzIPMhVQGwQUgpcAQQ
         NuQsGOT/eYOKy6dyW+47wpaS4gIMuFgW9hioBrGDsGzTXwK3HKbHuv/HhT+IBD23xeMy
         Ubqg==
X-Forwarded-Encrypted: i=1; AJvYcCWFtkBD+1qR+Rz+5r9BieTErDmI7eYLTPkN83/mqk3m1q/Kgt5FxFzff6A9Zcyi9X3iy2/LhvDwN1NPz6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmbbUlh+cTq9cQkZHopUwEr+cHvn4eWp7910rXUn3pir22aS/n
	PbUnx0VRyiM8PC8mrERbSlNd+CouJZP4AcYy+5eOJ2XRLZPPhnlgnk0GPpXOxw==
X-Gm-Gg: ASbGncvb1XN3xKdjqxeSES7sCsoeOSfW3jLwOeGuZmOzG0o5k2qWkyuc+70Kz91v1gq
	UfXStHuQFvktimm5t16bb8pOg5/Tr54Czmo+bcVVZuR2VELW0FA/PPCZFZs0cCDFv5V6N0QYkrK
	0IPqtJtbSq13YyNipVOqGpZb0Q7PFkx84eVbfOrd58vdBsHHBUV7bvABmaepjnOnYZznzFAXQVz
	ePEGBD0w8uzaZxXyfPw1D5wnvS2c3XGGGzrDe0knqhfz1QrvZq5QHjPxaZI5Z117MVPYqkTUgkS
	zWr4feJboN3Y6qcxoW/in+71uah7Y6EBAy3hIbklRmWMP2MsqUnf9vvMmDmlTcAnxx/W0Lsb23J
	ZQl5pGr82IIg8gcMAcQ==
X-Google-Smtp-Source: AGHT+IE/zprybY+F6GVB4tq8ms+Q0pFXmh2ohFGabwhGtV0mwA0F0+05N+c2zxBI68lQT3/uBGHXGA==
X-Received: by 2002:a05:600c:4e55:b0:453:5d8d:d1b8 with SMTP id 5b1f17b1804b1-454db8909a8mr33192865e9.30.1752143708126;
        Thu, 10 Jul 2025 03:35:08 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e2747fsm1472931f8f.100.2025.07.10.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 03:35:07 -0700 (PDT)
Date: Thu, 10 Jul 2025 11:35:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, "Nicolas
 Pitre" <npitre@baylibre.com>, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [????] Re: [PATCH v3 next 09/10] lib: mul_u64_u64_div_u64()
 Optimise the divide code
Message-ID: <20250710113504.583a3721@pumpkin>
In-Reply-To: <08a4b591e9ee41ca8cec888772a0fc43@baidu.com>
References: <20250614095346.69130-1-david.laight.linux@gmail.com>
	<20250614095346.69130-10-david.laight.linux@gmail.com>
	<20250709152420.4c95c22d@pumpkin>
	<08a4b591e9ee41ca8cec888772a0fc43@baidu.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 09:39:51 +0000
"Li,Rongqing" <lirongqing@baidu.com> wrote:

...
> Nice work!
> 
> Is it necessary to add an exception test case, such as a case for division result overflowing 64bit?

Not if the code traps :-)

	David

