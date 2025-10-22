Return-Path: <linux-kernel+bounces-865845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE63BFE298
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCEB188FAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F5F2741DA;
	Wed, 22 Oct 2025 20:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/fH0Rcx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB92F549F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164775; cv=none; b=Jb2tVjjeYL6NlAuRm5Jvs0Xy8cYbNbhfNZseZP34NVEWR5+s/w2iXcAoe5l6l7f3IjFSxdPCYXI6+sZJThIIMUUBi4x+77cUe3lxGFV3txdwvJ4gy2ZUD4MiO8e9PpmMynqzpwyKQrrv0dAtaLLtKOEgoqyRW62M9k4Jc8VvHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164775; c=relaxed/simple;
	bh=UsE2MC6YhiU2H2YxopFmG19GYWLjhkDN5teQLVlPj+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RemAUIHF601Ghp170ymjh+YxRjEJtxScQkuN47r2OxkRPr/6Uc2f2yvOYpr9y/6+tuqTViW8VGz4uHGd0MqDNPLlHaMZxwjD+gHG6e8QCo9+OL+TN68P4i+ImmUNfRyrB3RoK85EcfJdX3hJM/tV7NV5dMcLCeomnKrRkZ2EO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/fH0Rcx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7835321bc98so41540b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761164773; x=1761769573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T8eeYBeVEIY6XvODE4oNhMEO0a9ohRRG70mMGclTsoo=;
        b=g/fH0RcxhIMeRv9EGpLbgcfa05Fayz2AZmPaBVyQg2saHaNZYqpxwFun3keFTcw5hh
         eywukNJRTLJq8AUudtUSxxd3DNZN9ilnnt1h2w9cssVzkRnc7xn7gKnXrrplkyLTXbUL
         WGewi5g0x75zHFLZKKLYnFy5TWxg2As4mFHzEgrlC/5gM915Rv0n4R0v1vJOqqeN69+r
         kj353/s4I/5qXqHSdCOW9mvwuWwlIboWc89xfq5v2qHsKMuLxktCWqVY7qtOWdQdI2if
         KVRar/oCGYEnnFK/go6eEwBAkyPkRZ9s5JjcTxgxS131qqA86Ng+mUUAS4/BmtwL6GMC
         JZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761164773; x=1761769573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8eeYBeVEIY6XvODE4oNhMEO0a9ohRRG70mMGclTsoo=;
        b=EV6qEdinXmr1/fShMSr2QVbWQNHKTWCPyh+TNpRSf157BaIhwxGPCdXKAjfMx88kvv
         uHj7hlSxiYzdPQ0eTrXhdaNzmopFSra/sRW1ZfPnz5HgNfvSjBkmU8FNERaIiQrg5lE8
         mMTRTJjETBlftw8hxL8zVcHamKsNjdB7eWzfgNgtliOTOx6oyORc3otfpPr9judQJMG0
         yLkLnB6dUza2fjaoM4aK4Xaeug++U6b6mzqw/4vn6LJgB/AftMX02Vp4Bfcw/FRpQThB
         tzawpZBYgrgpWqIt1KXl9oSTMui7phXFwdWWlpPT+eTdLqF10bXD+fscK71lSYDD8DoJ
         NvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrHH5HdaX5DnujUxMymHFLYxuTtXCW71LkXqrqgeoqeBaAOFQ9CKGymY5g28A3Qnd+Kx/eLLAonpptPeU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh1Huc17+9IjNo5npjVzeyE84HFcEGxuyK9qWRVSNbc/qxPQFJ
	QGWkH61JCK+NY5bMCyR34rgsQEHLATxpmVsHz1T+ilemfIVk6ZXdkn8w4OmJ3Q==
X-Gm-Gg: ASbGncucOSZfO4W1FzIZGFaEB+kb7xDL2FdTtMAAjGfYwzwlSIciTN5YNir0fhdYafS
	7TRYTjW+K3Zp4JEYjZFlWpwSggEX4Fz7GGFlqMLkXfjxVZWBmAbFNYEu4ad166LHQVn1vXoBkYI
	CzgSbshenfGUCy82R9ZdUpW68mvzJfXfxx4LvXQFTTCC5NffqZ7AohRBD1yT+pfuw2Ou/SDZ3j0
	yfdCoQyeOcgM/D4sl0d0g6+fCw5HjweFLD98iU8qfEvRhgpvts9TbJ3dx4WJ9l53g8viRtyvFP2
	+RpXbresIF/J2SsG6KuFmEsSM05wXs37Lg0xntoYDON+mbDIgtzv8bGxDt3E/HdgOr6outjVr+i
	bKEP2/g9ExDeoGMfYeKdUmiqFdQpwQ0EYyKRmMzyTtAjWnkvE6Jc6q9k8BjL9BMWO1dlx74mjlf
	kpteokMFdDh1G0SJgT5pRnM536cnA4+90bPEQk9ptJmBE/3FsDaA==
X-Google-Smtp-Source: AGHT+IFDRCcByl//79aXbsGB2yKo3kBq184UaG8KGH4X6om7TJOgKw+yz9TH2hch3mYKqlgj9G617w==
X-Received: by 2002:a05:6a20:72a3:b0:331:e662:c973 with SMTP id adf61e73a8af0-334a8607001mr29327304637.32.1761164773019;
        Wed, 22 Oct 2025 13:26:13 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:53a9:459c:bdc:6273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a619d5sm123324b3a.1.2025.10.22.13.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:26:12 -0700 (PDT)
Date: Wed, 22 Oct 2025 13:26:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v4 1/2] dt-bindings: touchscreen: trivial-touch: add
 reset-gpios and wakeup-source
Message-ID: <dp2qoiiigb3zv3w2osyloiugasgypbgj6lcnikcekqpq2vb7wz@q5qpzmlfei2i>
References: <20251021201924.2881098-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021201924.2881098-1-Frank.Li@nxp.com>

On Tue, Oct 21, 2025 at 04:19:17PM -0400, Frank Li wrote:
> Add optional reset-gpios and wakeup-source properties.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thank you.

-- 
Dmitry

