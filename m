Return-Path: <linux-kernel+bounces-847255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BD1BCA5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D03C640C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95289242D8B;
	Thu,  9 Oct 2025 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="uv3GpQf7"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603102405EC
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030519; cv=none; b=r5Z0heC+VA6C8+9RZN0yLpxEIbtq2uRzmkJVMgKibWVTCD205MECuhXZamV0R6R2G5pT0tGydMkUenh6fpI3ajTu3ZYDY+n69MKBxLxWNJi3/4U17upyTeHlwAQ8HPED6Xct9hCZcIDAKwnM5kdTmyq6pujC12hga8LZ+PFUaL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030519; c=relaxed/simple;
	bh=VQJJ0kkdsoKilAETyLjjnmPlpywwYhmhfiCz5TnYPTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9kmYHgPFbC1H3m3z+IVvFHvwHKZQ4MHJT4XnnZZKiD7FCS/80YdNFXCHlyK7tywXOF0AYFcmAv1y/QyFXAta0N+GdXyli5FBnBp2uQTDwUaXl4XwI40Ak9bHbmp3Js+7zoERcZiGOqPOFMP7HKHSR0j5ugENV+BKtk65DEHgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=uv3GpQf7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so812746f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760030516; x=1760635316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+KLFKFTWpPvFnQc5/YBzjsvsC5/CidNVj2ClsuS6MQ=;
        b=uv3GpQf7E/vDeTz9FLxH1pauaLYsJemYzB6731uJSXpbjVHeTvKvX4tygAOWkI7wJG
         BdgeaDZDjeK4Zewz6oHUZerIvkZ0++bfYSpekkS1EVORWyMUwvBhYIvBaeDkLqq5/EaK
         qZPyNKt3gpPYn3wnco2eUZ2SN5KFZ6/T2bJKQWXNVdTejTjxTSPxTjGROgPZTlcbpkEm
         0Ydsp4ScEgLTgFUkIwGuylAPD1BP2XiJRM2UEGt25jfqwM8/MaQ2YO3fpQOLqt0xdc6o
         Pgtq0a3VKLmPmj71IlYHkfMd+4CxNsw6iQi63q9JlRODbNiUvz4LeQY216GLI9NIudYD
         eccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030516; x=1760635316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+KLFKFTWpPvFnQc5/YBzjsvsC5/CidNVj2ClsuS6MQ=;
        b=lIBG0bTAkz0YVTk9X6MQlvItcb+vDUYunFSLKRgwm4K0nz49LCuymUdGuPGyo4joME
         e2Yd8Bgu8fe9E5kA4FSQ13t0fBM64ISoXvOysIkxLZBUQMMqlkSPTLkYwYNmtk3ulwu9
         qd0FarwVXYowar9bk4kBTAk4mcV/dZCVAhrgMM4uSKqd5Tu2PKKuXxDPfEr6svBY6jKW
         kc8/CnOKoYASq6sJi5PjuRyIbmemYj8sUhXYJye6p3P48oO0unihzBDv/TZAlSGJI+8x
         D2qhR9sB4TKJAKB6B87FWfJkD+e3A+jaqa/9gPOjxSRlFxbPZwwhlSiWZk9TrtzsnhzI
         aTig==
X-Forwarded-Encrypted: i=1; AJvYcCXPnnVkrNWM3oGTwP9if8J4oKPAqpQ67wrbuB1AMwGyvVp+wdijxG6std4DFVZGsy0/YjMqw4+nudqTzP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwntNR8VdR2bNaLsjeTuHpg8k9yvDYJfsYHpNI8DHYtLxq0kQPS
	V1RuqC60mHuB4XNSuK+V+mVIBjHnE5RzcJ1+reEsQs9HdRCQmSku3kQzYsEZ5f9fIec=
X-Gm-Gg: ASbGncsf/SKD1D1KHP/Yh4+jYhrWRw4wp6TcKVrGBq4UuE6rzhvads+N3d/NwnFxIY5
	xrDTtc6guTytvoQQQ0HlV/uGFnM3UmUxxSl/3MCpaH2UIYPHngzMP9gdjPsmUSgx46Vt1p/iICY
	WIakl/vy0pEFVKIsadn9rNrZTc0T59f2Hr5Ref4+S4dUbDglBYYTcyDA6dupKy+Lt+gTImN5EWh
	RSCZqVehBNYzhM3ZH5sWB9BjK3RyXrcNUvh/i4EsD4RiIEBXODBoYsjKUC3IEQuNu5MQjhdSIvb
	zh3XYD9RZLG/bis6F/sv8coMeYJuJhUEH6yUr2xpgd+fROrqLb16kWYUxXV47BN5SE2fu/s2Jyb
	8bWmoN8WdDgIiWFKx78HhRmrpfSF1Flzm8XgW5HyJSA==
X-Google-Smtp-Source: AGHT+IFvtBt4VPloj/uWDHxR+fLdN49T1BIdUNfkKzHmKlSqCdUXz5aRdqggP7xZyjd/f8BtBox2sQ==
X-Received: by 2002:a05:6000:1863:b0:3e6:116a:8fdf with SMTP id ffacd0b85a97d-42666ab969fmr5606797f8f.13.1760030515562;
        Thu, 09 Oct 2025 10:21:55 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce50d70esm87352f8f.0.2025.10.09.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:21:54 -0700 (PDT)
Date: Thu, 9 Oct 2025 18:21:53 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Jan Kara <jack@suse.cz>
Cc: adilger.kernel@dilger.ca, kernel-team@cloudflare.com,
	libaokun1@huawei.com, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tytso@mit.edu, willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <20251009172153.kx72mao26tc7v2yu@matt-Precision-5490>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
 <20251009101748.529277-1-matt@readmodwrite.com>
 <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>

On Thu, Oct 09, 2025 at 02:29:07PM +0200, Jan Kara wrote:
> 
> OK, so even if we reduce the somewhat pointless CPU load in the allocator
> you aren't going to see substantial increase in your writeback throughput.
> Reducing the CPU load is obviously a worthy goal but I'm not sure if that's
> your motivation or something else that I'm missing :).
 
I'm not following. If you reduce the time it takes to allocate blocks
during writeback, why will that not improve writeback throughput?

Thanks,
Matt

