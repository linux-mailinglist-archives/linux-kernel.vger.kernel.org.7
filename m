Return-Path: <linux-kernel+bounces-757200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE47AB1BF02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8A8188A660
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D345B1CAA79;
	Wed,  6 Aug 2025 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6j3aFpQ"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88A3595C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 03:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754449482; cv=none; b=EMveqBFg19hr5RIhaodXU6q5ePN/HvAre8bT4Hi04S7ctBzVXRFKsQNLtLgEMTXyFSIzxzYZG0Z+UVYQGGXgrWWS0curgeoB1ThN1ohlmLM9VzkUvNXEajpPJ2nIqtiDCWFQCKgPpAGpNm70Vrr/mh9JucOQoFf2aj2UOc4nIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754449482; c=relaxed/simple;
	bh=hZGypJa+0gC0Pd2rNeu26LZsUEfunosrIkjMfNWiLZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biLbS+jQN+qMT7ugqB4mLNdmrSF8N9UIOU8j8eKtCNw5XPQEDeHO8/hZ4P+Zkaudh0dxkooiC9ZWYz0t/ACxLL4jZHOX79roe9ghNMRsZ4UKBhByB5p4p+XOSyl3udiKNH9nS+/O8uZW7fDtkAFpZkI7IP5KY/JsVPXu/ZTbiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j6j3aFpQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3220c39cffso4947190a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754449480; x=1755054280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTFIJh5IdYRfmXRrV/kBcUsFP1nFJtd9YZ0qDXPL8CU=;
        b=j6j3aFpQLDhSd2h0qJgA3WMFO0FU1u6CGBDWKQIVY6atMGZiAlNe87E9e+oQYEkiCT
         kpj+9ctNp0QgiqtlS03HSKL2wBCfaoNpEIHDCYfUGsxox4plIKjvC2rAWAIGgYHRaOw5
         jv57skvhWvwmQeteys2hO1owIIBbuiHDZxdZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754449480; x=1755054280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTFIJh5IdYRfmXRrV/kBcUsFP1nFJtd9YZ0qDXPL8CU=;
        b=arZZHRjAs5Z2GXzCz/OlsAbJoEoj6wzYc1mXQaZGWFs6fwDKN7J+fXCDlWH/fFSW0Q
         w+iETcAZJFxYi9Lfw/Fn9mdsRRqQYQedf+FHDEoPDD775sQ/0JnhkCWYbU6e7EVZWwtG
         hAWd7vxBQl6+DD+4IcZVOFht7KAyW7aU0L0lfNk6KaFpaFVJcgL7L6rCeU++rTA52tN8
         Mpt6vm60NpXwR34ceB+llhhWiF0byJx9TKAuO/myQV0t6M/g+Y9QSFGyCvECN0BPfW0/
         D+3f25ODmk2TLamVoPdWkzNn5TrXH0fz6v7YM62arHk8LLRnE67pFKHH2mkHuA2JAuj1
         P9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXem0RGh5ngIEATyatOHvQH/obl8QMEo2kGPWkMeeUJvIalSR6bobcnA61EB/ZEwLvK9hTMPYr4xf5ez/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6n7w3U5DwUJAddzo5aN3q1KItJ/ynOs7rib/VG0OW3kOHsK1
	CDIvGkEbMkpbohCSxoP3qoxqgDgV+IyxA5et8DzPpLTt2En0HVfXkOkXPq9w8zvYO3T6i9lJZaU
	n6fg=
X-Gm-Gg: ASbGncv26bPWGoMSjfUm5Q+P1wjDRzzviW0VW0bxpY/xsQwyU+GhMPQbVh7jUS0+O6R
	1qRA++s3UA/YWQGvKHr+k4raZhPAC4WY7DX91npXXKNXUWpfsA7UHX1om+unxLppP7pse+c0qGr
	sRgD/DxDR2PNY1+zkt8qjNiB4DC1bVRc5Uj2sLMSXp2vgErWGXykZdpEOqj2N/nbZ167PxYJ9RP
	aockRFvBnmm2LQr8vCGF7s91eYbw3VfPur/Yf72YTHAFHQGgODGWVYKO2OVH3/Oh41M5OmisNpu
	NAs0TTQbYiMqPAvyrKKJoT9vyef+fzhoxi1lEMdeursYyEOcnZz8EpV1152P1mSkWXrAmcnRUOY
	w2BT/l7UXgtb85dWJVROAUrc=
X-Google-Smtp-Source: AGHT+IF1L7Q+LwjpClF7GXDoVkELUC8g+IiurmJj34+qJEJNN9hK8LfT1l4Yu4vqTUn7fr+mkOUoOg==
X-Received: by 2002:a17:903:1a6b:b0:240:8cda:9ca1 with SMTP id d9443c01a7336-242a0bc8284mr14055655ad.50.1754449480245;
        Tue, 05 Aug 2025 20:04:40 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aab0b3sm145806125ad.161.2025.08.05.20.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 20:04:39 -0700 (PDT)
Date: Wed, 6 Aug 2025 12:04:35 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Seyediman Seyedarab <imandevel@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, minchan@kernel.org, 
	axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	syzbot+1a281a451fd8c0945d07@syzkaller.appspotmail.com
Subject: Re: [PATCH] zram: fix NULL pointer dereference in
 zcomp_available_show()
Message-ID: <5ydfoytbfcvgkxxvc4s6e7rjqzldldjanq3jgwlonm3pczpysh@gtf3u6hibkri>
References: <20250803062519.35712-1-ImanDevel@gmail.com>
 <d7gutildolj5jtx53l2tfkymxdctga3adabgn2cfqu3makx4le@3lfmk67haipn>
 <6hs2ou3giemh2j7lvaldr7akpmrwt56gdh3gjs7i5ouexljggp@2fpes7wzdu6l>
 <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edvzxvoparhuqppuic5amgz5smfar54zmli73nhyojnj63nom4@kmqnjdl2af7u>

On (25/08/05 10:43), Seyediman Seyedarab wrote:
> The NULL dereference (which syzbot reported) has a much tighter race 
> window: it requires catching the brief moment during zram_reset_device() 
> where comp_algs[prio] is NULL between zram_destroy_comps() and 
> comp_algorithm_set(). This 'can' be triggered by racing concurrent:
> - writes to /sys/block/zram0/reset 
> - reads from /sys/block/zram0/comp_algorithm
> The window is only a few instructions wide under write lock, so it is 
> significantly harder to reproduce than the use-after-free.

I honestly don't understand how this is possible.  comp_algorithm_set()
calls are done under writer ->init_lock, which is mutual exclusive:
neither concurrent writes no concurrent reads can occur in the meantime.

