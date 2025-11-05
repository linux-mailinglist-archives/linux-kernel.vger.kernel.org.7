Return-Path: <linux-kernel+bounces-886993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DC0C37075
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B3BC4F5633
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BF730FC3A;
	Wed,  5 Nov 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr1rtBE9"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8778A345CD6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362015; cv=none; b=f/lKfZlOoiQ+ecdkbvlHRAJxP4nTm4BvXWmjclQKUQ+dD95/pWb4BSshr3RnuDA3/ZPfwt6xB2Bqw1Jx3t5m/Gc5tkoTdxKCI8CuS0BFn02Mhw8ghMjsBHPC6T0mDDLBz8FHGzHlmxmLcLnnUJPLOnvLtA4lWjZVx1jHsS1kCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362015; c=relaxed/simple;
	bh=+kifdkP8A5Tuku292hNpK6CevBddXvGkOnP5jbcKy7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2+KlPKV4VhXls+Tx7lLT4ms/H79Mu14or1ka1nCmgZ6sDX6AcTlp4DzIlxpisj5FpNk2ETxsHgXsX/gQ8WFq2WyuQkd4vTBHjs/q4yvf3vjusI7Nau9owyCbtdr1g9AjRO+YYPNpcC455DHv13Mgq8OEEAXeGAFYl3YcRp+owk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr1rtBE9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-341b2e98486so88675a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362013; x=1762966813; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=urzPxq2b6XzypLSFugnwGqKc6Fs79UyxIT3WxPTyVhs=;
        b=Tr1rtBE9YQVdcTmLZtFBh9scQ12Wj1IG3XQddXf9TysC98xtvRWRLZxIbE9+esSEzJ
         TArIfOWk9JYjAlpFMwxB+JNnqLyZcdckq4jaP7aAqVhzEaJRfkMXaiQS1N1GpGTWvZPk
         a0jL5XLGcmXT8PdhNnxVe57jylgExFO1mPdfTpHQUOwVJWy04RuojIjSofGVoB8yOQaU
         KHEsIa0cFK9ox+0GNLW+g925STmunTBw2tyO1iZgCUfFtEpqNA8aFqdObeaZNi83k74U
         Y6vFI/P1aUJ9CUCPnafgktpJJAkUlyw7UjIk1cQpwML40Jxba8T6OCGZirAXH4uY8rcB
         jUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362013; x=1762966813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urzPxq2b6XzypLSFugnwGqKc6Fs79UyxIT3WxPTyVhs=;
        b=bqrJPGgfLCidCtN3R+wv34vQsUdYYs8GPgydvuZq8vrra6lG7otdaKnQ814zn0H0kN
         5dyyHKoktGJA6lKUueQVWM/turlGaudaVWYBv6L43Oi2Xf0wEwVRHAbYBr3vgJJf1GtS
         UkDAFxhOGFLt5fVt3icBgnNGqC6/Sgr3l5NvsUE0x/esPbuhfk1i58kZJ0fEudXvmpsY
         6e0CwmsC8jdvTBClPM7HkGmaYoeehmopDdOhbuAYbqazhZA7WWQMFOEL1pkGOXE2kwpe
         Scag+OhbOGQLg+Uxv1Ro/wi5sO5iabiaFAwYM7Hx6TqxUE6dPwpDCZ/akUYTe5AEu7ZY
         ai3w==
X-Forwarded-Encrypted: i=1; AJvYcCXEMMYLk7Wn9mKU0LGTXLWYvjwGVJ0Oj96Dp9ftNwMhp08vHgc952rbixvprncEJ6l5Np2bNAyhJjt/HSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl9bE8/39EW0e5vALGHc8RXuy/82y61skv94kDcdg3U59Htigt
	VvNh1Mmld1KSO2dUojk/dEUzF/NcN745l1YIoVb2SIg2JIGWSYg3cR+HdfiIMNwb9WM=
X-Gm-Gg: ASbGncsfIBSNtjQgzxScRzypnQX9/CBTv+EX5mbqP+RfkM3sHlWgAojx6qitKf5+0Z/
	0lcTsH2Kuw9x+/qBXFGDAALPEywDaPsEl9Zo51HjA+Ns8gaNm60apR8m0IRj7XrfI5ldNhiOT2R
	uyMTUArd5RDt6/XzFmABzz+toNWeuGtQseXzKnM2XzJrX6M7EJpqd5g3IC4HRqNdiA5Ewx5yCMy
	k4tddiWj/x/nd5I14Ay8WhUYu0weWJ4ufBt9/kA0Lb9i3fGBOH/zluIMR03YZbNKq8GzGU6UlYA
	scqPXJnKh5RhS/fkfky/Po4UJ2HGdm83Lr2OtSPJ6jbG9+X5x6wMmC6Z3xLTUiq2/261b8n7cLx
	RTa1KvW6B2kTUhDUsRONHbxxLxdtR4XaxXhYnmn2GXeH3ej8Pyk23FQNdqSr2RG5DajvUGNPnj/
	0gVvdVONc=
X-Google-Smtp-Source: AGHT+IGq/qA8sTG1Cz3rIeuk6jzo/Kh/j8xDG2Rr8Oga1cJ4f53RHJ781Umu0O49/wVvaUMstpX1nQ==
X-Received: by 2002:a05:6a21:329b:b0:311:99:7524 with SMTP id adf61e73a8af0-34f84113993mr3816652637.18.1762362012506;
        Wed, 05 Nov 2025 09:00:12 -0800 (PST)
Received: from localhost ([2408:841b:d10:e194:3d51:2b79:c21a:cd80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd3247d08sm6796717b3a.14.2025.11.05.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:00:12 -0800 (PST)
Date: Thu, 6 Nov 2025 01:00:06 +0800
From: Encrow Thorne <jyc0019@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] reset: fix BIT macro reference
Message-ID: <20251105170006.GA487100@hailin-HP-Pavilion-Laptop-14-dv0xxx>
References: <20251105-rfc-reset-include-bits-v2-1-f27c57b75a90@gmail.com>
 <1ce72e929f8f6c691faaf548a05b0eab2b9b1630.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ce72e929f8f6c691faaf548a05b0eab2b9b1630.camel@pengutronix.de>

On Wed, Nov 05, 2025 at 04:51:33PM +0100, Philipp Zabel wrote:
> On Mi, 2025-11-05 at 23:40 +0800, Encrow Thorne wrote:
> > RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
> > include bits.h or bitops.h. This causes compilation errors when
>                  ^^^^^^^^^^^
> Troy suggested "or bitops.h" can be dropped.
> 
> > including reset.h standalone.
> > 
> > Include bits.h to make reset.h self-contained.
> > 
> > Suggested-by: Troy Mitchell <troy.mitchell@linux.dev>
> > Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
> > Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
> > ---
> > Changes in v2:
> > - EDITME: describe what is new in this series revision.
> > - EDITME: use bulletpoints and terse descriptions.
> 
> These should be replaced with a short description of the changes
> relative to v1.
> 
> 
Sorry for the oversight on my side regarding the “Changes in v2” placeholders.
Do you recommend I resend a corrected v2 now, or wait and include it in a v3?
Thanks for your guidance.

				-Encrow
> Otherwise,
> 
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> regards
> Philipp

