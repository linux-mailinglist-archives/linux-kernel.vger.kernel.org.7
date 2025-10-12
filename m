Return-Path: <linux-kernel+bounces-849379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DB3BCFF7C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 07:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE5204E1655
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 05:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DEA1EFF8D;
	Sun, 12 Oct 2025 05:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9X4K/Is"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D9A13D638
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 05:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760247101; cv=none; b=hxDKJa/btYdE9AsAUrBJZdFvVNZcqo8iXJvDsHRLI8qiohbAwPNGu+h5OCuEk9+nybZ2/53qwji5dmp80nMuXiVMuqKdPNSr6t3tdpjAASTOuLq4fv9oVwNZLgcqeXVRGYjeFacjJ2c28TMhr9LNPl+2zxMjdsCA5YZ6mP4J8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760247101; c=relaxed/simple;
	bh=nCLq+DEhLRJEZWZMV+X3bkQFsa5jy4fUB1Ka/mPQCGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJbcEheRvIetOxJiohJCcercfbycgX1R5plfkd/SE4y4C8d4k+qTYSd4X8zV/wKzrqBYIAlHrIBcQM8Ugp46WqZAxKppg3+gukoEQjh1S5lc6gZ6X8+UKb5AFOc8/Plxa7NA5EmaPVemjEPI4XGinW+ypOi+LGxBdIyzweMnL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9X4K/Is; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32ecc50f573so716589a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 22:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760247099; x=1760851899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V315Oz2UwZma7KgfzSEN+KehYy049Dd9a5YOBN+/BjE=;
        b=N9X4K/IsmO8u3o/D9ulIXP1nUD9bGiyvJHkE8Q6ccAipWNKcAQrO1Nuh/FsOiFi7TS
         FZLiYAk7rqnPlscwcp/Xjf1WpKqkmW7jyg9hv26GpRI0d1sp4oqIhAuBzbpcNl/8EXzU
         Wt+vXlPMCpimlORYx9WbZkPu6XIoDhyS6Zb/+hICvrwnvmPI4fmvIPd+o9kr94iOMQ96
         LSTUkJ+2U3VjqoJHX+9BzbFMDBaRXUO+ro4IqL6viX7DFsh2z00UXcjCLXPhZjzV2lDd
         4PGcIboN/nHdxcuJX1qeBE07YKPbOjAYGmX6aRS8s1zYdp5+X7G79J5/pcyu4Qi2BjfE
         tmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760247099; x=1760851899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V315Oz2UwZma7KgfzSEN+KehYy049Dd9a5YOBN+/BjE=;
        b=mxdaJt77hGCMZOvheaLwWh1boglzW2YF5JG81btkBesrdAkQSGUddqaajgGvtF1YkE
         bejaqeJZ6V5nS/29fs8aFXR4BVZ/BkPuocYIBj7SHRzp6YTeCiSw+lcEbLlNYAC9uhId
         gKjJXMg3N3NTooWvFJ9Smgj24DYHfW3GKRSCCJ6FYxwPypWBQTzLXLX9R/45Z0ttYTyz
         pRSoHt+RGMcj+18Aiq0sppVXdqaLqsAiOfGffJODkEhlY6RtqDiiArHiG/TgrsuEIZov
         E+p5Vm45v9DW7ErIreuoNpXKEmogWmpmoBmtI/FZparObXqxIVAvTgVUfqITrLXwhZV4
         PC6g==
X-Forwarded-Encrypted: i=1; AJvYcCXrSLwU+3BK897F9sCHEa0r+Vl9zzq7kCaO+JFvqxT1fV7aH477k96DEVl940ea+5xky04pi5Ust4ZPi68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/XF9Ikex/eWf+COSXXUpa1Q3dDoy4KG+8aeHwM9sp7HFXkaHN
	XJ+SnHqhl5DFi/8PhUOTB5Q7oz5WXafNoK60iqlpdX2X0N2uXn4J9Hp/
X-Gm-Gg: ASbGncsogjee/aA0rc7V57qjVRcPTCnI99lyT3Pysv5vhbnQpKBNKqVrpFhpXfLlFR+
	V6anSjDfUzPHvngMCvxiqDbBEvsmecUt7REiEXVcFPI7LdPnT3sb7ukrUYryJEEADDzcXk5Wwas
	Lyf70hgoJAGem/uXgpNWxxVLOVEgG20Zx040NzpGZf1QhjxY/olkEbt38dRLE0h9DQWX8e9P+hF
	gw9VpUEY62wdBIFqSsIhCj020jd16MEWIta3P6ap6Exb7N2LkhDJApzIm8LlLbdwD0iLbQvThOk
	OFzp4qI/taT370b/nsld31B+TP43ktsb5pbXJrLSI25woqOVv88O9iddg6uqvbdOq5tYt+N4eVe
	qIKvPJQv+K6qc3dY5IhKFW5eHTCV4CxQMaLPznAKTHbyNZhMuVEk=
X-Google-Smtp-Source: AGHT+IGdgMMmNCve6hIXzVGxikslohoV+pMEGgcopaw46XiTYHSuaq6+3cVVsGeG9CQvShDrq4immg==
X-Received: by 2002:a17:90b:1b42:b0:32e:64ca:e849 with SMTP id 98e67ed59e1d1-33b513990d5mr12118698a91.8.1760247098812;
        Sat, 11 Oct 2025 22:31:38 -0700 (PDT)
Received: from elitemini ([2400:4050:d860:9700:ff1c:3f53:c7ab:f611])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61b12756sm8028789a91.25.2025.10.11.22.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 22:31:38 -0700 (PDT)
Date: Sun, 12 Oct 2025 14:31:34 +0900
From: Masaharu Noguchi <nogunix@gmail.com>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: chao@kernel.org, corbet@lwn.net, jaegeuk@kernel.org,
	linux-doc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: f2fs: wrap tables in literal code blocks
 to fix LaTeX build
Message-ID: <aOs9NiaXVrcO83dz@elitemini>
References: <20251011172415.114599-1-nogunix@gmail.com>
 <12aa7858-b05b-415f-a76b-c18848a9a784@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12aa7858-b05b-415f-a76b-c18848a9a784@gmail.com>

Hello,

Thank you for your detailed feedback regarding the f2fs.rst issue.

I have tested the current mainline (without my patch) using
Sphinx 8.3.0+ (commit ab8303f4bb13) and Docutils 0.21.2
on Python 3.13.7.

The pdfdocs build now completes successfully, and the nested
tables in f2fs.rst no longer cause any LaTeX errors.

It seems that the problem has been resolved in the upcoming
Sphinx 8.3 release, as you mentioned.

Thanks again for your kind guidance.

Best regards,  
Masaharu Noguchi

