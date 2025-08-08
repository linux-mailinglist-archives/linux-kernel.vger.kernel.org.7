Return-Path: <linux-kernel+bounces-760392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A3B1EA9A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 16:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB37B3BBDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39711280033;
	Fri,  8 Aug 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="B1zFbNK7"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9D4A32
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664491; cv=none; b=PuxLFMM1CMg2mma7OhgGUX6yMcK15A2kd8QjPZOOWqQecHl+6Fw6mEpQypkZF9MxbXZDdt3Bhhn/I0/DAwSYwWZWM7Lcd+Oxt2gnu56awcmvgUKySQsiO1JTofAgA/3TRClPYjc12l7GjPCdfadSYyvuIVm/ahZ4AfCzSk8Fbn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664491; c=relaxed/simple;
	bh=nTRO0iZtKB5n0+iTP7q3ABoqUJLeXsGT2augMV+mXUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N4jOpQkbHxekzuiC18NCkYiiHHr4tquDqOcBZHCwVbvD5SOJi0s9mmU1/Ag+T1+nzLbolazA9zOgSJAI5AKJ335W3douhs2yF9d2ITJw7uZOincNy08Uf5J1BkTHLtVfZbmlZv6ALid/BvdxjlMRaWY4Ivbv4SgA4n1Wu0OuFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=B1zFbNK7; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2e95ab2704fso1878217fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1754664489; x=1755269289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewzjsdpoAykHhEBFgJ/UB1pQfM2cO3t1vQCCzVyKC6Q=;
        b=B1zFbNK7E8JWTQk8T1qafzqsxsIlAmOB70RW8uPmVa4Ml9NE0ALG/mGtr2t1PfiwwL
         0cDzZcqcKjJTHaxjqR6eUi5imOqvCz9BT2UG7e88Z/UelXwmhhzVmc0ZPLpBWsDlvQP5
         ju8nWtZZf5IbjW+tDoqhi1lLk/2WbZmsn6Y8o+Ub45XYIn0mu8JiWcQK6mJ75pZ3KnA5
         vh+b6F9UjjR82O4FrUhjS8zV+VX8zraOyCqBDrVsr4vxiG0pQ7ks1vLgTRnbbyvfL01j
         8yG+9sPa+/zQ+WtRAx2mrrsJVxIYg1GwN5e/NFNvX7rvMeqo4vY8LIfED7xfzNyxDqGY
         kyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664489; x=1755269289;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewzjsdpoAykHhEBFgJ/UB1pQfM2cO3t1vQCCzVyKC6Q=;
        b=D1y7GR+MgKJ1WAZ5k6SLR4ClbjP6NDg7dmwwzx/wwPWzOBNlHCJ5UQ5gyo1E4B0qjs
         mJxPXxj9i/NEwammHH0K/ktUvwB/G1LvC9rOS2x9/O6xfTfik9oJFAxAV1Ctu9wy6aa2
         naJaUHI5DlmqyLg0mW8EM8eq8iO+nGiaCxHvUGFFndOD0aflzOfLoeBwvWGc/YOLfK54
         n2V0vCY2xp3xFil3dI+RG+7ywLqPEry3VHTAVK5Q/iUOntPcZaBtUwdYfrCPYzmP76SO
         DpBuzYtnSkMApgzU9E7goTIIKkSf+HzHUBph2U6XcVQzVh3Oupfioh3j6lPn9sFEZvdZ
         +QRA==
X-Forwarded-Encrypted: i=1; AJvYcCVHyH1mb67IK1y4YyoUeij+1brf7vZaxGF1UEKnMCEEQfVStG1BzoDW+QLa1KQcCAxrPIj4C6bofkyD6ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbYO3wCqokkAvOl5H0SWG58Vs8ocjL9/go4VWoh4+zbggD7TH
	CRNAhxqx7e2Cl2ds8P/aRwzGYFPFHP9+dx/gbb4sXZuIyanMaYT6rzQrhb25v/UMjaE=
X-Gm-Gg: ASbGncu7y9rpvtM2ZOWJeELUtK5XxcUHevUvmaM2nny9oMmvFVWQazLWbPmd+rTYUA+
	zX118Kw4dM4K3tVbR5aKgQb9ScSn+vNdvoLOnZbDcW/CXv6Bx9WgMINPYw3fWLYKoAfeRCgi0y0
	rsA4PEFJB7JJSLrmPiW4ZhCto5QMQVosxnQrD2vYqWVi3NnIdiNLvn0tJarqSArzKpy09gTzTLt
	92wzi9mMJTpoPjhz6I57mIKyQSnd+O7NCdMkVj/FKXPkDZk/Uw2WsfAojORYhtPyOogfS8Enl/q
	hPmOz2Ilo8pY5dkrLpb8DpGlAzhpYp7IC2FVN0oRLgYqk92ZyBW5CKgcvfVi0o0dxnAiyFt8QFz
	q/lbRsCw4Bk5oFC6GYJ4TOaYxachzD7X5BCkf
X-Google-Smtp-Source: AGHT+IG4hCE+IdcT7gDI6Y/FY4GnDriutfuUfIR5SNfXBdFrj25/eWOpBz8eI1y/JTwOMLKAIgdhrw==
X-Received: by 2002:a05:6870:e311:b0:2ff:8ee5:d1f7 with SMTP id 586e51a60fabf-30c21080f92mr1906932fac.1.1754664489207;
        Fri, 08 Aug 2025 07:48:09 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:e698:accb:897b:ca29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30c3a9d052asm123722fac.14.2025.08.08.07.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:48:08 -0700 (PDT)
Date: Fri, 8 Aug 2025 09:48:03 -0500
From: Corey Minyard <corey@minyard.net>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	openipmi-developer@lists.sourceforge.net,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing
 "clocks" property
Message-ID: <aJYOI8BzUSeMiuJm@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250807132852.3291305-1-robh@kernel.org>
 <a14b98078554e27453fc1f96a667b299a15fd4c2.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a14b98078554e27453fc1f96a667b299a15fd4c2.camel@codeconstruct.com.au>

On Fri, Aug 08, 2025 at 11:17:29AM +0930, Andrew Jeffery wrote:
> On Thu, 2025-08-07 at 08:28 -0500, Rob Herring (Arm) wrote:
> > The ASpeed kcs-bmc nodes have a "clocks" property which isn't
> > documented. It looks like all the LPC child devices have the same clock
> > source and some of the drivers manage their clock. Perhaps it is the
> > parent device that should have the clock, but it's too late for that.
> > 
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> Thanks Rob.
> 
> Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Queued for 4.18, I'll add it to the next tree when 4.17-rc1 releases.

Thanks,

-corey

