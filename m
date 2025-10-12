Return-Path: <linux-kernel+bounces-849489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D212BD0406
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 16:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE3C7347F22
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 14:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD7288C95;
	Sun, 12 Oct 2025 14:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1s89k26"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC350288500
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 14:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760279531; cv=none; b=iEfG8Sr0FUuFoPLrbWjun+YZ4v2c/lVks25lQW1XtC4oCR/dMSToGaUzBd7+YL4NcyaaZK6gFJrB99W2YbVT2agBaSy1c9py+Q1urUwwrL5veIZQMXTk629Jn5M/xYhD7OQropH7xY81Mgx6IA3GigXbLBgEAlecdVlWIV+BFUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760279531; c=relaxed/simple;
	bh=exVDaTCv2o9KGqW9+Cgff31C7B8DfZakECaMCpf1bfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvR3UxkPFjkwnV6UGJNhMRkUAtZyoRYMIP5HQl5ShRodm0KyOrmMciKHkZ2Rja+0B1Anw+ttyTl0q4nMe1JZaNBIZkzPSpcY7hyESvKNrfTIlw5YgswItiY8zu/M2XFUMmu4kC9gqGWoCeH2tAno+5NHhN7TQ60iGw/2odAxJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1s89k26; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-795773ac2a2so39310976d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760279528; x=1760884328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lafAVcrEHvdofnatEPGKT/Xtct7Xl7DSjL6fT41f0Sw=;
        b=K1s89k26nbYzSwwGw7yMYiYrRjewHFeqMCWTkxii0Kk1TGe8AJjnPIhBf9DswDh9AP
         Pc8PZkqx8PU/oLLaaseQlS2cn+adpK50u3OR+RUldZVfZbHOgIHTkf2j22hZCKR1/bY8
         K+WzATCb/aJGKL21QkWActjsYo1QICYWvUqnwm7Y23ReLGJMDnVIHhQ2nCvoLuAZDF4k
         MFpNBR0+2pc6q0LW7u3kXC9ZmsMz65gusX7+PngKjBo7pwiyG8Q3ip7uRmtL6kKVKXvC
         P35XoF+hOLRCfEMQFis3zy8k4eGD4BO0dwAafZG96RutusvGhhC7+CY8MhB04M5dSkS+
         lJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760279528; x=1760884328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lafAVcrEHvdofnatEPGKT/Xtct7Xl7DSjL6fT41f0Sw=;
        b=NCA9jCTgCQjGWxHDZ9VyiL4pSMKkkZD9DFaZAJsJobWo1I5QSUiLOh6LSuoe5F/o+i
         LjzTGyLp4loVvs4NJ1NXFOtH8i2LukG+H8K86JGvv8yTUwHpR8FkMXzKrFuerYNdmSIU
         /FY0gCWjzVH9ItQ8NZHIAQNN6bFYkfVkRyvL6jicybvCW1LERPKMQuVELIiu6UTGWFEj
         S+JRWexHx690gIUFUx4QdKi5xjPzcRmJqWmFiY1/S/nmi+KE3pKd/hLyoryzmyL2LrJY
         3YFYA5CqMukuh7WLcW/sZ+z3+jStr6EBCf5d22w0svMSQm1gSUijRW0wwKiqGDlIMlrO
         32DQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7OtT8gHtj4OGgsQRva3ojlnV/+v/3lazqgToQcViD4cKjE5krYutSwuVpj/ASEG5dKiEHGWUYzpx7/0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF45o6k+wKfqjlpXMqO6hm505rGxvo/8xn9kPZeTeXvprH5RQO
	Stuq38U1yfAYk1LTMzGOqWaCf/G+6CA9dGrSCDgJANRWCJ+TDbazbEO2
X-Gm-Gg: ASbGncskKjyBX73ibUczMau9VGJB5iwAMWXZ49rbDUUGPLuyQWIfVI8l/wO3n61WV57
	GjPIbssG2N9RT43+bFGlQ13c5eMXf+9bpnzkRDIKihJQjNhOHsSdC6AAFPIfh01ZJy2qJF8GaKf
	4JNiRCkjzUoN2/oXELvq8WSQEk4++fjyoojvdealXDPf7Ai4NXjd7ItZXQrN5GVwg4jZEGN+V8h
	F5CEHkf4bV1HhZ44xbvffTIyTPn4QVh7qboETphlhtFERVQBF0sfPlr0/f3NQckdoH5A71uZtmi
	ClOmFvADwV4T6UTREXGDCAvtDE5jP/dn50aDdV5IUERKad6FyR5NirYiiPa/6POWIJgWCtZls7h
	GK0pElIGm156tz+ADkRjH4LTvSf/pHSpzV+/RuP41RVxWakMLvqtL
X-Google-Smtp-Source: AGHT+IGylxeC57G3HP7/1vZXTCP0woc3CF/bb9piQD8YyNw88k6+Ampz6Ayo2XWXeOakyOz8ZMmEgA==
X-Received: by 2002:a05:622a:30f:b0:4e7:222e:6725 with SMTP id d75a77b69052e-4e7222e7357mr20155591cf.8.1760279527640;
        Sun, 12 Oct 2025 07:32:07 -0700 (PDT)
Received: from gmail.com ([2600:4041:4491:2000:f887:3bb2:9bc6:cbb0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87bc35930f3sm54042686d6.43.2025.10.12.07.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 07:32:07 -0700 (PDT)
Date: Sun, 12 Oct 2025 23:32:05 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
	hca@linux.ibm.com, corbet@lwn.net,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: fprobe: require explicit [GROUP/]EVENT
 for list/wildcard
Message-ID: <aOu75evMUGF8pBxE@gmail.com>
References: <20251004235001.133111-1-seokwoo.chung130@gmail.com>
 <20251004235001.133111-3-seokwoo.chung130@gmail.com>
 <20251008095316.cf24f13a84a454ddbf530120@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008095316.cf24f13a84a454ddbf530120@kernel.org>

On Wed, Oct 08, 2025 at 09:53:16AM +0900, Masami Hiramatsu wrote:
> This should be a part of [3/5], because when bisecting, the test will check the
> README file and check the feature.
> 
> Thank you,
> 

Ok. I will fold the readme_msg change in [3/5] (the patch that
introduces :entry|:exit and keeps %return for single-symbol input) so
the tracefs README matches the feature during bisection and for tests.

> On Sun,  5 Oct 2025 08:46:56 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> > ---
> >  kernel/trace/trace.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index b3c94fbaf002..ac0d3acc337e 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5524,7 +5524,8 @@ static const char readme_msg[] =
> >  	"\t           r[maxactive][:[<group>/][<event>]] <place> [<args>]\n"
> >  #endif
> >  #ifdef CONFIG_FPROBE_EVENTS
> > -	"\t           f[:[<group>/][<event>]] <func-name>[%return] [<args>]\n"
> > +	"\t           f[:[<group>/][<event>]] <func-name>[:entry|:exit] [<args>]\n"
> > +	"\t                (single symbols still accept %return)\n"
> >  	"\t           t[:[<group>/][<event>]] <tracepoint> [<args>]\n"
> >  #endif
> >  #ifdef CONFIG_HIST_TRIGGERS
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

